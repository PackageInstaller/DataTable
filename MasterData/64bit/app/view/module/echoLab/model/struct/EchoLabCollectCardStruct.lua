local var_0_0 = g.core.common.Path
local EchoLabCollectCardStruct = class("EchoLabCollectCardStruct")

function EchoLabCollectCardStruct:ctor(arg_1_1, arg_1_2)
	self._advanceId = arg_1_1.advance_id
	self._curGrade = 0
	self._cfgList = nil
	self._cfg = nil
	self._isActive = false
	self._targetTabName = nil
	self._attrInfoList = {}
	self._attrInfoDict = {}
	self._posInfo = {
		pos = -1
	}

	self:_initCfgList(arg_1_2)
end

function EchoLabCollectCardStruct:_initCfgList(arg_2_1)
	self._cfgList = arg_2_1

	table.sort(self._cfgList, function(arg_3_0, arg_3_1)
		return arg_3_0.grade_show < arg_3_1.grade_show
	end)

	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(self._cfgList) do
		local var_2_2 = 1

		while g.core.config.palace_compose_info.hasKey("affect_type_" .. 1) do
			if iter_2_1["affect_type_" .. 1] ~= 0 then
				local var_2_3 = var_2_1[iter_2_1["affect_type_" .. 1]]

				if not var_2_1[iter_2_1["affect_type_" .. 1]] then
					var_2_3 = 0
					var_2_0[#var_2_0 + 1] = iter_2_1["affect_type_" .. 1]
				end

				var_2_1[iter_2_1["affect_type_" .. 1]] = var_2_3 + iter_2_1["affect_value_" .. var_2_2]
			end

			var_2_2 = var_2_2 + 1
		end

		local var_2_5 = {
			list = {},
			dict = {}
		}

		for iter_2_2, iter_2_3 in ipairs(var_2_0) do
			table.insert(var_2_5.list, {
				type = iter_2_3,
				value = var_2_1[iter_2_3]
			})

			var_2_5.dict[iter_2_3] = var_2_1[iter_2_3]
		end

		self._attrInfoList[iter_2_0] = var_2_5
	end

	self._cfg = self._cfgList[self._curGrade + 1]

	self:_initTargetTabName()
end

function EchoLabCollectCardStruct:_initTargetTabName()
	self._targetTabName = "knight_info"

	if self._cfg.cards_type == g.core.common.Goods.TYPE_KNIGHT then
		self._targetTabName = "knight_info"
	elseif self._cfg.cards_type == g.core.common.Goods.TYPE_SKIN then
		self._targetTabName = "skin_info"
	elseif self._cfg.cards_type == g.core.common.Goods.TYPE_ARTIFACT then
		self._targetTabName = "artifact_info"
	elseif self._cfg.cards_type == g.core.common.Goods.TYPE_PET then
		self._targetTabName = "pet_info"
	elseif self._cfg.cards_type == g.core.common.Goods.TYPE_UNITETOKEN then
		self._targetTabName = "unite_token_info"
	end
end

function EchoLabCollectCardStruct:isPut()
	local var_5_0 = self:getTargetTabCfg()

	for iter_5_0, iter_5_1 in pairs(require("app.view.module.home.const.HomeConst").GM_UNPUT_INFO_LIST) do
		if iter_5_0 == self._targetTabName then
			for iter_5_2, iter_5_3 in pairs(iter_5_1) do
				if var_5_0[iter_5_2] == 0 then
					if self:_checkIsSkinPut() then
						return true
					end

					return false
				end
			end

			break
		end
	end

	return true
end

function EchoLabCollectCardStruct:_checkIsSkinPut()
	local var_6_0 = false

	if self._cfg.cards_type == g.core.common.Goods.TYPE_SKIN then
		if g.core.model.User.skinData:getActivitySkinById(self._advanceId) and g.core.model.User.skinData:isActivitySkinInShowTime(self._advanceId) or g.core.model.User.skinData:getSkinState(self._advanceId) == 1 then
			var_6_0 = true
		end
	end

	return var_6_0
end

function EchoLabCollectCardStruct:getAdvanceId()
	return self._advanceId
end

function EchoLabCollectCardStruct:setCurGradeById(arg_8_1)
	self:setCurGrade(g.core.config.palace_compose_info.get(arg_8_1).grade_show)
end

function EchoLabCollectCardStruct:setCurGradeByCardId(arg_9_1)
	local var_9_0

	for iter_9_0, iter_9_1 in ipairs(self._cfgList) do
		if iter_9_1.cards_id == arg_9_1 then
			var_9_0 = iter_9_1

			break
		end
	end

	assert(var_9_0 ~= nil, string.format("configName(%s), advanceId is %s, cardId is %s,it can not find in palace_compose_info", self._targetTabName, tostring(self._advanceId), tostring(arg_9_1)))
	self:setCurGrade(var_9_0.grade_show)
end

function EchoLabCollectCardStruct:setCurGrade(arg_10_1)
	self._curGrade = arg_10_1
	self._cfg = self._cfgList[self._curGrade + 1]
end

function EchoLabCollectCardStruct:getCurGrade()
	return (self._isActive or nil) and self._curGrade
end

function EchoLabCollectCardStruct:setOneKeyBeforeGrade(arg_12_1)
	self._beforeGrade = arg_12_1 or 0
end

function EchoLabCollectCardStruct:getOneKeyBeforeGrade()
	return self._beforeGrade
end

function EchoLabCollectCardStruct:getAllIdList()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(self._cfgList) do
		var_14_0[iter_14_0] = iter_14_1.id
	end

	return var_14_0
end

function EchoLabCollectCardStruct:getCfg(arg_15_1)
	arg_15_1 = arg_15_1 or self._curGrade

	return self._cfgList[arg_15_1 + 1]
end

function EchoLabCollectCardStruct:getTargetTab()
	return g.core.config[self._targetTabName]
end

function EchoLabCollectCardStruct:getTargetTabCfg()
	return (self:getTargetTab().get(self._advanceId))
end

function EchoLabCollectCardStruct:getCardName()
	local var_18_0 = self:getTargetTabCfg()

	return (self._curGrade > 0 or nil) and g.core.lang:get(408517, {
		name = var_18_0.name,
		grade = self._curGrade
	})
end

function EchoLabCollectCardStruct:getCardQuality(arg_19_1)
	return self:getTargetTabCfg().quality + (arg_19_1 and 0 or 1)
end

function EchoLabCollectCardStruct:getAttrInfo(arg_20_1)
	arg_20_1 = arg_20_1 or self._curGrade

	return self._attrInfoList[arg_20_1 + 1]
end

function EchoLabCollectCardStruct:getLineUpAttrInfo()
	return {
		type = self._cfg.suppress_type,
		value = self._cfg.suppress_value
	}
end

function EchoLabCollectCardStruct:getReward()
	return {
		type = self._curCfg.reward_type,
		value = self._curCfg.reward_value,
		size = self._curCfg.reward_size
	}
end

function EchoLabCollectCardStruct:getAddExp()
	return self._cfg.exp_add
end

function EchoLabCollectCardStruct:getCardType()
	return self._cfg.cards_type
end

function EchoLabCollectCardStruct:getId()
	return self._cfg.id
end

function EchoLabCollectCardStruct:getStar()
	return self:getTargetTab().get(self._cfg.cards_id).star or 0
end

function EchoLabCollectCardStruct:getRealStar()
	if self._cfg.cards_type == g.core.common.Goods.TYPE_KNIGHT then
		return g.core.model.User.knightsData:getKnight({
			advance_id = self._cfg.advance_id
		}):getStarLv()
	elseif self._cfg.cards_type == g.core.common.Goods.TYPE_SKIN then
		return 0
	elseif self._cfg.cards_type == g.core.common.Goods.TYPE_ARTIFACT then
		return g.core.model.User.artifactData:getArtifactByAdvId(self._cfg.advance_id):getStar()
	elseif self._cfg.cards_type == g.core.common.Goods.TYPE_PET then
		return g.core.model.User.petsData:getPetByAdvanceId(self._cfg.advance_id):getStarNum()
	elseif self._cfg.cards_type == g.core.common.Goods.TYPE_UNITETOKEN then
		return g.core.model.User.uniteTokenData:getTokenByAdvId(self._cfg.advance_id):getStarLevel()
	end

	return 0
end

function EchoLabCollectCardStruct:getTargetResId()
	local var_28_0 = self:getTargetTabCfg()

	return self._cfg.cards_type == g.core.common.Goods.TYPE_PET and var_28_0.resource or self._cfg.cards_type == g.core.common.Goods.TYPE_SKIN and var_28_0.res_2 or var_28_0.res_id
end

function EchoLabCollectCardStruct:getTargetPicURL()
	local var_29_0 = self:getTargetResId()

	return (self._cfg.cards_type == g.core.common.Goods.TYPE_KNIGHT or self._cfg.cards_type == g.core.common.Goods.TYPE_SKIN) and g.core.common.Path:getMiddleKnightPicById(var_29_0) or self._cfg.cards_type == g.core.common.Goods.TYPE_PET and g.core.common.Path:getPetMiddle(var_29_0) or g.core.common.Path:getPicRes(self._cfg.cards_type, var_29_0)
end

function EchoLabCollectCardStruct:getPicResUrl(arg_30_1)
	local var_30_0 = ""
	local var_30_1 = self:getTargetResId()

	if self._cfg.cards_type == g.core.common.Goods.TYPE_KNIGHT or self._cfg.cards_type == g.core.common.Goods.TYPE_SKIN then
		var_30_0 = var_0_0:getKnightBookPicRes(var_30_1)
	elseif self._cfg.cards_type == g.core.common.Goods.TYPE_ARTIFACT then
		var_30_0 = var_0_0:getArtifactRebornImg(var_30_1)
	elseif self._cfg.cards_type == g.core.common.Goods.TYPE_PET then
		var_30_0 = var_0_0:getPetPictorialBook(var_30_1)
	elseif self._cfg.cards_type == g.core.common.Goods.TYPE_UNITETOKEN then
		var_30_0 = var_0_0:getUniteTokenCardImg(var_30_1)

		if arg_30_1 then
			var_30_0 = var_0_0:getUniteTokenSkillMidPicById(var_30_1)
		end
	end

	return var_30_0
end

function EchoLabCollectCardStruct:getTargetStruct()
	return self._cfg.cards_type == g.core.common.Goods.TYPE_PET and g.core.model.User.petsData:getPetByAdvanceId(self._advanceId) or self._cfg.cards_type == g.core.common.Goods.TYPE_ARTIFACT and g.core.model.User.artifactData:getArtifactByAdvacnceId(self._advanceId) or self._cfg.cards_type == g.core.common.Goods.TYPE_UNITETOKEN and g.core.model.User.uniteTokenData:getTokenByAdvId(self._advanceId) or g.core.model.User.knightsData:getKnightByAdvanceId(self._advanceId)
end

function EchoLabCollectCardStruct:canActive()
	local var_32_0 = false

	if self._cfg.cards_type == g.core.common.Goods.TYPE_SKIN then
		var_32_0 = g.core.model.User.skinData:getSkinState(self._advanceId) == 1
	else
		local var_32_1 = self:getTargetStruct()

		if var_32_1 then
			var_32_0 = var_32_1:isOwn()
		end
	end

	return var_32_0 and not self._isActive
end

function EchoLabCollectCardStruct:onActive()
	self._isActive = true
end

function EchoLabCollectCardStruct:isActive()
	return self._isActive
end

function EchoLabCollectCardStruct:getUpgradeInfo()
	local var_35_1 = self:getTargetTab().get((self._cfg.cards_id_next == 0 or nil) and self._cfg.cards_id).star
	local var_35_3 = 0

	var_35_3 = self._cfg.cards_type == g.core.common.Goods.TYPE_PET and g.core.model.User.petsData:getPetByAdvanceId(self._advanceId):getStarNum() or self._cfg.cards_type == g.core.common.Goods.TYPE_ARTIFACT and g.core.model.User.artifactData:getArtifactByAdvacnceId(self._advanceId):getStar() or self._cfg.cards_type == g.core.common.Goods.TYPE_UNITETOKEN and g.core.model.User.uniteTokenData:getTokenByAdvId(self._advanceId):getStarLevel() or g.core.model.User.knightsData:getKnightByAdvanceId(self._advanceId):getStarLv()

	return {
		cur = var_35_3,
		target = var_35_1
	}
end

function EchoLabCollectCardStruct:isMaxGrade()
	return self._isActive and self._curGrade == #self._cfgList - 1
end

function EchoLabCollectCardStruct:canUpgrade()
	local var_37_0

	if self._cfg.cards_id_next ~= 0 then
		var_37_0 = self:getUpgradeInfo()
	end

	return self._isActive and not not (var_37_0 and var_37_0.cur >= var_37_0.target) and not self:isMaxGrade()
end

function EchoLabCollectCardStruct:setPos(arg_38_1)
	self._posInfo.pos = arg_38_1
end

function EchoLabCollectCardStruct:getPos()
	return self._posInfo.pos
end

function EchoLabCollectCardStruct:isLineUp()
	return self._posInfo.pos ~= -1
end

return EchoLabCollectCardStruct

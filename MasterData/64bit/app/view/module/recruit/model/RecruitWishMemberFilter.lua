local var_0_0 = g.core.const.ConstMgr.RecruitConst
local RecruitWishMemberStruct = require("app.view.module.recruit.model.RecruitWishMemberStruct")
local RecruitWishMemberFilter = class("RecruitWishMemberFilter")

function RecruitWishMemberFilter:ctor()
	self._roundRecruitDic = {}
end

function RecruitWishMemberFilter:getAndFilterWishMembersByRecruitType(arg_2_1, arg_2_2)
	local var_2_0 = {}

	if var_0_0.RECRUIT_TYPE.PREMIUM == arg_2_1 then
		var_2_0 = self:getAllWishKnightByRecruitType()
	elseif var_0_0.RECRUIT_TYPE.ARTIFACT_BASE == arg_2_1 then
		var_2_0 = self:getAllWishArtifactById(arg_2_2)
	elseif var_0_0.RECRUIT_TYPE.KNIGHT_SOUL_RECRUIT == arg_2_1 then
		var_2_0 = self:getKnightSoulListByRecruitCfg((g.core.model.User.recruitData:getRecruitCfgByIdOrActId(arg_2_2)))
	elseif var_0_0.RECRUIT_TYPE.LIMIT_KNIGHT_SOUL_RECRUIT == arg_2_1 then
		var_2_0 = self:getKnightSoulListByRecruitCfg(g.core.model.User.recruitData:getRecruitCfgByIdOrActId(arg_2_2, true), arg_2_2)
	elseif var_0_0.RECRUIT_TYPE.PRIMARY_LIMIT == arg_2_1 or var_0_0.RECRUIT_TYPE.RECRUIT_RETURN_KNIGHT == arg_2_1 or var_0_0.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT == arg_2_1 then
		var_2_0 = self:getWishKnightByPackKeyListAndType(g.core.config.recruit_knight_wish_rule_info.get(g.core.model.User.recruitData:getRecruitCfgByIdOrActId(arg_2_2).wish_rule_id).pool, arg_2_1, arg_2_2)
	elseif var_0_0.RECRUIT_TYPE.RECRUIT_KNIGHT_SPRING == arg_2_1 then
		var_2_0 = self:getWishKnightByPackKeyListAndType(g.core.config.recruit_knight_wish_rule_info.get(g.core.model.User.recruitData:getSpringCfgByIdOrActId(arg_2_2).wish_rule_id).pool, arg_2_1, arg_2_2)
	elseif var_0_0.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT == arg_2_1 or var_0_0.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT == arg_2_1 then
		var_2_0 = self:getWishKnightByPackKeyListAndType(g.core.config.recruit_knight_wish_rule_info.get(g.core.model.User.recruitData:getRecruitCfgByIdOrActId(arg_2_2).wish_rule_id).pool, arg_2_1, arg_2_2, g.core.common.Goods.TYPE_ARTIFACT)
	end

	return var_2_0
end

function RecruitWishMemberFilter:getAllWishKnightByRecruitType()
	local var_3_0 = {}
	local var_3_1 = g.core.model.User.recruitData:getRecruitKnightCfg(var_0_0.RECRUIT_TYPE.PREMIUM)
	local var_3_2 = var_3_1 and g.core.config.recruit_knight_wish_rule_info.get(var_3_1.wish_rule_id)

	for iter_3_0, iter_3_1 in ipairs((g.core.model.User.knightsData:getAllLineupAvailList(0))) do
		local var_3_3 = iter_3_1:getBaseInfo()

		if var_3_3.wish_show > 0 then
			local var_3_4 = true

			if var_3_2 and var_3_2.is_have_element_leader > 0 and var_3_3.is_element_leader and var_3_3.is_element_leader > 0 then
				local var_3_5 = g.core.model.User.knightsData:getKnight({
					advance_id = var_3_3.advance_id
				})

				if (var_3_5 and var_3_5:getStarLv() or 0) < var_3_2.element_leader_star then
					var_3_4 = false
				end
			end

			if var_3_4 then
				table.insert(var_3_0, (self:_createMemberStruct(g.core.common.Goods.TYPE_KNIGHT, iter_3_1:getBaseInfo(), iter_3_1, {
					isLimit = var_3_3.wish_show == 2
				})))
			end
		end
	end

	return var_3_0
end

function RecruitWishMemberFilter:getWishKnightByPackKeyListAndType(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = g.core.model.User.recruitData:getRecruitKnightCfg(arg_4_2)

	if arg_4_3 then
		var_4_0 = g.core.model.User.recruitData:getRecruitKnightCfgById(arg_4_3) or g.core.model.User.recruitData:getRecruitCfgByIdOrActId(arg_4_3)
	end

	arg_4_4 = arg_4_4 or g.core.common.Goods.TYPE_KNIGHT

	local var_4_1 = {}

	if arg_4_1 ~= 0 then
		g.core.model.User.recruitData:getDropKnights(arg_4_1, var_4_1, arg_4_2 == var_0_0.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT or arg_4_2 == var_0_0.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT)
	end

	local var_4_2 = {}
	local var_4_3

	if g.core.common.Goods.TYPE_KNIGHT == arg_4_4 then
		var_4_3 = g.core.config.knight_info
	elseif g.core.common.Goods.TYPE_ARTIFACT == arg_4_4 then
		var_4_3 = g.core.config.artifact_info
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		local var_4_4 = var_4_3.get(iter_4_1.value)

		if var_4_4.wish_show > 0 then
			local var_4_5 = g.core.config.recruit_knight_wish_rule_info.get(var_4_0.wish_rule_id)
			local var_4_6 = true

			if var_4_5.is_have_element_leader > 0 and var_4_4.is_element_leader and var_4_4.is_element_leader > 0 then
				local var_4_7 = g.core.model.User.knightsData:getKnight({
					advance_id = var_4_4.advance_id
				})

				if (var_4_7 and var_4_7:getStarLv() or 0) < var_4_5.element_leader_star then
					var_4_6 = false
				end
			end

			if var_4_6 then
				local var_4_8 = {
					isLimit = var_4_4.wish_show == 2,
					maxNum = g.core.config.parameter_info.get(15047).parameter
				}

				if var_4_5.reset_num > 0 then
					var_4_8.maxNum = var_4_5.reset_num
				end

				local var_4_9
				local var_4_10

				if g.core.common.Goods.TYPE_ARTIFACT == arg_4_4 then
					var_4_9 = g.core.model.User.artifactData:getArtifactByAdvacnceId(var_4_4.advance_code)
					var_4_10 = var_4_2
				end

				table.insert(var_4_2, (self:_createMemberStruct(arg_4_4, var_4_4, var_4_9, var_4_8)))
			end
		end
	end

	return var_4_2
end

function RecruitWishMemberFilter:getAllWishArtifactById(arg_5_1)
	self:_initRoundRecruitDic()

	local var_5_0 = {}
	local var_5_1 = {}
	local var_5_2 = {}

	for iter_5_0, iter_5_1 in pairs((g.core.model.User.recruitData:getWishInfo(var_0_0.RECRUIT_TYPE.ARTIFACT_BASE))) do
		var_5_2[iter_5_1.r_type .. "_" .. iter_5_1.r_value] = {
			pos = iter_5_1.pos,
			state = iter_5_1.status,
			placeHolders = self._wishInfos
		}
	end

	for iter_5_2 = 1, g.core.config.artifact_info:getLength() do
		local var_5_3 = g.core.config.artifact_info.indexOf(iter_5_2)

		if not var_5_1[var_5_3.advance_code] and var_5_3.put == 1 and var_5_3.if_try == 0 and self:getArtifactOpenState(var_5_3.advance_code) < 4 then
			local var_5_4 = self:_createMemberStruct(g.core.common.Goods.TYPE_ARTIFACT, var_5_3, g.core.model.User.artifactData:getArtifactByAdvacnceId(var_5_3.advance_code), {
				isLimit = var_5_3.gm_open == 1
			})

			var_5_4:setExtUp(30)

			local var_5_5 = var_5_2[var_5_4:getType() .. "_" .. var_5_4:getId()]

			if var_5_5 then
				var_5_4:updateStructNetInfo(var_5_5)
			end

			table.insert(var_5_0, var_5_4)
			self:_artifactBindUpValueFunc(var_5_4)

			var_5_1[var_5_3.advance_code] = true
		end
	end

	return var_5_0
end

function RecruitWishMemberFilter:getAllKnightSoul()
	local var_6_0 = {}
	local var_6_1 = g.core.model.User.knightSoulData:getWishCompleteMap()
	local var_6_2 = {}

	for iter_6_0, iter_6_1 in pairs((g.core.model.User.recruitData:getWishInfo(var_0_0.RECRUIT_TYPE.KNIGHT_SOUL_RECRUIT))) do
		var_6_2[iter_6_1.r_type .. "_" .. iter_6_1.r_value] = {
			pos = iter_6_1.pos,
			state = iter_6_1.status,
			placeHolders = self._wishInfos
		}
	end

	for iter_6_2 = 1, g.core.config.ksoul_info:getLength() do
		local var_6_3 = g.core.config.ksoul_info.indexOf(iter_6_2)

		if var_6_3.quality > g.core.const.ConstMgr.QUALITY_TYPE.R then
			local var_6_4 = self:_createMemberStruct(g.core.common.Goods.TYPE_KNIGHT_SOUL, var_6_3, nil, {
				historyMap = var_6_1
			})
			local var_6_5 = var_6_2[var_6_4:getType() .. "_" .. var_6_4:getId()]

			if var_6_5 then
				var_6_4:updateStructNetInfo(var_6_5)
			end

			table.insert(var_6_0, var_6_4)
		end
	end

	return var_6_0
end

function RecruitWishMemberFilter:getKnightSoulListByRecruitCfg(arg_7_1, arg_7_2)
	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_2 = 1

	while g.core.config.recruit_knight_info.hasKey("pack" .. 1 .. "_id") do
		if arg_7_1["pack" .. 1 .. "_id"] > 0 then
			g.core.model.User.recruitData:getDropKnights(arg_7_1["pack" .. 1 .. "_id"], var_7_1)
		end

		var_7_2 = var_7_2 + 1
	end

	local var_7_4 = g.core.model.User.knightSoulData:getWishCompleteMap()
	local var_7_5 = g.core.model.User.recruitData:getWishInfo(arg_7_1.type, arg_7_2) or {}

	if arg_7_1.type == g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.LIMIT_KNIGHT_SOUL_RECRUIT and #var_7_5 == 0 then
		var_7_5 = {}
	end

	local var_7_6 = {}

	for iter_7_0, iter_7_1 in pairs(var_7_5) do
		var_7_6[iter_7_1.r_type .. "_" .. iter_7_1.r_value] = {
			pos = iter_7_1.pos,
			state = iter_7_1.status,
			placeHolders = self._wishInfos
		}
	end

	for iter_7_2, iter_7_3 in ipairs(var_7_1) do
		local var_7_7 = self:_createMemberStruct(g.core.common.Goods.TYPE_KNIGHT_SOUL, g.core.config.ksoul_info.get(iter_7_3.value), nil, {
			historyMap = var_7_4
		})
		local var_7_8 = var_7_6[var_7_7:getType() .. "_" .. var_7_7:getId()]

		if var_7_8 then
			var_7_7:updateStructNetInfo(var_7_8)
		end

		table.insert(var_7_0, var_7_7)
	end

	return var_7_0
end

function RecruitWishMemberFilter:_initRoundRecruitDic()
	self._roundRecruitDic = {}

	for iter_8_0, iter_8_1 in ipairs(require("app.view.module.recruit.const.RecruitFuncCfg").getKnightCfg().subTree) do
		if iter_8_1.id then
			local var_8_0 = g.core.config.recruit_knight_info.get(iter_8_1.id)

			if g.core.model.User.recruitData:getDisplayInfoById(iter_8_1.id).cfg.type_label == 2 then
				local var_8_1 = 1

				while g.core.config.recruit_knight_info.hasKey("up_content_value") do
					if var_8_0.up_content_value > 0 then
						self._roundRecruitDic[var_8_0.up_content_value] = math.floor(tonumber(g.core.config.parameter_info.get(15027).parameter) / 100)
					end

					var_8_1 = var_8_1 + 1
				end
			end
		end
	end
end

function RecruitWishMemberFilter:getArtifactOpenState(arg_9_1)
	local var_9_0 = g.core.config.artifact_info.get(arg_9_1)
	local var_9_1 = 0

	if var_9_0.gm_open == 1 then
		local var_9_2 = g.core.model.User.artifactData:getArtifactByAdvacnceId(var_9_0.advance_code)
		local var_9_3 = var_9_2:getBelongToKnightInfo()

		var_9_1 = g.core.model.User.recruitData:isLimitArtifact(arg_9_1) and 1 or var_9_3 and (var_9_2:isOwn() or var_9_3:isOwn()) and 3 or 4
	end

	return var_9_1
end

function RecruitWishMemberFilter:_artifactBindUpValueFunc(arg_10_1)
	arg_10_1:setUpCalFunc(function(arg_11_0, arg_11_1)
		if not arg_11_1 and arg_11_0:getState() == 1 then
			return 0
		end

		return (self._roundRecruitDic[arg_10_1:getId()] or nil) and self._roundRecruitDic[arg_10_1:getId()]
	end)
end

function RecruitWishMemberFilter:_createMemberStruct(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0
	local var_12_1 = arg_12_4.maxNum
	local var_12_2 = arg_12_4.isLimit

	if g.core.common.Goods.TYPE_KNIGHT == arg_12_1 then
		var_12_0 = RecruitWishMemberStruct.new(arg_12_1, arg_12_2.advance_id, arg_12_3)

		local var_12_3 = g.core.model.User.knightsData:getKnight({
			advance_id = arg_12_2.advance_id
		})
		local var_12_4 = {}

		var_12_4.level = arg_12_3 and arg_12_3:getLevel() or 1
		var_12_4.quality = arg_12_2.quality
		var_12_4.star = arg_12_3 and arg_12_3:getStarLv() or 0
		var_12_4.name = arg_12_2.name
		var_12_4.group = arg_12_2.group
		var_12_4.isMaxStar = var_12_3 and var_12_3:isMaxStar() or false
		var_12_4.isOwn = var_12_3:isOwn()
		var_12_4.isLimit = var_12_2
		var_12_4.wishMaxNum = var_12_1

		var_12_0:updateStructBaseInfo(var_12_4)
	elseif g.core.common.Goods.TYPE_ARTIFACT == arg_12_1 then
		var_12_0 = RecruitWishMemberStruct.new(arg_12_1, arg_12_3:getAdvanceId(), arg_12_3)

		local var_12_5 = true

		if arg_12_3:isHasWeaponSpirit() then
			var_12_5 = arg_12_3:isSpiritMaxStage()
		end

		local var_12_6 = {
			level = arg_12_3:getLevel(),
			quality = arg_12_3:getQuality(),
			star = arg_12_3:getStar(),
			name = arg_12_2.name,
			group = arg_12_3:getBelongToKnightInfo():getGroup(),
			isOwn = arg_12_3:isOwn(),
			isMaxStar = arg_12_3:isMaxStar(),
			isLimit = var_12_2,
			wishMaxNum = var_12_1
		}

		var_12_6.fullDevelop = arg_12_3:isMaxStar() and var_12_5

		var_12_0:updateStructBaseInfo(var_12_6)
	elseif g.core.common.Goods.TYPE_KNIGHT_SOUL == arg_12_1 then
		var_12_0 = RecruitWishMemberStruct.new(arg_12_1, arg_12_2.id)

		var_12_0:updateStructBaseInfo({
			isMaxStar = false,
			star = 0,
			quality = arg_12_2.quality,
			name = arg_12_2.name,
			isOwn = arg_12_4.historyMap[arg_12_2.id] ~= nil,
			group = arg_12_2.group
		})
	end

	return var_12_0
end

return RecruitWishMemberFilter

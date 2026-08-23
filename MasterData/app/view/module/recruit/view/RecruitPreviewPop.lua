local var_0_0 = g.core.model.User.recruitData
local var_0_1 = g.core.const.ConstMgr.RecruitConst
local RecruitPreviewPop = class("RecruitPreviewPop", require("app.fairyGUI.recruit.UI_RecruitPreviewPop"), function()
	return fgui.GComponent:create({
		resName = "RecruitPreviewPop",
		pkgPath = "ui/recruit/recruit",
		pkgName = "recruit"
	})
end)

function RecruitPreviewPop:ctor(arg_2_1)
	self._id = arg_2_1.id
	self._type = arg_2_1.type
	self._actId = arg_2_1.actId
	self._params = arg_2_1

	if self._params.title then
		self.m_popPanel:setTitle(self._params.title)
	end

	self:_addListeners()
	self:_init()
end

function RecruitPreviewPop:_addListeners()
	return
end

function RecruitPreviewPop:_init()
	self:getView():center(true)
	self.m_previewList:setMargin(0)
	self:_initListDatas()
	self:_updateList()
end

function RecruitPreviewPop:_initListDatas()
	if self._params then
		self._listData = self._params.previewDatas
	end

	self._listData = self._listData or var_0_0:getPreviewInfosByRecruitId(self._id)

	local var_5_0 = {
		use_icon = 3
	}

	if self._type == var_0_1.RECRUIT_TYPE.PREMIUM then
		if not self._id or self._id ~= var_0_1.RECRUIT_SP_ID.PREMIUM_KNIGHT_NORMAL_ID then
			local var_5_1 = var_0_0:getRecruitKnightCfg(var_0_1.RECRUIT_TYPE.PREMIUM).limit_num
			local var_5_2 = var_0_0:getAdvanceDailyTotalNum()

			if g.core.platform.PlatformProxy:isChannelOfChina() then
				var_5_1 = math.min(var_5_1, g.core.const.ConstMgr.BASE_CONST.BANSHU_RECRUIT_PREMIUM_MAX)
				var_5_2 = math.min(var_5_2, g.core.const.ConstMgr.BASE_CONST.BANSHU_RECRUIT_PREMIUM_MAX)
			end

			var_5_0.tip = g.core.lang:get(108038, {
				num = var_5_1,
				cur = var_5_2
			})
		else
			local var_5_3 = g.core.model.User.recruitData:getWishInfos(g.core.model.User.recruitData:getDrawInfo(self._id), self._id)
			local var_5_4 = {
				cur = var_5_3.curTimes,
				num = var_5_3.maxTimes - 1
			}
			local var_5_5 = 108659

			if self._type == var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT then
				var_5_5 = 108706
				var_5_4.num = 1
			end

			var_5_0.tip = g.core.lang:get(var_5_5, var_5_4)
			var_5_0.tipQuality = 4
		end
	elseif self._type == var_0_1.RECRUIT_TYPE.UNITE_TOKEN_NORMAL then
		local var_5_6 = var_0_0:getRecruitKnightCfg(var_0_1.RECRUIT_TYPE.UNITE_TOKEN_NORMAL).limit_num

		if var_5_6 == 0 then
			var_5_0 = nil
		else
			var_5_0.tip = g.core.lang:get(108109, {
				num = var_5_6,
				cur = var_0_0:getUniteTokenNormalDailyTotalNum()
			})
		end
	elseif self._type == var_0_1.RECRUIT_TYPE.RECRUIT_SUCCUBA then
		local var_5_7 = var_0_0:getRecruitKnightCfg(var_0_1.RECRUIT_TYPE.RECRUIT_SUCCUBA).limit_num

		if var_5_7 == 0 then
			var_5_0 = nil
		else
			var_5_0.tip = g.core.lang:get(108468, {
				num = var_5_7,
				cur = var_0_0:getSuccubaNormalTotalNum()
			})
		end
	elseif self._type == var_0_1.RECRUIT_TYPE.UNITE_TOKEN_LIMIT or self._type == var_0_1.RECRUIT_TYPE.UNITE_TOKEN_OPEN_SERVER or self._type == var_0_1.RECRUIT_TYPE.ARTIFACT_LIMIT or self._type == var_0_1.RECRUIT_TYPE.PRECIOUS or self._type == var_0_1.RECRUIT_TYPE.RECRUIT_ACT_UNITE_TOKEN then
		var_5_0 = nil
	elseif self._type == var_0_1.RECRUIT_TYPE.PRIMARY then
		var_5_0.tip = g.core.lang:get(108332)
	elseif self._type == var_0_1.RECRUIT_TYPE.ARTIFACT_BASE then
		local var_5_8 = {
			cur = 0,
			num = var_0_0:getRecruitKnightCfg(self._type).limit_num
		}
		local var_5_9 = var_0_0:getDrawInfo(nil, self._type)

		if var_5_9 then
			var_5_8.cur = var_5_9:getDailyCount()
		end

		var_5_0.tip = g.core.lang:get(108038, var_5_8)
	else
		if self._type ~= var_0_1.RECRUIT_TYPE.KNIGHT_SOUL_RECRUIT then
			if self._type == var_0_1.RECRUIT_TYPE.LIMIT_KNIGHT_SOUL_RECRUIT then
				local var_5_10 = {
					cur = 0
				}

				var_5_10.num = var_0_0:getRecruitKnightCfg(self._type).limit_num

				local var_5_11 = var_0_0:getDrawInfo(nil, self._type)

				if var_5_11 then
					var_5_10.cur = var_5_11:getDailyCount()
				end

				var_5_0.tip = g.core.lang:get(108468, var_5_10)
			elseif self._type == var_0_1.RECRUIT_TYPE.PET_BASE then
				local var_5_12 = {
					cur = 0,
					num = var_0_0:getRecruitKnightCfg(var_0_1.RECRUIT_TYPE.PET_BASE).limit_num
				}
				local var_5_13 = var_0_0:getDrawInfo(nil, var_0_1.RECRUIT_TYPE.PET_BASE)

				if var_5_13 then
					var_5_12.cur = var_5_13:getDailyCount()
				end

				var_5_0.tip = g.core.lang:get(108432, var_5_12)
			elseif self._type == var_0_1.RECRUIT_TYPE.PET_LIMIT then
				local var_5_14 = var_0_0:getGuaranteedInfoByGuaranteedType(self._type, 7) or {
					totalTimes = 0,
					times = 0
				}

				var_5_0.tip = g.core.lang:get(108053, {
					cur = var_5_14.totalTimes - var_5_14.times,
					num = var_5_14.totalTimes - 1
				})
				var_5_0.tipQuality = 4
			elseif self._type == var_0_1.RECRUIT_TYPE.PRIMARY_LIMIT then
				local var_5_15 = g.core.model.User.recruitData:getDrawInfo(nil, self._type)

				var_5_0.tip = g.core.lang:get(108479, {
					cur = var_5_15:getTotalCount(),
					limit = var_5_15:getTotalLimitNum()
				})
			elseif self._type == var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_KNIGHT or self._type == var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT or self._type == var_0_1.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT or self._type == var_0_1.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT then
				local var_5_16 = g.core.model.User.recruitData:getDrawInfo(self._id, self._type, true):getWishLucks()
				local var_5_17 = g.core.config.recruit_knight_wish_rule_info.get(g.core.config.recruit_knight_info.get(self._id).wish_rule_id)
				local var_5_18 = 0

				for iter_5_0 = var_5_17.minimum_initial_quality, var_5_17.minimum_quality do
					if var_5_16[iter_5_0] then
						var_5_18 = var_5_18 + var_5_16[iter_5_0].num
					end
				end

				local var_5_19 = 108721

				if self._type == var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT then
					var_5_19 = 108706
				elseif self._type == var_0_1.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT then
					var_5_19 = 108718
				end

				var_5_0.tip = g.core.lang:get(var_5_19, {
					cur = math.min(var_5_18, var_5_17.minimum_num - 1),
					num = var_5_17.minimum_num - 1
				})
				var_5_0.tipQuality = 4
			end
		end

		local var_5_20 = var_0_0:getGuaranteedInfoByGuaranteedType(self._type, 7) or {
			totalTimes = 0,
			times = 0
		}
		local var_5_21 = g.core.lang:get(108658, {
			cur = var_5_20.totalTimes - var_5_20.times,
			num = var_5_20.totalTimes - 1
		})
		local var_5_22 = var_0_1.RECRUIT_TYPE.PREMIUM

		if self._type == var_0_1.RECRUIT_TYPE.LIMIT_ACTIVE then
			var_5_21 = g.core.lang:get(108664)
		elseif self._type == var_0_1.RECRUIT_TYPE.RECRUIT_KNIGHT_SPRING then
			var_5_21 = g.core.lang:get(108701)
			var_5_22 = self._type
		elseif self._type == var_0_1.RECRUIT_TYPE.RECRUIT_RESONATOR_CAPTAIN then
			var_5_21 = g.core.lang:get(108724)
			var_5_22 = self._type
		end

		local var_5_23 = var_0_0:getRecruitKnightCfg(var_5_22).limit_num
		local var_5_24 = g.core.model.User.recruitData:getDrawInfoByRecruitId(self._id)
		local var_5_25 = var_5_24 and var_5_24:getDailyCount() or 0

		if g.core.platform.PlatformProxy:isChannelOfChina() then
			var_5_23 = math.min(var_5_23, g.core.const.ConstMgr.BASE_CONST.BANSHU_RECRUIT_PREMIUM_MAX)
			var_5_25 = math.min(var_5_25, g.core.const.ConstMgr.BASE_CONST.BANSHU_RECRUIT_PREMIUM_MAX)
		end

		var_5_0.tip = g.core.lang:get(108038, {
			num = var_5_23,
			cur = var_5_25
		}) .. " \n " .. var_5_21
		var_5_0.tipQuality = 4
	end

	if var_5_0 then
		local var_5_26 = var_0_0:getDisplayInfoById(self._id)

		if var_5_26.cfg.type_label > 0 and self._type ~= var_0_1.RECRUIT_TYPE.PRIMARY_LIMIT and ({
			[var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_KNIGHT] = true,
			[var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT] = true,
			[var_0_1.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT] = true,
			[var_0_1.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT] = true,
			[var_0_1.RECRUIT_TYPE.RECRUIT_KNIGHT_SPRING] = true
		})[self._type] then
			var_5_0.tip = var_5_0.tip .. " \n " .. g.core.lang:get(108419, {
				tip = g.core.lang:get(108600 + var_5_26.cfg.type_label)
			})
		end

		table.insert(self._listData, 1, var_5_0)
	end
end

function RecruitPreviewPop:_onItemRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateView(self._type, self._listData[arg_6_1 + 1], self._params.tabType, self._actId or self._id)
end

function RecruitPreviewPop:onLoad()
	return
end

function RecruitPreviewPop:_updateList()
	for iter_8_0, iter_8_1 in ipairs(self._listData) do
		local var_8_0 = true

		if iter_8_1.use_icon < 3 then
			local var_8_1 = {}
			local var_8_2 = self._type == var_0_1.RECRUIT_TYPE.ARTIFACT_LIMIT or self._type == var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT
			local var_8_3 = self._tabType == g.core.const.ConstMgr.RecruitConst.RECRUIT_TAB_TYPE.PET_TAB

			for iter_8_2 = 1, 3 do
				if iter_8_1["pack" .. iter_8_2 .. "_id"] > 0 then
					g.core.model.User.recruitData:getDropKnights(iter_8_1["pack" .. iter_8_2 .. "_id"], var_8_1, var_8_2, var_8_3)
				end
			end

			var_8_0 = #var_8_1 > 0
		end

		if var_8_0 then
			local var_8_4 = fgui.UIPackage:createObject("recruit", "RecruitPreviewCell")

			self:_onItemRenderer(iter_8_0 - 1, var_8_4)
			self.m_previewList:addItem(var_8_4)
		end
	end
end

return RecruitPreviewPop

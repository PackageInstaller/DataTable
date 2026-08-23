local RecruitPreviewCell = class("RecruitPreviewCell", require("app.fairyGUI.recruit.UI_RecruitPreviewCell"))
local var_0_1 = g.core.const.ConstMgr.RecruitConst

function RecruitPreviewCell:ctor()
	self._itemData = nil
	self._showSpecial = {
		nil,
		true,
		nil,
		nil,
		nil,
		true,
		true,
		nil,
		nil,
		nil,
		nil,
		true,
		nil,
		nil,
		nil,
		nil,
		nil,
		true,
		true,
		true,
		true,
		nil,
		true,
		true,
		true,
		nil,
		true,
		true,
		true,
		true,
		nil,
		true,
		[33] = true
	}

	self:_addListeners()
end

function RecruitPreviewCell:_addListeners()
	return
end

function RecruitPreviewCell:updateView(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if not arg_3_2 then
		return
	end

	self._tabType = arg_3_3
	self._recruitId = arg_3_4

	self.m_tipQualityIcon:setVisible(false)

	if arg_3_2.use_icon < 3 then
		self.m_typeController:setSelectedIndex(arg_3_2.use_icon)
		self:_updateByCfg(arg_3_2, arg_3_1)
	else
		self.m_typeController:setSelectedIndex(0)
		self:_updateFirst(arg_3_2, arg_3_1)
	end
end

function RecruitPreviewCell:_getKnightName(arg_4_1)
	for iter_4_0 = 1, g.core.config.knight_info.getLength() do
		local var_4_0 = g.core.config.knight_info.indexOf(iter_4_0)

		if var_4_0.advance_id == arg_4_1 then
			return var_4_0.name
		end
	end
end

function RecruitPreviewCell:getDrawRealShowReward(arg_5_1, arg_5_2)
	if arg_5_1 == var_0_1.RECRUIT_TYPE.RECRUIT_SUCCUBA then
		local var_5_0 = g.core.model.User.recruitData:getSuccubaNormalWish()

		if next(var_5_0) then
			local var_5_1 = false

			for iter_5_0, iter_5_1 in ipairs((g.core.model.User.recruitData:getSuccubaTotalNormalWishItems())) do
				if iter_5_1.type == arg_5_2.type and iter_5_1.value == arg_5_2.value then
					var_5_1 = true

					break
				end
			end

			if var_5_1 then
				arg_5_2.value = var_5_0[1].r_value
			end
		end
	end

	return arg_5_2
end

function RecruitPreviewCell:_updateByCfg(arg_6_1, arg_6_2)
	self._upInfos = {}

	local var_6_0 = {}

	for iter_6_0 = 1, 99 do
		if not g.core.config.recruit_knight_preview_info.hasKey("up" .. iter_6_0 .. "_id") then
			break
		end

		local var_6_1 = arg_6_1["up" .. iter_6_0 .. "_id"]

		if arg_6_1["up" .. iter_6_0 .. "_id"] == 0 and iter_6_0 == 1 and ({
			[var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_KNIGHT] = true,
			[var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT] = true,
			[var_0_1.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT] = true,
			[var_0_1.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT] = true,
			[var_0_1.RECRUIT_TYPE.RECRUIT_KNIGHT_SPRING] = true
		})[arg_6_2] and arg_6_1.icon > 4 then
			local var_6_2 = g.core.model.User.recruitData:getWishInfo(arg_6_2, self._recruitId)

			if var_6_2 then
				for iter_6_1, iter_6_2 in pairs(var_6_2) do
					if iter_6_2[1] then
						var_6_1 = iter_6_2[1].r_value

						break
					end

					var_6_1 = iter_6_2.r_value

					break
				end
			end
		end

		if var_6_1 > 0 then
			self._upInfos[var_6_1] = arg_6_1["up" .. iter_6_0 .. "_txt"]
			var_6_0[var_6_1] = iter_6_0
		end
	end

	local var_6_3 = {}
	local var_6_4 = arg_6_2 == var_0_1.RECRUIT_TYPE.ARTIFACT_LIMIT or arg_6_2 == var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT or arg_6_2 == var_0_1.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT
	local var_6_5 = self._tabType == g.core.const.ConstMgr.RecruitConst.RECRUIT_TAB_TYPE.PET_TAB or self._tabType == g.core.const.ConstMgr.RecruitConst.RECRUIT_TAB_TYPE.SUCCUBA_TAB

	for iter_6_3 = 1, 3 do
		if arg_6_1["pack" .. iter_6_3 .. "_id"] > 0 then
			g.core.model.User.recruitData:getDropKnights(arg_6_1["pack" .. iter_6_3 .. "_id"], var_6_3, var_6_4, var_6_5)
		end
	end

	local var_6_6 = {}

	for iter_6_4, iter_6_5 in ipairs(var_6_3) do
		local var_6_7 = g.core.common.Goods:convert((self:getDrawRealShowReward(arg_6_2, {
			size = 1,
			type = iter_6_5.type,
			value = iter_6_5.value
		})))

		if iter_6_5.type ~= g.core.common.Goods.TYPE_PET and var_6_5 and iter_6_5.min > 0 then
			var_6_7.sizeStr = iter_6_5.min == iter_6_5.max and iter_6_5.min or iter_6_5.min .. "~" .. iter_6_5.max
		end

		if self._upInfos[var_6_7.value] then
			table.insert(var_6_6, 1, var_6_7)

			var_6_0[var_6_7.value] = nil
		else
			table.insert(var_6_6, var_6_7)
		end
	end

	if self._tabType == g.core.const.ConstMgr.RecruitConst.RECRUIT_TAB_TYPE.KNIGHT_TAB or arg_6_2 == var_0_1.RECRUIT_TYPE.RECRUIT_KNIGHT_SPRING or self._tabType == g.core.const.ConstMgr.RecruitConst.RECRUIT_TAB_TYPE.PET_TAB or self._tabType == g.core.const.ConstMgr.RecruitConst.RECRUIT_TAB_TYPE.UNITE_TAB or self._tabType == g.core.const.ConstMgr.RecruitConst.RECRUIT_TAB_TYPE.ARTIFACT_TAB then
		for iter_6_6, iter_6_7 in pairs(var_6_0) do
			table.insert(var_6_6, 1, (g.core.common.Goods:convert({
				size = 1,
				type = var_6_6[1].type,
				value = iter_6_6
			})))
		end
	end

	local var_6_8, var_6_9 = self:_getTitleTxtByQuality(arg_6_2, arg_6_1.icon, arg_6_1.rate / 100)

	if arg_6_2 == var_0_1.RECRUIT_TYPE.LIMIT_KNIGHT_SOUL_RECRUIT and arg_6_1.icon >= 4 or arg_6_2 == var_0_1.RECRUIT_TYPE.RECRUIT_KNIGHT_SPRING or arg_6_2 == var_0_1.RECRUIT_TYPE.RECRUIT_SUCCUBA then
		self.m_exDescTxt:setVisible(false)
	else
		self.m_exDescTxt:setVisible(true)

		if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.KR or config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
			if arg_6_1.icon >= 5 and arg_6_2 ~= var_0_1.RECRUIT_TYPE.DAILY_RECRUIT and arg_6_2 ~= var_0_1.RECRUIT_TYPE.PRIMARY then
				local var_6_10 = 108499

				if table.nums(self._upInfos) > 0 then
					var_6_10 = 108498
				end

				if var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_KNIGHT == arg_6_2 then
					var_6_10 = 108710
				elseif var_0_1.RECRUIT_TYPE.RECRUIT_RETURN_ARTIFACT == arg_6_2 then
					var_6_10 = 108711
				elseif var_0_1.RECRUIT_TYPE.NEW_LIMIT_ARTIFACT_RECRUIT == arg_6_2 then
					var_6_10 = 108716
				end

				self.m_exDescTxt:setText(g.core.lang:get(var_6_10))
			else
				self.m_exDescTxt:setText(g.core.lang:get(108499))
			end
		end
	end

	self.m_title:setText(var_6_8)

	if var_6_9 and arg_6_2 ~= var_0_1.RECRUIT_TYPE.RECRUIT_SUCCUBA then
		self.m_qualityIcon:setURL(var_6_9)
		self.m_title:setX(18 + self.m_qualityIcon:getWidth())
	else
		self.m_qualityIcon:setURL("")
		self.m_title:setX(25)
	end

	if arg_6_1.use_icon == 1 then
		self._itemData = var_6_6

		self.m_iconGroup:updateComp(self._itemData, self._upInfos)
		self:setHeight(self.m_iconGroup:getCompHeight() + 55)
	else
		local var_6_11 = {}

		for iter_6_8, iter_6_9 in pairs(var_6_6) do
			table.insert(var_6_11, iter_6_9.name)
		end

		self.m_itemNameTxt:setText((table.concat(var_6_11, ", ")))
		self:setHeight(self.m_itemNameTxt:getY() + self.m_itemNameTxt:getHeight() + 10)
	end
end

function RecruitPreviewCell:_updateFirst(arg_7_1, arg_7_2)
	self.m_qualityIcon:setURL("")

	if self._tabType == g.core.const.ConstMgr.RecruitConst.RECRUIT_TAB_TYPE.UNITE_TAB then
		self.m_title:setText(g.core.lang:get(108105))
	elseif self._tabType == g.core.const.ConstMgr.RecruitConst.RECRUIT_TAB_TYPE.ARTIFACT_TAB then
		self.m_title:setText(g.core.lang:get(108407))
	elseif self._tabType == g.core.const.ConstMgr.RecruitConst.RECRUIT_TAB_TYPE.PET_TAB then
		self.m_title:setText(g.core.lang:get(108431))
	else
		self.m_title:setText(g.core.lang:get(108040))
	end

	self.m_itemNameTxt:setText(arg_7_1.tip)
	self.m_tipQualityIcon:setVisible(false)
	self:setHeight(self.m_itemNameTxt:getY() + self.m_itemNameTxt:getHeight() + 50)
end

function RecruitPreviewCell:_getTitleTxtByQuality(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_1 == 3 then
		return g.core.lang:get(108042)
	else
		local var_8_0 = self:_getIconByQuality(arg_8_2)

		if self._showSpecial[arg_8_1] and arg_8_2 > 4 then
			return g.core.lang:get(108660, {
				ratio = arg_8_3
			}), var_8_0
		else
			return g.core.lang:get(108041, {
				ratio = arg_8_3
			}), var_8_0
		end
	end
end

function RecruitPreviewCell:_getIconByQuality(arg_9_1)
	return "ui://text_new/pic_pinzhi_" .. arg_9_1
end

return RecruitPreviewCell

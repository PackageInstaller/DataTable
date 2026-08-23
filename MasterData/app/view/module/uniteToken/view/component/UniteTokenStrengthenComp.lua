local var_0_0 = g.core.model.User.uniteTokenData
local var_0_1 = g.core.const.ConstMgr.UniteTokenConst
local var_0_2 = g.core.config.unite_token_upgrade_info
local UniteTokenStrengthenComp = class("UniteTokenStrengthenComp", require("app.fairyGUI.uniteToken.UI_UniteTokenStrengthenComp"))

function UniteTokenStrengthenComp:ctor()
	self.m_starComp:initStar({
		num = 0,
		style = 2,
		index = 6,
		gap = 12,
		max = 10
	})

	self._flagTimes = 0
	self._talentList = nil
	self._specialLvUpgrade = 0
	self._specialLv = 0

	self.m_starComp:setStarStyle(10, {
		active = "ui://base_new/icon_bf_qianghua2_1",
		unActive = "ui://base_new/icon_bf_qianghua2_2"
	})
	self.m_levelTipsBtn:addClickListener(handler(self, self._onTipsClick))
	self.m_touchPanel:addClickListener(handler(self, self._onTipsClick))
	self.m_strengthOBtn:addClickListener(handler(self, self._onOneStrengthClick))
	self.m_strengthTBtn:addClickListener(handler(self, self._onTenStrengthClick))
	self.m_strengthABtn:addClickListener(handler(self, self._onSpecialStrengthClick))
end

function UniteTokenStrengthenComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_UNITE_TOKEN_ONEKEY_UPGRADE, handler(self, self._onRecvTokenUpgrade), self)
	self:updateShow()
end

function UniteTokenStrengthenComp:updateShow(arg_3_1)
	self._showData = arg_3_1 or self._showData

	if not self._showData then
		return
	end

	if self._baseId and self._baseId ~= self._showData:getBaseId() then
		self:resetFlag()
	end

	local var_3_0 = self._showData:getLevel()
	local var_3_1 = self._showData:getTokenMaxLevel()

	self._baseId = self._showData:getBaseId()

	self.m_maxLevelTxt:setText("Max")
	self.m_levelTxt:setText(var_3_0)

	local var_3_2 = var_3_0 % 10

	if var_3_0 >= 10 and var_3_2 == 0 then
		var_3_2 = 10
	end

	self.m_starComp:setStarNum(var_3_2)

	local var_3_3 = var_3_1 <= var_3_0
	local var_3_4 = var_0_0:getTokenUpgradeInfo(self._showData:getUpgradeId(), var_3_0, var_3_1 <= var_3_0)

	if var_3_1 <= var_3_0 then
		self.m_stateController:setSelectedIndex(1)

		for iter_3_0 = 1, var_0_1.LV_ATTR_NUM do
			self["m_strengDescComp" .. iter_3_0]:setWidth(370)
			self["m_strengDescComp" .. iter_3_0]:getController("attrNum"):setSelectedIndex(0)
			self["m_strengDescComp" .. iter_3_0]:updateAttr(var_3_4.attrList[iter_3_0])
		end
	else
		self.m_stateController:setSelectedIndex(0)

		local var_3_5 = self._showData:getUpgradeId()
		local var_3_6 = var_0_0:getTokenUpgradeInfo(var_3_5, var_3_0, var_3_3)
		local var_3_7 = var_0_0:getTokenUpgradeInfo(var_3_5, var_3_0 + 1, var_3_3)

		for iter_3_1, iter_3_2 in ipairs(var_3_6.attrList) do
			local var_3_9 = clone(var_3_6.attrList[iter_3_1])

			var_3_9.value2 = tonumber(var_3_7.attrList[iter_3_1].value)

			self["m_strengDescComp" .. iter_3_1]:updateAttr(var_3_9)
			self["m_strengDescComp" .. iter_3_1]:getController("attrNum"):setSelectedIndex(1)
			self["m_strengDescComp" .. iter_3_1]:setWidth(205)
		end

		local var_3_10, var_3_11, var_3_12, var_3_13, var_3_14 = self._showData:canUpgrade()

		self._costType = var_3_6.cfg.cost_type
		self._costValue = var_3_6.cfg.cost_value
		self._costType2 = var_3_6.cfg.cost_type_2
		self._costValue2 = var_3_6.cfg.cost_value_2
		self._costSize2 = var_3_6.cfg.cost_num_2

		if self._costSize2 == 0 then
			self.m_oneCost:setVisible(true)
			self.m_towCost:setVisible(false)
			self.m_costComp:updateByTVS({
				type = self._costType,
				value = self._costValue,
				size = var_3_14
			})
		else
			self.m_oneCost:setVisible(false)
			self.m_towCost:setVisible(true)
			self.m_costComp1:updateByTVS({
				type = self._costType,
				value = self._costValue,
				size = var_3_14
			})
			self.m_costComp2:updateByTVS({
				type = self._costType2,
				value = self._costValue2,
				size = self._costSize2
			})
		end
	end

	local var_3_15

	for iter_3_3, iter_3_4 in ipairs(var_3_4.talentList) do
		if not iter_3_4.isActive then
			var_3_15 = iter_3_4

			break
		end
	end

	self._talentList = var_3_4.talentList
	var_3_15 = var_3_15 or var_3_4.talentList[#var_3_4.talentList]

	self.m_talentNameTxt:setText("[" .. var_3_15.info.name .. "]")

	local var_3_16 = var_3_15.info.description

	if not var_3_15.isActive then
		var_3_16 = g.core.lang:get(202526, {
			description = var_3_16,
			level = var_3_15.level
		})
	end

	self.m_talentDesc:setText(var_3_16)
end

function UniteTokenStrengthenComp:playEnterAnim(arg_4_1)
	if arg_4_1 then
		self.m_enterTransition:play(arg_4_1)
	else
		self.m_enterTransition:play()
	end
end

function UniteTokenStrengthenComp:playExitAnim(arg_5_1)
	if arg_5_1 then
		self.m_backTransition:play(arg_5_1)
	else
		self.m_backTransition:play()
	end
end

function UniteTokenStrengthenComp:_onOneStrengthClick()
	if not self._showData then
		return
	end

	local var_6_0, var_6_1, var_6_2, var_6_3, var_6_4, var_6_5, var_6_6 = self._showData:canUpgrade()

	if var_6_0 then
		local var_6_7 = self._showData:getServerId()

		if var_6_7 > 0 then
			g.core.network.GameNetProxy:send_C2S_UniteToken_Upgrade({
				id = var_6_7
			})
		end
	else
		if var_6_3 < var_6_4 then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self._costType,
				value = self._costValue
			})

			return
		end

		if var_6_5 < var_6_6 then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self._costType2,
				value = self._costValue2
			})

			return
		end

		if var_6_1 < var_6_2 then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = g.core.common.Goods.TYPE_RESOURCE,
				value = g.core.common.Goods.RESOURCE.TYPE_COIN,
				size = var_6_1
			})

			return
		end
	end
end

function UniteTokenStrengthenComp:_onTenStrengthClick()
	if not self._showData then
		return
	end

	local var_7_0 = self._lvUpNum or 10
	local var_7_1 = self._showData:getLevel()
	local var_7_2, var_7_3, var_7_4, var_7_5 = self:getLvUpMaxLv(var_7_1, self._showData:getTokenMaxLevel(), g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_ITEM, var_0_1.LVUP_COST_TYPE1), (g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_ITEM, var_0_1.LVUP_COST_TYPE2)))

	if var_7_2 - var_7_1 > 0 then
		local var_7_6 = var_7_2 - var_7_1
		local var_7_7

		if var_7_0 <= var_7_2 - var_7_1 then
			var_7_6 = var_7_0
			var_7_7 = {}
		end

		var_7_7.id = self._showData:getServerId()
		var_7_7.level = math.min(var_7_6, 100)

		g.core.network.GameNetProxy:send_C2S_UniteToken_OneKey_Upgrade(var_7_7)
	elseif var_7_3 then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = g.core.common.Goods.TYPE_RESOURCE,
			value = g.core.common.Goods.RESOURCE.TYPE_COIN
		})
	elseif var_7_4 then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = g.core.common.Goods.TYPE_ITEM,
			value = var_0_1.LVUP_COST_TYPE1
		})
	elseif var_7_5 then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = g.core.common.Goods.TYPE_ITEM,
			value = var_0_1.LVUP_COST_TYPE2
		})
	end
end

function UniteTokenStrengthenComp:_onSpecialStrengthClick()
	self._lvUpNum = self._specialLvUpgrade

	self:_onTenStrengthClick()

	self._lvUpNum = nil
end

function UniteTokenStrengthenComp:getLvUpMaxLv(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = self._showData:getUpgradeId()
	local var_9_1 = g.core.model.User.resourceData:getCoin()
	local var_9_2 = 0
	local var_9_3 = 0
	local var_9_4 = 0
	local var_9_5 = arg_9_1

	for iter_9_0 = arg_9_1, arg_9_2 do
		local var_9_6 = var_0_2.get(var_9_0, iter_9_0)

		var_9_2 = var_9_2 + var_9_6.cost_money

		if var_9_6.cost_value == var_0_1.LVUP_COST_TYPE1 then
			var_9_3 = var_9_3 + var_9_6.cost_num
		end

		if var_9_6.cost_num_2 > 0 then
			var_9_4 = var_9_4 + var_9_6.cost_num_2
		end

		if var_9_1 < var_9_2 or arg_9_3 < var_9_3 or arg_9_4 < var_9_4 then
			return var_9_5, var_9_1 < var_9_2, arg_9_3 < var_9_3, arg_9_4 < var_9_4
		else
			var_9_5 = var_9_5 + 1
		end
	end

	return arg_9_2, false, false, false
end

function UniteTokenStrengthenComp:_onTipsClick()
	if self._talentList then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.uniteToken.view.pop.UniteTokenTalentPop").new(self._talentList), {
			touchDisappear = true
		})
	end
end

function UniteTokenStrengthenComp:_onRecvTokenUpgrade(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_4.level == 10 then
		self._flagTimes = self._flagTimes + 1

		if self._flagTimes >= 2 then
			local var_11_0 = var_0_0:getFiveMaxTokenAvgLv()

			if var_11_0 >= g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.UNITE_TOKEN_SPECIAL_LEVEL).parameter and self._showData:getLevel() <= var_11_0 - 40 then
				self.m_specialController:setSelectedIndex(1)

				self._specialLvUpgrade = var_11_0
				self._specialLv = var_11_0 + 20

				self.m_strengthABtn:setTitle(g.core.lang:get(202529) .. self._specialLvUpgrade)
			else
				self.m_specialController:setSelectedIndex(0)
			end
		end
	end
end

function UniteTokenStrengthenComp:resetFlag()
	self._flagTimes = 0

	self.m_specialController:setSelectedIndex(0)
end

return UniteTokenStrengthenComp

local EquipRefineComp = class("EquipRefineComp", require("app.fairyGUI.equipAndTreasure.UI_EquipRefineComp"))
local var_0_1 = table.insert

function EquipRefineComp:ctor()
	self._equipId = nil
	self._diffLv = 1
	self._refineAddLv = 1
	self._upgradeSucTime = 1
	self._curLevel = 1

	self.m_refineMatList:setIniter()
	self.m_refineMatList:setItemRenderer(handler(self, self._onListMatItemRenderer))
	self.m_onekeyBtn:addClickListener(handler(self, self._onClickOneKey))
	self.m_fiveKeyBtn:addClickListener(handler(self, self._onClickFiveKey))
	self.m_tipsBtn:addClickListener(handler(self, self._onClickTipsButton))
	self.m_shortCutBtn:addClickListener(handler(self, self._onClickShortCutBtn))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
end

function EquipRefineComp:_onTouchBegin(arg_2_1)
	if self.m_showTipsController:getSelectedIndex() == 1 then
		if not self.m_tipsBtn:containPoint((arg_2_1:getInput():getTouch():getLocation())) then
			self.m_showTipsController:setSelectedIndex(0)
		end
	end
end

function EquipRefineComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_REFINING, handler(self, self._onEquipmentRefining), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_REFININGONELEVEL, handler(self, self._onEquipmentRefining), self)
end

function EquipRefineComp:updateView(arg_4_1)
	if not arg_4_1.isServer then
		self._upgradeSucTime = 1
	end

	self.m_haveEquipController:setSelectedIndex(next(arg_4_1.data) and 1 or 0)

	if not next(arg_4_1.data) then
		return
	end

	self._equipData = arg_4_1.data
	self._matList = self:_getAllRefineMat()

	self.m_refineMatList:setNumItems(#self._matList)

	local var_4_0 = arg_4_1.data:getCfg()
	local var_4_1 = arg_4_1.data:getServerData().refining_level
	local var_4_2 = g.core.model.User.equipmentData:getTotalEquipRefineLv()

	self.m_totalLv:setText(g.core.lang:get(201584, {
		num = var_4_2
	}))

	self._refineLimitLv = g.core.model.User.equipmentData:getTotalEquipRefineLvLimitLv(var_4_2)

	self.m_limitLv:setText(g.core.lang:get(201585, {
		num = math.min(self._refineLimitLv, var_4_0.refine_level)
	}))

	if var_4_0.refine_level < self._refineLimitLv then
		self.m_tipsTxt:setText(g.core.lang:get(201586, {
			num = var_4_0.refine_level
		}))
	else
		self.m_tipsTxt:setText(g.core.lang:get(201587, {
			num = self._refineLimitLv,
			sum = g.core.model.User.equipmentData:getNextTotalEquipRefineLvLimitLv(var_4_2)
		}))
	end

	self._curLevel = var_4_1
	self._equipId = arg_4_1.data:getServerData().id
	self._isLimit = var_4_1 >= var_4_0.refine_level

	self:setCtrlState("refineState", {
		index = self._isLimit and 1 or 0
	})
	self.m_curLvTxt:setText(var_4_1)
	self.m_nextLvTxt:setText(var_4_1 + 1)
	self.m_refineLimitTxt:setText("Max")

	local var_4_3, var_4_4, var_4_5 = arg_4_1.data:getEquipAttrAll()
	local var_4_6, var_4_7, var_4_8 = arg_4_1.data:getEquipNextAttrAll()
	local var_4_9, var_4_10, var_4_11, var_4_12 = g.core.lang:getAttrDelta(var_4_4[1].attr, var_4_4[1].value, var_4_7[1].value, true)

	self.m_refineDescComp1:updateAttr({
		name = var_4_9,
		value = var_4_10,
		value2 = var_4_11
	})
	self.m_refineDescComp1:setAttrIconByType(var_4_4[1].attr)

	local var_4_13, var_4_14, var_4_15, var_4_16 = g.core.lang:getAttrDelta(var_4_4[2].attr, var_4_4[2].value, var_4_7[2].value, true)

	self.m_refineDescComp2:updateAttr({
		name = var_4_13,
		value = var_4_14,
		value2 = var_4_15
	})
	self.m_refineDescComp2:setAttrIconByType(var_4_4[2].attr)
	self.m_refineDescComp1:setCtrlState("attrNum", {
		index = self._isLimit and 0 or 1
	})
	self.m_refineDescComp2:setCtrlState("attrNum", {
		index = self._isLimit and 0 or 1
	})

	if self:_checkShortCutBtnIsShow() then
		self.m_shortCutBtn:setTitle((g.core.lang:get(201567, {
			level = g.core.model.User.equipmentData:getEquipRefineShortCutLevel()
		})))
		self.m_shortCutBtn:setVisible(true)
	else
		self.m_shortCutBtn:setVisible(false)
	end
end

function EquipRefineComp:_checkShortCutBtnIsShow()
	local var_5_0 = g.core.model.User.equipmentData:getEquipRefineShortCutLevel()

	if self._upgradeSucTime < 2 then
		return false
	end

	if var_5_0 < 0 then
		return false
	end

	if self._curLevel > var_5_0 - 20 then
		return false
	end

	if var_5_0 < g.core.config.parameter_info.get(115).parameter then
		return false
	end

	return true
end

function EquipRefineComp:_getAllRefineMat()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs((g.core.config.item_info.match(function(arg_7_0)
		return arg_7_0.item_type == 10
	end))) do
		var_0_1(var_6_0, {
			info = iter_6_1,
			num = g.core.model.User.itemsData:getItemNumById(iter_6_1.id)
		})
	end

	return var_6_0
end

function EquipRefineComp:_onListMatItemRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateIcon({
		type = g.core.common.Goods.TYPE_ITEM,
		value = self._matList[arg_8_1 + 1].info.id,
		size = self._matList[arg_8_1 + 1].num
	})

	if self._matList[arg_8_1 + 1].num > 0 then
		arg_8_2:setGrayed(false)
	else
		arg_8_2:setGrayed(true)
	end
end

function EquipRefineComp:_onEquipmentRefining(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	self._equipData = g.core.model.User.equipmentData:getEquipBySid(self._equipId)

	self:updateView({
		isServer = true,
		data = self._equipData
	})

	if self._refineAddLv == 5 then
		self._upgradeSucTime = self._upgradeSucTime + 1
	end
end

function EquipRefineComp:_getMaxExp(arg_10_1, arg_10_2)
	return math.ceil((arg_10_2 + 1)^1.8 / 10 * arg_10_1.refining_exp_1 + arg_10_2 * arg_10_1.refining_exp_2)
end

function EquipRefineComp:_isCanRefineCondtion()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_ONEKEY_REFINE) then
		return false
	end

	local var_11_0 = self._matList
	local var_11_1 = self._equipData:getCfg()
	local var_11_2 = self._equipData:getServerData()
	local var_11_3 = var_11_1.refine_level
	local var_11_4 = self:_getMaxExp(var_11_1, var_11_2.refining_level)

	if var_11_2.refining_level == var_11_1.refine_level then
		local var_11_6 = false

		if var_11_2.refining_exp < var_11_4 then
			local var_11_7 = 9999999

			for iter_11_0, iter_11_1 in ipairs(var_11_0) do
				if iter_11_1.num > 0 and var_11_7 >= iter_11_1.info.item_value then
					var_11_7 = iter_11_1.info.item_value
				end
			end

			if var_11_7 ~= 9999999 and var_11_4 - var_11_2.refining_exp <= var_11_7 then
				var_11_6 = true
			end
		else
			var_11_6 = true
		end

		if var_11_6 then
			g.core.module.ModuleManager:tip(g.core.lang:get(201524, {
				level = var_11_3
			}))

			return false
		end
	end

	return true
end

function EquipRefineComp:_onClickOneKey()
	self._refineAddLv = 1

	self:_goToRefine()
end

function EquipRefineComp:_onClickFiveKey()
	self._refineAddLv = 5

	self:_goToRefine()
end

function EquipRefineComp:_onClickShortCutBtn()
	self._refineAddLv = g.core.model.User.equipmentData:getEquipRefineShortCutLevel()

	self:_goToRefine()
end

function EquipRefineComp:_goToRefine()
	if self._curLevel >= self._refineLimitLv then
		g.core.module.ModuleManager:tip(g.core.lang:get(201588))

		return
	end

	if not self:_isCanRefineCondtion() then
		return
	end

	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs(self._matList) do
		var_15_0 = var_15_0 + iter_15_1.num
	end

	if var_15_0 == 0 then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = g.core.common.Goods.TYPE_ITEM,
			value = self._matList[1].info.id,
			size = g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, self._matList[1].info.id)
		})
	else
		local var_15_1 = self._equipData:getServerData().refining_level
		local var_15_2 = self._equipData:getCfg().refine_level

		if var_15_2 < var_15_1 + self._refineAddLv then
			self._refineAddLv = var_15_2 - var_15_1
		end

		g.core.network.GameNetProxy:send_C2S_Equipment_RefiningOneLevel({
			id = self._equipData:getServerData().id,
			add = self._refineAddLv
		})
	end
end

function EquipRefineComp:_onClickTipsButton()
	if self.m_showTipsController:getSelectedIndex() == 1 then
		self.m_showTipsController:setSelectedIndex(0)
	else
		self.m_showTipsController:setSelectedIndex(1)
	end
end

return EquipRefineComp

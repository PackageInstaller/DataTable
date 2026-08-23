local FogNightmareKeepsakeCardComp = class("FogNightmareKeepsakeCardComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareKeepsakeCardComp"))
local var_0_1 = g.core.model.User.fogNightmareData

function FogNightmareKeepsakeCardComp:ctor()
	self._struct = nil
	self._suitStruct = nil
	self._levelCfg = nil
	self._desText = {}

	self.m_effSelect:addEffectSpine({
		anim = "play",
		name = "eff_ui_FogNightmare_keepsakeSelect"
	})
	self.m_switchTransition:setHook("change", handler(self, self._onSwitchDetail))
	self.m_baseIcon:setVisible(false)
	self.m_btnDetail:addEventListener(fgui.UIEventType.Click, handler(self, self._onSwitch))
	self.m_desList:setIniter(self)
	self.m_desList:setItemRenderer(handler(self, self._onDesItemRender))
	self.m_suitBgIcon:addClickListener(handler(self, self._onClickSuitIcon))
end

function FogNightmareKeepsakeCardComp:updateViewByStruct(arg_2_1)
	self._struct = arg_2_1

	self.m_detailController:setSelectedIndex(0)

	self._cfg = self._struct:getCfg()
	self._attr = self._struct:getAttr()
	self._baseInfo = self._struct:getBaseInfo()
	self._suitStruct = var_0_1:getKeepsakeData():getSuitInfo(self._baseInfo.suit_id)

	self.m_attrList:setVirtual(self)
	self.m_attrList:setItemRenderer(handler(self, self._onAttrListItemRender))
	self.m_attrList:doFairyBatching(false)
	self:_updateView()
end

function FogNightmareKeepsakeCardComp:updateKnightBySid(arg_3_1)
	self.m_stateComp:setVisible(false)

	local var_3_0 = 0

	self._knightStruct = var_0_1:getFormationData():getKnightByServerId(arg_3_1)

	if self._knightStruct then
		self.m_baseIcon:setVisible(true)
		self.m_baseIcon:updateIcon({
			struct = self._knightStruct
		})

		var_3_0 = var_0_1:getCurKeepsakePowerDelta(arg_3_1, self._struct:getCfg().id)

		self.m_stateComp:updateStateComp(self._knightStruct)
		self.m_stateComp:setVisible(true)
	end

	if var_3_0 > 0 then
		self.m_powerStateController:setSelectedIndex(2)
	elseif var_3_0 < 0 then
		self.m_powerStateController:setSelectedIndex(1)
	else
		self.m_powerStateController:setSelectedIndex(0)
	end
end

function FogNightmareKeepsakeCardComp:updateKnightByStruct(arg_4_1)
	if arg_4_1 then
		self.m_baseIcon:setVisible(true)
		self.m_baseIcon:updateIcon({
			struct = arg_4_1
		})
	end
end

function FogNightmareKeepsakeCardComp:_updateView()
	self.m_typeController:setSelectedIndex(self._baseInfo.type - 1)
	self.m_name:setText(self._baseInfo.seal_name)

	self._desText = {}
	self._desText[1] = g.core.lang:getByString(self._cfg.des, {
		param1 = self._cfg.des_param_1,
		param2 = self._cfg.des_param_2,
		param3 = self._cfg.des_param_3
	})

	self.m_power:setText(self._cfg.power)
	self.m_keepsakeIcon:setURL(g.core.common.Path:getFogNightmareKeepsakePicRes(self._baseInfo.seal_icon))
	self.m_txtLv:setText(g.core.lang:get(100535, {
		lv = self._cfg.level
	}))
	self.m_attrList:setNumItems(#self._attr)

	if self._suitStruct then
		self:_updateSuitUI()
		self.m_hasSuitController:setSelectedIndex(1)
	else
		self.m_hasSuitController:setSelectedIndex(0)
	end

	self.m_desList:setNumItems(#self._desText)
end

function FogNightmareKeepsakeCardComp:_onDesItemRender(arg_6_1, arg_6_2)
	local var_6_0 = 0
	local var_6_1 = arg_6_2:getChild("title")

	if arg_6_1 == 1 then
		arg_6_2:setCtrlState("showSplitLine", {
			index = 1
		})

		var_6_0 = var_6_1:getPosition().y
	end

	arg_6_2:setText(self._desText[arg_6_1 + 1])

	local var_6_2 = arg_6_2:getSize()

	var_6_2.height = var_6_1:getSize().height + var_6_0

	arg_6_2:setSize(var_6_2)
end

function FogNightmareKeepsakeCardComp:_updateSuitUI()
	self.m_suitIcon:setURL(g.core.common.Path:getFogNightmareKeepsakeSuitPicRes(self._suitStruct:getCfg().icon))
	self.m_suitNameText:setText(g.core.lang:get(500235, {
		name = self._suitStruct:getCfg().name,
		activeNum = self._suitStruct:getActiveKeepsakeNum(),
		max = self._suitStruct:getEffectInfoByIndex(self._suitStruct:getActiveNum() + 1).targetNum
	}))
end

function FogNightmareKeepsakeCardComp:_onSwitch()
	self.m_switchTransition:play()
end

function FogNightmareKeepsakeCardComp:_onSwitchDetail()
	if self.m_detailController:getSelectedIndex() == 0 then
		self.m_detailController:setSelectedIndex(1)
	else
		self.m_detailController:setSelectedIndex(0)
	end
end

function FogNightmareKeepsakeCardComp:_onAttrListItemRender(arg_10_1, arg_10_2)
	arg_10_2:updateAttr({
		type = self._attr[arg_10_1 + 1].key,
		value = self._attr[arg_10_1 + 1].value
	})
end

function FogNightmareKeepsakeCardComp:_onClickSuitIcon()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.keepsake.FogNightmareKeepsakeSuitInfoPop").new({
		suitInfo = self._suitStruct
	}), {
		touchDisappear = true
	})
end

return FogNightmareKeepsakeCardComp

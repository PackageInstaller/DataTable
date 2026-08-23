local SpireChallengeLineUp = class("SpireChallengeLineUp", require("app.fairyGUI.spire.UI_SpireChallengeLineUp"))

function SpireChallengeLineUp:ctor()
	self._formationType = nil
	self._isPassAll = false
	self._knightList = {}

	self:_initLineUpComp()
end

function SpireChallengeLineUp:_initLineUpComp()
	self.m_lineUpList:setVirtual(self)
	self.m_lineUpList:setItemRenderer(handler(self, self._onRenderLineUpItem))
	self.m_lineUpList:doFairyBatching(false)
	self.m_lineUpBtn:addClickListener(handler(self, self._onClickedLineUpBtn))
	self:addClickListener(handler(self, self._onClickedLineUpBtn))
end

function SpireChallengeLineUp:_onRenderLineUpItem(arg_3_1, arg_3_2)
	arg_3_2:updateLineIcon((self._knightList[arg_3_1 + 1] and self._knightList[arg_3_1 + 1] ~= 0 or nil) and {
		sid = self._knightList[arg_3_1 + 1]
	}, arg_3_1 + 1)
end

function SpireChallengeLineUp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.MUL_CHANGE_ALL, self._onLineUpChanged, self)
end

function SpireChallengeLineUp:updateLineUpComp(arg_5_1, arg_5_2, arg_5_3)
	self._formationType = arg_5_1
	self._isPassAll = arg_5_2
	self._towerCfg = arg_5_3
	self._knightList = g.core.model.User.mulFormationData:getFormationStruct(arg_5_1, 1):getKnightSidArr()

	self.m_lineUpList:setNumItems(#self._knightList)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_lineUpBtn,
		customData = {
			formationType = self._formationType
		}
	})
	self:_updateElementBuff()
end

function SpireChallengeLineUp:_updateElementBuff()
	if not self._towerCfg or self._towerCfg.element_buff_show ~= 1 then
		self.m_buffCountController:setSelectedIndex(0)

		return
	end

	local var_6_0 = self._towerCfg.element_buff_1
	local var_6_1 = self._towerCfg.element_buff_2

	self.m_buffCountController:setSelectedIndex((self._towerCfg.element_buff_1 > 0 and 1 or 0) + (self._towerCfg.element_buff_2 > 0 and 1 or 0))

	if var_6_0 > 0 then
		self.m_buffType1Controller:setSelectedIndex(var_6_0)
	end

	if var_6_1 > 0 then
		self.m_buffType2Controller:setSelectedIndex(var_6_1)
	end
end

function SpireChallengeLineUp:_onLineUpChanged()
	self:updateLineUpComp(self._formationType, self._isPassAll, self._towerCfg)
end

function SpireChallengeLineUp:_onClickedLineUpBtn()
	if self._isPassAll then
		g.core.module.ModuleManager:tip(g.core.lang:get(432020))

		return
	end

	if g.core.model.User.spireData:getCurStage() == g.core.const.ConstMgr.SpireConst.STAGE.SHOW_RESULT then
		g.core.module.ModuleManager:tip(g.core.lang:get(432035))

		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.SPIRE_FORMATION_LAYER, {
		formationType = self._formationType
	})
end

function SpireChallengeLineUp:setListVisible(arg_9_1)
	self.m_lineUpList:setVisible(arg_9_1)
end

return SpireChallengeLineUp

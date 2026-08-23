local var_0_0 = g.core.model.User.userBackData
local SummonRightComp = class("SummonRightComp", require("app.fairyGUI.summonOldPlayer.UI_SummonRightComp"))

function SummonRightComp:ctor()
	var_0_0:initCfgData()

	self._giftCfgData = var_0_0:getGiftCfgData()
	self._signCfgData = var_0_0:getSignCfgData()

	self:_initView()
end

function SummonRightComp:_initView()
	self.m_backBtn:addClickListener(handler(self, self.onBackBtnClick))
	self.m_giftList:setVirtual()
	self.m_giftList:setItemRenderer(handler(self, self._onGiftRender))
	self.m_giftList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onItemClick))
	self.m_signList:setVirtual()
	self.m_signList:setItemRenderer(handler(self, self._onSignRender))
	self.m_giftList:setNumItems(#self._giftCfgData)
	self.m_signList:setNumItems(#self._signCfgData)
end

function SummonRightComp:setParent(arg_3_1)
	self._parent = arg_3_1
end

function SummonRightComp:_onItemClick()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.USER_BACK) and g.core.model.User.userBackData:showEntrance() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.USER_BACK, {
			selIndex = 1
		})
	end
end

function SummonRightComp:onBackBtnClick()
	self._parent:closeSummonPnl()
end

function SummonRightComp:_onGiftRender(arg_6_1, arg_6_2)
	arg_6_2:updateSummonGiftCell(self._giftCfgData[arg_6_1 + 1])
end

function SummonRightComp:_onSignRender(arg_7_1, arg_7_2)
	arg_7_2:updateSummonSignCell(self._signCfgData[arg_7_1 + 1])
end

return SummonRightComp

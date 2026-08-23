local var_0_0 = g.core.const.ConstMgr.FormationConst
local KnightOneKeyConfirmPop = class("KnightOneKeyConfirmPop", require("app.fairyGUI.knightBag.UI_KnightOneKeyConfirmPop"), function()
	return fgui.GComponent:create({
		resName = "KnightOneKeyConfirmPop",
		pkgPath = "ui/knightBag/knightBag",
		pkgName = "knightBag"
	})
end)

function KnightOneKeyConfirmPop:ctor(arg_2_1)
	self:showAtCenter()

	self._index = arg_2_1.index
	self._notOwnKnightData = arg_2_1.notOwnKnightData
	self._confirmCallBack = arg_2_1.confirmCallBack

	self.m_cancelBtn:addClickListener(handler(self, self._onClickCancelBtn))
	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirmBtn))
	self.m_notOwnList:setVirtual()
	self.m_notOwnList:doFairyBatching(false)
	self.m_notOwnList:setItemRenderer(handler(self, self._onNotOwnRenderer))
	self.m_notOwnList:setNumItems(#self._notOwnKnightData)
	self.m_isMainTeamController:setSelectedIndex(self._index == var_0_0.MAIN_FORMATION_INDEX and 1 or 0)
end

function KnightOneKeyConfirmPop:_onClickCancelBtn()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function KnightOneKeyConfirmPop:_onClickConfirmBtn()
	if self._confirmCallBack then
		self._confirmCallBack(self._index)
	end

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function KnightOneKeyConfirmPop:_onNotOwnRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._notOwnKnightData[arg_5_1 + 1].id, self._notOwnKnightData[arg_5_1 + 1].pos)
end

return KnightOneKeyConfirmPop

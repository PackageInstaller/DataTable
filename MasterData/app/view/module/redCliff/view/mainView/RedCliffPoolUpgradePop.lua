local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.network.GameNetProxy
local var_0_3 = g.core.model.User.redCliffData
local RedCliffPoolUpgradePop = class("RedCliffPoolUpgradePop", require("app.fairyGUI.redCliff.UI_RedCliffStageUpgradePop"), function()
	return fgui.GComponent:create({
		resName = "RedCliffStageUpgradePop",
		pkgPath = "ui/redCliff/redCliff",
		pkgName = "redCliff"
	})
end)

function RedCliffPoolUpgradePop:ctor(arg_2_1)
	self:showAtCenter()

	self._poolId = arg_2_1.poolId
	self._successList = {}
	self._failList = {}
	self._failIndex = 1

	self.m_resultTxt:setVisible(false)
	self.m_closeBg:addClickListener(handler(self, self._onClickBg))
	self.m_successList:setVirtual()
	self.m_successList:setItemRenderer(handler(self, self._onRenderSuccessList))
	self.m_failList:setVirtual()
	self.m_failList:setItemRenderer(handler(self, self._onRenderFailList))
end

function RedCliffPoolUpgradePop:_onRenderSuccessList(arg_3_1, arg_3_2)
	arg_3_2:updateSuccessCell(self._successList[arg_3_1 + 1], arg_3_1)
end

function RedCliffPoolUpgradePop:_onRenderFailList(arg_4_1, arg_4_2)
	arg_4_2:updateFailCell(self._failList[arg_4_1 + 1], arg_4_1, self._failIndex)
end

function RedCliffPoolUpgradePop:_onRcvPromotionList(arg_5_1, arg_5_2, arg_5_3)
	self._successList = var_0_3:getSuccessList(self._poolId)
	self._failList = var_0_3:getFailList(self._poolId)
	self._failIndex = #self._successList + 1

	self.m_successList:setNumItems(#self._successList)
	self.m_failList:setNumItems(#self._failList)
	self.m_successNone:setVisible(#self._successList == 0)
	self.m_failNone:setVisible(#self._failList == 0)
end

function RedCliffPoolUpgradePop:onLoad()
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_CHI_BI_GETPROMOTIONLIST, self._onRcvPromotionList, self)
	var_0_2:send_C2S_ChiBi_GetPromotionList({
		pool_id = self._poolId
	})
	self.m_enterTransition:play()
end

function RedCliffPoolUpgradePop:onUnload()
	self.m_backTransition:play()
end

function RedCliffPoolUpgradePop:_onClickBg()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return RedCliffPoolUpgradePop

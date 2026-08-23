local var_0_0 = g.core.model.User.redCliffData
local RedCliffStageUpgradePop = class("RedCliffStageUpgradePop", require("app.fairyGUI.redCliff.UI_RedCliffStageUpgradePop"), function()
	return fgui.GComponent:create({
		pkgName = "redCliff",
		resName = "RedCliffStageUpgradePop",
		pkgPath = "ui/redCliff/redCliff"
	})
end)

function RedCliffStageUpgradePop:ctor(arg_2_1)
	self:showAtCenter()

	self._poolId = arg_2_1.poolId or var_0_0:getMyPoolId()

	self.m_closeBg:addClickListener(handler(self, self._onClose))
	self.m_successList:setVirtual()
	self.m_successList:setItemRenderer(handler(self, self._onRenderSuccessList))
	self.m_failList:setVirtual()
	self.m_failList:setItemRenderer(handler(self, self._onRenderFailList))

	self._successList = var_0_0:getSuccessList(self._poolId)
	self._failList = var_0_0:getFailList(self._poolId)
	self._failIndex = #self._successList + 1

	self.m_successList:setNumItems(#self._successList)
	self.m_failList:setNumItems(#self._failList)
	self.m_successNone:setVisible(#self._successList == 0)
	self.m_failNone:setVisible(#self._failList == 0)
	self.m_isUpgradeController:setSelectedIndex(var_0_0:isPromote() and 1 or 0)
end

function RedCliffStageUpgradePop:_onRenderSuccessList(arg_3_1, arg_3_2)
	arg_3_2:updateSuccessCell(self._successList[arg_3_1 + 1], arg_3_1)
end

function RedCliffStageUpgradePop:_onRenderFailList(arg_4_1, arg_4_2)
	arg_4_2:updateFailCell(self._failList[arg_4_1 + 1], arg_4_1, self._failIndex)
end

function RedCliffStageUpgradePop:_isMyselfUpgrade()
	local var_5_0 = g.core.model.User:getId()

	for iter_5_0, iter_5_1 in ipairs(self._successList) do
		if iter_5_1.id == var_5_0 then
			return true
		end
	end

	return false
end

function RedCliffStageUpgradePop:_onClose()
	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.RED_CLIFF_MAIN_LAYER)
end

function RedCliffStageUpgradePop:onLoad()
	self.m_enterTransition:play()
end

function RedCliffStageUpgradePop:onUnload()
	self.m_backTransition:play()
end

return RedCliffStageUpgradePop

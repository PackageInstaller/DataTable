local var_0_0 = g.core.model.User.userBackData
local SummonOldPlayerPop = class("SummonOldPlayerPop", require("app.fairyGUI.summonOldPlayer.UI_SummonOldPlayerPop"), function()
	return fgui.GComponent:create({
		resName = "SummonOldPlayerPop",
		pkgName = "summonOldPlayer",
		pkgPath = "ui/summonOldPlayer/summonOldPlayer"
	}, ...)
end)

function SummonOldPlayerPop:ctor()
	var_0_0:initCfgData()

	self._giftCfgData = var_0_0:getGiftCfgData()
	self._signCfgData = var_0_0:getSignCfgData()

	self:showAtCenter()
	self.m_leftComp:setParent(self)
	self.m_rightComp:setParent(self)
	self.m_closePnl:addClickListener(handler(self, self.closeSummonPnl))

	if #self._signCfgData == 0 then
		self.m_hasGiftController:setSelectedIndex(1)
	end

	self.m_enterTransition:play()
end

function SummonOldPlayerPop:closeSummonPnl()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return SummonOldPlayerPop

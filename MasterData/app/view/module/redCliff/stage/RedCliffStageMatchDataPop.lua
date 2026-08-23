local var_0_0 = g.core.model.User.redCliffData
local RedCliffStageMatchDataPop = class("RedCliffStageMatchDataPop", require("app.fairyGUI.redCliff.UI_RedCliffStageMatchDataPop"), function()
	return fgui.GComponent:create({
		resName = "RedCliffStageMatchDataPop",
		pkgPath = "ui/redCliff/redCliff",
		pkgName = "redCliff"
	})
end)

function RedCliffStageMatchDataPop:ctor()
	self:showAtCenter()

	self._playerList = {}

	self.m_playerList:setVirtual()
	self.m_playerList:setItemRenderer(handler(self, self._onRenderPlayerList))
	self.m_closeBg:addClickListener(handler(self, self._onClose))

	self._playerList = var_0_0:getMatchEndRankList()

	self.m_playerList:setNumItems(#self._playerList)
end

function RedCliffStageMatchDataPop:_onRenderPlayerList(arg_3_1, arg_3_2)
	self._playerList[arg_3_1 + 1].avata_id = self._playerList[arg_3_1 + 1].avatar_id

	arg_3_2:updateDataCell(self._playerList[arg_3_1 + 1], arg_3_1)
end

function RedCliffStageMatchDataPop:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function RedCliffStageMatchDataPop:onLoad()
	self.m_enterTransition:play()
end

function RedCliffStageMatchDataPop:onUnload()
	self.m_backTransition:play()

	if var_0_0:hasNotifyPromotion() then
		self:dispatchCompEvent("open_upgrade_list")
	else
		self:dispatchCompEvent("leave_game")
	end
end

return RedCliffStageMatchDataPop

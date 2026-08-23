local ExplorationMiniDetailPop = class("ExplorationMiniDetailPop", require("app.fairyGUI.exploration.UI_ExplorationMiniDetailPop"), function()
	return fgui.GComponent:create({
		resName = "ExplorationMiniDetailPop",
		pkgName = "exploration",
		isFullScreen = true,
		pkgPath = "ui/exploration/exploration"
	})
end)

function ExplorationMiniDetailPop:ctor()
	self:showAtCenter()

	self._lineComp = self.m_roomMapComp:getChild("lineComp")
	self._topComp = self.m_roomMapComp:getChild("topComp")

	self.m_enterTransition:play()
	self.m_mapEnterEffect:addEffectSpine({
		isLoop = false,
		remove = true,
		name = "eff_ui_explorationMap_enter",
		anim = "play"
	})
end

function ExplorationMiniDetailPop:onFollowFunc(arg_3_1)
	self._lineComp:setRootPos(arg_3_1)
	self._topComp:setRootPos(arg_3_1)
end

function ExplorationMiniDetailPop:onLoad()
	local var_4_0 = self.m_roomMapComp:getChild("mapComp")

	var_4_0:updateRoomComp()
	var_4_0:addFollowFunc(handler(self, self.onFollowFunc))
	self._lineComp:updateRoomComp()
	self._topComp:setEffectEnable(true)
	self._topComp:updateRoomComp()
end

function ExplorationMiniDetailPop:onCancelCallback()
	self.m_backTransition:play(handler(self, self._closeCompView))
end

function ExplorationMiniDetailPop:_closeCompView()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return ExplorationMiniDetailPop

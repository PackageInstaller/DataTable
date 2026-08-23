local var_0_0 = g.core.model.User.fogNightmareData
local FogNightmareExploreEnterLayer = class("FogNightmareExploreEnterLayer", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreEnterLayer"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareExploreEnterLayer",
		pkgName = "fogNightmare",
		isFullScreen = true,
		pkgPath = "ui/fogNightmare/fogNightmare"
	}, ...)
end)

function FogNightmareExploreEnterLayer:ctor()
	self:_initView()
end

function FogNightmareExploreEnterLayer:_initView()
	self:addBg("bg/fogNightmare/bg_wjmy_main.jpg")
	self.m_startBtn:addClickListener(handler(self, self._onStartBtnClicked))
end

function FogNightmareExploreEnterLayer:onLoad()
	return
end

function FogNightmareExploreEnterLayer:updateView()
	local var_5_0 = var_0_0:getTowerData():getFastFloors()

	if #var_5_0 > 0 then
		self:updateBtn(var_5_0)
		self.m_canQuickJumpController:setSelectedIndex(1)
	else
		self.m_canQuickJumpController:setSelectedIndex(0)
	end
end

function FogNightmareExploreEnterLayer:_onStartBtnClicked()
	if self.m_canQuickJumpController:getSelectedIndex() == 1 then
		local var_6_1 = self.m_selectComp:getSelectedFloor()
	end

	var_0_0:getFormationData():updateSelectInfos()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareExploreKnightPoolPop").new({
		showBtn = true
	}), {
		touchDisappear = false
	})
end

return FogNightmareExploreEnterLayer

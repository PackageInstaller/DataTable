local TowerChooseMainLayer = class("TowerChooseMainLayer", require("app.fairyGUI.tower.UI_TowerChooseMainLayer"), function()
	return fgui.GComponent:create({
		resName = "TowerChooseMainLayer",
		pkgPath = "ui/tower/tower",
		isFullScreen = true,
		pkgName = "tower"
	}, ...)
end)
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.const.ConstMgr.TowerConst

function TowerChooseMainLayer:ctor(arg_2_1)
	self:addBg("bg/tower/bg_yzts_leixing.jpg")
	self.m_topBar:setResInfoById(302)
	self.m_topBar:setDefaultResNum(0)
	self.m_enterComp1:addClickListener(handler(self, self._onClickComp1))
	self.m_enterComp2:addClickListener(handler(self, self._onClickComp2))
end

function TowerChooseMainLayer:onLoad()
	self.m_enterTransition:play()
	self:_updateView()
end

function TowerChooseMainLayer:receiveCompEvent(arg_4_1, arg_4_2)
	arg_4_2 = arg_4_2 or {}
end

function TowerChooseMainLayer:onUnload()
	return
end

function TowerChooseMainLayer:_updateView()
	self.m_enterComp1:update(var_0_2.TOWER_DIFFICULTY.NORMAL)
	self.m_enterComp2:update(var_0_2.TOWER_DIFFICULTY.HARD)
end

function TowerChooseMainLayer:_onClickComp1()
	var_0_1:pushModule(g.view.entrance.TOWER, {
		towerType = var_0_2.TOWER_DIFFICULTY.NORMAL
	})
end

function TowerChooseMainLayer:_onClickComp2()
	var_0_1:pushModule(g.view.entrance.TOWER_HARD, {
		towerType = var_0_2.TOWER_DIFFICULTY.HARD
	})
end

return TowerChooseMainLayer

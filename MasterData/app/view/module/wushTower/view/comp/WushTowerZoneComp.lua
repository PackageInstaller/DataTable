local var_0_0 = g.core.const.ConstMgr.WushTowerConst
local var_0_1 = g.core.model.User.wushTowerData
local WushTowerZoneComp = class("WushTowerZoneComp", require("app.fairyGUI.wushTower.UI_WushTowerZoneComp"))

function WushTowerZoneComp:onLoad()
	self:playEnterTransition()
end

function WushTowerZoneComp:updateZoneStageInfo(arg_2_1)
	local var_2_0 = var_0_1:isPrePassParcel()

	for iter_2_0 = 1, var_0_0.WUSH_TOWER_STAGE_COUNT do
		self["m_stageComp" .. iter_2_0]:updateStageComp(iter_2_0, var_2_0, arg_2_1)
	end

	self:_updateLineComp()
end

function WushTowerZoneComp:_updateLineComp()
	for iter_3_0 = 1, #var_0_0.WUSH_TOWER_LINE_ARRAY do
		self["m_" .. var_0_0.WUSH_TOWER_LINE_ARRAY[iter_3_0]]:getController("canMove"):setSelectedIndex(0)
	end

	local var_3_0 = var_0_1:getCanMoveParcels()
	local var_3_1 = var_0_1:getLastPassParcel()

	for iter_3_1 = 1, #var_3_0 do
		self["m_line" .. var_3_1 .. "_" .. var_3_0[iter_3_1]]:getController("canMove"):setSelectedIndex(1)
	end
end

function WushTowerZoneComp:playEnterTransition()
	self.m_enterTransition:play()
end

function WushTowerZoneComp:playBossPassTransition(arg_5_1)
	for iter_5_0 = 1, #var_0_0.WUSH_TOWER_LINE_ARRAY do
		self["m_" .. var_0_0.WUSH_TOWER_LINE_ARRAY[iter_5_0]]:getController("canMove"):setSelectedIndex(0)
	end

	self["m_stageComp" .. var_0_0.WUSH_TOWER_STAGE_COUNT]:updateStageComp(var_0_0.WUSH_TOWER_STAGE_COUNT)
	self["m_stageComp" .. var_0_0.WUSH_TOWER_STAGE_COUNT]:playEffDone(arg_5_1)
end

return WushTowerZoneComp

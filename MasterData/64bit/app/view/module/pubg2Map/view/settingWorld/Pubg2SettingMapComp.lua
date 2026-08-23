local var_0_0 = g.core.const.ConstMgr.PubgConst.fsm
local var_0_1 = g.core.model.User.pubgData
local var_0_2
local Pubg2SettingMapWorld = require("app.view.module.pubg2Map.view.settingWorld.Pubg2SettingMapWorld")
local Pubg2SettingMapComp = class("Pubg2SettingMapComp", require("app.fairyGUI.pubg.UI_Pubg2SettingMapComp"))

function Pubg2SettingMapComp:ctor()
	var_0_2 = var_0_1:getMapData()
	self._stage = nil
	self._isSettingPoint = false
	self._isSelectObstacle = false
	self._curModelIndex = 0

	self.m_modelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onModelChanged))
	self.m_debugSettingModel:addClickListener(handler(self, self._onClickDebugSettingModel))
	self.m_debugCtrlModel:addClickListener(handler(self, self._onClickDebugCtrlModel))
	self.m_setObstaclePoint:addClickListener(handler(self, self._onClickSetObstaclePoint))
	self.m_selectObstacle:addClickListener(handler(self, self._onClickSelectObstacle))
	self.m_delaunayBtn:addClickListener(handler(self, self._onClickDelaunay))
	self.m_exportObstacle:addClickListener(handler(self, self._onClickExportObstacle))
	self.m_importObstacle:addClickListener(handler(self, self._onClickImportObstacle))
end

function Pubg2SettingMapComp:_onModelChanged()
	self:getFloorComp():changeObstacleModel(self._curModelIndex ~= 0)
end

function Pubg2SettingMapComp:_onClickDebugSettingModel()
	self._curModelIndex = self._curModelIndex ~= 1 and 1 or 0

	self.m_modelController:setSelectedIndex(self._curModelIndex)
end

function Pubg2SettingMapComp:_onClickDebugCtrlModel()
	self._curModelIndex = self._curModelIndex ~= 2 and 2 or 0

	self.m_modelController:setSelectedIndex(self._curModelIndex)
end

function Pubg2SettingMapComp:_onClickExportObstacle()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		desc = "确定保存当前设置，覆盖旧的数据吗",
		title = g.core.lang:get(1257),
		onConfirm = handler(self, self.saveObstacleData)
	}))
end

function Pubg2SettingMapComp:_onClickImportObstacle()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		desc = "确定放弃当前设置，加载保存数据吗",
		title = g.core.lang:get(1257),
		onConfirm = handler(self, self.reloadObstacleData)
	}))
end

function Pubg2SettingMapComp:reloadObstacleData()
	self.m_floorComp:reloadObstacleData()
end

function Pubg2SettingMapComp:saveObstacleData()
	self.m_floorComp:saveObstacleData()
end

function Pubg2SettingMapComp:_onClickDelaunay()
	self:getFloorComp():delaunayTriangle()
end

function Pubg2SettingMapComp:_onClickSelectObstacle()
	self._isSelectObstacle = self.m_selectObstacle:isSelected()

	if self._isSettingPoint then
		self._isSettingPoint = false

		self.m_setObstaclePoint:setSelected(self._isSettingPoint)
	end
end

function Pubg2SettingMapComp:_onClickSetObstaclePoint()
	self._isSettingPoint = self.m_setObstaclePoint:isSelected()

	if self._isSelectObstacle then
		self._isSelectObstacle = false

		self.m_selectObstacle:setSelected(self._isSelectObstacle)
	end
end

function Pubg2SettingMapComp:setStage(arg_12_1)
	self._stage = arg_12_1

	self:_initTiledMap()
	self.m_floorComp:loadConfig(1, self:getMapWorld():getMapGround():getMapWidth(), (self:getMapWorld():getMapGround():getMapHeight()))

	local var_12_0 = self:getFloorComp():getMyCompPos()

	self:getMapWorld():setFollowCenter(cc.p(var_12_0.x, -var_12_0.y))
end

function Pubg2SettingMapComp:_initTiledMap()
	self._mapWorld = Pubg2SettingMapWorld.new(self, 1)

	self._mapWorld:startObserver(self.m_touchMap)
	self.m_tiledHolder:addNode(self._mapWorld)
end

function Pubg2SettingMapComp:getMapWorld()
	return self._mapWorld
end

function Pubg2SettingMapComp:moveToPoint(arg_15_1, arg_15_2)
	self._mapWorld:movePA2SC({
		x = arg_15_1,
		y = arg_15_2
	})
	self:onMapMoveEnd()
end

function Pubg2SettingMapComp:getScreenCenterPoint()
	local var_16_0 = self:getMapWorld():convertToNodeSpace({
		x = display.cx,
		y = display.cy
	})
	local var_16_1, var_16_2 = self:getMapWorld():getMapGround():pixelToCoord(var_16_0.x, var_16_0.y)

	return {
		x = var_16_1,
		y = var_16_2
	}
end

function Pubg2SettingMapComp:onMapMoveEnd()
	return
end

function Pubg2SettingMapComp:updatePlayerIcon()
	local var_18_0, var_18_1 = var_0_2:getMyPos()
	local var_18_2, var_18_3 = self:getMapWorld():getMapGround():coordToPixel(var_18_0, var_18_1)

	return self._stage:updatePlayerIcon(self:getMapWorld():convertToNodeSpace({
		x = display.cx,
		y = display.cy
	}), {
		x = var_18_2,
		y = var_18_3
	})
end

function Pubg2SettingMapComp:updateFloorCompPos(arg_19_1, arg_19_2)
	self.m_floorComp:setPosition(arg_19_1 + display.cx, arg_19_2 + display.cy)
	self.m_floorComp:updateCurPos(-arg_19_1, -arg_19_2)
end

function Pubg2SettingMapComp:getFloorComp()
	return self.m_floorComp
end

function Pubg2SettingMapComp:userMove()
	if not var_0_2:checkInMapTime() then
		return
	end

	local var_21_0 = var_0_2:getMyUser()

	if var_21_0 then
		local var_21_1 = var_21_0:getMovingPos()

		if var_21_1 and not var_21_0:isDead() then
			g.core.network.GameNetProxy:send_C2S_Pubg_Move({
				x = var_21_1.x,
				y = var_21_1.y
			})
		end
	end
end

function Pubg2SettingMapComp:tickMapUpdate(arg_22_1)
	if self._stage then
		self:getFloorComp():tickUpdate()

		if arg_22_1 then
			local var_22_0 = self:getFloorComp():getMyCompPos()

			self:getMapWorld():setFollowCenter(cc.p(var_22_0.x, -var_22_0.y))
		end

		self:getMapWorld():tickUpdate(var_0_0.Time.deltaT * 0.001)
		self.m_pointCount:setText("点数量" .. self:getFloorComp():getPointCount())
		self.m_triangleCount:setText("三角形数量" .. self:getFloorComp():getTriangleCount())
	end
end

function Pubg2SettingMapComp:worldClickPoint(arg_23_1)
	if self._isSettingPoint then
		self:getFloorComp():checkSettingPoint(arg_23_1)
	elseif self._isSelectObstacle then
		self:getFloorComp():checkSettingObstacleTriangle(arg_23_1)
	end
end

return Pubg2SettingMapComp

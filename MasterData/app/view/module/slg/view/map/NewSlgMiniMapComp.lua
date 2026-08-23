local NewSlgMiniMapComp = class("NewSlgMiniMapComp", require("app.fairyGUI.newSlg.UI_NewSlgMiniMapComp"))
local TileMapFunc = require("app.core.tilemap.TileMapFunc")

function NewSlgMiniMapComp:ctor()
	g.core.model.User.newSlgData:initMapInfo()

	self._imgMap = self:getChild("Img_map")
	self._imgMap2 = self:getChild("Img_map2")
	self._imgMap3 = self:getChild("Img_map3")
	self._imgMap4 = self:getChild("Img_map4")
	self._effHolder = self:getChild("eff")
	self._mapSize = nil
	self._scale = 1
	self._campScale = 1
	self._offset = {
		x = 0,
		y = 0
	}
	self._mapPos = nil
	self._movePos = nil
	self._closeBuildTouch = false
	self._hideMapCtrl = self:getController("hide_map")
	self._myBuildComp = nil

	self:_initMapSize()

	self._objectMap = {}

	self:addClickListener(handler(self, self._onClick))

	if self._effHolder then
		self._effHolder:addEffectSpine({
			remove = true,
			name = "eff_ui_newSlg_mapLine",
			isLoop = false
		})
	end
end

function NewSlgMiniMapComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_MOVEHOME, handler(self, self._onRcvMoveHome), self)
end

function NewSlgMiniMapComp:enableMap()
	if g.core.model.User.newSlgData:getSName() == "S2" then
		self._imgMap:setURL("ui://newSlg/pic_map_S2_01")
		self._imgMap2:setURL("ui://newSlg/pic_map_S2_02")
		self._imgMap3:setURL("ui://newSlg/pic_map_S2_03")
		self._imgMap4:setURL("ui://newSlg/pic_map_S2_04")
	else
		self._imgMap:setURL("ui://newSlg/mini_map")
	end
end

function NewSlgMiniMapComp:initMapParams(arg_4_1)
	self._scale = arg_4_1.scale or 1
	self._campScale = arg_4_1.campScale or 1
	self._offset = arg_4_1.offset or {
		x = 0,
		y = 0
	}
	self._closeBuildTouch = arg_4_1.closeBuildTouch

	self._hideMapCtrl:setSelectedIndex(arg_4_1.isHideBg and 1 or 0)
	self._imgMap:setOpacity(arg_4_1.opacity or 255)

	if self._imgMap2 then
		self._imgMap2:setOpacity(arg_4_1.opacity or 255)
	end

	if self._imgMap3 then
		self._imgMap3:setOpacity(arg_4_1.opacity or 255)
	end

	if self._imgMap4 then
		self._imgMap4:setOpacity(arg_4_1.opacity or 255)
	end

	if self:getChild("Group_name") then
		self:getChild("Group_name"):setVisible(not arg_4_1.closeName)
	end
end

function NewSlgMiniMapComp:move(arg_5_1)
	self._mapPos = arg_5_1.pos
	self._mapRcPos = arg_5_1.rcPos

	self:setScale(self._scale)
	self:_setPos()
end

function NewSlgMiniMapComp:_setPos()
	local var_6_0

	if self._mapPos then
		var_6_0 = self:_getMiniMapPosByPos(self._mapPos)
	elseif self._mapRcPos then
		var_6_0 = self:_getMiniMapPosByPos(self._mapRcPos)
	end

	if var_6_0 then
		local var_6_1 = cc.p(-var_6_0.x * self._scale + self._offset.x, -var_6_0.y * self._scale + self._offset.y)

		if self._movePos == nil then
			self._movePos = var_6_1
		elseif self._movePos.x ~= var_6_1.x or self._movePos.y ~= var_6_1.y then
			self._movePos = var_6_1
		else
			return
		end

		self:setPosition(self._movePos)
	end
end

function NewSlgMiniMapComp:_initMapSize()
	local var_7_0 = TileMapFunc.getConstShowNum() * TileMapFunc.getConstIncludeNum()

	self._mapSize = cc.size(var_7_0 * TileMapFunc.getUnitCellWidth(), var_7_0 * TileMapFunc.getUnitCellHeight())
end

function NewSlgMiniMapComp:_getMiniMapPosByRc(arg_8_1)
	local var_8_0, var_8_1 = TileMapFunc.rc2p(arg_8_1.x, arg_8_1.y)

	return self:_getMiniMapPosByPos(cc.p(var_8_0, var_8_1))
end

function NewSlgMiniMapComp:_getMiniMapPosByPos(arg_9_1)
	local var_9_0 = self:getHeight()

	return cc.p(math.floor(arg_9_1.x * (self:getWidth() / self._mapSize.width)), var_9_0 - math.floor(arg_9_1.y * (var_9_0 / self._mapSize.height)))
end

function NewSlgMiniMapComp:updateView()
	self:_initBuild()
end

function NewSlgMiniMapComp:_updateMyPos()
	return
end

function NewSlgMiniMapComp:_initBuild()
	self:_createGateCompArr()
	self:_createCityCompArr()
	self:_createMyComp()
	self:setChildIndex(self.m_posImg, 998)
end

function NewSlgMiniMapComp:_createMyComp()
	local var_13_0 = g.core.model.User.newSlgData:getMyUserData()
	local var_13_1

	if var_13_0 then
		var_13_1 = var_13_0.pos or cc.p(0, 0)

		if self._myBuildComp then
			self._myBuildComp:removeFromParent()

			self._myBuildComp = nil
		end
	end

	self._myBuildComp = self:_createPointNode(var_13_1, g.core.const.ConstMgr.NewSlgConst.COMP_TYPE.PLAYER_CASTLE, nil)
end

function NewSlgMiniMapComp:_createGateCompArr()
	for iter_14_0, iter_14_1 in ipairs((g.core.model.User.newSlgData:getObjectDataByType(g.core.const.ConstMgr.NewSlgConst.COMP_TYPE.GATE))) do
		self:_createPointNode(iter_14_1.pos, g.core.const.ConstMgr.NewSlgConst.COMP_TYPE.GATE, iter_14_1)
	end
end

function NewSlgMiniMapComp:_createCityCompArr()
	for iter_15_0, iter_15_1 in ipairs((g.core.model.User.newSlgData:getObjectDataByType(g.core.const.ConstMgr.NewSlgConst.COMP_TYPE.CITY))) do
		self:_createPointNode(iter_15_1.pos, g.core.const.ConstMgr.NewSlgConst.COMP_TYPE.CITY, iter_15_1)
	end
end

function NewSlgMiniMapComp:_createPointNode(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = self._objectMap[arg_16_1.x .. "_" .. arg_16_1.y .. "_" .. arg_16_2]

	if not self._objectMap[arg_16_1.x .. "_" .. arg_16_1.y .. "_" .. arg_16_2] then
		var_16_0 = fgui.UIPackage:createObject("newSlg", "NewSlgMiniMapBuildComp")

		var_16_0:setPivot(0.5, 0.5, true)
		var_16_0:setPosition((self:_getMiniMapPosByRc(arg_16_1)))
		var_16_0:setScale(1 / self._scale * self._campScale)
		self:addChildAt(var_16_0, 100)

		if arg_16_3 ~= nil then
			self._objectMap[arg_16_1.x .. "_" .. arg_16_1.y .. "_" .. arg_16_2] = var_16_0
		end
	end

	if arg_16_2 == g.core.const.ConstMgr.NewSlgConst.COMP_TYPE.PLAYER_CASTLE then
		var_16_0:setTouchable(false)
	else
		var_16_0:setTouchable(not self._closeBuildTouch)
	end

	var_16_0:updateView(arg_16_2, arg_16_3)

	return var_16_0
end

function NewSlgMiniMapComp:_onClick(arg_17_1)
	self.m_posImg:setPosition(self:globalToLocal((arg_17_1:getInput():getPosition())))
	self:dispatchCompEvent("NewSlgMiniMapComp_click")
end

function NewSlgMiniMapComp:receiveCompEvent(arg_18_1, arg_18_2)
	if arg_18_1 == "NewSlgMiniMapBuildComp_click" then
		self.m_posImg:setPosition(arg_18_2.comp:getPosition())

		return false
	end
end

function NewSlgMiniMapComp:_onRcvMoveHome()
	self:_createMyComp()
end

return NewSlgMiniMapComp

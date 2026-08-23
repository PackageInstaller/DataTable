local KsMath = require("app.core.utils.KsMath")
local var_0_1 = g.core.event
local HomeLandLayer = class("HomeLandLayer", require("app.fairyGUI.homeLand.UI_HomeLandLayer"), function()
	return fgui.GComponent:create({
		resName = "HomeLandLayer",
		pkgPath = "ui/homeLand/homeLand",
		isFullScreen = true,
		pkgName = "homeLand"
	}, ...)
end)

function HomeLandLayer:ctor(arg_2_1)
	self._offMoveX = 50
	self._beginGL = nil

	self:initHomeLand()
end

function HomeLandLayer:onLoad()
	self:_initRegister()
	self.m_land:startUp(self)
	self.m_touchLand:startListen(self)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_MAP_HOME)
	self:addMovie()
end

function HomeLandLayer:addMovie()
	self.m_movieComp:addCriSprite({
		fullScreenState = 2,
		movieName = "jiayuanSnow_1334x750_6000",
		isLoop = true,
		y = 0,
		moduleName = "homeland",
		x = 0
	})
end

function HomeLandLayer:onUnload()
	self.m_movieComp:removeAllCriSprite()
	self.m_touchLand:startListen(nil)
end

function HomeLandLayer:initHomeLand()
	self:_initHomeLandData()
	self:_initHomeLandUI()
end

function HomeLandLayer:_initHomeLandData()
	return
end

function HomeLandLayer:_initHomeLandUI()
	self.m_topBar:setResInfoById(60)
end

function HomeLandLayer:_initRegister()
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_GETINFO, self._onNetHLTrainInfo, self)
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_NET_S2C_FURNITURE_ROOM_GETINFO, self._onNetGetRoomInfo, self)
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_HOME_LAND_TO_LEFT, self.scrollLandToLeft, self)
end

function HomeLandLayer:onCoverTouchBegan(arg_10_1, arg_10_2)
	self._beginGL = arg_10_1:getLocation()

	return true
end

function HomeLandLayer:onCoverTouchMoved(arg_11_1, arg_11_2)
	self._offMoveX = KsMath.rangeIn(self._offMoveX + arg_11_1:getDelta().x / 10, 0, 100)

	self.m_land:setCurLandPercent(self._offMoveX)
end

function HomeLandLayer:scrollLandToLeft()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.2)
	self.m_land:scrollToLeft()
end

function HomeLandLayer:onCoverTouchEnded(arg_14_1, arg_14_2)
	if self._beginGL == nil then
		return
	end

	local var_14_0 = arg_14_1:getLocation()

	if math.abs(var_14_0.x - self._beginGL.x) + math.abs(var_14_0.y - self._beginGL.y) < 4 then
		self.m_land:checkClickHit(var_14_0)
	end
end

function HomeLandLayer:receiveCompEvent(arg_15_1, arg_15_2)
	if arg_15_1 == "Home_land_percent_change" then
		self._offMoveX = arg_15_2.percent or self._offMoveX
	end
end

function HomeLandLayer:_onNetHLTrainInfo()
	g.core.module.ModuleManager:pushModule(g.view.entrance.HOME_LAND_TRAIN)
end

function HomeLandLayer:_onNetGetRoomInfo()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FURNITURE)
end

return HomeLandLayer

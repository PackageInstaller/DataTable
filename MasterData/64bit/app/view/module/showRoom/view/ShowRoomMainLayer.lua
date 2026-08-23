local var_0_0 = 7
local var_0_1 = g.core.const.ConstMgr
local ShowRoomBtnCfg = require("app.view.module.showRoom.const.ShowRoomBtnCfg")
local var_0_3 = g.core.model.User
local ShowRoomMainLayer = class("ShowRoomMainLayer", require("app.fairyGUI.showRoom.UI_ShowRoomMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "showRoom",
		isFullScreen = true,
		pkgPath = "ui/showRoom/showRoom",
		resName = "ShowRoomMainLayer"
	}, ...)
end)

function ShowRoomMainLayer:ctor()
	self._animSchedulerId = nil

	self:_init()

	self.m_enterTransition = self:getView():getTransition("enter")
	self.m_backTransition = self:getView():getTransition("back")
end

function ShowRoomMainLayer:_init()
	for iter_3_0 = 1, var_0_0 do
		self["m_funcLabel" .. iter_3_0]:setData(ShowRoomBtnCfg[iter_3_0])
	end

	self:addBg("bg/showRoom/bg_cls_zhujiemian.jpg")
end

function ShowRoomMainLayer:onLoad()
	self._animTable = {
		1,
		2,
		3,
		4,
		5,
		6,
		7
	}

	for iter_4_0 = 1, var_0_0 do
		self["m_funcLabel" .. iter_4_0]:playInitAnim()
	end

	self:_playInAnim()
	var_0_3.functionUnlockData:saveUnlockedFunc(var_0_1.FUNCTION_TYPE.HOME_LAND_SHOWROOM)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_FINISH, handler(self, self.checkGuide), self)
end

function ShowRoomMainLayer:_playInAnim()
	self._animSchedulerId = g.core.common.Scheduler:newSchedule(handler(self, self._onAnimPlaying), math.random(4, 7) / 100)
end

function ShowRoomMainLayer:checkGuide()
	if not g.core.guide.GuideProxy:isGuideRunning() then
		if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.HANDBOOK_GUIDE_1) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
				tickType = 6,
				enum = g.core.const.ConstMgr.GuideConst.ENUM_TICK.HANDBOOK_GUIDE
			})
			g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.HANDBOOK_GUIDE_1)
			g.core.model.User.guideData:setGuideTickedFinish(46)
		end
	end
end

function ShowRoomMainLayer:_onAnimPlaying()
	self["m_funcLabel" .. table.remove(self._animTable, (math.random(1, #self._animTable)))]:playEnterAnim()

	if #self._animTable == 0 and self._animSchedulerId then
		g.core.common.Scheduler:cancelSchedule(self._animSchedulerId)

		self._animSchedulerId = nil

		self:checkGuide()
	end
end

function ShowRoomMainLayer:onUnload()
	if self._animSchedulerId then
		g.core.common.Scheduler:cancelSchedule(self._animSchedulerId)

		self._animSchedulerId = nil
	end
end

return ShowRoomMainLayer

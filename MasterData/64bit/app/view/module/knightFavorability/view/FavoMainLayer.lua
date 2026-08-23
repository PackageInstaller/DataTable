local var_0_1 = g.core.model.User
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_4 = g.core.model.User.knightFavoData
local FavoMainLayer = class("FavoMainLayer", require("app.fairyGUI.knightFavorability.UI_FavoMainLayer"), function()
	return fgui.GComponent:create({
		resName = "FavoMainLayer",
		pkgName = "knightFavorability",
		isFullScreen = true,
		pkgPath = "ui/knightFavorability/knightFavorability"
	}, ...)
end)

function FavoMainLayer:ctor(arg_2_1)
	self:addBg("bg/knightFavorability/bg_wenquanlvguan.jpg")
	self:_initMainLayer()
end

function FavoMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_FAVORABILITY_INFO, handler(self, self._onReceivePlotData), self)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_FAVO_MAIN)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_FAVO)
	self:_reqPlotData()
	self:newScheduleOnce(handler(self, self._updateView), 0.1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_knightTissueBtn
	})
end

function FavoMainLayer:_onAddKnight()
	local var_4_0

	if not self.m_knightPicComp then
		do return end

		var_4_0 = {}
	end

	var_4_0.knight = var_0_1.knightsData:getMainRoleKnight()[1]

	self.m_knightPicComp:updateKnight(var_4_0)
end

function FavoMainLayer:_initMainLayer()
	self.m_topBarComp:setResInfoById(7)
	self.m_FavoAttrBtn:addClickListener(handler(self, self._onClickFavoAttrBtn))
	self.m_knightTissueBtn:addClickListener(handler(self, self._onClickKnightTissue))
	self:_onAddKnight()
end

function FavoMainLayer:_updateView()
	self.m_sloganLabel:setText(g.core.lang:get(112001))

	local var_6_0, var_6_1 = var_0_1.knightFavoData:getTotalLevelAttrs()

	self.m_FavoAttrBtn:setTitle((var_0_1.knightFavoData:getTotalFavoLevel()))
	self:_updateList()
end

function FavoMainLayer:_updateList()
	if var_0_1.knightFavoData:getReqPlotStatus() then
		self.m_listComp:updateView()
	end
end

function FavoMainLayer:_onReceivePlotData()
	self:_updateList()
end

function FavoMainLayer:_reqPlotData()
	if not var_0_4:getReqPlotStatus() then
		g.core.network.GameNetProxy:send_C2S_KnightFavorability_Info({})
	end
end

function FavoMainLayer:_onClickFavoAttrBtn()
	self:addPopup(require("app.view.module.knightFavorability.view.FavoAttrPop").new(), {
		touchDisappear = true
	})
end

function FavoMainLayer:_onClickKnightTissue()
	g.core.module.ModuleManager:pushModule(g.view.entrance.KNIGHT_TISSUE)
end

return FavoMainLayer

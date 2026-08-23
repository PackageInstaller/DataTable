local var_0_0 = g.core.const.ConstMgr.SpineConst
local StormStationOverlordLayer = class("StormStationOverlordLayer", require("app.fairyGUI.storm.UI_StormStationOverlordLayer"), function()
	return fgui.GComponent:create({
		resName = "StormStationOverlordLayer",
		pkgPath = "ui/storm/storm",
		isFullScreen = true,
		pkgName = "storm"
	}, ...)
end)

function StormStationOverlordLayer:ctor()
	self.m_overlordAwardBtn:addClickListener(handler(self, self._onOverlordAwardClick))
	self.m_allOverlordBtn:addClickListener(handler(self, self._onShowHistoryOverlordClick))
	self.m_hegemonyBtn:addClickListener(handler(self, self._onHegemonyClick))
	self.m_allOverlordBtn:setVisible(false)
	self.m_stateController:setSelectedIndex(2)
end

function StormStationOverlordLayer:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_GETLORD, self._onRcvGetLord, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_GETMAXLORDAWARD, self._onRcvGetLordAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_LORDHISTORYS, self._onRcvLordHistory, self)
	g.core.network.GameNetProxy:send_C2S_StormCity_GetLord({})
	g.core.network.GameNetProxy:send_C2S_StormCity_LordHistorys({})
	g.core.model.User.stormCityData:updateOverLordTs()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_overlordAwardBtn
	})
end

function StormStationOverlordLayer:_onRcvGetLord()
	self:_updateView()
end

function StormStationOverlordLayer:_onRcvGetLordAward(arg_5_1, arg_5_2, arg_5_3)
	g.core.module.ModuleManager:awardSummary(arg_5_3.awards)
end

function StormStationOverlordLayer:_onRcvLordHistory()
	self.m_allOverlordBtn:setVisible(#g.core.model.User.stormCityData:getLordHistorys() > 0)
end

function StormStationOverlordLayer:_updateView()
	local var_7_0 = g.core.model.User.stormCityData:getOverLordUser()

	self._overlord = var_7_0

	if var_7_0 then
		local var_7_1 = var_7_0.show_knight_dress or 0
		local var_7_2 = var_7_0.show_knight_id

		if var_7_1 > 0 then
			self.m_knightPicComp:updateKnight({
				scale = 0.9,
				skinId = var_7_1
			})
		else
			self.m_knightPicComp:updateKnight({
				scale = 0.9,
				resId = var_7_2
			})
		end

		self.m_knightPicComp:setAlphaRect(var_0_0.MASK_TYPE.HORIZON, cc.rect(-300, 0, 400, 0), 200)
		self.m_playerNameTxt:setText(g.core.lang:get(304533, {
			name = var_7_0.name,
			server = var_7_0.server_name
		}))
		self.m_fightValueTxt:setText(g.core.lang:get(304534, {
			fightValue = var_7_0.fight_value
		}))

		local var_7_3 = var_7_0.param or 0

		if var_7_3 > 0 and not g.core.model.User.stormCityData:isProcess() then
			self.m_upTimeTxt:setText(g.core.lang:get(304532, {
				num = var_7_3
			}))
		end
	end

	self.m_stateController:setSelectedIndex(checkbool(var_7_0) and 1 or 0)
end

function StormStationOverlordLayer:_onOverlordAwardClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.storm.view.station.StormOverlordAwardPop").new()))
end

function StormStationOverlordLayer:_onShowHistoryOverlordClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.STORM_ALL_OVERLORD)
end

function StormStationOverlordLayer:_onHegemonyClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.storm.view.station.StormTargetHegemonyPop").new()))
end

return StormStationOverlordLayer

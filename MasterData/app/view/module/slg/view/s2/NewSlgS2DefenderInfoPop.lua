local NewSlgS2DefenderInfoPop = class("NewSlgS2DefenderInfoPop", require("app.fairyGUI.newSlg.UI_NewSlgS2DefenderInfoPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgS2DefenderInfoPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgS2DefenderInfoPop:ctor(arg_2_1)
	self:showAtCenter()

	self._snapshot = nil
	self._allianceId = 0
	arg_2_1 = arg_2_1 or {}
	self._id = arg_2_1.id

	self.m_closeBtn:setClickCallBack(handler(self, self._onClickClose))
	self.m_closeGraph:addClickListener(handler(self, self._onClickClose))
	self.m_enterTransition:play()
end

function NewSlgS2DefenderInfoPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETCITYDEFINFO, handler(self, self._onRcvNewSlgGetCityDefInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, handler(self, self._updateAlliance), self)
	g.core.network.GameNetProxy:send_C2S_NewSlg_GetCityDefInfo({
		city_id = self._id
	})
end

function NewSlgS2DefenderInfoPop:_onClickClose()
	if self._inClose then
		return
	end

	self._inClose = true

	self.m_backTransition:play(handler(self, self.onCloseAnimFinish))
end

function NewSlgS2DefenderInfoPop:onCloseAnimFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgS2DefenderInfoPop:_onRcvNewSlgGetCityDefInfo(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.m_defenderComp:updateView(arg_6_4, self._id)
	self:_updateBaseInfo(arg_6_4)
end

function NewSlgS2DefenderInfoPop:_updateAlliance()
	self._snapshot = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, self._allianceId)

	if self._snapshot then
		self.m_allianceName:setText(g.core.lang:get(429655, {
			name = self._snapshot.name
		}))
	end
end

function NewSlgS2DefenderInfoPop:_updateBaseInfo(arg_8_1)
	local var_8_0 = arg_8_1.teams or {}
	local var_8_1 = arg_8_1.def_teams or {}
	local var_8_2 = g.core.model.User.newSlgData

	self._cityCfg = g.core.model.User.newSlgData:getCityInfoById(self._id)

	self.m_titleTxt:setText(g.core.lang:get(429658, {
		num1 = #var_8_0,
		num2 = var_8_2:getChariotGatherMaxNum(self._id)
	}))

	local var_8_3 = 0

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		var_8_3 = var_8_3 + iter_8_1.authority
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_1) do
		var_8_3 = var_8_3 + iter_8_3.authority
	end

	self.m_Txt_authority:setText(g.core.lang:get(429656, {
		num = var_8_3
	}))

	self._allianceId = var_8_2:getCityOccupyAlliance(self._id) or 0

	if self._allianceId > 0 then
		self:_updateAlliance()
	else
		self.m_allianceName:setText(g.core.lang:get(429657))
	end
end

return NewSlgS2DefenderInfoPop

local var_0_0 = g.core.const.ConstMgr.NewSlgConst
local var_0_1 = g.core.model.User.newSlgData
local NewSlgPreviewLayer = class("NewSlgPreviewLayer", require("app.fairyGUI.newSlg.UI_NewSlgPreviewLayer"), function()
	return fgui.GComponent:create({
		resName = "NewSlgPreviewLayer",
		pkgPath = "ui/newSlg/newSlg",
		isFullScreen = true,
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgPreviewLayer:ctor()
	self.m_bgLoader:setURL("bg/newSlg/bg_hzts_yureqi.jpg")

	if g.core.model.User.newSlgData:getSName() == "S2" then
		self.m_S2TxtIcon:setVisible(true)

		self._helpId = 376
	else
		self.m_S2TxtIcon:setVisible(false)

		self._helpId = 372
	end

	self.m_lookBtn:addClickListener(handler(self, self._onClickBtnLook))
	self.m_goBtn:addClickListener(handler(self, self._onClickBtnGo))
	self.m_previewBtn:addClickListener(handler(self, self._onClickBtnPreview))
	self.m_introduceBtn:addClickListener(handler(self, self._onClickBtnIntroduce))
	self.m_awardBtn:addClickListener(handler(self, self._onClickBtnAward))
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG)
	self.m_enterTransition:play()
end

function NewSlgPreviewLayer:onLoad()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_SLG_S4)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_OBTAINPREVIEWREWARDS, self.onS2CNewSlgGetPreviewReward, self)
	g.core.network.GameNetProxy:send_C2S_NewSlg_GetMatchServer({})
	self:_updateView()

	self._schedule = self:newSchedule(handler(self, self._updateCountDown), 1)

	self:_updateCountDown()
end

function NewSlgPreviewLayer:onS2CNewSlgGetPreviewReward(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3.rewards then
		g.core.module.ModuleManager:awardSummary(arg_4_3.rewards)
		self:_updateView()
	end
end

function NewSlgPreviewLayer:_updateCountDown()
	local var_5_0, var_5_1 = g.core.model.User.newSlgData:getForecastTime()

	if var_5_0 >= 0 then
		self.m_timeTxt:setText(var_5_1)
	else
		self:cancelSchedule(self._schedule)

		self._schedule = nil

		g.core.module.ModuleManager:replaceModule(g.view.entrance.NEW_SLG_MAIN)
	end
end

function NewSlgPreviewLayer:_updateView()
	local var_6_0 = g.core.model.User.allianceData:hasAlliance()

	self.m_hasAllianceController:setSelectedIndex(var_6_0 and 1 or 0)
	self.m_btnNameTxt:setText((var_6_0 or nil) and (g.core.lang:get(428949) or g.core.lang:get(428950)))
	self.m_previewBtn:setVisible(not var_0_1:getIsGotPreviewReward())
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_previewBtn
	})
end

function NewSlgPreviewLayer:_onClickBtnLook()
	g.core.common.GlobalFunc.pushMatchServerPop({
		serverInfo = var_0_1:getServerList()
	})
end

function NewSlgPreviewLayer:_onClickBtnGo()
	if not g.core.model.User.guildData:hasGuild() then
		g.core.module.ModuleManager:tip(g.core.lang:get(403507))

		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.ALLIANCE)
end

function NewSlgPreviewLayer:_onClickBtnPreview()
	g.core.network.GameNetProxy:send_C2S_NewSlg_ObtainPreviewRewards({})
end

function NewSlgPreviewLayer:_onClickBtnIntroduce()
	if self._helpId and self._helpId > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
			id = self._helpId
		}), {
			touchDisappear = true
		})
	end
end

function NewSlgPreviewLayer:_onClickBtnAward()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_RANK, {
		topTab = 2,
		rankType = var_0_0.RANK_TYPE.PERSONAL_ALL
	})
end

return NewSlgPreviewLayer

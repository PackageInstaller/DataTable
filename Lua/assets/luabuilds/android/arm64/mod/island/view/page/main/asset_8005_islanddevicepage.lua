local IslandDevicePage = class("IslandDevicePage", import("...base.IslandBasePage"))

IslandDevicePage.SPECIAL_BTN = {
	ship_order = "IslandDeviceShipOrderBtn",
	order = "IslandDeviceOrderBtn"
}

function IslandDevicePage:getUIName()
	return "IslandDeviceUI"
end

function IslandDevicePage:OnLoaded()
	self.exitBtn = self._tf:Find("panel/exit")
	self.timeTxt = self._tf:Find("panel/top/time"):GetComponent(typeof(Text))
	self.electricTF = self._tf:Find("panel/top/battery/electric")
	self.bannerTF = self._tf:Find("panel/banner")
	self.bannerEmptyTF = self._tf:Find("panel/banner_empty")
	self.scrollSnap = IslandBannerScrollRect.New(self.bannerTF:Find("mask/content"), self.bannerTF:Find("dots"))
	self.btnContainer = self._tf:Find("panel/btn_container")
	self.systemTimeUtil = LocalSystemTimeUtil.New()

	return
end

function IslandDevicePage:OnInit()
	onButton(self, self._tf:Find("close"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.exitBtn, function()
		self:emit(IslandMediator.PLAY_ROOM_MATCH_STOP)
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	setActive(self.exitBtn, not ISLAND_PLAYER_TESTING)
	self:InitBtns()
	self:InitBanner()

	return
end

function IslandDevicePage:InitBtns()
	self.btns = {}

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(pg.island_main_btns.get_id_list_by_main_type[2]) do
		var_6_0[pg.island_main_btns[iter_6_1].btn_name] = iter_6_1
	end

	eachChild(self.btnContainer, function(arg_7_0)
		if var_6_0[arg_7_0.name] then
			self.btns[arg_7_0.name] = IslandDevicePage.SPECIAL_BTN[arg_7_0.name] and _G[IslandDevicePage.SPECIAL_BTN[arg_7_0.name]].New(arg_7_0, self.event, var_6_0[arg_7_0.name]) or IslandDeviceBaseBtn.New(arg_7_0, self.event, var_6_0[arg_7_0.name])
		end

		return
	end)

	return
end

function IslandDevicePage:InitBanner()
	local var_8_0 = self:GetBannerDisplays()

	self.banners = var_8_0

	for iter_8_0 = 0, #var_8_0 - 1 do
		local var_8_1 = var_8_0[iter_8_0 + 1]
		local var_8_2 = self.scrollSnap:AddChild()

		if var_8_0[iter_8_0 + 1].id == 3 then
			LoadImageSpriteAsync("activitybanner/island_temp4", var_8_2)
		else
			LoadImageSpriteAsync("island/islandbanner/" .. var_8_0[iter_8_0 + 1].pic, var_8_2)
		end

		onButton(self, var_8_2, function()
			self:BannerSkip(var_8_1)

			return
		end, SFX_MAIN)
	end

	self.scrollSnap:SetUp()

	return
end

function IslandDevicePage:OnShow()
	self:AddTimer()
	self:Flush()
	self:FlushBattery()
	self:FlushTime()
	self:emitCore(ISLAND_EVT.DEVIEE_STATE_CHANGE, true)

	if IslandCameraMgr.instance then
		IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.FOCUS_CAMERA_NAME)
	end

	return
end

function IslandDevicePage:Flush()
	for iter_11_0, iter_11_1 in pairs(self.btns) do
		iter_11_1:Flush()
	end

	local var_11_0 = self:GetBannerDisplays()
	local var_11_1 = #var_11_0 ~= 0

	setActive(self.bannerEmptyTF, not (#var_11_0 ~= 0))
	setActive(self.bannerTF, var_11_1)

	if var_11_1 then
		if #self.banners ~= #var_11_0 then
			self.scrollSnap:Reset()
			self:InitBanner()
		else
			self.scrollSnap:Resume()
		end
	end

	return
end

function IslandDevicePage:FlushBattery()
	setFillAmount(self.electricTF, (SystemInfo.batteryLevel < 0 or nil) and 1)

	return
end

function IslandDevicePage:FlushTime()
	self.systemTimeUtil:SetUp(function(arg_14_0, arg_14_1, arg_14_2)
		self.timeTxt.text = arg_14_0 .. ":" .. arg_14_1

		return
	end)

	return
end

function IslandDevicePage:AddTimer()
	self:RemoveTimer()

	self.timer = Timer.New(function()
		self:FlushBattery()
		self:FlushTime()

		return
	end, 60, -1)

	self.timer:Start()

	return
end

function IslandDevicePage:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandDevicePage:OnHide()
	self:RemoveTimer()
	self:emitCore(ISLAND_EVT.DEVIEE_STATE_CHANGE, false)

	if IslandCameraMgr.instance then
		IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.FOLLOW_CAMERA_NAME)
	end

	return
end

function IslandDevicePage:OnEnable()
	self:OnShow()

	return
end

function IslandDevicePage:OnDisable()
	self:OnHide()

	return
end

function IslandDevicePage:OnDestroy()
	self:OnHide()
	self:RemoveTimer()
	self.systemTimeUtil:Dispose()

	self.systemTimeUtil = nil

	self.scrollSnap:Dispose()

	self.scrollSnap = nil

	for iter_21_0, iter_21_1 in pairs(self.btns) do
		iter_21_1:Dispose()
	end

	self.btns = nil

	return
end

function IslandDevicePage:GetBannerDisplays()
	return underscore(pg.island_banner.all):chain():map(function(arg_23_0)
		return pg.island_banner[arg_23_0]
	end):select(function(arg_24_0)
		if PLATFORM == PLATFORM_OPENHARMONY and arg_24_0.type == IslandConst.BANNER_TYPE_SURVEY then
			return false
		end

		return pg.TimeMgr.GetInstance():inTime(arg_24_0.time)
	end):value()
end

function IslandDevicePage:BannerSkip(arg_25_1)
	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandDeviceBanner(arg_25_1.id))

	if arg_25_1.type == IslandConst.BANNER_TYPE_OPEN_URL then
		Application.OpenURL(arg_25_1.param)
	elseif arg_25_1.type == IslandConst.BANNER_TYPE_SWITCH_MAP then
		self:Hide()
		self:emit(IslandBaseMediator.SWITCH_MAP, unpack(arg_25_1.param))
	elseif arg_25_1.type == IslandConst.BANNER_TYPE_OPEN_PAGE then
		self:Hide()
		self:emit(IslandMediator.OPEN_PAGE, arg_25_1.param[1], arg_25_1.param[2])
	elseif arg_25_1.type == IslandConst.BANNER_TYPE_SURVEY then
		local var_25_0, var_25_1 = getProxy(ActivityProxy):isSurveyOpen()
		local var_25_2 = getProxy(ActivityProxy):isSurveyDone()

		if var_25_0 and not isFinish then
			self:Hide()
			self:emit(IslandMediator.OPEN_PAGE, arg_25_1.param[1], arg_25_1.param[2])
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_not_start"))
		end
	end

	return
end

return IslandDevicePage

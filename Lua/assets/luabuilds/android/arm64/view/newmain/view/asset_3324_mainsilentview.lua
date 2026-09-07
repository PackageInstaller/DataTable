local MainSilentView = class("MainSilentView", import("view.base.BaseSubView"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 5
local var_0_6 = 6
local var_0_7 = 7
local var_0_8 = {}

var_0_8[1] = "noti_1"
var_0_8[2] = "noti_2"
var_0_8[3] = "noti_1"
var_0_8[4] = "noti_1"
var_0_8[5] = "noti_1"
var_0_8[6] = "noti_1"
var_0_8[7] = "noti_1"

local var_0_9 = 1
local var_0_10 = 2

function MainSilentView:getUIName()
	return "MainSilentViewUI"
end

function MainSilentView:OnLoaded()
	self.cg = self._tf:GetComponent(typeof(CanvasGroup))
	self.animationPlayer = self._tf:GetComponent(typeof(Animation))
	self.dftAniEvent = self._tf:GetComponent(typeof(DftAniEvent))
	self.timeTxt = self._tf:Find("adapt/en/time"):GetComponent(typeof(Text))
	self.timeEnTxt = self._tf:Find("adapt/en"):GetComponent(typeof(Text))
	self.batteryTxt = self._tf:Find("adapt/battery/Text"):GetComponent(typeof(Text))
	self.electric = {
		self._tf:Find("adapt/battery/kwh/1"),
		self._tf:Find("adapt/battery/kwh/2"),
		self._tf:Find("adapt/battery/kwh/3")
	}
	self.dateTxt = self._tf:Find("adapt/date"):GetComponent(typeof(Text))
	self.changeBtn = self._tf:Find("change")
	self.tips = UIItemList.New(self._tf:Find("tips"), self._tf:Find("tips/tpl"))
	self.chatTr = self._tf:Find("chat")
	self.chatTxt = self.chatTr:GetComponent(typeof(Text))
	self.changeSkinBtn = MainChangeSkinBtn.New(self.changeBtn, self.event)
	self.systemTimeUtil = LocalSystemTimeUtil.New()
	self.musicPlayerView = MainMusicPlayerView.New(self._tf:Find("adapt"), self.event)

	self.musicPlayerView:Load(self._tf:Find("adapt/MusicPlayer").gameObject)
	self.musicPlayerView:ActionInvoke("Hide")

	self.playedList = {}

	return
end

function MainSilentView:OnInit()
	onButton(self, self.changeBtn, function()
		self:TrackingSwitchShip()

		self.changeSkinCount = self.changeSkinCount + 1

		self.changeSkinBtn:OnClick()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Tracking(var_0_9)
		self:Exit()

		return
	end, SFX_PANEL)
	self:bind(GAME.ZERO_HOUR_OP_DONE, function()
		self:FlushDate()

		return
	end)
	self:bind(GAME.REMOVE_LAYERS, function(arg_7_0, arg_7_1)
		self:OnRemoveLayer(arg_7_1.context)

		return
	end)
	self:bind(MainWordView.SET_CONTENT, function(arg_8_0, arg_8_1, arg_8_2)
		self:SetChatTxt(arg_8_2)

		return
	end)
	self:bind(MainWordView.START_ANIMATION, function(arg_9_0, arg_9_1, arg_9_2)
		self:RemoveChatTimer()
		self:AddChatTimer(arg_9_1 + arg_9_2)

		return
	end)
	self:bind(MainWordView.STOP_ANIMATION, function(arg_10_0, arg_10_1, arg_10_2)
		self:RemoveChatTimer()
		self:SetChatTxt("")

		return
	end)
	self.changeSkinBtn:Flush()

	return
end

function MainSilentView:RemoveChatTimer()
	if self.chatTimer then
		self.chatTimer:Stop()

		self.chatTimer = nil
	end

	return
end

function MainSilentView:AddChatTimer(arg_12_1)
	self.chatTimer = Timer.New(function()
		self:SetChatTxt("")

		return
	end, arg_12_1, 1)

	self.chatTimer:Start()

	return
end

function MainSilentView:SetChatTxt(arg_14_1)
	setActive(self.chatTr, arg_14_1 and arg_14_1 ~= "")

	self.chatTxt.text = arg_14_1 or ""

	return
end

function MainSilentView:OnRemoveLayer(arg_15_1)
	if arg_15_1.mediator == CommissionInfoMediator or arg_15_1.mediator == NotificationMediator then
		self:Exit()
	end

	return
end

function MainSilentView:Exit(arg_16_1)
	self:RemoveChatTimer()
	self:TrackingSwitchShip()
	self.dftAniEvent:SetEndEvent(nil)
	self.dftAniEvent:SetEndEvent(function()
		self:emit(NewMainScene.EXIT_SILENT_VIEW)

		if arg_16_1 then
			arg_16_1()
		end

		return
	end)
	self.animationPlayer:Play("anim_silentview_out")

	return
end

function MainSilentView:Tracking(arg_18_1)
	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildExitSilentView(self.enterTime, pg.TimeMgr.GetInstance():GetServerTime(), arg_18_1))

	return
end

function MainSilentView:TrackingSwitchShip()
	if not getProxy(PlayerProxy) then
		return
	end

	local var_19_0 = getProxy(PlayerProxy):getRawData()

	if not var_19_0 then
		return
	end

	local var_19_1 = var_19_0:GetFlagShip()
	local var_19_2 = var_19_1:getSkinId()

	if isa(var_19_1, VirtualEducateCharShip) then
		var_19_2 = 0
	end

	local var_19_3 = pg.TimeMgr.GetInstance()
	local var_19_4 = var_19_3:GetServerTime()

	pg.GameTrackerMgr.GetInstance().Record(var_19_3, GameTrackerBuilder.BuildSwitchPainting(var_19_2, var_19_4 - self.paintingTime))

	self.paintingTime = var_19_4

	return
end

function MainSilentView:Show()
	MainSilentView.super.Show(self)
	self:FlushTips()
	self:FlushBattery()
	self:FlushTime()
	self:FlushDate()
	self:FlushMusicPlayer()
	self:AddTimer()
	self:SetChatTxt("")

	self.changeSkinCount = 0
	self.enterTime = pg.TimeMgr.GetInstance():GetServerTime()
	self.paintingTime = self.enterTime

	return
end

function MainSilentView:Reset()
	MainSilentView.super.Reset(self)

	self.exited = false

	return
end

function MainSilentView:AddTimer()
	self:RemoveTimer()

	self.timer = Timer.New(function()
		self:FlushTips()
		self:FlushBattery()

		return
	end, 30, -1)

	self.timer:Start()

	return
end

function MainSilentView:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function MainSilentView:FlushTips()
	local var_25_0 = {}

	self:CollectTips(var_25_0)

	local var_25_1 = {}

	self.tips:make(function(arg_26_0, arg_26_1, arg_26_2)
		if UIItemList.EventUpdate == arg_26_0 then
			local var_26_0 = var_25_0[arg_26_1 + 1]

			arg_26_2:Find("icon"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/MainUI_atlas", var_0_8[var_25_0[arg_26_1 + 1].type])

			setText(arg_26_2:Find("num"), var_25_0[arg_26_1 + 1].count)
			setText(arg_26_2:Find("Text"), i18n("main_silent_tip_" .. var_25_0[arg_26_1 + 1].type))
			onButton(self, arg_26_2, function()
				self:PlayTipOutAnimation(arg_26_2, function()
					self:Skip(var_26_0.type)

					return
				end)

				return
			end, SFX_PANEL)
			self:InsertAnimation(var_25_1, arg_26_2)
		end

		return
	end)
	self.tips:align(#var_25_0)
	seriesAsync(var_25_1, function()
		return
	end)

	return
end

function MainSilentView:PlayTipOutAnimation(arg_30_1, arg_30_2)
	self.cg.blocksRaycasts = false

	local var_30_0 = arg_30_1:GetComponent(typeof(DftAniEvent))

	var_30_0:SetEndEvent(nil)
	var_30_0:SetEndEvent(function()
		self.cg.blocksRaycasts = true

		var_30_0:SetEndEvent(nil)
		arg_30_2()

		return
	end)
	arg_30_1:GetComponent(typeof(Animation)):Play("anim_silentview_tip_out")

	return
end

function MainSilentView:InsertAnimation(arg_32_1, arg_32_2)
	if table.contains(self.playedList, arg_32_2) then
		return
	end

	local var_32_0 = GetOrAddComponent(arg_32_2, typeof(CanvasGroup))

	var_32_0.alpha = 0

	table.insert(arg_32_1, function(arg_33_0)
		if self.exited then
			return
		end

		var_32_0.alpha = 1

		arg_32_2:GetComponent(typeof(Animation)):Play("anim_silentview_tip_in")
		onDelayTick(arg_33_0, 0.066)

		return
	end)
	table.insert(self.playedList, arg_32_2)

	return
end

function MainSilentView:Skip(arg_34_1)
	self:Tracking(var_0_10)
	self:Exit(function()
		if arg_34_1 == var_0_1 then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.EVENT)
		elseif arg_34_1 == var_0_2 then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.GETBOAT)
		elseif arg_34_1 == var_0_3 then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.TECHNOLOGY)
		elseif arg_34_1 == var_0_4 then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.NAVALACADEMYSCENE, {
				warp = NavalAcademyScene.WARP_TO_TACTIC
			})
		end

		return
	end)

	return
end

function MainSilentView:CollectTips(arg_36_1)
	self:CollectEventTips(arg_36_1)
	self:CollectBuildTips(arg_36_1)
	self:CollectTechTips(arg_36_1)
	self:CollectStudentTips(arg_36_1)
	self:CollectIslandTips(arg_36_1)
	self:CollectChapterAutoTips(arg_36_1)

	return
end

function MainSilentView:CollectEventTips(arg_37_1)
	local var_37_0 = getProxy(EventProxy):countByState(EventInfo.StateFinish)

	if var_37_0 > 0 then
		table.insert(arg_37_1, {
			count = var_37_0,
			type = var_0_1
		})
	end

	return
end

function MainSilentView:CollectBuildTips(arg_38_1)
	local var_38_0 = getProxy(BuildShipProxy):getFinishCount()

	if var_38_0 > 0 then
		table.insert(arg_38_1, {
			count = var_38_0,
			type = var_0_2
		})
	end

	return
end

function MainSilentView:CollectTechTips(arg_39_1)
	local var_39_0 = 0

	for iter_39_0, iter_39_1 in pairs((getProxy(TechnologyProxy):getPlanningTechnologys())) do
		if iter_39_1:isCompleted() then
			var_39_0 = var_39_0 + 1
		end
	end

	if var_39_0 > 0 then
		table.insert(arg_39_1, {
			count = var_39_0,
			type = var_0_3
		})
	end

	return
end

function MainSilentView:CollectStudentTips(arg_40_1)
	local var_40_0 = 0

	for iter_40_0, iter_40_1 in pairs((getProxy(NavalAcademyProxy):RawGetStudentList())) do
		if iter_40_1:IsFinish() then
			var_40_0 = var_40_0 + 1
		end
	end

	if var_40_0 > 0 then
		table.insert(arg_40_1, {
			count = var_40_0,
			type = var_0_4
		})
	end

	return
end

function MainSilentView:CollectIslandTips(arg_41_1)
	if LOCK_ISLAND_DISPLAY then
		return
	end

	local var_41_0, var_41_1 = getProxy(SystemTipProxy):GetIslandTipInfos()

	if var_41_0 > 0 then
		table.insert(arg_41_1, {
			count = var_41_0,
			type = var_0_5
		})
	end

	if var_41_1 > 0 then
		table.insert(arg_41_1, {
			count = var_41_1,
			type = var_0_6
		})
	end

	return
end

function MainSilentView:CollectChapterAutoTips(arg_42_1)
	local var_42_0, var_42_1 = getProxy(ChapterAutoProxy):GetCntInfo()

	if var_42_1 > 0 and var_42_0 == var_42_1 then
		table.insert(arg_42_1, {
			count = var_42_1,
			type = var_0_7
		})
	end

	return
end

function MainSilentView:FlushBattery()
	local var_43_1 = math.floor(((SystemInfo.batteryLevel < 0 or nil) and 1) * 100)

	self.batteryTxt.text = var_43_1 .. "%"

	local var_43_2 = 1 / #self.electric

	for iter_43_0, iter_43_1 in ipairs(self.electric) do
		setActive(iter_43_1, not (var_43_1 < (iter_43_0 - 1) * var_43_2))
	end

	return
end

function MainSilentView:FlushTime()
	self.systemTimeUtil:SetUp(function(arg_45_0, arg_45_1, arg_45_2)
		if SettingsMainScenePanel.IsEnable24HourSystem() then
			self.timeEnTxt.color = Color.New(1, 1, 1, 0)
		else
			self.timeEnTxt.color = Color.New(1, 1, 1, 1)
			arg_45_0 = arg_45_0 > 12 and arg_45_0 - 12 or arg_45_0
		end

		if arg_45_0 < 10 then
			arg_45_0 = "0" .. arg_45_0
		end

		self.timeTxt.text = arg_45_0 .. ":" .. arg_45_1
		self.timeEnTxt.text = arg_45_2

		return
	end)

	return
end

local var_0_11 = {
	"MONDAY",
	"TUESDAY",
	"WEDNESDAY",
	"THURSDAY",
	"FRIDAY",
	"SATURDAY",
	"SUNDAY"
}
local var_0_12 = {
	"JAN",
	"FEB",
	"MAR",
	"APR",
	"MAY",
	"JUN",
	"JUL",
	"AUG",
	"SEP",
	"OCT",
	"NOV",
	"DEC"
}

function MainSilentView:FlushDate()
	local var_46_0 = string.split(os.date("%Y/%m/%d"), "/")

	self.dateTxt.text = table.concat({
		var_0_11[pg.TimeMgr.GetInstance():GetServerWeek()],
		var_0_12[tonumber(var_46_0[2])],
		var_46_0[3],
		var_46_0[1]
	}, " / ")

	return
end

function MainSilentView:FlushMusicPlayer()
	local var_47_0 = pg.BgmMgr.GetInstance():GetNow() == "MainMusicPlayer"

	if tobool(self.musicPlayerView:isShowing()) ~= var_47_0 then
		if var_47_0 then
			self.musicPlayerView:ExecuteAction("Show", true)
		else
			self.musicPlayerView:ExecuteAction("Hide")
		end
	end

	return
end

function MainSilentView:OnDestroy()
	self:RemoveChatTimer()

	self.exited = true

	self.dftAniEvent:SetEndEvent(nil)
	self:RemoveTimer()
	self.changeSkinBtn:Dispose()

	self.changeSkinBtn = nil

	self.systemTimeUtil:Dispose()

	self.systemTimeUtil = nil

	self.musicPlayerView:Destroy()

	self.musicPlayerView = nil

	return
end

return MainSilentView

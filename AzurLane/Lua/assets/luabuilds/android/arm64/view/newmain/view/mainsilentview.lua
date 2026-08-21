local var_0_0 = class("MainSilentView", import("view.base.BaseSubView"))
local var_0_1 = 2
local var_0_2 = 3
local var_0_3 = 4
local var_0_4 = 5
local var_0_5 = 6
local var_0_6 = {}

;({})[1] = "noti_1"
;({})[2] = "noti_2"
;({})[3] = "noti_1"
;({})[4] = "noti_1"
;({})[5] = "noti_1"
;({})[6] = "noti_1"

local var_0_7 = 1
local var_0_8 = 2

function var_0_0.getUIName(arg_1_0)
	return "MainSilentViewUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.cg = arg_2_0._tf:GetComponent(typeof(CanvasGroup))
	arg_2_0.animationPlayer = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.dftAniEvent = arg_2_0._tf:GetComponent(typeof(DftAniEvent))
	arg_2_0.timeTxt = arg_2_0._tf:Find("adapt/en/time"):GetComponent(typeof(Text))
	arg_2_0.timeEnTxt = arg_2_0._tf:Find("adapt/en"):GetComponent(typeof(Text))
	arg_2_0.batteryTxt = arg_2_0._tf:Find("adapt/battery/Text"):GetComponent(typeof(Text))
	arg_2_0.electric = {
		arg_2_0._tf:Find("adapt/battery/kwh/1"),
		arg_2_0._tf:Find("adapt/battery/kwh/2"),
		arg_2_0._tf:Find("adapt/battery/kwh/3")
	}
	arg_2_0.dateTxt = arg_2_0._tf:Find("adapt/date"):GetComponent(typeof(Text))
	arg_2_0.changeBtn = arg_2_0._tf:Find("change")
	arg_2_0.tips = UIItemList.New(arg_2_0._tf:Find("tips"), arg_2_0._tf:Find("tips/tpl"))
	arg_2_0.chatTr = arg_2_0._tf:Find("chat")
	arg_2_0.chatTxt = arg_2_0.chatTr:GetComponent(typeof(Text))
	arg_2_0.changeSkinBtn = MainChangeSkinBtn.New(arg_2_0.changeBtn, arg_2_0.event)
	arg_2_0.systemTimeUtil = LocalSystemTimeUtil.New()
	arg_2_0.musicPlayerView = MainMusicPlayerView.New(arg_2_0._tf:Find("adapt"), arg_2_0.event)

	arg_2_0.musicPlayerView:Load(arg_2_0._tf:Find("adapt/MusicPlayer").gameObject)
	arg_2_0.musicPlayerView:ActionInvoke("Hide")

	arg_2_0.playedList = {}

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.changeBtn, function()
		arg_3_0:TrackingSwitchShip()

		arg_3_0.changeSkinCount = arg_3_0.changeSkinCount + 1

		arg_3_0.changeSkinBtn:OnClick()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Tracking(var_0_7)
		arg_3_0:Exit()

		return
	end, SFX_PANEL)
	arg_3_0:bind(GAME.ZERO_HOUR_OP_DONE, function()
		arg_3_0:FlushDate()

		return
	end)
	arg_3_0:bind(GAME.REMOVE_LAYERS, function(arg_7_0, arg_7_1)
		arg_3_0:OnRemoveLayer(arg_7_1.context)

		return
	end)
	arg_3_0:bind(MainWordView.SET_CONTENT, function(arg_8_0, arg_8_1, arg_8_2)
		arg_3_0:SetChatTxt(arg_8_2)

		return
	end)
	arg_3_0:bind(MainWordView.START_ANIMATION, function(arg_9_0, arg_9_1, arg_9_2)
		arg_3_0:RemoveChatTimer()
		arg_3_0:AddChatTimer(arg_9_1 + arg_9_2)

		return
	end)
	arg_3_0:bind(MainWordView.STOP_ANIMATION, function(arg_10_0, arg_10_1, arg_10_2)
		arg_3_0:RemoveChatTimer()
		arg_3_0:SetChatTxt("")

		return
	end)
	arg_3_0.changeSkinBtn:Flush()

	return
end

function var_0_0.RemoveChatTimer(arg_11_0)
	if arg_11_0.chatTimer then
		arg_11_0.chatTimer:Stop()

		arg_11_0.chatTimer = nil
	end

	return
end

function var_0_0.AddChatTimer(arg_12_0, arg_12_1)
	arg_12_0.chatTimer = Timer.New(function()
		arg_12_0:SetChatTxt("")

		return
	end, arg_12_1, 1)

	arg_12_0.chatTimer:Start()

	return
end

function var_0_0.SetChatTxt(arg_14_0, arg_14_1)
	setActive(arg_14_0.chatTr, arg_14_1 and arg_14_1 ~= "")

	arg_14_0.chatTxt.text = arg_14_1 or ""

	return
end

function var_0_0.OnRemoveLayer(arg_15_0, arg_15_1)
	if arg_15_1.mediator == CommissionInfoMediator or arg_15_1.mediator == NotificationMediator then
		arg_15_0:Exit()
	end

	return
end

function var_0_0.Exit(arg_16_0, arg_16_1)
	arg_16_0:RemoveChatTimer()
	arg_16_0:TrackingSwitchShip()
	arg_16_0.dftAniEvent:SetEndEvent(nil)
	arg_16_0.dftAniEvent:SetEndEvent(function()
		arg_16_0:emit(NewMainScene.EXIT_SILENT_VIEW)

		if arg_16_1 then
			arg_16_1()
		end

		return
	end)
	arg_16_0.animationPlayer:Play("anim_silentview_out")

	return
end

function var_0_0.Tracking(arg_18_0, arg_18_1)
	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildExitSilentView(arg_18_0.enterTime, pg.TimeMgr.GetInstance():GetServerTime(), arg_18_1))

	return
end

function var_0_0.TrackingSwitchShip(arg_19_0)
	local var_19_9000

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
	local var_19_4 = var_19_3.GetServerTime(var_19_9000)

	pg.GameTrackerMgr.GetInstance().Record(var_19_3, GameTrackerBuilder.BuildSwitchPainting(var_19_2, var_19_4 - arg_19_0.paintingTime))

	arg_19_0.paintingTime = var_19_4

	return
end

function var_0_0.Show(arg_20_0)
	var_0_0.super.Show(arg_20_0)
	arg_20_0:FlushTips()
	arg_20_0:FlushBattery()
	arg_20_0:FlushTime()
	arg_20_0:FlushDate()
	arg_20_0:FlushMusicPlayer()
	arg_20_0:AddTimer()
	arg_20_0:SetChatTxt("")

	arg_20_0.changeSkinCount = 0
	arg_20_0.enterTime = pg.TimeMgr.GetInstance():GetServerTime()
	arg_20_0.paintingTime = arg_20_0.enterTime

	return
end

function var_0_0.Reset(arg_21_0)
	var_0_0.super.Reset(arg_21_0)

	arg_21_0.exited = false

	return
end

function var_0_0.AddTimer(arg_22_0)
	arg_22_0:RemoveTimer()

	arg_22_0.timer = Timer.New(function()
		arg_22_0:FlushTips()
		arg_22_0:FlushBattery()

		return
	end, 30, -1)

	arg_22_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_24_0)
	if arg_24_0.timer then
		arg_24_0.timer:Stop()

		arg_24_0.timer = nil
	end

	return
end

function var_0_0.FlushTips(arg_25_0)
	local var_25_0 = {}

	arg_25_0:CollectTips({})

	local var_25_1 = {}

	arg_25_0.tips:make(function(arg_26_0, arg_26_1, arg_26_2)
		if UIItemList.EventUpdate == arg_26_0 then
			local var_26_0 = var_25_0[arg_26_1 + 1]

			arg_26_2:Find("icon"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/MainUI_atlas", var_0_6[var_25_0[arg_26_1 + 1].type])

			setText(arg_26_2:Find("num"), var_25_0[arg_26_1 + 1].count)
			setText(arg_26_2:Find("Text"), i18n("main_silent_tip_" .. var_25_0[arg_26_1 + 1].type))
			onButton(arg_25_0, arg_26_2, function()
				arg_25_0:PlayTipOutAnimation(arg_26_2, function()
					arg_25_0:Skip(var_26_0.type)

					return
				end)

				return
			end, SFX_PANEL)
			arg_25_0:InsertAnimation(var_25_1, arg_26_2)
		end

		return
	end)
	arg_25_0.tips:align(#{})
	seriesAsync({}, function()
		return
	end)

	return
end

function var_0_0.PlayTipOutAnimation(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0.cg.blocksRaycasts = false

	local var_30_0 = arg_30_1:GetComponent(typeof(DftAniEvent))

	var_30_0:SetEndEvent(nil)
	var_30_0:SetEndEvent(function()
		arg_30_0.cg.blocksRaycasts = true

		var_30_0:SetEndEvent(nil)
		arg_30_2()

		return
	end)
	arg_30_1:GetComponent(typeof(Animation)):Play("anim_silentview_tip_out")

	return
end

function var_0_0.InsertAnimation(arg_32_0, arg_32_1, arg_32_2)
	if table.contains(arg_32_0.playedList, arg_32_2) then
		return
	end

	local var_32_0 = GetOrAddComponent(arg_32_2, typeof(CanvasGroup))

	var_32_0.alpha = 0

	table.insert(arg_32_1, function(arg_33_0)
		if arg_32_0.exited then
			return
		end

		var_32_0.alpha = 1

		arg_32_2:GetComponent(typeof(Animation)):Play("anim_silentview_tip_in")
		onDelayTick(arg_33_0, 0.066)

		return
	end)
	table.insert(arg_32_0.playedList, arg_32_2)

	return
end

function var_0_0.Skip(arg_34_0, arg_34_1)
	arg_34_0:Tracking(var_0_8)
	arg_34_0:Exit(function()
		if arg_34_1 == var_0 then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.EVENT)
		elseif arg_34_1 == var_0_1 then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.GETBOAT)
		elseif arg_34_1 == var_0_2 then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.TECHNOLOGY)
		elseif arg_34_1 == var_0_3 then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.NAVALACADEMYSCENE, {
				warp = NavalAcademyScene.WARP_TO_TACTIC
			})
		end

		return
	end)

	return
end

function var_0_0.CollectTips(arg_36_0, arg_36_1)
	arg_36_0:CollectEventTips(arg_36_1)
	arg_36_0:CollectBuildTips(arg_36_1)
	arg_36_0:CollectTechTips(arg_36_1)
	arg_36_0:CollectStudentTips(arg_36_1)
	arg_36_0:CollectIslandTips(arg_36_1)

	return
end

function var_0_0.CollectEventTips(arg_37_0, arg_37_1)
	local var_37_0 = getProxy(EventProxy):countByState(EventInfo.StateFinish)

	if var_37_0 > 0 then
		table.insert(arg_37_1, {
			count = var_37_0,
			type = var_0
		})
	end

	return
end

function var_0_0.CollectBuildTips(arg_38_0, arg_38_1)
	local var_38_0 = getProxy(BuildShipProxy):getFinishCount()

	if var_38_0 > 0 then
		table.insert(arg_38_1, {
			count = var_38_0,
			type = var_0_1
		})
	end

	return
end

function var_0_0.CollectTechTips(arg_39_0, arg_39_1)
	local var_39_0 = 0

	for iter_39_0, iter_39_1 in pairs((getProxy(TechnologyProxy):getPlanningTechnologys())) do
		if iter_39_1:isCompleted() then
			var_39_0 = var_39_0 + 1
		end
	end

	if var_39_0 > 0 then
		table.insert(arg_39_1, {
			count = var_39_0,
			type = var_0_2
		})
	end

	return
end

function var_0_0.CollectStudentTips(arg_40_0, arg_40_1)
	local var_40_0 = 0

	for iter_40_0, iter_40_1 in pairs((getProxy(NavalAcademyProxy):RawGetStudentList())) do
		if iter_40_1:IsFinish() then
			var_40_0 = var_40_0 + 1
		end
	end

	if var_40_0 > 0 then
		table.insert(arg_40_1, {
			count = var_40_0,
			type = var_0_3
		})
	end

	return
end

function var_0_0.CollectIslandTips(arg_41_0, arg_41_1)
	if LOCK_ISLAND_DISPLAY then
		return
	end

	local var_41_0, var_41_1 = getProxy(SystemTipProxy):GetIslandTipInfos()

	if var_41_0 > 0 then
		table.insert(arg_41_1, {
			count = var_41_0,
			type = var_0_4
		})
	end

	if var_41_1 > 0 then
		table.insert(arg_41_1, {
			count = var_41_1,
			type = var_0_5
		})
	end

	return
end

function var_0_0.FlushBattery(arg_42_0)
	local var_42_0 = SystemInfo.batteryLevel

	if SystemInfo.batteryLevel < 0 then
		var_42_0 = 1
	end

	local var_42_1 = math.floor(var_42_0 * 100)

	arg_42_0.batteryTxt.text = var_42_1 .. "%"

	local var_42_2 = 1 / #arg_42_0.electric

	for iter_42_0, iter_42_1 in ipairs(arg_42_0.electric) do
		setActive(iter_42_1, not (var_42_1 < (iter_42_0 - 1) * var_42_2))
	end

	return
end

function var_0_0.FlushTime(arg_43_0)
	arg_43_0.systemTimeUtil:SetUp(function(arg_44_0, arg_44_1, arg_44_2)
		if SettingsMainScenePanel.IsEnable24HourSystem() then
			arg_43_0.timeEnTxt.color = Color.New(1, 1, 1, 0)
		else
			arg_43_0.timeEnTxt.color = Color.New(1, 1, 1, 1)
			arg_44_0 = arg_44_0 > 12 and arg_44_0 - 12 or arg_44_0
		end

		if arg_44_0 < 10 then
			arg_44_0 = "0" .. arg_44_0
		end

		arg_43_0.timeTxt.text = arg_44_0 .. ":" .. arg_44_1
		arg_43_0.timeEnTxt.text = arg_44_2

		return
	end)

	return
end

local var_0_9 = {
	"MONDAY",
	"TUESDAY",
	"WEDNESDAY",
	"THURSDAY",
	"FRIDAY",
	"SATURDAY",
	"SUNDAY"
}
local var_0_10 = {
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

function var_0_0.FlushDate(arg_45_0)
	local var_45_0 = string.split(os.date("%Y/%m/%d"), "/")

	arg_45_0.dateTxt.text = table.concat({
		var_0_9[pg.TimeMgr.GetInstance():GetServerWeek()],
		var_0_10[tonumber(var_45_0[2])],
		var_45_0[3],
		var_45_0[1]
	}, " / ")

	return
end

function var_0_0.FlushMusicPlayer(arg_46_0)
	local var_46_0 = pg.BgmMgr.GetInstance():GetNow() == "MainMusicPlayer"

	if tobool(arg_46_0.musicPlayerView:isShowing()) ~= var_46_0 then
		if var_46_0 then
			arg_46_0.musicPlayerView:ExecuteAction("Show", true)
		else
			arg_46_0.musicPlayerView:ExecuteAction("Hide")
		end
	end

	return
end

function var_0_0.OnDestroy(arg_47_0)
	arg_47_0:RemoveChatTimer()

	arg_47_0.exited = true

	arg_47_0.dftAniEvent:SetEndEvent(nil)
	arg_47_0:RemoveTimer()
	arg_47_0.changeSkinBtn:Dispose()

	arg_47_0.changeSkinBtn = nil

	arg_47_0.systemTimeUtil:Dispose()

	arg_47_0.systemTimeUtil = nil

	arg_47_0.musicPlayerView:Destroy()

	arg_47_0.musicPlayerView = nil

	return
end

return var_0_0

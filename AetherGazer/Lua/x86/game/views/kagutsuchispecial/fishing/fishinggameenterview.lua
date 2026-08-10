local var_0_0 = class("FishingGameEnterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0, ...)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.winBar = KagutsuchiSpecialWinBarItem.New(arg_4_0, arg_4_0.winBar_, {
		CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id,
		CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id
	})

	arg_4_0:InitBtnListeners()

	arg_4_0.tips_.text = GetTipsF("ACTIVITY_KAGUTSUCHI_FISH_FATIGUE_TIPS", GameSetting.activity_kagutsuchi_fatigue_fish_recover.value[1])
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
	arg_5_0.winBar:Dispose()
end

function var_0_0.OnEnter(arg_6_0)
	manager.windowBar:HideBar()
	arg_6_0:RegisterEvents()
	arg_6_0.winBar:SetGameHelpKey("ACTIVITY_KAGUTSUCHI_FISH_DESCRIBE")
	arg_6_0.winBar:RegistBackCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()

		local var_7_0 = KagutsuchiFishingEventData.activityID

		ActivityTools.JumpBackToActivityMainViewByActivityID(var_7_0)
	end)
	arg_6_0:UpdateEventTime()
	arg_6_0:UpdateFishingGameCount()

	if arg_6_0.timer ~= nil then
		arg_6_0.timer:Stop()
	end

	arg_6_0.timer = Timer.New(function()
		arg_6_0:UpdateEventTime()
	end, 1, -1)

	arg_6_0.timer:Start()
end

function var_0_0.UpdateFishingGameCount(arg_9_0)
	local var_9_0 = GameSetting.activity_kagutsuchi_fish_times_max.value[1]

	arg_9_0.gameCountText_.text = string.format("%d/%d", KagutsuchiFishingEventData:GetRestGameCount(), var_9_0)
end

function var_0_0.OnExit(arg_10_0)
	if arg_10_0.timer ~= nil then
		arg_10_0.timer:Stop()

		arg_10_0.timer = nil
	end

	arg_10_0:RemoveAllEventListener()
end

function var_0_0.RegisterEvents(arg_11_0)
	return
end

function var_0_0.InitBtnListeners(arg_12_0)
	arg_12_0:AddBtnListener(arg_12_0.gameStartBtn_, nil, var_0_0.StartGame)
	arg_12_0:AddBtnListener(arg_12_0.collectionBtn_, nil, var_0_0.GoToColloctionPage)
end

local function var_0_1()
	local var_13_0
	local var_13_1 = KagutsuchiFishingEventData.fishRemain

	if var_13_1 == nil or next(var_13_1) == nil then
		var_13_0 = HanafudaCardCfg.all
	else
		var_13_0 = {}

		for iter_13_0, iter_13_1 in pairs(var_13_1) do
			table.insert(var_13_0, iter_13_0)
		end
	end

	return var_13_0[math.random(#var_13_0)]
end

local function var_0_2()
	local var_14_0 = var_0_1()

	manager.notify:Invoke(KAGUTSUCHI_FISHING_EVENT_GAME_START)
	JumpTools.OpenPageByJump("/kagutsuchiFishingGame", {
		fishID = var_14_0
	})
end

local function var_0_3()
	if KagutsuchiWorkData then
		return KagutsuchiWorkData:GetStamina()
	end

	return 0
end

function var_0_0.StartGame()
	local var_16_0 = KagutsuchiFishingEventData.activityID

	if GameSetting.activity_kagutsuchi_fish_times_max.value[1] > KagutsuchiFishingEventData.dailyGameCount then
		if var_0_3() + GameSetting.activity_kagutsuchi_fatigue_fish_recover.value[1] > GameSetting.activity_kagutsuchi_battle_fatigue_max.value[1] then
			JumpTools.OpenPageByJump("kagutsuchiFishingStaminaWillOverflow", {
				OkCallback = var_0_2
			})
		elseif ActivityTools.GetActivityIsOpenWithTip(var_16_0, true) then
			var_0_2()
		end
	else
		ShowTips("ACTIVITY_KAGUTSUCHI_FISH_NO_GAME_COUNT")
	end
end

function var_0_0.UpdateEventTime(arg_17_0)
	local var_17_0 = KagutsuchiFishingEventData.activityID
	local var_17_1 = ActivityData:GetActivityData(var_17_0).stopTime

	if var_17_1 <= manager.time:GetServerTime() then
		arg_17_0.timeText_.text = GetTips("TIME_OVER")

		return
	end

	arg_17_0.timeText_.text = manager.time:GetLostTimeStr2(var_17_1)
end

function var_0_0.GoToColloctionPage()
	JumpTools.OpenPageByJump("/kagutsuchiFishingGameCollection")
end

return var_0_0

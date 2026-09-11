local FishingGameEnterView = class("FishingGameEnterView", ReduxView)

function FishingGameEnterView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingUI"
end

function FishingGameEnterView:UIParent()
	return manager.ui.uiMain.transform
end

function FishingGameEnterView:OnCtor(...)
	return
end

function FishingGameEnterView:Init()
	self:BindCfgUI()

	self.winBar = KagutsuchiSpecialWinBarItem.New(self, self.winBar_, {
		CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id,
		CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id
	})

	self:InitBtnListeners()

	self.tips_.text = GetTipsF("ACTIVITY_KAGUTSUCHI_FISH_FATIGUE_TIPS", GameSetting.activity_kagutsuchi_fatigue_fish_recover.value[1])
end

function FishingGameEnterView:Dispose()
	FishingGameEnterView.super.Dispose(self)
	self.winBar:Dispose()
end

function FishingGameEnterView:OnEnter()
	manager.windowBar:HideBar()
	self:RegisterEvents()
	self.winBar:SetGameHelpKey("ACTIVITY_KAGUTSUCHI_FISH_DESCRIBE")
	self.winBar:RegistBackCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		ActivityTools.JumpBackToActivityMainViewByActivityID(KagutsuchiFishingEventData.activityID)
	end)
	self:UpdateEventTime()
	self:UpdateFishingGameCount()

	if self.timer ~= nil then
		self.timer:Stop()
	end

	self.timer = Timer.New(function()
		self:UpdateEventTime()
	end, 1, -1)

	self.timer:Start()
end

function FishingGameEnterView:UpdateFishingGameCount()
	self.gameCountText_.text = string.format("%d/%d", KagutsuchiFishingEventData:GetRestGameCount(), GameSetting.activity_kagutsuchi_fish_times_max.value[1])
end

function FishingGameEnterView:OnExit()
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	self:RemoveAllEventListener()
end

function FishingGameEnterView:RegisterEvents()
	return
end

function FishingGameEnterView:InitBtnListeners()
	self:AddBtnListener(self.gameStartBtn_, nil, FishingGameEnterView.StartGame)
	self:AddBtnListener(self.collectionBtn_, nil, FishingGameEnterView.GoToColloctionPage)
end

local function var_0_1()
	local var_13_0

	if KagutsuchiFishingEventData.fishRemain == nil or next(KagutsuchiFishingEventData.fishRemain) == nil then
		var_13_0 = HanafudaCardCfg.all
	else
		var_13_0 = {}

		for iter_13_0, iter_13_1 in pairs(KagutsuchiFishingEventData.fishRemain) do
			table.insert(var_13_0, iter_13_0)
		end
	end

	return var_13_0[math.random(#var_13_0)]
end

local function var_0_2()
	manager.notify:Invoke(KAGUTSUCHI_FISHING_EVENT_GAME_START)
	JumpTools.OpenPageByJump("/kagutsuchiFishingGame", {
		fishID = var_0_1()
	})
end

local function var_0_3()
	if KagutsuchiWorkData then
		return KagutsuchiWorkData:GetStamina()
	end

	return 0
end

function FishingGameEnterView.StartGame()
	if GameSetting.activity_kagutsuchi_fish_times_max.value[1] > KagutsuchiFishingEventData.dailyGameCount then
		if var_0_3() + GameSetting.activity_kagutsuchi_fatigue_fish_recover.value[1] > GameSetting.activity_kagutsuchi_battle_fatigue_max.value[1] then
			JumpTools.OpenPageByJump("kagutsuchiFishingStaminaWillOverflow", {
				OkCallback = var_0_2
			})
		elseif ActivityTools.GetActivityIsOpenWithTip(KagutsuchiFishingEventData.activityID, true) then
			var_0_2()
		end
	else
		ShowTips("ACTIVITY_KAGUTSUCHI_FISH_NO_GAME_COUNT")
	end
end

function FishingGameEnterView:UpdateEventTime()
	local var_17_0 = ActivityData:GetActivityData(KagutsuchiFishingEventData.activityID).stopTime

	if var_17_0 <= manager.time:GetServerTime() then
		self.timeText_.text = GetTips("TIME_OVER")

		return
	end

	self.timeText_.text = manager.time:GetLostTimeStr2(var_17_0)
end

function FishingGameEnterView.GoToColloctionPage()
	JumpTools.OpenPageByJump("/kagutsuchiFishingGameCollection")
end

return FishingGameEnterView

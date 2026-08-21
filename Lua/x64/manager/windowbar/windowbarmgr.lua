local var_0_0 = class("WindowBarMgr", import("game.extend.ReduxView"))
local var_0_1 = import("manager.windowBar.WindowCurrencyItem")
local var_0_2 = import("manager.windowBar.WindowMaterialItem")
local var_0_3 = import("manager.windowBar.WindowActivityMatrixCoinItem")
local var_0_4 = import("manager.windowBar.WindowActivityCoinItem")
local var_0_5 = import("manager.windowBar.WindowPopTipsItem")

import("manager.windowBar.WindowBarDef")

local var_0_6

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Com_dynamic/WindowBarUI"
end

function var_0_0.OnCtor(arg_2_0)
	print("Initialize Window")
end

function var_0_0.Init(arg_3_0)
	arg_3_0.lastBarList_ = {}
	arg_3_0.lastAddBarList_ = {}
	arg_3_0.lastCanClickBarList_ = {}
	arg_3_0.styleInfo_ = {}
	arg_3_0.lastStyleInfo_ = {}

	arg_3_0:InitUI()
	arg_3_0:AddListeners()

	arg_3_0.windowPopTipsItemView_ = var_0_5.New(arg_3_0.goTips_)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.gameObject_ = GameObject.Instantiate(Asset.Load(arg_4_0:UIName()), manager.ui.uiPop.transform)
	arg_4_0.transform_ = arg_4_0.gameObject_.transform

	arg_4_0:BindCfgUI()
	arg_4_0:AdaptScreen()

	arg_4_0.barGo_ = {}
	arg_4_0.barGo_[HOME_BAR] = arg_4_0.homeBtn_.gameObject
	arg_4_0.barGo_[BACK_BAR] = arg_4_0.backBtn_.gameObject
	arg_4_0.barGo_[INFO_BAR] = arg_4_0.infoBtn_.gameObject
	arg_4_0.storedGameHelper = nil
	arg_4_0.isShow_ = false
	arg_4_0.cooperationInviteTip_ = CooperationInviteTipItem.New(arg_4_0.m_cooperationInviteTip)
end

function var_0_0.SetWhereTag(arg_5_0, arg_5_1)
	var_0_6 = arg_5_1
end

function var_0_0.ClearWhereTag(arg_6_0)
	var_0_6 = nil
end

function var_0_0.GetWhereTag(arg_7_0)
	return var_0_6
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.homeBtn_, nil, function()
		OperationRecorder.Record(gameContext:GetLastOpenPage(), "homeBtn")

		if arg_8_0.homeFunc_ then
			arg_8_0.homeFunc_()
		elseif var_0_6 == "chess" then
			gameContext:Go("/warHome")
		elseif var_0_6 == "canteen" then
			gameContext:Go("/restaurantMain")
		elseif var_0_6 == "dorm" then
			gameContext:Go("/dorm")
		elseif var_0_6 == "newchess" then
			NewChessTools.ExitNewChessScene(true)
		elseif var_0_6 == "guildActivity" then
			local var_9_0 = GuildActivityData:GetCurrentGrid()
			local var_9_1

			if var_9_0 ~= nil and var_9_0 > 0 then
				local var_9_2 = ActivityClubCfg[var_9_0].map_id

				var_9_1 = table.indexof(ActivityClubMapCfg.all, var_9_2)
			else
				var_9_1 = 1
			end

			gameContext:Go("/guildActivityWarField", {
				level = var_9_1,
				activityID = ActivityConst.GUILD_ACTIVITY_START
			})
		elseif var_0_6 == "guildActivitySP" then
			local var_9_3 = GuildActivitySPData:GetCurrentGrid()
			local var_9_4

			if var_9_3 ~= nil and var_9_3 > 0 then
				local var_9_5 = ActivityClubSPCfg[var_9_3].map_id
				local var_9_6 = GuildActivitySPData:GetCurRunActivityID()
				local var_9_7 = ActivityClubSPMapCfg.get_id_list_by_activity[var_9_6]

				var_9_4 = table.indexof(var_9_7, var_9_5)
			else
				var_9_4 = 1
			end

			local var_9_8 = GuildActivitySPData:GetCurRunActivityID()

			gameContext:Go("/guildActivitySPWarField", {
				level = var_9_4,
				activityID = var_9_8,
				totalActivityID = var_9_8
			})
		elseif var_0_6 == "minigame" then
			DormMinigame.Exit(HOME_BAR)
		elseif whereami == "battleResult" then
			DestroyLua()
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded("/home")
		elseif var_0_6 == "danceGame" then
			BackHomeDataManager:ExitBackHomeSystem()
			DormMinigame.Exit(HOME_BAR)
		elseif var_0_6 == "dormIllu" then
			DormIllu.Exit(HOME_BAR)
		elseif var_0_6 == "qworld" then
			QWorldUIShow()
		else
			gameContext:Go("/home", {
				isHomeBack = true
			}, nil, true)
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.backBtn_, nil, function()
		OperationRecorder.Record(gameContext:GetLastOpenPage(), "backBtn")
		arg_8_0:CallBackFunc()
	end)
	arg_8_0:AddBtnListener(arg_8_0.infoBtn_, nil, function()
		OperationRecorder.Record(gameContext:GetLastOpenPage(), "infoBtn")
		arg_8_0:ShowGameHelp()
	end)
	arg_8_0:AddBtnListener(arg_8_0.bgBtn_, nil, function()
		arg_8_0:StopTimer()
		SetActive(arg_8_0.countdownGo_, false)
		SetActive(arg_8_0.bgBtn_.gameObject, false)
	end)
end

local function var_0_7(arg_13_0)
	if type(arg_13_0.gameHelpKey) == "table" then
		if arg_13_0.gameHelpKey.type == "jump" then
			local var_13_0 = arg_13_0.gameHelpKey.view
			local var_13_1 = arg_13_0.gameHelpKey.params

			JumpTools.OpenPageByJump(var_13_0, var_13_1)
		end
	elseif arg_13_0.gameHelpKey then
		local var_13_2 = GetTips(arg_13_0.gameHelpKey)

		if arg_13_0.gameHelpEnterFunc then
			arg_13_0.gameHelpEnterFunc()
		end

		local var_13_3 = arg_13_0.gameHelpExitFunc

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_13_2,
			key = arg_13_0.gameHelpKey,
			exitFunc = function()
				if var_13_3 then
					var_13_3()
				end
			end
		})
	elseif arg_13_0.proGameHelpKey then
		local var_13_4 = arg_13_0.proGameHelpKey
		local var_13_5 = GameSetting[var_13_4] and GameSetting[var_13_4].value or {}

		if arg_13_0.proGameHelpEnterFunc then
			arg_13_0.proGameHelpEnterFunc()
		end

		local var_13_6 = arg_13_0.proGameHelpExitFunc

		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_13_5,
			exitHandle = function()
				if var_13_6 then
					var_13_6()
				end
			end
		})
	end
end

function var_0_0.SetStoredGameHelper(arg_16_0, arg_16_1)
	arg_16_0.storedGameHelper = arg_16_1
end

function var_0_0.ShowGameHelp(arg_17_0)
	if arg_17_0.infoFunc_ then
		arg_17_0.infoFunc_()
	else
		var_0_7(arg_17_0)
	end
end

function var_0_0.SetGameHelpKey(arg_18_0, arg_18_1)
	arg_18_0.proGameHelpKey = nil
	arg_18_0.gameHelpKey = arg_18_1
end

function var_0_0.SetNormalGameHelpCallback(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.gameHelpEnterFunc = arg_19_1
	arg_19_0.gameHelpExitFunc = arg_19_2
end

function var_0_0.SetGameHelpKeyPro(arg_20_0, arg_20_1)
	arg_20_0.gameHelpKey = nil
	arg_20_0.proGameHelpKey = arg_20_1
end

function var_0_0.SetProGameHelpCallback(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.proGameHelpEnterFunc = arg_21_1
	arg_21_0.proGameHelpExitFunc = arg_21_2
end

function var_0_0.RegistExtraTextAndCallBack(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.clickExtraFunc_ = arg_22_2
end

function var_0_0.GetBackBtnIsShow(arg_23_0)
	if arg_23_0.barGo_ == nil or arg_23_0.barGo_[BACK_BAR] == nil then
		return false
	end

	return arg_23_0.barGo_[BACK_BAR].activeInHierarchy
end

function var_0_0.CallBackFunc(arg_24_0)
	if arg_24_0.backFunc_ then
		arg_24_0.backFunc_()
	else
		JumpTools.Back()
	end
end

local var_0_8 = {
	BACK_BAR,
	HOME_BAR
}

function var_0_0.GetBackBtnIsShow(arg_25_0)
	if arg_25_0.barGo_ == nil or arg_25_0.barGo_[BACK_BAR] == nil then
		return false
	end

	return arg_25_0.barGo_[BACK_BAR].activeInHierarchy
end

function var_0_0.SwitchBar(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if isNil(arg_26_0.gameObject_) then
		arg_26_0:Init()
	end

	if arg_26_2 then
		arg_26_0:HideBar()
	end

	SetActive(arg_26_0.gameObject_, true)

	arg_26_0.isShow_ = true
	arg_26_1 = arg_26_1 or var_0_8
	arg_26_0.lastStyleInfo_ = arg_26_0.styleInfo_ or arg_26_0.lastStyleInfo_ or {}
	arg_26_0.styleInfo_ = arg_26_3 or {}

	if CooperationData:CheckInRoom() then
		local var_26_0 = {}

		for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
			if iter_26_1 == BACK_BAR or iter_26_1 == INFO_BAR then
				table.insert(var_26_0, iter_26_1)
			end
		end

		arg_26_1 = var_26_0
	elseif var_0_6 == "qworld" then
		local var_26_1 = table.indexof(arg_26_1, HOME_BAR)

		if var_26_1 then
			table.remove(arg_26_1, var_26_1)
		end
	end

	if arg_26_0.storedGameHelper and not table.indexof(arg_26_1, INFO_BAR) then
		table.insert(arg_26_1, INFO_BAR)
	end

	for iter_26_2, iter_26_3 in ipairs(arg_26_1) do
		if iter_26_3 == HOME_BAR then
			if manager.guide:IsPlaying() and whereami == "battleResult" then
				arg_26_0:SetActive(arg_26_0.barGo_[iter_26_3], false)
			else
				arg_26_0:SetActive(arg_26_0.barGo_[iter_26_3], true)
			end
		elseif iter_26_3 == BACK_BAR or iter_26_3 == INFO_BAR then
			var_0_0:SetActive(arg_26_0.barGo_[iter_26_3], true)
		elseif iter_26_3 == EXTRA_BAR or iter_26_3 == NAVI_BAR then
			-- block empty
		elseif iter_26_3 == ACTIVITY_MATRIX_COIN then
			local var_26_2 = arg_26_0:getOrAddBarGo_(iter_26_3, arg_26_0.styleInfo_)

			var_0_0:SetActive(var_26_2, true)
			var_26_2:SetCanAdd(false)
		elseif iter_26_3 == ACTIVITY_COIN then
			local var_26_3 = arg_26_0:getOrAddBarGo_(iter_26_3, arg_26_0.styleInfo_)

			var_0_0:SetActive(var_26_3, true)
			var_26_3:SetCanAdd(false)
			var_26_3:SetType("black")
		elseif iter_26_3 == INVITE_BAR then
			if arg_26_0.cooperationInviteTip_ then
				arg_26_0.cooperationInviteTip_:Show()
			end
		elseif ItemCfg[iter_26_3] and ItemCfg[iter_26_3].type == ItemConst.ITEM_TYPE.MATERIAL then
			local var_26_4 = arg_26_0:getOrAddBarGo_(iter_26_3, arg_26_0.styleInfo_)

			var_0_0:SetActive(var_26_4, true)
			var_26_4:SetCanAdd(false)
		else
			local var_26_5 = arg_26_0:getOrAddBarGo_(iter_26_3, arg_26_0.styleInfo_)

			var_0_0:SetActive(var_26_5, true)
			var_26_5:SetCanAdd(false)
		end
	end

	local var_26_6 = arg_26_0:getMappedBarList_(arg_26_1, arg_26_0.styleInfo_)
	local var_26_7 = arg_26_0:getMappedBarList_(arg_26_0.lastBarList_, arg_26_0.lastStyleInfo_)

	for iter_26_4, iter_26_5 in ipairs(var_26_7) do
		if not table.keyof(var_26_6, iter_26_5) and arg_26_0.barGo_[iter_26_5] then
			var_0_0:SetActive(arg_26_0.barGo_[iter_26_5], false)
		end
	end

	if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 0 then
		var_0_0:SetActive(arg_26_0.barGo_[CurrencyConst.GetPlatformDiamondId()], false)
	end

	arg_26_0.lastBarList_ = arg_26_1
	arg_26_0.lastAddBarList_ = {}
	arg_26_0.lastCanClickBarList_ = {}
end

function var_0_0.RegistHomeCallBack(arg_27_0, arg_27_1)
	arg_27_0.homeFunc_ = arg_27_1
	arg_27_0.lastHomeFunc_ = arg_27_1
end

function var_0_0.RegistBackCallBack(arg_28_0, arg_28_1)
	arg_28_0.backFunc_ = arg_28_1
	arg_28_0.lastBackFunc_ = arg_28_1
end

function var_0_0.RegistInfoCallBack(arg_29_0, arg_29_1)
	arg_29_0.infoFunc_ = arg_29_1
	arg_29_0.lastInfoFunc_ = arg_29_1
end

function var_0_0.SetBarCanAdd(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.barGo_[arg_30_0:getMappedKey_(arg_30_1, arg_30_0.styleInfo_)]

	if var_30_0 then
		var_30_0:SetCanAdd(arg_30_2)

		if arg_30_2 then
			table.insert(arg_30_0.lastAddBarList_, arg_30_1)
		end
	end
end

function var_0_0.SetActivityId(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0.barGo_[arg_31_0:getMappedKey_(arg_31_1, arg_31_0.styleInfo_)]

	if var_31_0 and var_31_0.SetActivityId then
		var_31_0:SetActivityId(arg_31_2)
	end
end

function var_0_0.SetBarCanClick(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0.barGo_[arg_32_0:getMappedKey_(arg_32_1, arg_32_0.styleInfo_)]

	if var_32_0 then
		var_32_0:SetCanClick(arg_32_2)

		if arg_32_2 then
			table.insert(arg_32_0.lastCanClickBarList_, arg_32_1)
		end
	end
end

function var_0_0.SetAsLastSibling(arg_33_0)
	arg_33_0.transform_:SetAsLastSibling()
end

function var_0_0.SetAsFirstSibling(arg_34_0)
	arg_34_0.transform_:SetAsFirstSibling()
end

function var_0_0.HideBar(arg_35_0)
	arg_35_0.homeFunc_ = nil
	arg_35_0.backFunc_ = nil
	arg_35_0.infoFunc_ = nil
	arg_35_0.gameHelpEnterFunc = nil
	arg_35_0.gameHelpExitFunc = nil
	arg_35_0.proGameHelpEnterFunc = nil
	arg_35_0.proGameHelpExitFunc = nil

	SetActive(arg_35_0.gameObject_, false)

	if arg_35_0.windowPopTipsItemView_ then
		arg_35_0.windowPopTipsItemView_:Hide()
	end

	if arg_35_0.cooperationInviteTip_ then
		arg_35_0.cooperationInviteTip_:Hide()
	end

	arg_35_0.storedGameHelper = nil
	arg_35_0.isShow_ = false

	arg_35_0:UnBindListener()

	arg_35_0.lastStyleInfo_ = arg_35_0.styleInfo_
	arg_35_0.styleInfo_ = nil
end

function var_0_0.GetIsShow(arg_36_0)
	return arg_36_0.isShow_
end

function var_0_0.GetLastHomeFunc(arg_37_0)
	return arg_37_0.lastHomeFunc_
end

function var_0_0.GetLastBackFunc(arg_38_0)
	return arg_38_0.lastBackFunc_
end

function var_0_0.GetLastInfoFunc(arg_39_0)
	return arg_39_0.lastInfoFunc_
end

function var_0_0.GetLastBarList(arg_40_0)
	return arg_40_0.lastBarList_
end

function var_0_0.GetLastAddBarList(arg_41_0)
	return arg_41_0.lastAddBarList_
end

function var_0_0.GetLastCanClickBarList(arg_42_0)
	return arg_42_0.lastCanClickBarList_
end

function var_0_0.PushWindowBar(arg_43_0, ...)
	arg_43_0.history = arg_43_0.history or {}

	local var_43_0 = {
		show = arg_43_0:GetIsShow(),
		barList = arg_43_0:GetLastBarList(),
		addList = arg_43_0:GetLastAddBarList(),
		clickList = arg_43_0:GetLastCanClickBarList(),
		styleInfo = arg_43_0.lastStyleInfo_,
		back = arg_43_0:GetLastBackFunc(),
		home = arg_43_0:GetLastHomeFunc(),
		info = arg_43_0:GetLastInfoFunc(),
		gameHelpKey = arg_43_0.gameHelpKey
	}

	table.insert(arg_43_0.history, var_43_0)
	arg_43_0:SwitchBar(...)
end

function var_0_0.PopWindowBar(arg_44_0)
	if arg_44_0.history and #arg_44_0.history > 0 then
		local var_44_0 = table.remove(arg_44_0.history)

		if var_44_0.show then
			arg_44_0:SwitchBar(var_44_0.barList, true, var_44_0.styleInfo)

			for iter_44_0, iter_44_1 in pairs(var_44_0.addList) do
				arg_44_0:SetBarCanAdd(iter_44_1, true)
			end

			for iter_44_2, iter_44_3 in pairs(var_44_0.clickList) do
				arg_44_0:SetBarCanClick(iter_44_3, true)
			end

			arg_44_0:RegistBackCallBack(var_44_0.back)
			arg_44_0:RegistHomeCallBack(var_44_0.home)
			arg_44_0:RegistInfoCallBack(var_44_0.info)
			arg_44_0:SetGameHelpKey(var_44_0.gameHelpKey)
		else
			arg_44_0:HideBar()
		end
	end
end

function var_0_0.UnBindListener(arg_45_0)
	for iter_45_0, iter_45_1 in pairs(arg_45_0.barGo_ or {}) do
		if iter_45_0 == BACK_BAR or iter_45_0 == HOME_BAR or iter_45_0 == NAVI_BAR or iter_45_0 == INFO_BAR or iter_45_0 == EXTRA_BAR then
			-- block empty
		else
			iter_45_1:UnBindListener()
		end
	end
end

function var_0_0.IsInited(arg_46_0)
	return not isNil(arg_46_0.gameObject_)
end

function var_0_0.OnClickCurrencyBar(arg_47_0)
	if arg_47_0.countdownGo_.activeInHierarchy then
		return
	end

	local var_47_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
	local var_47_1 = var_47_0
	local var_47_2 = PlayerData:GetPlayerInfo().userLevel
	local var_47_3 = GameLevelSetting[var_47_2].fatigue_max

	arg_47_0:StopTimer()

	if var_47_0 < var_47_3 then
		local var_47_4 = GameSetting.fatigue_recovery.value[1] * 60
		local var_47_5 = CurrencyData:GetLastFatigueRecoverTime() == 0 and var_47_4 or var_47_4 - (manager.time:GetServerTime() - CurrencyData:GetLastFatigueRecoverTime()) % var_47_4
		local var_47_6 = (var_47_3 - var_47_0 - 1) * var_47_4 + (var_47_5 == var_47_4 and var_47_0 == var_47_1 and 0 or var_47_5)

		arg_47_0.time_.text = string.format("%02d:%02d:%02d", math.floor(var_47_5 / 3600), math.floor(var_47_5 % 3600 / 60), var_47_5 % 60)
		arg_47_0.allTime_.text = string.format("%02d:%02d:%02d", math.floor(var_47_6 / 3600), math.floor(var_47_6 % 3600 / 60), var_47_6 % 60)
		arg_47_0.timer_ = Timer.New(function()
			var_47_5 = CurrencyData:GetLastFatigueRecoverTime() == 0 and var_47_4 or var_47_4 - (manager.time:GetServerTime() - CurrencyData:GetLastFatigueRecoverTime()) % var_47_4
			var_47_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
			var_47_6 = (var_47_3 - var_47_0 - 1) * var_47_4 + (var_47_5 == var_47_4 and var_47_0 == var_47_1 and 0 or var_47_5)

			if var_47_5 <= 0 then
				var_47_5 = 0
			end

			if var_47_6 <= 0 then
				var_47_6 = 0
			end

			arg_47_0.time_.text = string.format("%02d:%02d:%02d", math.floor(var_47_5 / 3600), math.floor(var_47_5 % 3600 / 60), var_47_5 % 60)
			arg_47_0.allTime_.text = string.format("%02d:%02d:%02d", math.floor(var_47_6 / 3600), math.floor(var_47_6 % 3600 / 60), var_47_6 % 60)
			var_47_1 = var_47_0
		end, 1, -1)

		arg_47_0.timer_:Start()
	else
		arg_47_0.time_.text = "00:00:00"
		arg_47_0.allTime_.text = "00:00:00"
	end

	SetActive(arg_47_0.countdownGo_, true)
	SetActive(arg_47_0.bgBtn_.gameObject, true)
end

function var_0_0.OnStopTimer(arg_49_0)
	arg_49_0.time_.text = "00:00:00"
	arg_49_0.allTime_.text = "00:00:00"

	arg_49_0:StopTimer()
	SetActive(arg_49_0.countdownGo_, false)
	SetActive(arg_49_0.bgBtn_.gameObject, false)
end

function var_0_0.StopTimer(arg_50_0)
	if arg_50_0.timer_ then
		arg_50_0.timer_:Stop()

		arg_50_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_51_0)
	var_0_0.super.Dispose(arg_51_0)
	arg_51_0:StopTimer()

	for iter_51_0, iter_51_1 in pairs(arg_51_0.barGo_ or {}) do
		if iter_51_0 == BACK_BAR or iter_51_0 == HOME_BAR or iter_51_0 == NAVI_BAR or iter_51_0 == INFO_BAR or iter_51_0 == EXTRA_BAR then
			-- block empty
		else
			local var_51_0 = iter_51_1.gameObject_

			iter_51_1:Dispose()
			Object.Destroy(var_51_0)
		end
	end

	arg_51_0.barGo_ = nil

	if arg_51_0.windowPopTipsItemView_ then
		arg_51_0.windowPopTipsItemView_:Dispose()

		arg_51_0.windowPopTipsItemView_ = nil
	end

	if arg_51_0.cooperationInviteTip_ then
		arg_51_0.cooperationInviteTip_:Dispose()

		arg_51_0.cooperationInviteTip_ = nil
	end

	if not isNil(arg_51_0.gameObject_) then
		var_0_0.super.Dispose(arg_51_0)
		Object.Destroy(arg_51_0.gameObject_)

		arg_51_0.gameObject_ = nil
		arg_51_0.transform_ = nil
	end

	arg_51_0.currencyItem_ = nil
	arg_51_0.backBtn_ = nil
	arg_51_0.homeBtn_ = nil
	arg_51_0.infoBtn_ = nil
	arg_51_0.currencyList_ = nil
	arg_51_0.isShow_ = false
end

function var_0_0.SetActive(arg_52_0, arg_52_1, arg_52_2)
	if type(arg_52_1) == "table" then
		arg_52_1:SetActive(arg_52_2)
	elseif arg_52_1 then
		SetActive(arg_52_1, arg_52_2)
	end
end

function var_0_0.getMappedKey_(arg_53_0, arg_53_1, arg_53_2)
	if arg_53_2 and arg_53_2.prefix then
		return arg_53_2.prefix .. arg_53_1
	else
		return arg_53_1
	end
end

function var_0_0.getOrAddBarGo_(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = arg_54_0:getMappedKey_(arg_54_1, arg_54_2)
	local var_54_1 = arg_54_0.barGo_[var_54_0]

	if not var_54_1 then
		local var_54_2 = arg_54_0:getBarTemplate_(arg_54_2)
		local var_54_3 = arg_54_0:getBarClass_(arg_54_1, arg_54_2)
		local var_54_4 = Object.Instantiate(var_54_2, arg_54_0.currencyList_.transform)

		var_54_1 = var_54_3.New(var_54_4, arg_54_1)
		arg_54_0.barGo_[var_54_0] = var_54_1

		if arg_54_1 == CurrencyConst.CURRENCY_TYPE_VITALITY then
			arg_54_0.countdownGo_.transform:SetParent(var_54_4.transform)

			arg_54_0.countdownGo_.transform:GetComponent("RectTransform").anchoredPosition = Vector2(0, -50)

			var_54_1:RegistClickFunc(handler(arg_54_0, arg_54_0.OnClickCurrencyBar))
			var_54_1:RegistTimeFunc(handler(arg_54_0, arg_54_0.OnStopTimer))
		end
	end

	return var_54_1
end

function var_0_0.getBarTemplate_(arg_55_0, arg_55_1)
	if arg_55_1 and arg_55_1.prefix and arg_55_1.prefix == "HOME:" then
		return arg_55_0.currencyItemMainHome_ or arg_55_0.currencyItem_
	end

	return arg_55_0.currencyItem_
end

function var_0_0.getBarClass_(arg_56_0, arg_56_1, arg_56_2)
	if arg_56_1 == ACTIVITY_MATRIX_COIN then
		return var_0_3
	elseif arg_56_1 == ACTIVITY_COIN then
		return var_0_4
	elseif ItemCfg[arg_56_1] then
		if ItemCfg[arg_56_1].type == ItemConst.ITEM_TYPE.MATERIAL then
			return var_0_2
		else
			return var_0_1
		end
	elseif type(arg_56_1) == "table" and arg_56_1.GetBarClass then
		return arg_56_1:GetBarClass(arg_56_2)
	end
end

function var_0_0.getMappedBarList_(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_2 == nil or arg_57_2.prefix == nil then
		return arg_57_1
	end

	local var_57_0 = {}

	for iter_57_0, iter_57_1 in ipairs(arg_57_1) do
		table.insert(var_57_0, arg_57_0:getMappedKey_(iter_57_1, arg_57_2))
	end

	return var_57_0
end

return var_0_0

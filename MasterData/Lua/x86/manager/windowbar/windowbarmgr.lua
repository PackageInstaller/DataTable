local WindowBarMgr = class("WindowBarMgr", import("game.extend.ReduxView"))
local WindowCurrencyItem = import("manager.windowBar.WindowCurrencyItem")
local WindowMaterialItem = import("manager.windowBar.WindowMaterialItem")
local WindowActivityMatrixCoinItem = import("manager.windowBar.WindowActivityMatrixCoinItem")
local WindowActivityCoinItem = import("manager.windowBar.WindowActivityCoinItem")
local WindowPopTipsItem = import("manager.windowBar.WindowPopTipsItem")

import("manager.windowBar.WindowBarDef")

local var_0_6

function WindowBarMgr:UIName()
	return "Widget/System/Com_dynamic/WindowBarUI"
end

function WindowBarMgr:OnCtor()
	print("Initialize Window")
end

function WindowBarMgr:Init()
	self.lastBarList_ = {}
	self.lastAddBarList_ = {}
	self.lastCanClickBarList_ = {}
	self.styleInfo_ = {}
	self.lastStyleInfo_ = {}

	self:InitUI()
	self:AddListeners()

	self.windowPopTipsItemView_ = WindowPopTipsItem.New(self.goTips_)
end

function WindowBarMgr:InitUI()
	self.gameObject_ = GameObject.Instantiate(Asset.Load(self:UIName()), manager.ui.uiPop.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AdaptScreen()

	self.barGo_ = {}
	self.barGo_[HOME_BAR] = self.homeBtn_.gameObject
	self.barGo_[BACK_BAR] = self.backBtn_.gameObject
	self.barGo_[INFO_BAR] = self.infoBtn_.gameObject
	self.storedGameHelper = nil
	self.isShow_ = false
	self.cooperationInviteTip_ = CooperationInviteTipItem.New(self.m_cooperationInviteTip)
end

function WindowBarMgr:SetWhereTag(arg_5_1)
	var_0_6 = arg_5_1
end

function WindowBarMgr:ClearWhereTag()
	var_0_6 = nil
end

function WindowBarMgr:GetWhereTag()
	return var_0_6
end

function WindowBarMgr:AddListeners()
	self:AddBtnListener(self.homeBtn_, nil, function()
		OperationRecorder.Record(gameContext:GetLastOpenPage(), "homeBtn")

		if self.homeFunc_ then
			self.homeFunc_()
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
			local var_9_1 = var_9_0 ~= nil and var_9_0 > 0 and table.indexof(ActivityClubMapCfg.all, ActivityClubCfg[var_9_0].map_id) or 1

			gameContext:Go("/guildActivityWarField", {
				level = var_9_1,
				activityID = ActivityConst.GUILD_ACTIVITY_START
			})
		elseif var_0_6 == "guildActivitySP" then
			local var_9_2 = GuildActivitySPData:GetCurrentGrid()
			local var_9_3 = var_9_2 ~= nil and var_9_2 > 0 and table.indexof(ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()], ActivityClubSPCfg[var_9_2].map_id) or 1
			local var_9_4 = GuildActivitySPData:GetCurRunActivityID()

			gameContext:Go("/guildActivitySPWarField", {
				level = var_9_3,
				activityID = var_9_4,
				totalActivityID = var_9_4
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
	self:AddBtnListener(self.backBtn_, nil, function()
		OperationRecorder.Record(gameContext:GetLastOpenPage(), "backBtn")
		self:CallBackFunc()
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		OperationRecorder.Record(gameContext:GetLastOpenPage(), "infoBtn")
		self:ShowGameHelp()
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:StopTimer()
		SetActive(self.countdownGo_, false)
		SetActive(self.bgBtn_.gameObject, false)
	end)
end

local function var_0_7(arg_13_0)
	if type(arg_13_0.gameHelpKey) == "table" then
		if arg_13_0.gameHelpKey.type == "jump" then
			JumpTools.OpenPageByJump(arg_13_0.gameHelpKey.view, arg_13_0.gameHelpKey.params)
		end
	elseif arg_13_0.gameHelpKey then
		if arg_13_0.gameHelpEnterFunc then
			arg_13_0.gameHelpEnterFunc()
		end

		local var_13_0 = arg_13_0.gameHelpExitFunc

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips(arg_13_0.gameHelpKey),
			key = arg_13_0.gameHelpKey,
			exitFunc = function()
				if var_13_0 then
					var_13_0()
				end
			end
		})
	elseif arg_13_0.proGameHelpKey then
		local var_13_1

		if GameSetting[arg_13_0.proGameHelpKey] then
			var_13_1 = GameSetting[arg_13_0.proGameHelpKey].value or {}

			if arg_13_0.proGameHelpEnterFunc then
				arg_13_0.proGameHelpEnterFunc()
			end
		end

		local var_13_2 = arg_13_0.proGameHelpExitFunc

		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_13_1,
			exitHandle = function()
				if var_13_2 then
					var_13_2()
				end
			end
		})
	end
end

function WindowBarMgr:SetStoredGameHelper(arg_16_1)
	self.storedGameHelper = arg_16_1
end

function WindowBarMgr:ShowGameHelp()
	if self.infoFunc_ then
		self.infoFunc_()
	else
		var_0_7(self)
	end
end

function WindowBarMgr:SetGameHelpKey(arg_18_1)
	self.proGameHelpKey = nil
	self.gameHelpKey = arg_18_1
end

function WindowBarMgr:SetNormalGameHelpCallback(arg_19_1, arg_19_2)
	self.gameHelpEnterFunc = arg_19_1
	self.gameHelpExitFunc = arg_19_2
end

function WindowBarMgr:SetGameHelpKeyPro(arg_20_1)
	self.gameHelpKey = nil
	self.proGameHelpKey = arg_20_1
end

function WindowBarMgr:SetProGameHelpCallback(arg_21_1, arg_21_2)
	self.proGameHelpEnterFunc = arg_21_1
	self.proGameHelpExitFunc = arg_21_2
end

function WindowBarMgr:RegistExtraTextAndCallBack(arg_22_1, arg_22_2)
	self.clickExtraFunc_ = arg_22_2
end

function WindowBarMgr:GetBackBtnIsShow()
	if self.barGo_ == nil or self.barGo_[BACK_BAR] == nil then
		return false
	end

	return self.barGo_[BACK_BAR].activeInHierarchy
end

function WindowBarMgr:CallBackFunc()
	if self.backFunc_ then
		self.backFunc_()
	else
		JumpTools.Back()
	end
end

local var_0_8 = {
	BACK_BAR,
	HOME_BAR
}

function WindowBarMgr:GetBackBtnIsShow()
	if self.barGo_ == nil or self.barGo_[BACK_BAR] == nil then
		return false
	end

	return self.barGo_[BACK_BAR].activeInHierarchy
end

function WindowBarMgr:SwitchBar(arg_26_1, arg_26_2, arg_26_3)
	if isNil(self.gameObject_) then
		self:Init()
	end

	if arg_26_2 then
		self:HideBar()
	end

	SetActive(self.gameObject_, true)

	self.isShow_ = true
	arg_26_1 = arg_26_1 or var_0_8
	self.lastStyleInfo_ = self.styleInfo_ or self.lastStyleInfo_ or {}
	self.styleInfo_ = arg_26_3 or {}

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

	if self.storedGameHelper and not table.indexof(arg_26_1, INFO_BAR) then
		table.insert(arg_26_1, INFO_BAR)
	end

	for iter_26_2, iter_26_3 in ipairs(arg_26_1) do
		if iter_26_3 == HOME_BAR then
			if manager.guide:IsPlaying() and whereami == "battleResult" then
				self:SetActive(self.barGo_[iter_26_3], false)
			else
				self:SetActive(self.barGo_[iter_26_3], true)
			end
		elseif iter_26_3 == BACK_BAR or iter_26_3 == INFO_BAR then
			WindowBarMgr:SetActive(self.barGo_[iter_26_3], true)
		elseif iter_26_3 == EXTRA_BAR or iter_26_3 == NAVI_BAR then
			-- block empty
		elseif iter_26_3 == ACTIVITY_MATRIX_COIN then
			local var_26_2 = self:getOrAddBarGo_(iter_26_3, self.styleInfo_)

			WindowBarMgr:SetActive(var_26_2, true)
			var_26_2:SetCanAdd(false)
		elseif iter_26_3 == ACTIVITY_COIN then
			local var_26_3 = self:getOrAddBarGo_(iter_26_3, self.styleInfo_)

			WindowBarMgr:SetActive(var_26_3, true)
			var_26_3:SetCanAdd(false)
			var_26_3:SetType("black")
		elseif iter_26_3 == INVITE_BAR then
			if self.cooperationInviteTip_ then
				self.cooperationInviteTip_:Show()
			end
		elseif ItemCfg[iter_26_3] and ItemCfg[iter_26_3].type == ItemConst.ITEM_TYPE.MATERIAL then
			local var_26_4 = self:getOrAddBarGo_(iter_26_3, self.styleInfo_)

			WindowBarMgr:SetActive(var_26_4, true)
			var_26_4:SetCanAdd(false)
		else
			local var_26_5 = self:getOrAddBarGo_(iter_26_3, self.styleInfo_)

			WindowBarMgr:SetActive(var_26_5, true)
			var_26_5:SetCanAdd(false)
		end
	end

	local var_26_6 = self:getMappedBarList_(arg_26_1, self.styleInfo_)

	for iter_26_4, iter_26_5 in ipairs((self:getMappedBarList_(self.lastBarList_, self.lastStyleInfo_))) do
		if not table.keyof(var_26_6, iter_26_5) and self.barGo_[iter_26_5] then
			WindowBarMgr:SetActive(self.barGo_[iter_26_5], false)
		end
	end

	if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 0 then
		WindowBarMgr:SetActive(self.barGo_[CurrencyConst.GetPlatformDiamondId()], false)
	end

	self.lastBarList_ = arg_26_1
	self.lastAddBarList_ = {}
	self.lastCanClickBarList_ = {}
end

function WindowBarMgr:RegistHomeCallBack(arg_27_1)
	self.homeFunc_ = arg_27_1
	self.lastHomeFunc_ = arg_27_1
end

function WindowBarMgr:RegistBackCallBack(arg_28_1)
	self.backFunc_ = arg_28_1
	self.lastBackFunc_ = arg_28_1
end

function WindowBarMgr:RegistInfoCallBack(arg_29_1)
	self.infoFunc_ = arg_29_1
	self.lastInfoFunc_ = arg_29_1
end

function WindowBarMgr:SetBarCanAdd(arg_30_1, arg_30_2)
	local var_30_0 = self.barGo_[self:getMappedKey_(arg_30_1, self.styleInfo_)]

	if var_30_0 then
		var_30_0:SetCanAdd(arg_30_2)

		if arg_30_2 then
			table.insert(self.lastAddBarList_, arg_30_1)
		end
	end
end

function WindowBarMgr:SetActivityId(arg_31_1, arg_31_2)
	local var_31_0 = self.barGo_[self:getMappedKey_(arg_31_1, self.styleInfo_)]

	if var_31_0 and var_31_0.SetActivityId then
		var_31_0:SetActivityId(arg_31_2)
	end
end

function WindowBarMgr:SetBarCanClick(arg_32_1, arg_32_2)
	local var_32_0 = self.barGo_[self:getMappedKey_(arg_32_1, self.styleInfo_)]

	if var_32_0 then
		var_32_0:SetCanClick(arg_32_2)

		if arg_32_2 then
			table.insert(self.lastCanClickBarList_, arg_32_1)
		end
	end
end

function WindowBarMgr:SetAsLastSibling()
	self.transform_:SetAsLastSibling()
end

function WindowBarMgr:SetAsFirstSibling()
	self.transform_:SetAsFirstSibling()
end

function WindowBarMgr:HideBar()
	self.homeFunc_ = nil
	self.backFunc_ = nil
	self.infoFunc_ = nil
	self.gameHelpEnterFunc = nil
	self.gameHelpExitFunc = nil
	self.proGameHelpEnterFunc = nil
	self.proGameHelpExitFunc = nil

	SetActive(self.gameObject_, false)

	if self.windowPopTipsItemView_ then
		self.windowPopTipsItemView_:Hide()
	end

	if self.cooperationInviteTip_ then
		self.cooperationInviteTip_:Hide()
	end

	self.storedGameHelper = nil
	self.isShow_ = false

	self:UnBindListener()

	self.lastStyleInfo_ = self.styleInfo_
	self.styleInfo_ = nil
end

function WindowBarMgr:GetIsShow()
	return self.isShow_
end

function WindowBarMgr:GetLastHomeFunc()
	return self.lastHomeFunc_
end

function WindowBarMgr:GetLastBackFunc()
	return self.lastBackFunc_
end

function WindowBarMgr:GetLastInfoFunc()
	return self.lastInfoFunc_
end

function WindowBarMgr:GetLastBarList()
	return self.lastBarList_
end

function WindowBarMgr:GetLastAddBarList()
	return self.lastAddBarList_
end

function WindowBarMgr:GetLastCanClickBarList()
	return self.lastCanClickBarList_
end

function WindowBarMgr:PushWindowBar(...)
	self.history = self.history or {}

	table.insert(self.history, {
		show = self:GetIsShow(),
		barList = self:GetLastBarList(),
		addList = self:GetLastAddBarList(),
		clickList = self:GetLastCanClickBarList(),
		styleInfo = self.lastStyleInfo_,
		back = self:GetLastBackFunc(),
		home = self:GetLastHomeFunc(),
		info = self:GetLastInfoFunc(),
		gameHelpKey = self.gameHelpKey
	})
	self:SwitchBar(...)
end

function WindowBarMgr:PopWindowBar()
	if self.history and #self.history > 0 then
		local var_44_0 = table.remove(self.history)

		if var_44_0.show then
			self:SwitchBar(var_44_0.barList, true, var_44_0.styleInfo)

			for iter_44_0, iter_44_1 in pairs(var_44_0.addList) do
				self:SetBarCanAdd(iter_44_1, true)
			end

			for iter_44_2, iter_44_3 in pairs(var_44_0.clickList) do
				self:SetBarCanClick(iter_44_3, true)
			end

			self:RegistBackCallBack(var_44_0.back)
			self:RegistHomeCallBack(var_44_0.home)
			self:RegistInfoCallBack(var_44_0.info)
			self:SetGameHelpKey(var_44_0.gameHelpKey)
		else
			self:HideBar()
		end
	end
end

function WindowBarMgr:UnBindListener()
	for iter_45_0, iter_45_1 in pairs(self.barGo_ or {}) do
		if iter_45_0 == BACK_BAR or iter_45_0 == HOME_BAR or iter_45_0 == NAVI_BAR or iter_45_0 == INFO_BAR or iter_45_0 == EXTRA_BAR then
			-- block empty
		else
			iter_45_1:UnBindListener()
		end
	end
end

function WindowBarMgr:IsInited()
	return not isNil(self.gameObject_)
end

function WindowBarMgr:OnClickCurrencyBar()
	if self.countdownGo_.activeInHierarchy then
		return
	end

	local var_47_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
	local var_47_1 = var_47_0
	local var_47_2 = GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max

	self:StopTimer()

	if var_47_0 < var_47_2 then
		local var_47_3 = GameSetting.fatigue_recovery.value[1] * 60
		local var_47_4

		if CurrencyData:GetLastFatigueRecoverTime() ~= 0 or not var_47_3 then
			::label_47_0::

			var_47_4 = var_47_3 - (manager.time:GetServerTime() - CurrencyData:GetLastFatigueRecoverTime()) % var_47_3
		end

		local var_47_5 = (var_47_2 - var_47_0 - 1) * var_47_3 + (var_47_4 == var_47_3 and var_47_0 == var_47_1 and 0 or var_47_4)

		self.time_.text = string.format("%02d:%02d:%02d", math.floor(var_47_4 / 3600), math.floor(var_47_4 % 3600 / 60), var_47_4 % 60)
		self.allTime_.text = string.format("%02d:%02d:%02d", math.floor(var_47_5 / 3600), math.floor(var_47_5 % 3600 / 60), var_47_5 % 60)
		self.timer_ = Timer.New(function()
			if CurrencyData:GetLastFatigueRecoverTime() == 0 then
				var_47_4 = var_47_3 or var_47_3 - (manager.time:GetServerTime() - CurrencyData:GetLastFatigueRecoverTime()) % var_47_3
			end

			var_47_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
			var_47_5 = (var_47_2 - var_47_0 - 1) * var_47_3 + (var_47_4 == var_47_3 and var_47_0 == var_47_1 and 0 or var_47_4)

			if var_47_4 <= 0 then
				var_47_4 = 0
			end

			if var_47_5 <= 0 then
				var_47_5 = 0
			end

			self.time_.text = string.format("%02d:%02d:%02d", math.floor(var_47_4 / 3600), math.floor(var_47_4 % 3600 / 60), var_47_4 % 60)
			self.allTime_.text = string.format("%02d:%02d:%02d", math.floor(var_47_5 / 3600), math.floor(var_47_5 % 3600 / 60), var_47_5 % 60)
			var_47_1 = var_47_0
		end, 1, -1)

		self.timer_:Start()
	else
		self.time_.text = "00:00:00"
		self.allTime_.text = "00:00:00"
	end

	SetActive(self.countdownGo_, true)
	SetActive(self.bgBtn_.gameObject, true)
end

function WindowBarMgr:OnStopTimer()
	self.time_.text = "00:00:00"
	self.allTime_.text = "00:00:00"

	self:StopTimer()
	SetActive(self.countdownGo_, false)
	SetActive(self.bgBtn_.gameObject, false)
end

function WindowBarMgr:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function WindowBarMgr:Dispose()
	WindowBarMgr.super.Dispose(self)
	self:StopTimer()

	for iter_51_0, iter_51_1 in pairs(self.barGo_ or {}) do
		if iter_51_0 == BACK_BAR or iter_51_0 == HOME_BAR or iter_51_0 == NAVI_BAR or iter_51_0 == INFO_BAR or iter_51_0 == EXTRA_BAR then
			-- block empty
		else
			local var_51_0 = iter_51_1.gameObject_

			iter_51_1:Dispose()
			Object.Destroy(var_51_0)
		end
	end

	self.barGo_ = nil

	if self.windowPopTipsItemView_ then
		self.windowPopTipsItemView_:Dispose()

		self.windowPopTipsItemView_ = nil
	end

	if self.cooperationInviteTip_ then
		self.cooperationInviteTip_:Dispose()

		self.cooperationInviteTip_ = nil
	end

	if not isNil(self.gameObject_) then
		WindowBarMgr.super.Dispose(self)
		Object.Destroy(self.gameObject_)

		self.gameObject_ = nil
		self.transform_ = nil
	end

	self.currencyItem_ = nil
	self.backBtn_ = nil
	self.homeBtn_ = nil
	self.infoBtn_ = nil
	self.currencyList_ = nil
	self.isShow_ = false
end

function WindowBarMgr:SetActive(arg_52_1, arg_52_2)
	if type(arg_52_1) == "table" then
		arg_52_1:SetActive(arg_52_2)
	elseif arg_52_1 then
		SetActive(arg_52_1, arg_52_2)
	end
end

function WindowBarMgr:getMappedKey_(arg_53_1, arg_53_2)
	if arg_53_2 and arg_53_2.prefix then
		return arg_53_2.prefix .. arg_53_1
	else
		return arg_53_1
	end
end

function WindowBarMgr:getOrAddBarGo_(arg_54_1, arg_54_2)
	local var_54_0 = self:getMappedKey_(arg_54_1, arg_54_2)
	local var_54_1 = self.barGo_[var_54_0]

	if not self.barGo_[var_54_0] then
		var_54_1 = self:getBarClass_(arg_54_1, arg_54_2):New(arg_54_1)
		self.barGo_[var_54_0] = var_54_1

		if arg_54_1 == CurrencyConst.CURRENCY_TYPE_VITALITY then
			self.countdownGo_.transform:SetParent(Object.Instantiate(self:getBarTemplate_(arg_54_2), self.currencyList_.transform).transform)

			self.countdownGo_.transform:GetComponent("RectTransform").anchoredPosition = Vector2(0, -50)

			var_54_1:RegistClickFunc(handler(self, self.OnClickCurrencyBar))
			var_54_1:RegistTimeFunc(handler(self, self.OnStopTimer))
		end
	end

	return var_54_1
end

function WindowBarMgr:getBarTemplate_(arg_55_1)
	if arg_55_1 and arg_55_1.prefix and arg_55_1.prefix == "HOME:" then
		return self.currencyItemMainHome_ or self.currencyItem_
	end

	return self.currencyItem_
end

function WindowBarMgr:getBarClass_(arg_56_1, arg_56_2)
	if arg_56_1 == ACTIVITY_MATRIX_COIN then
		return WindowActivityMatrixCoinItem
	elseif arg_56_1 == ACTIVITY_COIN then
		return WindowActivityCoinItem
	elseif ItemCfg[arg_56_1] then
		if ItemCfg[arg_56_1].type == ItemConst.ITEM_TYPE.MATERIAL then
			return WindowMaterialItem
		else
			return WindowCurrencyItem
		end
	elseif type(arg_56_1) == "table" and arg_56_1.GetBarClass then
		return arg_56_1:GetBarClass(arg_56_2)
	end
end

function WindowBarMgr:getMappedBarList_(arg_57_1, arg_57_2)
	if arg_57_2 == nil or arg_57_2.prefix == nil then
		return arg_57_1
	end

	local var_57_0 = {}

	for iter_57_0, iter_57_1 in ipairs(arg_57_1) do
		table.insert(var_57_0, self:getMappedKey_(iter_57_1, arg_57_2))
	end

	return var_57_0
end

return WindowBarMgr

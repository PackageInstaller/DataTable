local var_0_0 = class("GuildRecommendView", ReduxView)
local var_0_1 = 10

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club/ClubFoundedUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.recommendUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.uiList_, GuildRecommendItem)
	arg_3_0.clubController_ = arg_3_0.controller:GetController("None")
	arg_3_0.btnComtroller = arg_3_0.controller:GetController("btn")
	arg_3_0.emptytroller = arg_3_0.controller:GetController("descEmpty")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:AddRefreshStamptime()
	arg_4_0:RefreshScroll()
	arg_4_0:RegisterEvent()
end

function var_0_0.OnTop(arg_5_0)
	arg_5_0:RefreshWinBar()
end

function var_0_0.OnExit(arg_6_0)
	manager.windowBar:HideBar()
	arg_6_0:StopRefreshStamptime()
	arg_6_0:RemoveAllEventListener()
end

function var_0_0.RefreshWinBar(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:RegistBackCallBack(function()
		arg_7_0:Back(2)
	end)
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)

	if arg_9_0.recommendUIList_ then
		arg_9_0.recommendUIList_:Dispose()

		arg_9_0.recommendUIList_ = nil
	end
end

function var_0_0.RegisterEvent(arg_10_0)
	arg_10_0:RegistEventListener(GUILD_RECOMMEND_CLICK, handler(arg_10_0, arg_10_0.ClickRecommendItem))
end

function var_0_0.AddListeners(arg_11_0)
	arg_11_0:AddBtnListener(arg_11_0.buttonSearch_, nil, function()
		if arg_11_0.inputField_.text == "" then
			return
		end

		local var_12_0 = tonumber(arg_11_0.inputField_.text)

		if var_12_0 == nil or var_12_0 < 0 then
			arg_11_0.inputField_.text = ""

			return ShowTips("ERROR_CLUB_NOT_EXIST")
		end

		GuildAction.SearchGuild(tonumber(arg_11_0.inputField_.text), function(arg_13_0)
			if isSuccess(arg_13_0.result) then
				ShowTips(arg_13_0.result)

				arg_11_0.searchFlag_ = true
				arg_11_0.inputField_.text = ""

				arg_11_0:RefreshScroll()
			else
				ShowTips(arg_13_0.result)
			end
		end)
	end)
	arg_11_0:AddBtnListener(arg_11_0.buttonRefresh_, nil, function()
		arg_11_0:ClickRefreshBtn()
	end)
	arg_11_0:AddBtnListener(arg_11_0.buttonJoin_, nil, function()
		if OperationData:IsFunctionStoped(OperationConst.OPERATION_STOP.JOIN_CLUB) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		SDKTools.SendMessageToSDK("club_member_manage_jump", {
			source = 3
		})

		local var_15_0 = arg_11_0:GetItemData()[arg_11_0.selectIndex_]

		GuildAction.GuildRequestJoin(var_15_0.id, function(arg_16_0)
			GuildData:AddJoinData(var_15_0.id)
			arg_11_0:RefreshInfo()
		end)
	end)
	arg_11_0:AddBtnListener(arg_11_0.foundBtn, nil, function()
		JumpTools.OpenPageByJump("guildFoundedView")
	end)
	arg_11_0:AddBtnListener(arg_11_0.copyIDBtn, nil, function()
		local var_18_0 = arg_11_0:GetItemData()

		if arg_11_0.selectIndex_ and var_18_0[arg_11_0.selectIndex_] then
			UnityEngine.GUIUtility.systemCopyBuffer = var_18_0[arg_11_0.selectIndex_].id

			ShowTips("COPY_SUCCESS")
		end
	end)
end

function var_0_0.ClickRefreshBtn(arg_19_0)
	if GuildData:GetRecommendRefreshStamptime() + var_0_1 > manager.time:GetServerTime() then
		return
	end

	GuildAction.RequiredGuildRecommendList(function(arg_20_0)
		if isSuccess(arg_20_0.result) then
			GuildData:SetRecommendRefreshStamptime()

			arg_19_0.searchFlag_ = false

			arg_19_0:AddRefreshStamptime()
			arg_19_0:RefreshScroll()
		else
			ShowTips(arg_20_0.result)
		end
	end)
end

function var_0_0.RefreshScroll(arg_21_0)
	local var_21_0 = arg_21_0:GetItemData()

	arg_21_0.selectIndex_ = 1

	if #var_21_0 <= 0 then
		arg_21_0.clubController_:SetSelectedState("false")
	else
		arg_21_0.clubController_:SetSelectedState("true")
	end

	arg_21_0.recommendUIList_:StartScroll(#var_21_0, arg_21_0.selectIndex_)
	arg_21_0:RefreshInfo()
end

function var_0_0.RefreshItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:GetItemData()

	arg_22_2:SetData(arg_22_1, var_22_0[arg_22_1], arg_22_1 == arg_22_0.selectIndex_)
end

function var_0_0.ClickRecommendItem(arg_23_0, arg_23_1)
	arg_23_0.selectIndex_ = arg_23_1

	arg_23_0:RefreshInfo()
end

function var_0_0.RefreshInfo(arg_24_0)
	local var_24_0 = arg_24_0:GetItemData()[arg_24_0.selectIndex_]

	if var_24_0 == nil then
		return
	end

	arg_24_0.textName_.text = GetI18NText(var_24_0.name)
	arg_24_0.textMember_.text = string.format("%s/%s", var_24_0.member, var_24_0.maxMemberCnt)
	arg_24_0.textLevel_.text = string.format(GetTips("CLUB_LEVEL"), var_24_0.level)
	arg_24_0.textContribute_.text = GetI18NText(var_24_0.contribute)
	arg_24_0.textID_.text = var_24_0.id

	if var_24_0.notice and var_24_0.notice ~= "" then
		arg_24_0.emptytroller:SetSelectedState("full")

		arg_24_0.textNotice_.text = GetI18NText(var_24_0.notice)
	else
		arg_24_0.emptytroller:SetSelectedState("empty")
	end

	local var_24_1 = ClubHeadIconCfg[var_24_0.icon]

	arg_24_0.imageIcon_.sprite = getSpriteViaConfig("ClubHeadIcon", var_24_1.icon_bg)

	arg_24_0:RefreshBtnState()
end

function var_0_0.RefreshBtnState(arg_25_0)
	local var_25_0 = arg_25_0:GetItemData()[arg_25_0.selectIndex_]

	if var_25_0 == nil then
		return
	end

	arg_25_0.btnComtroller:SetSelectedState("can")

	if OperationData:IsFunctionStoped(OperationConst.OPERATION_STOP.JOIN_CLUB) then
		arg_25_0.btnComtroller:SetSelectedState("no")

		return
	end

	if var_25_0.is_requested and var_25_0.is_requested == 1 then
		arg_25_0.btnComtroller:SetSelectedState("had")

		return
	end
end

function var_0_0.GetItemData(arg_26_0)
	if arg_26_0.searchFlag_ then
		return GuildData:GetSearchList()
	else
		return GuildData:GetRecommendList()
	end
end

function var_0_0.AddRefreshStamptime(arg_27_0)
	arg_27_0:RefreshCDText()
	arg_27_0:StopRefreshStamptime()

	arg_27_0.refreshTimer_ = Timer.New(function()
		arg_27_0:RefreshCDText()
	end, 1, -1)

	arg_27_0.refreshTimer_:Start()
end

function var_0_0.RefreshCDText(arg_29_0)
	local var_29_0 = GuildData:GetRecommendRefreshStamptime() + var_0_1
	local var_29_1 = GetTips("CLUB_REFRES_TEXT")
	local var_29_2 = var_29_0 - manager.time:GetServerTime()

	if var_29_2 > 0 then
		arg_29_0.textRefresh_.text = string.format("%s(%sS)", var_29_1, var_29_2)
	else
		arg_29_0:StopRefreshStamptime()

		arg_29_0.textRefresh_.text = var_29_1
	end
end

function var_0_0.StopRefreshStamptime(arg_30_0)
	if arg_30_0.refreshTimer_ then
		arg_30_0.refreshTimer_:Stop()

		arg_30_0.refreshTimer_ = nil
	end
end

return var_0_0

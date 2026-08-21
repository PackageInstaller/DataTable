local var_0_0 = class("SignView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ActivitySign/ActivityUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()

	arg_3_0.selectIndex = -1
	arg_3_0.allToggles = {
		ActivityDailySignToggle.New(),
		ActivityMonthCardToggle.New(),
		ActivityBigMonthCardToggle.New()
	}

	local var_3_0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_SIGN] or {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		table.insert(arg_3_0.allToggles, ActivitySevenSignToggle.New(iter_3_1))
	end

	arg_3_0.pages = {}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.toggleList = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, SignToggleItem)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_maskBtn, nil, function()
		if arg_5_0.signReady_ then
			arg_5_0:Back()
		end
	end)
end

function var_0_0.OnTop(arg_7_0)
	if arg_7_0.params_.check then
		arg_7_0:CheckSign()

		arg_7_0.params_.check = nil
	end
end

function var_0_0.OnEnter(arg_8_0)
	JumpTools.RefreshGaussianBg()

	arg_8_0.toggles = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_0.allToggles) do
		if iter_8_1:IsActivity() and PlayerData:GetPlayerInfo().userLevel >= iter_8_1:GetLimitLevel() then
			table.insert(arg_8_0.toggles, iter_8_1)
		end
	end

	table.sort(arg_8_0.toggles, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0:Check() and 1 or 0
		local var_9_1 = arg_9_1:Check() and 1 or 0

		if var_9_0 == var_9_1 then
			local var_9_2 = arg_9_0:IsManual() and 0 or 1
			local var_9_3 = arg_9_1:IsManual() and 0 or 1

			if var_9_2 == var_9_3 then
				return arg_9_0:Order() > arg_9_1:Order()
			else
				return var_9_3 < var_9_2
			end
		else
			return var_9_1 < var_9_0
		end
	end)
	arg_8_0.toggleList:StartScroll(#arg_8_0.toggles)

	if arg_8_0.params_.isBack then
		arg_8_0:SetSelectPage(SignData:GetHistoryIndex() or 1)
	elseif arg_8_0.params_.systemID then
		local var_8_0 = 1
		local var_8_1 = arg_8_0.params_.systemID

		for iter_8_2, iter_8_3 in pairs(arg_8_0.toggles) do
			if iter_8_3:GetSystemID() == var_8_1 then
				var_8_0 = iter_8_2

				break
			end
		end

		arg_8_0.params_.systemID = nil

		arg_8_0:SetSelectPage(var_8_0)
	else
		arg_8_0:SetSelectPage(1)
	end

	arg_8_0.signReady_ = true
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0.signReady_ = false

	SignData:SetHistoryIndex(arg_10_0.selectIndex)

	arg_10_0.selectIndex = -1

	if arg_10_0.curPage then
		arg_10_0.curPage:SetActive(false)

		arg_10_0.curPage = nil
	end
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.toggles[arg_11_1]

	arg_11_2:SetData(arg_11_1, var_11_0)
	arg_11_2:SetSelect(arg_11_0.selectIndex)
	arg_11_2:RegistCallBack(handler(arg_11_0, arg_11_0.SetSelectPage))
end

function var_0_0.SetSelectPage(arg_12_0, arg_12_1)
	if arg_12_1 == arg_12_0.selectIndex then
		return
	end

	arg_12_1 = math.min(arg_12_1, #arg_12_0.toggles)

	local var_12_0 = arg_12_0.toggles[arg_12_1]:GetLimitLevel()

	if var_12_0 > PlayerData:GetPlayerInfo().userLevel then
		ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_12_0))

		return
	end

	arg_12_0.selectIndex = arg_12_1

	local var_12_1 = arg_12_0.toggleList:GetItemList()

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		iter_12_1:SetSelect(arg_12_0.selectIndex)
	end

	arg_12_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_13_0)
	if arg_13_0.curPage then
		arg_13_0.curPage:SetActive(false)
	end

	local var_13_0 = arg_13_0.selectIndex
	local var_13_1 = arg_13_0.toggles[var_13_0]
	local var_13_2 = var_13_1:GetName()

	if not arg_13_0.pages[var_13_2] then
		local var_13_3 = var_13_1:GetParams()

		arg_13_0.pages[var_13_2] = var_13_1:UIClass().New(arg_13_0, arg_13_0.m_content, var_13_3)
	end

	arg_13_0.curPage = arg_13_0.pages[var_13_2]

	arg_13_0.curPage:SetActive(true)
	arg_13_0.curPage.transform_:SetAsLastSibling()
end

function var_0_0.CheckSign(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.toggles) do
		if iter_14_1:Check() then
			arg_14_0:SetSelectPage(iter_14_0)
			arg_14_0.curPage:AutoGetReward()

			return
		end
	end

	if not arg_14_0.selectIndex or arg_14_0.selectIndex == -1 then
		arg_14_0:SetSelectPage(1)
	end

	arg_14_0.signReady_ = true
end

function var_0_0.OnReadyToSkipAnimation(arg_15_0, arg_15_1)
	arg_15_0.curPage.animPlaying = not arg_15_1

	SetActive(arg_15_0.m_skipBtn.gameObject, not arg_15_1)
end

function var_0_0.OnSign(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.curPage and arg_16_0.curPage.OnSign then
		arg_16_0.curPage:OnSign(arg_16_1)
	end
end

function var_0_0.OnMonthCardDailyReward(arg_17_0)
	if arg_17_0.curPage and arg_17_0.curPage.OnMonthCardDailyReward then
		arg_17_0.curPage:OnMonthCardDailyReward()
	end

	arg_17_0:CheckSign()
end

function var_0_0.OnGetFatigueSuccess(arg_18_0, arg_18_1)
	if arg_18_0.curPage and arg_18_0.curPage.OnGetFatigueSuccess then
		arg_18_0.curPage:OnGetFatigueSuccess(arg_18_1)
	end
end

function var_0_0.OnAccumulateLoginRefresh(arg_19_0)
	if arg_19_0.curPage and arg_19_0.curPage.RefreshSignItem then
		arg_19_0.curPage:RefreshSignItem()
	end
end

function var_0_0.OnBigMonthCardSign(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_0.curPage then
		local var_20_0 = arg_20_0.curPage.btnAni
		local var_20_1

		if var_20_0 ~= nil then
			var_20_0.enabled = true

			if arg_20_3 > 0 then
				var_20_1 = arg_20_0.curPage.itemAni[arg_20_3]
				var_20_1.enabled = true
			end

			arg_20_0.aniTimer_ = Timer.New(function()
				if not arg_20_0.curPage then
					if arg_20_0.aniTimer_ then
						arg_20_0.aniTimer_:Stop()

						arg_20_0.aniTimer_ = nil
					end

					return
				end

				if var_20_0:GetCurrentAnimatorStateInfo(0).normalizedTime >= 2 or not arg_20_0.curPage.animPlaying then
					if arg_20_0.curPage.animPlaying then
						arg_20_0:OnReadyToSkipAnimation(true)
					end

					getReward(arg_20_1, nil, function()
						arg_20_0:CheckSign()
					end)
					BigMonthCardData:SetRecord(arg_20_2)

					var_20_0.enabled = false

					if var_20_1 then
						var_20_1.enabled = false
					end

					manager.notify:Invoke(GET_BIG_MONTH_SIGN)

					if arg_20_0.aniTimer_ then
						arg_20_0.aniTimer_:Stop()

						arg_20_0.aniTimer_ = nil
					end
				end
			end, 0.033, -1)

			manager.notify:CallUpdateFunc(SIGN_INPUT, true)
			arg_20_0:OnReadyToSkipAnimation(false)
			arg_20_0.aniTimer_:Start()
		end
	else
		manager.notify:CallUpdateFunc(SIGN_INPUT, true)
	end
end

function var_0_0.OnSignViewInputChange(arg_23_0, arg_23_1)
	arg_23_0.signReady_ = arg_23_1

	manager.ui:UIEventEnabledByUI(arg_23_1, not arg_23_1)
end

function var_0_0.StopAniTimer(arg_24_0)
	if arg_24_0.aniTimer_ then
		arg_24_0.aniTimer_:Stop()

		arg_24_0.aniTimer_ = nil
	end
end

function var_0_0.Dispose(arg_25_0)
	arg_25_0:StopAniTimer()
	arg_25_0.toggleList:Dispose()

	for iter_25_0, iter_25_1 in pairs(arg_25_0.pages) do
		iter_25_1:Dispose()
	end

	arg_25_0.pages = {}

	var_0_0.super.Dispose(arg_25_0)
end

return var_0_0

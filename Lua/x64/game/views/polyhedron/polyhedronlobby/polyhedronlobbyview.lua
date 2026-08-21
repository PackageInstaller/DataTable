local var_0_0 = class("PolyhedronLobbyView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Polyhedron/PolyhedronPrepareUI"
end

function var_0_0.UIBackCount(arg_2_0)
	return 2
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.m_policyBtn, nil, function()
		JumpTools.OpenPageByJump("/polyhedronPolicyReward")
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_heroBtn, nil, function()
		JumpTools.GoToSystem("/polyhedronHero", {
			isEnter = true,
			type = HeroConst.HERO_DATA_TYPE.POLYHEDRON,
			tempHeroList = PolyhedronData:GetHeroIDList()
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_taskBtn, nil, function()
		JumpTools.OpenPageByJump("polyhedronTask")
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_altasBtn, nil, function()
		JumpTools.GoToSystem("/polyhedronArtifactAtlas", nil)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_rankBtn, nil, function()
		PolyhedronAction.QueryOpenRankView()
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_shopBtn, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.NEW_DUO_WEI
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_beaconBtn, nil, function()
		JumpTools.OpenPageByJump("/polyhedronBeaconOperate")
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_terminalBtn, nil, function()
		JumpTools.OpenPageByJump("/polyhedronTerminal")
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_challengeBtn, nil, function()
		local var_15_0 = PolyhedronData:GetPolyhedronInfo():GetState()

		if GameSetting.polyhedron_max_challenge_times.value[1] <= PolyhedronData:GetAlreadyChallengeTimes() then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				title = GetTips("PROMPT"),
				content = GetTips("POLYHEDRON_EXCEED_CHALLENGE_TIMES"),
				OkCallback = function()
					return
				end
			})

			return
		end

		if GameSetting.polyhedron_max_challenge_times.value[1] <= PolyhedronData:GetAlreadyChallengeTimes() then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				title = GetTips("PROMPT"),
				content = GetTips("POLYHEDRON_EXCEED_CHALLENGE_TIMES"),
				OkCallback = function()
					return
				end
			})

			return
		end

		if PolyhedronConst.STATE_TYPE.NOTSTARTED == var_15_0 then
			PolyhedronData:SetCacheBeaconList({})
			PolyhedronData:SetCacheSelectHero(0)
			JumpTools.OpenPageByJump("/polyhedronDifficulty", {})
		elseif PolyhedronConst.STATE_TYPE.SETTLEMENT == var_15_0 then
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronOver", {})
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("POLYHEDRON_LOBBY_START_TIP"),
				BtnText = {
					nil,
					GetTips("POLYHEDRON_LOBBY_SETTLEMENT"),
					GetTips("POLYHEDRON_LOBBY_BUTTON_CONTINUE")
				},
				OkCallback = function()
					local var_18_0 = PolyhedronData:GetPolyhedronInfo():GetState()

					if PolyhedronConst.STATE_TYPE.SETTLEMENT == var_18_0 then
						JumpTools.GoToSystem("/polyhedronBlank/polyhedronOver", nil)
					else
						PolyhedronAction.LaunchPolyhedronBattle()
					end
				end,
				MaskCallback = function()
					return
				end,
				CancelCallback = function()
					PolyhedronAction.QueryPolyhedronGiveUp(function(arg_21_0)
						if isSuccess(arg_21_0.result) then
							local var_21_0 = PolyhedronData:GetPolyhedronInfo():GetState()

							if PolyhedronConst.STATE_TYPE.SETTLEMENT == var_21_0 then
								JumpTools.GoToSystem("/polyhedronBlank/polyhedronOver", nil)
							else
								JumpTools.GoToSystem("/polyhedronBlank/polyhedronLobby", nil)
							end
						else
							ShowTips(arg_21_0.result)
						end
					end)
				end
			})
		end
	end)
end

function var_0_0.OnTop(arg_22_0)
	local var_22_0 = GameSetting.polyhedron_describe and GameSetting.polyhedron_describe.value or {}

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			hideBg = true,
			pages = var_22_0
		})
	end)
	CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)

	if PolyhedronData:GetIsNewRed() then
		if PolyhedronData:GetPolyhedronInfo():GetState() == PolyhedronConst.STATE_TYPE.SETTLEMENT then
			JumpTools.OpenPageByJump("/polyhedronBlank/polyhedronOver", {})
		elseif gameContext:IsBack("/polyhedronBlank/polyhedronLobby") > 0 and not manager.guide:IsPlaying() then
			arg_22_0.tipsTimer = Timer.New(function()
				ShowMessageBox({
					ButtonType = "SingleBtn",
					title = GetTips("PROMPT"),
					content = GetTips("POLYHEDRON_RESET"),
					OkCallback = function()
						PolyhedronAction.UpdatePolyhedronNewRed()

						arg_22_0.m_policyLvLab.text = PolyhedronTools.PolyhedronPolicyExpToLevel()
					end
				})
			end, 0.1, 1)

			arg_22_0.tipsTimer:Start()
		else
			PolyhedronAction.UpdatePolyhedronNewRed()
		end
	end
end

function var_0_0.OnEnter(arg_26_0)
	arg_26_0.m_policyLvLab.text = ""
	arg_26_0.m_timeLab.text = ""

	local var_26_0 = PolyhedronData:GetPolyhedronInfo():GetState()

	if PolyhedronConst.STATE_TYPE.NOTSTARTED == var_26_0 then
		arg_26_0.m_btnLab.text = GetTips("POLYHEDRON_LOBBY_BUTTON_START")
	else
		arg_26_0.m_btnLab.text = GetTips("POLYHEDRON_LOBBY_BUTTON_CONTINUE")
	end

	arg_26_0.m_policyLvLab.text = PolyhedronTools.PolyhedronPolicyExpToLevel()

	arg_26_0:BindRedPoint()
	arg_26_0:RefreshTime()

	arg_26_0.timer = Timer.New(function()
		arg_26_0:RefreshTime()
	end, 1, -1)

	arg_26_0.timer:Start()
	CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
end

function var_0_0.OnExit(arg_28_0)
	manager.windowBar:HideBar()
	arg_28_0:UnbindRedPoint()

	if arg_28_0.timer then
		arg_28_0.timer:Stop()

		arg_28_0.timer = nil
	end

	if arg_28_0.tipsTimer then
		arg_28_0.tipsTimer:Stop()

		arg_28_0.tipsTimer = nil
	end
end

function var_0_0.RefreshTime(arg_29_0)
	local var_29_0 = PolyhedronData:GetActivityID()
	local var_29_1 = ActivityData:GetActivityData(var_29_0)

	if var_29_1 and manager.time:GetServerTime() <= var_29_1.stopTime then
		arg_29_0.m_timeLab.text = manager.time:GetLostTimeStr(var_29_1.stopTime)

		return
	end

	arg_29_0.m_timeLab.text = GetTips("TIME_OVER")
end

function var_0_0.Dispose(arg_30_0)
	var_0_0.super.Dispose(arg_30_0)
end

function var_0_0.BindRedPoint(arg_31_0)
	manager.redPoint:bindUIandKey(arg_31_0.m_taskBtn.transform, RedPointConst.POLYHEDRON_RESIDENT_TASK)
	manager.redPoint:bindUIandKey(arg_31_0.m_policyBtn.transform, RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD)
	manager.redPoint:bindUIandKey(arg_31_0.m_beaconBtn.gameObject.transform, RedPointConst.POLYHEDRON_BEACON_UNLOCK)
	manager.redPoint:bindUIandKey(arg_31_0.m_terminalBtn.gameObject.transform, RedPointConst.POLYHEDRON_TERMINAL_GIFT)
	manager.redPoint:bindUIandKey(arg_31_0.m_heroBtn.gameObject.transform, RedPointConst.POLYHEDRON_HERO_UNLOCK)
end

function var_0_0.UnbindRedPoint(arg_32_0)
	manager.redPoint:unbindUIandKey(arg_32_0.m_taskBtn.transform, RedPointConst.POLYHEDRON_RESIDENT_TASK)
	manager.redPoint:unbindUIandKey(arg_32_0.m_policyBtn.transform, RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD)
	manager.redPoint:unbindUIandKey(arg_32_0.m_beaconBtn.gameObject.transform, RedPointConst.POLYHEDRON_BEACON_UNLOCK)
	manager.redPoint:unbindUIandKey(arg_32_0.m_terminalBtn.gameObject.transform, RedPointConst.POLYHEDRON_TERMINAL_GIFT)
	manager.redPoint:unbindUIandKey(arg_32_0.m_heroBtn.gameObject.transform, RedPointConst.POLYHEDRON_HERO_UNLOCK)
end

return var_0_0

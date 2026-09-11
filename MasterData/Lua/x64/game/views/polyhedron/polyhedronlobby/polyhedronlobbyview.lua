local PolyhedronLobbyView = class("PolyhedronLobbyView", ReduxView)

function PolyhedronLobbyView:UIName()
	return "Widget/System/Polyhedron/PolyhedronPrepareUI"
end

function PolyhedronLobbyView:UIBackCount()
	return 2
end

function PolyhedronLobbyView:UIParent()
	return manager.ui.uiMain.transform
end

function PolyhedronLobbyView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronLobbyView:InitUI()
	self:BindCfgUI()
end

function PolyhedronLobbyView:AddUIListener()
	self:AddBtnListener(self.m_policyBtn, nil, function()
		JumpTools.OpenPageByJump("/polyhedronPolicyReward")
	end)
	self:AddBtnListener(self.m_heroBtn, nil, function()
		JumpTools.GoToSystem("/polyhedronHero", {
			isEnter = true,
			type = HeroConst.HERO_DATA_TYPE.POLYHEDRON,
			tempHeroList = PolyhedronData:GetHeroIDList()
		})
	end)
	self:AddBtnListener(self.m_taskBtn, nil, function()
		JumpTools.OpenPageByJump("polyhedronTask")
	end)
	self:AddBtnListener(self.m_altasBtn, nil, function()
		JumpTools.GoToSystem("/polyhedronArtifactAtlas", nil)
	end)
	self:AddBtnListener(self.m_rankBtn, nil, function()
		PolyhedronAction.QueryOpenRankView()
	end)
	self:AddBtnListener(self.m_shopBtn, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.NEW_DUO_WEI
		})
	end)
	self:AddBtnListener(self.m_beaconBtn, nil, function()
		JumpTools.OpenPageByJump("/polyhedronBeaconOperate")
	end)
	self:AddBtnListener(self.m_terminalBtn, nil, function()
		JumpTools.OpenPageByJump("/polyhedronTerminal")
	end)
	self:AddBtnListener(self.m_challengeBtn, nil, function()
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
					if PolyhedronConst.STATE_TYPE.SETTLEMENT == PolyhedronData:GetPolyhedronInfo():GetState() then
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
							if PolyhedronConst.STATE_TYPE.SETTLEMENT == PolyhedronData:GetPolyhedronInfo():GetState() then
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

function PolyhedronLobbyView:OnTop()
	if GameSetting.polyhedron_describe then
		local var_22_0 = GameSetting.polyhedron_describe.value or {}
	end

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
			self.tipsTimer = Timer.New(function()
				ShowMessageBox({
					ButtonType = "SingleBtn",
					title = GetTips("PROMPT"),
					content = GetTips("POLYHEDRON_RESET"),
					OkCallback = function()
						PolyhedronAction.UpdatePolyhedronNewRed()

						self.m_policyLvLab.text = PolyhedronTools.PolyhedronPolicyExpToLevel()
					end
				})
			end, 0.1, 1)

			self.tipsTimer:Start()
		else
			PolyhedronAction.UpdatePolyhedronNewRed()
		end
	end
end

function PolyhedronLobbyView:OnEnter()
	self.m_policyLvLab.text = ""
	self.m_timeLab.text = ""
	self.m_btnLab.text = PolyhedronConst.STATE_TYPE.NOTSTARTED == PolyhedronData:GetPolyhedronInfo():GetState() and GetTips("POLYHEDRON_LOBBY_BUTTON_START") or GetTips("POLYHEDRON_LOBBY_BUTTON_CONTINUE")
	self.m_policyLvLab.text = PolyhedronTools.PolyhedronPolicyExpToLevel()

	self:BindRedPoint()
	self:RefreshTime()

	self.timer = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	self.timer:Start()
	CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
end

function PolyhedronLobbyView:OnExit()
	manager.windowBar:HideBar()
	self:UnbindRedPoint()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.tipsTimer then
		self.tipsTimer:Stop()

		self.tipsTimer = nil
	end
end

function PolyhedronLobbyView:RefreshTime()
	local var_29_0 = ActivityData:GetActivityData((PolyhedronData:GetActivityID()))

	if var_29_0 and manager.time:GetServerTime() <= var_29_0.stopTime then
		self.m_timeLab.text = manager.time:GetLostTimeStr(var_29_0.stopTime)

		return
	end

	self.m_timeLab.text = GetTips("TIME_OVER")
end

function PolyhedronLobbyView:Dispose()
	PolyhedronLobbyView.super.Dispose(self)
end

function PolyhedronLobbyView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.m_taskBtn.transform, RedPointConst.POLYHEDRON_RESIDENT_TASK)
	manager.redPoint:bindUIandKey(self.m_policyBtn.transform, RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD)
	manager.redPoint:bindUIandKey(self.m_beaconBtn.gameObject.transform, RedPointConst.POLYHEDRON_BEACON_UNLOCK)
	manager.redPoint:bindUIandKey(self.m_terminalBtn.gameObject.transform, RedPointConst.POLYHEDRON_TERMINAL_GIFT)
	manager.redPoint:bindUIandKey(self.m_heroBtn.gameObject.transform, RedPointConst.POLYHEDRON_HERO_UNLOCK)
end

function PolyhedronLobbyView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.m_taskBtn.transform, RedPointConst.POLYHEDRON_RESIDENT_TASK)
	manager.redPoint:unbindUIandKey(self.m_policyBtn.transform, RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD)
	manager.redPoint:unbindUIandKey(self.m_beaconBtn.gameObject.transform, RedPointConst.POLYHEDRON_BEACON_UNLOCK)
	manager.redPoint:unbindUIandKey(self.m_terminalBtn.gameObject.transform, RedPointConst.POLYHEDRON_TERMINAL_GIFT)
	manager.redPoint:unbindUIandKey(self.m_heroBtn.gameObject.transform, RedPointConst.POLYHEDRON_HERO_UNLOCK)
end

return PolyhedronLobbyView

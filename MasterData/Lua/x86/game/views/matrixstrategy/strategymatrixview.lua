local StrategyMatrixView = class("StrategyMatrixView", ReduxView)

function StrategyMatrixView:UIBackCount()
	return 2
end

function StrategyMatrixView:UIName()
	return "UI/VolumeIIIDownUI/OceanusRoguelike/StrategyMatrixMapUI"
end

function StrategyMatrixView:UIParent()
	return manager.ui.uiMain.transform
end

function StrategyMatrixView:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrategyMatrixView:InitUI()
	self:BindCfgUI()

	self.map = nil
end

function StrategyMatrixView:AddUIListener()
	self:AddBtnListener(self.m_giveUpBtn, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_MATRIX"),
			OkCallback = function()
				StrategyMatrixAction.QueryMatrixGiveUp(self.matrix_activity_id)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	self:AddBtnListener(self.m_infoBtn, nil, function()
		local var_10_0 = StrategyMatrixData:GetMatrixHeroTeam(self.matrix_activity_id)

		JumpTools.OpenPageByJump("/strategyMatrixHero_new", {
			isEnter = true,
			matrix_activity_id = self.matrix_activity_id,
			type = HeroConst.HERO_DATA_TYPE.STRATEGYMATRIX,
			tempHeroList = var_10_0,
			hid = var_10_0[1]
		})
	end)
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("strategyMatrixRward", {
			matrix_activity_id = self.matrix_activity_id
		})
	end)
end

function StrategyMatrixView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(self.matrix_activity_id))
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, self.matrix_activity_id)
	manager.windowBar:RegistBackCallBack(function()
		if self.map then
			self.map:GoBack()
		else
			self:Back()
		end
	end)
end

function StrategyMatrixView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id
	self.mapId = StrategyMatrixData:GetMapId(self.matrix_activity_id)

	if self.map and self.mapId ~= self.map:GetMapId() then
		self.map:Dispose()

		self.map = nil
	end

	self.map = self.map or StrategyMatrixMap.New(self.mapId, self.m_content)

	self.map:SetData(self.matrix_activity_id)

	if self.params_.playerAnim then
		self.m_animator:Play("StrategyMatrixMapUI", 0, 0)

		self.params_.playerAnim = nil

		self.map:PlayerAnim(true)
	else
		self.m_animator:Play("StrategyMatrixMapUI", 0, 9999999)
		self.map:PlayerAnim(false)
	end

	self:RefrenTime()

	self.timer = Timer.New(function()
		self:RefrenTime()
	end, 1, -1)

	self.timer:Start()
	StrategyMatrixAction.SetStrategyRead(self.matrix_activity_id)
	manager.redPoint:bindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX, self.matrix_activity_id))

	local var_14_0 = StrategyMatrixData:GetTierID(self.matrix_activity_id)

	if var_14_0 and StrategyMatrixTierTemplateCfg[var_14_0] then
		self.m_title.text = GetTips("ACTIVITY_STRATEGY_TITLE_" .. StrategyMatrixTierTemplateCfg[var_14_0].tier)
		self.m_bg.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VolumeIIIDownUI/" .. ({
			"VolumeDown_bg_00418",
			"VolumeDown_bg_00419",
			"VolumeDown_bg_00420",
			"VolumeDown_bg_00421"
		})[StrategyMatrixTierTemplateCfg[var_14_0].tier])
	else
		self.m_title.text = ""
	end
end

function StrategyMatrixView:OnExit()
	if self.map then
		self.map:Exit()
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX, self.matrix_activity_id))
end

function StrategyMatrixView:RefrenTime()
	local var_17_0 = ActivityData:GetActivityData(self.matrix_activity_id)

	self.m_timeLab.text = var_17_0 and var_17_0:IsActivitying() and manager.time:GetLostTimeStr(var_17_0.stopTime) or GetTips("TIME_OVER")
end

function StrategyMatrixView:Dispose()
	if self.map then
		self.map:Dispose()
	end

	self.map = nil

	StrategyMatrixView.super.Dispose(self)
end

return StrategyMatrixView

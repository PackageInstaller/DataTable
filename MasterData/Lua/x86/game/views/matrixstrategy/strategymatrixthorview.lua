local StrategyMatrixThorView = class("StrategyMatrixThorView", ReduxView)

function StrategyMatrixThorView:UIBackCount()
	return 2
end

function StrategyMatrixThorView:UIName()
	return "UI/EmptyDream/ThorRoguelike/ThorRoguelikeMapUI"
end

function StrategyMatrixThorView:UIParent()
	return manager.ui.uiMain.transform
end

function StrategyMatrixThorView:Init()
	self:InitUI()
	self:AddUIListener()

	self.showDropDownConrtoller = ControllerUtil.GetController(self.m_dropDownBtn.transform, "showDropDown")
	self.difficultyController = ControllerUtil.GetController(self.m_dropDownBtn.transform, "difficulty")
	self.hardLockController = ControllerUtil.GetController(self.m_levelBtn2.transform, "lock")
end

function StrategyMatrixThorView:InitUI()
	self:BindCfgUI()

	self.map = nil
end

function StrategyMatrixThorView:AddUIListener()
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
	self:AddBtnListener(self.m_dropDownBtn, nil, function()
		if self.showDropDownConrtoller:GetSelectedState() == "hide" then
			self.showDropDownConrtoller:SetSelectedState("show")
		else
			self.showDropDownConrtoller:SetSelectedState("hide")
		end
	end)
	self:AddBtnListener(self.m_levelBtn1, nil, function()
		self.showDropDownConrtoller:SetSelectedState("hide")
		self:OnDropDownClick(1)
	end)
	self:AddBtnListener(self.m_levelBtn2, nil, function()
		self.showDropDownConrtoller:SetSelectedState("hide")

		if ActivityTools.GetActivityIsOpenWithTip(ActivityConst.STRATEGY_MATRIX_THOR_HARD) then
			if StrategyMatrixData:GetIsClearance(ActivityConst.STRATEGY_MATRIX_THOR) then
				self:OnDropDownClick(2)
			else
				ShowTips("THOR_STRATEGY_UNLOCK")
			end
		end
	end)
	self:AddBtnListener(self.m_mask, nil, function()
		self.showDropDownConrtoller:SetSelectedState("hide")
	end)
	self:AddBtnListener(self.m_storyBtn, nil, function()
		JumpTools.OpenPageByJump("/strategyMatrixThorStoryReview")
	end)
end

function StrategyMatrixThorView:InitBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(self.matrix_activity_id))
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, self.matrix_activity_id)
	manager.windowBar:RegistBackCallBack(function()
		self:Back()
	end)
end

function StrategyMatrixThorView:OnEnter()
	self:Refresh()

	self.timer = Timer.New(function()
		self:RefrenTime()
	end, 1, -1)

	self.timer:Start()
end

function StrategyMatrixThorView:OnUpdate()
	self:Refresh()
	self:InitBar()
end

function StrategyMatrixThorView:OnTop()
	self:InitBar()

	if self.map then
		self.map:OnTop()
	end
end

function StrategyMatrixThorView:Refresh()
	if self.matrix_activity_id == self.params_.matrix_activity_id then
		return
	end

	self.showDropDownConrtoller:SetSelectedState("hide")

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
	StrategyMatrixAction.SetStrategyRead(ActivityConst.STRATEGY_MATRIX_THOR)
	StrategyMatrixAction.SetStrategyRead(ActivityConst.STRATEGY_MATRIX_THOR_HARD)
	manager.redPoint:bindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX, self.matrix_activity_id))

	local var_23_0 = ActivityConst.STRATEGY_MATRIX_THOR_HARD == self.matrix_activity_id
	local var_23_1 = StrategyMatrixData:GetTierID(self.matrix_activity_id)

	if var_23_1 and StrategyMatrixTierTemplateCfg[var_23_1] then
		self.m_title.text = GetTips("THOR_STRATEGY_TITLE_" .. StrategyMatrixTierTemplateCfg[var_23_1].tier)
		self.m_bg.sprite = var_23_0 and pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/" .. ({
			"EDream_bg_0147",
			"EDream_bg_0148",
			"EDream_bg_0149",
			"EDream_bg_0150"
		})[StrategyMatrixTierTemplateCfg[var_23_1].tier]) or pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/" .. ({
			"EDream_bg_0137",
			"EDream_bg_0138",
			"EDream_bg_0139",
			"EDream_bg_0140"
		})[StrategyMatrixTierTemplateCfg[var_23_1].tier])
	else
		self.m_title.text = ""
	end

	self.m_difficultyLab.text = var_23_0 and GetTips("HARDLEVEL_HARD") or GetTips("HARDLEVEL_EASY")

	self.difficultyController:SetSelectedIndex(var_23_0 and 1 or 0)
end

function StrategyMatrixThorView:OnExit()
	manager.windowBar:HideBar()

	if self.map then
		self.map:Exit()
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX, self.matrix_activity_id))

	self.matrix_activity_id = nil
end

function StrategyMatrixThorView:RefrenTime()
	local var_25_0 = ActivityData:GetActivityData(self.matrix_activity_id)

	self.m_timeLab.text = var_25_0 and var_25_0:IsActivitying() and manager.time:GetLostTimeStr(var_25_0.stopTime) or GetTips("TIME_OVER")

	if ActivityData:GetActivityIsOpen(ActivityConst.STRATEGY_MATRIX_THOR_HARD) and StrategyMatrixData:GetIsClearance(ActivityConst.STRATEGY_MATRIX_THOR) then
		self.hardLockController:SetSelectedIndex(0)
	else
		self.hardLockController:SetSelectedIndex(1)
	end
end

function StrategyMatrixThorView:OnDropDownClick(arg_26_1)
	StrategyMatrixData:SetDifficultySelect(arg_26_1)
	StrategyMatrixAction.GotoStrategyMatrix(arg_26_1 == 2 and ActivityData:GetActivityIsOpen(ActivityConst.STRATEGY_MATRIX_THOR_HARD) and ActivityConst.STRATEGY_MATRIX_THOR_HARD or ActivityConst.STRATEGY_MATRIX_THOR, true)
end

function StrategyMatrixThorView:Dispose()
	if self.map then
		self.map:Dispose()
	end

	self.map = nil

	StrategyMatrixThorView.super.Dispose(self)
end

return StrategyMatrixThorView

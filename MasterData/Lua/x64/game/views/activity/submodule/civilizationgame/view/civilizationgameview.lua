local CivilizationGameView = class("CivilizationGameView", ReduxView)

function CivilizationGameView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Culture/V4_2_GodEaterUI_Culture_PlayUI"
end

function CivilizationGameView:UIParent()
	return manager.ui.uiMain.transform
end

function CivilizationGameView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CivilizationGameView:InitUI()
	self:BindCfgUI()

	self.skillController_ = self.mainControllerEx_:GetController("tips")
	self.mapController_ = self.mainControllerEx_:GetController("Base")
	self.infoController_ = self.mainControllerEx_:GetController("infoTips")
	self.sourceController_ = self.mainControllerEx_:GetController("sourceTips")
	self.foodController_ = self.foodControllerEx_:GetController("state")
end

function CivilizationGameView:AddUIListener()
	self:AddBtnListener(self.heroBtn_, nil, function()
		JumpTools.OpenPageByJump("civilizationGameHeroView", {
			heroID = self.heroID_
		})
	end)
	self:AddBtnListener(self.tipsMaskBtn_, nil, function()
		self.skillController_:SetSelectedState("off")
	end)
	self:AddBtnListener(self.explainBtn_, nil, function()
		self:ShowInfoTips(true)
	end)
	self:AddBtnListener(self.infoTipsMask_, nil, function()
		self:ShowInfoTips(false)
	end)

	for iter_5_0 = 1, 3 do
		self:AddBtnListenerScale(self["resourceBtn_" .. iter_5_0], nil, function()
			self:ShowSourceTips(iter_5_0)
		end)
	end

	self:AddBtnListener(self.resourceMaskBtn_, nil, function()
		self:ShowSourceTips(0)
	end)
end

function CivilizationGameView:OnEnter()
	self.heroID_ = self.params_.heroID
	self.stageID_ = self.params_.stageID
	self.activityID_ = self.params_.activityID
	self.gameType_ = self.params_.gameType

	self.mapController_:SetSelectedState("content01")

	for iter_12_0 = 1, 3 do
		self["hexController" .. iter_12_0] = self["hexControllerEx_" .. iter_12_0]:GetController("lock")

		self["hexController" .. iter_12_0]:SetSelectedState("off")
	end

	CivilizationGameTools.PreLoadCfg(self.gameType_)
	self:RefreshUI()
	SetActive(self.foodTipsGo_, false)
	self.foodController_:SetSelectedIndex(0)
	civilization.CivilizationLuaBridge.StartGame(self.stageID_, self.heroID_, self.activityID_, not not manager.guide:IsPlaying())
end

function CivilizationGameView:RefreshUI()
	self.heroImg_.sprite = getSprite("Atlas/V4_2_GodEaterUIAtlas", ActivityCivilizationHeroCfg[self.heroID_].icon)
	self.titleText_.text = ActivityCivilizationSettingCfg[ActivityCivilizationSettingCfg.get_id_list_by_type[self.gameType_][1]].note
	self.winText_.text = ActivityCivilizationStageCfg[self.stageID_].victory_desc
end

function CivilizationGameView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			content = GetTips("GODEATER_CIVILIZATION_EXIT_CONFIRM_TIPS"),
			OkCallback = function()
				civilization.CivilizationLuaBridge.EndGame()
			end
		})
	end)
	self.infoController_:SetSelectedState("off")
end

function CivilizationGameView:OnExit()
	manager.windowBar:HideBar()
end

function CivilizationGameView:ShowInfoTips(arg_18_1)
	if arg_18_1 then
		local var_18_0 = civilization.CivilizationLuaBridge.GetInfoTips()
		local var_18_1 = ""

		for iter_18_0 = 0, 3 do
			var_18_1 = iter_18_0 + 1 == 1 and string.format(GetTips("GODEATER_CIVILIZATION_GAME_SETTING_" .. iter_18_0 + 1), var_18_0[iter_18_0]) or var_18_1 .. "\n" .. string.format(GetTips("GODEATER_CIVILIZATION_GAME_SETTING_" .. iter_18_0 + 1), var_18_0[2 * iter_18_0], var_18_0[2 * iter_18_0 - 1])
		end

		self.infoTipsText_.text = var_18_1

		self.infoController_:SetSelectedState("on")
	else
		self.infoController_:SetSelectedState("off")
	end
end

function CivilizationGameView:ShowSourceTips(arg_19_1)
	self.sourceController_:SetSelectedIndex(arg_19_1)

	if arg_19_1 == 1 then
		self.resourceText_.text = GetTips("GODEATER_CIVILIZATION_SOURCE_FOOD")
	elseif arg_19_1 == 2 then
		self.resourceText_.text = GetTips("GODEATER_CIVILIZATION_SOURCE_POP")
	elseif arg_19_1 == 3 then
		self.resourceText_.text = GetTips("GODEATER_CIVILIZATION_SOURCE_TECH")
	end
end

function CivilizationGameView:OnCivilizationClickSkill(arg_20_1, arg_20_2)
	if arg_20_1 ~= 0 then
		self.skillNameText_.text = GetI18NText(ActivityCivilizationSkillCfg[arg_20_1].name)
		self.skillTimeText_.text = ActivityCivilizationSkillCfg[arg_20_1].cd
		self.skillDescText_.text = GetI18NText(ActivityCivilizationSkillCfg[arg_20_1].description)
	end

	self.skillTipsGo_.transform.position = arg_20_2.position

	self.skillController_:SetSelectedState("on")
end

function CivilizationGameView:OnCivilizationMapExtension()
	self.mapController_:SetSelectedState("content02")
end

function CivilizationGameView:OnCivilizationGainHex(arg_22_1, arg_22_2)
	if arg_22_2 < 0 or arg_22_2 > 3 then
		return
	end

	self["hexController" .. arg_22_2]:SetSelectedState("on")

	self["hexImg_" .. arg_22_2].sprite = getSpriteViaConfig("CivilizationGame", ActivityCivilizationFactorCfg[arg_22_1].icon)
end

function CivilizationGameView:OnCivilizationAgeChange(arg_23_1, arg_23_2)
	JumpTools.OpenPageByJump("civilizationGameLvUpView", {
		lastAge = arg_23_2
	})

	self.titleText_.text = ActivityCivilizationSettingCfg[ActivityCivilizationSettingCfg.get_id_list_by_type[self.gameType_][arg_23_1 + 1]].note
end

function CivilizationGameView:OnCivilizationFoodShortage(arg_24_1)
	SetActive(self.foodTipsGo_, arg_24_1)
	self.foodController_:SetSelectedIndex(arg_24_1 and 1 or 0)
end

function CivilizationGameView:Dispose()
	CivilizationGameView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CivilizationGameView

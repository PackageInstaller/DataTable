local CustomCenterTools = require("game.tools.CustomCenterTools")
local ScenePreviewView = class("ScenePreviewView", ReduxView)

function ScenePreviewView:UIName()
	return "Widget/System/Main/SceneChange_new"
end

function ScenePreviewView:UIParent()
	return manager.ui.uiMain.transform
end

function ScenePreviewView:Init()
	self:InitUI()
	self:AddUIListeners()
end

local function var_0_2(arg_4_0, arg_4_1)
	return ComponentBinder.GetInstance():InjectImage(arg_4_0, arg_4_1)
end

local function var_0_3(arg_5_0, arg_5_1)
	return ComponentBinder.GetInstance():InjectText(arg_5_0)
end

local var_0_4 = CustomCenterTools.GetMatchSkinByScene

function ScenePreviewView:BindEffectCom()
	self.effectTgl = {}

	for iter_6_0, iter_6_1 in ipairs(HomeSceneTagCfg.all) do
		local var_6_0 = {}

		var_6_0.obj = self["effectGo_" .. iter_6_1] or self.effectItemPanel_:Find("item" .. iter_6_1).gameObject
		var_6_0.toggle = self["effectTgl_" .. iter_6_1] or var_6_0.obj.transform:Find("btn"):GetComponent("Toggle")
		var_6_0.icon = self["effectIcon_" .. iter_6_1] or var_0_2(var_6_0.obj.transform:Find("icon"):GetComponent("Image"), self)
		var_6_0.name = self["effectName_" .. iter_6_1] or var_0_3(var_6_0.obj.transform:Find("text"):GetComponent("Text"), self)
		self["effectGo_" .. iter_6_1] = var_6_0.obj
		self["effectTgl_" .. iter_6_1] = var_6_0.toggle
		self["effectIcon_" .. iter_6_1] = var_6_0.icon
		self["effectName_" .. iter_6_1] = var_6_0.name
		var_6_0.name.text = GetI18NText(HomeSceneTagCfg[iter_6_1].tag_desc)
		self.effectTgl[iter_6_1] = var_6_0
	end
end

function ScenePreviewView:InitUI()
	self:BindCfgUI()
	self:BindEffectCom()

	self.bg_.immediate = true
	self.btnController_ = self.mainControllerEx_:GetController("btn")
	self.recommandController_ = self.mainControllerEx_:GetController("recommandState")
	self.tabController_ = self.tabControllerEx_:GetController("tab")
	self.setting_ = {
		[HomeSceneSettingConst.SETTING.SOUND_EFFECT] = "sound_effect",
		[HomeSceneSettingConst.SETTING.CAMERA_FOLLOW] = "camera_follow",
		[HomeSceneSettingConst.SETTING.SCENE_BGM] = "scene_bgm"
	}
	self.settingBtn_ = {}
	self.settingCon_ = {}
	self.settingItem_ = {}

	for iter_7_0, iter_7_1 in ipairs(self.setting_) do
		self.settingBtn_[iter_7_0] = self["settingBtn_" .. iter_7_0]
		self.settingItem_[iter_7_0] = self["settingItem_" .. iter_7_0]

		if self.settingItem_[iter_7_0] then
			self.settingCon_[iter_7_0] = self.settingBtn_[iter_7_0].transform:GetComponent("ControllerExCollection"):GetController("type")
		end
	end

	self.sceneScrollHelper_ = LuaList.New(handler(self, self.SceneIndexItem), self.listGo_, ScenePreviewItem)
	self.dlcScrollHelper_ = LuaList.New(handler(self, self.DlcIndexItem), self.dlcListGo_, ScenePreviewDlcItem)
end

function ScenePreviewView:SceneIndexItem(arg_8_1, arg_8_2)
	local var_8_0 = self.sceneList_[arg_8_1]

	arg_8_2:RefreshData(self.sceneList_[arg_8_1], self.sceneData_[self.sceneList_[arg_8_1]], self.sceneList_[arg_8_1] == self.curSceneID_)
	arg_8_2:RegistClickFunc(function()
		self:ChangeCurScene(1, var_8_0)
	end)
end

function ScenePreviewView:DlcIndexItem(arg_10_1, arg_10_2)
	local var_10_0 = self.dlcList_[arg_10_1]

	arg_10_2:RefreshData(self.dlcList_[arg_10_1], self.dlcData_[self.dlcList_[arg_10_1]], self.dlcList_[arg_10_1] == self.curSceneID_)
	arg_10_2:RegistClickFunc(function()
		self:ChangeCurScene(2, var_10_0)
	end)
end

function ScenePreviewView:ChangeCurScene(arg_12_1, arg_12_2)
	self.curPage_ = arg_12_1
	self.curSceneID_ = arg_12_2

	self:RefreshRight()

	if arg_12_1 == 1 then
		self.sceneScrollHelper_:Refresh()
	else
		self.dlcScrollHelper_:Refresh()
	end
end

function ScenePreviewView:SelectPage(arg_13_1)
	local var_13_0 = HomeSceneSettingData:GetCurScene()

	if arg_13_1 == 1 then
		if HomeSceneSettingCfg[var_13_0] and HomeSceneSettingCfg[var_13_0].limit_display == 1 then
			self:ChangeCurScene(arg_13_1, var_13_0)
		else
			self:ChangeCurScene(arg_13_1, self.sceneList_[1])
		end
	else
		local var_13_1 = PlayerData:GetPosterGirlHeroSkinId()
		local var_13_2
		local var_13_3

		if var_13_1 then
			var_13_2 = nullable(CustomCenterTools.GetDLCScene(var_13_1), "special_scene_id")
		end

		if var_13_2 then
			for iter_13_0, iter_13_1 in ipairs(self.dlcList_) do
				if iter_13_1 == var_13_2 then
					var_13_3 = iter_13_0

					break
				end
			end
		end

		if HomeSceneSettingCfg[var_13_0] and HomeSceneSettingCfg[var_13_0].limit_display == 0 then
			self:ChangeCurScene(arg_13_1, var_13_0)
		elseif var_13_2 and var_13_3 then
			self:ChangeCurScene(arg_13_1, var_13_2)
		else
			self:ChangeCurScene(arg_13_1, self.dlcList_[1])
		end
	end
end

function ScenePreviewView:AddUIListeners()
	self:AddBtnListener(self.recommandBtn_, nil, function()
		local var_15_0 = self.recommandController_:GetSelectedIndex()

		if var_15_0 == 2 then
			return
		end

		if var_15_0 == 1 then
			self.recommandController_:SetSelectedIndex(0)
		else
			self.recommandController_:SetSelectedIndex(1)
		end
	end)
	self:AddBtnListener(self.sceneBtn_, nil, function()
		if self.curPage_ == 1 then
			return
		end

		self.curPage_ = 1

		self:SelectPage(1)
		self:RefreshUI()
	end)
	self:AddBtnListener(self.dlcBtn_, nil, function()
		if self.curPage_ == 2 then
			return
		end

		if self.dlcList_ and #self.dlcList_ > 0 then
			self.curPage_ = 2

			self:SelectPage(2)
			self:RefreshUI()
		else
			ShowTips(GetTips("HOME_SCENE_COUNT_INVALID"))
		end
	end)
	self:AddBtnListener(self.useBtn_, nil, function()
		if self.curPage_ == 1 then
			self:UseScene(self.curSceneID_)
		else
			local var_18_0 = var_0_4(self.curSceneID_)
			local var_18_1 = SkinCfg[var_18_0].hero

			if SkinCfg[var_18_0].hero and HeroTools.GetHeroIsUnlock(SkinCfg[var_18_0].hero) and var_18_0 and HeroTools.GetHasOwnedSkin(var_18_0) then
				if PlayerData:IsRandomHero() then
					ShowMessageBox({
						title = GetTips("PROMPT"),
						content = GetTips("RANDOM_ASSIST_TIPS"),
						OkCallback = function()
							PlayerAction.SetIsRandomHero(false, function()
								return
							end)
							HeroAction.SelectSkin(var_18_1, var_18_0)
							PlayerAction.ChangePosterGirl(var_18_1)
						end
					})
				else
					HeroAction.SelectSkin(SkinCfg[var_18_0].hero, var_18_0)
					PlayerAction.ChangePosterGirl(SkinCfg[var_18_0].hero)
				end
			end
		end
	end)
	self:AddBtnListener(self.trialBtn_, nil, function()
		if self.curPage_ == 1 then
			self:UseScene(self.curSceneID_)
		else
			local var_21_0 = var_0_4(self.curSceneID_)
			local var_21_1 = SkinCfg[var_21_0].hero

			if SkinCfg[var_21_0].hero and HeroTools.GetHeroIsUnlock(SkinCfg[var_21_0].hero) and var_21_0 and (HeroTools.GetHasOwnedSkin(var_21_0) or HeroTools.GetIsLimitTimeSkin(var_21_0)) then
				if PlayerData:IsRandomHero() then
					ShowMessageBox({
						title = GetTips("PROMPT"),
						content = GetTips("RANDOM_ASSIST_TIPS"),
						OkCallback = function()
							PlayerAction.SetIsRandomHero(false, function()
								return
							end)
							HeroAction.SelectSkin(var_21_1, var_21_0)
							PlayerAction.ChangePosterGirl(var_21_1)
						end
					})
				else
					HeroAction.SelectSkin(SkinCfg[var_21_0].hero, var_21_0)
					PlayerAction.ChangePosterGirl(SkinCfg[var_21_0].hero)
				end
			end
		end
	end)
	self:AddBtnListener(self.getBtn_, nil, function()
		if self:IsCanGet() then
			JumpTools.JumpToPage2(self.cfg_.obtain_way)
		else
			ShowTips("HOME_NO_GET_WAY")
		end
	end)
	self:AddBtnListener(self.noGetBtn_, nil, function()
		if self.curPage_ == 1 then
			if not self:IsCanGet() then
				ShowTips("HOME_NO_GET_WAY")
			end
		else
			local var_25_0 = var_0_4(self.curSceneID_)

			if not SkinCfg[var_25_0].hero or not HeroTools.GetHeroIsUnlock(SkinCfg[var_25_0].hero) then
				ShowTips(GetTipsF("HOME_SCENE_UNAVAILABLE", HeroTools.GetHeroFullName(SkinCfg[var_25_0].hero)))
			elseif not var_25_0 or not HeroTools.GetHasOwnedSkin(var_25_0) then
				ShowTips(GetTipsF("HOME_SCENE_UNAVAILABLE", SkinCfg[var_25_0].name))
			end
		end
	end)
	self:AddBtnListener(self.previewBtn_, nil, function()
		self.params_.sceneID = self.curSceneID_

		local var_26_0 = HomeSceneSettingData:SetPreviewScene(self.curSceneID_)

		HomeSceneSettingData:SetPreviewSceneParams(var_26_0)
		OpenPageUntilLoaded("/homePreview", var_26_0)
	end)
	self:AddBtnListener(self.randomSceneBtn_, nil, function()
		JumpTools.GoToSystem("/randomScene", {})
	end)

	for iter_14_0, iter_14_1 in ipairs(self.setting_) do
		if self.settingBtn_[iter_14_0] then
			self:AddBtnListener(self.settingBtn_[iter_14_0], nil, function()
				SettingAction.ChangeHomeSceneSetting("home_scene_" .. iter_14_1, 1 - self.settingData_["home_scene_" .. iter_14_1])

				if iter_14_0 == HomeSceneSettingConst.SETTING.SCENE_BGM then
					self:CheckPlayBgm()
				end
			end)
		end
	end

	for iter_14_2, iter_14_3 in ipairs(HomeSceneTagCfg.all) do
		self:AddToggleListener(self.effectTgl[iter_14_3].toggle, function(arg_29_0)
			if arg_29_0 then
				self:AddClickTimer()

				self.tglTitle_.text = HomeSceneTagCfg[iter_14_3].tag_desc
				self.tglDesc_.text = HomeSceneTagCfg[iter_14_3].tag_detail

				SetActive(self.tglPanelGo_, true)
			end
		end)
	end
end

function ScenePreviewView:OnEnter()
	self:BindRedpoint()

	if self.params_._BackFromRandomScene then
		self.params_._BackFromRandomScene = nil

		return
	end

	HomeSceneSettingData:DealOverdueScene()

	self.curSceneID_ = self.params_.sceneID and self.params_.sceneID or HomeSceneSettingData:GetCurScene()

	local var_30_0 = HomeSceneSettingData:GetCurScene()

	if not var_30_0 or HomeSceneSettingData:GetUsedState(var_30_0) == SceneConst.HOME_SCENE_TYPE.LOCK then
		local var_30_2 = GameSetting.home_sence_default.value[1]

		HomeSceneSettingAction.SetHomeScene(GameSetting.home_sence_default.value[1])

		self.curSceneID_ = var_30_2
	end

	self.curPage_ = 1

	if HomeSceneSettingCfg[self.curSceneID_] and HomeSceneSettingCfg[self.curSceneID_].limit_display == 0 then
		self.curPage_ = 2
	end

	self:RefreshUI()
end

function ScenePreviewView:RefreshUI()
	self:RefreshList()
	self:RefreshRight()
end

function ScenePreviewView:RefreshList()
	self.sceneData_ = {}
	self.sceneList_ = {}

	for iter_32_0, iter_32_1 in ipairs(HomeSceneSettingCfg.all) do
		if HomeSceneSettingCfg[iter_32_1].limit_display == 1 then
			table.insert(self.sceneList_, iter_32_1)

			self.sceneData_[iter_32_1] = HomeSceneSettingData:GetUsedState(iter_32_1)
		end
	end

	table.sort(self.sceneList_, function(arg_33_0, arg_33_1)
		if self.sceneData_[arg_33_0] ~= self.sceneData_[arg_33_1] then
			return self.sceneData_[arg_33_0] > self.sceneData_[arg_33_1]
		end

		return arg_33_0 < arg_33_1
	end)
	self.sceneScrollHelper_:StartScroll(#self.sceneList_, table.indexof(self.sceneList_, self.curSceneID_))

	self.dlcData_ = {}
	self.dlcList_ = {}

	for iter_32_2, iter_32_3 in pairs(SkinSceneActionCfg.get_id_list_by_special_scene_id) do
		if HomeSceneSettingCfg[iter_32_2].limit_display == 0 and (ShopTools.CheckDlcPurchasedByItemID(iter_32_2) or ShopTools.CheckDlcTrialByItemID(iter_32_2)) then
			local var_32_0 = SkinSceneActionCfg[iter_32_3].skin_id

			table.insert(self.dlcList_, iter_32_2)

			local var_32_1 = 0

			if SkinCfg[var_32_0].hero and HeroTools.GetHeroIsUnlock(SkinCfg[var_32_0].hero) and var_32_0 and HeroTools.GetHasOwnedSkin(var_32_0) then
				var_32_1 = 2
			end

			if SkinCfg[var_32_0].hero and HeroTools.GetHeroIsUnlock(SkinCfg[var_32_0].hero) and ShopTools.CheckDlcTrialByItemID(iter_32_2) then
				self.dlcData_[iter_32_2] = 1
			end
		end
	end

	CommonTools.UniversalSortEx(self.dlcList_, {
		map = function(arg_34_0)
			local var_34_0 = var_0_4(arg_34_0)

			if SkinCfg[var_34_0].hero and HeroTools.GetHeroIsUnlock(SkinCfg[var_34_0].hero) and var_34_0 and (HeroTools.GetHasOwnedSkin(var_34_0) or HeroTools.GetIsLimitTimeSkin(var_34_0)) then
				return 1
			end

			return 0
		end
	}, {
		map = function(arg_35_0)
			return arg_35_0
		end
	})
	self.dlcScrollHelper_:StartScroll(#self.dlcList_, table.indexof(self.dlcList_, self.curSceneID_))
end

function ScenePreviewView:RefreshRight()
	self.tabController_:SetSelectedIndex(self.curPage_ - 1)

	self.cfg_ = HomeSceneSettingCfg[self.curSceneID_]
	self.title_.text = self.cfg_.title
	self.desc_.text = self.cfg_.desc

	if self.curPage_ == 1 then
		self.bg_.spriteSync = "TextureConfig/SceneChangeUI/bg/" .. self.curSceneID_

		SetActive(self.randomSceneBtn_.transform, true)
	else
		self.bg_.spriteSync = "TextureConfig/Character/PortraitDLC/" .. var_0_4(self.curSceneID_)

		SetActive(self.randomSceneBtn_.transform, false)
	end

	self:ResetTgl()
	self:RefreshSetting()
	self:RefreshType()
	self:RefreshRedPoint()
end

function ScenePreviewView:ResetTgl()
	self:HideMessage()

	for iter_37_0, iter_37_1 in ipairs(HomeSceneTagCfg.all) do
		local var_37_0 = self.effectTgl[iter_37_1]

		if not isNil(self.effectTgl[iter_37_1].obj) then
			if table.indexof(self.cfg_.scene_tag, iter_37_1) then
				SetActive(var_37_0.obj, true)
			else
				SetActive(var_37_0.obj, false)
			end

			var_37_0.toggle.isOn = false
		end
	end

	if self.cfg_.scene_tag == "" or #self.cfg_.scene_tag == 0 then
		self.recommandController_:SetSelectedIndex(2)
	else
		self.recommandController_:SetSelectedIndex(1)
	end
end

function ScenePreviewView:HideMessage()
	SetActive(self.tglPanelGo_, false)
end

function ScenePreviewView:RefreshSetting()
	for iter_39_0, iter_39_1 in ipairs(self.setting_) do
		if table.indexof(self.cfg_.scene_setting, iter_39_0) then
			SetActive(self.settingItem_[iter_39_0], true)
		else
			SetActive(self.settingItem_[iter_39_0], false)
		end
	end

	self.settingData_ = SettingData:GetHomeSceneSettingData()

	self:RefreshSoundEffect()
	self:RefreshSceneBgm()
end

function ScenePreviewView:RefreshSoundEffect()
	self.settingCon_[1]:SetSelectedState(self.settingData_.home_scene_sound_effect == 1 and "on" or "off")
end

function ScenePreviewView:RefreshSceneBgm()
	self.settingCon_[HomeSceneSettingConst.SETTING.SCENE_BGM]:SetSelectedState(self.settingData_.home_scene_scene_bgm == 1 and "on" or "off")
end

function ScenePreviewView:RefreshType()
	self:StopTimer()

	if self.curPage_ == 1 then
		local var_42_0 = HomeSceneSettingData:GetCurScene()

		if self.sceneData_[self.curSceneID_] == 0 then
			self.btnController_:SetSelectedState(self:IsCanGet() and "get" or "ban")

			self.tip_.text = self.cfg_.unlock_description
			self.banText_.text = self.cfg_.unlock_description
		elseif self.sceneData_[self.curSceneID_] == 1 then
			self.btnController_:SetSelectedState(self.curSceneID_ == var_42_0 and "trialing" or "trial")
			self:RefreshTime()
		elseif self.sceneData_[self.curSceneID_] == 2 then
			self.btnController_:SetSelectedState(self.curSceneID_ == var_42_0 and "using" or "use")
		end
	else
		local var_42_1 = self.dlcData_[self.curSceneID_]
		local var_42_2 = HomeSceneSettingData:GetCurScene()

		if self.dlcData_[self.curSceneID_] == 0 then
			self.btnController_:SetSelectedState("ban")

			local var_42_3 = var_0_4(self.curSceneID_)

			if not SkinCfg[var_42_3].hero or not HeroTools.GetHeroIsUnlock(SkinCfg[var_42_3].hero) then
				self.banText_.text = GetTipsF("HOME_SCENE_UNAVAILABLE", HeroTools.GetHeroFullName(SkinCfg[var_42_3].hero))
			elseif not var_42_3 or not HeroTools.GetHasOwnedSkin(var_42_3) then
				self.banText_.text = GetTipsF("HOME_SCENE_UNAVAILABLE", SkinCfg[var_42_3].name)
			end
		elseif var_42_1 == 1 then
			self.btnController_:SetSelectedState(self.curSceneID_ == var_42_2 and "trialing" or "trial")
			self:RefreshTime()
		elseif var_42_1 == 2 then
			self.btnController_:SetSelectedState(self.curSceneID_ == var_42_2 and "using" or "use")
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.tglContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.tglContent_)
end

function ScenePreviewView:IsCanGet()
	return (self.cfg_.obtain_way or nil) and #self.cfg_.obtain_way > 0 and not JumpTools.NeedHide(self.cfg_.obtain_way, self.curSceneID_) and not JumpTools.GetLinkIsLocked(self.cfg_.obtain_way)
end

function ScenePreviewView:RefreshTime()
	self:StopTimer()

	local var_44_0 = manager.time:GetServerTime()
	local var_44_1 = HomeSceneSettingData:GetSceneTimeStamp(self.curSceneID_)

	self.time_.text = string.format(GetTips("TIME_DISPLAY_12"), TimeMgr.GetInstance():STimeDescS(var_44_1, "!%Y/%m/%d %H:%M"))
	self.timer_ = Timer.New(function()
		if var_44_1 and var_44_0 <= var_44_1 then
			self.time_.text = string.format(GetTips("TIME_DISPLAY_12"), TimeMgr.GetInstance():STimeDescS(var_44_1, "!%Y/%m/%d %H:%M"))
		else
			HomeSceneSettingAction.SetHomeScene(GameSetting.home_sence_default.value[1])

			self.curSceneID_ = HomeSceneSettingData:GetCurScene()
			self.curPage_ = HomeSceneSettingCfg[self.curSceneID_] and HomeSceneSettingCfg[self.curSceneID_].limit_display == 0 and 2 or 1

			self:RefreshUI()
		end
	end, 1, -1)

	self.timer_:Start()
end

function ScenePreviewView:RefreshRedPoint()
	saveData("scene", tostring(self.curSceneID_), 0)
	manager.redPoint:setTip(RedPointConst.SCENE .. "_" .. self.curSceneID_, 0)
end

function ScenePreviewView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ScenePreviewView:AddClickTimer()
	self:StopClickTimer()

	self.buttonUp_ = 0
	self.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		if Input.GetMouseButtonUp(0) then
			self.buttonUp_ = self.buttonUp_ + 1

			if self.buttonUp_ >= 2 then
				for iter_49_0, iter_49_1 in ipairs(HomeSceneTagCfg.all) do
					if self.effectTgl[iter_49_1].toggle then
						self.effectTgl[iter_49_1].toggle.isOn = false
					end
				end

				self:HideMessage()

				if self.clickTimer_ then
					FuncTimerManager.inst:RemoveFuncTimer(self.clickTimer_)

					self.clickTimer_ = nil
				end
			end
		end
	end, -1, true)
end

function ScenePreviewView:StopClickTimer()
	if self.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(self.clickTimer_)

		self.clickTimer_ = nil
	end
end

function ScenePreviewView:CheckPlayBgm()
	local var_51_0 = HomeSceneSettingCfg[HomeSceneSettingData:GetCurScene()]

	if var_51_0.default_music ~= 0 and self.settingData_.home_scene_scene_bgm == 1 and table.indexof(var_51_0.scene_setting, HomeSceneSettingConst.SETTING.SCENE_BGM) then
		IllustratedAction.QuerySetBgm(var_51_0.default_music)
	end
end

function ScenePreviewView:OnHomeSceneChange()
	self:RefreshUI()
end

function ScenePreviewView:OnChangePosterGirl()
	self:RefreshUI()
end

function ScenePreviewView:OnHomeSceneSettingChange(arg_54_1, arg_54_2)
	if arg_54_2.key == "allData" then
		self:RefreshSoundEffect()
	elseif arg_54_2.key == "home_scene_sound_effect" then
		self:RefreshSoundEffect()
	elseif arg_54_2.key == "home_scene_camera_follow" then
		-- block empty
	elseif arg_54_2.key == "home_scene_scene_bgm" then
		self:RefreshSceneBgm()
	end
end

function ScenePreviewView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ScenePreviewView:OnExit()
	self:CheckPlayBgm()
	self:UnbindRedpoint()
	self:StopTimer()

	for iter_56_0, iter_56_1 in ipairs(self.sceneScrollHelper_:GetItemList()) do
		iter_56_1:OnExit()
	end

	for iter_56_2, iter_56_3 in ipairs(self.dlcScrollHelper_:GetItemList()) do
		iter_56_3:OnExit()
	end

	manager.windowBar:HideBar()
end

function ScenePreviewView:UseScene(arg_57_1)
	if HomeSceneSettingData:IsRandomScene() then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("RANDOM_SCENE_TIPS"),
			OkCallback = function()
				HomeSceneSettingAction.SetIsRandomScene(false, function()
					return
				end)
				HomeSceneSettingAction.SetHomeScene(arg_57_1)
			end
		})
	else
		if HomeSceneSettingCfg[arg_57_1] and HomeSceneSettingCfg[arg_57_1].limit_display == 1 and PlayerData:IsRandomHero() and PlayerData:IsRandomHeroUseDlcScene() then
			HomeSceneSettingData:SetIsUseDlcScene(false)
		end

		if HomeSceneSettingData:GetCurScene() == arg_57_1 then
			self:RefreshUI()
		end

		HomeSceneSettingAction.SetHomeScene(arg_57_1)
	end

	if PosterGirlTools.SceneHasTimeEffect(arg_57_1) then
		HomeSceneSettingData:SetIsTimeScene(false)
	end
end

function ScenePreviewView:BindRedpoint()
	manager.redPoint:bindUIandKey(self.sceneBtn_.transform, RedPointConst.SCENE_NORMAL)
	manager.redPoint:bindUIandKey(self.dlcBtn_.transform, RedPointConst.SCENE_DLC)
end

function ScenePreviewView:UnbindRedpoint()
	manager.redPoint:unbindUIandKey(self.sceneBtn_.transform)
	manager.redPoint:unbindUIandKey(self.dlcBtn_.transform)
end

function ScenePreviewView:Dispose()
	self:RemoveAllListeners()

	if self.sceneScrollHelper_ then
		self.sceneScrollHelper_:Dispose()

		self.sceneScrollHelper_ = nil
	end

	if self.dlcScrollHelper_ then
		self.dlcScrollHelper_:Dispose()

		self.dlcScrollHelper_ = nil
	end

	ScenePreviewView.super.Dispose(self)
end

return ScenePreviewView

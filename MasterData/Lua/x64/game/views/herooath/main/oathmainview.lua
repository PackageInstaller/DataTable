local OathMainView = class("OathMainView", ReduxView)

function OathMainView:UIName()
	return "Widget/System/Hero_Oath/HeroOathMainUI"
end

function OathMainView:UIParent()
	return manager.ui.uiMain.transform
end

function OathMainView:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.btnContent_ = OathMainBtnContent.New(self.btnContent_)
	self.oathHeroList_ = LuaList.New(handler(self, self.IndexOathHeroItem), self.listGo_, OathHeroItem)
	self.expendHeroController_ = self.controller_:GetController("expendHeroList")
	self.oathReadyController = self.controller_:GetController("oath")
	self.showConditionController = self.controller_:GetController("showCondition")
	self.toggleController = self.toggleController_:GetController("default0")
	self.movieController_ = self.controller_:GetController("movie")
	self.criMovie_ = self.movieGo_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criMovie_.player

	self.criplayer_:SetMaxPictureDataSize(300000)
	self.criMovie_:Stop()

	function self.criplayer_.statusChangeCallback(arg_4_0)
		self:CirMovieStatusChange(arg_4_0)
	end

	self.criLoopMovie_ = self.movieLoopGo_:GetComponent("CriManaMovieControllerForUI")
	self.criLoopPlayer_ = self.criLoopMovie_.player

	self.criLoopPlayer_:SetMaxPictureDataSize(300000)
	self.criLoopMovie_:Stop()

	function self.criLoopPlayer_.statusChangeCallback(arg_5_0)
		self:CirMovieStatusChange(arg_5_0)
	end

	self.moviePlaying = false
	self.isPlayMovie = false
end

function OathMainView:IndexOathHeroItem(arg_6_1, arg_6_2)
	local var_6_0 = self.oath_hero_list[arg_6_1]

	arg_6_2:SetData(self.oath_hero_list[arg_6_1])
	arg_6_2:ChangeSelect(var_6_0 == self.selectHeroID)
end

function OathMainView:RefreshOathList()
	self.oath_hero_list = OathTools.GetHeroSortList(WeddingCfg.all)

	self.oathHeroList_:StartScroll(#WeddingCfg.all)
end

function OathMainView:SelectToOathHero(arg_8_1)
	self:CheckHeroOathLevelUp()

	if self.selectHeroID ~= arg_8_1 then
		local var_8_0 = table.indexof(self.oath_hero_list, self.selectHeroID)

		if var_8_0 then
			local var_8_1 = self.oathHeroList_:GetItemByIndex(var_8_0)

			if var_8_1 then
				var_8_1:ChangeSelect(false)
			end
		end

		self.selectHeroID = arg_8_1

		local var_8_2 = self.oathHeroList_:GetItemByIndex((table.indexof(self.oath_hero_list, self.selectHeroID)))

		if var_8_2 then
			var_8_2:ChangeSelect(true)
		end

		return true
	end

	return false
end

function OathMainView:RefreshSelectContent()
	self.btnContent_:SetData(self.selectHeroID)

	self.heroImg_.sprite = OathTools.GetOathCharacterSprite(self.selectHeroID)

	self:RefreshOathCondition(self.selectHeroID)
	OathSupportData:SetOathNewHeroNoticeShowed(self.selectHeroID)
	SetActive(self.canOathObj_, (manager.redPoint:getTipBoolean(RedPointConst.OATH_HERO_CAN_COMPLETE .. self.selectHeroID)))
end

local OathConditionItem = class("OathConditionItem", BaseView)

function OathConditionItem:Ctor(arg_10_1)
	self.gameObject_ = arg_10_1
	self.transform_ = arg_10_1.transform

	self:BindCfgUI()

	self.stateController = self.controllers_:GetController("lock")
	self.showIconController = self.controllers_:GetController("showIcon")
	self.showJumpController = self.controllers_:GetController("btn")

	self:AddBtnListener(self.jumpBtn_, nil, function()
		if self.jumpLink then
			JumpTools.JumpToPage(self.jumpLink)
		end
	end)
end

function OathConditionItem:SetIsShow(arg_12_1)
	SetActive(self.gameObject_, arg_12_1)
end

function OathConditionItem:SetData(arg_13_1, arg_13_2)
	self.desc_.text = GetI18NText(ConditionCfg[arg_13_1].desc)
	self.jumpLink = arg_13_2

	if ConditionCfg[arg_13_1].type == 330001 then
		self:SetShowIcon(true)

		self.icon_.spriteSync = ItemTools.getItemSprite(ConditionCfg[arg_13_1].params[1], nil, true)
	else
		self:SetShowIcon(false)
	end

	self.stateController:SetSelectedState(IsConditionAchieved(arg_13_1) and "unlock" or "lock")
	self.showJumpController:SetSelectedState(IsConditionAchieved(arg_13_1) and "off" or "on")
end

function OathConditionItem:SetShowIcon(arg_14_1)
	self.showIconController:SetSelectedState(arg_14_1 and "true" or "false")
end

function OathConditionItem:Dispose()
	self:RemoveAllListeners()
	OathConditionItem.super.Dispose(self)
end

local function var_0_2(arg_16_0, arg_16_1)
	for iter_16_0 = arg_16_0.conditionList_.childCount + 1, arg_16_1 do
		local var_16_0 = Object.Instantiate(arg_16_0.conditionItemPrefab_, arg_16_0.conditionList_)
	end

	for iter_16_1 = 1, arg_16_0.conditionList_.childCount do
		arg_16_0.items[iter_16_1] = arg_16_0.items[iter_16_1] or OathConditionItem.New(arg_16_0.conditionList_:GetChild(iter_16_1 - 1).gameObject)

		arg_16_0.items[iter_16_1]:SetIsShow(iter_16_1 <= arg_16_1)
	end
end

function OathMainView:RefreshOathCondition(arg_17_1)
	if OathTools.IsOath(arg_17_1) then
		self.oathReadyController:SetSelectedState("completed")
		self.showConditionController:SetSelectedState("false")
	else
		local var_17_0 = WeddingCfg[arg_17_1].condition

		var_0_2(self, #WeddingCfg[arg_17_1].condition)

		local var_17_1 = true

		for iter_17_0, iter_17_1 in ipairs(var_17_0) do
			self.items[iter_17_0]:SetData(iter_17_1, WeddingCfg[arg_17_1].jump[iter_17_0])

			if not IsConditionAchieved(iter_17_1) then
				var_17_1 = false
			end
		end

		self.oathReadyController:SetSelectedState(var_17_1 and "ready" or "preview")
		self.showConditionController:SetSelectedState("true")
	end
end

function OathMainView:AddListeners()
	self:AddBtnListener(self.expendBtn_, nil, function()
		if self.expendHeroController_:GetSelectedState() == "up" then
			self.expendHeroController_:SetSelectedState("down")
		else
			self.expendHeroController_:SetSelectedState("up")
		end
	end)
	self:AddBtnListener(self.oathBtn1_, nil, function()
		self:OnClickOathBtn()
	end)
	self:AddBtnListener(self.oathBtn2_, nil, function()
		self:OnClickOathBtn()
	end)
	self:AddBtnListener(self.closeHeroListBtn_, nil, function()
		self.expendHeroController_:SetSelectedState("down")
	end)
	self:AddBtnListener(self.dynamicBtn_, nil, function()
		if self.toggleController:GetSelectedIndex() == 0 then
			self.toggleController:SetSelectedIndex(1)
			self.movieController_:SetSelectedIndex(0)

			self.movieGo_.transform.localPosition = Vector2(9999, 9999)
			self.movieLoopGo_.transform.localPosition = Vector2(9999, 9999)

			self:StopMovie()
		else
			self.toggleController:SetSelectedIndex(0)
			self.movieController_:SetSelectedIndex(1)

			self.movieGo_.transform.localPosition = Vector2(0, 0)
			self.movieLoopGo_.transform.localPosition = Vector2(0, 0)

			self:PlayEnterAni()
		end
	end)
	self:AddBtnListener(self.staticBtn_, nil, function()
		if self.toggleController:GetSelectedIndex() == 0 then
			self.toggleController:SetSelectedIndex(1)
			self.movieController_:SetSelectedIndex(0)

			self.movieGo_.transform.localPosition = Vector2(9999, 9999)
			self.movieLoopGo_.transform.localPosition = Vector2(9999, 9999)

			self:StopMovie()
		else
			self.toggleController:SetSelectedIndex(0)
			self.movieController_:SetSelectedIndex(1)

			self.movieGo_.transform.localPosition = Vector2(0, 0)
			self.movieLoopGo_.transform.localPosition = Vector2(0, 0)

			self:PlayEnterAni()
		end
	end)
end

function OathMainView:PlayEnterAni()
	self.isPlayMovie = true

	SetFile(self.criLoopPlayer_, nil, "SofdecAsset/story/story_" .. (WeddingCfg[self.selectHeroID].wedding_plot[2] .. "_" .. ((self.selectHeroID == 1095 or nil) and math.random(2, 3))) .. ".usm", CriMana.Player.SetMode.New)
	self.criLoopPlayer_:Prepare()
	self:PlayMovie(self.criLoopPlayer_, self.criLoopMovie_)
end

function OathMainView:PlayMovie(arg_26_1, arg_26_2)
	arg_26_1:SetVolume((manager.audio:GetMusicVolume()))
	arg_26_2:Play()

	self.moviePlaying = true
end

function OathMainView:CirMovieStatusChange(arg_27_1)
	local var_27_0 = tostring(arg_27_1)

	if var_27_0 == "PlayEnd" then
		self.hasViewStart_ = true
		self.movieLoopGo_.transform.localPosition = Vector2(0, 0)

		self:PlayMovie(self.criLoopPlayer_, self.criLoopMovie_)

		self.movieGo_.transform.localPosition = Vector2(9999, 9999)
	elseif var_27_0 == "Stop" then
		self:PlayEnterAni()
	elseif var_27_0 == "Error" then
		self.criLoopPlayer_:Stop()
	end
end

function OathMainView:StopMovie()
	if self.criMovie_ then
		self.criMovie_:Stop()
	end

	if self.criLoopMovie_ then
		self.criLoopMovie_:Stop()
	end

	self.moviePlaying = false
end

function OathMainView:DisPoseMovie()
	if self.criMovie_ or self.criLoopMovie_ then
		self:StopMovie()

		if self.criPlayer_ then
			self.criPlayer_:Dispose()

			self.criplayer_.statusChangeCallback = nil
			self.criPlayer_ = nil
		end

		if self.criLoopPlayer_ then
			self.criLoopPlayer_:Dispose()

			self.criplayer_.statusChangeCallback = nil
			self.criLoopPlayer_ = nil
		end
	end
end

function OathMainView:OnClickOathBtn()
	OathLaunchScene(WeddingCfg[self.selectHeroID].wedding_scene, self.selectHeroID, WeddingCfg[self.selectHeroID].skin_id, OathConst.OATH_SCENE_MODE.OATH)
end

function OathMainView:AddEventListeners()
	self:RegistEventListener(OATH_SELECT_HERO, handler(self, self.OnClickOathHero))
	self:RegistEventListener(OATH_CHANGE_NAME, handler(self, self.OnChangeOathName))
	self:RegistEventListener(OATH_HERO_LEVEL_UP, handler(self, self.CheckHeroOathLevelUp))
	self:RegistEventListener(OATH_SCENE_ENTER_HOME_VIEW, handler(self, self.OnExitSceneEnterHomeView))
end

function OathMainView:OnClickOathHero(arg_32_1)
	if self:SelectToOathHero(arg_32_1) then
		self:RefreshSelectContent()
		self:RefreshToggleContent()

		if self.toggleController:GetSelectedIndex() == 0 then
			self:StopMovie()

			self.panelAni_.enabled = false
		else
			self.panelAni_.enabled = true

			self.ani_:Play("UI_HeroOathMainUI", 0, 0)
		end
	end
end

function OathMainView:OnChangeOathName()
	self.btnContent_:RefreshNameUI()
end

function OathMainView:OnExitSceneEnterHomeView()
	if self.params_ and self.params_.enterCallback then
		self.params_.enterCallback()

		self.params_.enterCallback = nil
	end
end

function OathMainView:CheckHeroOathLevelUp()
	local var_35_0, var_35_1 = OathCollectionContentData:HasNewLevelUpdateMsg(self.selectHeroID)

	if var_35_1 then
		JumpTools.OpenPageByJump("oathLevelUpPop", {
			heroID = var_35_0,
			level = var_35_1
		})
	end
end

function OathMainView:RefreshToggleContent()
	local var_36_0 = false

	self.storys = nullable(WeddingCfg[self.selectHeroID], "wedding_plot") or {}
	self.pics = {}

	for iter_36_0, iter_36_1 in ipairs(self.storys) do
		table.insert(self.pics, CollectPictureCfg.get_id_list_by_additional_parameter[iter_36_1])
	end

	for iter_36_2, iter_36_3 in pairs(self.pics[1]) do
		if IllustratedData:GetIllustrationInfo()[iter_36_3] == nil then
			rewardAvailable = false
			rewardList = nil
			var_36_0 = true

			break
		end
	end

	if var_36_0 then
		self.toggleController:SetSelectedIndex(1)
		self.movieController_:SetSelectedIndex(0)

		self.movieGo_.transform.localPosition = Vector2(9999, 9999)
		self.movieLoopGo_.transform.localPosition = Vector2(9999, 9999)

		self:StopMovie()
	end

	SetActive(self.toggleGo_, not var_36_0)
end

function OathMainView:OnEnter()
	local var_37_0 = self.params_ and self.params_.selectHeroID

	self:AddEventListeners()

	local var_37_1

	if not var_37_0 then
		::label_37_0::

		var_37_1 = self.selectHeroID or self.oath_hero_list[1]
	end

	self.selectHeroID = var_37_1

	self:SelectToOathHero(self.selectHeroID)
	self:RefreshOathList()

	if self.toggleController:GetSelectedIndex() == 0 then
		self.panelAni_.enabled = false
	else
		self.panelAni_.enabled = true

		self.ani_:Play("UI_HeroOathMainUI", 0, 0)
	end

	self:RefreshSelectContent()
	self:RefreshToggleContent()
	self.expendHeroController_:SetSelectedState("down")

	if self.params_ then
		self.params_.selectHeroID = nil
	end
end

function OathMainView:OnTop()
	self:RefreshBar()
end

function OathMainView:OnBehind()
	manager.windowBar:HideBar()
end

function OathMainView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function OathMainView:OnExit()
	manager.windowBar:HideBar()

	if self.isPlayMovie then
		self:StopMovie()

		self.isPlayMovie = false
	end

	self.btnContent_:OnExit()
	self:RemoveAllEventListener()
end

function OathMainView:Init()
	self.items = {}

	self:InitUI()
end

function OathMainView:Dispose()
	self.oathHeroList_:Dispose()
	self:DisPoseMovie()

	if self.btnContent_ then
		self.btnContent_:Dispose()

		self.btnContent_ = nil
	end

	if self.items then
		for iter_43_0, iter_43_1 in pairs(self.items) do
			Object.Destroy(iter_43_1.gameObject_)
			iter_43_1:Dispose()
		end

		self.items = nil
	end

	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return OathMainView

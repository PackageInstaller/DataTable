local var_0_0 = class("OathMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_Oath/HeroOathMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.btnContent_ = OathMainBtnContent.New(arg_3_0.btnContent_)
	arg_3_0.oathHeroList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexOathHeroItem), arg_3_0.listGo_, OathHeroItem)
	arg_3_0.expendHeroController_ = arg_3_0.controller_:GetController("expendHeroList")
	arg_3_0.oathReadyController = arg_3_0.controller_:GetController("oath")
	arg_3_0.showConditionController = arg_3_0.controller_:GetController("showCondition")
	arg_3_0.toggleController = arg_3_0.toggleController_:GetController("default0")
	arg_3_0.movieController_ = arg_3_0.controller_:GetController("movie")
	arg_3_0.criMovie_ = arg_3_0.movieGo_:GetComponent("CriManaMovieControllerForUI")
	arg_3_0.criplayer_ = arg_3_0.criMovie_.player

	arg_3_0.criplayer_:SetMaxPictureDataSize(300000)
	arg_3_0.criMovie_:Stop()

	function arg_3_0.criplayer_.statusChangeCallback(arg_4_0)
		arg_3_0:CirMovieStatusChange(arg_4_0)
	end

	arg_3_0.criLoopMovie_ = arg_3_0.movieLoopGo_:GetComponent("CriManaMovieControllerForUI")
	arg_3_0.criLoopPlayer_ = arg_3_0.criLoopMovie_.player

	arg_3_0.criLoopPlayer_:SetMaxPictureDataSize(300000)
	arg_3_0.criLoopMovie_:Stop()

	function arg_3_0.criLoopPlayer_.statusChangeCallback(arg_5_0)
		arg_3_0:CirMovieStatusChange(arg_5_0)
	end

	arg_3_0.moviePlaying = false
	arg_3_0.isPlayMovie = false
end

function var_0_0.IndexOathHeroItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.oath_hero_list[arg_6_1]

	arg_6_2:SetData(var_6_0)
	arg_6_2:ChangeSelect(var_6_0 == arg_6_0.selectHeroID)
end

function var_0_0.RefreshOathList(arg_7_0)
	local var_7_0 = WeddingCfg.all

	arg_7_0.oath_hero_list = OathTools.GetHeroSortList(var_7_0)

	arg_7_0.oathHeroList_:StartScroll(#var_7_0)
end

function var_0_0.SelectToOathHero(arg_8_0, arg_8_1)
	arg_8_0:CheckHeroOathLevelUp()

	if arg_8_0.selectHeroID ~= arg_8_1 then
		local var_8_0 = table.indexof(arg_8_0.oath_hero_list, arg_8_0.selectHeroID)

		if var_8_0 then
			local var_8_1 = arg_8_0.oathHeroList_:GetItemByIndex(var_8_0)

			if var_8_1 then
				var_8_1:ChangeSelect(false)
			end
		end

		arg_8_0.selectHeroID = arg_8_1

		local var_8_2 = table.indexof(arg_8_0.oath_hero_list, arg_8_0.selectHeroID)
		local var_8_3 = arg_8_0.oathHeroList_:GetItemByIndex(var_8_2)

		if var_8_3 then
			var_8_3:ChangeSelect(true)
		end

		return true
	end

	return false
end

function var_0_0.RefreshSelectContent(arg_9_0)
	arg_9_0.btnContent_:SetData(arg_9_0.selectHeroID)

	arg_9_0.heroImg_.sprite = OathTools.GetOathCharacterSprite(arg_9_0.selectHeroID)

	arg_9_0:RefreshOathCondition(arg_9_0.selectHeroID)
	OathSupportData:SetOathNewHeroNoticeShowed(arg_9_0.selectHeroID)

	local var_9_0 = manager.redPoint:getTipBoolean(RedPointConst.OATH_HERO_CAN_COMPLETE .. arg_9_0.selectHeroID)

	SetActive(arg_9_0.canOathObj_, var_9_0)
end

local var_0_1 = class("OathConditionItem", BaseView)

function var_0_1.Ctor(arg_10_0, arg_10_1)
	arg_10_0.gameObject_ = arg_10_1
	arg_10_0.transform_ = arg_10_1.transform

	arg_10_0:BindCfgUI()

	arg_10_0.stateController = arg_10_0.controllers_:GetController("lock")
	arg_10_0.showIconController = arg_10_0.controllers_:GetController("showIcon")
	arg_10_0.showJumpController = arg_10_0.controllers_:GetController("btn")

	arg_10_0:AddBtnListener(arg_10_0.jumpBtn_, nil, function()
		if arg_10_0.jumpLink then
			JumpTools.JumpToPage(arg_10_0.jumpLink)
		end
	end)
end

function var_0_1.SetIsShow(arg_12_0, arg_12_1)
	SetActive(arg_12_0.gameObject_, arg_12_1)
end

function var_0_1.SetData(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = ConditionCfg[arg_13_1]

	arg_13_0.desc_.text = GetI18NText(var_13_0.desc)
	arg_13_0.jumpLink = arg_13_2

	if var_13_0.type == 330001 then
		arg_13_0:SetShowIcon(true)

		local var_13_1 = var_13_0.params[1]
		local var_13_2 = ItemTools.getItemSprite(var_13_1, nil, true)

		arg_13_0.icon_.spriteSync = var_13_2
	else
		arg_13_0:SetShowIcon(false)
	end

	arg_13_0.stateController:SetSelectedState(IsConditionAchieved(arg_13_1) and "unlock" or "lock")
	arg_13_0.showJumpController:SetSelectedState(IsConditionAchieved(arg_13_1) and "off" or "on")
end

function var_0_1.SetShowIcon(arg_14_0, arg_14_1)
	arg_14_0.showIconController:SetSelectedState(arg_14_1 and "true" or "false")
end

function var_0_1.Dispose(arg_15_0)
	arg_15_0:RemoveAllListeners()
	var_0_1.super.Dispose(arg_15_0)
end

local function var_0_2(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.conditionList_

	for iter_16_0 = var_16_0.childCount + 1, arg_16_1 do
		local var_16_1 = Object.Instantiate(arg_16_0.conditionItemPrefab_, var_16_0)
	end

	local var_16_2 = var_16_0.childCount

	for iter_16_1 = 1, var_16_2 do
		local var_16_3 = var_16_0:GetChild(iter_16_1 - 1).gameObject

		arg_16_0.items[iter_16_1] = arg_16_0.items[iter_16_1] or var_0_1.New(var_16_3)

		arg_16_0.items[iter_16_1]:SetIsShow(iter_16_1 <= arg_16_1)
	end
end

function var_0_0.RefreshOathCondition(arg_17_0, arg_17_1)
	if OathTools.IsOath(arg_17_1) then
		arg_17_0.oathReadyController:SetSelectedState("completed")
		arg_17_0.showConditionController:SetSelectedState("false")
	else
		local var_17_0 = WeddingCfg[arg_17_1].condition
		local var_17_1 = WeddingCfg[arg_17_1].jump

		var_0_2(arg_17_0, #var_17_0)

		local var_17_2 = true

		for iter_17_0, iter_17_1 in ipairs(var_17_0) do
			arg_17_0.items[iter_17_0]:SetData(iter_17_1, var_17_1[iter_17_0])

			if not IsConditionAchieved(iter_17_1) then
				var_17_2 = false
			end
		end

		arg_17_0.oathReadyController:SetSelectedState(var_17_2 and "ready" or "preview")
		arg_17_0.showConditionController:SetSelectedState("true")
	end
end

function var_0_0.AddListeners(arg_18_0)
	arg_18_0:AddBtnListener(arg_18_0.expendBtn_, nil, function()
		if arg_18_0.expendHeroController_:GetSelectedState() == "up" then
			arg_18_0.expendHeroController_:SetSelectedState("down")
		else
			arg_18_0.expendHeroController_:SetSelectedState("up")
		end
	end)
	arg_18_0:AddBtnListener(arg_18_0.oathBtn1_, nil, function()
		arg_18_0:OnClickOathBtn()
	end)
	arg_18_0:AddBtnListener(arg_18_0.oathBtn2_, nil, function()
		arg_18_0:OnClickOathBtn()
	end)
	arg_18_0:AddBtnListener(arg_18_0.closeHeroListBtn_, nil, function()
		arg_18_0.expendHeroController_:SetSelectedState("down")
	end)
	arg_18_0:AddBtnListener(arg_18_0.dynamicBtn_, nil, function()
		if arg_18_0.toggleController:GetSelectedIndex() == 0 then
			arg_18_0.toggleController:SetSelectedIndex(1)
			arg_18_0.movieController_:SetSelectedIndex(0)

			arg_18_0.movieGo_.transform.localPosition = Vector2(9999, 9999)
			arg_18_0.movieLoopGo_.transform.localPosition = Vector2(9999, 9999)

			arg_18_0:StopMovie()
		else
			arg_18_0.toggleController:SetSelectedIndex(0)
			arg_18_0.movieController_:SetSelectedIndex(1)

			arg_18_0.movieGo_.transform.localPosition = Vector2(0, 0)
			arg_18_0.movieLoopGo_.transform.localPosition = Vector2(0, 0)

			arg_18_0:PlayEnterAni()
		end
	end)
	arg_18_0:AddBtnListener(arg_18_0.staticBtn_, nil, function()
		if arg_18_0.toggleController:GetSelectedIndex() == 0 then
			arg_18_0.toggleController:SetSelectedIndex(1)
			arg_18_0.movieController_:SetSelectedIndex(0)

			arg_18_0.movieGo_.transform.localPosition = Vector2(9999, 9999)
			arg_18_0.movieLoopGo_.transform.localPosition = Vector2(9999, 9999)

			arg_18_0:StopMovie()
		else
			arg_18_0.toggleController:SetSelectedIndex(0)
			arg_18_0.movieController_:SetSelectedIndex(1)

			arg_18_0.movieGo_.transform.localPosition = Vector2(0, 0)
			arg_18_0.movieLoopGo_.transform.localPosition = Vector2(0, 0)

			arg_18_0:PlayEnterAni()
		end
	end)
end

function var_0_0.PlayEnterAni(arg_25_0)
	arg_25_0.isPlayMovie = true

	local var_25_0 = WeddingCfg[arg_25_0.selectHeroID]
	local var_25_1 = 2

	if arg_25_0.selectHeroID == 1095 then
		var_25_1 = math.random(2, 3)
	end

	local var_25_2 = var_25_0.wedding_plot[2] .. "_" .. var_25_1

	SetFile(arg_25_0.criLoopPlayer_, nil, "SofdecAsset/story/story_" .. var_25_2 .. ".usm", CriMana.Player.SetMode.New)
	arg_25_0.criLoopPlayer_:Prepare()
	arg_25_0:PlayMovie(arg_25_0.criLoopPlayer_, arg_25_0.criLoopMovie_)
end

function var_0_0.PlayMovie(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = manager.audio:GetMusicVolume()

	arg_26_1:SetVolume(var_26_0)
	arg_26_2:Play()

	arg_26_0.moviePlaying = true
end

function var_0_0.CirMovieStatusChange(arg_27_0, arg_27_1)
	local var_27_0 = tostring(arg_27_1)

	if var_27_0 == "PlayEnd" then
		arg_27_0.hasViewStart_ = true
		arg_27_0.movieLoopGo_.transform.localPosition = Vector2(0, 0)

		arg_27_0:PlayMovie(arg_27_0.criLoopPlayer_, arg_27_0.criLoopMovie_)

		arg_27_0.movieGo_.transform.localPosition = Vector2(9999, 9999)
	elseif var_27_0 == "Stop" then
		arg_27_0:PlayEnterAni()
	elseif var_27_0 == "Error" then
		arg_27_0.criLoopPlayer_:Stop()
	end
end

function var_0_0.StopMovie(arg_28_0)
	if arg_28_0.criMovie_ then
		arg_28_0.criMovie_:Stop()
	end

	if arg_28_0.criLoopMovie_ then
		arg_28_0.criLoopMovie_:Stop()
	end

	arg_28_0.moviePlaying = false
end

function var_0_0.DisPoseMovie(arg_29_0)
	if arg_29_0.criMovie_ or arg_29_0.criLoopMovie_ then
		arg_29_0:StopMovie()

		if arg_29_0.criPlayer_ then
			arg_29_0.criPlayer_:Dispose()

			arg_29_0.criplayer_.statusChangeCallback = nil
			arg_29_0.criPlayer_ = nil
		end

		if arg_29_0.criLoopPlayer_ then
			arg_29_0.criLoopPlayer_:Dispose()

			arg_29_0.criplayer_.statusChangeCallback = nil
			arg_29_0.criLoopPlayer_ = nil
		end
	end
end

function var_0_0.OnClickOathBtn(arg_30_0)
	local var_30_0 = WeddingCfg[arg_30_0.selectHeroID]

	OathLaunchScene(var_30_0.wedding_scene, arg_30_0.selectHeroID, var_30_0.skin_id, OathConst.OATH_SCENE_MODE.OATH)
end

function var_0_0.AddEventListeners(arg_31_0)
	arg_31_0:RegistEventListener(OATH_SELECT_HERO, handler(arg_31_0, arg_31_0.OnClickOathHero))
	arg_31_0:RegistEventListener(OATH_CHANGE_NAME, handler(arg_31_0, arg_31_0.OnChangeOathName))
	arg_31_0:RegistEventListener(OATH_HERO_LEVEL_UP, handler(arg_31_0, arg_31_0.CheckHeroOathLevelUp))
	arg_31_0:RegistEventListener(OATH_SCENE_ENTER_HOME_VIEW, handler(arg_31_0, arg_31_0.OnExitSceneEnterHomeView))
end

function var_0_0.OnClickOathHero(arg_32_0, arg_32_1)
	if arg_32_0:SelectToOathHero(arg_32_1) then
		arg_32_0:RefreshSelectContent()
		arg_32_0:RefreshToggleContent()

		if arg_32_0.toggleController:GetSelectedIndex() == 0 then
			arg_32_0:StopMovie()

			arg_32_0.panelAni_.enabled = false
		else
			arg_32_0.panelAni_.enabled = true

			arg_32_0.ani_:Play("UI_HeroOathMainUI", 0, 0)
		end
	end
end

function var_0_0.OnChangeOathName(arg_33_0)
	arg_33_0.btnContent_:RefreshNameUI()
end

function var_0_0.OnExitSceneEnterHomeView(arg_34_0)
	if arg_34_0.params_ and arg_34_0.params_.enterCallback then
		arg_34_0.params_.enterCallback()

		arg_34_0.params_.enterCallback = nil
	end
end

function var_0_0.CheckHeroOathLevelUp(arg_35_0)
	local var_35_0, var_35_1 = OathCollectionContentData:HasNewLevelUpdateMsg(arg_35_0.selectHeroID)

	if var_35_1 then
		JumpTools.OpenPageByJump("oathLevelUpPop", {
			heroID = var_35_0,
			level = var_35_1
		})
	end
end

function var_0_0.RefreshToggleContent(arg_36_0)
	local var_36_0 = false
	local var_36_1 = WeddingCfg[arg_36_0.selectHeroID]

	arg_36_0.storys = nullable(var_36_1, "wedding_plot") or {}
	arg_36_0.pics = {}

	for iter_36_0, iter_36_1 in ipairs(arg_36_0.storys) do
		local var_36_2 = CollectPictureCfg.get_id_list_by_additional_parameter[iter_36_1]

		table.insert(arg_36_0.pics, var_36_2)
	end

	for iter_36_2, iter_36_3 in pairs(arg_36_0.pics[1]) do
		if IllustratedData:GetIllustrationInfo()[iter_36_3] == nil then
			rewardAvailable = false
			rewardList = nil
			var_36_0 = true

			break
		end
	end

	if var_36_0 then
		arg_36_0.toggleController:SetSelectedIndex(1)
		arg_36_0.movieController_:SetSelectedIndex(0)

		arg_36_0.movieGo_.transform.localPosition = Vector2(9999, 9999)
		arg_36_0.movieLoopGo_.transform.localPosition = Vector2(9999, 9999)

		arg_36_0:StopMovie()
	end

	SetActive(arg_36_0.toggleGo_, not var_36_0)
end

function var_0_0.OnEnter(arg_37_0)
	local var_37_0 = arg_37_0.params_ and arg_37_0.params_.selectHeroID

	arg_37_0:AddEventListeners()

	arg_37_0.selectHeroID = var_37_0 or arg_37_0.selectHeroID or arg_37_0.oath_hero_list[1]

	arg_37_0:SelectToOathHero(arg_37_0.selectHeroID)
	arg_37_0:RefreshOathList()

	if arg_37_0.toggleController:GetSelectedIndex() == 0 then
		arg_37_0.panelAni_.enabled = false
	else
		arg_37_0.panelAni_.enabled = true

		arg_37_0.ani_:Play("UI_HeroOathMainUI", 0, 0)
	end

	arg_37_0:RefreshSelectContent()
	arg_37_0:RefreshToggleContent()
	arg_37_0.expendHeroController_:SetSelectedState("down")

	if arg_37_0.params_ then
		arg_37_0.params_.selectHeroID = nil
	end
end

function var_0_0.OnTop(arg_38_0)
	arg_38_0:RefreshBar()
end

function var_0_0.OnBehind(arg_39_0)
	manager.windowBar:HideBar()
end

function var_0_0.RefreshBar(arg_40_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_41_0)
	manager.windowBar:HideBar()

	if arg_41_0.isPlayMovie then
		arg_41_0:StopMovie()

		arg_41_0.isPlayMovie = false
	end

	arg_41_0.btnContent_:OnExit()
	arg_41_0:RemoveAllEventListener()
end

function var_0_0.Init(arg_42_0)
	arg_42_0.items = {}

	arg_42_0:InitUI()
end

function var_0_0.Dispose(arg_43_0)
	arg_43_0.oathHeroList_:Dispose()
	arg_43_0:DisPoseMovie()

	if arg_43_0.btnContent_ then
		arg_43_0.btnContent_:Dispose()

		arg_43_0.btnContent_ = nil
	end

	if arg_43_0.items then
		for iter_43_0, iter_43_1 in pairs(arg_43_0.items) do
			Object.Destroy(iter_43_1.gameObject_)
			iter_43_1:Dispose()
		end

		arg_43_0.items = nil
	end

	arg_43_0:RemoveAllListeners()
	arg_43_0.super.Dispose(arg_43_0)
end

return var_0_0

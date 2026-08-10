local var_0_0 = class("SummerCookMenuView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_SummerPub/CookingGame/cookBookUI/Activity_SummerPub_CookBookUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.foodList_ = LuaList.New(handler(arg_4_0, arg_4_0.FoodIndexItem), arg_4_0.foodListGo_, SummerCookMenuFoodItem)
	arg_4_0.lockController_ = arg_4_0.transCon_:GetController("lock")
	arg_4_0.tipsController_ = arg_4_0.transCon_:GetController("tips")
	arg_4_0.btnController_ = arg_4_0.btnCon_:GetController("btnstatus")
	arg_4_0.toggleList_ = {}

	for iter_4_0 = 1, arg_4_0.toggleContent_.childCount do
		arg_4_0.toggleList_[iter_4_0] = arg_4_0.toggleContent_:GetChild(iter_4_0 - 1):Find("Toggle"):GetComponent("Toggle")
	end

	arg_4_0.mutiTouchHelper_ = arg_4_0.btn_swipe.gameObject:GetComponent("MutiTouchHelper")
	arg_4_0.stepItems_ = {}
	arg_4_0.criMovie1_ = arg_4_0.movieGo1_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criplayer1_ = arg_4_0.criMovie1_.player

	arg_4_0.criplayer1_:SetMaxPictureDataSize(300000)

	arg_4_0.criMovie2_ = arg_4_0.movieGo2_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criplayer2_ = arg_4_0.criMovie2_.player

	arg_4_0.criplayer2_:SetMaxPictureDataSize(300000)
end

function var_0_0.FoodIndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RegisterClick(handler(arg_5_0, arg_5_0.OnFoodClick))
	arg_5_2:SetData(arg_5_0.foodDataList_[arg_5_1])

	local var_5_0 = SummerPubData:GetClearNumByStageID(ItemCfg[arg_5_0.foodDataList_[arg_5_1]].source[1][1], SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0

	arg_5_2:SetLock(var_5_0)

	if not var_5_0 and arg_5_0.foodUnlock_ then
		arg_5_0.foodUnlock_ = false
	end
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btnCg_, nil, function()
		arg_6_0:PlayMovie()
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnPre_, nil, function()
		arg_6_0:OnPageChange(arg_6_0.currentDishIndex_ - 1)
		arg_6_0:SendIllustrationMsg(1, arg_6_0.currentDishIndex_ - 1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnNext_, nil, function()
		arg_6_0:OnPageChange(arg_6_0.currentDishIndex_ + 1)
		arg_6_0:SendIllustrationMsg(1, arg_6_0.currentDishIndex_ + 1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnClose_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnStart_, nil, function()
		JumpTools.OpenPageByJump("/summerCookGameView", {
			dishId = arg_6_0.currentDishId_
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnLock_, nil, function()
		if not arg_6_0.foodUnlock_ then
			ShowTips("COOKING_GAME_MATERIAL_NOT_ENOUGH")
		else
			ShowTips("NYA_SUMMER_STEAK_LOCKED")
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnMask_, nil, function()
		arg_6_0:OnMaskClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.cgMaskBtn_, nil, function()
		arg_6_0.criplayer2_:Stop()
		arg_6_0.criplayer1_:Stop()
		SetActive(arg_6_0.cgMaskBtn_.gameObject, false)

		if arg_6_0.currentDishId_ == 10800 then
			manager.audio:PlayEffect("minigame_activity_4_3", "minigame_activity_4_3_musicstop_cgend", "")
		end
	end)

	function arg_6_0.mutiTouchHelper_.OnSingleDrag(arg_15_0, arg_15_1)
		arg_6_0:TouchHelpSingleDrag(arg_15_0, arg_15_1)
	end

	function arg_6_0.mutiTouchHelper_.OnMutiDrag(arg_16_0)
		arg_6_0:TouchHelpMutiDrag(arg_16_0)
	end

	function arg_6_0.mutiTouchHelper_.EndDrag()
		arg_6_0.hasChangePaged = false
	end
end

function var_0_0.TouchHelpSingleDrag(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = 3

	if arg_18_0.hasChangePaged then
		return
	end

	if arg_18_1 < -1 * var_18_0 then
		if arg_18_0.currentDishIndex_ == arg_18_0.maxDishIndex_ then
			return
		end

		arg_18_0.hasChangePaged = true

		arg_18_0:OnPageChange(arg_18_0.currentDishIndex_ + 1)
		arg_18_0:SendIllustrationMsg(2, arg_18_0.currentDishIndex_ + 1)
	elseif var_18_0 < arg_18_1 then
		if arg_18_0.currentDishIndex_ == 1 then
			return
		end

		arg_18_0.hasChangePaged = true

		arg_18_0:OnPageChange(arg_18_0.currentDishIndex_ - 1)
		arg_18_0:SendIllustrationMsg(2, arg_18_0.currentDishIndex_ - 1)
	end
end

function var_0_0.SendIllustrationMsg(arg_19_0, arg_19_1, arg_19_2)
	SDKTools.SendMessageToSDK("activity_illustration", {
		illustration_type = 2,
		activity_id = ActivityConst.ACTIVITY_NYA_SUMMER_PUB,
		type = arg_19_1,
		other_data = string.format("[%s,%s]", arg_19_0.currentDishIndex_, arg_19_2)
	})
end

function var_0_0.TouchHelpMutiDrag(arg_20_0, arg_20_1)
	if arg_20_0.hasChangePaged then
		return
	end

	local var_20_0 = GameSetting.delta_to_zoom and GameSetting.delta_to_zoom.value[1] or 10

	if var_20_0 < arg_20_1 then
		if arg_20_0.currentDishIndex_ == arg_20_0.maxDishIndex_ then
			return
		end

		arg_20_0:SendIllustrationMsg(2, arg_20_0.currentDishIndex_ + 1)

		arg_20_0.hasChangePaged = true

		arg_20_0:OnPageChange(arg_20_0.currentDishIndex_ + 1)
	elseif arg_20_1 < -1 * var_20_0 then
		if arg_20_0.currentDishIndex_ == 1 then
			return
		end

		arg_20_0:SendIllustrationMsg(2, arg_20_0.currentDishIndex_ - 1)

		arg_20_0.hasChangePaged = true

		arg_20_0:OnPageChange(arg_20_0.currentDishIndex_ - 1)
	end
end

function var_0_0.OnPageChange(arg_21_0, arg_21_1)
	arg_21_0.switchAnim_:Play("CookBookUI_switch", 0, 0)
	arg_21_0:RefreshView(arg_21_1)
end

function var_0_0.OnEnter(arg_22_0)
	arg_22_0.maxDishIndex_ = #SummerPubCookCfg.all

	local var_22_0 = SummerPubData:GetCookMenuIndex()

	if arg_22_0.params_.dishIndex then
		for iter_22_0, iter_22_1 in ipairs(SummerPubCookCfg.all) do
			if iter_22_1 == arg_22_0.params_.dishIndex then
				var_22_0 = iter_22_0

				break
			end
		end
	end

	arg_22_0:RefreshView(var_22_0)
end

function var_0_0.RefreshView(arg_23_0, arg_23_1)
	arg_23_0.currentDishIndex_ = arg_23_1

	SummerPubData:SetCookMenuIndex(arg_23_1)

	arg_23_0.currentDishId_ = SummerPubCookCfg.all[arg_23_0.currentDishIndex_]
	arg_23_0.currentDishCfg_ = SummerPubCookCfg[arg_23_0.currentDishId_]
	arg_23_0.toggleList_[arg_23_0.currentDishIndex_].isOn = true

	if arg_23_1 == 1 then
		SetActive(arg_23_0.btnPre_.gameObject, false)
	elseif arg_23_1 == arg_23_0.maxDishIndex_ then
		SetActive(arg_23_0.btnNext_.gameObject, false)
	else
		SetActive(arg_23_0.btnPre_.gameObject, true)
		SetActive(arg_23_0.btnNext_.gameObject, true)
	end

	arg_23_0.textTitle_.text = arg_23_0.currentDishCfg_.food_name
	arg_23_0.imgDish_.sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_SummerPub/CookingGame/mainGame/" .. arg_23_0.currentDishCfg_.food_finish)
	arg_23_0.heroImg_.sprite = getSpriteViaConfig("HeroItemshead", SummerPubHeroCfg[arg_23_0.currentDishCfg_.hero_id].profile_icon_head)
	arg_23_0.foodDataList_ = arg_23_0.currentDishCfg_.material

	arg_23_0:RefreshController()

	arg_23_0.foodUnlock_ = true

	arg_23_0.foodList_:StartScroll(#arg_23_0.foodDataList_)

	arg_23_0.steps_ = string.split(GetI18NText(arg_23_0.currentDishCfg_.food_steps), "\n")

	for iter_23_0 = 1, #arg_23_0.steps_ do
		local var_23_0 = arg_23_0.stepItems_[iter_23_0]

		if not var_23_0 then
			local var_23_1 = GameObject.Instantiate(arg_23_0.stepItem_)

			var_23_1.transform:SetParent(arg_23_0.stepContent_, false)

			var_23_0 = {
				go = var_23_1
			}
			var_23_0.text_ = var_23_1.transform:Find("steptext"):GetComponent("Text")
			arg_23_0.stepItems_[iter_23_0] = var_23_0
		end

		var_23_0.text_.text = arg_23_0.steps_[iter_23_0]

		SetActive(var_23_0.go, true)
	end

	for iter_23_1 = #arg_23_0.steps_ + 1, #arg_23_0.stepItems_ do
		SetActive(arg_23_0.stepItems_[iter_23_1].go, false)
	end
end

function var_0_0.RefreshController(arg_24_0)
	arg_24_0.isPassLevel = SummerPubData:GetCookClearNumByStageID(arg_24_0.currentDishId_) > 0
	arg_24_0.isUnlock = SummerPubData:GetClearNumByStageID(arg_24_0.currentDishCfg_.unlocked_by_level[1], SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0

	arg_24_0.lockController_:SetSelectedState(tostring(arg_24_0.isPassLevel))

	arg_24_0.textDesc_.text = arg_24_0.isPassLevel and arg_24_0.currentDishCfg_.food_desc or GetTips("COOKING_DEFAULT_DESC")

	if arg_24_0.isUnlock then
		if not arg_24_0.isPassLevel then
			arg_24_0.btnController_:SetSelectedState("bubble")
			arg_24_0.bubbleAnim_:Play("btn_cook", 0, 0)
		else
			arg_24_0.btnController_:SetSelectedState("normal01")
		end
	else
		arg_24_0.btnController_:SetSelectedState("lock01")
	end
end

function var_0_0.PlayMovie(arg_25_0)
	if not arg_25_0.criplayer1_ or not arg_25_0.criplayer2_ then
		Debug.LogError("品菜CG CriWare player not initialized")

		return
	end

	arg_25_0.criMovie1_:Stop()
	arg_25_0.criMovie2_:Stop()

	arg_25_0.moviePath = {}

	local var_25_0 = arg_25_0.currentDishCfg_.open_cg_id
	local var_25_1 = arg_25_0.currentDishCfg_.taste_cg_id
	local var_25_2 = arg_25_0.currentDishCfg_.taste_cg_id_loop

	if var_25_0 and var_25_0 ~= "" then
		SetFile(arg_25_0.criplayer1_, nil, "SofdecAsset/activity/" .. var_25_0 .. ".usm", CriMana.Player.SetMode.New)
		SetFile(arg_25_0.criplayer1_, nil, "SofdecAsset/activity/" .. var_25_1 .. ".usm", CriMana.Player.SetMode.Append)
	else
		SetFile(arg_25_0.criplayer1_, nil, "SofdecAsset/activity/" .. var_25_1 .. ".usm", CriMana.Player.SetMode.New)
	end

	if var_25_2 and var_25_2 ~= "" then
		SetFile(arg_25_0.criplayer2_, nil, "SofdecAsset/activity/" .. var_25_2 .. ".usm", CriMana.Player.SetMode.New)
		arg_25_0.criplayer2_:Prepare()
	end

	arg_25_0.criplayer1_:Prepare()

	function arg_25_0.criplayer1_.statusChangeCallback(arg_26_0)
		if tostring(arg_26_0) == "PlayEnd" then
			if var_25_2 and var_25_2 ~= "" then
				arg_25_0.criMovie2_:Play()
				arg_25_0.criplayer2_:SetVolume(manager.audio:GetEffectVolume())
			end

			SetActive(arg_25_0.cgMaskBtn_.gameObject, true)
		end
	end

	arg_25_0.movieGo1_.transform.localPosition = Vector3(0, 0, 0)

	arg_25_0.criplayer1_:SetVolume(manager.audio:GetEffectVolume())
	arg_25_0.criMovie1_:Play()
	SDKTools.SendMessageToSDK("activity_illustration", {
		illustration_type = 1,
		type = 2,
		activity_id = ActivityConst.ACTIVITY_NYA_SUMMER_PUB,
		food_id = arg_25_0.currentDishId_,
		button_name = arg_25_0.currentDishCfg_.taste_cg_id
	})

	if arg_25_0.currentDishId_ == 10800 then
		manager.audio:PlayEffect("minigame_activity_4_3", "minigame_activity_4_3_musicstop_cgstart", "")
	end
end

function var_0_0.DisPoseMovie(arg_27_0)
	if arg_27_0.criMovie1_ or arg_27_0.criMovie2_ then
		if arg_27_0.criMovie1_ then
			arg_27_0.criMovie1_:Stop()
		end

		if arg_27_0.criMovie2_ then
			arg_27_0.criMovie2_:Stop()
		end

		if arg_27_0.criPlayer1_ then
			arg_27_0.criPlayer1_.statusChangeCallback = nil

			arg_27_0.criPlayer1_:Dispose()

			arg_27_0.criPlayer1_ = nil
		end

		if arg_27_0.criPlayer2_ then
			arg_27_0.criPlayer2_.statusChangeCallback = nil

			arg_27_0.criPlayer2_:Dispose()

			arg_27_0.criPlayer2_ = nil
		end
	end
end

function var_0_0.OnFoodClick(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_0.selectedItemId_ = arg_28_1

	local var_28_0 = ItemCfg[arg_28_1]

	arg_28_0.tipsController_:SetSelectedState(tostring(arg_28_2))

	local var_28_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_28_2 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_28_1, arg_28_3.position)
	local var_28_3, var_28_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_28_0.tipsTransfrom_.parent, var_28_2, var_28_1, nil)

	arg_28_0.tipsTransfrom_.localPosition = Vector3.New(var_28_4.x + 560, var_28_4.y, 0)

	if arg_28_2 then
		arg_28_0.foodName_.text = var_28_0.name
		arg_28_0.foodDesc_.text = var_28_0.desc
	end
end

function var_0_0.OnMaskClick(arg_29_0)
	local var_29_0 = arg_29_0.foodList_:GetItemList()

	for iter_29_0, iter_29_1 in pairs(var_29_0) do
		iter_29_1:RefreshSelect(false)
	end

	arg_29_0.tipsController_:SetSelectedState(tostring(false))

	arg_29_0.selectedItemId_ = nil
end

function var_0_0.OnExit(arg_30_0)
	arg_30_0:OnMaskClick()
end

function var_0_0.Dispose(arg_31_0)
	arg_31_0.foodList_:Dispose()
	arg_31_0:DisPoseMovie()

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.stepItems_) do
		Object.Destroy(iter_31_1.go)
	end

	arg_31_0.stepItems_ = {}

	var_0_0.super.Dispose(arg_31_0)
end

return var_0_0

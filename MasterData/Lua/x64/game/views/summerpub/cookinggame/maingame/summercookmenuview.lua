local SummerCookMenuView = class("SummerCookMenuView", ReduxView)

function SummerCookMenuView:UIName()
	return "Widget/System/Activity_SummerPub/CookingGame/cookBookUI/Activity_SummerPub_CookBookUI"
end

function SummerCookMenuView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerCookMenuView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SummerCookMenuView:InitUI()
	self:BindCfgUI()

	self.foodList_ = LuaList.New(handler(self, self.FoodIndexItem), self.foodListGo_, SummerCookMenuFoodItem)
	self.lockController_ = self.transCon_:GetController("lock")
	self.tipsController_ = self.transCon_:GetController("tips")
	self.btnController_ = self.btnCon_:GetController("btnstatus")
	self.toggleList_ = {}

	for iter_4_0 = 1, self.toggleContent_.childCount do
		self.toggleList_[iter_4_0] = self.toggleContent_:GetChild(iter_4_0 - 1):Find("Toggle"):GetComponent("Toggle")
	end

	self.mutiTouchHelper_ = self.btn_swipe.gameObject:GetComponent("MutiTouchHelper")
	self.stepItems_ = {}
	self.criMovie1_ = self.movieGo1_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer1_ = self.criMovie1_.player

	self.criplayer1_:SetMaxPictureDataSize(300000)

	self.criMovie2_ = self.movieGo2_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer2_ = self.criMovie2_.player

	self.criplayer2_:SetMaxPictureDataSize(300000)
end

function SummerCookMenuView:FoodIndexItem(arg_5_1, arg_5_2)
	arg_5_2:RegisterClick(handler(self, self.OnFoodClick))
	arg_5_2:SetData(self.foodDataList_[arg_5_1])

	local var_5_0 = SummerPubData:GetClearNumByStageID(ItemCfg[self.foodDataList_[arg_5_1]].source[1][1], SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0

	arg_5_2:SetLock(var_5_0)

	if not var_5_0 and self.foodUnlock_ then
		self.foodUnlock_ = false
	end
end

function SummerCookMenuView:AddUIListeners()
	self:AddBtnListener(self.btnCg_, nil, function()
		self:PlayMovie()
	end)
	self:AddBtnListener(self.btnPre_, nil, function()
		self:OnPageChange(self.currentDishIndex_ - 1)
		self:SendIllustrationMsg(1, self.currentDishIndex_ - 1)
	end)
	self:AddBtnListener(self.btnNext_, nil, function()
		self:OnPageChange(self.currentDishIndex_ + 1)
		self:SendIllustrationMsg(1, self.currentDishIndex_ + 1)
	end)
	self:AddBtnListener(self.btnClose_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btnStart_, nil, function()
		JumpTools.OpenPageByJump("/summerCookGameView", {
			dishId = self.currentDishId_
		})
	end)
	self:AddBtnListener(self.btnLock_, nil, function()
		if not self.foodUnlock_ then
			ShowTips("COOKING_GAME_MATERIAL_NOT_ENOUGH")
		else
			ShowTips("NYA_SUMMER_STEAK_LOCKED")
		end
	end)
	self:AddBtnListener(self.btnMask_, nil, function()
		self:OnMaskClick()
	end)
	self:AddBtnListener(self.cgMaskBtn_, nil, function()
		self.criplayer2_:Stop()
		self.criplayer1_:Stop()
		SetActive(self.cgMaskBtn_.gameObject, false)

		if self.currentDishId_ == 10800 then
			manager.audio:PlayEffect("minigame_activity_4_3", "minigame_activity_4_3_musicstop_cgend", "")
		end
	end)

	function self.mutiTouchHelper_.OnSingleDrag(arg_15_0, arg_15_1)
		self:TouchHelpSingleDrag(arg_15_0, arg_15_1)
	end

	function self.mutiTouchHelper_.OnMutiDrag(arg_16_0)
		self:TouchHelpMutiDrag(arg_16_0)
	end

	function self.mutiTouchHelper_.EndDrag()
		self.hasChangePaged = false
	end
end

function SummerCookMenuView:TouchHelpSingleDrag(arg_18_1, arg_18_2)
	if self.hasChangePaged then
		return
	end

	if arg_18_1 < -1 * 3 then
		if self.currentDishIndex_ == self.maxDishIndex_ then
			return
		end

		self.hasChangePaged = true

		self:OnPageChange(self.currentDishIndex_ + 1)
		self:SendIllustrationMsg(2, self.currentDishIndex_ + 1)
	elseif 3 < arg_18_1 then
		if self.currentDishIndex_ == 1 then
			return
		end

		self.hasChangePaged = true

		self:OnPageChange(self.currentDishIndex_ - 1)
		self:SendIllustrationMsg(2, self.currentDishIndex_ - 1)
	end
end

function SummerCookMenuView:SendIllustrationMsg(arg_19_1, arg_19_2)
	SDKTools.SendMessageToSDK("activity_illustration", {
		illustration_type = 2,
		activity_id = ActivityConst.ACTIVITY_NYA_SUMMER_PUB,
		type = arg_19_1,
		other_data = string.format("[%s,%s]", self.currentDishIndex_, arg_19_2)
	})
end

function SummerCookMenuView:TouchHelpMutiDrag(arg_20_1)
	if self.hasChangePaged then
		return
	end

	if GameSetting.delta_to_zoom then
		local var_20_0 = GameSetting.delta_to_zoom.value[1] or 10

		if var_20_0 < arg_20_1 then
			if self.currentDishIndex_ == self.maxDishIndex_ then
				return
			end

			self:SendIllustrationMsg(2, self.currentDishIndex_ + 1)

			self.hasChangePaged = true

			self:OnPageChange(self.currentDishIndex_ + 1)
		elseif arg_20_1 < -1 * var_20_0 then
			if self.currentDishIndex_ == 1 then
				return
			end

			self:SendIllustrationMsg(2, self.currentDishIndex_ - 1)

			self.hasChangePaged = true

			self:OnPageChange(self.currentDishIndex_ - 1)
		end
	end
end

function SummerCookMenuView:OnPageChange(arg_21_1)
	self.switchAnim_:Play("CookBookUI_switch", 0, 0)
	self:RefreshView(arg_21_1)
end

function SummerCookMenuView:OnEnter()
	self.maxDishIndex_ = #SummerPubCookCfg.all

	local var_22_0 = SummerPubData:GetCookMenuIndex()

	if self.params_.dishIndex then
		for iter_22_0, iter_22_1 in ipairs(SummerPubCookCfg.all) do
			if iter_22_1 == self.params_.dishIndex then
				var_22_0 = iter_22_0

				break
			end
		end
	end

	self:RefreshView(var_22_0)
end

function SummerCookMenuView:RefreshView(arg_23_1)
	self.currentDishIndex_ = arg_23_1

	SummerPubData:SetCookMenuIndex(arg_23_1)

	self.currentDishId_ = SummerPubCookCfg.all[self.currentDishIndex_]
	self.currentDishCfg_ = SummerPubCookCfg[self.currentDishId_]
	self.toggleList_[self.currentDishIndex_].isOn = true

	if arg_23_1 == 1 then
		SetActive(self.btnPre_.gameObject, false)
	elseif arg_23_1 == self.maxDishIndex_ then
		SetActive(self.btnNext_.gameObject, false)
	else
		SetActive(self.btnPre_.gameObject, true)
		SetActive(self.btnNext_.gameObject, true)
	end

	self.textTitle_.text = self.currentDishCfg_.food_name
	self.imgDish_.sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_SummerPub/CookingGame/mainGame/" .. self.currentDishCfg_.food_finish)
	self.heroImg_.sprite = getSpriteViaConfig("HeroItemshead", SummerPubHeroCfg[self.currentDishCfg_.hero_id].profile_icon_head)
	self.foodDataList_ = self.currentDishCfg_.material

	self:RefreshController()

	self.foodUnlock_ = true

	self.foodList_:StartScroll(#self.foodDataList_)

	self.steps_ = string.split(GetI18NText(self.currentDishCfg_.food_steps), "\n")

	for iter_23_0 = 1, #self.steps_ do
		local var_23_0 = self.stepItems_[iter_23_0]

		if not self.stepItems_[iter_23_0] then
			local var_23_1 = GameObject.Instantiate(self.stepItem_)

			var_23_1.transform:SetParent(self.stepContent_, false)

			var_23_0 = {
				go = var_23_1
			}
			var_23_0.text_ = var_23_1.transform:Find("steptext"):GetComponent("Text")
			self.stepItems_[iter_23_0] = var_23_0
		end

		var_23_0.text_.text = self.steps_[iter_23_0]

		SetActive(var_23_0.go, true)
	end

	for iter_23_1 = #self.steps_ + 1, #self.stepItems_ do
		SetActive(self.stepItems_[iter_23_1].go, false)
	end
end

function SummerCookMenuView:RefreshController()
	self.isPassLevel = SummerPubData:GetCookClearNumByStageID(self.currentDishId_) > 0
	self.isUnlock = SummerPubData:GetClearNumByStageID(self.currentDishCfg_.unlocked_by_level[1], SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0

	self.lockController_:SetSelectedState(tostring(self.isPassLevel))

	if self.isPassLevel then
		self.textDesc_.text = self.currentDishCfg_.food_desc or GetTips("COOKING_DEFAULT_DESC")
	end

	if self.isUnlock then
		if not self.isPassLevel then
			self.btnController_:SetSelectedState("bubble")
			self.bubbleAnim_:Play("btn_cook", 0, 0)
		else
			self.btnController_:SetSelectedState("normal01")
		end
	else
		self.btnController_:SetSelectedState("lock01")
	end
end

function SummerCookMenuView:PlayMovie()
	if not self.criplayer1_ or not self.criplayer2_ then
		Debug.LogError("品菜CG CriWare player not initialized")

		return
	end

	self.criMovie1_:Stop()
	self.criMovie2_:Stop()

	self.moviePath = {}

	local var_25_0 = self.currentDishCfg_.taste_cg_id_loop

	if self.currentDishCfg_.open_cg_id and self.currentDishCfg_.open_cg_id ~= "" then
		SetFile(self.criplayer1_, nil, "SofdecAsset/activity/" .. self.currentDishCfg_.open_cg_id .. ".usm", CriMana.Player.SetMode.New)
		SetFile(self.criplayer1_, nil, "SofdecAsset/activity/" .. self.currentDishCfg_.taste_cg_id .. ".usm", CriMana.Player.SetMode.Append)
	else
		SetFile(self.criplayer1_, nil, "SofdecAsset/activity/" .. self.currentDishCfg_.taste_cg_id .. ".usm", CriMana.Player.SetMode.New)
	end

	if var_25_0 and var_25_0 ~= "" then
		SetFile(self.criplayer2_, nil, "SofdecAsset/activity/" .. var_25_0 .. ".usm", CriMana.Player.SetMode.New)
		self.criplayer2_:Prepare()
	end

	self.criplayer1_:Prepare()

	function self.criplayer1_.statusChangeCallback(arg_26_0)
		if tostring(arg_26_0) == "PlayEnd" then
			if var_25_0 and var_25_0 ~= "" then
				self.criMovie2_:Play()
				self.criplayer2_:SetVolume(manager.audio:GetEffectVolume())
			end

			SetActive(self.cgMaskBtn_.gameObject, true)
		end
	end

	self.movieGo1_.transform.localPosition = Vector3(0, 0, 0)

	self.criplayer1_:SetVolume(manager.audio:GetEffectVolume())
	self.criMovie1_:Play()
	SDKTools.SendMessageToSDK("activity_illustration", {
		illustration_type = 1,
		type = 2,
		activity_id = ActivityConst.ACTIVITY_NYA_SUMMER_PUB,
		food_id = self.currentDishId_,
		button_name = self.currentDishCfg_.taste_cg_id
	})

	if self.currentDishId_ == 10800 then
		manager.audio:PlayEffect("minigame_activity_4_3", "minigame_activity_4_3_musicstop_cgstart", "")
	end
end

function SummerCookMenuView:DisPoseMovie()
	if self.criMovie1_ or self.criMovie2_ then
		if self.criMovie1_ then
			self.criMovie1_:Stop()
		end

		if self.criMovie2_ then
			self.criMovie2_:Stop()
		end

		if self.criPlayer1_ then
			self.criPlayer1_.statusChangeCallback = nil

			self.criPlayer1_:Dispose()

			self.criPlayer1_ = nil
		end

		if self.criPlayer2_ then
			self.criPlayer2_.statusChangeCallback = nil

			self.criPlayer2_:Dispose()

			self.criPlayer2_ = nil
		end
	end
end

function SummerCookMenuView:OnFoodClick(arg_28_1, arg_28_2, arg_28_3)
	self.selectedItemId_ = arg_28_1

	self.tipsController_:SetSelectedState(tostring(arg_28_2))

	local var_28_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_28_1, var_28_2 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.tipsTransfrom_.parent, UnityEngine.RectTransformUtility.WorldToScreenPoint(var_28_0, arg_28_3.position), var_28_0, nil)

	self.tipsTransfrom_.localPosition = Vector3.New(var_28_2.x + 560, var_28_2.y, 0)

	if arg_28_2 then
		self.foodName_.text = ItemCfg[arg_28_1].name
		self.foodDesc_.text = ItemCfg[arg_28_1].desc
	end
end

function SummerCookMenuView:OnMaskClick()
	for iter_29_0, iter_29_1 in pairs((self.foodList_:GetItemList())) do
		iter_29_1:RefreshSelect(false)
	end

	self.tipsController_:SetSelectedState(tostring(false))

	self.selectedItemId_ = nil
end

function SummerCookMenuView:OnExit()
	self:OnMaskClick()
end

function SummerCookMenuView:Dispose()
	self.foodList_:Dispose()
	self:DisPoseMovie()

	for iter_31_0, iter_31_1 in ipairs(self.stepItems_) do
		Object.Destroy(iter_31_1.go)
	end

	self.stepItems_ = {}

	SummerCookMenuView.super.Dispose(self)
end

return SummerCookMenuView

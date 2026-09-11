local DormIlluFurnitureDetailView = class("DormIlluFurnitureDetailView", ReduxView)
local var_0_1 = {
	DEFAULT = 1,
	NEAR = 2
}

function DormIlluFurnitureDetailView:UIName()
	return "Widget/BackHouseUI/IdolDance/IdolDanceIllustrateFurnitureDetailsUI"
end

function DormIlluFurnitureDetailView:UIParent()
	return manager.ui.uiMain.transform
end

function DormIlluFurnitureDetailView:Init()
	self.listen = {
		[ON_DORM_CHARACTER_INTERACT_FINISH] = handler(self, self.OnInteractFin)
	}

	self:InitUI()
	self:RegisterEvents()
end

function DormIlluFurnitureDetailView:RegisterEvents()
	for iter_4_0, iter_4_1 in pairs(self.listen) do
		manager.notify:RegistListener(iter_4_0, iter_4_1)
	end
end

function DormIlluFurnitureDetailView:RemoveEvents()
	for iter_5_0, iter_5_1 in pairs(self.listen) do
		manager.notify:RemoveListener(iter_5_0, iter_5_1)
	end
end

function DormIlluFurnitureDetailView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function DormIlluFurnitureDetailView:OnBehind()
	manager.windowBar:HideBar()
end

function DormIlluFurnitureDetailView:OnEnter()
	if self.infoPage_ then
		self.infoPage_:OnEnter(self.params_.furID)
	end

	local var_8_0 = 0
	local var_8_1 = self:GetData()

	if self.params_.isBack and var_8_1 then
		var_8_0 = var_8_1.furID or 0
		self.furIDList_ = var_8_1.furIDList
	else
		var_8_0 = self.params_.furID
		self.furIDList_ = self.params_.list
	end

	self:ChangeFurID(var_8_0)

	self.scaleLevel_ = var_0_1.DEFAULT

	manager.ui:SetMainCameraCom("CinemachineBrain", false)
	manager.ui:SetMainCamera("hero")
end

function DormIlluFurnitureDetailView:RefreshCameraState()
	if BackHomeFurniture[self.furID_] and BackHomeFurniture[self.furID_].ignore_zoom and BackHomeFurniture[self.furID_].ignore_zoom == 1 then
		self.scaleLevel_ = var_0_1.DEFAULT

		manager.ui:SetMainCamera("hero")
		self.zoomController_:SetSelectedState("off")
	else
		local var_9_0 = CameraCfg.hero

		if self.scaleLevel_ == var_0_1.NEAR then
			manager.ui:SetMainCameraPos((Vector3.Lerp(Vector3(var_9_0.position[1], var_9_0.position[2], var_9_0.position[3]), Dorm.DormEntityManager.GetTransform(self.furEntityID_).position, 0.25)))
			self.zoomController_:SetSelectedState("stat01")
		else
			manager.ui:SetMainCamera("hero")
			self.zoomController_:SetSelectedState("stat02")
		end
	end
end

function DormIlluFurnitureDetailView:StopInteraction()
	if self.heroEntityID_ and self.heroEntityID_ ~= 0 then
		Dorm.DormEntityManager.StopAllCmd(self.heroEntityID_)
		self:RemoveHeroModel(self.heroEntityID_)

		self.heroEntityID_ = 0
	end

	self:StopTimer()
	self:SetPlayState(false)
end

function DormIlluFurnitureDetailView:OnExit()
	manager.audio:Stop("effect")
	self:StopInteraction()

	if self.infoPage_ then
		self.infoPage_:OnExit()
	end

	self:RemoveModel()
	self:SaveData()

	self.furID_ = 0
	self.furIDList_ = {}
	self.scaleLevel_ = var_0_1.DEFAULT

	manager.ui:ResetMainCamera()
end

function DormIlluFurnitureDetailView:SaveData()
	self.saveTable_ = {
		furID = self.furID_,
		furIDList = self.furIDList_
	}
end

function DormIlluFurnitureDetailView:CleanData()
	self.saveTable_ = nil
end

function DormIlluFurnitureDetailView:GetData()
	return self.saveTable_ or nil
end

function DormIlluFurnitureDetailView:Dispose()
	self:RemoveEvents()
	self:StopInteraction()
	self:CleanData()

	if self.infoPage_ then
		self.infoPage_:Dispose()

		self.infoPage_ = nil
	end

	self:RemoveModel()
	DormIlluFurnitureDetailView.super.Dispose(self)
end

function DormIlluFurnitureDetailView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.playController_ = self.playControllerEx_:GetController("play")
	self.zoomController_ = self.mainControllerEx_:GetController("BlowUpBtn")
	self.infoPage_ = DormIlluFurnitureDetailInfoView.New(self.furnitureInfoSubView_)
	self.next_action = nil
	self.furIDList_ = {}
	self.furID_ = 0
end

function DormIlluFurnitureDetailView:AddUIListener()
	self:AddBtnListener(self.leftBtn_, nil, function()
		manager.audio:Stop("effect")

		local var_18_0 = 0

		for iter_18_0, iter_18_1 in ipairs(self.furIDList_) do
			if iter_18_1 == self.furID_ then
				var_18_0 = iter_18_0 == 1 and self.furIDList_[#self.furIDList_] or self.furIDList_[iter_18_0 - 1]
			end
		end

		self:ChangeFurID(var_18_0)
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		manager.audio:Stop("effect")

		local var_19_0 = 0

		for iter_19_0, iter_19_1 in ipairs(self.furIDList_) do
			if iter_19_1 == self.furID_ then
				var_19_0 = iter_19_0 == #self.furIDList_ and self.furIDList_[1] or self.furIDList_[iter_19_0 + 1]
			end
		end

		self:ChangeFurID(var_19_0)
	end)
	self:AddBtnListener(self.sourceBtn_, nil, function()
		JumpTools.GoToSystem("/dormShop", {
			hideHomeBtn = true,
			shop = ShopCfg[ShopCfg.get_id_list_by_give_id[self.furID_][1]].shop_id,
			shopList = DormTools:GetAllDormShopIDList()
		}, ViewConst.SYSTEM_ID.DORM_SHOP)
	end)
	self:AddBtnListener(self.playBtn_, nil, function()
		manager.audio:Stop("effect")

		if not self.heroEntityID_ or not Dorm.DormEntityManager.TestDuringInteract(self.heroEntityID_, true) then
			self:PlayInteraction()
		else
			self:StopInteraction()
		end
	end)
	self:AddBtnListener(self.zoomBtn_, nil, function()
		self.scaleLevel_ = self.scaleLevel_ == var_0_1.NEAR and var_0_1.DEFAULT or var_0_1.NEAR

		self:RefreshCameraState()
	end)
	self:AddDragListener(self.backGo_, function()
		if BackHomeFurniture[self.furID_].can_rot == 1 then
			return
		end

		local var_23_0 = Dorm.DormEntityManager.GetTransform(self.furEntityID_)

		self.startRot_ = var_23_0 and var_23_0.localEulerAngles or Vector3.zero
		self.lastRotateY_ = nil
		self.lastDeltaX_ = 0
	end, function(arg_24_0, arg_24_1)
		if BackHomeFurniture[self.furID_].can_rot == 1 then
			return
		end

		local var_24_0 = Dorm.DormEntityManager.GetTransform(self.furEntityID_)

		if var_24_0 then
			local var_24_1 = self.lastRotateY_ or var_24_0.localEulerAngles.y
			local var_24_2 = var_24_1 + (arg_24_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_24_1

			if var_24_1 + (arg_24_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_24_1 < -HeroConst.MAX_RORATE_ANGLE then
				var_24_2 = -HeroConst.MAX_RORATE_ANGLE
			elseif var_24_1 + (arg_24_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_24_1 > HeroConst.MAX_RORATE_ANGLE then
				var_24_2 = HeroConst.MAX_RORATE_ANGLE
			end

			self.lastRotateY_ = var_24_1 + var_24_2
			self.lastDeltaX_ = arg_24_0
			var_24_0.localRotation = Quaternion.RotateTowards(var_24_0.localRotation, Quaternion.Euler(self.startRot_.x, var_24_1 + var_24_2, self.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function DormIlluFurnitureDetailView:ChangeFurID(arg_25_1)
	if self.furID_ == arg_25_1 then
		return
	end

	self.furID_ = arg_25_1

	self:UpdateView()
end

function DormIlluFurnitureDetailView:UpdateView()
	if BackHomeFurniture[self.furID_].interact_max and BackHomeFurniture[self.furID_].interact_max > 0 and self.furID_ ~= 961103 then
		SetActive(self.playBtn_.gameObject, true)
	else
		SetActive(self.playBtn_.gameObject, false)
	end

	self:RemoveModel()
	self:CreateModel()
	self.infoPage_:UpdateView(self.furID_)

	if self.sourceBtn_ then
		local var_26_0 = false

		if ShopCfg.get_id_list_by_give_id[self.furID_] then
			for iter_26_0, iter_26_1 in ipairs((DormTools:GetAllDormShopIDList())) do
				if iter_26_1 == ShopCfg[ShopCfg.get_id_list_by_give_id[self.furID_][1]].shop_id then
					var_26_0 = true
				end
			end
		end

		SetActive(self.sourceBtn_.gameObject, var_26_0)
	end

	self:RefreshCameraState()
	self:StopInteraction()
end

function DormIlluFurnitureDetailView:CreateModel()
	if BackHomeFurniture[self.furID_] then
		if BackHomeFurniture[self.furID_].type == DormConst.FLOOR_TYPE_NUM or BackHomeFurniture[self.furID_].type == DormConst.WALL_TYPE_NUM or BackHomeFurniture[self.furID_].type == DormConst.BACK_GROUND_TYPE then
			self.furEntityID_ = self:CreateObjModel(self.furID_)

			if BackHomeFurniture[self.furID_].type == DormConst.WALL_TYPE_NUM then
				Dorm.DormEntityManager.PutEntityAtWithRot(self.furEntityID_, Vector3.New(DormIlluConst.FurniturePosition.wallPos[1], DormIlluConst.FurniturePosition.wallPos[2], DormIlluConst.FurniturePosition.wallPos[3]), Quaternion.Euler(0, 16, 0))
				Dorm.DormEntityManager.IlluSetWallMaterial(self.furEntityID_, BackHomeFurniture[self.furID_].material)
			elseif BackHomeFurniture[self.furID_].type == DormConst.BACK_GROUND_TYPE then
				Dorm.DormEntityManager.PutEntityAtWithScale(self.furEntityID_, Vector3.New(DormIlluConst.FurniturePosition.backgroundPos[1], DormIlluConst.FurniturePosition.backgroundPos[2], DormIlluConst.FurniturePosition.backgroundPos[3]), Vector3.New(0.2, 0.2, 0.2))
			elseif BackHomeFurniture[self.furID_].type == DormConst.FLOOR_TYPE_NUM then
				Dorm.DormEntityManager.PutEntityAt(self.furEntityID_, Vector3.New(DormIlluConst.FurniturePosition.floorPos[1], DormIlluConst.FurniturePosition.floorPos[2], DormIlluConst.FurniturePosition.floorPos[3]))
			end
		else
			self.furEntityID_ = self:CreateFurModel(self.furID_)

			DormLuaBridge.ChangeFurnitureState(self.furEntityID_, DormFurnitureManager.FurnitureState.Placed)

			if BackHomeFurniture[self.furID_].illu_position and BackHomeFurniture[self.furID_].illu_position ~= "" and BackHomeFurniture[self.furID_].illu_position ~= {} then
				Dorm.DormEntityManager.PutEntityAt(self.furEntityID_, Vector3.New(BackHomeFurniture[self.furID_].illu_position[1], BackHomeFurniture[self.furID_].illu_position[2], BackHomeFurniture[self.furID_].illu_position[3]))
			else
				Dorm.DormEntityManager.PutEntityAt(self.furEntityID_, Vector3.New(DormIlluConst.FurniturePosition.defaultPos[1], DormIlluConst.FurniturePosition.defaultPos[2], DormIlluConst.FurniturePosition.defaultPos[3]))
			end
		end
	end
end

function DormIlluFurnitureDetailView:PlayInteraction()
	if not self.heroEntityID_ or not Dorm.DormEntityManager.TestDuringInteract(self.heroEntityID_, true) then
		self:StopInteraction()

		local var_28_0 = 1084
		local var_28_1 = 2001

		if BackHomeFurniture[self.furID_].interact == "" or BackHomeFurniture[self.furID_].interact == nil or BackHomeFurniture[self.furID_].interact == {} or #BackHomeFurniture[self.furID_].interact == 0 then
			if Dorm.DormEntityManager.GetFurnitureInteractID(self.furEntityID_) ~= -1 then
				var_28_1 = Dorm.DormEntityManager.GetFurnitureInteractID(self.furEntityID_)
			end
		else
			local var_28_2 = BackHomeFurniture[self.furID_].interact[math.random(#BackHomeFurniture[self.furID_].interact)]

			if var_28_2 then
				var_28_0 = var_28_2[1]
				var_28_1 = var_28_2[2]
			end
		end

		self.heroEntityID_ = self:CreateHeroModel(var_28_0)

		Dorm.DormEntityManager.GetTransform(self.heroEntityID_):SetParent((Dorm.DormEntityManager.GetTransform(self.furEntityID_)))

		if var_28_1 == 200 then
			return
		end

		Dorm.DormEntityManager.PutEntityAt(self.heroEntityID_, Dorm.DormEntityManager.GetEntityInteractPoint(self.furEntityID_, var_28_1))
		Dorm.DormEntityManager.SendInteractToEntityCMD(self.heroEntityID_, self.furEntityID_, var_28_1, false)

		local var_28_3 = DormCharacterInteractBehaviour.GetSequence(self.heroEntityID_, self.furEntityID_, DormInteractSequence[var_28_1].name)
		local var_28_4 = type(var_28_3) == "function" and var_28_3(nil, true) or var_28_3

		self.curDuration = var_28_4.duration
		self.timer_ = FrameTimer.New(function()
			self.curDuration = self.curDuration - Time.deltaTime
			self.progress_.fillAmount = 1 - self.curDuration / var_28_4.duration
		end, 1, -1)

		self.timer_:Start()

		local var_28_6, var_28_7, var_28_8 = DormCharacterInteractBehaviour.GetNextAction(var_28_1)

		self.next_action = var_28_6 and var_28_7 or nil

		self:SetPlayState(true)
	end
end

function DormIlluFurnitureDetailView:StopTimer()
	self.curDuration = 0
	self.next_action = nil

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function DormIlluFurnitureDetailView:OnInteractFin(arg_31_1, arg_31_2)
	if self.next_action and self.heroEntityID_ and self.furEntityID_ and self.heroEntityID_ ~= 0 and self.heroEntityID_ ~= 0 then
		local var_31_0 = self.next_action

		Dorm.DormEntityManager.TryExecuteInteractToEntityImmediate(self.heroEntityID_, self.furEntityID_, self.next_action)

		local var_31_1, var_31_2, var_31_3 = DormCharacterInteractBehaviour.GetNextAction(var_31_0)

		self.next_action = var_31_1 and var_31_2 or nil

		local var_31_4 = DormCharacterInteractBehaviour.GetSequence(self.heroEntityID_, self.furEntityID_, DormInteractSequence[var_31_0].name)

		self:StopTimer()

		if var_31_4 then
			self.curDuration = var_31_4.duration
			self.timer_ = FrameTimer.New(function()
				self.curDuration = self.curDuration - Time.deltaTime
				self.progress_.fillAmount = 1 - self.curDuration / var_31_4.duration
			end, 1, -1)

			self.timer_:Start()

			local var_31_5, var_31_6, var_31_7 = DormCharacterInteractBehaviour.GetNextAction(var_31_0)

			self.next_action = var_31_5 and var_31_6 or nil
		end

		return
	end

	self:StopInteraction()
end

function DormIlluFurnitureDetailView:SetPlayState(arg_33_1)
	self.playController_:SetSelectedState(arg_33_1 and "on" or "off")
end

function DormIlluFurnitureDetailView:CreateHeroModel(arg_34_1)
	return DormIllu.GetHero(arg_34_1)
end

function DormIlluFurnitureDetailView:CreateFurModel(arg_35_1)
	return DormIllu.GetFurniture(self.furID_)
end

function DormIlluFurnitureDetailView:CreateObjModel(arg_36_1)
	return DormIllu.GetModel(self.furID_)
end

function DormIlluFurnitureDetailView:RemoveHeroModel(arg_37_1)
	DormIllu.RemoveHero(arg_37_1)
end

function DormIlluFurnitureDetailView:RemoveModel()
	self:StopInteraction()

	if self.furEntityID_ and self.furEntityID_ ~= 0 then
		DormIllu.RemoveModel(self.furEntityID_)
		DormIllu.RemoveFurniture(self.furEntityID_)

		self.furEntityID_ = 0
	end
end

return DormIlluFurnitureDetailView

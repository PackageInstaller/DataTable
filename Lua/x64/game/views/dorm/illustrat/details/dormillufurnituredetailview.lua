local var_0_0 = class("DormIlluFurnitureDetailView", ReduxView)
local var_0_1 = {
	DEFAULT = 1,
	NEAR = 2
}

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolDance/IdolDanceIllustrateFurnitureDetailsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.listen = {
		[ON_DORM_CHARACTER_INTERACT_FINISH] = handler(arg_3_0, arg_3_0.OnInteractFin)
	}

	arg_3_0:InitUI()
	arg_3_0:RegisterEvents()
end

function var_0_0.RegisterEvents(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.listen) do
		manager.notify:RegistListener(iter_4_0, iter_4_1)
	end
end

function var_0_0.RemoveEvents(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.listen) do
		manager.notify:RemoveListener(iter_5_0, iter_5_1)
	end
end

function var_0_0.OnTop(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.OnBehind(arg_7_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_8_0)
	if arg_8_0.infoPage_ then
		arg_8_0.infoPage_:OnEnter(arg_8_0.params_.furID)
	end

	local var_8_0 = 0
	local var_8_1 = arg_8_0:GetData()

	if arg_8_0.params_.isBack and var_8_1 then
		var_8_0 = var_8_1.furID or 0
		arg_8_0.furIDList_ = var_8_1.furIDList
	else
		var_8_0 = arg_8_0.params_.furID
		arg_8_0.furIDList_ = arg_8_0.params_.list
	end

	arg_8_0:ChangeFurID(var_8_0)

	arg_8_0.scaleLevel_ = var_0_1.DEFAULT

	manager.ui:SetMainCameraCom("CinemachineBrain", false)
	manager.ui:SetMainCamera("hero")
end

function var_0_0.RefreshCameraState(arg_9_0)
	local var_9_0 = BackHomeFurniture[arg_9_0.furID_]

	if var_9_0 and var_9_0.ignore_zoom and var_9_0.ignore_zoom == 1 then
		arg_9_0.scaleLevel_ = var_0_1.DEFAULT

		manager.ui:SetMainCamera("hero")
		arg_9_0.zoomController_:SetSelectedState("off")
	else
		local var_9_1 = CameraCfg.hero

		if arg_9_0.scaleLevel_ == var_0_1.NEAR then
			local var_9_2 = Dorm.DormEntityManager.GetTransform(arg_9_0.furEntityID_).position
			local var_9_3 = Vector3(var_9_1.position[1], var_9_1.position[2], var_9_1.position[3])
			local var_9_4 = Vector3.Lerp(var_9_3, var_9_2, 0.25)

			manager.ui:SetMainCameraPos(var_9_4)
			arg_9_0.zoomController_:SetSelectedState("stat01")
		else
			manager.ui:SetMainCamera("hero")
			arg_9_0.zoomController_:SetSelectedState("stat02")
		end
	end
end

function var_0_0.StopInteraction(arg_10_0)
	if arg_10_0.heroEntityID_ and arg_10_0.heroEntityID_ ~= 0 then
		Dorm.DormEntityManager.StopAllCmd(arg_10_0.heroEntityID_)
		arg_10_0:RemoveHeroModel(arg_10_0.heroEntityID_)

		arg_10_0.heroEntityID_ = 0
	end

	arg_10_0:StopTimer()
	arg_10_0:SetPlayState(false)
end

function var_0_0.OnExit(arg_11_0)
	manager.audio:Stop("effect")
	arg_11_0:StopInteraction()

	if arg_11_0.infoPage_ then
		arg_11_0.infoPage_:OnExit()
	end

	arg_11_0:RemoveModel()
	arg_11_0:SaveData()

	arg_11_0.furID_ = 0
	arg_11_0.furIDList_ = {}
	arg_11_0.scaleLevel_ = var_0_1.DEFAULT

	manager.ui:ResetMainCamera()
end

function var_0_0.SaveData(arg_12_0)
	arg_12_0.saveTable_ = {
		furID = arg_12_0.furID_,
		furIDList = arg_12_0.furIDList_
	}
end

function var_0_0.CleanData(arg_13_0)
	arg_13_0.saveTable_ = nil
end

function var_0_0.GetData(arg_14_0)
	return arg_14_0.saveTable_ or nil
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:RemoveEvents()
	arg_15_0:StopInteraction()
	arg_15_0:CleanData()

	if arg_15_0.infoPage_ then
		arg_15_0.infoPage_:Dispose()

		arg_15_0.infoPage_ = nil
	end

	arg_15_0:RemoveModel()
	var_0_0.super.Dispose(arg_15_0)
end

function var_0_0.InitUI(arg_16_0)
	arg_16_0:BindCfgUI()
	arg_16_0:AddUIListener()

	arg_16_0.playController_ = arg_16_0.playControllerEx_:GetController("play")
	arg_16_0.zoomController_ = arg_16_0.mainControllerEx_:GetController("BlowUpBtn")
	arg_16_0.infoPage_ = DormIlluFurnitureDetailInfoView.New(arg_16_0.furnitureInfoSubView_)
	arg_16_0.next_action = nil
	arg_16_0.furIDList_ = {}
	arg_16_0.furID_ = 0
end

function var_0_0.AddUIListener(arg_17_0)
	arg_17_0:AddBtnListener(arg_17_0.leftBtn_, nil, function()
		manager.audio:Stop("effect")

		local var_18_0 = 0

		for iter_18_0, iter_18_1 in ipairs(arg_17_0.furIDList_) do
			if iter_18_1 == arg_17_0.furID_ then
				if iter_18_0 == 1 then
					var_18_0 = arg_17_0.furIDList_[#arg_17_0.furIDList_]
				else
					var_18_0 = arg_17_0.furIDList_[iter_18_0 - 1]
				end
			end
		end

		arg_17_0:ChangeFurID(var_18_0)
	end)
	arg_17_0:AddBtnListener(arg_17_0.rightBtn_, nil, function()
		manager.audio:Stop("effect")

		local var_19_0 = 0

		for iter_19_0, iter_19_1 in ipairs(arg_17_0.furIDList_) do
			if iter_19_1 == arg_17_0.furID_ then
				if iter_19_0 == #arg_17_0.furIDList_ then
					var_19_0 = arg_17_0.furIDList_[1]
				else
					var_19_0 = arg_17_0.furIDList_[iter_19_0 + 1]
				end
			end
		end

		arg_17_0:ChangeFurID(var_19_0)
	end)
	arg_17_0:AddBtnListener(arg_17_0.sourceBtn_, nil, function()
		local var_20_0 = DormTools:GetAllDormShopIDList()
		local var_20_1 = ShopCfg.get_id_list_by_give_id[arg_17_0.furID_][1]
		local var_20_2 = ShopCfg[var_20_1].shop_id

		JumpTools.GoToSystem("/dormShop", {
			hideHomeBtn = true,
			shop = var_20_2,
			shopList = var_20_0
		}, ViewConst.SYSTEM_ID.DORM_SHOP)
	end)
	arg_17_0:AddBtnListener(arg_17_0.playBtn_, nil, function()
		manager.audio:Stop("effect")

		if not arg_17_0.heroEntityID_ or not Dorm.DormEntityManager.TestDuringInteract(arg_17_0.heroEntityID_, true) then
			arg_17_0:PlayInteraction()
		else
			arg_17_0:StopInteraction()
		end
	end)
	arg_17_0:AddBtnListener(arg_17_0.zoomBtn_, nil, function()
		if arg_17_0.scaleLevel_ == var_0_1.NEAR then
			arg_17_0.scaleLevel_ = var_0_1.DEFAULT
		else
			arg_17_0.scaleLevel_ = var_0_1.NEAR
		end

		arg_17_0:RefreshCameraState()
	end)
	arg_17_0:AddDragListener(arg_17_0.backGo_, function()
		if BackHomeFurniture[arg_17_0.furID_].can_rot == 1 then
			return
		end

		local var_23_0 = Dorm.DormEntityManager.GetTransform(arg_17_0.furEntityID_)

		if var_23_0 then
			arg_17_0.startRot_ = var_23_0.localEulerAngles
		else
			arg_17_0.startRot_ = Vector3.zero
		end

		arg_17_0.lastRotateY_ = nil
		arg_17_0.lastDeltaX_ = 0
	end, function(arg_24_0, arg_24_1)
		if BackHomeFurniture[arg_17_0.furID_].can_rot == 1 then
			return
		end

		local var_24_0 = Dorm.DormEntityManager.GetTransform(arg_17_0.furEntityID_)

		if var_24_0 then
			local var_24_1 = arg_17_0.lastRotateY_ or var_24_0.localEulerAngles.y
			local var_24_2 = var_24_1 + (arg_24_0 - (arg_17_0.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_24_1
			local var_24_3 = var_24_2

			if var_24_2 < -HeroConst.MAX_RORATE_ANGLE then
				var_24_3 = -HeroConst.MAX_RORATE_ANGLE
			elseif var_24_2 > HeroConst.MAX_RORATE_ANGLE then
				var_24_3 = HeroConst.MAX_RORATE_ANGLE
			end

			arg_17_0.lastRotateY_ = var_24_1 + var_24_3
			arg_17_0.lastDeltaX_ = arg_24_0
			var_24_0.localRotation = Quaternion.RotateTowards(var_24_0.localRotation, Quaternion.Euler(arg_17_0.startRot_.x, var_24_1 + var_24_3, arg_17_0.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function var_0_0.ChangeFurID(arg_25_0, arg_25_1)
	if arg_25_0.furID_ == arg_25_1 then
		return
	end

	arg_25_0.furID_ = arg_25_1

	arg_25_0:UpdateView()
end

function var_0_0.UpdateView(arg_26_0)
	if BackHomeFurniture[arg_26_0.furID_].interact_max and BackHomeFurniture[arg_26_0.furID_].interact_max > 0 and arg_26_0.furID_ ~= 961103 then
		SetActive(arg_26_0.playBtn_.gameObject, true)
	else
		SetActive(arg_26_0.playBtn_.gameObject, false)
	end

	arg_26_0:RemoveModel()
	arg_26_0:CreateModel()
	arg_26_0.infoPage_:UpdateView(arg_26_0.furID_)

	if arg_26_0.sourceBtn_ then
		local var_26_0 = false
		local var_26_1 = DormTools:GetAllDormShopIDList()
		local var_26_2 = ShopCfg.get_id_list_by_give_id[arg_26_0.furID_]

		if var_26_2 then
			local var_26_3 = var_26_2[1]
			local var_26_4 = ShopCfg[var_26_3].shop_id

			for iter_26_0, iter_26_1 in ipairs(var_26_1) do
				if iter_26_1 == var_26_4 then
					var_26_0 = true
				end
			end
		end

		SetActive(arg_26_0.sourceBtn_.gameObject, var_26_0)
	end

	arg_26_0:RefreshCameraState()
	arg_26_0:StopInteraction()
end

function var_0_0.CreateModel(arg_27_0)
	local var_27_0 = DormIlluConst.FurniturePosition
	local var_27_1 = BackHomeFurniture[arg_27_0.furID_]

	if var_27_1 then
		local var_27_2 = var_27_1.type

		if var_27_2 == DormConst.FLOOR_TYPE_NUM or var_27_2 == DormConst.WALL_TYPE_NUM or var_27_2 == DormConst.BACK_GROUND_TYPE then
			arg_27_0.furEntityID_ = arg_27_0:CreateObjModel(arg_27_0.furID_)

			if var_27_2 == DormConst.WALL_TYPE_NUM then
				Dorm.DormEntityManager.PutEntityAtWithRot(arg_27_0.furEntityID_, Vector3.New(var_27_0.wallPos[1], var_27_0.wallPos[2], var_27_0.wallPos[3]), Quaternion.Euler(0, 16, 0))
				Dorm.DormEntityManager.IlluSetWallMaterial(arg_27_0.furEntityID_, BackHomeFurniture[arg_27_0.furID_].material)
			elseif var_27_2 == DormConst.BACK_GROUND_TYPE then
				Dorm.DormEntityManager.PutEntityAtWithScale(arg_27_0.furEntityID_, Vector3.New(var_27_0.backgroundPos[1], var_27_0.backgroundPos[2], var_27_0.backgroundPos[3]), Vector3.New(0.2, 0.2, 0.2))
			elseif var_27_2 == DormConst.FLOOR_TYPE_NUM then
				Dorm.DormEntityManager.PutEntityAt(arg_27_0.furEntityID_, Vector3.New(var_27_0.floorPos[1], var_27_0.floorPos[2], var_27_0.floorPos[3]))
			end
		else
			arg_27_0.furEntityID_ = arg_27_0:CreateFurModel(arg_27_0.furID_)

			DormLuaBridge.ChangeFurnitureState(arg_27_0.furEntityID_, DormFurnitureManager.FurnitureState.Placed)

			if var_27_1.illu_position and var_27_1.illu_position ~= "" and var_27_1.illu_position ~= {} then
				Dorm.DormEntityManager.PutEntityAt(arg_27_0.furEntityID_, Vector3.New(var_27_1.illu_position[1], var_27_1.illu_position[2], var_27_1.illu_position[3]))
			else
				Dorm.DormEntityManager.PutEntityAt(arg_27_0.furEntityID_, Vector3.New(var_27_0.defaultPos[1], var_27_0.defaultPos[2], var_27_0.defaultPos[3]))
			end
		end
	end
end

function var_0_0.PlayInteraction(arg_28_0)
	if not arg_28_0.heroEntityID_ or not Dorm.DormEntityManager.TestDuringInteract(arg_28_0.heroEntityID_, true) then
		arg_28_0:StopInteraction()

		local var_28_0 = 1084
		local var_28_1 = 2001
		local var_28_2 = BackHomeFurniture[arg_28_0.furID_].interact

		if var_28_2 == "" or var_28_2 == nil or var_28_2 == {} or #var_28_2 == 0 then
			if Dorm.DormEntityManager.GetFurnitureInteractID(arg_28_0.furEntityID_) ~= -1 then
				var_28_1 = Dorm.DormEntityManager.GetFurnitureInteractID(arg_28_0.furEntityID_)
			end
		else
			local var_28_3 = var_28_2[math.random(#var_28_2)]

			if var_28_3 then
				var_28_0 = var_28_3[1]
				var_28_1 = var_28_3[2]
			end
		end

		arg_28_0.heroEntityID_ = arg_28_0:CreateHeroModel(var_28_0)

		local var_28_4 = Dorm.DormEntityManager.GetTransform(arg_28_0.heroEntityID_)
		local var_28_5 = Dorm.DormEntityManager.GetTransform(arg_28_0.furEntityID_)

		var_28_4:SetParent(var_28_5)

		if var_28_1 == 200 then
			return
		end

		Dorm.DormEntityManager.PutEntityAt(arg_28_0.heroEntityID_, Dorm.DormEntityManager.GetEntityInteractPoint(arg_28_0.furEntityID_, var_28_1))
		Dorm.DormEntityManager.SendInteractToEntityCMD(arg_28_0.heroEntityID_, arg_28_0.furEntityID_, var_28_1, false)

		local var_28_6 = DormInteractSequence[var_28_1].name
		local var_28_7 = DormCharacterInteractBehaviour.GetSequence(arg_28_0.heroEntityID_, arg_28_0.furEntityID_, var_28_6)
		local var_28_8

		if type(var_28_7) == "function" then
			var_28_8 = var_28_7(nil, true)
		else
			var_28_8 = var_28_7
		end

		local var_28_9 = var_28_8.duration

		arg_28_0.curDuration = var_28_8.duration
		arg_28_0.timer_ = FrameTimer.New(function()
			arg_28_0.curDuration = arg_28_0.curDuration - Time.deltaTime
			arg_28_0.progress_.fillAmount = 1 - arg_28_0.curDuration / var_28_8.duration
		end, 1, -1)

		arg_28_0.timer_:Start()

		local var_28_10, var_28_11, var_28_12 = DormCharacterInteractBehaviour.GetNextAction(var_28_1)

		if var_28_10 then
			arg_28_0.next_action = var_28_11
		else
			arg_28_0.next_action = nil
		end

		arg_28_0:SetPlayState(true)
	end
end

function var_0_0.StopTimer(arg_30_0)
	arg_30_0.curDuration = 0
	arg_30_0.next_action = nil

	if arg_30_0.timer_ then
		arg_30_0.timer_:Stop()

		arg_30_0.timer_ = nil
	end
end

function var_0_0.OnInteractFin(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_0.next_action and arg_31_0.heroEntityID_ and arg_31_0.furEntityID_ and arg_31_0.heroEntityID_ ~= 0 and arg_31_0.heroEntityID_ ~= 0 then
		local var_31_0 = arg_31_0.next_action

		Dorm.DormEntityManager.TryExecuteInteractToEntityImmediate(arg_31_0.heroEntityID_, arg_31_0.furEntityID_, var_31_0)

		local var_31_1, var_31_2, var_31_3 = DormCharacterInteractBehaviour.GetNextAction(var_31_0)

		if var_31_1 then
			arg_31_0.next_action = var_31_2
		else
			arg_31_0.next_action = nil
		end

		local var_31_4 = DormInteractSequence[var_31_0].name
		local var_31_5 = DormCharacterInteractBehaviour.GetSequence(arg_31_0.heroEntityID_, arg_31_0.furEntityID_, var_31_4)

		arg_31_0:StopTimer()

		if var_31_5 then
			arg_31_0.curDuration = var_31_5.duration
			arg_31_0.timer_ = FrameTimer.New(function()
				arg_31_0.curDuration = arg_31_0.curDuration - Time.deltaTime
				arg_31_0.progress_.fillAmount = 1 - arg_31_0.curDuration / var_31_5.duration
			end, 1, -1)

			arg_31_0.timer_:Start()

			local var_31_6, var_31_7, var_31_8 = DormCharacterInteractBehaviour.GetNextAction(var_31_0)

			if var_31_6 then
				arg_31_0.next_action = var_31_7
			else
				arg_31_0.next_action = nil
			end
		end

		return
	end

	arg_31_0:StopInteraction()
end

function var_0_0.SetPlayState(arg_33_0, arg_33_1)
	arg_33_0.playController_:SetSelectedState(arg_33_1 and "on" or "off")
end

function var_0_0.CreateHeroModel(arg_34_0, arg_34_1)
	return DormIllu.GetHero(arg_34_1)
end

function var_0_0.CreateFurModel(arg_35_0, arg_35_1)
	return DormIllu.GetFurniture(arg_35_0.furID_)
end

function var_0_0.CreateObjModel(arg_36_0, arg_36_1)
	return DormIllu.GetModel(arg_36_0.furID_)
end

function var_0_0.RemoveHeroModel(arg_37_0, arg_37_1)
	DormIllu.RemoveHero(arg_37_1)
end

function var_0_0.RemoveModel(arg_38_0)
	arg_38_0:StopInteraction()

	if arg_38_0.furEntityID_ and arg_38_0.furEntityID_ ~= 0 then
		DormIllu.RemoveModel(arg_38_0.furEntityID_)
		DormIllu.RemoveFurniture(arg_38_0.furEntityID_)

		arg_38_0.furEntityID_ = 0
	end
end

return var_0_0

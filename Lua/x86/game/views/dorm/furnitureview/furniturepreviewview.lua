DormIlluFurnitureDetailView = import("game.views.dorm.Illustrat.details.DormIlluFurnitureDetailView")

local var_0_0 = class("FurniturePreviewView", DormIlluFurnitureDetailView)
local var_0_1 = {
	DEFAULT = 1,
	NEAR = 2
}

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/FurnitureDetailsUI"
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

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()

	arg_4_0.playController_ = arg_4_0.playControllerEx_:GetController("play")
	arg_4_0.zoomController_ = arg_4_0.mainControllerEx_:GetController("BlowUpBtn")
	arg_4_0.infoPage_ = DormIlluFurnitureDetailInfoView.New(arg_4_0.furnitureInfoSubView_)
	arg_4_0.next_action = nil
	arg_4_0.furID_ = 0
end

function var_0_0.OnTop(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.OnHide(arg_6_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_7_0)
	if system == DormEnum.DormSystemType.Dormitory then
		DormHeroTools.HideAllCharacter()
	end

	local var_7_0 = SceneManager.GetSceneByName("X100_DormPreview")
	local var_7_1 = var_7_0:GetRootGameObjects()
	local var_7_2

	if var_7_1 ~= nil then
		for iter_7_0 = 0, var_7_1.Length - 1 do
			if var_7_1[iter_7_0].name == var_7_0.name then
				var_7_2 = var_7_1[iter_7_0]

				break
			end
		end
	end

	arg_7_0.cameraNormal_ = var_7_2.transform:Find("previewCamera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))
	arg_7_0.cameraNear_ = var_7_2.transform:Find("previewCamera_near"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))

	arg_7_0:LoadManager()

	if arg_7_0.infoPage_ then
		arg_7_0.infoPage_:OnEnter(arg_7_0.params_.furID)
	end

	arg_7_0:ChangeFurID(arg_7_0.params_.furID)

	arg_7_0.scaleLevel_ = var_0_1.DEFAULT

	manager.ui:SetMainCamera("furnituPreview")
end

function var_0_0.RefreshCameraState(arg_8_0)
	local var_8_0 = BackHomeFurniture[arg_8_0.furID_]

	if var_8_0 and var_8_0.ignore_zoom and var_8_0.ignore_zoom == 1 then
		arg_8_0.scaleLevel_ = var_0_1.DEFAULT
		arg_8_0.cameraNear_.enabled = false
		arg_8_0.cameraNormal_.enabled = true

		arg_8_0.zoomController_:SetSelectedState("off")
	elseif arg_8_0.scaleLevel_ == var_0_1.NEAR then
		local var_8_1 = Dorm.DormEntityManager.GetTransform(arg_8_0.furEntityID_).position
		local var_8_2 = arg_8_0.cameraNormal_.transform.localPosition
		local var_8_3 = Vector3.Lerp(var_8_2, var_8_1, 0.25)

		arg_8_0.cameraNear_.transform.localPosition = var_8_3
		arg_8_0.cameraNear_.enabled = true
		arg_8_0.cameraNormal_.enabled = false

		arg_8_0.zoomController_:SetSelectedState("stat01")
	else
		arg_8_0.cameraNear_.enabled = false
		arg_8_0.cameraNormal_.enabled = true

		arg_8_0.zoomController_:SetSelectedState("stat02")
	end
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.playBtn_, nil, function()
		manager.audio:Stop("effect")

		if not arg_9_0.heroEntityID_ or not Dorm.DormEntityManager.TestDuringInteract(arg_9_0.heroEntityID_, true) then
			arg_9_0:PlayInteraction()
		else
			arg_9_0:StopInteraction()
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.zoomBtn_, nil, function()
		if arg_9_0.scaleLevel_ == var_0_1.NEAR then
			arg_9_0.scaleLevel_ = var_0_1.DEFAULT
		else
			arg_9_0.scaleLevel_ = var_0_1.NEAR
		end

		arg_9_0:RefreshCameraState()
	end)
	arg_9_0:AddDragListener(arg_9_0.backGo_, function()
		if BackHomeFurniture[arg_9_0.furID_].can_rot == 1 then
			return
		end

		local var_12_0 = Dorm.DormEntityManager.GetTransform(arg_9_0.furEntityID_)

		if var_12_0 then
			arg_9_0.startRot_ = var_12_0.localEulerAngles
		else
			arg_9_0.startRot_ = Vector3.zero
		end

		arg_9_0.lastRotateY_ = nil
		arg_9_0.lastDeltaX_ = 0
	end, function(arg_13_0, arg_13_1)
		if BackHomeFurniture[arg_9_0.furID_].can_rot == 1 then
			return
		end

		local var_13_0 = Dorm.DormEntityManager.GetTransform(arg_9_0.furEntityID_)

		if var_13_0 then
			local var_13_1 = arg_9_0.lastRotateY_ or var_13_0.localEulerAngles.y
			local var_13_2 = var_13_1 + (arg_13_0 - (arg_9_0.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_13_1
			local var_13_3 = var_13_2

			if var_13_2 < -HeroConst.MAX_RORATE_ANGLE then
				var_13_3 = -HeroConst.MAX_RORATE_ANGLE
			elseif var_13_2 > HeroConst.MAX_RORATE_ANGLE then
				var_13_3 = HeroConst.MAX_RORATE_ANGLE
			end

			arg_9_0.lastRotateY_ = var_13_1 + var_13_3
			arg_9_0.lastDeltaX_ = arg_13_0
			var_13_0.localRotation = Quaternion.RotateTowards(var_13_0.localRotation, Quaternion.Euler(arg_9_0.startRot_.x, var_13_1 + var_13_3, arg_9_0.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0.cameraNear_.enabled = false
	arg_14_0.cameraNormal_.enabled = false

	manager.audio:Stop("effect")
	manager.ui:ResetMainCamera()
	arg_14_0:StopInteraction()
	arg_14_0:UnloadManager()

	if arg_14_0.infoPage_ then
		arg_14_0.infoPage_:OnExit()
	end

	arg_14_0:RemoveModel()

	arg_14_0.furID_ = 0
	arg_14_0.scaleLevel_ = var_0_1.DEFAULT

	local var_14_0 = BackHomeDataManager:GetCurSystem()
end

local function var_0_2(arg_15_0)
	local var_15_0 = BackHomeHeroSkinCfg[arg_15_0].model

	return "CharDorm/" .. var_15_0
end

local function var_0_3(arg_16_0)
	return var_0_2(arg_16_0.heroID)
end

local function var_0_4(arg_17_0)
	local var_17_0 = BackHomeFurniture[arg_17_0]

	if var_17_0 then
		if var_17_0.model and var_17_0.model ~= "" then
			return var_17_0.model
		elseif var_17_0.type == 27 then
			return var_17_0.extend
		elseif var_17_0.type == 21 then
			return "Dorm/Dormitory/HZ05_normal1_qiangmian"
		end
	end

	return ""
end

local function var_0_5(arg_18_0)
	return var_0_4(arg_18_0.furID)
end

local function var_0_6(arg_19_0)
	if arg_19_0.spawnAt == nil then
		return nil
	end

	local var_19_0 = "idol.camp.pos." .. arg_19_0.spawnAt

	return nullable(Dorm.storage:PickData(var_19_0), "transform")
end

function var_0_0.LoadManager(arg_20_0)
	local var_20_0 = EntityManager.CreateIlluFurniture.New()

	arg_20_0.furnitureEntityManager_ = EntityManager.New(var_20_0)

	local var_20_1 = EntityManager.CreateModel.New(var_0_5)

	arg_20_0.modelEntityManager_ = EntityManager.New(var_20_1)

	local var_20_2 = EntityManager.CreateModel.New(var_0_3, var_0_6)

	arg_20_0.heroEntityManager_ = EntityManager.New(var_20_2)
end

function var_0_0.UnloadManager(arg_21_0)
	arg_21_0.heroEntityManager_:Clear()
	arg_21_0.furnitureEntityManager_:Clear()
	arg_21_0.modelEntityManager_:Clear()

	arg_21_0.heroEntityManager_ = nil
	arg_21_0.furnitureEntityManager_ = nil
	arg_21_0.modelEntityManager_ = nil
end

function var_0_0.CreateHeroModel(arg_22_0, arg_22_1)
	if arg_22_0.heroEntityManager_ then
		local var_22_0 = arg_22_1

		if SkinCfg[arg_22_1] then
			var_22_0 = SkinCfg[arg_22_1].hero or arg_22_1
		else
			var_22_0 = arg_22_1
		end

		local var_22_1 = DormData:GetHeroArchiveID(var_22_0)

		return arg_22_0.heroEntityManager_:Update(var_22_1, {
			complex = true,
			heroID = var_22_0,
			cfgID = var_22_0,
			archiveID = var_22_1,
			spawnAt = spawnAt
		})
	end
end

function var_0_0.CreateFurModel(arg_23_0, arg_23_1)
	if arg_23_0.furnitureEntityManager_ then
		return arg_23_0.furnitureEntityManager_:Update(arg_23_1, {
			state = 0,
			cfgID = arg_23_1
		})
	end
end

function var_0_0.CreateObjModel(arg_24_0, arg_24_1)
	if arg_24_0.modelEntityManager_ then
		return arg_24_0.modelEntityManager_:Update(arg_24_1, {
			furID = arg_24_1
		})
	end
end

function var_0_0.RemoveHeroModel(arg_25_0, arg_25_1)
	if arg_25_0.heroEntityManager_ then
		local var_25_0 = arg_25_0.heroEntityManager_:Find(arg_25_1)

		if var_25_0 then
			arg_25_0.heroEntityManager_:Remove(var_25_0)
		end
	end
end

function var_0_0.RemoveModel(arg_26_0)
	arg_26_0:StopInteraction()

	if arg_26_0.furEntityID_ and arg_26_0.furEntityID_ ~= 0 then
		if arg_26_0.modelEntityManager_ then
			local var_26_0 = arg_26_0.modelEntityManager_:Find(arg_26_0.furEntityID_)

			if var_26_0 then
				arg_26_0.modelEntityManager_:Remove(var_26_0)
			end
		end

		if arg_26_0.furnitureEntityManager_ then
			local var_26_1 = arg_26_0.furnitureEntityManager_:Find(arg_26_0.furEntityID_)

			if var_26_1 then
				arg_26_0.furnitureEntityManager_:Remove(var_26_1)
			end
		end

		arg_26_0.furEntityID_ = 0
	end
end

return var_0_0

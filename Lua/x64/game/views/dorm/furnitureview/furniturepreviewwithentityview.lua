FurniturePreviewView = import("game.views.dorm.FurnitureView.FurniturePreviewView")

local var_0_0 = class("FurniturePreviewWithEntityView", FurniturePreviewView)
local var_0_1 = {
	DEFAULT = 1,
	NEAR = 2
}

function var_0_0.OnEnter(arg_1_0)
	local var_1_0 = SceneManager.GetSceneByName("X100_DormPreviewWithEntity")
	local var_1_1 = var_1_0:GetRootGameObjects()
	local var_1_2

	if var_1_1 ~= nil then
		for iter_1_0 = 0, var_1_1.Length - 1 do
			if var_1_1[iter_1_0].name == var_1_0.name then
				var_1_2 = var_1_1[iter_1_0]

				break
			end
		end
	end

	local var_1_3 = var_1_2.transform:Find("previewCamera")
	local var_1_4 = var_1_2.transform:Find("previewCamera_near")

	if var_1_3 then
		var_1_3.gameObject:SetActive(false)
	end

	if var_1_4 then
		var_1_4.gameObject:SetActive(false)
	end

	arg_1_0:LoadManager()

	if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Dormitory then
		DormHeroTools.HideAllCharacter()
	end

	if arg_1_0.infoPage_ then
		arg_1_0.infoPage_:OnEnter(arg_1_0.params_.furID)
	end

	arg_1_0:ChangeFurID(arg_1_0.params_.furID)

	arg_1_0.scaleLevel_ = var_0_1.DEFAULT

	manager.ui:SetMainCamera("furnituPreviewEntity")
end

function var_0_0.RefreshCameraState(arg_2_0)
	local var_2_0 = BackHomeFurniture[arg_2_0.furID_]

	if var_2_0 and var_2_0.ignore_zoom and var_2_0.ignore_zoom == 1 then
		arg_2_0.scaleLevel_ = var_0_1.DEFAULT

		local var_2_1 = CameraCfg.furnituPreviewEntity
		local var_2_2 = Vector3(var_2_1.position[1], var_2_1.position[2], var_2_1.position[3])

		manager.ui:SetMainCameraPos(var_2_2)
		arg_2_0.zoomController_:SetSelectedState("off")
	else
		local var_2_3 = CameraCfg.furnituPreviewEntity

		if arg_2_0.scaleLevel_ == var_0_1.NEAR then
			local var_2_4 = Dorm.DormEntityManager.GetTransform(arg_2_0.furEntityID_).position
			local var_2_5 = Vector3(var_2_3.position[1], var_2_3.position[2], var_2_3.position[3])
			local var_2_6 = Vector3.Lerp(var_2_5, var_2_4, 0.25)

			manager.ui:SetMainCameraPos(var_2_6)
			arg_2_0.zoomController_:SetSelectedState("stat01")
		else
			local var_2_7 = Vector3(var_2_3.position[1], var_2_3.position[2], var_2_3.position[3])

			manager.ui:SetMainCameraPos(var_2_7)
			arg_2_0.zoomController_:SetSelectedState("stat02")
		end
	end
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:StopInteraction()
	arg_3_0:UnloadManager()

	if arg_3_0.infoPage_ then
		arg_3_0.infoPage_:OnExit()
	end

	arg_3_0:RemoveModel()

	arg_3_0.furID_ = 0
	arg_3_0.scaleLevel_ = var_0_1.DEFAULT

	manager.ui:ResetMainCamera()
end

local function var_0_2(arg_4_0)
	local var_4_0 = BackHomeFurniture[arg_4_0]

	if var_4_0 then
		if var_4_0.model and var_4_0.model ~= "" then
			return var_4_0.model
		elseif var_4_0.type == 27 then
			return var_4_0.extend
		elseif var_4_0.type == 21 then
			return "Dorm/Dormitory/HZ05_normal1_qiangmian"
		end
	end

	return ""
end

local function var_0_3(arg_5_0)
	return var_0_2(arg_5_0.furID)
end

local function var_0_4(arg_6_0)
	local var_6_0 = BackHomeHeroSkinCfg[arg_6_0].model

	return "CharDorm/" .. var_6_0
end

local function var_0_5(arg_7_0)
	return var_0_4(arg_7_0.heroID)
end

local function var_0_6(arg_8_0)
	if arg_8_0.spawnAt == nil then
		return nil
	end

	local var_8_0 = "idol.camp.pos." .. arg_8_0.spawnAt

	return nullable(Dorm.storage:PickData(var_8_0), "transform")
end

function var_0_0.LoadManager(arg_9_0)
	DormCharacterActionManager:Init()
	DormCharacterInteractBehaviour:Init()

	Dorm.storage = DormStorage.GetInstance()

	Dorm.storage:Reset()

	local var_9_0 = EntityManager.CreateIlluFurniture.New()

	arg_9_0.furnitureEntityManager_ = EntityManager.New(var_9_0)

	local var_9_1 = EntityManager.CreateModel.New(var_0_3)

	arg_9_0.modelEntityManager_ = EntityManager.New(var_9_1)

	local var_9_2 = EntityManager.CreateModel.New(var_0_5, var_0_6)

	arg_9_0.heroEntityManager_ = EntityManager.New(var_9_2)

	Dorm.Enter()
end

function var_0_0.UnloadManager(arg_10_0)
	DormCharacterInteractBehaviour:Reset()
	DormCharacterActionManager:Reset()
	Dorm.storage:Reset()
	arg_10_0.heroEntityManager_:Clear()
	arg_10_0.furnitureEntityManager_:Clear()
	arg_10_0.modelEntityManager_:Clear()

	arg_10_0.heroEntityManager_ = nil
	arg_10_0.furnitureEntityManager_ = nil
	arg_10_0.modelEntityManager_ = nil

	Dorm.Leave()
end

return var_0_0

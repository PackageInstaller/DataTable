FurniturePreviewView = import("game.views.dorm.FurnitureView.FurniturePreviewView")

local FurniturePreviewWithEntityView = class("FurniturePreviewWithEntityView", FurniturePreviewView)
local var_0_1 = {
	DEFAULT = 1,
	NEAR = 2
}

function FurniturePreviewWithEntityView:OnEnter()
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

	self:LoadManager()

	if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Dormitory then
		DormHeroTools.HideAllCharacter()
	end

	if self.infoPage_ then
		self.infoPage_:OnEnter(self.params_.furID)
	end

	self:ChangeFurID(self.params_.furID)

	self.scaleLevel_ = var_0_1.DEFAULT

	manager.ui:SetMainCamera("furnituPreviewEntity")
end

function FurniturePreviewWithEntityView:RefreshCameraState()
	if BackHomeFurniture[self.furID_] and BackHomeFurniture[self.furID_].ignore_zoom and BackHomeFurniture[self.furID_].ignore_zoom == 1 then
		self.scaleLevel_ = var_0_1.DEFAULT

		manager.ui:SetMainCameraPos((Vector3(CameraCfg.furnituPreviewEntity.position[1], CameraCfg.furnituPreviewEntity.position[2], CameraCfg.furnituPreviewEntity.position[3])))
		self.zoomController_:SetSelectedState("off")
	else
		local var_2_0 = CameraCfg.furnituPreviewEntity

		if self.scaleLevel_ == var_0_1.NEAR then
			manager.ui:SetMainCameraPos((Vector3.Lerp(Vector3(var_2_0.position[1], var_2_0.position[2], var_2_0.position[3]), Dorm.DormEntityManager.GetTransform(self.furEntityID_).position, 0.25)))
			self.zoomController_:SetSelectedState("stat01")
		else
			manager.ui:SetMainCameraPos((Vector3(var_2_0.position[1], var_2_0.position[2], var_2_0.position[3])))
			self.zoomController_:SetSelectedState("stat02")
		end
	end
end

function FurniturePreviewWithEntityView:OnExit()
	self:StopInteraction()
	self:UnloadManager()

	if self.infoPage_ then
		self.infoPage_:OnExit()
	end

	self:RemoveModel()

	self.furID_ = 0
	self.scaleLevel_ = var_0_1.DEFAULT

	manager.ui:ResetMainCamera()
end

local function var_0_2(arg_4_0)
	if BackHomeFurniture[arg_4_0] then
		if BackHomeFurniture[arg_4_0].model and BackHomeFurniture[arg_4_0].model ~= "" then
			return BackHomeFurniture[arg_4_0].model
		elseif BackHomeFurniture[arg_4_0].type == 27 then
			return BackHomeFurniture[arg_4_0].extend
		elseif BackHomeFurniture[arg_4_0].type == 21 then
			return "Dorm/Dormitory/HZ05_normal1_qiangmian"
		end
	end

	return ""
end

local function var_0_3(arg_5_0)
	return var_0_2(arg_5_0.furID)
end

local function var_0_4(arg_6_0)
	return "CharDorm/" .. BackHomeHeroSkinCfg[arg_6_0].model
end

local function var_0_5(arg_7_0)
	return var_0_4(arg_7_0.heroID)
end

local function var_0_6(arg_8_0)
	if arg_8_0.spawnAt == nil then
		return nil
	end

	return nullable(Dorm.storage:PickData("idol.camp.pos." .. arg_8_0.spawnAt), "transform")
end

function FurniturePreviewWithEntityView:LoadManager()
	DormCharacterActionManager:Init()
	DormCharacterInteractBehaviour:Init()

	Dorm.storage = DormStorage.GetInstance()

	Dorm.storage:Reset()

	self.furnitureEntityManager_ = EntityManager.New((EntityManager.CreateIlluFurniture.New()))
	self.modelEntityManager_ = EntityManager.New((EntityManager.CreateModel.New(var_0_3)))
	self.heroEntityManager_ = EntityManager.New((EntityManager.CreateModel.New(var_0_5, var_0_6)))

	Dorm.Enter()
end

function FurniturePreviewWithEntityView:UnloadManager()
	DormCharacterInteractBehaviour:Reset()
	DormCharacterActionManager:Reset()
	Dorm.storage:Reset()
	self.heroEntityManager_:Clear()
	self.furnitureEntityManager_:Clear()
	self.modelEntityManager_:Clear()

	self.heroEntityManager_ = nil
	self.furnitureEntityManager_ = nil
	self.modelEntityManager_ = nil

	Dorm.Leave()
end

return FurniturePreviewWithEntityView

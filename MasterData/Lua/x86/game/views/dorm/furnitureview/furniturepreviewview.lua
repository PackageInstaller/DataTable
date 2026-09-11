DormIlluFurnitureDetailView = import("game.views.dorm.Illustrat.details.DormIlluFurnitureDetailView")

local FurniturePreviewView = class("FurniturePreviewView", DormIlluFurnitureDetailView)
local var_0_1 = {
	DEFAULT = 1,
	NEAR = 2
}

function FurniturePreviewView:UIName()
	return "Widget/BackHouseUI/Dorm/FurnitureDetailsUI"
end

function FurniturePreviewView:UIParent()
	return manager.ui.uiMain.transform
end

function FurniturePreviewView:Init()
	self.listen = {
		[ON_DORM_CHARACTER_INTERACT_FINISH] = handler(self, self.OnInteractFin)
	}

	self:InitUI()
	self:RegisterEvents()
end

function FurniturePreviewView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.playController_ = self.playControllerEx_:GetController("play")
	self.zoomController_ = self.mainControllerEx_:GetController("BlowUpBtn")
	self.infoPage_ = DormIlluFurnitureDetailInfoView.New(self.furnitureInfoSubView_)
	self.next_action = nil
	self.furID_ = 0
end

function FurniturePreviewView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function FurniturePreviewView:OnHide()
	manager.windowBar:HideBar()
end

function FurniturePreviewView:OnEnter()
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

	self.cameraNormal_ = var_7_2.transform:Find("previewCamera"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))
	self.cameraNear_ = var_7_2.transform:Find("previewCamera_near"):GetComponent(typeof(Cinemachine.CinemachineVirtualCamera))

	self:LoadManager()

	if self.infoPage_ then
		self.infoPage_:OnEnter(self.params_.furID)
	end

	self:ChangeFurID(self.params_.furID)

	self.scaleLevel_ = var_0_1.DEFAULT

	manager.ui:SetMainCamera("furnituPreview")
end

function FurniturePreviewView:RefreshCameraState()
	if BackHomeFurniture[self.furID_] and BackHomeFurniture[self.furID_].ignore_zoom and BackHomeFurniture[self.furID_].ignore_zoom == 1 then
		self.scaleLevel_ = var_0_1.DEFAULT
		self.cameraNear_.enabled = false
		self.cameraNormal_.enabled = true

		self.zoomController_:SetSelectedState("off")
	elseif self.scaleLevel_ == var_0_1.NEAR then
		self.cameraNear_.transform.localPosition = Vector3.Lerp(self.cameraNormal_.transform.localPosition, Dorm.DormEntityManager.GetTransform(self.furEntityID_).position, 0.25)
		self.cameraNear_.enabled = true
		self.cameraNormal_.enabled = false

		self.zoomController_:SetSelectedState("stat01")
	else
		self.cameraNear_.enabled = false
		self.cameraNormal_.enabled = true

		self.zoomController_:SetSelectedState("stat02")
	end
end

function FurniturePreviewView:AddUIListener()
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

		local var_12_0 = Dorm.DormEntityManager.GetTransform(self.furEntityID_)

		self.startRot_ = var_12_0 and var_12_0.localEulerAngles or Vector3.zero
		self.lastRotateY_ = nil
		self.lastDeltaX_ = 0
	end, function(arg_13_0, arg_13_1)
		if BackHomeFurniture[self.furID_].can_rot == 1 then
			return
		end

		local var_13_0 = Dorm.DormEntityManager.GetTransform(self.furEntityID_)

		if var_13_0 then
			local var_13_1 = self.lastRotateY_ or var_13_0.localEulerAngles.y
			local var_13_2 = var_13_1 + (arg_13_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_13_1

			if var_13_1 + (arg_13_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_13_1 < -HeroConst.MAX_RORATE_ANGLE then
				var_13_2 = -HeroConst.MAX_RORATE_ANGLE
			elseif var_13_1 + (arg_13_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_13_1 > HeroConst.MAX_RORATE_ANGLE then
				var_13_2 = HeroConst.MAX_RORATE_ANGLE
			end

			self.lastRotateY_ = var_13_1 + var_13_2
			self.lastDeltaX_ = arg_13_0
			var_13_0.localRotation = Quaternion.RotateTowards(var_13_0.localRotation, Quaternion.Euler(self.startRot_.x, var_13_1 + var_13_2, self.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function FurniturePreviewView:OnExit()
	self.cameraNear_.enabled = false
	self.cameraNormal_.enabled = false

	manager.audio:Stop("effect")
	manager.ui:ResetMainCamera()
	self:StopInteraction()
	self:UnloadManager()

	if self.infoPage_ then
		self.infoPage_:OnExit()
	end

	self:RemoveModel()

	self.furID_ = 0
	self.scaleLevel_ = var_0_1.DEFAULT

	local var_14_0 = BackHomeDataManager:GetCurSystem()
end

local function var_0_2(arg_15_0)
	return "CharDorm/" .. BackHomeHeroSkinCfg[arg_15_0].model
end

local function var_0_3(arg_16_0)
	return var_0_2(arg_16_0.heroID)
end

local function var_0_4(arg_17_0)
	if BackHomeFurniture[arg_17_0] then
		if BackHomeFurniture[arg_17_0].model and BackHomeFurniture[arg_17_0].model ~= "" then
			return BackHomeFurniture[arg_17_0].model
		elseif BackHomeFurniture[arg_17_0].type == 27 then
			return BackHomeFurniture[arg_17_0].extend
		elseif BackHomeFurniture[arg_17_0].type == 21 then
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

	return nullable(Dorm.storage:PickData("idol.camp.pos." .. arg_19_0.spawnAt), "transform")
end

function FurniturePreviewView:LoadManager()
	self.furnitureEntityManager_ = EntityManager.New((EntityManager.CreateIlluFurniture.New()))
	self.modelEntityManager_ = EntityManager.New((EntityManager.CreateModel.New(var_0_5)))
	self.heroEntityManager_ = EntityManager.New((EntityManager.CreateModel.New(var_0_3, var_0_6)))
end

function FurniturePreviewView:UnloadManager()
	self.heroEntityManager_:Clear()
	self.furnitureEntityManager_:Clear()
	self.modelEntityManager_:Clear()

	self.heroEntityManager_ = nil
	self.furnitureEntityManager_ = nil
	self.modelEntityManager_ = nil
end

function FurniturePreviewView:CreateHeroModel(arg_22_1)
	if self.heroEntityManager_ then
		local var_22_0 = arg_22_1

		var_22_0 = SkinCfg[arg_22_1] and (SkinCfg[arg_22_1].hero or arg_22_1) or arg_22_1

		local var_22_1 = DormData:GetHeroArchiveID(var_22_0)

		return self.heroEntityManager_:Update(var_22_1, {
			complex = true,
			heroID = var_22_0,
			cfgID = var_22_0,
			archiveID = var_22_1,
			spawnAt = spawnAt
		})
	end
end

function FurniturePreviewView:CreateFurModel(arg_23_1)
	if self.furnitureEntityManager_ then
		return self.furnitureEntityManager_:Update(arg_23_1, {
			state = 0,
			cfgID = arg_23_1
		})
	end
end

function FurniturePreviewView:CreateObjModel(arg_24_1)
	if self.modelEntityManager_ then
		return self.modelEntityManager_:Update(arg_24_1, {
			furID = arg_24_1
		})
	end
end

function FurniturePreviewView:RemoveHeroModel(arg_25_1)
	if self.heroEntityManager_ then
		local var_25_0 = self.heroEntityManager_:Find(arg_25_1)

		if var_25_0 then
			self.heroEntityManager_:Remove(var_25_0)
		end
	end
end

function FurniturePreviewView:RemoveModel()
	self:StopInteraction()

	if self.furEntityID_ and self.furEntityID_ ~= 0 then
		if self.modelEntityManager_ then
			local var_26_0 = self.modelEntityManager_:Find(self.furEntityID_)

			if var_26_0 then
				self.modelEntityManager_:Remove(var_26_0)
			end
		end

		if self.furnitureEntityManager_ then
			local var_26_1 = self.furnitureEntityManager_:Find(self.furEntityID_)

			if var_26_1 then
				self.furnitureEntityManager_:Remove(var_26_1)
			end
		end

		self.furEntityID_ = 0
	end
end

return FurniturePreviewView

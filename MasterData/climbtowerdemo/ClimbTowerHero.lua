-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClimbTowerDemo\\ClimbTowerHero.lua

local ClimbTowerObject = require("ClimbTowerDemo/ClimbTowerObject")
local RearHouseModelManager = require("Logic/RearHouse/RearHouseModelManager")
local ModelTool = require("Entity/ModelTool")
local strClassName = "ClimbTowerHero"
local ClimbTowerHero = Class(strClassName, ClimbTowerObject)

function ClimbTowerHero:ctor(entityId, entityName, parent, putData, initData)
	self.modelLoaded = false
end

function ClimbTowerHero:destroy(...)
	ClimbTowerHero.super.destroy(self)

	self.modelLoaded = false
end

function ClimbTowerHero:setAnimatorScale(modelType)
	local commondModelData = utils.getCommonModelData(self.modelId)
	local performData = commondModelData[modelType]

	if performData and performData[1] and performData[1].scale then
		self.scale = performData[1].scale
	end
end

function ClimbTowerHero:getHeroModelData(info, high)
	local modelData = {}
	local modelType = Const.MODEL_TYPE.PerformAct

	if self.isMySelf then
		modelType = Const.MODEL_TYPE.RearHouse
	end

	self:setAnimatorScale(modelType)

	modelData.model_type = modelType
	self.hero = true
	modelData.model_id = self.modelId

	if high then
		modelData.use_lod = Const.MODEL_LOD_LV1
	else
		modelData.use_lod = Const.MODEL_LOD_LV2
	end

	local animator = ModelTool.getControllerPathByType(self.modelId, modelType)

	if animator then
		modelData.animator = animator
	end

	return modelData
end

function ClimbTowerHero:onModelLoadedEnd()
	local go = self.entityModel.modelGameObject

	self.entityModel:setModelLayer(Const.LAYER_NPC)

	self.modelLoaded = true

	if self.hero then
		self.dragController:SetLodGroup(go, -1)
		self:setModelPos(go, false)
	end

	self:showModel()
end

function ClimbTowerHero:setRotation(angle)
	if self._modelsTransform then
		local originAngle = self._modelsTransform.localEulerAngles

		self.angle = angle
		self._modelsTransform.localEulerAngles = Vector3(originAngle.x, angle, originAngle.z)

		if not self.isMySelf then
			local scale = self._modelsTransform.localScale

			self._modelsTransform.localScale = Vector3(scale.x, scale.y, scale.z * -1)
		end
	end
end

function ClimbTowerHero:_getBaseModelId(...)
	if self.putData.hero then
		return self.putData.hero:getShowBaseModelId()
	else
		return self.data.baseId or self.modelId
	end
end

return ClimbTowerHero

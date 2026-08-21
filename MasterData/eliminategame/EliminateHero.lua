-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/EliminateGame\\EliminateHero.lua

local EliminateObject = require("EliminateGame/EliminateObject")
local ModelTool = require("Entity/ModelTool")
local strClassName = "EliminateHero"
local EliminateHero = Class(strClassName, EliminateObject)

function EliminateHero:ctor(entityId, entityName, parent, putData, initData)
	self.modelLoaded = false
end

function EliminateHero:destroy(...)
	EliminateHero.super.destroy(self)

	self.modelLoaded = false
end

function EliminateHero:getHeroModelData(info, high)
	local modelData = {}

	modelData.model_type = Const.MODEL_TYPE.RearHouse
	self.hero = true
	modelData.model_id = self.modelId

	if high then
		modelData.use_lod = Const.MODEL_LOD_LV1
	else
		modelData.use_lod = Const.MODEL_LOD_LV2
	end

	local animator = ModelTool.getControllerPathByType(self.modelId, Const.MODEL_TYPE.RearHouse)

	if animator then
		modelData.animator = animator
	end

	return modelData
end

function EliminateHero:onModelLoadedEnd()
	local go = self.entityModel.modelGameObject

	self.entityModel:setModelLayer(Const.LAYER_NPC)

	self.modelLoaded = true

	if self.hero then
		self.dragController:SetLodGroup(go, -1)
		self:setModelPos(go, false)
	end

	self:showModel()
end

function EliminateHero:_getBaseModelId(...)
	if self.putData.hero then
		return self.putData.hero:getShowBaseModelId()
	else
		return self.data.baseId or self.modelId
	end
end

return EliminateHero

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Entity\\ModelTool.lua

local ResHeroBase = require("ClientData/ResHeroBase")
local ModelMeshInfo = require("ClientData/ModelMeshInfo")
local ModelFactory = Framework.Entity.ModelFactory
local AutoRotate = AutoRotate
local ModelType = Const.MODEL_TYPE
local ModelTool = {}
local self = ModelTool

function ModelTool.analyzeModelData(oriModelData)
	local modelType = oriModelData.model_type or ModelType.Default
	local useLOD = oriModelData.use_lod or Const.MODEL_LOD_LV0
	local data = {}

	if modelType == ModelType.Default then
		local commonModelId = oriModelData.model_id

		if not commonModelId then
			return
		end

		ModelTool._prepareCommonModelData(data, commonModelId, useLOD)
	elseif modelType == ModelType.Simple then
		local prefabPath = oriModelData.path

		if not prefabPath then
			return
		end

		data.avatar = prefabPath
	elseif modelType == ModelType.ShowMain or modelType == ModelType.ShowStepOne or modelType == ModelType.ShowStepTwo or modelType == ModelType.ShowResult or modelType == ModelType.PerformAct or modelType == ModelType.ARAct or modelType == ModelType.ShowDrag or modelType == ModelType.RearHouse or modelType == ModelType.ShowSkinStatic then
		local commonModelId = oriModelData.model_id

		if not commonModelId then
			return
		end

		ModelTool._prepareShowModelData(data, commonModelId, modelType, useLOD)
	end

	if oriModelData.model_id then
		data.model_id = oriModelData.model_id
	end

	if oriModelData.animator then
		data.animator = oriModelData.animator
	end

	if oriModelData.scale then
		data.scale = (data.scale or 1) * oriModelData.scale
	end

	if oriModelData.fashion_tag and data.avatar then
		data.avatar = data.avatar .. "_" .. oriModelData.fashion_tag
	end

	return data
end

function ModelTool._prepareCommonModelData(data, commonModelId, useLOD)
	local resModelData = utils.getCommonModelData(commonModelId)

	if not resModelData then
		return
	end

	local pathData = utils.getModelPathData(resModelData.path_id) or {}
	local basePath = pathData.base_path
	local avatarPath = ModelTool.getAvatarPath(pathData, "avatar_bone_lv", useLOD)

	if not avatarPath or not basePath then
		return
	end

	data.avatar = string.format("Characters/%s/Avatars/%s", basePath, avatarPath)
	data.parts = {}

	local scaleRatio = resModelData.scale

	if scaleRatio and scaleRatio > 0 then
		data.scale = scaleRatio / 10000
	end
end

function ModelTool.getAnimator(commonModelId, showType)
	local resModelData = utils.getCommonModelData(commonModelId)

	if not resModelData then
		return
	end

	local showInfo = resModelData[showType]

	if not showInfo then
		return nil
	end

	showInfo = showInfo[1]

	local animPath = showInfo.ani_con_path
	local animName = showInfo.ani_con_name

	if not animPath or not animName then
		return
	end

	return ModelTool.getControllerPath(animPath, animName, showType ~= Const.MODEL_TYPE.PerformAct)
end

function ModelTool._prepareShowModelData(data, commonModelId, showType, useLOD)
	local resModelData = utils.getCommonModelData(commonModelId)

	if not resModelData then
		return
	end

	local showInfo = resModelData[showType]

	if not showInfo then
		return ModelTool._prepareCommonModelData(data, commonModelId, useLOD)
	end

	local pathData = utils.getModelPathData(resModelData.path_id) or {}

	showInfo = showInfo[1]

	local basePath = pathData.base_path
	local showAvatar = showInfo.avatar or ModelTool.getAvatarPath(pathData, Const.DEFAULT_MODEL_PATH[showType], useLOD)

	if not showAvatar or not basePath then
		return
	end

	data.avatar = string.format("Characters/%s/Avatars/%s", basePath, showAvatar)

	local animPath = showInfo.ani_con_path
	local animName = showInfo.ani_con_name

	if not animPath or not animName then
		return
	end

	data.animator = ModelTool.getControllerPath(animPath, animName, showType ~= Const.MODEL_TYPE.PerformAct)
	data.parts = {}

	local bodyPart = showInfo.body_part

	if bodyPart then
		local partType = self.getBodyPartType(1)

		data.parts[partType] = string.format("Characters/%s/Bodies/%s", basePath, bodyPart)
	end

	local scale = showInfo.scale

	if scale then
		data.scale = scale
	end
end

function ModelTool.getControllerPath(path, weaponType, isOverride)
	local extension

	extension = isOverride and ".overrideController" or ".controller"

	if path and path ~= "" then
		return "Animators/" .. path .. "/" .. weaponType .. extension
	else
		return "Animators/" .. weaponType .. extension
	end
end

function ModelTool.getControllerPathByType(commonModelId, showType)
	local resModelData = utils.getCommonModelData(commonModelId)

	if not resModelData then
		return
	end

	local showInfo = resModelData[showType]

	if not showInfo then
		return
	end

	local pathData = utils.getModelPathData(resModelData.path_id) or {}

	showInfo = showInfo[1]

	local animPath = showInfo.ani_con_path
	local animName = showInfo.ani_con_name

	if not animPath or not animName then
		return
	end

	return ModelTool.getControllerPath(animPath, animName, showType ~= Const.MODEL_TYPE.PerformAct)
end

function ModelTool.getAvatarPath(pathData, avatarBase, lodLv)
	local avatarKey = avatarBase .. lodLv
	local showAvatar = pathData[avatarKey]

	while not showAvatar and lodLv ~= Const.MODEL_LOD_LV0 do
		lodLv = lodLv - 1
		avatarKey = avatarBase .. lodLv
		showAvatar = pathData[avatarKey]
	end

	return showAvatar
end

function ModelTool.getBodyPartType(index)
	if index >= 1 and index <= 10 then
		return "bodyPart" .. index
	end
end

function ModelTool.modelPlayAnimation(modelInsId, animationName, modelAux)
	animationName = ModelTool.checkAnimChange(modelInsId, animationName)
	modelAux = modelAux or ModelFactory.GetModelAux(modelInsId)

	if modelAux then
		modelAux:PlayAnimator(animationName)
	end
end

function ModelTool.modelPlayAnimationNow(modelInsId, animationName)
	animationName = ModelTool.checkAnimChange(modelInsId, animationName)

	local modelAux = ModelFactory.GetModelAux(modelInsId)

	if modelAux then
		modelAux:PlayAnimatorNow(animationName)
	end
end

function ModelTool.getModelAuxByInsId(modelInsId)
	return ModelFactory.GetModelAux(modelInsId)
end

function ModelTool.addAutoRotateComponent(modelInsId)
	return ModelFactory.AddAutoRotateComponent(modelInsId)
end

function ModelTool.hasAvatarPath(commonModelId, avatarBase, lodLv)
	local resModelData = utils.getCommonModelData(commonModelId)

	if not resModelData then
		return false
	end

	local pathData = utils.getModelPathData(resModelData.path_id) or {}
	local avatarKey = avatarBase .. lodLv

	return pathData[avatarKey] ~= nil
end

function ModelTool.addBaseModel(modelInsId, commonModelId, baseLv, baseType, callback)
	if not ResHeroBase[commonModelId] or not ResHeroBase[commonModelId][baseLv] then
		return
	end

	local baseInfo = ResHeroBase[commonModelId][baseLv]
	local path = baseInfo.base_path or "Characters/Common/Herobase_Level_02_size_01.prefab"
	local showInfo = baseInfo[baseType]
	local pos = Vector3.zero
	local scale = Vector3.one
	local rotate = 0
	local height = 0

	if showInfo and showInfo[1] then
		showInfo = showInfo[1]

		if showInfo.base_scale then
			scale = {
				x = showInfo.base_scale[1],
				y = showInfo.base_scale[2],
				z = showInfo.base_scale[3]
			}
		end

		if showInfo.height then
			height = showInfo.height
		end

		ModelFactory.AddBaseModelWithParam(modelInsId, path, pos, scale, rotate, height, callback)
	else
		ModelFactory.AddBaseModel(modelInsId, path, callback)
	end
end

function ModelTool.delBaseModel(modelInsId)
	ModelFactory.DelBaseModel(modelInsId)
end

function ModelTool.restModelPosition(modelInsId, yAdjust)
	local modelGO = ModelFactory.GetModelObject(modelInsId)

	if modelGO and modelGO.transform then
		local pos = Vector3(0, yAdjust or 0, 0)

		modelGO.transform.localPosition = pos
	end
end

function ModelTool.changeModelAnim(modelInsId, changeDict)
	if not self.modelAnimChangeDict then
		self.modelAnimChangeDict = {}
	end

	self.modelAnimChangeDict[modelInsId] = changeDict
end

function ModelTool.clearModelAnim(modelInsId)
	if self.modelAnimChangeDict and self.modelAnimChangeDict[modelInsId] then
		self.modelAnimChangeDict[modelInsId] = nil
	end
end

function ModelTool.checkAnimChange(modelInsId, animName)
	if self.modelAnimChangeDict and self.modelAnimChangeDict[modelInsId] and self.modelAnimChangeDict[modelInsId][animName] then
		animName = self.modelAnimChangeDict[modelInsId][animName]
	end

	return animName
end

return ModelTool

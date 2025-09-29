-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/character/model/ModelData.lua

module("logic.extensions.character.model.ModelData", package.seeall)

local M = class("ModelData")
local kResTagPerform = "perform"

function M:ctor(modelId)
	self._modelId = modelId
	self._modelCO = ModelConfig.instance:getModelConfig(modelId)
end

function M:getModelCO()
	return self._modelCO
end

function M:modelId()
	return self._modelCO.code
end

function M:height()
	return self._modelCO.height
end

function M:positionOffsets()
	return self._modelCO.positionOffsets
end

function M:flagScale()
	return self._modelCO.flagScale
end

function M:attackScale()
	return self._modelCO.attackScale
end

function M:vertices()
	return self._modelCO.vertices
end

function M:multiTimelineAnims()
	return self._modelCO.multiTimelineAnims
end

function M:skillNotReverse()
	return self._modelCO.skillNotReverse
end

function M:headIconName()
	return self._modelCO.headIconName
end

function M:halfIconName()
	return self._modelCO.halfIconName
end

function M:headIconReverse()
	return self._modelCO.headIconReverse
end

function M:wholeIconName()
	return self._modelCO.wholeIconName
end

function M:modelType()
	return self._modelCO.modelType
end

function M:modelTypeParam()
	return self._modelCO.modelTypeParam
end

function M:lockDirection()
	return self._modelCO.lockDirection
end

function M:resDirType()
	return self._modelCO.resDirType
end

function M:resName()
	return self._modelCO.resName
end

function M:houseResName()
	return self._modelCO.houseResName
end

function M:rogueResName()
	return self._modelCO.rogueResName
end

function M:mainSceneResName()
	return self._modelCO.mainSceneResName
end

function M:mainSceneElement()
	return self._modelCO.mainSceneElement
end

function M:storyResName()
	return self._modelCO.storyResName
end

function M:audioName()
	return self._modelCO.audioName
end

function M:footSteps()
	return self._modelCO.footSteps
end

function M:specialResForBoss()
	return self._modelCO.specialResForBoss
end

function M:mountWear()
	return self._modelCO.mountWear
end

function M:getXinMaoModelId()
	return self._modelCO.xinMaoModelId
end

function M:getMainTimelinePath()
	return ModelCOUtil.getMainTimelinePath(self._modelCO)
end

function M:getMainModelResPath()
	local resName = self:mainSceneResName()

	return string.format("character3d/%s/general/%s-main.prefab", resName, resName)
end

function M:getMainSceneChangeTimelinePath()
	local resName = self:mainSceneResName()

	return string.format("effect3d/prefab/main/%s_xiangqing_change/%s_xiangqing_change_p.prefab", resName, resName)
end

function M:getLotteryEnterShowTimelinePath()
	local resName = self:mainSceneResName()

	return string.format("effect3d/prefab/retrieve/getrole/%s_enter_show/%s_enter_show_p.prefab", resName, resName)
end

function M:getXinMaoPath()
	local xinMaoModelId = self:getXinMaoModelId()

	if xinMaoModelId > 0 then
		local modelData = ModelConfig.instance:getModelData(xinMaoModelId)

		if modelData then
			return modelData:getXinMaoPath()
		end

		return nil
	end

	local resName = self:mainSceneResName()
	local heroName = false
	local tempStr = string.split(resName, "_")

	if #tempStr == 2 then
		heroName = tempStr[2]
	end

	local path = GameUrl.GetXinMaoPath(resName, heroName)

	if not Astral.LuaResourceCache.Instance:ExistsResource(path) then
		path = nil
	end

	return path
end

function M:getPerformanceResName()
	local resName = self:resName()

	if self._modelCO.resTag and self._modelCO.resTag[kResTagPerform] then
		resName = self._modelCO.resTag[kResTagPerform]
	end

	return resName
end

return M

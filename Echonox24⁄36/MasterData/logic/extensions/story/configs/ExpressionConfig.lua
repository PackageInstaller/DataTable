-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/configs/ExpressionConfig.lua

module("logic.extensions.story.configs.ExpressionConfig", package.seeall)

local ExpressionConfig = class("ExpressionConfig", BaseConfig)

function ExpressionConfig:onInit()
	self._cfgInfo = false
end

function ExpressionConfig:getNames()
	return {
		ConfigName.Express
	}
end

function ExpressionConfig:handleConfig(name, content)
	if name == ConfigName.Express then
		self._cfgInfo = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function ExpressionConfig:getConfigInfoCO(code)
	local configList = self._cfgInfo[code]

	if not configList and enableErrorLog then
		printError(string.format("无法找到对应表情，ID:[%s]", code))
	end

	return configList
end

function ExpressionConfig:getExpressionCountByModelId(modelId)
	local configList = self:getConfigInfoCO(modelId)
	local count = 0

	if configList then
		for _, v in ipairs(configList) do
			if v.isHideInRoleData ~= 1 then
				count = count + 1
			end
		end
	end

	return count
end

function ExpressionConfig:getConfigByModelIdAndExpressionId(modelId, faceId)
	local configList = self:getConfigInfoCO(modelId)
	local expressCO = false

	if configList then
		for _, v in ipairs(configList) do
			if faceId == v.expressionID then
				expressCO = v

				break
			end
		end
	end

	if not expressCO and enableWarnLog then
		printWarn(string.format("无法找到对应表情，ModelId:[%s],faceId:[%s]", modelId, faceId))
	end

	return expressCO
end

function ExpressionConfig:getFaceNameById(modelid, faceid)
	local faceName = ""
	local configList = self:getConfigInfoCO(modelid)

	faceName = self:getDefaultFaceByList(configList)

	if configList then
		for _, v in ipairs(configList) do
			if faceid == v.expressionID then
				faceName = v.expressionName

				break
			end
		end
	end

	return faceName
end

function ExpressionConfig:getFaceInfo(code, face)
	local faceInfo = "changtai"
	local tmpNpcCO = PlotTempNpcConfig.instance:getPlotTempNpcCO(code)

	if tmpNpcCO then
		local configList = self:getConfigInfoCO(tmpNpcCO.modelId)

		faceInfo = self:getDefaultFaceByList(configList)

		if configList then
			for _, v in ipairs(configList) do
				if face and face == v.expressionName then
					faceInfo = v.expressionRes

					break
				end
			end
		end
	end

	return faceInfo
end

function ExpressionConfig:getFaceResByName(modelid, facename)
	local faceRes = "changtai"
	local configList = self:getConfigInfoCO(modelid)

	faceRes = self:getDefaultFaceByList(configList)

	if configList then
		for _, v in ipairs(configList) do
			if facename == v.expressionName then
				faceRes = v.expressionRes

				break
			end
		end
	end

	return faceRes
end

function ExpressionConfig:getDefaultFace(modleId)
	local configList = self:getConfigInfoCO(modleId)
	local faceName = false

	if configList then
		for _, v in ipairs(configList) do
			if v.expressionID == 1 then
				faceName = v.expressionRes

				break
			end
		end
	end

	if not faceName and enableErrorLog then
		printError(string.format("无法找到对应默认表情表情，ModelId:[%s]", modleId))
	end

	return faceName
end

function ExpressionConfig:getDefaultFaceByList(configList)
	local faceName = false

	if configList then
		for _, v in ipairs(configList) do
			if v.expressionID == 1 then
				faceName = v.expressionRes

				break
			end
		end
	end

	if not faceName and enableErrorLog then
		printError(string.format("无法找到对应默认表情表情，ModelId:[%s]", modelId))
	end

	return faceName
end

ExpressionConfig.instance = ExpressionConfig.New()

return ExpressionConfig

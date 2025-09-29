-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterdepot/config/CharacterCOUtil.lua

module("logic.extensions.characterdepot.config.CharacterCOUtil", package.seeall)

local CharacterCOUtil = {}

function CharacterCOUtil.getCode(characterCO)
	return characterCO.id
end

function CharacterCOUtil.getName(characterCO)
	return characterCO.name
end

function CharacterCOUtil.getModelCode(characterCO)
	return characterCO.modelId
end

function CharacterCOUtil.getCareer(characterCO)
	return characterCO.career
end

function CharacterCOUtil.getIcon(characterCO)
	local modelId = characterCO.modelId
	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	return modelCO.headIconName
end

function CharacterCOUtil.quality2IconName(quality)
	return CommEnum.Quality2SamllIcon[quality]
end

function CharacterCOUtil.quality2LineName(quality)
	return CommEnum.Quality2LineName[quality]
end

function CharacterCOUtil.colorType2IconName(colorType)
	return CommEnum.ColorType2Icon[colorType]
end

function CharacterCOUtil.colorType2BgName(colorType)
	return CommEnum.ColorType2Bg[colorType]
end

function CharacterCOUtil.career2IconName(career)
	return CommEnum.Career2Icon[career]
end

function CharacterCOUtil.campType2Name(campType)
	return CommEnum.CampType2Name[campType]
end

function CharacterCOUtil.qua2Color(qua)
	return CommEnum.Qua2Color[qua]
end

function CharacterCOUtil.qua2Score(qua)
	return CommEnum.Qua2Score[qua]
end

function CharacterCOUtil.qua2Ratio(qua)
	return qua / 6
end

function CharacterCOUtil.getCareerName(career)
	return CommEnum.Career2Name[career]
end

function CharacterCOUtil.getXinMaoPath(heroId)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(heroId)
	local modelCO = ModelConfig.instance:getModelConfig(characterCO.modelId)
	local resFolder = modelCO.resName
	local name = string.split(resFolder, "_")[2]

	return GameUrl.GetXinMaoPath(resFolder, name)
end

local heightMap = {
	[0] = -1.13,
	-1.18,
	-1.22,
	-1.13,
	-1.18,
	-1.22
}

function CharacterCOUtil.getHeroHeight(heightLevel)
	return heightMap[heightLevel] or -1
end

return CharacterCOUtil

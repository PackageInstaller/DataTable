-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/config/DungeonStarCOWrapper.lua

module("logic.extensions.dungeon.config.DungeonStarCOWrapper", package.seeall)

local DungeonStarCOWrapper = class("DungeonStarCOWrapper")
local kDescriptionBuilderTable = {
	nil,
	nil,
	nil,
	"_description_builder4",
	"_description_builder5",
	"_description_builder6",
	"_description_builder7",
	nil,
	"_description_builder9",
	nil,
	nil,
	"_description_builder12",
	"_description_builder12"
}

function DungeonStarCOWrapper:ctor(dungeonStarCO)
	self._dungeonStarCO = dungeonStarCO
	self._description = false

	self:_buildConfig()
end

function DungeonStarCOWrapper:getDungeonStarCO()
	return self._dungeonStarCO
end

function DungeonStarCOWrapper:getDescription()
	return self._description
end

function DungeonStarCOWrapper:_buildConfig()
	self._description = self:_buildDescription()
end

function DungeonStarCOWrapper:_buildDescription()
	local dungeonStarCO = self._dungeonStarCO
	local builder = self:_getDescriptionBuilder(dungeonStarCO.type)

	if builder then
		return builder(self, dungeonStarCO)
	else
		return string.format(dungeonStarCO.desc, dungeonStarCO.parameter)
	end
end

function DungeonStarCOWrapper:_getDescriptionBuilder(tType)
	local builderKey = kDescriptionBuilderTable[tType]

	return builderKey and DungeonStarCOWrapper[builderKey]
end

function DungeonStarCOWrapper:_description_builder4(dungeonStarCO)
	local parameterArray = string.split(dungeonStarCO.parameter, "#")
	local count = checkint(parameterArray[1])
	local campType = checkint(parameterArray[2])

	return string.format(dungeonStarCO.desc, count, CharacterCOUtil.campType2Name(campType))
end

function DungeonStarCOWrapper:_description_builder5(dungeonStarCO)
	local entityCodeList = {}
	local params = string.split(dungeonStarCO.parameter, "#")

	for i, param in ipairs(params) do
		table.insert(entityCodeList, checkint(param))
	end

	local names = {}

	for i, entityCode in ipairs(entityCodeList) do
		local entityCOAdapter = BattleEntityCOAdapter:getSharedEntityCOAdapter(entityCode)

		table.insert(names, entityCOAdapter and entityCOAdapter:getName())
	end

	return string.format(dungeonStarCO.desc, unpack(names))
end

function DungeonStarCOWrapper:_description_builder6(dungeonStarCO)
	local entityCode = checkint(dungeonStarCO.parameter)
	local entityCOAdapter = BattleEntityCOAdapter:getSharedEntityCOAdapter(entityCode)

	return string.format(dungeonStarCO.desc, entityCOAdapter and entityCOAdapter:getName())
end

function DungeonStarCOWrapper:_description_builder7(dungeonStarCO)
	local parameterArray = string.split(dungeonStarCO.parameter, "#")
	local count = checkint(parameterArray[1])
	local careerType = checkint(parameterArray[2])

	return string.format(dungeonStarCO.desc, count, CharacterCOUtil.getCareerName(careerType))
end

function DungeonStarCOWrapper:_description_builder9(dungeonStarCO)
	local careerType = checkint(dungeonStarCO.parameter)

	return string.format(dungeonStarCO.desc, CharacterCOUtil.getCareerName(careerType))
end

function DungeonStarCOWrapper:_description_builder12(dungeonStarCO)
	local parameterArray = string.split(dungeonStarCO.parameter, "#")
	local entityCode = checkint(parameterArray[1])
	local attrId = checkint(parameterArray[2])
	local value = parameterArray[3]
	local attrCO = AttributeDefineConfig.instance:getAttributeCO(attrId)

	return string.format(dungeonStarCO.desc, self:_getNameByEntityCode(entityCode), attrCO.name, string.format("%d%%", value * 100))
end

function DungeonStarCOWrapper:_getNameByEntityCode(entityCode)
	local entityCOAdapter = BattleEntityCOAdapter:getSharedEntityCOAdapter(entityCode)

	return entityCOAdapter and entityCOAdapter:getName()
end

return DungeonStarCOWrapper

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\BattleObject\\SkillDataBank.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local CueDataBank = require("System/CueDataBank")
local DataPath = "ClientData/SkillData/"
local SkillDataBank = {}
local skillData = {}
local DataVirtualPath = "ClientData.SkillData."

function SkillDataBank.initSkillData(weaponType)
	if weaponType then
		local fullDataPath = DataPath .. weaponType
		local weaponData = require(fullDataPath)

		if weaponData ~= nil then
			skillData[weaponType] = weaponData

			local cueFile = weaponData.cueFile

			if cueFile and cueFile ~= "" then
				CueDataBank.initCueData(cueFile)
			end

			return true
		else
			return false
		end
	end
end

function SkillDataBank.refreshData(weaponType)
	if weaponType then
		package.loaded[DataVirtualPath .. weaponType] = nil

		SkillDataBank.initSkillData(weaponType)
	else
		for weaponName, _ in pairs(skillData) do
			package.loaded[DataVirtualPath .. weaponName] = nil

			SkillDataBank.initSkillData(weaponName)
		end
	end
end

function SkillDataBank.clearSkillData()
	skillData = {}
end

function SkillDataBank.getSkillData(weaponType, skillId)
	if skillData[weaponType] == nil then
		local success = SkillDataBank.initSkillData(weaponType)

		if not success then
			return nil
		end
	end

	if skillData[weaponType][skillId] ~= nil then
		return skillData[weaponType][skillId]
	elseif skillData.Hero_Common[skillId] ~= nil then
		return skillData.Hero_Common[skillId]
	else
		return nil
	end
end

function SkillDataBank.getAttackEventList(weaponType, skillId)
	local skill = SkillDataBank.getSkillData(weaponType, skillId)

	if skill then
		local atkEventData = skill.atkEvents

		if atkEventData then
			return atkEventData
		else
			return nil
		end
	end
end

function SkillDataBank.getAtkEventData(weaponType, skillId, atkEventId, eventLevel)
	local events = SkillDataBank.getAttackEventList(weaponType, skillId)

	if events and events[atkEventId] then
		local eventData = events[atkEventId]

		if eventData and eventData.levelAtkEvents and eventData.levelAtkEvents[eventLevel] and next(eventData.levelAtkEvents[eventLevel]) then
			setmetatable(eventData.levelAtkEvents[eventLevel], {
				__index = eventData
			})

			return eventData.levelAtkEvents[eventLevel]
		else
			return eventData
		end
	else
		return nil
	end
end

function SkillDataBank.getOffsetEventData(weaponType, skillId, offsetEventId)
	local skill = SkillDataBank.getSkillData(weaponType, skillId)

	if skill then
		local offsetEventList = skill.offsetEvents

		if offsetEventList then
			if offsetEventList[offsetEventId] then
				return offsetEventList[offsetEventId]
			else
				return nil
			end
		end
	end
end

function SkillDataBank.getSkillName(weaponType, skillId)
	local skill = SkillDataBank.getSkillData(weaponType, skillId)

	if skill then
		if skill.name ~= "" then
			return skill.name
		else
			return weaponType .. skillId
		end
	end
end

function SkillDataBank.getAllData(weaponType)
	if skillData[weaponType] then
		return skillData[weaponType]
	else
		return nil
	end
end

SkillDataBank.initSkillData("Hero_Common")

return SkillDataBank

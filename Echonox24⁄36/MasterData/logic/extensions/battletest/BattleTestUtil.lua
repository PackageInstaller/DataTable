-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battletest/BattleTestUtil.lua

module("logic.extensions.battletest.BattleTestUtil", package.seeall)

local BattleTestUtil = {}

local function buildServerSkillDatas(skillCodes, enhanceCodes)
	local serverSkillDatas = {}

	for _, skillCode in pairs(skillCodes) do
		local serverSkillData = {
			code = skillCode,
			enhances = {
				0
			}
		}

		table.insert(serverSkillDatas, serverSkillData)

		for _, enhanceCode in pairs(enhanceCodes) do
			local enhanceCO = ActiveSkillConfig.instance:getSkillEnhanceCO(enhanceCode)

			if enhanceCO and enhanceCO.skillCode == skillCode then
				table.insert(serverSkillData.enhances, enhanceCode)
			end
		end
	end

	return serverSkillDatas
end

local function clientEntityData2ServerEntityData(clientEntityData)
	local coordinates = string.splitToNumber(clientEntityData.coordinates, ",")
	local skillCodes = string.splitToNumber(clientEntityData.skillCodes, ",")
	local enhanceCodes = string.splitToNumber(clientEntityData.enhanceCodes, ",")
	local serverEntityData = {}

	serverEntityData.code = clientEntityData.code
	serverEntityData.x = coordinates[1] or 0
	serverEntityData.z = coordinates[2] or 0
	serverEntityData.skills = buildServerSkillDatas(skillCodes, enhanceCodes)
	serverEntityData.move = clientEntityData.move
	serverEntityData.battleCamp = clientEntityData.battleCamp
	serverEntityData.maxHp = clientEntityData.maxHp
	serverEntityData.atkPhy = clientEntityData.atkPhy
	serverEntityData.defPhy = clientEntityData.defPhy
	serverEntityData.atkMag = clientEntityData.atkMag
	serverEntityData.defMag = clientEntityData.defMag
	serverEntityData.inspiration = clientEntityData.inspiration
	serverEntityData.hasSanity = clientEntityData.hasSanity > 0
	serverEntityData.sanity = clientEntityData.sanity
	serverEntityData.aiName = clientEntityData.aiName
	serverEntityData.weakPointColor = clientEntityData.weakPointColor
	serverEntityData.weakPointHpRate = clientEntityData.weakPointHpRate

	return serverEntityData
end

local function clientCampData2ServerCampData(clientCampData)
	local serverCampData = {}

	for _, clientEntityData in pairs(clientCampData) do
		if clientEntityData then
			local serverEntityData = clientEntityData2ServerEntityData(clientEntityData)

			table.insert(serverCampData, serverEntityData)
		end
	end

	return serverCampData
end

BattleTestUtil.isTest = false
BattleTestUtil.TestBattleLevelCode = 0
BattleTestUtil.DefaultMapCode = 10301
BattleTestUtil.LastTestRequestData = false

function BattleTestUtil.enterBattleTest(clientCampDataList)
	local reqLuaTable = {}

	reqLuaTable.cmd = GameEnum.GMCmdEnum.DummyBattle
	reqLuaTable.value = {}
	reqLuaTable.value.map = clientCampDataList.sceneCode or BattleTestUtil.DefaultMapCode
	reqLuaTable.value.me = clientCampData2ServerCampData(clientCampDataList[1])
	reqLuaTable.value.enemy = clientCampData2ServerCampData(clientCampDataList[2])
	BattleTestUtil.LastTestRequestData = reqLuaTable

	HackToolAgent.instance:sendGmRequest(reqLuaTable)
end

function BattleTestUtil.requestDummyBattleLevel(battleLevelCode)
	local param = HackToolUtil.createStartBattleLevel(battleLevelCode)

	BattleTestUtil.TestBattleLevelCode = battleLevelCode

	MonsterConfig.instance:loadLevelMonsterConfig(battleLevelCode)
	HackToolAgent.instance:sendGmRequest(param)
end

local BATTLE_DEBUG = "battle_debug"
local BATTLE_USE_PROGRAME_SCENE = "use_empty_scene"
local BATTLE_HIDE_SCENE = "battle_hide_scene"
local BATTLE_OUTPUT_LOG = "battle_output_log"
local BATTLE_OUTPUT_SERVER_LOG = "battle_output_server_log"

function BattleTestUtil.init()
	SpaceX.CheckBoardSetting.debug = Astral.LocalStorage.Instance:GetInt(BATTLE_DEBUG) > 0

	BattleTestUtil.setUseProgramScene(Astral.LocalStorage.Instance:GetInt(BATTLE_USE_PROGRAME_SCENE) > 0)
	BattleTestUtil.setHideScene(Astral.LocalStorage.Instance:GetInt(BATTLE_HIDE_SCENE) > 0)
	BattleTestUtil.setOutputLog(Astral.LocalStorage.Instance:GetInt(BATTLE_OUTPUT_LOG) > 0)
	BattleTestUtil.setOutputServerLog(Astral.LocalStorage.Instance:GetInt(BATTLE_OUTPUT_SERVER_LOG) > 0)
end

function BattleTestUtil.setDebug(isDebug)
	SpaceX.CheckBoardSetting.debug = isDebug

	Astral.LocalStorage.Instance:SetInt(BATTLE_DEBUG, isDebug and 1 or 0)
end

function BattleTestUtil.isDebug()
	return SpaceX.CheckBoardSetting.debug
end

function BattleTestUtil.setUseProgramScene(useProgramScene)
	BattleTestUtil._useProgramScene = useProgramScene

	Astral.LocalStorage.Instance:SetInt(BATTLE_USE_PROGRAME_SCENE, useProgramScene and 1 or 0)
end

function BattleTestUtil.isUseProgramScene()
	return BattleTestUtil._useProgramScene
end

function BattleTestUtil.setHideScene(hideScene)
	BattleTestUtil._hideScene = hideScene

	Astral.LocalStorage.Instance:SetInt(BATTLE_HIDE_SCENE, hideScene and 1 or 0)
end

function BattleTestUtil.isHideScene()
	return BattleTestUtil._hideScene
end

function BattleTestUtil.setOutputLog(outputLog)
	BattleTestUtil._outputLog = outputLog

	Astral.LocalStorage.Instance:SetInt(BATTLE_OUTPUT_LOG, outputLog and 1 or 0)
end

function BattleTestUtil.isOutputLog()
	return BattleTestUtil._outputLog
end

function BattleTestUtil.setOutputServerLog(outputLog)
	BattleTestUtil._outputServerLog = outputLog

	Astral.LocalStorage.Instance:SetInt(BATTLE_OUTPUT_SERVER_LOG, outputLog and 1 or 0)
end

function BattleTestUtil.isOutputServerLog()
	return BattleTestUtil._outputServerLog
end

return BattleTestUtil

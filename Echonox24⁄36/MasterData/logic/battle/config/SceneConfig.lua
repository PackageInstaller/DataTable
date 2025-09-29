-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/SceneConfig.lua

module("logic.battle.config.SceneConfig", package.seeall)

local SceneConfig = class("SceneConfig", BaseConfig)

function SceneConfig:onInit()
	self._cfgScene = false
	self._storyScene = false
end

function SceneConfig:getNames()
	return {
		ConfigName.Scene,
		ConfigName.StoryScene
	}
end

function SceneConfig:handleConfig(name, content)
	if name == ConfigName.Scene then
		self._cfgScene = content
	elseif name == ConfigName.StoryScene then
		self._storyScene = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function SceneConfig:getSceneCO(code)
	local sceneCO = self._cfgScene[code]

	if code ~= 0 and not sceneCO and BattleLog.enableError then
		BattleLog.error(string.format("SceneConfig::cannot find scene config for code[%s]", code))
	end

	return sceneCO
end

function SceneConfig:getStoryScene(code)
	local sceneCO = self._storyScene[code]

	if code > 0 and not sceneCO then
		printError("StoryScene::无法找到剧情场景预设，ID：", code)
	end

	return sceneCO
end

function SceneConfig:getBattleCalcuteCO()
	if not self._cfgBattleCalcute then
		local path = "logic.config.leveleditor.leveleditorjson.t_export_battle_calculate"

		self._cfgBattleCalcute = require(path)
	end

	return self._cfgBattleCalcute
end

function SceneConfig:getBattleCalcuteHeroCO()
	if not self._cfgBattleCalcuteHero then
		local path = "logic.config.leveleditor.leveleditorjson.t_export_battle_calculate_hero"

		self._cfgBattleCalcuteHero = require(path)
	end

	return self._cfgBattleCalcuteHero
end

SceneConfig.instance = SceneConfig.New()

return SceneConfig

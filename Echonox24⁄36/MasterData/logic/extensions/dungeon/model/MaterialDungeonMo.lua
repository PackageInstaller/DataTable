-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/MaterialDungeonMo.lua

module("logic.extensions.dungeon.model.MaterialDungeonMo", package.seeall)

local M = class("MaterialDungeonMo", DungeonMOBase)

function M:setChapterIdAndDifficulty(chapterId)
	self._chapterId = chapterId
	self._difficulty = 1
end

function M:setMaterialDungeonCode(code)
	self._materialDungeonCode = code

	local materialDungeonCO = DungeonConfig.instance:getMaterialDungeonCfgByMaterialDungoenId(code)

	self._unlockLevel = materialDungeonCO.unlockLv
	self._previewReward = materialDungeonCO.previewReward
	self._bannerRes = materialDungeonCO.bannerRes
	self._difficultyStr = materialDungeonCO.difficultyStr
	self._unlockDungeonCode = materialDungeonCO.unlockDungeonCode
end

function M:getChapterCo()
	if self._chapterCO == nil then
		self._chapterCO = DungeonConfig.instance:getChapterCO(CommEnum.DungeonType.Material, self:getChapterId())
	end

	return self._chapterCO
end

function M:getMaterialDungeonCode()
	return self._materialDungeonCode
end

function M:getBannerRes()
	return self._bannerRes
end

function M:getDifficultyStr()
	return self._difficultyStr
end

function M:getUnlockLevel()
	return self._unlockLevel
end

function M:getUnlockDungeonInfo()
	local dungeonName = ""

	if self._unlockDungeonCode and self._unlockDungeonCode ~= 0 then
		local dungeonCo = DungeonConfig.instance:getDungeonCfgById(self._unlockDungeonCode)

		if dungeonCo then
			if dungeonCo.type == CommEnum.DungeonType.Mainline then
				local difficultyDesc = DungeonEnum.MainLineDiffName[DungeonEnum.Difficulty.Easy]
				local mainlineCO = DungeonConfig.instance:getCfgMainLineChapterIncludePlot(self._unlockDungeonCode)

				if mainlineCO then
					difficultyDesc = DungeonEnum.MainLineDiffName[mainlineCO.difficulty]
				else
					printError("Mainline dungeon config is not found, id ", self._unlockDungeonCode)
				end

				dungeonName = langF("task_mainline_dungeon_format_name", difficultyDesc, dungeonCo.index)
			elseif dungeonCo.type == CommEnum.DungeonType.LightTower then
				dungeonName = langF("task_lighttow_dungeon_format_name", dungseonCo.index)
			elseif dungeonCo.type == CommEnum.DungeonType.DarkTower then
				dungeonName = langF("task_darktow_dungeon_format_name", dungeonCo.index)
			else
				dungeonName = langF("task_common_dungeon_format_name", DungeonConfig.instance:getDungeonTypeName(dungeonCo.type), dungeonCo.index)
			end
		else
			print("找不到副本", self._unlockDungeonCode)
		end
	end

	return self._unlockDungeonCode and self._unlockDungeonCode ~= 0, dungeonName
end

function M:getIsLock(showTips)
	return not self:getIsUnlock(showTips)
end

function M:getIsUnlock(showTips)
	if DungeonModel.instance:getAllDungeonUnlock() then
		return true
	end

	if not self:getPreDungeonPassed() then
		if showTips then
			FloatWordMgr.instance:show(lang("tip_teaching_lock"))
		end

		return false
	end

	if self._unlockDungeonCode and self._unlockDungeonCode ~= 0 then
		local unlockDungeonMo = DungeonModel.instance:getDungeonMoById(self._unlockDungeonCode)

		if not unlockDungeonMo:hasPassed() then
			if showTips then
				local code, unlockDungeonName = self:getUnlockDungeonInfo()

				FloatWordMgr.instance:show(langF("pass_pre_dungeon_unlock", unlockDungeonName))
			end

			return false
		end
	end

	if PlayerModel.instance:getLevel() < self._unlockLevel then
		if showTips then
			FloatWordMgr.instance:show(string.format(lang("tip_player_not_reach_level"), self:_formatLevel(self._unlockLevel)))
		end

		return false
	end

	return true
end

function M:getPreDungeonPassed()
	if not self._preDungeonId then
		return true
	end

	local preDungeonMo = DungeonMaterialChapterModel.instance:getDungeonMoById(self._preDungeonId)

	return preDungeonMo:hasPassed()
end

function M:getDungeonPreviewReward()
	return self._previewReward
end

function M:getImportantPassReward()
	local rewardList = {}

	if self._previewReward then
		for i, v in ipairs(self._previewReward) do
			table.insert(rewardList, v)
		end
	else
		if not self._normalReward then
			return rewardList
		end

		for _, rewardCode in ipairs(self._normalReward) do
			local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardCode)

			if rewardCO and rewardCO.rewardShow then
				for i, v in ipairs(rewardCO.rewardShow[1]) do
					table.insert(rewardList, v)
				end
			end
		end
	end

	return rewardList
end

function M:canRecord()
	local chapterId = self:getChapterId()
	local cfgChapter = DungeonConfig.instance:getChapterCO(CommEnum.DungeonType.Material, chapterId)

	if cfgChapter and cfgChapter.canRecord == 1 then
		return true
	end

	return false
end

function M:getConsecutiveLimit()
	local chapterId = self:getChapterId()
	local cfgChapter = DungeonConfig.instance:getChapterCO(CommEnum.DungeonType.Material, chapterId)

	return cfgChapter and cfgChapter.consecutive or 0
end

function M:getLockDesc()
	if not self:getPreDungeonPassed() then
		return lang("pass_pre_dungeon")
	end

	if self._unlockDungeonCode and self._unlockDungeonCode ~= 0 then
		local unlockDungeonMo = DungeonModel.instance:getDungeonMoById(self._unlockDungeonCode)

		if not unlockDungeonMo:hasPassed() then
			local code, unlockDungeonName = self:getUnlockDungeonInfo()

			return unlockDungeonName
		end
	end

	if PlayerModel.instance:getLevel() < self._unlockLevel then
		return langF("tip_x_level_open", self:_formatLevel(self._unlockLevel))
	end

	return ""
end

function M:_formatLevel(level)
	local a = math.floor(level / 10)
	local b = level % 10

	return string.format("%s-%s", a, b)
end

return M

-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/EquipExploreDungeonMo.lua

module("logic.extensions.dungeon.model.EquipExploreDungeonMo", package.seeall)

local M = class("EquipExploreDungeonMo", DungeonMOBase)

function M:initByConfig(co)
	M.super.initByConfig(self, co)
end

function M:setChapterIdAndDifficulty(chapterId)
	self._chapterId = chapterId
	self._difficulty = 1
end

function M:setMaterialDungeonCode(code)
	self._equipexploreDungeonCode = code

	local cfg = DungeonConfig.instance:getMaterialDungeonCfgByMaterialDungoenId(code)

	self._unlockLevel = cfg.unlockLv
	self._previewReward = cfg.previewReward
	self._bannerRes = cfg.bannerRes
	self._difficultyStr = cfg.difficultyStr
	self._unlockDungeonCode = cfg.unlockDungeonCode
end

function M:getChapterCo()
	if self._chapterCO == nil then
		self._chapterCO = DungeonConfig.instance:getChapterCO(CommEnum.DungeonType.Material, self:getChapterId())
	end

	return self._chapterCO
end

function M:getMaterialDungeonCode()
	return self._equipexploreDungeonCode
end

function M:getCommonDungeonId()
	return self:getId()
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

	local preDungeonMo = DungeonEquipExploreChapterModel.instance:getDungeonMoById(self._preDungeonId)

	return preDungeonMo:hasPassed()
end

function M:getDungeonPreviewReward()
	return self._previewReward
end

function M:getIsLock(showTips)
	return not self:getIsUnlock(showTips)
end

function M:getIsClear()
	return self:hasPassed()
end

function M:getBossId()
	local enemyIds = self:getEnemyIds()

	return enemyIds[1] or 0
end

function M:getBossLv()
	return self:getUnlockLevel()
end

function M:getCostItemId()
	return CommEnum.CurrencyCodeEnum.TlCode
end

function M:getCostItemCount()
	return self:getPointCost()
end

function M:getFirstPassRewardDataLst()
	if not self._firstPassRewardDataLst then
		self._firstPassRewardDataLst = {}

		for _, reward in ipairs(self:getAllFirstPassReward()) do
			self:_addRewardToTable(self._firstPassRewardDataLst, reward.code, reward.num, true)
		end
	end

	return self._firstPassRewardDataLst
end

function M:getNormalPassRewardDataLst()
	if not self._normalPassRewardDataLst then
		self._normalPassRewardDataLst = {}

		for _, reward in ipairs(self:getAllNormalPassReward()) do
			self:_addRewardToTable(self._normalPassRewardDataLst, reward, 1, false)
		end
	end

	return self._normalPassRewardDataLst
end

function M:getTotalPassRewardDataLst()
	if not self._totalPassRewardDataLst then
		self._totalPassRewardDataLst = {}

		local first = self:getFirstPassRewardDataLst()
		local normal = self:getNormalPassRewardDataLst()

		for _, value in ipairs(first) do
			table.insert(self._totalPassRewardDataLst, value)
		end

		for _, value in ipairs(normal) do
			table.insert(self._totalPassRewardDataLst, value)
		end
	end

	return self._totalPassRewardDataLst
end

function M:_addRewardToTable(theTable, itemId, itemCount, isFirstPassItem)
	local itemData = ItemUtil.createItemData({
		itemId = itemId
	})

	itemData:setCount(itemCount)
	table.insert(theTable, {
		itemData = itemData,
		isFirstPassItem = isFirstPassItem
	})
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

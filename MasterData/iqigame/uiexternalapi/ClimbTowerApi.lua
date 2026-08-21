-- chunkname: @IQIGame\\UIExternalApi\\ClimbTowerApi.lua

ClimbTowerApi = BaseLangApi:Extend()

function ClimbTowerApi:FormatStageLevel(stageLevel)
	return string.format("%02d", stageLevel)
end

function ClimbTowerApi:GetLowestNotPassedLevelTips(level)
	return string.format(self:GetCfgText(2100000), level)
end

function ClimbTowerApi:GetAllLevelPassedTips()
	return string.format(self:GetCfgText(2100001))
end

function ClimbTowerApi:GetStageTitleTips(towerName, stageLevel)
	return towerName .. string.format(self:GetCfgText(2100002), stageLevel)
end

function ClimbTowerApi:GetDailyRewardTitleTips()
	return self:GetCfgText(2100003)
end

function ClimbTowerApi:GetDailyRewardExplanationText()
	return CfgHelpTipsTable[2000000].Text
end

function ClimbTowerApi:GetStageDetailTips()
	return self:GetCfgText(2100004)
end

function ClimbTowerApi:GetStageInfoTips()
	return self:GetCfgText(2100005)
end

function ClimbTowerApi:GetDungeonBuffTips()
	return self:GetCfgText(2100006)
end

function ClimbTowerApi:GenerateDungeonBuffDesc(buffList)
	local buffTips = ""

	if getTableLength(buffList) > 0 then
		for i, buffID in pairs(buffList) do
			buffTips = buffTips .. "-" .. CfgBuffTable[buffID].Describe

			if i ~= #buffList then
				buffTips = buffTips .. "\n"
			end
		end
	end

	return buffTips
end

function ClimbTowerApi:GetPassRewardTitleTips()
	return self:GetCfgText(2100007)
end

function ClimbTowerApi:GetLevelPassedTips()
	return string.format(self:GetCfgText(2100008))
end

function ClimbTowerApi:GetMapImagePath()
	return "Assets/05_Images/Chapter/TowerChapter/background.png"
end

function ClimbTowerApi:GetTowerIconImagePath()
	return "Assets/05_Images/Chapter/TowerChapter/background.png"
end

function ClimbTowerApi:GetTowerDetailImagePath()
	return "Assets/05_Images/Chapter/TowerChapter/background.png"
end

function ClimbTowerApi:GetTowerDailyRewardImagePath()
	return "Assets/05_Images/Chapter/TowerChapter/background.png"
end

function ClimbTowerApi:GetTowerDailyRewardExplanationImagePath()
	return "Assets/05_Images/Chapter/TowerChapter/background.png"
end

function ClimbTowerApi:GetDupDetailBgImagePath()
	return "Assets/05_Images/Chapter/TowerChapter/background.png"
end

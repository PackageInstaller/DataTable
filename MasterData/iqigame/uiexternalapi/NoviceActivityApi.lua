-- chunkname: @IQIGame\\UIExternalApi\\NoviceActivityApi.lua

NoviceActivityApi = BaseLangApi:Extend()

function NoviceActivityApi:GetTips_TaskPanel_RewardTopDesc_First()
	return self:GetCfgText(105008)
end

function NoviceActivityApi:GetTips_TaskPanel_RewardTopDesc_Second()
	return self:GetCfgText(105009)
end

function NoviceActivityApi:GetTips_TaskPanel_ExpText()
	return self:GetCfgText(105010)
end

function NoviceActivityApi:GetTips_TaskPanel_TaskDayIndex(dayIndex)
	return self:GetCfgText(9000000 + dayIndex - 1)
end

function NoviceActivityApi:GetTips_SignInPanel_RewardTopDesc()
	return self:GetCfgText(105001)
end

function NoviceActivityApi:GetTips_SignInPanel_7DayRewardTopDesc()
	return self:GetCfgText(105002)
end

function NoviceActivityApi:GetTips_ActivityLeftTime(seconds)
	if seconds > 86400 then
		return DateTimeFormat(seconds, "dd天hh小时", false)
	else
		return DateTimeFormat(seconds, "hh:mm:ss", false)
	end
end

function NoviceActivityApi:GetTips_TabContent_SignInTitle()
	return self:GetCfgText(105004)
end

function NoviceActivityApi:GetTips_TabContent_TaskTitle()
	return self:GetCfgText(105005)
end

function NoviceActivityApi:GetTips_TabContent_LevelRewardTitle()
	return self:GetCfgText(105006)
end

function NoviceActivityApi:GetTips_LevelRewardPanel_AgentLevelTextTips()
	return self:GetCfgText(105012)
end

function NoviceActivityApi:GetTips_LevelRewardPanel_UnfinishedTextTips()
	return self:GetCfgText(105013)
end

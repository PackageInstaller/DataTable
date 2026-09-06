-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/brotherhood/config/BrotherHoodConfig.lua

module("logic.extensions.brotherhood.config.BrotherHoodConfig", package.seeall)

local BrotherHoodConfig = class("BrotherHoodConfig", BaseConfig)

function BrotherHoodConfig:onInit()
	BrotherHoodConfig.super.onInit(self)

	self.brother_hood_activity = nil
	self.brother_hood_fragments = nil
	self.brother_hood_plot = nil
	self.brother_hood_plot_play = nil
	self.brother_hood_progress_reward = nil
	self.brother_hood_physical = nil
end

function BrotherHoodConfig:getNames()
	return {
		"brother_hood_activity",
		"brother_hood_fragments",
		"brother_hood_plot",
		"brother_hood_plot_play",
		"brother_hood_progress_reward",
		"brother_hood_physical"
	}
end

function BrotherHoodConfig:handleConfig(name, content)
	if name == "brother_hood_activity" then
		self.brother_hood_activity = content
	elseif name == "brother_hood_fragments" then
		self.brother_hood_fragments = content
	elseif name == "brother_hood_plot" then
		self.brother_hood_plot = content
	elseif name == "brother_hood_plot_play" then
		self.brother_hood_plot_play = content
	elseif name == "brother_hood_progress_reward" then
		self.brother_hood_progress_reward = content
	elseif name == "brother_hood_physical" then
		self.brother_hood_physical = content
	end
end

function BrotherHoodConfig:getActivityCfg(id)
	return self.brother_hood_activity[id]
end

function BrotherHoodConfig:getFragmentCfgs(plotPlanId)
	local list = TableUtil.toList(self.brother_hood_fragments[plotPlanId])

	table.sort(list, function(a, b)
		return a.fragmentsId < b.fragmentsId
	end)

	return list
end

function BrotherHoodConfig:getFragmentCfg(plotPlanId, fragmentsId)
	if self.brother_hood_fragments[plotPlanId] then
		return self.brother_hood_fragments[plotPlanId][fragmentsId]
	end
end

function BrotherHoodConfig:getPlotList(plotPlanId)
	return self.brother_hood_plot[plotPlanId]
end

function BrotherHoodConfig:getPlotCfg(plotPlanId, groupId)
	if self.brother_hood_plot[plotPlanId] then
		return self.brother_hood_plot[plotPlanId][groupId]
	end
end

function BrotherHoodConfig:getDescByFragmentId(plotPlanId, fragmentsId)
	local list = self:getPlotList(plotPlanId)

	for i, v in ipairs(list) do
		if v.fragmentsId == fragmentsId then
			return v.plot
		end
	end
end

function BrotherHoodConfig:getPlotCfgById(plotPlanId)
	return self.brother_hood_plot_play[plotPlanId]
end

function BrotherHoodConfig:getRewardList(rewardPlanId)
	return self.brother_hood_progress_reward[rewardPlanId]
end

function BrotherHoodConfig:getRewardCfg(rewardPlanId, progress)
	if self.brother_hood_progress_reward[rewardPlanId] then
		return self.brother_hood_progress_reward[rewardPlanId][progress]
	end
end

function BrotherHoodConfig:getPowerCostById(physicalPlan)
	local cfg = self.brother_hood_physical[physicalPlan]

	return cfg.physicalCost or {}
end

BrotherHoodConfig.instance = BrotherHoodConfig.New()

return BrotherHoodConfig

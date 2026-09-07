local BossRushStoryNode = class("BossRushStoryNode", import("model.vo.BaseVO"))

BossRushStoryNode.TRIGGER_TYPE = {
	PT_GOT = 1,
	HIDE_READED = 4,
	STORY_READED = 3,
	SERIES_PASSED = 2
}
BossRushStoryNode.NODE_TYPE = {
	BATTLE = 3,
	LOCATION = 4,
	NORMAL = 1,
	EVENT = 2
}
BossRushStoryNode.REPEATABLE_KEY = "repeatable"

function BossRushStoryNode:bindConfigTable()
	return pg.activity_series_enemy_story
end

function BossRushStoryNode:Ctor(arg_2_1, ...)
	BossRushStoryNode.super.Ctor(self, arg_2_1, ...)

	self.configId = self.id

	return
end

function BossRushStoryNode:GetTriggers()
	local function var_3_0(arg_4_0)
		if type(arg_4_0) ~= "table" then
			return {}
		end

		return arg_4_0
	end

	local var_3_1 = var_3_0(self:getConfig("trigger_type"))
	local var_3_2 = var_3_0(self:getConfig("trigger_value"))
	local var_3_3 = {}

	for iter_3_0 = 1, #var_3_1 do
		table.insert(var_3_3, {
			type = var_3_1[iter_3_0],
			value = var_3_2[iter_3_0]
		})
	end

	return var_3_3
end

function BossRushStoryNode:IsActive(arg_5_1, arg_5_2)
	return underscore.all(self:GetTriggers(), function(arg_6_0)
		return switch(arg_6_0.type, {
			[BossRushStoryNode.TRIGGER_TYPE.PT_GOT] = function()
				return arg_5_2.data1 >= arg_6_0.value
			end,
			[BossRushStoryNode.TRIGGER_TYPE.SERIES_PASSED] = function()
				return BossRushSeriesData.New({
					id = arg_6_0.value,
					actId = arg_5_1.id
				}):IsUnlock(arg_5_1)
			end,
			[BossRushStoryNode.TRIGGER_TYPE.STORY_READED] = function()
				return BossRushStoryNode.New({
					id = arg_6_0.value
				}):IsReaded()
			end,
			[BossRushStoryNode.TRIGGER_TYPE.HIDE_READED] = function()
				return not BossRushStoryNode.New({
					id = arg_6_0.value
				}):IsReaded()
			end
		}, function()
			return false
		end)
	end)
end

function BossRushStoryNode:IsReaded()
	local var_12_0 = self:GetStory()

	if var_12_0 and var_12_0 ~= "" then
		return tobool(pg.NewStoryMgr.GetInstance():IsPlayed(var_12_0))
	else
		return true
	end

	return
end

function BossRushStoryNode:GetType()
	return self:getConfig("type")
end

function BossRushStoryNode:GetName()
	return self:getConfig("name")
end

function BossRushStoryNode:GetIconName()
	return self:getConfig("icon")
end

function BossRushStoryNode:GetStory()
	return self:getConfig("story")
end

function BossRushStoryNode:GetActiveLink()
	return self:getConfig("line")
end

function BossRushStoryNode:GetCleanBG()
	return noEmptyStr(self:getConfig("change_background"))
end

function BossRushStoryNode:GetCleanBGM()
	return noEmptyStr(self:getConfig("change_bgm"))
end

function BossRushStoryNode:GetCleanAnimator()
	return noEmptyStr(self:getConfig("change_prefab"))
end

function BossRushStoryNode:GetParams(arg_21_1)
	local var_21_0 = noEmptyStr(self:getConfig("params"))

	if not var_21_0 then
		return nil
	end

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if iter_21_1[1] == arg_21_1 then
			return iter_21_1
		end
	end

	return nil
end

function BossRushStoryNode:IsRecrew()
	local var_22_0 = self:getConfig("label_key")

	if type(var_22_0) ~= "table" then
		return nil
	end

	local var_22_1 = StoryStep.GetGlobalFlagKey(var_22_0.flagID) .. var_22_0.flagIndex

	if not PlayerPrefs.HasKey(var_22_1) then
		return nil
	end

	return PlayerPrefs.GetInt(var_22_1) > 0
end

return BossRushStoryNode

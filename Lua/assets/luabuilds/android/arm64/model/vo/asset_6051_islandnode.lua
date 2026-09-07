local IslandNode = class("IslandNode", import(".BaseVO"))

function IslandNode:bindConfigTable()
	return pg.activity_map_event_list
end

function IslandNode:Ctor(arg_2_1)
	self.id = arg_2_1.id
	self.configId = arg_2_1.id
	self.eventId = arg_2_1.event_id
	self.isNew = arg_2_1.is_new == 1

	return
end

function IslandNode:IsUnlock()
	self.isUnlock = self.isUnlock or self:GetUnlock()

	return self.isUnlock
end

function IslandNode:GetUnlock()
	local var_4_0 = getProxy(SixthAnniversaryIslandProxy)
	local var_4_1 = self:getConfig("open_need")
	local var_4_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)
	local var_4_3 = var_4_2 and var_4_2:GetTotalBuildingLevel() or 0
	local var_4_4 = {}

	for iter_4_0, iter_4_1 in ipairs(getProxy(ActivityTaskProxy):getFinishTasks()) do
		var_4_4[iter_4_1:GetConfigID()] = true
	end

	return var_4_3 >= var_4_1[1] and underscore.all(var_4_1[2], function(arg_5_0)
		return var_4_0:GetNode(arg_5_0):IsCompleted()
	end) and underscore.all(self:getConfig("open_task"), function(arg_6_0)
		return var_4_4[arg_6_0]
	end)
end

function IslandNode:IsVisual()
	return (self:getConfig("node_status") == 1 or not self:IsCompleted()) and self:IsUnlock() and not self:ChangeVisual()
end

function IslandNode:ChangeVisual()
	local var_8_0 = self:getConfig("node_change")

	return var_8_0 ~= 0 and getProxy(SixthAnniversaryIslandProxy):GetNode(var_8_0):IsUnlock()
end

function IslandNode:IsCompleted()
	return self.eventId == 0
end

function IslandNode:IsNew()
	return not self:IsTreasure() and self.isNew
end

function IslandNode:IsMain()
	return self:getConfig("type") == 1
end

function IslandNode:IsTreasure()
	return self:getConfig("type") == 4
end

function IslandNode:IsRefresh()
	return self:getConfig("refresh") == 1
end

function IslandNode:IsFlowerField()
	return self:getConfig("type") == 5 and self:getConfig("params")[1] == "flowerfield"
end

function IslandNode:GetScale()
	return 0.8
end

function IslandNode:RedDotHint()
	return switch(self:getConfig("type"), {
		[4] = function()
			return false
		end,
		[5] = function()
			IslandNode.markDic = IslandNode.markDic or {
				minigame1 = function(...)
					return getProxy(MiniGameProxy):GetHubByHubId((getProxy(ActivityProxy):getActivityById(ActivityConst.ISLAND_GAME_ID):getConfig("config_id"))).count > 0
				end,
				minigame2 = function(...)
					return IslandNode.markDic.minigame1(...)
				end,
				minigame3 = function(...)
					return IslandNode.markDic.minigame1(...)
				end,
				flowerfield = function()
					return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FLOWER_FIELD)))
				end,
				hotspringtask = function()
					return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2)))
				end
			}

			return switch(self:getConfig("params")[1], IslandNode.markDic, function()
				return false
			end)
		end
	}, function()
		return not self:IsCompleted()
	end)
end

function IslandNode:GetEffectName()
	return switch(self:getConfig("type"), {
		[4] = function()
			return "haidao_baoxiang"
		end
	}, function()
		return ""
	end)
end

function IslandNode:CanTrigger()
	if self:getConfig("type") == 5 then
		return true
	else
		return not self:IsCompleted()
	end

	return
end

function IslandNode:CanToggleOn()
	return switch(self:getConfig("type"), {
		[4] = function()
			return false
		end,
		[5] = function()
			return true
		end
	}, function()
		return not self:IsCompleted()
	end)
end

return IslandNode

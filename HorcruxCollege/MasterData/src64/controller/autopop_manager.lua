local var_0_0 = {}
local network = require("network.network")
local activity_manager = require("controller.activity_manager")
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3

var_0_0.statusAchievement = 2
var_0_0.otherStatus = 2
var_0_0.achievementQueue = {}
var_0_0.otherQueue = {}
var_0_0.objAchievement = nil

function var_0_0:createAchievementPoplayer(arg_1_1)
	if arg_1_1 and next(arg_1_1) ~= nil then
		self:enachievementQueue(arg_1_1)
	end

	if self.statusAchievement ~= var_0_3 then
		-- block empty
	elseif self.achievementQueue and next(self.achievementQueue) ~= nil then
		if not cc.Director:getInstance():getRunningScene():getChildByName("AchievementPoplayer") then
			require("view.Layer.AchievementPopLayer")

			local var_1_0 = AchievementPopLayer:create()

			var_1_0:setName("AchievementPoplayer")
			cc.Director:getInstance():getRunningScene():addChild(var_1_0, 999)

			self.objAchievement = var_1_0
		end
	end
end

function var_0_0:initachievementQueue(arg_2_1)
	for iter_2_0 = 1, #arg_2_1 do
		self.achievementQueue[iter_2_0] = {
			title = arg_2_1[iter_2_0].title,
			content = arg_2_1[iter_2_0].content,
			medal = arg_2_1[iter_2_0].medal
		}
	end
end

function var_0_0:enachievementQueue(arg_3_1)
	if self.achievementQueue and next(self.achievementQueue) ~= nil then
		for iter_3_0 = 1, #arg_3_1 do
			table.insert(self.achievementQueue, {
				title = arg_3_1[iter_3_0].title,
				content = arg_3_1[iter_3_0].content,
				medal = arg_3_1[iter_3_0].medal
			})
		end
	else
		self:initachievementQueue(arg_3_1)
	end
end

function var_0_0:deachievementQueue()
	table.remove(self.achievementQueue, 1)
end

function var_0_0:getachievementQueue()
	return self.achievementQueue
end

function var_0_0:achievementQueueEmpty()
	if next(self.achievementQueue) ~= nil then
		return true
	else
		return false
	end
end

function var_0_0:pauseAchievementPop()
	if self.statusAchievement ~= var_0_4 then
		self.statusAchievement = var_0_4
	end
end

function var_0_0:resumeAchievementPop()
	if self.statusAchievement ~= var_0_3 then
		self.statusAchievement = var_0_3

		self:createAchievementPoplayer()
	end
end

function var_0_0:lockAchievementPop()
	if self.statusAchievement ~= var_0_5 then
		self.statusAchievement = var_0_5
	end
end

function var_0_0:unlockAchievementPop()
	if self.statusAchievement ~= var_0_3 then
		self.statusAchievement = var_0_3

		self:createAchievementPoplayer()
	end
end

function var_0_0:getAchievementStatus()
	return self.statusAchievement
end

local var_0_6 = {
	activitySign = function(self)
		local var_12_0 = self.callback
		local var_12_2

		if not activity_manager:getAlertStatus(self.id, "sign") then
			if self.callback then
				self.callback()
			end

			do return end

			var_12_2 = {
				activityID = self.id
			}
		end

		function var_12_2.callback()
			if self.exitCallback then
				self.exitCallback()
			end

			if var_12_0 then
				var_12_0()
			end
		end

		var_12_2.initType = 1

		if LayerManager:getActiveLayerName() ~= "Fightlayer" then
			require("controller.sign_manager"):createActivitySignLayer(var_12_2)
		end
	end,
	daka = function(self)
		if LayerManager:getActiveLayerName() ~= "Fightlayer" then
			activity_manager:createActivitySignLayer(self.param1, self.param2, {
				returnLayerCallback = self.returnLayerCallback,
				callback = self.callback
			})
		end
	end,
	liuli = function(self)
		if LayerManager:getActiveLayerName() ~= "Fightlayer" then
			activity_manager:createActivitySignLayer(self.param1, self.param2, {
				returnLayerCallback = self.returnLayerCallback,
				callback = self.callback
			})
		end
	end,
	sign = function(self)
		local function var_16_0(arg_17_0)
			local var_17_1, var_17_2 = arg_17_0:find("%d+", (arg_17_0:find(" ")))

			return tonumber((arg_17_0:sub(var_17_1, var_17_2)))
		end

		local var_16_1 = self.callback

		network:rpc("get_sign_time", nil, function(arg_18_0)
			local var_18_0 = var_16_0(arg_18_0.time)

			if arg_18_0.sign_limit == 3 then
				LayerManager:getActiveLayerObj():addChild(SignLayer:create({
					Main = true,
					callback = var_16_1
				}))
			elseif arg_18_0.sign_limit == 2 then
				if var_18_0 < 12 and var_18_0 >= 0 then
					if var_16_1 then
						var_16_1()
					end

					print("不可签到")
				elseif arg_18_0.sign_time[1] < 18 and var_18_0 >= 18 or arg_18_0.sign_time[1] < 12 then
					LayerManager:getActiveLayerObj():addChild(SignLayer:create({
						Main = true,
						callback = var_16_1
					}))
				else
					if var_16_1 then
						var_16_1()
					end

					print("不可签到")
				end
			elseif arg_18_0.sign_limit == 1 then
				if var_18_0 < 18 and var_18_0 >= 0 then
					if var_16_1 then
						var_16_1()
					end

					print("不可签到")
				elseif arg_18_0.sign_time[1] >= 18 or arg_18_0.sign_time[2] >= 18 then
					if var_16_1 then
						var_16_1()
					end

					print("不可签到")
				else
					LayerManager:getActiveLayerObj():addChild(SignLayer:create({
						Main = true,
						callback = var_16_1
					}))
				end
			else
				if var_16_1 then
					var_16_1()
				end

				print("不可签到")
			end
		end)
	end,
	tips = function(arg_19_0)
		return
	end,
	notice = function(self)
		local var_20_0 = self.callback

		network:rpc("get_notice_id", nil, function(arg_21_0)
			if arg_21_0.result == 1 then
				print("create Notice Layer!!!!")

				if global_basic_scene then
					LayerManager:pushInLayer("PublishnoticeLayer", arg_21_0.notice_tbl, 1, var_20_0)
				end
			else
				print("unknow error")

				if var_20_0 then
					var_20_0()
				end
			end
		end)
	end
}

function var_0_0:createOtherPopLayer(arg_22_1)
	if arg_22_1 and next(arg_22_1) ~= nil then
		self:enotherQueue(arg_22_1)
	end

	if self.otherStatus ~= var_0_3 then
		-- block empty
	else
		if self:otherQueueEmpty() == false then
			return
		end

		local var_22_0 = self:getotherQueueHead()

		var_22_0.initPara = var_22_0.initPara or {}

		function var_22_0.initPara.callback()
			self:deotherQueue()
		end

		local var_22_1 = cc.Node:create()

		global_basic_scene:addChild(var_22_1)

		if LayerManager:getActiveLayerName() ~= "Fightlayer" then
			var_22_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
				var_0_6[var_22_0.layerType](var_22_0.initPara)
			end), cc.CallFunc:create(function()
				var_22_1:removeFromParent()
			end)))
		end
	end
end

function var_0_0.initotherQueue(arg_26_0, arg_26_1)
	arg_26_0.otherQueue = arg_26_1
end

function var_0_0:enotherQueue(arg_27_1)
	if self.otherQueue and next(self.otherQueue) ~= nil then
		for iter_27_0 = 1, #arg_27_1 do
			table.insert(self.otherQueue, arg_27_1[iter_27_0])
		end
	else
		self:initotherQueue(arg_27_1)
	end
end

function var_0_0:deotherQueue()
	table.remove(self.otherQueue, 1)
	self:createOtherPopLayer()
end

function var_0_0.getotherQueue(arg_29_0)
	return
end

function var_0_0:getotherQueueHead()
	return self.otherQueue[1]
end

function var_0_0:otherQueueEmpty()
	if self.otherQueue and next(self.otherQueue) ~= nil then
		return true
	else
		return false
	end
end

function var_0_0.pauseOtherPop(arg_32_0)
	arg_32_0.otherStatus = var_0_4
end

function var_0_0.resumeOtherPop(arg_33_0)
	arg_33_0.otherStatus = var_0_3

	cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("AUTO_POP_EVENT")))
end

function var_0_0:getOhterStatus()
	return self.otherStatus
end

function var_0_0.cleanOtherPop(arg_35_0)
	arg_35_0.otherQueue = {}
end

function var_0_0.lockAll(arg_36_0)
	return
end

function var_0_0.unlockAll(arg_37_0)
	return
end

function var_0_0:pushbackGetNewRole(arg_38_1)
	self.getNewRoleQueue = self.getNewRoleQueue or {}

	table.insert(self.getNewRoleQueue, arg_38_1)
end

function var_0_0:getNewRoleQueueIsEmpty()
	if not self.getNewRoleQueue then
		return true
	end

	return #self.getNewRoleQueue == 0
end

function var_0_0:popGetNewRoleQueue(arg_40_1)
	if not self.getNewRoleQueue or not next(self.getNewRoleQueue) then
		return
	end

	local var_40_0 = self.getNewRoleQueue[1]

	table.remove(self.getNewRoleQueue, 1)
	require("view.Layer.GetRoleAnimationLayer")

	local var_40_1 = GetRoleAnimationLayer:create(var_40_0, arg_40_1)

	if not var_40_1:getParent() then
		global_basic_scene:addChild(var_40_1, 999)
	end

	self.getNewRoleQueue = {}
end

setmetatable(var_0_0, {
	__index = require("controller.autopop_manager_ext")
})

return var_0_0

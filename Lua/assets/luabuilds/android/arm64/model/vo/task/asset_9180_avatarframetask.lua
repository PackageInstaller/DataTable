local AvatarFrameTask = class("AvatarFrameTask", import(".Task"))

AvatarFrameTask.type_task_level = "task_level"
AvatarFrameTask.type_task_ship = "task_ship"
AvatarFrameTask.fillter_task_type = {
	AvatarFrameTask.type_task_level,
	AvatarFrameTask.type_task_ship
}

local var_0_1 = AvatarFrameTask.fillter_task_type
local var_0_3 = {
	"avatar_upgrad_1",
	"avatar_upgrad_2",
	"avatar_upgrad_3"
}
local var_0_4 = "avatar_task_ship_1"
local var_0_5 = "avatar_task_ship_2"

function AvatarFrameTask:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._actId = arg_1_1
	self.configId = arg_1_2
	self.id = arg_1_3.id
	self.progress = arg_1_3.progress or 0
	self.acceptTime = arg_1_3.accept_time or 0
	self.submitTime = arg_1_3.submit_time or 0

	return
end

function AvatarFrameTask:IsActEnd()
	local var_2_0 = getProxy(ActivityProxy):getActivityById(pg.activity_event_avatarframe[self.configId].link_event)

	return not var_2_0 or var_2_0:isEnd()
end

function AvatarFrameTask:updateProgress(arg_3_1)
	self.progress = arg_3_1 or 0

	return
end

function AvatarFrameTask:isFinish()
	return self:getProgress() >= self:getConfig("target_num")
end

function AvatarFrameTask:getProgress()
	return self.progress or 0
end

function AvatarFrameTask:isReceive()
	return false
end

function AvatarFrameTask:getTaskStatus()
	if self.progress >= self:getConfig("target_num") then
		return 1
	end

	return 0
end

function AvatarFrameTask:onAdded()
	return
end

function AvatarFrameTask:setTaskFinish()
	self.submitTime = 1

	self:updateProgress(self:getConfig("target_num"))

	return
end

function AvatarFrameTask:updateProgress(arg_10_1)
	self.progress = arg_10_1

	return
end

function AvatarFrameTask:isSelectable()
	return false
end

function AvatarFrameTask:judgeOverflow(arg_12_1, arg_12_2, arg_12_3)
	return false, false
end

function AvatarFrameTask:IsUrTask()
	return false
end

function AvatarFrameTask:GetRealType()
	return 6
end

function AvatarFrameTask:IsOverflowShipExpItem()
	return false
end

function AvatarFrameTask:ShowOnTaskScene()
	return true
end

function AvatarFrameTask:getConfig(arg_17_1)
	if not self.configData then
		if not pg.activity_event_avatarframe[self.configId] then
			print("avatart id = " .. self.configId .. " is not found")

			return
		end

		local var_17_0 = self:getTypeData(pg.activity_event_avatarframe[self.configId], self.id)

		if not var_17_0 then
			return
		end

		local var_17_1 = Clone(pg.activity_event_avatarframe[self.configId].award_display)

		var_17_1[1][3] = var_17_0.award_num
		self.configData = {
			sub_type = 0,
			level = 1,
			item_id = pg.activity_event_avatarframe[self.configId].pt_id,
			desc = var_17_0.desc,
			target_num = var_17_0.target_num,
			award_num = var_17_0.award_num,
			scene = var_17_0.scene,
			award_display = var_17_1
		}
	end

	return self.configData[arg_17_1]
end

function AvatarFrameTask:getTypeData(arg_18_1, arg_18_2)
	for iter_18_0 = 1, #var_0_1 do
		for iter_18_1, iter_18_2 in ipairs(arg_18_1[var_0_1[iter_18_0]]) do
			if iter_18_2[1] == arg_18_2 then
				self.avatarType = var_0_1[iter_18_0]

				return self:createData(var_0_1[iter_18_0], iter_18_2)
			end
		end
	end

	return
end

function AvatarFrameTask:isAvatarTask()
	return true
end

function AvatarFrameTask:getActId()
	return self._actId
end

function AvatarFrameTask:createData(arg_21_1, arg_21_2)
	local var_21_0

	if arg_21_1 == AvatarFrameTask.type_task_level then
		local var_21_1, var_21_2, var_21_3, var_21_4, var_21_5, var_21_6 = unpack(arg_21_2)
		local var_21_7 = ""

		if var_21_3 > 0 and var_21_3 <= #var_0_3 then
			var_21_7 = pg.gametip[var_0_3[var_21_3]].tip
		end

		local var_21_8 = pg.ship_data_statistics[var_21_2 * 10 + 1].name
		local var_21_9
		local var_21_10

		for iter_21_0, iter_21_1 in ipairs(var_21_4) do
			assert(pg.chapter_template[iter_21_1] ~= nil, "找不到chapterid = " .. iter_21_1)

			var_21_10 = var_21_10 or {
				"ACTIVITY_MAP",
				{
					pg.chapter_template[iter_21_1].act_id
				}
			}
			var_21_9 = not var_21_9 and pg.chapter_template[iter_21_1].chapter_name or var_21_9 .. "," .. pg.chapter_template[iter_21_1].chapter_name
		end

		var_21_0 = {
			target_num = var_21_5,
			award_num = var_21_6,
			scene = var_21_10,
			desc = i18n("avatar_task_level", var_21_7, var_21_8, var_21_9, var_21_5)
		}
	elseif arg_21_1 == AvatarFrameTask.type_task_ship then
		local var_21_11, var_21_12, var_21_13, var_21_14 = unpack(arg_21_2)
		local var_21_15 = ShipGroup.getDefaultShipNameByGroupID(var_21_12)

		if var_21_13 == 1 then
			var_21_0 = {
				award_num = var_21_14,
				desc = i18n(var_0_4, var_21_15)
			}
		elseif var_21_13 == 2 then
			var_21_0 = {
				award_num = var_21_14,
				desc = i18n(var_0_5, var_21_15),
				scene = {
					"DOCKYARD",
					{
						mode = "overview"
					}
				}
			}
		end
	end

	return setmetatable(var_21_0, {
		__index = {
			award_num = 1,
			target_num = 1,
			desc = ""
		}
	})
end

return AvatarFrameTask

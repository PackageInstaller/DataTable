local Instagram3Dorm = class("Instagram3Dorm", import("...BaseVO"))

Instagram3Dorm.OP_DISCUSS = 2
Instagram3Dorm.OP_READ = 3
Instagram3Dorm.OP_LIKE = 4
Instagram3Dorm.OP_SHARE = 5
Instagram3Dorm.OP_EXIT = 6

function Instagram3Dorm:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1.id
	self.configId = arg_1_1.id
	self.time = arg_1_1.time or 0
	self.isRead = defaultValue(arg_1_1.read_flag, 0) == 1
	self.isGood = defaultValue(arg_1_1.good_flag, 0) == 1
	self.isLock = defaultValue(arg_1_2, true)
	self.exitTime = arg_1_1.exit_time or 0

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.reply_list or {}) do
		var_1_0[iter_1_1.key] = var_1_0[iter_1_1.key] or {}

		table.insert(var_1_0[iter_1_1.key], {
			index = iter_1_1.value,
			time = iter_1_1.time
		})
	end

	self.replyedList = self:BuildReplyedList(var_1_0)
	self.replyableList = self:BuildReplyableList(var_1_0)
	self.unlockDesc = self.isLock and self:BuildUnlockDesc() or ""

	return
end

function Instagram3Dorm:BuildUnlockDesc()
	local var_2_1 = _.detect(pg.dorm3d_ins_unlock.get_id_list_by_type[Dorm3dInsProxy.UNLOCK_TYPE_INS] or {}, function(arg_3_0)
		return pg.dorm3d_ins_unlock[arg_3_0].content == self.configId
	end)

	if not var_2_1 then
		return ""
	end

	return (HXSet.hxLan(pg.dorm3d_ins_unlock[var_2_1].text))
end

function Instagram3Dorm:GetUnLockConditionDesc()
	return self.unlockDesc
end

function Instagram3Dorm:IsLock()
	return self.isLock
end

function Instagram3Dorm:Unlock(arg_6_1)
	self.isLock = false
	self.time = arg_6_1

	return
end

function Instagram3Dorm:GetReplyedList()
	return self.replyedList
end

function Instagram3Dorm:ExistAnyReplyable()
	return #self.replyableList > 0
end

function Instagram3Dorm:GetReplyableList()
	return self.replyableList
end

function Instagram3Dorm:MarkReply(arg_10_1, arg_10_2)
	for iter_10_0 = #self.replyableList, 1, -1 do
		if self.replyableList[iter_10_0].id == arg_10_1 then
			table.remove(self.replyableList, iter_10_0)
		end
	end

	table.insert(self.replyedList, (self:BuildPlayerComment(arg_10_1, arg_10_2, (pg.TimeMgr.GetInstance():GetServerTime()))))

	return
end

function Instagram3Dorm:BuildPlayerComment(arg_11_1, arg_11_2, arg_11_3)
	return InstagramPlayerComment3Dorm.New(arg_11_1, arg_11_2, 10000, pg.dorm3d_ins_player_template[arg_11_1].message[arg_11_2], arg_11_3, {
		pg.dorm3d_ins_player_template[arg_11_1].npc_reply[arg_11_2]
	})
end

function Instagram3Dorm:BuildReplyedList(arg_12_1)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		for iter_12_2, iter_12_3 in ipairs(iter_12_1) do
			table.insert(var_12_0, (self:BuildPlayerComment(iter_12_0, iter_12_3.index, iter_12_3.time)))
		end
	end

	for iter_12_4, iter_12_5 in ipairs((InstagramComment3Dorm.BuildNpcReplayList(self:getConfig("npc_discuss"), self.time))) do
		table.insert(var_12_0, iter_12_5)
	end

	return var_12_0
end

function Instagram3Dorm:BuildReplyableList(arg_13_1)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(self:getConfig("discuss")) do
		if not arg_13_1[iter_13_1] then
			for iter_13_2, iter_13_3 in ipairs(pg.dorm3d_ins_player_template[iter_13_1].message) do
				table.insert(var_13_0, (self:BuildPlayerComment(iter_13_1, iter_13_2, (pg.TimeMgr.GetInstance():GetServerTime()))))
			end
		end
	end

	return var_13_0
end

function Instagram3Dorm:bindConfigTable()
	return pg.dorm3d_ins_template
end

function Instagram3Dorm:GetBackground()
	return self:getConfig("background")
end

function Instagram3Dorm:IsRead()
	return self.isRead
end

function Instagram3Dorm:IsGood()
	return self.isGood
end

function Instagram3Dorm:GetText()
	return (HXSet.hxLan(pg.dorm3d_ins_language[self:getConfig("message")].value))
end

function Instagram3Dorm:GetPicture()
	return self:getConfig("picture")
end

function Instagram3Dorm:GetName()
	return self:getConfig("name")
end

function Instagram3Dorm:GetIcon()
	return self:getConfig("sculpture")
end

function Instagram3Dorm:GetPushTime()
	return InstagramTimeStamp(self.time)
end

function Instagram3Dorm:LockState()
	return self.isLock and 0 or 1
end

function Instagram3Dorm:MarkRead()
	self.isRead = true

	return
end

function Instagram3Dorm:MarkLike()
	self.isGood = true

	return
end

function Instagram3Dorm:CanShow()
	return true
end

function Instagram3Dorm:SetExitTime(arg_27_1)
	self.exitTime = arg_27_1

	return
end

function Instagram3Dorm:ShouldTip()
	if self:IsLock() or not self:CanShow() then
		return false
	end

	if not self:IsRead() then
		return true
	end

	if _.any(self.replyedList, function(arg_29_0)
		return arg_29_0:CanShow() and arg_29_0:ShouldTip(self.exitTime)
	end) then
		return true
	end

	return false
end

return Instagram3Dorm

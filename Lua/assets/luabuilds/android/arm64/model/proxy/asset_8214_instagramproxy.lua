local InstagramProxy = class("InstagramProxy", import(".NetProxy"))
local var_0_1 = pg.activity_ins_language
local var_0_2 = pg.activity_ins_npc_template

function InstagramProxy:register()
	self.messages = {}
	self.officialAccounts = {}
	self.isReqNewInstagramData = false
	self.isReqOldInstagramData = false
	self.allReply = {}

	local function var_1_0(arg_2_0)
		local var_2_0 = arg_2_0.npc_reply_persist

		if type(arg_2_0.npc_reply_persist) == "string" then
			var_2_0 = {}
		end

		local var_2_1 = ""
		local var_2_2 = pg.TimeMgr.GetInstance():GetServerTime()

		if var_0_1[arg_2_0.message_persist] then
			var_2_1 = var_0_1[arg_2_0.message_persist].value
			var_2_2 = pg.TimeMgr.GetInstance():parseTimeFromConfig(arg_2_0.time_persist)
		end

		return {
			id = arg_2_0.id,
			time = var_2_2,
			text = var_2_1,
			npc_reply = var_2_0
		}
	end

	for iter_1_0, iter_1_1 in ipairs(var_0_2.all) do
		self.allReply[iter_1_1] = var_1_0(var_0_2[iter_1_1])
	end

	return
end

function InstagramProxy:IsReqOldInstagramData()
	return self.isReqOldInstagramData
end

function InstagramProxy:MarkOldInstagramData()
	self.isReqOldInstagramData = true

	return
end

function InstagramProxy:IsReqNewInstagramData()
	return self.isReqNewInstagramData
end

function InstagramProxy:MarkNewInstagramData()
	self.isReqNewInstagramData = true

	self:AddInstagramTimer()

	return
end

function InstagramProxy:AddInstagram(arg_7_1)
	if arg_7_1:getConfig("type") == InstagramConst.INSTAGRAM_TYPE.OFFICIAL_ACCOUNT then
		self:AddOfficialAccounts(arg_7_1)
	else
		self.messages[arg_7_1.id] = arg_7_1
	end

	return
end

function InstagramProxy:GetAllReply()
	return self.allReply
end

function InstagramProxy:GetMessages()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self.messages) do
		table.insert(var_9_0, iter_9_1)
	end

	return var_9_0
end

function InstagramProxy:ExistMessage()
	return table.getCount(self.messages) > 0
end

function InstagramProxy:GetData()
	return self.messages
end

function InstagramProxy:GetMessageById(arg_12_1)
	return self.messages[arg_12_1]
end

function InstagramProxy:UpdateMessage(arg_13_1)
	if arg_13_1:getConfig("type") == InstagramConst.INSTAGRAM_TYPE.OFFICIAL_ACCOUNT then
		self:UpdateOfficialAccounts(arg_13_1)
	elseif not self.messages[arg_13_1.id] then
		self:AddInstagram(arg_13_1)
	else
		self.messages[arg_13_1.id] = arg_13_1
	end

	return
end

function InstagramProxy:AddOfficialAccounts(arg_14_1)
	self.officialAccounts[arg_14_1.id] = arg_14_1

	return
end

function InstagramProxy:UpdateOfficialAccounts(arg_15_1)
	if not self.officialAccounts[arg_15_1.id] then
		self:AddOfficialAccounts(arg_15_1)
	else
		self.officialAccounts[arg_15_1.id] = arg_15_1
	end

	return
end

function InstagramProxy:GetOfficialAccounts()
	return self.officialAccounts
end

function InstagramProxy:ShouldShowOfficialAccountsTip()
	for iter_17_0, iter_17_1 in pairs(self.officialAccounts) do
		if iter_17_1:ShouldShowTip() then
			return true
		end
	end

	return
end

function InstagramProxy:ShouldShowTip()
	return _.any(self:GetMessages(), function(arg_19_0)
		return arg_19_0:ShouldShowTip()
	end)
end

function InstagramProxy.GetNewInstagramIds()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(pg.activity_ins_template.all) do
		if pg.activity_ins_template[iter_20_1].is_active == 1 or pg.activity_ins_template[iter_20_1].type == InstagramConst.INSTAGRAM_TYPE.OFFICIAL_ACCOUNT then
			table.insert(var_20_0, iter_20_1)
		end
	end

	return var_20_0
end

function InstagramProxy.GetOldInstagramIds()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(pg.activity_ins_template.all) do
		if pg.activity_ins_template[iter_21_1].is_active == 0 then
			table.insert(var_21_0, iter_21_1)
		end
	end

	return var_21_0
end

function InstagramProxy:GetNextPushTime()
	local var_22_0

	for iter_22_0, iter_22_1 in ipairs(pg.activity_ins_template.all) do
		local var_22_2

		if pg.activity_ins_template[iter_22_1].type == InstagramConst.INSTAGRAM_TYPE.OFFICIAL_ACCOUNT then
			if self.officialAccounts[iter_22_1] == nil then
				local var_22_1 = pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.activity_ins_template[iter_22_1].time)

				if var_22_0 == nil then
					var_22_0 = var_22_1
					var_22_2 = iter_22_1
				elseif var_22_1 < var_22_0 then
					var_22_0 = var_22_1
					var_22_2 = iter_22_1
				end
			end
		elseif pg.activity_ins_template[iter_22_1].is_active == 1 and self:GetMessageById(iter_22_1) == nil then
			local var_22_3 = pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.activity_ins_template[iter_22_1].time)

			if var_22_0 == nil then
				var_22_0 = var_22_3
				var_22_2 = iter_22_1
			elseif var_22_3 < var_22_0 then
				var_22_0 = var_22_3
				var_22_2 = iter_22_1
			end
		end
	end

	return var_22_0, nil
end

function InstagramProxy:AddInstagramTimer()
	self:RemoveInstagramTimer()

	local var_23_0, var_23_1 = self:GetNextPushTime()

	if not var_23_0 then
		return
	end

	local var_23_2 = var_23_0 - pg.TimeMgr.GetInstance():GetServerTime() + math.Random(1, 3)

	local function var_23_3()
		pg.m02:sendNotification(GAME.ACT_INSTAGRAM_OP, {
			cmd = ActivityConst.INSTAGRAM_OP_ACTIVE,
			arg1 = var_23_1
		})

		return
	end

	if var_23_2 <= 0 then
		var_23_3()

		return
	end

	self:RemoveInstagramTimer()

	self.timer = Timer.New(function()
		self:RemoveInstagramTimer()
		var_23_3()

		return
	end, var_23_2, 1)

	self.timer:Start()

	return
end

function InstagramProxy:RemoveInstagramTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function InstagramProxy:remove()
	self.isReqNewInstagramData = false

	self:RemoveInstagramTimer()

	return
end

return InstagramProxy

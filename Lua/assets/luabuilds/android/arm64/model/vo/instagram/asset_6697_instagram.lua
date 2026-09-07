local Instagram = class("Instagram", import("..BaseVO"))

Instagram.TYPE_PLAYER_COMMENT = 1
Instagram.TYPE_NPC_COMMENT = 2

local var_0_1 = pg.activity_ins_language

function Instagram:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id

	if self:getConfig("is_active") == 1 then
		self:InitByServer(arg_1_1)
	else
		self:InitByConfig(arg_1_1)
	end

	self.good = arg_1_1.good
	self.isLike = arg_1_1.is_good == 1
	self.isRead = arg_1_1.is_read == 1

	return
end

function Instagram:InitByServer(arg_2_1)
	self.text = arg_2_1.text
	self.picture = arg_2_1.picture
	self.time = arg_2_1.time
	self.oaListPic = arg_2_1.oalist_pic
	self.optionDiscuss = {}
	self.discussList = {}
	self.allReply = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.npc_reply) do
		local var_2_0 = {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.npc_reply) do
			table.insert(var_2_0, iter_2_3)
		end

		self.allReply[iter_2_1.id] = {
			id = iter_2_1.id,
			time = iter_2_1.time,
			text = iter_2_1.text,
			npc_reply = var_2_0
		}
	end

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.player_discuss) do
		if iter_2_5.text == "" then
			for iter_2_6, iter_2_7 in ipairs(iter_2_5.text_list) do
				table.insert(self.optionDiscuss, 1, {
					id = iter_2_5.id,
					index = iter_2_6,
					text = iter_2_7
				})
			end
		else
			table.insert(self.discussList, InstagramPlayerComment.New(iter_2_5, self, 1))
		end
	end

	for iter_2_8, iter_2_9 in ipairs(arg_2_1.npc_discuss) do
		table.insert(self.discussList, InstagramNpcComment.New(iter_2_9, self, 1))
	end

	return
end

function Instagram:InitByConfig(arg_3_1)
	local var_3_0 = self:getConfig("message_persist")

	assert(var_0_1[var_3_0], var_3_0)

	self.text = var_0_1[var_3_0].value
	self.picture = self:getConfig("picture_persist")
	self.time = pg.TimeMgr.GetInstance():parseTimeFromConfig(self:getConfig("time_persist"))
	self.oaListPic = self:getConfig("oalist_pic_persist")
	self.optionDiscuss = {}
	self.discussList = {}
	self.allReply = getProxy(InstagramProxy):GetAllReply()

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.player_discuss) do
		if iter_3_1.text == "" then
			for iter_3_2, iter_3_3 in ipairs(iter_3_1.text_list) do
				table.insert(self.optionDiscuss, 1, {
					id = iter_3_1.id,
					index = iter_3_2,
					text = iter_3_3
				})
			end
		else
			table.insert(self.discussList, InstagramPlayerComment.New(iter_3_1, self, 1))
		end
	end

	local var_3_1 = self:getConfig("npc_discuss_persist")

	if type(var_3_1) == "table" then
		for iter_3_4, iter_3_5 in ipairs(var_3_1) do
			table.insert(self.discussList, InstagramNpcComment.New(self.allReply[iter_3_5], self, 1))
		end
	end

	return
end

function Instagram:GetLasterUpdateTime()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(self.discussList) do
		table.insert(var_4_0, (iter_4_1:GetLasterUpdateTime()))
	end

	table.sort(var_4_0, function(arg_5_0, arg_5_1)
		return arg_5_1 < arg_5_0
	end)

	return var_4_0[1] or 0
end

function Instagram:AnyCommentUnread()
	return _.any(self.discussList, function(arg_7_0)
		return arg_7_0:AnyReplyTimeOut()
	end)
end

function Instagram:GetAllReply()
	return self.allReply
end

function Instagram:IsReaded()
	return self.isRead
end

function Instagram:bindConfigTable()
	return pg.activity_ins_template
end

function Instagram:GetIcon()
	return self:getConfig("sculpture")
end

function Instagram:GetName()
	return self:getConfig("name")
end

function Instagram:GetSortIndex()
	local var_13_0 = self:bindConfigTable()

	if var_13_0[var_13_0.all[1]].order then
		return self:getConfig("order")
	else
		return 0
	end

	return
end

function Instagram:GetImage()
	return self.picture
end

function Instagram:GetContent()
	return HXSet.hxLan(self.text)
end

function Instagram:GetLikeCnt()
	if self.good > 999 then
		return "999+"
	else
		return self.good
	end

	return
end

function Instagram:IsLiking()
	return self.isLike
end

function Instagram:UpdateIsLike()
	self.isLike = 1

	return
end

function Instagram:GetPushTime()
	return InstagramTimeStamp(self.time)
end

function Instagram:GetCanDisplayComments()
	local var_20_0 = {}
	local var_20_1 = 0

	for iter_20_0, iter_20_1 in ipairs(self.discussList) do
		if not iter_20_1:ShouldWaitForShow() then
			table.insert(var_20_0, iter_20_1)

			var_20_1 = var_20_1 + 1
		end
	end

	return var_20_0, var_20_1
end

function Instagram:GetFastestRefreshTime()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(self.discussList) do
		local var_21_1 = iter_21_1:GetFasterRefreshTime()

		if var_21_1 then
			table.insert(var_21_0, var_21_1)
		end
	end

	if #var_21_0 > 0 then
		table.sort(var_21_0, function(arg_22_0, arg_22_1)
			return arg_22_0 < arg_22_1
		end)

		return var_21_0[1]
	end

	return
end

function Instagram:GetOptionComment()
	return self.optionDiscuss
end

function Instagram:CanOpenComment()
	return #self.optionDiscuss > 0
end

function Instagram:ShouldShowTip()
	return not self:IsReaded() or self:AnyCommentUnread()
end

return Instagram

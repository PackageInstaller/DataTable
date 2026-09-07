local InstagramComment = class("InstagramComment", import("..BaseVO"))

function InstagramComment:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.time = arg_1_1.time
	self.text = arg_1_1.text
	self.instagram = arg_1_2
	self.parentComment = arg_1_4
	self.id = arg_1_1.id
	self.level = arg_1_3 or 1
	self.isRoot = false

	if not self.parentComment then
		self.isRoot = true
	end

	self.allReply = arg_1_2:GetAllReply()
	self.replyList = {}

	return
end

function InstagramComment:GetLasterUpdateTime()
	local var_2_0 = {}

	local function var_2_1(arg_3_0)
		if arg_3_0 <= pg.TimeMgr.GetInstance():GetServerTime() then
			table.insert(var_2_0, arg_3_0)
		end

		return
	end

	var_2_1(self.time)

	for iter_2_0, iter_2_1 in pairs((self:GetAllReplys())) do
		var_2_1(iter_2_1.time)
	end

	table.sort(var_2_0, function(arg_4_0, arg_4_1)
		return arg_4_1 < arg_4_0
	end)

	return var_2_0[1] or 0
end

function InstagramComment:GetName()
	assert(false)

	return
end

function InstagramComment:GetPainting()
	assert(false)

	return
end

function InstagramComment:GetType()
	assert(false)

	return
end

function InstagramComment:GetFasterRefreshTime()
	local var_8_0 = {}

	if self:ShouldWaitForShow() then
		table.insert(var_8_0, self.time)
	end

	for iter_8_0, iter_8_1 in ipairs((self:GetAllReplys())) do
		if iter_8_1:ShouldWaitForShow() then
			table.insert(var_8_0, iter_8_1.time)
		end
	end

	if #var_8_0 > 0 then
		table.sort(var_8_0, function(arg_9_0, arg_9_1)
			return arg_9_0 < arg_9_1
		end)

		return var_8_0[1]
	end

	return
end

function InstagramComment:AnyReplyTimeOut()
	return _.any(self:GetAllReplys(), function(arg_11_0)
		return arg_11_0:TimeOutAndTxtIsEmpty()
	end) or self:TimeOutAndTxtIsEmpty()
end

function InstagramComment:TimeOutAndTxtIsEmpty()
	return pg.TimeMgr.GetInstance():GetServerTime() >= self.time and self.text == ""
end

function InstagramComment:ShouldWaitForShow()
	return pg.TimeMgr.GetInstance():GetServerTime() < self.time or self:TimeOutAndTxtIsEmpty()
end

function InstagramComment:GetReplyTimeOffset()
	return self.time - pg.TimeMgr.GetInstance():GetServerTime()
end

function InstagramComment:GetReplyList()
	return self.replyList
end

function InstagramComment:GetAllReplys()
	local var_16_0 = {}

	local function var_16_2(arg_17_0)
		for iter_17_0, iter_17_1 in ipairs(arg_17_0) do
			var_16_2(iter_17_1.replyList)
			table.insert(var_16_0, iter_17_1)
		end

		return
	end

	;(nil)(self.replyList)

	return var_16_0
end

function InstagramComment:GetCanDisplayReply()
	local var_18_0 = {}
	local var_18_1 = 0

	for iter_18_0, iter_18_1 in ipairs((self:GetAllReplys())) do
		if not iter_18_1:ShouldWaitForShow() then
			table.insert(var_18_0, iter_18_1)

			var_18_1 = var_18_1 + 1
		end
	end

	return var_18_0, var_18_1
end

function InstagramComment:GetParentCommentName()
	return self.parentComment:GetName()
end

function InstagramComment:HasReply()
	local var_20_0 = self:GetAllReplys()

	return _.any(var_20_0, function(arg_21_0)
		return not arg_21_0:ShouldWaitForShow()
	end) and #var_20_0 > 0
end

function InstagramComment:GetContent()
	local var_22_0 = self:GetName()

	if self.isRoot then
		return string.format("<color=#000000FF>%s.</color>%s", var_22_0, self.text)
	else
		local var_22_1 = self:GetParentCommentName()

		return string.format("<color=#000000FF>%s.</color>%s", var_22_0, self.text)
	end

	return
end

function InstagramComment:GetReplyCnt()
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in ipairs((self:GetAllReplys())) do
		if not iter_23_1:ShouldWaitForShow() then
			var_23_0 = var_23_0 + 1
		end
	end

	return var_23_0
end

function InstagramComment:GetTime()
	return InstagramReplyTimeStamp(self.time) .. " reply"
end

function InstagramComment:GetIcon()
	return self:GetPainting()
end

function InstagramComment:GetReplyBtnTxt()
	return "reply"
end

return InstagramComment

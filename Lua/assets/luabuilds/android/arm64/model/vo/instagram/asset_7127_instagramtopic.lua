local InstagramTopic = class("InstagramTopic", import("..BaseVO"))
local var_0_1 = pg.activity_ins_chat_language

function InstagramTopic:Ctor(arg_1_1, arg_1_2)
	self.topicConfig = arg_1_1
	self.topicId = arg_1_1.id
	self.characterId = arg_1_1.ship_group
	self.name = arg_1_1.name
	self.unlockDesc = arg_1_1.unlock_desc
	self.triggerType = arg_1_1.trigger_type
	self.triggerParam = arg_1_1.trigger_param
	self.content = arg_1_1.content

	self:SetWordList()

	self.operationTime = nil
	self.readFlag = 1
	self.replyList = nil

	if arg_1_2 then
		self.active = true
		self.operationTime = arg_1_2.op_time
		self.readFlag = arg_1_2.read_flag
		self.replyList = arg_1_2.reply_list

		self:SetDisplayWordList()
	else
		self.active = false
	end

	self.isII = arg_1_1.group_ii ~= 0

	return
end

function InstagramTopic:SetWordList()
	self.wordList = {}

	for iter_2_0, iter_2_1 in ipairs(self.content) do
		table.insert(self.wordList, var_0_1[iter_2_1])
	end

	return
end

function InstagramTopic:SetDisplayWordList()
	self.displayWordList = {}
	self.replyValues = {}

	if self.replyList ~= nil and #self.replyList > 0 then
		local var_3_0 = self.replyList[#self.replyList].key

		for iter_3_0, iter_3_1 in ipairs(self.replyList) do
			table.insert(self.replyValues, iter_3_1.value)
		end

		for iter_3_2, iter_3_3 in ipairs(self.wordList) do
			if iter_3_3.flag == 0 or _.contains(self.replyValues, iter_3_3.flag) then
				table.insert(self.displayWordList, iter_3_3)
			end

			if (iter_3_3.flag == 0 or _.contains(self.replyValues, iter_3_3.flag)) and iter_3_3.option ~= "" and ((iter_3_3.id == var_3_0 or nil) and iter_3_2) < iter_3_2 then
				break
			end
		end
	else
		for iter_3_4, iter_3_5 in ipairs(self.wordList) do
			table.insert(self.displayWordList, iter_3_5)

			if iter_3_5.option ~= "" then
				break
			end
		end
	end

	return
end

function InstagramTopic:GetDisplayWordList()
	return self.displayWordList
end

function InstagramTopic:GetLatestCharacterWord()
	local var_5_0
	local var_5_1 = ""

	for iter_5_0 = #self.displayWordList, 1, -1 do
		if self.displayWordList[iter_5_0].ship_group ~= 0 or self:IsCompleted() then
			var_5_0 = self.displayWordList[iter_5_0]

			break
		end
	end

	if var_5_0.type == 1 then
		var_5_1 = var_5_0.param
	elseif var_5_0.type == 2 then
		var_5_1 = "<color=#ff6666>" .. i18n("juuschat_chattip1") .. "</color>"
	elseif var_5_0.type == 3 then
		var_5_1 = "<color=#ff6666>" .. i18n("juuschat_chattip2") .. "</color>" .. pg.activity_ins_redpackage[tonumber(var_5_0.param)].desc
	elseif var_5_0.type == 4 then
		var_5_1 = string.gsub(pg.emoji_template[tonumber(var_5_0.param)].desc, "#%w+>", "#28af6e>")
	elseif var_5_0.type == 5 then
		local var_5_2 = var_5_0.param

		for iter_5_1 in string.gmatch(var_5_0.param, "'%d+'") do
			var_5_2 = string.gsub(var_5_2, iter_5_1, "<color=#46d6ff>" .. pg.activity_ins_ship_group_template[tonumber((string.sub(iter_5_1, 2, #iter_5_1 - 1)))].name .. "</color>")
		end

		var_5_1 = var_5_2
	end

	if self:isWaiting() and var_5_0.type ~= 2 and var_5_0.type ~= 3 then
		var_5_1 = "<color=#ff6666>" .. i18n("juuschat_chattip3") .. "</color>" .. var_5_1
	end

	return var_5_1
end

function InstagramTopic:Activate(arg_6_1)
	self.active = true
	self.operationTime = arg_6_1
	self.readFlag = 0

	self:SetDisplayWordList()

	self.replyList = {}

	return
end

function InstagramTopic:RedPacketGotFlag(arg_7_1)
	if #self.replyValues > 0 and _.contains(self.replyValues, arg_7_1) then
		return true
	end

	return false
end

function InstagramTopic:isWaiting()
	return self.displayWordList[#self.displayWordList].option ~= ""
end

function InstagramTopic:IsCompleted()
	if not self:isWaiting() and self.readFlag == 1 then
		return true
	end

	return false
end

return InstagramTopic

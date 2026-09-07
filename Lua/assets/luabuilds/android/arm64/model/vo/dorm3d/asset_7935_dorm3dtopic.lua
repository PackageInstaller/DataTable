local Dorm3dTopic = class("Dorm3dTopic", import("..BaseVO"))
local var_0_1 = pg.dorm3d_ins_chat_language

function Dorm3dTopic:Ctor(arg_1_1, arg_1_2)
	self.topicConfig = arg_1_1
	self.topicId = arg_1_1.id
	self.characterId = arg_1_1.ship_group
	self.name = arg_1_1.name
	self.unlockDesc = arg_1_1.unlock_desc
	self.content = arg_1_1.content

	self:SetWordList()

	self.operationTime = nil
	self.readFlag = 1
	self.replyList = nil

	if arg_1_2 then
		self.active = true
		self.operationTime = arg_1_2.time
		self.readFlag = arg_1_2.read_flag
		self.replyList = arg_1_2.reply_list

		self:SetDisplayWordList()
	else
		self.active = false
	end

	return
end

function Dorm3dTopic:SetWordList()
	self.wordList = {}

	for iter_2_0, iter_2_1 in ipairs(self.content) do
		table.insert(self.wordList, var_0_1[iter_2_1])
	end

	return
end

function Dorm3dTopic:SetDisplayWordList()
	self.displayWordList = {}
	self.replyValues = {}

	if self.replyList ~= nil and #self.replyList > 0 then
		table.sort(self.replyList, function(arg_4_0, arg_4_1)
			return arg_4_0.key < arg_4_1.key
		end)

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

function Dorm3dTopic:GetDisplayWordList()
	return self.displayWordList
end

function Dorm3dTopic:Activate(arg_6_1)
	self.active = true
	self.operationTime = arg_6_1
	self.readFlag = 0

	self:SetDisplayWordList()

	self.replyList = {}

	return
end

function Dorm3dTopic:RedPacketGotFlag(arg_7_1)
	if #self.replyValues > 0 and _.contains(self.replyValues, arg_7_1) then
		return true
	end

	return false
end

function Dorm3dTopic:isWaiting()
	return self.displayWordList[#self.displayWordList].option ~= ""
end

function Dorm3dTopic:IsCompleted()
	if not self:isWaiting() and self.readFlag == 1 then
		return true
	end

	return false
end

return Dorm3dTopic

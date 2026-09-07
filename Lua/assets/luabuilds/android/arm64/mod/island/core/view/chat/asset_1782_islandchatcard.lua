local IslandChatCard = class("IslandChatCard")

function IslandChatCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.selfBubble = IslandChatBubble.New(self._tf:Find("self"))
	self.otherBubble = IslandChatBubble.New(self._tf:Find("other"))

	return
end

function IslandChatCard:Update(arg_2_1)
	if not arg_2_1.player then
		return
	end

	if self.data and arg_2_1.player.id == self.data.player.id and self.data.timestamp == arg_2_1.timestamp then
		return
	end

	self.sender = arg_2_1.player
	self.data = arg_2_1

	local var_2_0 = getProxy(PlayerProxy):getRawData()
	local var_2_1 = arg_2_1.player.id == var_2_0.id

	arg_2_1.isSelf = arg_2_1.player.id == var_2_0.id

	if var_2_1 then
		arg_2_1.player = setmetatable(Clone(var_2_0), {
			__index = arg_2_1.player
		})
	end

	setActive(self.selfBubble.tf, var_2_1)
	setActive(self.otherBubble.tf, not var_2_1)

	if var_2_1 then
		self.selfBubble:dispose()
		self.selfBubble:update(arg_2_1)
	else
		self.otherBubble:dispose()
		self.otherBubble:update(arg_2_1)
	end

	return
end

function IslandChatCard:IsTradeLink()
	return self.otherBubble.isTradeLink or self.selfBubble.isTradeLink
end

function IslandChatCard:Dispose()
	self.selfBubble:dispose()
	self.otherBubble:dispose()

	self.selfBubble = nil
	self.otherBubble = nil

	return
end

return IslandChatCard

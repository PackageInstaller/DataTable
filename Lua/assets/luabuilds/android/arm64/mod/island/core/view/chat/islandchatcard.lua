local var_0_0 = class("IslandChatCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.selfBubble = IslandChatBubble.New(arg_1_0._tf:Find("self"))
	arg_1_0.otherBubble = IslandChatBubble.New(arg_1_0._tf:Find("other"))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	if not arg_2_1.player then
		return
	end

	if arg_2_0.data and arg_2_1.player.id == arg_2_0.data.player.id and arg_2_0.data.timestamp == arg_2_1.timestamp then
		return
	end

	arg_2_0.sender = arg_2_1.player
	arg_2_0.data = arg_2_1

	local var_2_0 = getProxy(PlayerProxy):getRawData()
	local var_2_1 = arg_2_1.player.id == var_2_0.id

	arg_2_1.isSelf = arg_2_1.player.id == var_2_0.id

	if var_2_1 then
		arg_2_1.player = setmetatable(Clone(var_2_0), {
			__index = arg_2_1.player
		})
	end

	setActive(arg_2_0.selfBubble.tf, var_2_1)
	setActive(arg_2_0.otherBubble.tf, not var_2_1)

	if var_2_1 then
		arg_2_0.selfBubble:dispose()
		arg_2_0.selfBubble:update(arg_2_1)
	else
		arg_2_0.otherBubble:dispose()
		arg_2_0.otherBubble:update(arg_2_1)
	end

	return
end

function var_0_0.IsTradeLink(arg_3_0)
	return arg_3_0.otherBubble.isTradeLink or arg_3_0.selfBubble.isTradeLink
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.selfBubble:dispose()
	arg_4_0.otherBubble:dispose()

	arg_4_0.selfBubble = nil
	arg_4_0.otherBubble = nil

	return
end

return var_0_0

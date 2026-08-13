class = var_0_10000

local var_0_0 = var_0_10000("IslandChatCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	IslandChatBubble = var_2

	local var_1_0 = var_2.New
	local var_1_1 = arg_1_0._tf

	arg_1_0.selfBubble = var_1_0(var_4.Find(var_1_1, "self"))
	IslandChatBubble = var_2

	local var_1_2 = var_2.New
	local var_1_3 = arg_1_0._tf

	arg_1_0.otherBubble = var_1_2(var_4.Find(var_1_3, "other"))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	if not arg_2_1.player then
		return
	end

	if arg_2_0.data and var_2.id == arg_2_0.data.player.id and arg_2_0.data.timestamp == arg_2_1.timestamp then
		return
	end

	arg_2_0.sender = var_2
	arg_2_0.data = arg_2_1
	getProxy = var_3
	PlayerProxy = var_1_10005

	local var_2_0 = var_3(var_1_10005)
	local var_2_1 = var_3.getRawData(var_2_0)

	arg_2_1.isSelf = var_2.id == var_2_1.id

	if var_4 then
		setmetatable = var_5
		Clone = var_1_10007
		arg_2_1.player = var_5(var_1_10007(var_2_1), {
			__index = arg_2_1.player
		})
	end

	setActive = var_5

	var_5(arg_2_0.selfBubble.tf, var_4)

	setActive = var_5

	var_5(arg_2_0.otherBubble.tf, not var_4)

	if var_4 then
		local var_2_2 = arg_2_0.selfBubble

		var_5.dispose(var_2_2)

		local var_2_3 = arg_2_0.selfBubble

		var_5.update(var_2_3, arg_2_1)
	else
		local var_2_4 = arg_2_0.otherBubble

		var_5.dispose(var_2_4)

		local var_2_5 = arg_2_0.otherBubble

		var_5.update(var_2_5, arg_2_1)
	end

	return
end

function var_0_0.IsTradeLink(arg_3_0)
	local var_3_0

	if not arg_3_0.otherBubble.isTradeLink then
		var_3_0 = arg_3_0.selfBubble.isTradeLink
	end

	return var_3_0
end

function var_0_0.Dispose(arg_4_0)
	local var_4_0 = arg_4_0.selfBubble

	var_1.dispose(var_4_0)

	local var_4_1 = arg_4_0.otherBubble

	var_1.dispose(var_4_1)

	arg_4_0.selfBubble = nil
	arg_4_0.otherBubble = nil

	return
end

return var_0_0

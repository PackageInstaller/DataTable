class = var_0_10000

local var_0_0 = "IslandEmojiAdaptor"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..IslandBaseUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.loaded = false

	return
end

function var_0_1.Init(arg_2_0, arg_2_1)
	IslandEmojiLayer = var_1_10002
	arg_2_0.emojiLayer = var_1_10002.New()

	local var_2_0 = arg_2_0.emojiLayer
	local var_2_1 = var_2.bind

	BaseUI = var_1_10005

	var_2_1(var_2_0, var_1_10005.ON_CLOSE, function()
		local var_3_0 = arg_2_0.emojiLayer

		var_0.exit(var_3_0)

		arg_2_0.emojiLayer = nil
		arg_2_0.loaded = false

		return
	end)

	local var_2_2 = arg_2_0.emojiLayer

	var_2.setContextData(var_2_2, arg_2_1)

	local var_2_3

	local function var_2_4()
		local var_4_0 = arg_2_0.emojiLayer.event
		local var_4_1 = var_0.disconnect

		BaseUI = var_2_10003

		var_4_1(var_4_0, var_2_10003.LOADED, var_2_4)

		local var_4_2 = arg_2_0.emojiLayer

		var_0.enter(var_4_2)
		var_0_1.super.Init(arg_2_0)

		arg_2_0.loaded = true

		return
	end

	local var_2_5 = arg_2_0.emojiLayer.event
	local var_2_6 = var_3.connect

	BaseUI = var_6

	var_2_6(var_2_5, var_6.LOADED, var_2_4)

	local var_2_7 = arg_2_0.emojiLayer

	var_3.load(var_2_7)

	return
end

function var_0_1.OnDispose(arg_5_0)
	var_0_1.super.OnDispose(arg_5_0)

	if arg_5_0.loaded then
		local var_5_0 = arg_5_0.emojiLayer

		var_1.exit(var_5_0)

		arg_5_0.emojiLayer = nil
	end

	return
end

return var_0_1

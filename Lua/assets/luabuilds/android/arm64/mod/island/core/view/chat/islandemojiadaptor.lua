local var_0_0 = class("IslandEmojiAdaptor", import("..IslandBaseUnit"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.loaded = false

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.emojiLayer = IslandEmojiLayer.New()

	arg_2_0.emojiLayer:bind(BaseUI.ON_CLOSE, function()
		arg_2_0.emojiLayer:exit()

		arg_2_0.emojiLayer = nil
		arg_2_0.loaded = false

		return
	end)
	arg_2_0.emojiLayer:setContextData(arg_2_1)
	arg_2_0.emojiLayer.event:connect(BaseUI.LOADED, function()
		arg_2_0.emojiLayer.event:disconnect(BaseUI.LOADED, var_0)
		arg_2_0.emojiLayer:enter()
		var_0_0.super.Init(arg_2_0)

		arg_2_0.loaded = true

		return
	end)
	arg_2_0.emojiLayer:load()

	return
end

function var_0_0.OnDispose(arg_5_0)
	var_0_0.super.OnDispose(arg_5_0)

	if arg_5_0.loaded then
		arg_5_0.emojiLayer:exit()

		arg_5_0.emojiLayer = nil
	end

	return
end

return var_0_0

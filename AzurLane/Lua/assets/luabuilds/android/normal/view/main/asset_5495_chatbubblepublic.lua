class = var_0_10000

local var_0_0 = var_0_10000("ChatBubblePublic")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	tf = var_1_10002
	arg_1_0.tf = var_1_10002(arg_1_1)
	findTF = var_2

	local var_1_0 = var_2(arg_1_0.tf, "text")

	arg_1_0.richText = var_2.GetComponent(var_1_0, "RichText")
	findTF = var_2

	local var_1_1 = var_2(arg_1_0.tf, "channel")

	IsNil = var_3

	if not var_3(var_1_1) then
		arg_1_0.channel = var_1_1:GetComponent("Image")
	end

	return
end

function var_0_0.update(arg_2_0, arg_2_1)
	if arg_2_0.data == arg_2_1 then
		return
	end

	arg_2_0.data = arg_2_1

	local var_2_0 = arg_2_0.richText

	var_2_0.supportRichText = true
	ChatProxy = var_2_0

	var_2_0.InjectPublic(arg_2_0.richText, arg_2_1)

	local var_2_1 = arg_2_0.richText

	var_2.AddListener(var_2_1, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.clickItem(var_3_0, arg_3_0, arg_3_1)

		return
	end)

	if arg_2_0.channel then
		local var_2_2 = arg_2_0.channel

		GetSpriteFromAtlas = var_2_1

		local var_2_3 = "channel"

		ChatConst = var_1_10005
		var_2_2.sprite = var_2_1(var_2_3, var_1_10005.GetChannelSprite(arg_2_1.type) .. "_1920")

		local var_2_4 = arg_2_0.channel

		var_2.SetNativeSize(var_2_4)
	end

	return
end

function var_0_0.clickItem(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == "clickPlayer" then
		print = var_1_10003

		var_1_10003("click player : ")
	elseif arg_4_1 == "clickShip" then
		print = var_1_10003

		var_1_10003("click ship : ")
	end

	return
end

function var_0_0.dispose(arg_5_0)
	local var_5_0 = arg_5_0.richText

	var_1.RemoveAllListeners(var_5_0)

	return
end

return var_0_0

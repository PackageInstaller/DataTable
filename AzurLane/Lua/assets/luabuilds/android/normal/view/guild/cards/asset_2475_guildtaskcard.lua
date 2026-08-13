class = var_0_10000

local var_0_0 = var_0_10000("GuildTaskCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	go = var_1_10002
	arg_1_0._go = var_1_10002(arg_1_1)

	local var_1_0 = arg_1_0._tf

	arg_1_0.acceptBtn = var_2.Find(var_1_0, "accept")

	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_2.Find(var_1_1, "icon")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.icon = var_1_3(var_1_2, var_4(var_1_10005))

	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_2.Find(var_1_4, "desc/Text")
	local var_1_6 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.descTxt = var_1_6(var_1_5, var_4(var_1_10005))

	local var_1_7 = arg_1_0._tf
	local var_1_8 = var_2.Find(var_1_7, "res_1/Text")
	local var_1_9 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.publicResTxt = var_1_9(var_1_8, var_4(var_1_10005))

	local var_1_10 = arg_1_0._tf
	local var_1_11 = var_2.Find(var_1_10, "res_2/Text")
	local var_1_12 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.privateResTxt = var_1_12(var_1_11, var_4(var_1_10005))

	local var_1_13 = arg_1_0._tf
	local var_1_14 = var_2.Find(var_1_13, "res_1/label")
	local var_1_15 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005

	local var_1_16 = var_1_15(var_1_14, var_4(var_1_10005))

	i18n = var_1_14
	var_1_16.text = var_1_14("guild_public_awards")

	local var_1_17 = arg_1_0._tf
	local var_1_18 = var_2.Find(var_1_17, "res_2/label")
	local var_1_19 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005

	local var_1_20 = var_1_19(var_1_18, var_4(var_1_10005))

	i18n = var_1_18
	var_1_20.text = var_1_18("guild_private_awards")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.task = arg_2_1

	local var_2_0 = arg_2_0.icon

	GetSpriteFromAtlas = var_1_10003
	var_2_0.sprite = var_1_10003("ui/GuildMainUI_atlas", "frame_" .. arg_2_1:GetScale())
	arg_2_0.descTxt.text = arg_2_1:GetDesc()
	arg_2_0.publicResTxt.text = arg_2_1:GetCaptailAward()
	arg_2_0.privateResTxt.text = arg_2_1:GetPrivateAward()

	return
end

function var_0_0.Destroy(arg_3_0)
	return
end

return var_0_0

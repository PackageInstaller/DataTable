local var_0_0 = class("GuildTaskCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0._go = go(arg_1_1)
	arg_1_0.acceptBtn = arg_1_0._tf:Find("accept")
	arg_1_0.icon = arg_1_0._tf:Find("icon"):GetComponent(typeof(Image))
	arg_1_0.descTxt = arg_1_0._tf:Find("desc/Text"):GetComponent(typeof(Text))
	arg_1_0.publicResTxt = arg_1_0._tf:Find("res_1/Text"):GetComponent(typeof(Text))
	arg_1_0.privateResTxt = arg_1_0._tf:Find("res_2/Text"):GetComponent(typeof(Text))
	arg_1_0._tf:Find("res_1/label"):GetComponent(typeof(Text)).text = i18n("guild_public_awards")
	arg_1_0._tf:Find("res_2/label"):GetComponent(typeof(Text)).text = i18n("guild_private_awards")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.task = arg_2_1
	arg_2_0.icon.sprite = GetSpriteFromAtlas("ui/GuildMainUI_atlas", "frame_" .. arg_2_1:GetScale())
	arg_2_0.descTxt.text = arg_2_1:GetDesc()
	arg_2_0.publicResTxt.text = arg_2_1:GetCaptailAward()
	arg_2_0.privateResTxt.text = arg_2_1:GetPrivateAward()

	return
end

function var_0_0.Destroy(arg_3_0)
	return
end

return var_0_0

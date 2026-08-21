local var_0_0 = class("IslandBlackWhitListCard", import(".IslandFriendCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.removeBtn = arg_1_1.transform:Find("remove")

	setText(arg_1_0.removeBtn:Find("Text"), i18n("island_btn_label_remove"))

	return
end

return var_0_0

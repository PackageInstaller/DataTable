local var_0_0 = class("CardPuzzleRelicView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = tf(arg_1_1)

	return
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.data = arg_2_1

	return
end

function var_0_0.UpdateView(arg_3_0)
	setImageSprite(arg_3_0._tf:Find("Icon"), LoadSprite(arg_3_0.data:GetIconPath(), ""), true)
	setText(arg_3_0._tf:Find("Name"), arg_3_0.data:GetName())
	setText(arg_3_0._tf:Find("Detail"), arg_3_0.data:GetDesc())
	TweenItemAlphaAndWhite(go(arg_3_0._tf))

	return
end

function var_0_0.Clear(arg_4_0)
	ClearTweenItemAlphaAndWhite(go(arg_4_0._tf))

	return
end

return var_0_0

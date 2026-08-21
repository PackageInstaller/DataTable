local var_0_0 = class("NewEducateOptionsHandler")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.tpl = arg_1_0._tf:Find("tpl")
	arg_1_0.optionUIList = UIItemList.New(arg_1_0._tf, arg_1_0.tpl)

	arg_1_0.optionUIList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			arg_1_0:UpdateOption(arg_2_1, arg_2_2)
		end

		return
	end)

	return
end

function var_0_0.Play(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.callName = arg_3_0.callName or getProxy(NewEducateProxy):GetCurChar():GetCallName()

	setActive(arg_3_0._go, true)

	arg_3_0.optionIds = arg_3_1
	arg_3_0.callback = arg_3_2

	arg_3_0.optionUIList:align(#arg_3_0.optionIds)

	return
end

function var_0_0._GetText(arg_4_0, arg_4_1)
	return string.gsub(pg.child2_word[arg_4_1].word, "$1", arg_4_0.callName)
end

function var_0_0.UpdateOption(arg_5_0, arg_5_1, arg_5_2)
	setScrollText(arg_5_2:Find("mask/Text"), arg_5_0:_GetText(pg.child2_node[arg_5_0.optionIds[arg_5_1 + 1]].text))
	onButton(arg_5_0, arg_5_2, function()
		existCall(arg_5_0.callback(var_0))
		arg_5_0:Reset()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateCallName(arg_7_0)
	arg_7_0.callName = getProxy(NewEducateProxy):GetCurChar():GetCallName()

	return
end

function var_0_0.Reset(arg_8_0)
	arg_8_0.callback = nil

	setActive(arg_8_0._go, false)

	return
end

function var_0_0.Destroy(arg_9_0)
	pg.DelegateInfo.Dispose(arg_9_0)

	return
end

return var_0_0

local var_0_0 = class("PileGameSignedLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "PileSignedUI"
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.data = arg_2_1
	arg_2_0.ultimate = arg_2_1.ultimate
	arg_2_0.usedtime = arg_2_1.usedtime

	return
end

function var_0_0.init(arg_3_0)
	arg_3_0.icons = {
		arg_3_0._tf:Find("bg/icon/npc1"),
		arg_3_0._tf:Find("bg/icon/npc2"),
		arg_3_0._tf:Find("bg/icon/npc3"),
		arg_3_0._tf:Find("bg/icon/npc4"),
		arg_3_0._tf:Find("bg/icon/npc5"),
		arg_3_0._tf:Find("bg/icon/npc6"),
		arg_3_0._tf:Find("bg/icon/npc7")
	}
	arg_3_0.helpBtn = arg_3_0._tf:Find("bg/btn/pngbtn_help")
	arg_3_0.getBtn = arg_3_0._tf:Find("bg/btn/btn_djlq")
	arg_3_0.gotBtn = arg_3_0._tf:Find("bg/btn/btn_ylq")
	arg_3_0.parent = arg_3_0._tf.parent

	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)

	return
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf, function()
		arg_4_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_chunjie_stamp.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.getBtn, function()
		if arg_4_0.data:getConfig("reward_need") > arg_4_0.usedtime then
			return
		end

		arg_4_0:emit(PileGameSignedMediator.ON_GET_AWARD)

		return
	end, SFX_PANEL)
	arg_4_0:UpdateIconDesc()
	arg_4_0:UpdateSigned()

	return
end

function var_0_0.UpdateIconDesc(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.icons) do
		onButton(arg_8_0, iter_8_1, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("special_animal" .. iter_8_0)
			})

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.UpdateSigned(arg_10_0)
	local var_10_0 = arg_10_0.data:getConfig("reward_need")
	local var_10_1 = arg_10_0.usedtime
	local var_10_2 = arg_10_0.ultimate == 0

	setActive(arg_10_0.getBtn, arg_10_0.ultimate == 0)
	setActive(arg_10_0.gotBtn, not var_10_2)
	setGray(arg_10_0.getBtn, var_10_2 and var_10_1 < var_10_0, true)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.icons) do
		local var_10_3 = iter_10_1:GetComponent(typeof(Image))

		var_10_3.color = iter_10_0 <= var_10_1 and Color.New(1, 1, 1, 1) or Color.New(1, 1, 1, 0.1)
	end

	return
end

function var_0_0.willExit(arg_11_0)
	arg_11_0.icons = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0._tf, arg_11_0.parent)

	return
end

return var_0_0

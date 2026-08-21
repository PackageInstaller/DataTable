local var_0_0 = class("HoloLiveMioPage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.heartTpl = arg_1_0.bg:Find("HeartTpl")
	arg_1_0.heartContainer = arg_1_0.bg:Find("HeartContainer")
	arg_1_0.helpBtn = arg_1_0.bg:Find("HelpBtn")

	onButton(arg_1_0, arg_1_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.hololive_dashenling.tip
		})

		return
	end, SFX_PANEL)

	arg_1_0.heartUIItemList = UIItemList.New(arg_1_0.heartContainer, arg_1_0.heartTpl)

	arg_1_0.heartUIItemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			setActive(arg_3_2:Find("Full"), not (arg_1_0.ptData:GetLevelProgress() < arg_3_1 + 1))
		end

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_4_0)
	var_0_0.super.OnUpdateFlush(arg_4_0)

	local var_4_0, var_4_1 = arg_4_0.ptData:GetLevelProgress()

	arg_4_0.heartUIItemList:align(var_4_1)

	return
end

return var_0_0

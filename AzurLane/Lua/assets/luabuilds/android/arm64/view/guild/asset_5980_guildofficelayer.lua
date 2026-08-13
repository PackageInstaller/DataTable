class = var_0_10000

local var_0_0 = "GuildOfficeLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "GuildEmptyUI"
end

function var_0_1.setPlayer(arg_2_0, arg_2_1)
	arg_2_0.playerVO = arg_2_1

	return
end

function var_0_1.SetGuild(arg_3_0, arg_3_1)
	arg_3_0.guild = arg_3_1
	GuildMember = var_1_10002
	arg_3_0.isAdmin = var_1_10002.IsAdministrator(arg_3_1:getSelfDuty())

	if arg_3_0.taskPage then
		local var_3_0 = arg_3_0.taskPage

		if var_2.GetLoaded(var_3_0) then
			local var_3_1 = arg_3_0.taskPage

			var_2.OnUpdateGuild(var_3_1, arg_3_0.guild, arg_3_0.isAdmin)
		end
	end

	return
end

function var_0_1.init(arg_4_0)
	GuildOfficeTaskPage = var_1_10001
	arg_4_0.taskPage = var_1_10001.New(arg_4_0._tf, arg_4_0.event)

	local var_4_0 = arg_4_0._tf

	arg_4_0.helpBtn = var_1.Find(var_4_0, "frame/help")

	return
end

function var_0_1.didEnter(arg_5_0)
	local var_5_0 = arg_5_0.guild
	local var_5_1 = var_1.GetOfficePainting(var_5_0)

	pg = var_1_10002

	local var_5_2 = var_1_10002.GuildPaintingMgr.GetInstance()
	local var_5_3 = var_2.Update
	local var_5_4 = var_5_1

	Vector3 = var_1_10006

	var_5_3(var_5_2, var_5_4, var_1_10006(-737, -171, 0))

	local var_5_5 = arg_5_0.taskPage

	var_2.ExecuteAction(var_5_5, "Update", arg_5_0.guild, arg_5_0.isAdmin)

	onButton = var_2

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.helpBtn

	local function var_5_8()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_6_2.type = var_2_10004
		pg = var_2_10004
		var_6_2.helps = var_2_10004.gametip.guild_office_tip.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_7

	var_2(var_5_6, var_5_7, var_5_8, var_7)

	return
end

function var_0_1.UpdateContribution(arg_7_0)
	if arg_7_0.taskPage then
		local var_7_0 = arg_7_0.taskPage

		if var_1.GetLoaded(var_7_0) then
			local var_7_1 = arg_7_0.taskPage

			var_1.OnUpdateContribution(var_7_1)
		end
	end

	return
end

function var_0_1.UpdateSupplyPanel(arg_8_0)
	if arg_8_0.taskPage then
		local var_8_0 = arg_8_0.taskPage

		if var_1.GetLoaded(var_8_0) then
			local var_8_1 = arg_8_0.taskPage

			var_1.OnUpdateSupplyPanel(var_8_1)
		end
	end

	return
end

function var_0_1.UpdateTask(arg_9_0, arg_9_1)
	if arg_9_0.taskPage then
		local var_9_0 = arg_9_0.taskPage

		if var_2.GetLoaded(var_9_0) then
			local var_9_1 = arg_9_0.taskPage

			var_2.OnUpdateTask(var_9_1, arg_9_1)
		end
	end

	return
end

function var_0_1.onBackPressed(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.CriMgr.GetInstance()
	local var_10_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_10_1(var_10_0, var_1_10004)
	arg_10_0:emit(var_0_1.ON_BACK)

	return
end

function var_0_1.willExit(arg_11_0)
	local var_11_0 = arg_11_0.taskPage

	var_1.Destroy(var_11_0)

	isActive = var_1
	pg = var_11_0

	if var_1(var_11_0.MsgboxMgr.GetInstance()._go) then
		triggerButton = var_1
		pg = var_3

		var_1(var_3.MsgboxMgr.GetInstance()._closeBtn)
	end

	return
end

return var_0_1

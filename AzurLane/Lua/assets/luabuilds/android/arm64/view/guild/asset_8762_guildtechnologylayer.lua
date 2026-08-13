class = var_0_10000

local var_0_0 = "GuildTechnologyLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "GuildEmptyUI"
end

function var_0_1.setGuild(arg_2_0, arg_2_1)
	arg_2_0.guildVO = arg_2_1

	return
end

function var_0_1.init(arg_3_0)
	GuildTechnologyPage = var_1_10001
	arg_3_0.technologyPage = var_1_10001.New(arg_3_0._tf, arg_3_0.event)

	local var_3_0 = arg_3_0._tf

	arg_3_0.helpBtn = var_1.Find(var_3_0, "frame/help")

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:UpdatePainting()

	local var_4_0 = arg_4_0.technologyPage

	var_1.ExecuteAction(var_4_0, "SetUp", arg_4_0.guildVO)

	onButton = var_1

	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0.helpBtn

	local function var_4_3()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_5_2.type = var_2_10004
		pg = var_2_10004
		var_5_2.helps = var_2_10004.gametip.guild_tech_tip.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_1, var_4_2, var_4_3, var_1_10006)

	return
end

function var_0_1.UpdatePainting(arg_6_0)
	local var_6_0 = arg_6_0.guildVO
	local var_6_1 = var_1.GetOfficePainting(var_6_0)

	pg = var_1_10002

	local var_6_2 = var_1_10002.GuildPaintingMgr.GetInstance()
	local var_6_3 = var_2.Update
	local var_6_4 = var_6_1

	Vector3 = var_1_10006

	var_6_3(var_6_2, var_6_4, var_1_10006(-737, -171, 0))

	return
end

function var_0_1.UpdateUpgradeList(arg_7_0)
	local var_7_0 = arg_7_0.technologyPage

	if var_1.GetLoaded(var_7_0) then
		local var_7_1 = arg_7_0.technologyPage

		var_1.UpdateUpgradeList(var_7_1)
	end

	return
end

function var_0_1.UpdateBreakOutList(arg_8_0)
	local var_8_0 = arg_8_0.technologyPage

	if var_1.GetLoaded(var_8_0) then
		local var_8_1 = arg_8_0.technologyPage

		var_1.UpdateBreakOutList(var_8_1)
	end

	return
end

function var_0_1.UpdateGuild(arg_9_0, arg_9_1)
	arg_9_0:setGuild(arg_9_1)

	if arg_9_0.technologyPage then
		local var_9_0 = arg_9_0.technologyPage

		if var_2.GetLoaded(var_9_0) then
			local var_9_1 = arg_9_0.technologyPage

			var_2.Update(var_9_1, arg_9_0.guildVO)
		end
	end

	return
end

function var_0_1.UpdateAll(arg_10_0)
	local var_10_0 = arg_10_0.technologyPage

	if var_1.GetLoaded(var_10_0) then
		local var_10_1 = arg_10_0.technologyPage

		var_1.Flush(var_10_1)
	end

	return
end

function var_0_1.onBackPressed(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.CriMgr.GetInstance()
	local var_11_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_11_1(var_11_0, var_1_10004)
	arg_11_0:emit(var_0_1.ON_BACK)

	return
end

function var_0_1.willExit(arg_12_0)
	local var_12_0 = arg_12_0.technologyPage

	var_1.Destroy(var_12_0)

	isActive = var_1
	pg = var_12_0

	if var_1(var_12_0.MsgboxMgr.GetInstance()._go) then
		triggerButton = var_1
		pg = var_3

		var_1(var_3.MsgboxMgr.GetInstance()._closeBtn)
	end

	return
end

return var_0_1

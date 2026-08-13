class = var_0_10000

local var_0_0 = "CurrentWorldBossDetailPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseWorldBossDetailPage"))

function var_0_1.getUIName(arg_1_0)
	return "CurrentWorldBossDetailUI"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.listBtn = var_1.Find(var_2_0, "list_btn")
	MetaWorldbossBtn = var_1

	local var_2_1 = var_1.New
	local var_2_2 = arg_2_0._tf

	arg_2_0.metaWorldbossBtn = var_2_1(var_2.Find(var_2_2, "archives_btn"), arg_2_0.event)
	WorldBossHelpPage = var_1
	arg_2_0.helpWindow = var_1.New(arg_2_0._tf, arg_2_0.event)

	local var_2_3 = arg_2_0._tf

	arg_2_0.currProgressTr = var_1.Find(var_2_3, "progress")

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "progress/value")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.currProgressTxt = var_2_6(var_2_5, var_3(var_4))
	WorldbossPtBtn = var_1

	local var_2_7 = var_1.New
	local var_2_8 = arg_2_0._tf

	arg_2_0.ptBtn = var_2_7(var_2.Find(var_2_8, "point"))

	return
end

function var_0_1.OnInit(arg_3_0)
	var_0_1.super.OnInit(arg_3_0)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.listBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		WorldBossScene = var_2_10002

		local var_4_2 = var_2_10002.ON_SWITCH

		WorldBossScene = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003.PAGE_CHALLENGE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.currProgressTr

	local function var_3_5()
		WorldBossConst = var_2_10000

		local var_5_0 = var_2_10000.GetCurrBossItemInfo()

		pg = var_2_10001

		local var_5_1 = var_2_10001.MsgboxMgr.GetInstance()
		local var_5_2 = var_1.ShowMsgBox
		local var_5_3 = {
			hideNo = true
		}

		MSGBOX_TYPE_DROP_ITEM = var_2_10004
		var_5_3.type = var_2_10004
		var_5_3.name = var_5_0.name
		var_5_3.content = var_5_0.display
		var_5_3.iconPath = var_5_0.icon
		var_5_3.frame = var_5_0.rarity

		var_5_2(var_5_1, var_5_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf
	local var_3_8 = var_3.Find(var_3_7, "point/help")

	local function var_3_9()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		pg = var_2_10003
		var_6_2.helps = var_2_10003.gametip.world_boss_help_meta.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_5

	var_1(var_3_6, var_3_8, var_3_9, var_5)

	return
end

function var_0_1.OnUpdateRes(arg_7_0)
	WorldBossConst = var_1_10001

	local var_7_0, var_7_1, var_7_2 = var_1_10001.GetCurrBossConsume()

	WorldBossConst = var_1_10004

	local var_7_3 = var_1_10004.GetCurrBossItemProgress()

	arg_7_0.currProgressTxt.text = var_7_3 .. "/" .. var_7_2

	return
end

function var_0_1.OnUpdatePt(arg_8_0)
	if arg_8_0.ptBtn then
		local var_8_0 = arg_8_0.ptBtn

		var_1.Update(var_8_0)
	end

	return
end

function var_0_1.OnRescue(arg_9_0)
	if arg_9_0.helpWindow then
		local var_9_0 = arg_9_0.helpWindow

		var_1.ExecuteAction(var_9_0, "Update", arg_9_0.boss)
	end

	return
end

function var_0_1.Show(arg_10_0)
	var_0_1.super.Show(arg_10_0)
	arg_10_0:TryPlayGuide()

	return
end

function var_0_1.TryPlayGuide(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.NewStoryMgr.GetInstance()

	if var_1.IsPlayed(var_11_0, "WorldG191") then
		WorldGuider = var_1

		local var_11_1 = var_1.GetInstance()

		var_1.PlayGuide(var_11_1, "WorldG191_1")
	end

	pg = var_1

	local var_11_2 = var_1.NewStoryMgr.GetInstance()

	if var_1.IsPlayed(var_11_2, "WorldG191_1") then
		CurrentWorldBossDetailPage = var_1

		if not var_1.formDock then
			WorldGuider = var_1

			local var_11_3 = var_1.GetInstance()

			var_1.PlayGuide(var_11_3, "WorldG192")
		end
	end

	CurrentWorldBossDetailPage = var_1
	var_1.formDock = false

	return
end

function var_0_1.OnDestroy(arg_12_0)
	var_0_1.super.OnDestroy(arg_12_0)

	if arg_12_0.helpWindow then
		local var_12_0 = arg_12_0.helpWindow

		var_1.Destroy(var_12_0)

		arg_12_0.helpWindow = nil
	end

	if arg_12_0.metaWorldbossBtn then
		local var_12_1 = arg_12_0.metaWorldbossBtn

		var_1.Dispose(var_12_1)

		arg_12_0.metaWorldbossBtn = nil
	end

	if arg_12_0.ptBtn then
		local var_12_2 = arg_12_0.ptBtn

		var_1.Dispose(var_12_2)

		arg_12_0.ptBtn = nil
	end

	return
end

return var_0_1

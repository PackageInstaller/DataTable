class = var_0_10000

local var_0_0 = "PileGameSignedLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "PileSignedUI"
end

function var_0_1.SetData(arg_2_0, arg_2_1)
	arg_2_0.data = arg_2_1
	arg_2_0.ultimate = arg_2_1.ultimate
	arg_2_0.usedtime = arg_2_1.usedtime

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = arg_3_0._tf

	var_3_0[1] = var_2.Find(var_3_1, "bg/icon/npc1")

	local var_3_2 = arg_3_0._tf

	var_3_0[2] = var_2.Find(var_3_2, "bg/icon/npc2")

	local var_3_3 = arg_3_0._tf

	var_3_0[3] = var_2.Find(var_3_3, "bg/icon/npc3")

	local var_3_4 = arg_3_0._tf

	var_3_0[4] = var_2.Find(var_3_4, "bg/icon/npc4")

	local var_3_5 = arg_3_0._tf

	var_3_0[5] = var_2.Find(var_3_5, "bg/icon/npc5")

	local var_3_6 = arg_3_0._tf

	var_3_0[6] = var_2.Find(var_3_6, "bg/icon/npc6")

	local var_3_7 = arg_3_0._tf

	var_3_0[7] = var_2.Find(var_3_7, "bg/icon/npc7")
	arg_3_0.icons = var_3_0

	local var_3_8 = arg_3_0._tf

	arg_3_0.helpBtn = var_1.Find(var_3_8, "bg/btn/pngbtn_help")

	local var_3_9 = arg_3_0._tf

	arg_3_0.getBtn = var_1.Find(var_3_9, "bg/btn/btn_djlq")

	local var_3_10 = arg_3_0._tf

	arg_3_0.gotBtn = var_1.Find(var_3_10, "bg/btn/btn_ylq")
	arg_3_0.parent = arg_3_0._tf.parent
	pg = var_1

	local var_3_11 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_11, arg_3_0._tf)

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10005)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.helpBtn

	local function var_4_5()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		pg = var_2_10003
		var_6_2.helps = var_2_10003.gametip.help_chunjie_stamp.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10005)

	onButton = var_1_10001

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.getBtn

	local function var_4_8()
		local var_7_0 = arg_4_0.data

		if var_0.getConfig(var_7_0, "reward_need") > arg_4_0.usedtime then
			return
		end

		local var_7_1 = arg_4_0
		local var_7_2 = var_2.emit

		PileGameSignedMediator = var_2_10004

		var_7_2(var_7_1, var_2_10004.ON_GET_AWARD)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_6, var_4_7, var_4_8, var_1_10005)
	arg_4_0:UpdateIconDesc()
	arg_4_0:UpdateSigned()

	return
end

function var_0_1.UpdateIconDesc(arg_8_0)
	ipairs = var_1_10001

	for iter_8_0, iter_8_1 in var_1_10001(arg_8_0.icons) do
		onButton = var_1_10006

		local var_8_0 = arg_8_0
		local var_8_1 = iter_8_1

		local function var_8_2()
			pg = var_2_10000

			local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
			local var_9_1 = var_0.ShowMsgBox
			local var_9_2 = {}

			i18n = var_2_10003
			var_9_2.content = var_2_10003("special_animal" .. iter_8_0)

			var_9_1(var_9_0, var_9_2)

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_8_0, var_8_1, var_8_2, var_1_10010)
	end

	return
end

function var_0_1.UpdateSigned(arg_10_0)
	local var_10_0 = arg_10_0.data
	local var_10_1 = var_1.getConfig(var_10_0, "reward_need")
	local var_10_2 = arg_10_0.usedtime
	local var_10_3 = arg_10_0.ultimate == 0

	setActive = var_1_10004

	var_1_10004(arg_10_0.getBtn, var_10_3)

	setActive = var_1_10004

	var_1_10004(arg_10_0.gotBtn, not var_10_3)

	setGray = var_1_10004

	var_1_10004(arg_10_0.getBtn, var_10_3 and var_10_2 < var_10_1, true)

	ipairs = var_1_10004

	for iter_10_0, iter_10_1 in var_1_10004(arg_10_0.icons) do
		local var_10_4 = iter_10_0 <= var_10_2
		local var_10_5 = iter_10_1
		local var_10_6 = iter_10_1.GetComponent

		typeof = var_1_10012
		Image = var_1_10013

		local var_10_7 = var_10_6(var_10_5, var_1_10012(var_1_10013))

		if var_10_4 then
			Color = var_10_5

			if not var_10_5.New(1, 1, 1, 1) then
				Color = var_10_5
				var_10_5 = var_10_5.New(1, 1, 1, 0.1)
			end

			var_10_7.color = var_10_5
		end
	end

	return
end

function var_0_1.willExit(arg_11_0)
	arg_11_0.icons = nil
	pg = var_1

	local var_11_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_11_0, arg_11_0._tf, arg_11_0.parent)

	return
end

return var_0_1

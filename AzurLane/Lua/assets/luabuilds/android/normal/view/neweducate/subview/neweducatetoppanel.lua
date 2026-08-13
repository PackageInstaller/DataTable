class = var_0_10000

local var_0_0 = "NewEducateTopPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "NewEducateTopPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.GetComponent

	typeof = var_1_10003
	Animation = var_1_10004
	arg_2_0.animCom = var_2_1(var_2_0, var_1_10003(var_1_10004))
	NewEducateTopProgress = var_1

	local var_2_2 = var_1.New
	local var_2_3 = arg_2_0._tf

	arg_2_0.progressPart = var_2_2(var_2.Find(var_2_3, "progress"), arg_2_0)
	NewEducateTopRes = var_1

	local var_2_4 = var_1.New
	local var_2_5 = arg_2_0._tf

	arg_2_0.resPart = var_2_4(var_2.Find(var_2_5, "res"), arg_2_0)

	local var_2_6 = arg_2_0.resPart

	var_1.SetBgEnable(var_2_6, not arg_2_0.contextData.hideBlurBg)

	local var_2_7 = arg_2_0._tf

	arg_2_0.toolbarTF = var_1.Find(var_2_7, "toolbar")
	setActive = var_1

	local var_2_8 = arg_2_0.toolbarTF

	var_1(var_2.Find(var_2_8, "btns/home"), not arg_2_0.contextData.hideHome)

	setActive = var_1

	local var_2_9 = arg_2_0.toolbarTF

	var_1(var_2.Find(var_2_9, "btns/help/line"), not arg_2_0.contextData.hideHome)

	pg = var_1

	local var_2_10, var_2_11

	if var_1.gameset.child2_rank_switch.key_value == 1 then
		var_2_10 = arg_2_0.contextData.char
		var_2_10 = var_1.GetPermanentData(var_2_10)
		var_2_11 = var_1.IsTarotType(var_2_10)
	else
		var_2_11 = false
	end

	if false then
		var_2_11 = true
	end

	setActive = var_2_10

	local var_2_12 = arg_2_0.toolbarTF

	var_2_10(var_3.Find(var_2_12, "btns/rank"), var_2_11)

	setAnchoredPosition = var_2_10

	var_2_10(arg_2_0.resPart._tf, {
		x = var_2_11 and -697 or -565
	})

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.toolbarTF
	local var_3_2 = var_3.Find(var_3_1, "btns/rank")

	local function var_3_3()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		NewEducateBaseUI = var_2_10002

		local var_4_2 = var_2_10002.GO_SUBLAYER

		Context = var_2_10003

		local var_4_3 = var_2_10003.New
		local var_4_4 = {}

		NewEducateRankMediator = var_2_10005
		var_4_4.mediator = var_2_10005
		NewEducateRankLayer = var_2_10005
		var_4_4.viewComponent = var_2_10005

		var_4_1(var_4_0, var_4_2, var_4_3(var_4_4))

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.toolbarTF
	local var_3_6 = var_3.Find(var_3_5, "btns/collect")

	local function var_3_7()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		NewEducateBaseUI = var_2_10002

		local var_5_2 = var_2_10002.GO_SUBLAYER

		Context = var_2_10003

		local var_5_3 = var_2_10003.New
		local var_5_4 = {}

		NewEducateCollectEntranceMediator = var_2_10005
		var_5_4.mediator = var_2_10005
		NewEducateCollectEntranceLayer = var_2_10005
		var_5_4.viewComponent = var_2_10005
		var_5_4.data = {
			id = arg_3_0.contextData.char.id
		}

		var_5_1(var_5_0, var_5_2, var_5_3(var_5_4))

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_5)

	onButton = var_1_10001

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.toolbarTF
	local var_3_10 = var_3.Find(var_3_9, "btns/refresh")

	local function var_3_11()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		NewEducateBaseUI = var_2_10002

		local var_6_2 = var_2_10002.ON_BOX
		local var_6_3 = {}

		i18n = var_2_10004
		var_6_3.content = var_2_10004("child_refresh_sure_tip")

		function var_6_3.onYes()
			pg = var_3_10000

			local var_7_0 = var_3_10000.m02
			local var_7_1 = var_0.sendNotification

			GAME = var_3_10002

			var_7_1(var_7_0, var_3_10002.NEW_EDUCATE_REFRESH, {
				id = arg_3_0.contextData.char.id,
				difficulty = arg_3_0.contextData.char.difficulty
			})

			return
		end

		var_6_1(var_6_0, var_6_2, var_6_3)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_8, var_3_10, var_3_11, var_5)

	local var_3_12 = var_0_1

	var_3_12.helps = {
		"child2_main_help",
		"child2_explorer_main_help"
	}
	onButton = var_3_12

	local var_3_13 = arg_3_0
	local var_3_14 = arg_3_0.toolbarTF
	local var_3_15 = var_3.Find(var_3_14, "btns/help")

	local function var_3_16()
		local var_8_0 = var_0_1.helps[arg_3_0.contextData.char.id]

		pg = var_1

		local var_8_1 = var_1.MsgboxMgr.GetInstance()
		local var_8_2 = var_1.ShowMsgBox
		local var_8_3 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_8_3.type = var_2_10004
		i18n = var_2_10004
		var_8_3.helps = var_2_10004(var_8_0)

		var_8_2(var_8_1, var_8_3)

		return
	end

	SFX_PANEL = var_5

	var_3_12(var_3_13, var_3_15, var_3_16, var_5)

	onButton = var_3_12

	local var_3_17 = arg_3_0
	local var_3_18 = arg_3_0.toolbarTF
	local var_3_19 = var_3.Find(var_3_18, "btns/home")

	local function var_3_20()
		NewEducateHelper = var_2_10000

		var_2_10000.TrackExitTime()

		local var_9_0 = arg_3_0
		local var_9_1 = var_0.emit

		NewEducateBaseUI = var_2_10002

		var_9_1(var_9_0, var_2_10002.ON_HOME)

		return
	end

	SFX_PANEL = var_5

	var_3_12(var_3_17, var_3_19, var_3_20, var_5)
	arg_3_0:OverlayPanel(arg_3_0._tf, {
		pbList = {
			arg_3_0.resPart._tf
		}
	})
	arg_3_0:Flush()

	return
end

function var_0_1.Flush(arg_10_0)
	local var_10_0 = arg_10_0.progressPart

	var_1.Update(var_10_0, arg_10_0.contextData.char)

	local var_10_1 = arg_10_0.resPart

	var_1.Update(var_10_1, arg_10_0.contextData.char)

	return
end

function var_0_1.FlushRes(arg_11_0)
	local var_11_0 = arg_11_0.resPart

	var_1.Update(var_11_0, arg_11_0.contextData.char)

	return
end

function var_0_1.FlushProgress(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.progressPart

	var_2.Update(var_12_0, arg_12_0.contextData.char, arg_12_1)

	return
end

function var_0_1.PlayShow(arg_13_0)
	local var_13_0 = arg_13_0.animCom

	var_1.Play(var_13_0, "anim_educate_topui_show")

	return
end

function var_0_1.PlayHide(arg_14_0)
	local var_14_0 = arg_14_0.animCom

	var_1.Play(var_14_0, "anim_educate_topui_hide")

	return
end

function var_0_1.OnDestroy(arg_15_0)
	local var_15_0 = arg_15_0.progressPart

	var_1.Dispose(var_15_0)

	local var_15_1 = arg_15_0.resPart

	var_1.Dispose(var_15_1)
	arg_15_0:UnOverlayPanel(arg_15_0._tf)

	return
end

return var_0_1

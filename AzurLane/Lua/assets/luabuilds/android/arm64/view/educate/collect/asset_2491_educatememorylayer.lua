class = var_0_10000

local var_0_0 = "EducateMemoryLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".EducateCollectLayerTemplate"))
local var_0_2 = {
	frame_1 = "frame1",
	frame_5 = "frame3",
	frame_3 = "frame2",
	frame_4 = "frame3",
	frame_2 = "frame3"
}

function var_0_1.getUIName(arg_1_0)
	return "EducateMemoryUI"
end

function var_0_1.initConfig(arg_2_0)
	pg = var_1_10001
	arg_2_0.config = var_1_10001.child_memory

	return
end

function var_0_1.didEnter(arg_3_0)
	setText = var_1_10001

	local var_3_0 = arg_3_0.windowTF
	local var_3_1 = var_3.Find(var_3_0, "tip")

	i18n = var_1_10004

	var_1_10001(var_3_1, var_1_10004("child_buy_memory_tip"))

	setText = var_1_10001

	local var_3_2 = arg_3_0.performTF
	local var_3_3 = var_3.Find(var_3_2, "review_btn/Text")

	i18n = var_4

	var_1_10001(var_3_3, var_4("child_btn_review"))

	pg = var_1_10001
	arg_3_0.addPrice = var_1_10001.gameset.child_cg_add_price.key_value
	pg = var_1
	arg_3_0.maxPrice = var_1.gameset.child_cg_max_price.key_value

	arg_3_0:Flush()

	return
end

function var_0_1.SetData(arg_4_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)

	arg_4_0.memories = var_1.GetMemories(var_4_0)
	arg_4_0.gameCnt = var_1:GetGameCnt()
	arg_4_0.bugCnt = var_1:GetMemoryBuyCnt()

	return
end

function var_0_1.Flush(arg_5_0)
	arg_5_0:SetData()

	setText = var_1

	var_1(arg_5_0.curCntTF, #arg_5_0.memories)

	setText = var_1

	var_1(arg_5_0.allCntTF, "/" .. #arg_5_0.config.all)
	arg_5_0:updatePage()

	return
end

function var_0_1.updateItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = var_0_2[arg_6_2.name]

	GetImageSpriteFromAtlasAsync = var_4

	var_4("ui/educatememoryui_atlas", var_6_0 .. "_" .. arg_6_1.sp_bg, arg_6_2)

	LoadImageSpriteAsync = var_4

	var_4("bg/" .. arg_6_1.pic, arg_6_2:Find("icon/Image"))

	setText = var_4

	var_4(arg_6_2:Find("unlock/name"), arg_6_1.desc)

	setText = var_4

	var_4(arg_6_2:Find("lock/name"), arg_6_1.lock_name)

	setText = var_4

	var_4(arg_6_2:Find("lock/desc/Text"), arg_6_1.unlock_desc)

	table = var_4

	local var_6_1 = var_4.contains(arg_6_0.memories, arg_6_1.id)

	setActive = var_1_10005

	var_1_10005(arg_6_2:Find("icon/lock"), not var_6_1)

	setActive = var_1_10005

	var_1_10005(arg_6_2:Find("lock"), not var_6_1)

	setActive = var_1_10005

	var_1_10005(arg_6_2:Find("unlock"), var_6_1)

	if var_6_1 then
		setActive = var_1_10005

		local var_6_2 = arg_6_2:Find("unlock/new")

		EducateTipHelper = var_8

		local var_6_3 = var_8.IsShowNewTip

		EducateTipHelper = var_10

		var_1_10005(var_6_2, var_6_3(var_10.NEW_MEMORY, arg_6_1.id))

		onButton = var_1_10005

		local var_6_4 = arg_6_0
		local var_6_5 = arg_6_2

		local function var_6_6()
			local var_7_0 = arg_6_0

			var_0.showPerformWindow(var_7_0, arg_6_1)

			return
		end

		SFX_PANEL = var_10

		var_1_10005(var_6_4, var_6_5, var_6_6, var_10)
	else
		removeOnButton = var_1_10005

		var_1_10005(arg_6_2)

		local var_6_7 = arg_6_2:Find("lock/unlock_btn")

		setActive = var_6

		var_6(var_6_7, arg_6_0.gameCnt > 1)

		onButton = var_6

		local var_6_8 = arg_6_0
		local var_6_9 = var_6_7

		local function var_6_10()
			local var_8_0 = arg_6_0

			var_0.OnClickBuyBtn(var_8_0, arg_6_1)

			return
		end

		SFX_PANEL = var_1_10011

		var_6(var_6_8, var_6_9, var_6_10, var_1_10011)
	end

	return
end

function var_0_1.showPerformWindow(arg_9_0, arg_9_1)
	EducateTipHelper = var_1_10002

	local var_9_0 = var_1_10002.ClearNewTip

	EducateTipHelper = var_1_10004

	var_9_0(var_1_10004.NEW_MEMORY, arg_9_1.id)

	local var_9_1 = arg_9_0.performTF
	local var_9_2 = var_2.Find(var_9_1, "Image")

	LoadImageSpriteAsync = var_1_10003

	var_1_10003("bg/" .. arg_9_1.pic, var_9_2)

	setActive = var_1_10003

	var_1_10003(arg_9_0.performTF, true)

	onButton = var_1_10003

	local var_9_3 = arg_9_0
	local var_9_4 = var_9_2

	local function var_9_5()
		setActive = var_2_10000

		var_2_10000(arg_9_0.performTF, false)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_9_3, var_9_4, var_9_5, var_1_10008)

	onButton = var_1_10003

	local var_9_6 = arg_9_0
	local var_9_7 = arg_9_0.performTF
	local var_9_8 = var_6.Find(var_9_7, "review_btn")

	local function var_9_9()
		pg = var_2_10000

		local var_11_0 = var_2_10000.PerformMgr.GetInstance()

		var_0.PlayOne(var_11_0, arg_9_1.performance)

		return
	end

	SFX_PANEL = var_9_7

	var_1_10003(var_9_6, var_9_8, var_9_9, var_9_7)

	return
end

function var_0_1.OnClickBuyBtn(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.lock_name

	math = var_1_10003

	local var_12_1 = var_1_10003.min(arg_12_0.maxPrice, arg_12_1.child_cg_basic_price + arg_12_0.bugCnt * arg_12_0.addPrice)
	local var_12_2 = arg_12_0
	local var_12_3 = arg_12_0.emit

	EducateBaseUI = var_7

	local var_12_4 = var_7.EDUCATE_ON_MSG_TIP
	local var_12_5 = {}

	i18n = var_1_10009
	var_12_5.content = var_1_10009("child_cg_buy", var_12_1, var_12_0)

	function var_12_5.onYes()
		local var_13_0 = arg_12_0
		local var_13_1 = var_0.emit

		EducateCollectMediatorTemplate = var_2_10003

		local var_13_2 = var_2_10003.UNLOCK
		local var_13_3 = {}

		EducateBuyCollectCommand = var_2_10005
		var_13_3.type = var_2_10005.TYPE.MEMORY
		var_13_3.id = arg_12_1.id
		var_13_3.cost = var_12_1

		var_13_1(var_13_0, var_13_2, var_13_3)

		return
	end

	var_12_3(var_12_2, var_12_4, var_12_5)

	return
end

function var_0_1.playAnimChange(arg_14_0)
	local var_14_0 = arg_14_0.anim

	var_1.Stop(var_14_0)

	local var_14_1 = arg_14_0.anim

	var_1.Play(var_14_1, "anim_educate_memory_change")

	return
end

function var_0_1.playAnimClose(arg_15_0)
	local var_15_0 = arg_15_0.anim

	var_1.Play(var_15_0, "anim_educate_memory_out")

	return
end

return var_0_1

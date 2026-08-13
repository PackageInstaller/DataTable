class = var_0_10000

local var_0_0 = "EducateEndingLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".EducateCollectLayerTemplate"))
local var_0_2 = {
	frame_1 = "frame1",
	frame_5 = "frame3",
	frame_3 = "frame2",
	frame_4 = "frame3",
	frame_2 = "frame2"
}

function var_0_1.getUIName(arg_1_0)
	return "EducateEndingUI"
end

function var_0_1.initConfig(arg_2_0)
	pg = var_1_10001
	arg_2_0.config = var_1_10001.child_ending

	return
end

function var_0_1.didEnter(arg_3_0)
	setText = var_1_10001

	local var_3_0 = arg_3_0.windowTF
	local var_3_1 = var_2.Find(var_3_0, "tip")

	i18n = var_3_0

	var_1_10001(var_3_1, var_3_0("child_buy_ending_tip"))

	setText = var_1_10001

	local var_3_2 = arg_3_0.performTF
	local var_3_3 = var_2.Find(var_3_2, "review_btn/Text")

	i18n = var_3_2

	var_1_10001(var_3_3, var_3_2("child_btn_review"))

	local var_3_4 = arg_3_0.windowTF

	arg_3_0.tpl = var_1.Find(var_3_4, "condition_tpl")
	pg = var_1
	arg_3_0.addPrice = var_1.gameset.child_cg_add_price.key_value
	pg = var_1
	arg_3_0.maxPrice = var_1.gameset.child_cg_max_price.key_value

	arg_3_0:Flush()

	return
end

function var_0_1.SetData(arg_4_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)

	arg_4_0.endings = var_1.GetAllEndings(var_4_0)
	arg_4_0.completeEndings = var_1:GetCompleteEndings()
	arg_4_0.char = var_1:GetCharData()
	arg_4_0.gameCnt = var_1:GetGameCnt()
	arg_4_0.bugCnt = var_1:GetEndingBuyCnt()

	return
end

function var_0_1.Flush(arg_5_0)
	arg_5_0:SetData()

	setText = var_1

	var_1(arg_5_0.curCntTF, #arg_5_0.endings)

	setText = var_1

	var_1(arg_5_0.allCntTF, "/" .. #arg_5_0.config.all)
	arg_5_0:updatePage()

	return
end

function var_0_1.updateItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = var_0_2[arg_6_2.name]

	GetImageSpriteFromAtlasAsync = var_4

	var_4("ui/educateendingui_atlas", var_6_0 .. "_" .. arg_6_1.sp_bg, arg_6_2)

	LoadImageSpriteAsync = var_4

	var_4("bg/" .. arg_6_1.pic, arg_6_2:Find("icon/Image"))

	setText = var_4

	var_4(arg_6_2:Find("unlock/name"), arg_6_1.name)

	setText = var_4

	var_4(arg_6_2:Find("lock/name"), arg_6_1.lock_name)

	table = var_4

	local var_6_1 = var_4.contains(arg_6_0.endings, arg_6_1.id)

	setActive = var_5

	var_5(arg_6_2:Find("icon/lock"), not var_6_1)

	setActive = var_5

	var_5(arg_6_2:Find("unlock"), var_6_1)

	setActive = var_5

	var_5(arg_6_2:Find("lock"), not var_6_1)

	if var_6_1 then
		onButton = var_5

		local var_6_2 = arg_6_0
		local var_6_3 = arg_6_2

		local function var_6_4()
			local var_7_0 = arg_6_0

			var_0.showPerformWindow(var_7_0, arg_6_1)

			return
		end

		SFX_PANEL = var_1_10009

		var_5(var_6_2, var_6_3, var_6_4, var_1_10009)

		setActive = var_5

		local var_6_5 = arg_6_2
		local var_6_6 = arg_6_2.Find(var_6_5, "unlock/complete")

		table = var_6_5

		var_5(var_6_6, var_6_5.contains(arg_6_0.completeEndings, arg_6_1.id))
	else
		removeOnButton = var_5

		var_5(arg_6_2)

		local var_6_7 = arg_6_2:Find("lock/desc/conditions")
		local var_6_8 = arg_6_1.condition

		arg_6_0:updateConditions(var_6_8, var_6_7)

		setActive = var_7

		var_7(var_6_7, #arg_6_1.condition > 0)

		local var_6_9 = arg_6_2
		local var_6_10 = arg_6_2.Find(var_6_9, "lock/desc/Text")

		setText = var_6_9

		var_6_9(var_6_10, arg_6_1.unlock_desc)

		setActive = var_6_9

		var_6_9(var_6_10, arg_6_1.unlock_desc ~= "")

		local var_6_11 = arg_6_2
		local var_6_12 = arg_6_2.Find(var_6_11, "lock/unlock_btn")

		setActive = var_6_11

		var_6_11(var_6_12, arg_6_0.gameCnt > 1)

		onButton = var_6_11

		local var_6_13 = arg_6_0
		local var_6_14 = var_6_12

		local function var_6_15()
			local var_8_0 = arg_6_0

			var_0.OnClickBuyBtn(var_8_0, arg_6_1)

			return
		end

		SFX_PANEL = var_1_10013

		var_6_11(var_6_13, var_6_14, var_6_15, var_1_10013)
	end

	return
end

function var_0_1.updateConditions(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = 0

	for iter_9_0 = 1, #arg_9_1 do
		local var_9_1 = arg_9_1[iter_9_0][1]

		EducateConst = var_1_10010

		if var_9_1 == var_1_10010.DROP_TYPE_ATTR then
			var_9_0 = var_9_0 + 1

			if iter_9_0 <= arg_9_2.childCount then
				var_1_10010 = arg_9_2

				local var_9_2

				if not arg_9_2.GetChild(var_1_10010, iter_9_0 - 1) then
					cloneTplTo = var_9_2
					var_9_2 = var_9_2(arg_9_0.tpl, arg_9_2)
				end

				var_1_10010 = false

				local var_9_3 = ""
				local var_9_6

				if var_1_10008[3] then
					local var_9_4 = arg_9_0.char

					var_1_10010 = var_9_6.GetAttrById(var_9_4, var_1_10008[2]) >= var_1_10008[3]
					pg = var_9_6
					var_9_3 = var_9_6.child_attr[var_1_10008[2]].name .. " > " .. var_1_10008[3]
				else
					local var_9_5 = arg_9_0.char

					var_1_10010 = var_9_6.GetPersonalityId(var_9_5) == var_1_10008[2]
					i18n = var_9_6
					var_9_6 = var_9_6("child_nature_title")
					pg = var_13
					var_9_3 = var_9_6 .. var_13.child_attr[var_1_10008[2]].name
				end

				setActive = var_9_6

				var_9_6(var_9_2:Find("icon/unlock"), var_1_10010)

				local var_9_7 = var_1_10010 and "F59F48" or "FFFFFF"

				setTextColor = var_13

				local var_9_8 = var_9_2
				local var_9_9 = var_9_2.Find(var_9_8, "Text")

				Color = var_9_8

				var_13(var_9_9, var_9_8.NewHex(var_9_7))

				setText = var_13

				var_13(var_9_2:Find("Text"), var_9_3)
			end
		end
	end

	for iter_9_1 = 1, arg_9_2.childCount do
		setActive = var_1_10008

		var_1_10008(arg_9_2:GetChild(iter_9_1 - 1), iter_9_1 <= var_9_0)
	end

	return
end

function var_0_1.showPerformWindow(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.performTF
	local var_10_1 = var_2.Find(var_10_0, "Image")

	LoadImageSpriteAsync = var_10_0

	var_10_0("bg/" .. arg_10_1.pic, var_10_1)

	setActive = var_10_0

	var_10_0(arg_10_0.performTF, true)

	onButton = var_10_0

	local var_10_2 = arg_10_0
	local var_10_3 = var_10_1

	local function var_10_4()
		setActive = var_2_10000

		var_2_10000(arg_10_0.performTF, false)

		return
	end

	SFX_PANEL = var_1_10007

	var_10_0(var_10_2, var_10_3, var_10_4, var_1_10007)

	onButton = var_10_0

	local var_10_5 = arg_10_0
	local var_10_6 = arg_10_0.performTF
	local var_10_7 = var_5.Find(var_10_6, "review_btn")

	local function var_10_8()
		pg = var_2_10000

		local var_12_0 = var_2_10000.PerformMgr.GetInstance()

		var_0.PlayGroup(var_12_0, arg_10_1.performance)

		return
	end

	SFX_PANEL = var_7

	var_10_0(var_10_5, var_10_7, var_10_8, var_7)

	return
end

function var_0_1.OnClickBuyBtn(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.lock_name

	math = var_1_10003

	local var_13_1 = var_1_10003.min(arg_13_0.maxPrice, arg_13_1.child_cg_basic_price + arg_13_0.bugCnt * arg_13_0.addPrice)
	local var_13_2 = arg_13_0
	local var_13_3 = arg_13_0.emit

	EducateBaseUI = var_6

	local var_13_4 = var_6.EDUCATE_ON_MSG_TIP
	local var_13_5 = {}

	i18n = var_1_10008
	var_13_5.content = var_1_10008("child_cg_buy", var_13_1, var_13_0)

	function var_13_5.onYes()
		local var_14_0 = arg_13_0
		local var_14_1 = var_0.emit

		EducateCollectMediatorTemplate = var_2_10002

		local var_14_2 = var_2_10002.UNLOCK
		local var_14_3 = {}

		EducateBuyCollectCommand = var_2_10004
		var_14_3.type = var_2_10004.TYPE.ENDING
		var_14_3.id = arg_13_1.id
		var_14_3.cost = var_13_1

		var_14_1(var_14_0, var_14_2, var_14_3)

		return
	end

	var_13_3(var_13_2, var_13_4, var_13_5)

	return
end

function var_0_1.playAnimChange(arg_15_0)
	local var_15_0 = arg_15_0.anim

	var_1.Stop(var_15_0)

	local var_15_1 = arg_15_0.anim

	var_1.Play(var_15_1, "anim_educate_ending_change")

	return
end

function var_0_1.playAnimClose(arg_16_0)
	local var_16_0 = arg_16_0.anim

	var_1.Play(var_16_0, "anim_educate_ending_out")

	return
end

return var_0_1

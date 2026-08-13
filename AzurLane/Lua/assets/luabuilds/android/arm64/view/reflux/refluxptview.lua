class = var_0_10000

local var_0_0 = "RefluxPTView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "RefluxPTUI"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:updateUI()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	return
end

function var_0_1.OnBackPress(arg_4_0)
	arg_4_0:Hide()

	return
end

function var_0_1.initData(arg_5_0)
	getProxy = var_1_10001
	RefluxProxy = var_1_10003
	arg_5_0.refluxProxy = var_1_10001(var_1_10003)

	return
end

function var_0_1.initUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.nextBtn = var_1.Find(var_6_0, "NextBtn")

	local var_6_1 = arg_6_0._tf

	arg_6_0.countText = var_1.Find(var_6_1, "PTCount")

	local var_6_2 = arg_6_0.countText
	local var_6_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006

	local var_6_4 = var_6_3(var_6_2, var_4(var_1_10006))

	Object = var_1_10002
	var_6_4.material = var_1_10002.Instantiate(var_6_4.material)
	arg_6_0.faceSpriteList = {}

	local var_6_5 = arg_6_0._tf
	local var_6_6 = var_2.Find(var_6_5, "Face")

	for iter_6_0 = 0, var_6_6.childCount - 1 do
		local var_6_7 = var_6_6
		local var_6_8 = var_6_6.GetChild(var_6_7, iter_6_0)

		getImageSprite = var_1_10008
		var_1_10008 = var_1_10008(var_6_8)
		table = var_6_7

		var_6_7.insert(arg_6_0.faceSpriteList, var_1_10008)
	end

	local var_6_9 = arg_6_0._tf

	arg_6_0.scrollViewTF = var_3.Find(var_6_9, "ScrollRect")
	arg_6_0.viewportTF = arg_6_0.scrollViewTF

	local var_6_10 = arg_6_0._tf

	arg_6_0.tpl = var_3.Find(var_6_10, "StepTpl")

	local var_6_11 = arg_6_0._tf

	arg_6_0.tplContainerTF = var_3.Find(var_6_11, "ScrollRect/Container")
	UIItemList = var_3
	arg_6_0.stepUIIList = var_3.New(arg_6_0.tplContainerTF, arg_6_0.tpl)

	local var_6_12 = arg_6_0.stepUIIList

	var_3.make(var_6_12, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			arg_7_1 = arg_7_1 + 1

			local var_7_0 = arg_6_0

			var_3.updateTpl(var_7_0, arg_7_2, arg_7_1)
		end

		return
	end)

	return
end

function var_0_1.updateData(arg_8_0)
	return
end

function var_0_1.updateUI(arg_9_0)
	arg_9_0:updateTplList()
	arg_9_0:ScrollPt(arg_9_0.refluxProxy.ptStage - 1)

	setText = var_1

	var_1(arg_9_0.countText, arg_9_0.refluxProxy.ptNum)

	return
end

function var_0_1.updateOutline(arg_10_0)
	local var_10_0 = arg_10_0.countText
	local var_10_1 = var_1.GetComponent

	typeof = var_1_10004
	Text = var_1_10006

	local var_10_2 = var_10_1(var_10_0, var_1_10004(var_1_10006))

	Object = var_1_10002
	var_10_2.material = var_1_10002.Instantiate(var_10_2.material)

	return
end

function var_0_1.updateTpl(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1:Find("item")
	local var_11_1 = var_3.Find(var_11_0, "award")
	local var_11_2 = var_3:Find("text_unlock")
	local var_11_3 = var_3:Find("text_pt")
	local var_11_4 = arg_11_1:Find("checked")
	local var_11_5 = arg_11_1:Find("face")
	local var_11_6 = arg_11_1:Find("progress")
	local var_11_7 = var_9.Find(var_11_6, "text")
	local var_11_8 = var_9
	local var_11_9 = var_9.Find(var_11_8, "Fill Area")
	local var_11_10 = arg_11_1:Find("achieve")

	pg = var_11_8

	local var_11_11 = var_11_8.return_pt_template[arg_11_2]
	local var_11_12 = arg_11_0.refluxProxy.ptNum
	local var_11_13 = var_11_11.pt_require
	local var_11_14 = arg_11_0.refluxProxy.ptStage + 1
	local var_11_15 = arg_11_0.refluxProxy.ptStage
	local var_11_16 = arg_11_0:getAwardForShow(arg_11_2)

	updateDrop = var_1_10019

	var_1_10019(var_11_1, var_11_16, {
		Q = true
	})

	setText = var_1_10019

	local var_11_17 = var_11_2

	i18n = var_22

	var_1_10019(var_11_17, var_22("reflux_word_2"))

	setText = var_1_10019

	var_1_10019(var_11_3, var_11_13 .. "PT")

	setActive = var_1_10019

	var_1_10019(var_11_4, arg_11_2 < var_11_14)

	if arg_11_2 < var_11_14 then
		Color = var_1_10019

		if not var_1_10019.gray then
			Color = var_1_10019
			var_1_10019 = var_1_10019.white
		end

		local var_11_18 = arg_11_1
		local var_11_19 = arg_11_1.GetComponentsInChildren

		typeof = var_23
		Image = var_1_10025

		local var_11_20 = var_11_19(var_11_18, var_23(var_1_10025))
		local var_11_21 = var_20.ToTable(var_11_20)

		ipairs = var_21

		for iter_11_0, iter_11_1 in var_21(var_11_21) do
			iter_11_1.color = var_1_10019
		end

		setImageColor = var_21

		var_21(var_3, var_1_10019)

		local var_11_22 = arg_11_0
		local var_11_23, var_11_24 = arg_11_0.getPTMinAndMax(var_11_22, arg_11_2)

		Vector2 = var_11_22
		var_9.sizeDelta = var_11_22(125, 20)
		setSlider = var_23

		var_23(var_9, var_11_23, var_11_24, var_11_12)

		setActive = var_23

		var_23(var_11_9, var_11_23 < var_11_12)

		setText = var_23

		var_23(var_11_7, var_11_13 .. "PT")

		local var_11_25 = arg_11_2 == var_11_14 and var_11_13 <= var_11_12

		setActive = var_24

		var_24(var_11_10, var_11_25)

		local var_11_26

		if var_11_25 then
			onButton = var_24
			var_11_26 = arg_11_0

			local var_11_27 = arg_11_1

			local function var_11_28()
				local var_12_0 = arg_11_0

				var_0.onStepClick(var_12_0, arg_11_2)

				return
			end

			SFX_PANEL = var_1_10029

			var_24(var_11_26, var_11_27, var_11_28, var_1_10029)
		else
			removeOnButton = var_24

			var_24(arg_11_1)
		end

		local var_11_29 = (arg_11_2 - 1) % 10 + 1
		local var_11_30 = arg_11_0.faceSpriteList[var_11_29]

		setImageSprite = var_11_26

		var_11_26(var_11_5, var_11_30)

		return
	end
end

function var_0_1.updateTplList(arg_13_0)
	local var_13_0 = arg_13_0.stepUIIList
	local var_13_1 = var_1.align

	pg = var_1_10004

	var_13_1(var_13_0, #var_1_10004.return_pt_template.all)

	return
end

function var_0_1.updateAfterServer(arg_14_0)
	pg = var_1_10001

	local var_14_0 = #var_1_10001.return_pt_template.all
	local var_14_1 = arg_14_0.refluxProxy.ptStage + 1 - 1

	if var_2 <= var_14_0 and var_2 >= 1 then
		local var_14_2 = arg_14_0.tplContainerTF
		local var_14_3 = var_4.GetChild(var_14_2, var_2 - 1)

		arg_14_0:updateTpl(var_14_3, var_2)
	end

	if var_14_1 <= var_14_0 and var_14_1 >= 1 then
		local var_14_4 = arg_14_0.tplContainerTF
		local var_14_5 = var_4.GetChild(var_14_4, var_14_1 - 1)

		arg_14_0:updateTpl(var_14_5, var_14_1)
	end

	arg_14_0:ScrollPt(arg_14_0.refluxProxy.ptStage - 1)

	return
end

function var_0_1.ScrollPt(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0.tplContainerTF
	local var_15_1 = var_4.GetComponent

	typeof = var_1_10007
	HorizontalLayoutGroup = var_1_10009

	local var_15_2 = var_15_1(var_15_0, var_1_10007(var_1_10009))
	local var_15_3 = arg_15_0.tpl
	local var_15_4 = var_5.GetComponent

	typeof = var_1_10008
	LayoutElement = var_1_10010

	local var_15_5 = var_15_4(var_15_3, var_1_10008(var_1_10010))

	math = var_15_0

	local var_15_6 = var_15_0.max(arg_15_1 * (var_15_5.preferredWidth + var_15_2.spacing) - arg_15_0.viewportTF.rect.width * 0.5 + var_15_5.preferredWidth, 0)
	local var_15_7 = arg_15_0.tplContainerTF.childCount * var_15_5.preferredWidth + (arg_15_0.tplContainerTF.childCount - 1) * var_15_2.spacing - arg_15_0.viewportTF.rect.width

	math = var_8

	local var_15_8 = var_8.clamp(var_15_6 / var_15_7, 0, 1)
	local var_15_9 = arg_15_0.scrollViewTF
	local var_15_10 = var_9.GetComponent

	typeof = var_12
	ScrollRect = var_1_10014
	var_15_10(var_15_9, var_12(var_1_10014)).horizontalNormalizedPosition = var_15_8

	return
end

function var_0_1.onStepClick(arg_16_0, arg_16_1)
	local function var_16_0()
		pg = var_2_10000

		local var_17_0 = var_2_10000.m02
		local var_17_1 = var_0.sendNotification

		GAME = var_2_10003

		var_17_1(var_17_0, var_2_10003.REFLUX_GET_PT_AWARD)

		return
	end

	local var_16_1 = arg_16_0

	var_3[1] = arg_16_0.getAwardForShow(var_16_1, arg_16_1).type
	var_3[2] = var_3.id
	var_3[3] = var_3.count

	local var_16_2 = {
		var_3
	}

	Task = var_16_1

	local var_16_3, var_16_4 = var_16_1.StaticJudgeOverflow(false, false, false, true, true, var_16_2)

	if var_16_3 then
		pg = var_7

		local var_16_5 = var_7.MsgboxMgr.GetInstance()
		local var_16_6 = var_7.ShowMsgBox
		local var_16_7 = {}

		MSGBOX_TYPE_ITEM_BOX = var_11
		var_16_7.type = var_11
		i18n = var_11
		var_16_7.content = var_11("award_max_warning")
		var_16_7.items = var_16_4
		var_16_7.onYes = var_16_0

		var_16_6(var_16_5, var_16_7)
	else
		var_16_0()
	end

	return
end

function var_0_1.getAwardForShow(arg_18_0, arg_18_1)
	pg = var_1_10002

	local var_18_0 = var_1_10002.return_pt_template[arg_18_1].level
	local var_18_1 = arg_18_0.refluxProxy.returnLV
	local var_18_2

	ipairs = var_1_10006

	for iter_18_0, iter_18_1 in var_1_10006(var_18_0) do
		local var_18_3 = iter_18_1[1]
		local var_18_4 = iter_18_1[2]

		if var_18_3 <= var_18_1 and var_18_1 <= var_18_4 then
			var_18_2 = iter_18_0
		end
	end

	local var_18_5 = var_2.award_display[var_18_2]

	return {
		type = var_18_5[1],
		id = var_18_5[2],
		count = var_18_5[3]
	}
end

function var_0_1.getPTMinAndMax(arg_19_0, arg_19_1)
	local var_19_0
	local var_19_1

	pg = var_1_10004

	local var_19_2 = var_1_10004.return_pt_template[arg_19_1].pt_require
	local var_19_3 = arg_19_1 - 1

	pg = var_1_10006

	if var_1_10006.return_pt_template[var_19_3] then
		var_19_0 = var_6.pt_require
	else
		var_19_0 = 0
	end

	return var_19_0, var_19_2
end

function var_0_1.isAnyPTCanGetAward()
	pg = var_1_10000

	local var_20_0 = #var_1_10000.return_pt_template.all

	getProxy = var_1_10001
	RefluxProxy = var_1_10003

	if var_1_10001(var_1_10003).ptStage + 1 <= var_20_0 then
		pg = var_1_10003

		return var_1_10003.return_pt_template[var_2].pt_require <= var_1.ptNum
	else
		return false
	end

	return
end

return var_0_1

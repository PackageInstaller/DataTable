class = var_0_10000

local var_0_0 = "RefluxSignView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "RefluxSignUI"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:updateUI()
	arg_2_0:tryAutoSign()

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
	arg_5_0.dayAwardList = arg_5_0:getAllAwardList()
	pg = var_1
	arg_5_0.totalSignCount = #var_1.return_sign_template.all

	return
end

function var_0_1.initUI(arg_6_0)
	local var_6_0 = arg_6_0._tf
	local var_6_1 = var_1.Find(var_6_0, "DayImg")

	arg_6_0.daySpriteList = {}

	for iter_6_0 = 0, arg_6_0.totalSignCount - 1 do
		local var_6_2 = var_6_1
		local var_6_3 = var_6_1.GetChild(var_6_2, iter_6_0)

		getImageSprite = var_1_10007
		var_1_10007 = var_1_10007(var_6_3)
		table = var_6_2

		var_6_2.insert(arg_6_0.daySpriteList, var_1_10007)
	end

	local var_6_4 = arg_6_0._tf

	arg_6_0.dayTpl = var_2.Find(var_6_4, "DayTpl")

	local var_6_5 = arg_6_0._tf

	arg_6_0.scrollRectTF = var_2.Find(var_6_5, "ScrollRect")

	local var_6_6 = arg_6_0._tf

	arg_6_0.dayContainerTF = var_2.Find(var_6_6, "ScrollRect/Container")

	local var_6_7 = arg_6_0._tf

	arg_6_0.signCountText = var_2.Find(var_6_7, "DayCount/Text")
	UIItemList = var_2
	arg_6_0.dayUIItemList = var_2.New(arg_6_0.dayContainerTF, arg_6_0.dayTpl)

	local var_6_8 = arg_6_0.dayUIItemList

	var_2.make(var_6_8, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_7_2:Find("Item1/Icon")
			local var_7_1 = arg_7_2:Find("Item2/Icon")
			local var_7_2 = arg_7_2:Find("Item3/Icon")
			local var_7_3 = arg_7_2:Find("DayImg")
			local var_7_4 = arg_7_2:Find("Got")
			local var_7_5 = arg_7_2:Find("GotMask")
			local var_7_6 = {
				var_7_0,
				var_7_1,
				var_7_2
			}

			arg_7_1 = arg_7_1 + 1

			local var_7_7 = arg_6_0.dayAwardList[arg_7_1]

			ipairs = var_11

			for iter_7_0, iter_7_1 in var_11(var_7_6) do
				local var_7_8 = var_7_7[iter_7_0].type

				DROP_TYPE_SHIP = var_2_10018

				if var_7_8 ~= var_2_10018 then
					setImageSprite = var_7_8

					local var_7_9 = iter_7_1

					LoadSprite = var_2_10020

					var_7_8(var_7_9, var_2_10020(var_16:getIcon()))
				else
					Ship = var_7_8
					var_2_10020 = var_7_8.New({
						configId = var_16.id
					})
					var_2_10018 = var_17.getPainting(var_2_10020)
					setImageSprite = var_19

					local var_7_10 = iter_7_1

					LoadSprite = var_2_10022

					var_19(var_7_10, var_2_10022("QIcon/" .. var_2_10018))
				end
			end

			local var_7_11 = arg_7_1 <= arg_6_0.refluxProxy.signCount

			setActive = var_12

			var_12(var_7_4, var_7_11)

			setActive = var_12

			var_12(var_7_5, var_7_11)

			setImageSprite = var_12

			var_12(var_7_3, arg_6_0.daySpriteList[arg_7_1])
		end

		return
	end)

	local var_6_9 = arg_6_0.scrollRectTF
	local var_6_10 = var_2.GetComponent

	typeof = var_5
	ScrollRect = var_1_10007
	arg_6_0.scrollSC = var_6_10(var_6_9, var_5(var_1_10007))

	local var_6_11 = arg_6_0.dayContainerTF
	local var_6_12 = var_2.GetComponent

	typeof = var_5
	HorizontalLayoutGroup = var_1_10007
	arg_6_0.hlgSC = var_6_12(var_6_11, var_5(var_1_10007))
	arg_6_0.hlgLeft = arg_6_0.hlgSC.padding.left
	arg_6_0.hlgSpacing = arg_6_0.hlgSC.spacing

	local var_6_13 = arg_6_0.dayTpl
	local var_6_14 = var_2.GetComponent

	typeof = var_5
	LayoutElement = var_1_10007
	arg_6_0.tplWidth = var_6_14(var_6_13, var_5(var_1_10007)).preferredWidth

	return
end

function var_0_1.updateUI(arg_8_0)
	setText = var_1_10001

	var_1_10001(arg_8_0.signCountText, arg_8_0.refluxProxy.signCount)

	local var_8_0 = arg_8_0.dayUIItemList

	var_1.align(var_8_0, arg_8_0.totalSignCount)
	arg_8_0:autoScroll(arg_8_0.refluxProxy.signCount)

	return
end

function var_0_1.updateOutline(arg_9_0)
	return
end

function var_0_1.getAllAwardList(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = arg_10_0.refluxProxy.returnLV

	ipairs = var_1_10003
	pg = var_1_10005

	for iter_10_0, iter_10_1 in var_1_10003(var_1_10005.return_sign_template.all) do
		pg = var_1_10008

		local var_10_2 = var_1_10008.return_sign_template[iter_10_1].level
		local var_10_3 = var_1_10008.award_display
		local var_10_4 = arg_10_0:getLevelIndex(var_10_1, var_10_2)
		local var_10_5 = {}
		local var_10_6 = var_10_3[var_10_4]

		ipairs = var_14

		for iter_10_2, iter_10_3 in var_14(var_10_6) do
			Drop = var_1_10019
			var_1_10019 = var_1_10019.Create(iter_10_3)
			table = var_1_10020

			var_1_10020.insert(var_10_5, var_1_10019)
		end

		table = var_14

		var_14.insert(var_10_0, var_10_5)
	end

	return var_10_0
end

function var_0_1.getLevelIndex(arg_11_0, arg_11_1, arg_11_2)
	ipairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_2) do
		local var_11_0 = iter_11_1[1]
		local var_11_1 = iter_11_1[2]

		if var_11_0 <= arg_11_1 and arg_11_1 <= var_11_1 then
			return iter_11_0
		end
	end

	return
end

function var_0_1.tryAutoSign(arg_12_0)
	local var_12_0 = arg_12_0.refluxProxy

	if var_1.isCanSign(var_12_0) then
		pg = var_1

		local var_12_1 = var_1.m02
		local var_12_2 = var_1.sendNotification

		GAME = var_1_10004

		var_12_2(var_12_1, var_1_10004.REFLUX_SIGN)
	end

	return
end

function var_0_1.autoScroll(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.dayContainerTF.childCount
	local var_13_1 = 0
	local var_13_2 = arg_13_1 == 1 and 0 or arg_13_1 == arg_13_0.dayContainerTF.childCount and 1 or arg_13_1 / var_13_0
	local var_13_3 = arg_13_0.scrollSC

	math = var_1_10005
	var_13_3.horizontalNormalizedPosition = var_1_10005.clamp(var_13_2, 0, 1)

	return
end

return var_0_1

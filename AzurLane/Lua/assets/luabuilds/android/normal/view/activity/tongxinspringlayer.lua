class = var_0_10000

local var_0_0 = "TongXinSpringLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "TongXinSpringUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0.closedFlag = false

	return
end

function var_0_1.didEnter(arg_3_0)
	findTF = var_1_10001
	arg_3_0.ad = var_1_10001(arg_3_0._tf, "ad")
	GetComponent = var_1

	local var_3_0 = arg_3_0.ad

	typeof = var_3
	Animator = var_1_10004
	arg_3_0.animator = var_1(var_3_0, var_3(var_1_10004))
	GetComponent = var_1

	local var_3_1 = arg_3_0.ad

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_3_0.dftAniEvent = var_1(var_3_1, var_3(var_1_10004))

	local var_3_2 = arg_3_0.dftAniEvent

	var_1.SetEndEvent(var_3_2, function()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end)

	onButton = var_1

	local var_3_3 = arg_3_0

	findTF = var_3

	var_1(var_3_3, var_3(arg_3_0._tf, "ad/clickClose"), function()
		if arg_3_0.closedFlag then
			return
		end

		arg_3_0.closedFlag = true

		local var_5_0 = arg_3_0.animator

		var_0.Play(var_5_0, "anim_kinder_spring_out")

		return
	end)

	onButton = var_1

	local var_3_4 = arg_3_0

	findTF = var_3

	var_1(var_3_4, var_3(arg_3_0._tf, "ad/btnBack"), function()
		if arg_3_0.closedFlag then
			return
		end

		arg_3_0.closedFlag = true

		local var_6_0 = arg_3_0.animator

		var_0.Play(var_6_0, "anim_kinder_spring_out")

		return
	end)

	onButton = var_1

	local var_3_5 = arg_3_0

	findTF = var_3

	var_1(var_3_5, var_3(arg_3_0._tf, "ad/btnHome"), function()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		BaseUI = var_2_10002

		var_7_1(var_7_0, var_2_10002.ON_HOME)

		return
	end)

	pg = var_1

	local var_3_6 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_6, arg_3_0.ad)

	GetComponent = var_1
	findTF = var_3_6

	local var_3_7 = var_3_6(arg_3_0.ad, "bg/img")

	typeof = var_3
	Image = var_4

	local var_3_8 = var_1(var_3_7, var_3(var_4))

	var_1.SetNativeSize(var_3_8)

	GetComponent = var_1
	findTF = var_3_8

	local var_3_9 = var_3_8(arg_3_0.ad, "title/img")

	typeof = var_3
	Image = var_4

	local var_3_10 = var_1(var_3_9, var_3(var_4))

	var_1.SetNativeSize(var_3_10)

	return
end

function var_0_1.createUI(arg_8_0)
	findTF = var_1_10001
	arg_8_0.iconTpl = var_1_10001(arg_8_0._tf, "ad/list/iconTpl")
	setActive = var_1

	var_1(arg_8_0.iconTpl, false)

	findTF = var_1
	arg_8_0.iconContent = var_1(arg_8_0._tf, "ad/list")

	local var_8_0 = arg_8_0.activity
	local var_8_1 = var_1.GetTotalSlotCount(var_8_0)

	arg_8_0.iconTfs = {}

	for iter_8_0 = 1, var_8_1 do
		local var_8_2 = iter_8_0

		tf = var_1_10007
		instantiate = var_1_10008
		var_1_10007 = var_1_10007(var_1_10008(arg_8_0.iconTpl))
		setActive = var_1_10008

		var_1_10008(var_1_10007, true)

		SetParent = var_1_10008

		var_1_10008(var_1_10007, arg_8_0.iconContent)

		onButton = var_1_10008

		var_1_10008(arg_8_0, var_1_10007, function()
			local var_9_0 = arg_8_0

			var_0.clickIcon(var_9_0, var_8_2)

			return
		end)

		table = var_1_10008

		var_1_10008.insert(arg_8_0.iconTfs, var_1_10007)
	end

	return
end

function var_0_1.updateUI(arg_10_0)
	local var_10_0 = arg_10_0.activity
	local var_10_1 = var_1.GetShipIds(var_10_0)
	local var_10_2 = arg_10_0.activity
	local var_10_3 = var_2.GetSlotCount(var_10_2)
	local var_10_4 = arg_10_0.activity
	local var_10_5 = var_3.GetTotalSlotCount(var_10_4)

	for iter_10_0 = 1, var_10_5 do
		local var_10_6 = arg_10_0.iconTfs[iter_10_0]

		findTF = var_1_10009
		var_1_10009 = var_1_10009(var_10_6, "add")
		findTF = var_10

		local var_10_7 = var_10(var_10_6, "lock")

		findTF = var_11

		local var_10_8 = var_11(var_10_6, "char")

		setActive = var_12

		var_12(var_1_10009, false)

		setActive = var_12

		var_12(var_10_7, false)

		setActive = var_12

		var_12(var_10_8, false)

		if iter_10_0 <= var_10_3 then
			if var_10_1[iter_10_0] and var_10_1[iter_10_0] ~= 0 then
				getProxy = var_12
				BayProxy = var_13

				local var_10_9 = var_12(var_13)

				if var_12.RawGetShipById(var_10_9, var_10_1[iter_10_0]) then
					LoadSprite = var_10_9
					var_10_9 = var_10_9("qicon/" .. var_12:getPainting())
					setImageSprite = var_14
					findTF = var_15

					var_14(var_15(var_10_8, "mask/icon"), var_10_9)

					setActive = var_14

					var_14(var_10_8, true)
				else
					setActive = var_10_9

					var_10_9(var_1_10009, true)
				end
			else
				setActive = var_12

				var_12(var_1_10009, true)
			end
		else
			setActive = var_12

			var_12(var_10_7, true)
		end
	end

	return
end

function var_0_1.clickIcon(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.activity

	if arg_11_1 <= var_2.GetSlotCount(var_11_0) then
		local var_11_1 = arg_11_0.activity
		local var_11_2 = var_11_0.GetShipIds(var_11_1)[arg_11_1]

		if 0 < var_11_2 then
			getProxy = var_1_10005
			BayProxy = var_1_10006

			local var_11_3 = var_1_10005(var_1_10006)

			var_1_10005 = var_1_10005.RawGetShipById(var_11_3, var_11_2)
		else
			var_1_10005 = false
		end

		if false then
			var_1_10005 = true
		end

		local var_11_4 = arg_11_0
		local var_11_5 = arg_11_0.emit

		TongXinSpringMediator = var_1_10008

		var_11_5(var_11_4, var_1_10008.OPEN_CHUANWU, arg_11_1, var_1_10005 and var_1_10005 or nil)
	else
		local var_11_6 = arg_11_0

		var_11_0 = arg_11_0.emit
		TongXinSpringMediator = var_1_10005

		var_11_0(var_11_6, var_1_10005.UNLOCK_SLOT, arg_11_0.activity.id)
	end

	print = var_11_0

	var_11_0("点击了第" .. arg_11_1 .. "个")

	return
end

function var_0_1.InitActivity(arg_12_0, arg_12_1)
	arg_12_0.activity = arg_12_1

	arg_12_0:createUI()
	arg_12_0:updateUI()

	return
end

function var_0_1.UpdateActivity(arg_13_0, arg_13_1)
	arg_13_0.activity = arg_13_1

	arg_13_0:updateUI()

	return
end

function var_0_1.willExit(arg_14_0)
	local var_14_0 = arg_14_0.dftAniEvent

	var_1.SetEndEvent(var_14_0, nil)

	arg_14_0.closedFlag = true
	pg = var_1

	local var_14_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_14_1, arg_14_0.ad, arg_14_0._tf)

	return
end

function var_0_1.onBackPressed(arg_15_0)
	if arg_15_0.closedFlag then
		return
	end

	arg_15_0.closedFlag = true

	local var_15_0 = arg_15_0.animator

	var_1.Play(var_15_0, "anim_kinder_spring_out")

	return
end

return var_0_1

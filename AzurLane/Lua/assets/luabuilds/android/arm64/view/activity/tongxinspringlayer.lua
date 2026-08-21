local var_0_0 = class("TongXinSpringLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "TongXinSpringUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.closedFlag = false

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0.ad = findTF(arg_3_0._tf, "ad")
	arg_3_0.animator = GetComponent(arg_3_0.ad, typeof(Animator))
	arg_3_0.dftAniEvent = GetComponent(arg_3_0.ad, typeof(DftAniEvent))

	arg_3_0.dftAniEvent:SetEndEvent(function()
		arg_3_0:closeView()

		return
	end)
	onButton(arg_3_0, findTF(arg_3_0._tf, "ad/clickClose"), function()
		if arg_3_0.closedFlag then
			return
		end

		arg_3_0.closedFlag = true

		arg_3_0.animator:Play("anim_kinder_spring_out")

		return
	end)
	onButton(arg_3_0, findTF(arg_3_0._tf, "ad/btnBack"), function()
		if arg_3_0.closedFlag then
			return
		end

		arg_3_0.closedFlag = true

		arg_3_0.animator:Play("anim_kinder_spring_out")

		return
	end)
	onButton(arg_3_0, findTF(arg_3_0._tf, "ad/btnHome"), function()
		arg_3_0:emit(BaseUI.ON_HOME)

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0.ad)
	GetComponent(findTF(arg_3_0.ad, "bg/img"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(arg_3_0.ad, "title/img"), typeof(Image)):SetNativeSize()

	return
end

function var_0_0.createUI(arg_8_0)
	arg_8_0.iconTpl = findTF(arg_8_0._tf, "ad/list/iconTpl")

	setActive(arg_8_0.iconTpl, false)

	arg_8_0.iconContent = findTF(arg_8_0._tf, "ad/list")
	arg_8_0.iconTfs = {}

	for iter_8_0 = 1, arg_8_0.activity:GetTotalSlotCount() do
		local var_8_0 = iter_8_0
		local var_8_1 = tf(instantiate(arg_8_0.iconTpl))

		setActive(var_8_1, true)
		SetParent(var_8_1, arg_8_0.iconContent)
		onButton(arg_8_0, var_8_1, function()
			arg_8_0:clickIcon(var_8_0)

			return
		end)
		table.insert(arg_8_0.iconTfs, var_8_1)
	end

	return
end

function var_0_0.updateUI(arg_10_0)
	local var_10_0 = arg_10_0.activity:GetShipIds()
	local var_10_1 = arg_10_0.activity:GetSlotCount()

	for iter_10_0 = 1, arg_10_0.activity:GetTotalSlotCount() do
		local var_10_2 = findTF(arg_10_0.iconTfs[iter_10_0], "add")
		local var_10_3 = findTF(arg_10_0.iconTfs[iter_10_0], "lock")
		local var_10_4 = findTF(arg_10_0.iconTfs[iter_10_0], "char")

		setActive(var_10_2, false)
		setActive(var_10_3, false)
		setActive(var_10_4, false)

		if iter_10_0 <= var_10_1 then
			if var_10_0[iter_10_0] and var_10_0[iter_10_0] ~= 0 then
				local var_10_5 = getProxy(BayProxy):RawGetShipById(var_10_0[iter_10_0])

				if var_10_5 then
					setImageSprite(findTF(var_10_4, "mask/icon"), (LoadSprite("qicon/" .. var_10_5:getPainting())))
					setActive(var_10_4, true)
				else
					setActive(var_10_2, true)
				end
			else
				setActive(var_10_2, true)
			end
		else
			setActive(var_10_3, true)
		end
	end

	return
end

function var_0_0.clickIcon(arg_11_0, arg_11_1)
	if arg_11_1 <= arg_11_0.activity:GetSlotCount() then
		local var_11_0 = arg_11_0.activity:GetShipIds()[arg_11_1]
		local var_11_1 = var_11_0 > 0 and getProxy(BayProxy):RawGetShipById(var_11_0)

		arg_11_0:emit(TongXinSpringMediator.OPEN_CHUANWU, arg_11_1, var_11_1 and var_11_1 or nil)
	else
		arg_11_0:emit(TongXinSpringMediator.UNLOCK_SLOT, arg_11_0.activity.id)
	end

	print("点击了第" .. arg_11_1 .. "个")

	return
end

function var_0_0.InitActivity(arg_12_0, arg_12_1)
	arg_12_0.activity = arg_12_1

	arg_12_0:createUI()
	arg_12_0:updateUI()

	return
end

function var_0_0.UpdateActivity(arg_13_0, arg_13_1)
	arg_13_0.activity = arg_13_1

	arg_13_0:updateUI()

	return
end

function var_0_0.willExit(arg_14_0)
	arg_14_0.dftAniEvent:SetEndEvent(nil)

	arg_14_0.closedFlag = true

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_14_0.ad, arg_14_0._tf)

	return
end

function var_0_0.onBackPressed(arg_15_0)
	if arg_15_0.closedFlag then
		return
	end

	arg_15_0.closedFlag = true

	arg_15_0.animator:Play("anim_kinder_spring_out")

	return
end

return var_0_0

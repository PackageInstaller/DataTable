class = var_0_10000

local var_0_0 = "LoadingPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0)

	seriesAsync = var_2

	var_2({
		function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.preload(var_2_0, arg_2_0)

			return
		end
	}, function()
		PoolMgr = var_2_10000

		local var_3_0 = var_2_10000.GetInstance()

		var_0.GetUI(var_3_0, "Loading", true, function(arg_4_0)
			GameObject = var_3_10001

			local var_4_0 = var_3_10001.Find("Overlay/UIOverlay")
			local var_4_1 = arg_4_0.transform

			var_2.SetParent(var_4_1, var_4_0.transform, false)
			arg_4_0:SetActive(false)

			local var_4_2 = arg_1_0

			var_2.onUILoaded(var_4_2, arg_4_0)
			arg_1_1()

			return
		end)

		return
	end)

	return
end

function var_0_1.preload(arg_5_0, arg_5_1)
	getLoginConfig = var_1_10002

	local var_5_0, var_5_1 = var_1_10002()

	arg_5_0.bgPath = var_5_1
	arg_5_0.isCri = var_5_0

	if arg_5_0.isCri then
		LoadAndInstantiateAsync = var_5_2

		var_5_2("effect", arg_5_0.bgPath, function(arg_6_0)
			arg_5_0.criBgGo = arg_6_0

			if arg_5_1 then
				arg_5_1()
			end

			return
		end)
	else
		LOGIN_HX = var_5_2

		local var_5_2

		if var_5_2 then
			PlayerProxy = var_5_2
			var_5_2 = var_5_2.GetDeviceMaxPlayerLevel()
			pg = var_5_1
			var_5_2 = var_5_2 <= var_5_1.gameset.LOGIN_HX_LV.key_value
		end

		local var_5_3 = var_5_2 and "loadingbg_hx/" or "loadingbg/"

		LoadSpriteAsync = var_1_10004

		var_1_10004(var_5_3 .. arg_5_0.bgPath, function(arg_7_0)
			arg_5_0.staticBgSprite = arg_7_0

			if arg_5_1 then
				arg_5_1()
			end

			return
		end)
	end

	return
end

function var_0_1.init(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.infos = var_1.Find(var_8_0, "infos")
	arg_8_0.infoTpl = arg_8_0:getTpl("infos/info_tpl")

	local var_8_1 = arg_8_0._tf

	arg_8_0.indicator = var_1.Find(var_8_1, "load")

	local var_8_2 = arg_8_0._tf

	arg_8_0.bg = var_1.Find(var_8_2, "BG")

	arg_8_0:displayBG(true)

	return
end

function var_0_1.appendInfo(arg_9_0, arg_9_1)
	cloneTplTo = var_1_10002

	local var_9_0 = var_1_10002(arg_9_0.infoTpl, arg_9_0.infos)

	setText = var_1_10003

	var_1_10003(var_9_0, arg_9_1)

	GetOrAddComponent = var_1_10003

	local var_9_1 = var_1_10003(var_9_0, "CanvasGroup")

	LeanTween = var_4

	local var_9_2 = var_4.alphaCanvas(var_9_1, 0, 0.3)

	var_4.setDelay(var_9_2, 1.5)

	local var_9_3 = var_4
	local var_9_4 = var_4.setOnComplete

	System = var_8

	var_9_4(var_9_3, var_8.Action(function()
		destroy = var_2_10000

		var_2_10000(var_9_0)

		return
	end))

	return
end

function var_0_1.onLoading(arg_11_0)
	return arg_11_0._go.activeInHierarchy
end

local var_0_2 = 0

function var_0_1.on(arg_12_0, arg_12_1)
	defaultValue = var_1_10002

	local var_12_0

	if var_1_10002(arg_12_0.displayIndicator, true) then
		defaultValue = var_12_0
		var_12_0 = var_12_0(arg_12_1, true)
	end

	arg_12_0.displayIndicator = var_12_0
	setImageAlpha = var_12_0

	var_12_0(arg_12_0._tf, arg_12_1 and 0.01 or 0)

	if not arg_12_0.displayIndicator then
		setActive = var_2

		var_2(arg_12_0.indicator, arg_12_1)

		if arg_12_0.delayTimer then
			pg = var_2

			local var_12_1 = var_2.TimeMgr.GetInstance()

			var_2.RemoveTimer(var_12_1, arg_12_0.delayTimer)

			arg_12_0.delayTimer = nil
		end
	elseif not arg_12_0.delayTimer then
		pg = var_2

		local var_12_2 = var_2.TimeMgr.GetInstance()

		arg_12_0.delayTimer = var_2.AddTimer(var_12_2, "loading", 1, 0, function()
			setImageAlpha = var_2_10000

			var_2_10000(arg_12_0._tf, 0.2)

			setActive = var_2_10000

			var_2_10000(arg_12_0.indicator, true)

			return
		end)
	end

	if var_0_2 * (var_0_2 + 1) == 0 then
		setActive = var_2

		var_2(arg_12_0._go, true)

		local var_12_3 = arg_12_0._go.transform

		var_2.SetAsLastSibling(var_12_3)
	end

	var_0_2 = var_0_2 + 1

	return
end

function var_0_1.off(arg_14_0)
	if var_0_2 * (var_0_2 - 1) == 0 then
		setActive = var_1

		var_1(arg_14_0._go, false)

		setActive = var_1

		var_1(arg_14_0.indicator, false)

		arg_14_0.displayIndicator = true

		if arg_14_0.delayTimer then
			pg = var_1

			local var_14_0 = var_1.TimeMgr.GetInstance()

			var_1.RemoveTimer(var_14_0, arg_14_0.delayTimer)

			arg_14_0.delayTimer = nil
		end
	end

	var_0_2 = var_0_2 - 1
	assert = var_1

	var_1(var_0_2 >= 0)

	return
end

function var_0_1.displayBG(arg_15_0, arg_15_1)
	setActive = var_1_10002

	var_1_10002(arg_15_0.bg, arg_15_1)

	GetComponent = var_1_10002

	local var_15_0 = var_1_10002(arg_15_0.bg, "Image")

	if arg_15_1 then
		if not arg_15_0.isCri then
			IsNil = var_3

			if var_3(var_15_0.sprite) then
				var_15_0.sprite = arg_15_0.staticBgSprite
			end
		elseif arg_15_0.bg.childCount == 0 then
			var_15_0.enabled = false

			local var_15_1 = arg_15_0.criBgGo.transform

			var_3.SetParent(var_15_1, arg_15_0.bg.transform, false)
			var_3:SetAsFirstSibling()

			local var_15_2 = arg_15_0.criBgGo

			if var_4.GetComponent(var_15_2, "AspectRatioFitter") then
				var_4.enabled = true
			end
		end
	else
		if not arg_15_0.isCri then
			var_15_0.sprite = nil
		else
			removeAllChildren = var_3

			var_3(arg_15_0.bg)
		end

		arg_15_0.criBgGo = nil
		arg_15_0.staticBgSprite = nil
	end

	return
end

function var_0_1.getRetainCount(arg_16_0)
	return var_0_2
end

return var_0_1

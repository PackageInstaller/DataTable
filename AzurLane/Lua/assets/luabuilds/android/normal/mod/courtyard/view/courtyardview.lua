class = var_0_10000

local var_0_0 = var_0_10000("CourtYardBaseView")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.name = arg_1_1
	arg_1_0.storey = arg_1_2

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.isInit = false

	local var_2_0 = arg_2_0:GetStoreyModule()
	local var_2_1

	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_3_0)
			local var_3_0 = arg_2_0

			var_1.LoadUI(var_3_0, var_2_0.__cname, function(arg_4_0)
				var_2_1 = arg_4_0

				arg_3_0()

				return
			end)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_2_0

			var_1.InitObjPool(var_5_0, arg_5_0)

			return
		end
	}, function()
		arg_2_0.storeyModule = var_2_0.New(arg_2_0.storey, var_2_1)
		arg_2_0.isInit = true

		return
	end)

	return
end

function var_0_0.IsInit(arg_7_0)
	return arg_7_0.isInit == true
end

function var_0_0.LoadUI(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.resName = arg_8_1
	ResourceMgr = var_1_10003

	local var_8_0 = var_1_10003.Inst
	local var_8_1 = var_3.getAssetAsync
	local var_8_2 = "UI/" .. arg_8_0.resName
	local var_8_3 = ""

	UnityEngine = var_1_10007

	var_8_1(var_8_0, var_8_2, var_8_3, var_1_10007.Events.UnityAction_UnityEngine_Object(function(arg_9_0)
		local var_9_0
		local var_9_1 = arg_8_0.storey
		local var_9_2 = var_2.GetStyle(var_9_1)

		CourtYardConst = var_9_1

		if var_9_2 == var_9_1.STYLE_PREVIEW then
			pg = var_9_2

			local var_9_3 = var_9_2.UIMgr.GetInstance().OverlayMain

			var_9_0 = var_9_2.Find(var_9_3, "BackYardInterActionPreview(Clone)/frame/view")
		else
			pg = var_9_2

			local var_9_4 = var_9_2.UIMgr.GetInstance().UIMain

			var_9_0 = var_9_2.Find(var_9_4, arg_8_0.name .. "(Clone)")
		end

		Object = var_9_2

		local var_9_5 = var_9_2.Instantiate(arg_9_0, var_9_0)

		arg_8_0._go = var_9_5

		local var_9_6 = var_9_5.transform

		var_3.SetSiblingIndex(var_9_6, 1)

		setActive = var_3

		var_3(var_9_5, true)

		local var_9_7 = arg_8_0
		local var_9_8 = var_9_5.transform

		var_9_7.poolRoot = var_4.Find(var_9_8, "root")

		arg_8_2(var_9_5)

		return
	end), true, true)

	return
end

function var_0_0.GetRect(arg_10_0)
	assert = var_1_10001

	var_1_10001(arg_10_0.storeyModule)

	return arg_10_0.storeyModule.rectTF
end

function var_0_0.GetStoreyModule(arg_11_0)
	local var_11_0 = arg_11_0.storey
	local var_11_1 = {}

	CourtYardConst = var_1_10003

	local var_11_2 = var_1_10003.STYLE_INNER

	CourtYardStoreyModule = var_1_10004
	var_11_1[var_11_2] = var_1_10004
	CourtYardConst = var_11_2

	local var_11_3 = var_11_2.STYLE_OUTSIDE

	CourtYardOutStoreyModule = var_1_10004
	var_11_1[var_11_3] = var_1_10004
	CourtYardConst = var_11_3

	local var_11_4 = var_11_3.STYLE_FEAST

	CourtYardFeastStoreyModule = var_1_10004
	var_11_1[var_11_4] = var_1_10004
	CourtYardConst = var_11_4

	local var_11_5 = var_11_4.STYLE_PREVIEW

	CourtYardStoreyPreviewModule = var_1_10004
	var_11_1[var_11_5] = var_1_10004

	return var_11_1[var_11_0:GetStyle()]
end

function var_0_0.InitObjPool(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.storey
	local var_12_1 = {}

	CourtYardConst = var_1_10004

	local var_12_2 = var_1_10004.STYLE_INNER

	CourtYardPoolMgr = var_1_10005
	var_12_1[var_12_2] = var_1_10005
	CourtYardConst = var_12_2

	local var_12_3 = var_12_2.STYLE_OUTSIDE

	CourtYardPoolMgr = var_1_10005
	var_12_1[var_12_3] = var_1_10005
	CourtYardConst = var_12_3

	local var_12_4 = var_12_3.STYLE_FEAST

	CourtYardFeastPoolMgr = var_1_10005
	var_12_1[var_12_4] = var_1_10005
	CourtYardConst = var_12_4

	local var_12_5 = var_12_4.STYLE_PREVIEW

	CourtYardPoolMgr = var_1_10005
	var_12_1[var_12_5] = var_1_10005

	local var_12_6 = var_12_1[var_12_0:GetStyle()].New()

	var_4.Init(var_12_6, arg_12_0.poolRoot, arg_12_1)

	arg_12_0.poolMgr = var_4

	return
end

function var_0_0.GetCurrStorey(arg_13_0)
	return arg_13_0.storeyModule
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.storeyModule then
		local var_14_0 = arg_14_0.storeyModule

		var_1.Dispose(var_14_0)

		arg_14_0.storeyModule = nil
	end

	arg_14_0.storey = nil

	local var_14_1 = arg_14_0.poolMgr

	var_1.Dispose(var_14_1)

	arg_14_0.poolMgr = nil

	return
end

return var_0_0

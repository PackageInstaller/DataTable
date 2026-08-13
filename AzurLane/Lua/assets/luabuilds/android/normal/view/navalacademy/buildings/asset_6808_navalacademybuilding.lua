class = var_0_10000

local var_0_0 = var_0_10000("NavalAcademyBuilding")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0.parent = arg_1_1

	local var_1_0 = arg_1_1._tf

	arg_1_0._tf = var_2.Find(var_1_0, "academyMap/map/" .. arg_1_0:GetGameObjectName())
	findTF = var_2

	local var_1_1 = var_2(arg_1_0._tf, "name/Text")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	arg_1_0.nameTxt = var_1_2(var_1_1, var_4(var_5))
	findTF = var_2
	arg_1_0.tip = var_2(arg_1_0._tf, "tip")

	return
end

function var_0_0.Init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf

	local function var_2_2()
		local var_3_0 = arg_2_0

		var_0.OnClick(var_3_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	arg_2_0.nameTxt.text = arg_2_0:GetTitle()

	arg_2_0:RefreshTip()
	arg_2_0:OnInit()

	return
end

function var_0_0.RefreshTip(arg_4_0)
	setActive = var_1_10001

	var_1_10001(arg_4_0.tip, arg_4_0:IsTip())

	return
end

function var_0_0.OnInit(arg_5_0)
	return
end

function var_0_0.OnClick(arg_6_0)
	return
end

function var_0_0.IsTip(arg_7_0)
	return false
end

function var_0_0.GetTitle(arg_8_0)
	return ""
end

function var_0_0.GetGameObjectName(arg_9_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_0.emit(arg_10_0, ...)
	local var_10_0 = arg_10_0.parent

	var_1.emit(var_10_0, ...)

	return
end

function var_0_0.Dispose(arg_11_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_11_0)

	return
end

return var_0_0

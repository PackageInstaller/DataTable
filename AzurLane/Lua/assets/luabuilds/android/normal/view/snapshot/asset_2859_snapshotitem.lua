class = var_0_10000

local var_0_0 = var_0_10000("SnapshotItem")

var_0_0.NAME_COLOR = {
	"#FFFFFFFF",
	"#5A9BFFFF"
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0.selected = arg_1_2
	arg_1_0.tr = arg_1_1.transform
	arg_1_0.btn = arg_1_1:GetComponent("Button")
	findTF = var_3
	arg_1_0.nameTF = var_3(arg_1_0.tr, "Text")

	local var_1_0 = arg_1_0.nameTF

	arg_1_0.nameTxt = var_3.GetComponent(var_1_0, "Text")
	findTF = var_3
	arg_1_0.unselectGo = var_3(arg_1_0.tr, "unselect").gameObject
	findTF = var_3
	arg_1_0.selectedGo = var_3(arg_1_0.tr, "selected").gameObject
	arg_1_0.info = nil
	arg_1_0.id = -1

	local var_1_1 = arg_1_0.selectedGo

	var_3.SetActive(var_1_1, false)

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.info = arg_2_1
	arg_2_0.id = arg_2_1.id

	arg_2_0:flush()

	return
end

function var_0_0.UpdateSelected(arg_3_0, arg_3_1)
	arg_3_0.selected = arg_3_1

	local var_3_0 = arg_3_0.unselectGo

	var_2.SetActive(var_3_0, not arg_3_0.selected)

	local var_3_1 = arg_3_0.selectedGo

	var_2.SetActive(var_3_1, arg_3_0.selected)

	if arg_3_0.selected then
		local var_3_2 = arg_3_0.nameTxt

		setColorStr = var_3_1
		var_3_2.text = var_3_1(arg_3_0.info.name, arg_3_0.NAME_COLOR[2])
	else
		local var_3_3 = arg_3_0.nameTxt

		setColorStr = var_3_1
		var_3_3.text = var_3_1(arg_3_0.info.name, arg_3_0.NAME_COLOR[1])
	end

	return
end

function var_0_0.HasInfo(arg_4_0)
	return arg_4_0.info ~= nil
end

function var_0_0.GetID(arg_5_0)
	return arg_5_0.id
end

function var_0_0.flush(arg_6_0)
	arg_6_0.nameTxt.text = arg_6_0.info.name

	return
end

function var_0_0.SetEulerAngle(arg_7_0, arg_7_1)
	rtf = var_1_10002

	local var_7_0 = var_1_10002(arg_7_0.nameTF).eulerAngles

	rtf = var_3

	local var_7_1 = var_3(arg_7_0.nameTF)

	Vector3 = var_4
	var_7_1.eulerAngles = var_4(0, 0, arg_7_1)

	return
end

function var_0_0.RotateUI(arg_8_0, arg_8_1, arg_8_2)
	LeanTween = var_1_10003

	local var_8_0 = var_1_10003.rotateZ

	go = var_1_10004

	var_8_0(var_1_10004(arg_8_0.nameTF), arg_8_1, arg_8_2)

	return
end

return var_0_0

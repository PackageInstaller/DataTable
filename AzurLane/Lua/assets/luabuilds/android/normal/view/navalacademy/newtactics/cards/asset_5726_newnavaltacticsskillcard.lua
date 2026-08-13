class = var_0_10000

local var_0_0 = var_0_10000("NewNavalTacticsSkillCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	findTF = var_1_10002

	local var_1_0 = var_1_10002(arg_1_0._tf, "icon")
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.icon = var_1_1(var_1_0, var_4(var_1_10005))
	findTF = var_2

	local var_1_2 = var_2(arg_1_0._tf, "descView/desc")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.descTxt = var_1_3(var_1_2, var_4(var_1_10005))
	findTF = var_2

	local var_1_4 = var_2(arg_1_0._tf, "next")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nextTxt = var_1_5(var_1_4, var_4(var_1_10005))

	return
end

function var_0_0.Enable(arg_2_0)
	setActive = var_1_10001

	var_1_10001(arg_2_0._tf, true)

	return
end

function var_0_0.Disable(arg_3_0)
	setActive = var_1_10001

	var_1_10001(arg_3_0._tf, false)

	return
end

function var_0_0.Update(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.GetName(var_4_0)

	changeToScrollText = var_4_0

	local var_4_2 = arg_4_0._tf

	var_4_0(var_5.Find(var_4_2, "name/Text"), var_4_1)

	arg_4_0.descTxt.text = arg_4_1:GetTacticsDesc()

	local var_4_3 = "Lv."
	local var_4_4 = arg_4_1.level
	local var_4_5

	if not arg_4_2 or not (arg_4_2 > 0) or not ("  <color=#A9F548FF>+" .. arg_4_2 .. "</color>") then
		var_4_5 = ""
	end

	local var_4_6 = var_4_3 .. var_4_4 .. var_4_5

	setText = var_4_4

	local var_4_7 = arg_4_0._tf

	var_4_4(var_6.Find(var_4_7, "name/level"), var_4_6)

	local var_4_8

	if arg_4_1:IsMaxLevel() then
		var_4_8 = arg_4_0.nextTxt
		var_4_8.text = "MAX"
	else
		var_4_8 = arg_4_0.nextTxt
		var_4_8.text = "<color=#A9F548FF>" .. arg_4_1.exp .. "</color>/" .. arg_4_1:GetNextLevelExp()
	end

	LoadSpriteAsync = var_4_8

	var_4_8("skillicon/" .. arg_4_1:GetIcon(), function(arg_5_0)
		arg_4_0.icon.sprite = arg_5_0

		return
	end)

	return
end

function var_0_0.Dispose(arg_6_0)
	return
end

return var_0_0

local var_0_0 = class("NewNavalTacticsSkillCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0.icon = findTF(arg_1_0._tf, "icon"):GetComponent(typeof(Image))
	arg_1_0.descTxt = findTF(arg_1_0._tf, "descView/desc"):GetComponent(typeof(Text))
	arg_1_0.nextTxt = findTF(arg_1_0._tf, "next"):GetComponent(typeof(Text))

	return
end

function var_0_0.Enable(arg_2_0)
	setActive(arg_2_0._tf, true)

	return
end

function var_0_0.Disable(arg_3_0)
	setActive(arg_3_0._tf, false)

	return
end

function var_0_0.Update(arg_4_0, arg_4_1, arg_4_2)
	changeToScrollText(arg_4_0._tf:Find("name/Text"), (arg_4_1:GetName()))

	arg_4_0.descTxt.text = arg_4_1:GetTacticsDesc()

	local var_4_0 = "Lv."
	local var_4_1 = arg_4_1.level

	if arg_4_2 and arg_4_2 > 0 then
		local var_4_2 = "  <color=#A9F548FF>+" .. arg_4_2 .. "</color>" or ""

		setText(arg_4_0._tf:Find("name/level"), var_4_0 .. var_4_1 .. var_4_2)

		arg_4_0.nextTxt.text = arg_4_1:IsMaxLevel() and "MAX" or "<color=#A9F548FF>" .. arg_4_1.exp .. "</color>/" .. arg_4_1:GetNextLevelExp()

		LoadSpriteAsync("skillicon/" .. arg_4_1:GetIcon(), function(arg_5_0)
			arg_4_0.icon.sprite = arg_5_0

			return
		end)

		return
	end
end

function var_0_0.Dispose(arg_6_0)
	return
end

return var_0_0

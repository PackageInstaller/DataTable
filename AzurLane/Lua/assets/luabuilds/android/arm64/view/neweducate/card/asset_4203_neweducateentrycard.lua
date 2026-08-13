class = var_0_10000

local var_0_0 = var_0_10000("NewEducateEntryCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.iconTF = var_2.Find(var_1_0, "icon/Image")

	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_2.Find(var_1_1, "level/Text")
	local var_1_3 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.levelText = var_1_3(var_1_2, var_5(var_1_10007))

	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_2.Find(var_1_4, "name")
	local var_1_6 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.nameText = var_1_6(var_1_5, var_5(var_1_10007))

	local var_1_7 = arg_1_0._tf
	local var_1_8 = var_2.Find(var_1_7, "desc/content/Text")
	local var_1_9 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.descText = var_1_9(var_1_8, var_5(var_1_10007))

	local var_1_10 = arg_1_0._tf
	local var_1_11 = var_2.Find(var_1_10, "desc/content/effect")
	local var_1_12 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.countText = var_1_12(var_1_11, var_5(var_1_10007))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1
	pg = var_1_10002
	arg_2_0.config = var_1_10002.child2_benefit_list[arg_2_1]

	local var_2_0 = arg_2_0.levelText

	GetRomanDigitPlus = var_1_10003
	var_2_0.text = var_1_10003(arg_2_0.config.rare)
	arg_2_0.nameText.text = arg_2_0.config.name
	arg_2_0.descText.text = arg_2_0.config.simple_desc

	local var_2_1 = arg_2_0.countText

	var_2_1.text = ""
	LoadImageSpriteAsync = var_2_1

	var_2_1("neweducateicon/" .. arg_2_0.config.item_icon, arg_2_0.iconTF, true)

	local var_2_2 = arg_2_0.config.benefit_level
	local var_2_3 = 1 < var_2_2 and "bg_entry_2" or "bg_entry"

	LoadImageSpriteAtlasAsync = var_3

	local var_2_4 = "ui/neweducateentrycard_atlas"
	local var_2_5 = var_2_3
	local var_2_6 = arg_2_0._tf

	var_3(var_2_4, var_2_5, var_7.Find(var_2_6, "icon"))

	return
end

function var_0_0.UpdateDescMode(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.descText
	local var_3_1

	if not arg_3_1 or not arg_3_0.config.desc then
		var_3_1 = arg_3_0.config.simple_desc
	end

	var_3_0.text = var_3_1

	return
end

function var_0_0.UpdateCountDesc(arg_4_0)
	getProxy = var_1_10001
	NewEducateProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = var_1.GetCurChar(var_4_0)
	local var_4_2 = var_1.GetBenefitData(var_4_1)

	Clone = var_1_10002

	local var_4_3 = var_1_10002(arg_4_0.config.count_desc)

	string = var_4_1

	local var_4_4 = var_4_1.gsub(var_4_3, "{(%d+),%$val}", function(arg_5_0)
		local var_5_0 = var_4_2
		local var_5_1 = var_1.GetBuff(var_5_0, arg_4_0.id)

		return var_1.GetDisplayNum(var_5_1, arg_5_0)
	end)

	if var_4_2:GetDisplayCounterData(arg_4_0.config.debuff_tag) then
		string = var_4
		var_4_4 = var_4.gsub(var_4_4, "{(%d+),(%d+),(%d+)}", function(arg_6_0, arg_6_1, arg_6_2)
			local var_6_0 = var_0

			return var_3.GetValue(var_6_0, arg_6_0, arg_6_1, arg_6_2)
		end)
	end

	arg_4_0.countText.text = var_4_4

	return
end

function var_0_0.Dispose(arg_7_0)
	return
end

function var_0_0.StaticShow(arg_8_0, arg_8_1)
	pg = var_1_10002

	local var_8_0 = var_1_10002.child2_benefit_list[arg_8_1]

	setText = var_1_10003

	local var_8_1 = arg_8_0:Find("level/Text")

	GetRomanDigitPlus = var_1_10006

	var_1_10003(var_8_1, var_1_10006(var_8_0.rare))

	setText = var_1_10003

	var_1_10003(arg_8_0:Find("name"), var_8_0.name)

	setText = var_1_10003

	var_1_10003(arg_8_0:Find("desc/content/Text"), var_8_0.desc)

	setText = var_1_10003

	var_1_10003(arg_8_0:Find("desc/content/effect"), "")

	LoadImageSpriteAsync = var_1_10003

	var_1_10003("neweducateicon/" .. var_8_0.item_icon, arg_8_0:Find("icon/Image"), true)

	local var_8_2 = var_8_0.benefit_level
	local var_8_3 = 1 < var_8_2 and "bg_entry_2" or "bg_entry"

	LoadImageSpriteAtlasAsync = var_4

	var_4("ui/neweducateentrycard_atlas", var_8_3, arg_8_0:Find("icon"))

	return
end

return var_0_0

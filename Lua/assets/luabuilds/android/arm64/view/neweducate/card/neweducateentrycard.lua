local var_0_0 = class("NewEducateEntryCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.iconTF = arg_1_0._tf:Find("icon/Image")
	arg_1_0.levelText = arg_1_0._tf:Find("level/Text"):GetComponent(typeof(Text))
	arg_1_0.nameText = arg_1_0._tf:Find("name"):GetComponent(typeof(Text))
	arg_1_0.descText = arg_1_0._tf:Find("desc/content/Text"):GetComponent(typeof(Text))
	arg_1_0.countText = arg_1_0._tf:Find("desc/content/effect"):GetComponent(typeof(Text))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1
	arg_2_0.config = pg.child2_benefit_list[arg_2_1]
	arg_2_0.levelText.text = GetRomanDigitPlus(arg_2_0.config.rare)
	arg_2_0.nameText.text = arg_2_0.config.name
	arg_2_0.descText.text = arg_2_0.config.simple_desc
	arg_2_0.countText.text = ""

	LoadImageSpriteAsync("neweducateicon/" .. arg_2_0.config.item_icon, arg_2_0.iconTF, true)
	LoadImageSpriteAtlasAsync("ui/neweducateentrycard_atlas", arg_2_0.config.benefit_level > 1 and "bg_entry_2" or "bg_entry", arg_2_0._tf:Find("icon"))

	return
end

function var_0_0.UpdateDescMode(arg_3_0, arg_3_1)
	if arg_3_1 then
		arg_3_0.descText.text = arg_3_0.config.desc or arg_3_0.config.simple_desc

		return
	end
end

function var_0_0.UpdateCountDesc(arg_4_0)
	local var_4_0 = getProxy(NewEducateProxy):GetCurChar():GetBenefitData()
	local var_4_1 = string.gsub(Clone(arg_4_0.config.count_desc), "{(%d+),%$val}", function(arg_5_0)
		return var_4_0:GetBuff(arg_4_0.id):GetDisplayNum(arg_5_0)
	end)

	if getProxy(NewEducateProxy):GetCurChar():GetBenefitData():GetDisplayCounterData(arg_4_0.config.debuff_tag) then
		var_4_1 = string.gsub(var_4_1, "{(%d+),(%d+),(%d+)}", function(arg_6_0, arg_6_1, arg_6_2)
			return var_0:GetValue(arg_6_0, arg_6_1, arg_6_2)
		end)
	end

	arg_4_0.countText.text = var_4_1

	return
end

function var_0_0.Dispose(arg_7_0)
	return
end

function var_0_0.StaticShow(arg_8_0, arg_8_1)
	local var_8_0 = pg.child2_benefit_list[arg_8_1]

	setText(arg_8_0:Find("level/Text"), GetRomanDigitPlus(pg.child2_benefit_list[arg_8_1].rare))
	setText(arg_8_0:Find("name"), var_8_0.name)
	setText(arg_8_0:Find("desc/content/Text"), var_8_0.desc)
	setText(arg_8_0:Find("desc/content/effect"), "")
	LoadImageSpriteAsync("neweducateicon/" .. var_8_0.item_icon, arg_8_0:Find("icon/Image"), true)
	LoadImageSpriteAtlasAsync("ui/neweducateentrycard_atlas", var_8_0.benefit_level > 1 and "bg_entry_2" or "bg_entry", arg_8_0:Find("icon"))

	return
end

return var_0_0

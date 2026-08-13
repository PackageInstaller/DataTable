class = var_0_10000

local var_0_0 = var_0_10000("OtherWorldTempleChars")
local var_0_1 = "other_world_temple_char"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	onButton = var_1_10003

	local var_1_0 = arg_1_0._event

	findTF = var_1_10006

	local var_1_1 = var_1_10006(arg_1_0._tf, "ad/btnClose")

	local function var_1_2()
		local var_2_0 = arg_1_0

		var_0.setActive(var_2_0, false)

		return
	end

	SFX_CANCEL = var_8

	var_1_10003(var_1_0, var_1_1, var_1_2, var_8)

	onButton = var_1_10003

	local var_1_3 = arg_1_0._event

	findTF = var_1_1

	local var_1_4 = var_1_1(arg_1_0._tf, "ad/clickClose")

	local function var_1_5()
		local var_3_0 = arg_1_0

		var_0.setActive(var_3_0, false)

		return
	end

	SFX_CANCEL = var_8

	var_1_10003(var_1_3, var_1_4, var_1_5, var_8)

	findTF = var_1_10003
	arg_1_0._charTpl = var_1_10003(arg_1_0._tf, "ad/chars/content/charTpl")
	setText = var_3
	findTF = var_5

	local var_1_6 = var_5(arg_1_0._charTpl, "got/img/text")

	i18n = var_6

	var_3(var_1_6, var_6("word_got"))

	setActive = var_3

	var_3(arg_1_0._charTpl, false)

	arg_1_0._charItems = {}
	findTF = var_3
	arg_1_0._charContent = var_3(arg_1_0._tf, "ad/chars/content")

	return
end

function var_0_0.setData(arg_4_0, arg_4_1)
	arg_4_0.charIds = arg_4_1

	return
end

function var_0_0.updateActivityPool(arg_5_0, arg_5_1)
	arg_5_0.activityPools = arg_5_1

	return
end

function var_0_0.updateSelect(arg_6_0)
	arg_6_0:updateItemsCount(#arg_6_0.charIds)

	for iter_6_0 = 1, #arg_6_0._charItems do
		local var_6_0 = arg_6_0._charItems[iter_6_0]

		setActive = var_1_10006

		var_1_10006(var_6_0, false)

		if iter_6_0 <= #arg_6_0.charIds then
			setActive = var_1_10006

			var_1_10006(var_6_0, true)
			arg_6_0:setItemData(var_6_0, arg_6_0.charIds[iter_6_0])
		end
	end

	setText = var_1
	findTF = var_3

	local var_6_1 = var_3(arg_6_0._tf, "ad/title/text")

	i18n = iter_6_0

	var_1(var_6_1, iter_6_0(var_0_1))

	return
end

function var_0_0.setItemData(arg_7_0, arg_7_1, arg_7_2)
	pg = var_1_10003

	local var_7_0 = var_1_10003.guardian_template[arg_7_2]
	local var_7_1 = arg_7_0.activityPools[var_7_0.guardian_gain_pool]
	local var_7_2 = ""
	local var_7_3 = var_7_1
	local var_7_4 = var_7_1.getGuardianGot(var_7_3, arg_7_2)
	local var_7_6

	if var_7_0.type == 1 then
		string = var_7

		local var_7_5 = var_7.gsub

		var_7_6 = var_7_0.guardian_gain_desc
		var_1_10010 = "$1"
		math = var_1_10011
		var_7_2 = var_7_5(var_7_6, var_1_10010, var_1_10011.min(var_7_1:getFetchCount(), var_7_0.guardian_gain[2]))
	elseif var_7_0.type == 2 then
		if var_7_4 then
			var_7_2 = var_7_0.guardian_gain_desc
		else
			var_7_2 = "???"
		end
	end

	if var_7_0.type == 2 then
		setText = var_7
		findTF = var_7_6
		var_7_6 = var_7_6(arg_7_1, "desc/text")

		if not var_7_4 or not var_7_0.guardian_desc then
			var_1_10010 = "???"
		end

		var_7(var_7_6, var_1_10010)

		setText = var_7
		findTF = var_7_6
		var_7_6 = var_7_6(arg_7_1, "name/text")

		if not var_7_4 or not var_7_0.guardian_name then
			var_1_10010 = "???"
		end

		var_7(var_7_6, var_1_10010)
	else
		setText = var_7
		findTF = var_7_6

		var_7(var_7_6(arg_7_1, "name/text"), var_7_0.guardian_name)

		setText = var_7
		findTF = var_7_6

		var_7(var_7_6(arg_7_1, "desc/text"), var_7_0.guardian_desc)
	end

	PLATFORM_CODE = var_7
	PLATFORM_CH = var_7_3

	if var_7 ~= var_7_3 then
		GetComponent = var_7
		findTF = var_7_6
		var_7_6 = var_7_6(arg_7_1, "name/text")
		typeof = var_1_10010
		Text = var_12

		local var_7_7 = var_7(var_7_6, var_1_10010(var_12))

		var_7_7.fontSize = 30
		GetComponent = var_7_7
		findTF = var_7_6
		var_7_6 = var_7_6(arg_7_1, "desc/text")
		typeof = var_10
		Text = var_12
		var_7_7(var_7_6, var_10(var_12)).fontSize = 24
	end

	if var_7_0.type == 2 then
		setActive = var_7
		findTF = var_7_6

		var_7(var_7_6(arg_7_1, "icon/mask/img"), var_7_4)
	end

	LoadImageSpriteAsync = var_7

	local var_7_8 = "shipyardicon/" .. var_7_0.guardian_painting

	findTF = var_10

	var_7(var_7_8, var_10(arg_7_1, "icon/mask/img"), true)

	setText = var_7
	findTF = var_7_8

	var_7(var_7_8(arg_7_1, "tip/text"), var_7_2)

	setActive = var_7
	findTF = var_9

	var_7(var_9(arg_7_1, "icon/lock"), not var_7_4)

	setActive = var_7
	findTF = var_9

	var_7(var_9(arg_7_1, "got"), var_7_4)

	return
end

function var_0_0.updateItemsCount(arg_8_0, arg_8_1)
	local var_8_0 = 0

	if arg_8_1 > #arg_8_0._charItems then
		var_8_0 = arg_8_1 - #arg_8_0._charItems
	end

	for iter_8_0 = 1, var_8_0 do
		tf = var_1_10007
		instantiate = var_1_10009
		var_1_10007 = var_1_10007(var_1_10009(arg_8_0._charTpl))
		SetParent = var_1_10008

		var_1_10008(var_1_10007, arg_8_0._charContent)

		table = var_1_10008

		var_1_10008.insert(arg_8_0._charItems, var_1_10007)
	end

	return
end

function var_0_0.setActive(arg_9_0, arg_9_1)
	setActive = var_1_10002

	var_1_10002(arg_9_0._tf, arg_9_1)

	return
end

return var_0_0

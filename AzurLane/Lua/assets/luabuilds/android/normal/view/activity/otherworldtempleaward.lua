class = var_0_10000

local var_0_0 = var_0_10000("OtherWorldTempleAward")
local var_0_1 = "other_world_temple_award_last"
local var_0_2 = "other_world_temple_award_title_1"
local var_0_3 = "other_world_temple_award_title_2"
local var_0_4 = "other_world_temple_award_title_3"
local var_0_5 = {
	var_0_2,
	var_0_3,
	var_0_4
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	onButton = var_1_10003

	local var_1_0 = arg_1_0._event

	findTF = var_1_10005

	local var_1_1 = var_1_10005(arg_1_0._tf, "ad/btnClose")

	local function var_1_2()
		local var_2_0 = arg_1_0

		var_0.setActive(var_2_0, false)

		return
	end

	SFX_CANCEL = var_7

	var_1_10003(var_1_0, var_1_1, var_1_2, var_7)

	onButton = var_1_10003

	local var_1_3 = arg_1_0._event

	findTF = var_1_1

	local var_1_4 = var_1_1(arg_1_0._tf, "ad/clickClose")

	local function var_1_5()
		local var_3_0 = arg_1_0

		var_0.setActive(var_3_0, false)

		return
	end

	SFX_CANCEL = var_7

	var_1_10003(var_1_3, var_1_4, var_1_5, var_7)

	findTF = var_1_10003
	arg_1_0._awardTpl = var_1_10003(arg_1_0._tf, "ad/awards/content/awardTpl")
	setActive = var_3

	var_3(arg_1_0._awardTpl, false)

	arg_1_0._awardItems = {}
	findTF = var_3
	arg_1_0._awardContent = var_3(arg_1_0._tf, "ad/awards/content")

	return
end

function var_0_0.setData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.templeIds = arg_4_1
	arg_4_0.shopDatasList = arg_4_2

	return
end

function var_0_0.updateActivityPool(arg_5_0, arg_5_1)
	arg_5_0.activityPools = arg_5_1

	return
end

function var_0_0.updateSelect(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.shopDatasList[arg_6_1]

	arg_6_0:updateItemsCount(#var_6_0)

	arg_6_0.selectPool = arg_6_0.activityPools[arg_6_0.templeIds[arg_6_1]]

	for iter_6_0 = 1, #arg_6_0._awardItems do
		local var_6_1 = arg_6_0._awardItems[iter_6_0]

		setActive = var_1_10008

		var_1_10008(var_6_1, false)

		if iter_6_0 <= #var_6_0 then
			setActive = var_1_10008

			var_1_10008(var_6_1, true)
			arg_6_0:setItemData(var_6_1, var_6_0[iter_6_0])
		end
	end

	setText = var_3
	findTF = var_4

	local var_6_2 = var_4(arg_6_0._tf, "ad/title/text")

	i18n = var_5

	var_3(var_6_2, var_5(var_0_5[arg_6_1]))

	return
end

function var_0_0.setItemData(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2.id
	local var_7_1 = arg_7_2.count
	local var_7_2

	if not arg_7_0.selectPool.awards[var_7_0] then
		var_7_2 = 0
	end

	local var_7_3 = var_7_1 - var_7_2

	pg = var_1_10008

	local var_7_4 = var_1_10008.activity_random_award_item[var_7_0]

	Drop = var_1_10009

	local var_7_5 = var_1_10009.New({
		type = var_7_4.resource_category,
		id = var_7_4.commodity_id,
		count = var_7_4.num
	})

	updateDrop = var_10
	findTF = var_11

	var_10(var_11(arg_7_1, "ad/icon/IconTpl"), var_7_5)

	onButton = var_10

	local var_7_6 = arg_7_0._event
	local var_7_7 = arg_7_1

	local function var_7_8()
		local var_8_0 = arg_7_0._event
		local var_8_1 = var_0.emit

		BaseUI = var_2_10002

		var_8_1(var_8_0, var_2_10002.ON_DROP, var_7_5)

		return
	end

	SFX_PANEL = var_1_10014

	var_10(var_7_6, var_7_7, var_7_8, var_1_10014)

	setScrollText = var_10
	findTF = var_7_6

	var_10(var_7_6(arg_7_1, "ad/name/text"), var_7_5:getName())

	setText = var_10
	findTF = var_11

	local var_7_9 = var_11(arg_7_1, "ad/amount/text")

	i18n = var_12

	var_10(var_7_9, var_12(var_0_1, var_7_3, var_7_1))

	setActive = var_10
	findTF = var_7_9

	var_10(var_7_9(arg_7_1, "ad/soldOut"), var_7_3 == 0)

	return
end

function var_0_0.updateItemsCount(arg_9_0, arg_9_1)
	local var_9_0 = 0

	if arg_9_1 > #arg_9_0._awardItems then
		var_9_0 = arg_9_1 - #arg_9_0._awardItems
	end

	for iter_9_0 = 1, var_9_0 do
		tf = var_1_10007
		instantiate = var_1_10008
		var_1_10007 = var_1_10007(var_1_10008(arg_9_0._awardTpl))
		SetParent = var_1_10008

		var_1_10008(var_1_10007, arg_9_0._awardContent)

		table = var_1_10008

		var_1_10008.insert(arg_9_0._awardItems, var_1_10007)
	end

	return
end

function var_0_0.setActive(arg_10_0, arg_10_1)
	setActive = var_1_10002

	var_1_10002(arg_10_0._tf, arg_10_1)

	return
end

return var_0_0

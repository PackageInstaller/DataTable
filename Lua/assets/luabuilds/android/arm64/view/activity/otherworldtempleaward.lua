local var_0_0 = class("OtherWorldTempleAward")
local var_0_1 = "other_world_temple_award_last"
local var_0_2 = {}

;({})[1] = "other_world_temple_award_title_1"
;({})[2] = "other_world_temple_award_title_2"
;({})[3] = "other_world_temple_award_title_3"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2

	onButton(arg_1_0._event, findTF(arg_1_0._tf, "ad/btnClose"), function()
		arg_1_0:setActive(false)

		return
	end, SFX_CANCEL)
	onButton(arg_1_0._event, findTF(arg_1_0._tf, "ad/clickClose"), function()
		arg_1_0:setActive(false)

		return
	end, SFX_CANCEL)

	arg_1_0._awardTpl = findTF(arg_1_0._tf, "ad/awards/content/awardTpl")

	setActive(arg_1_0._awardTpl, false)

	arg_1_0._awardItems = {}
	arg_1_0._awardContent = findTF(arg_1_0._tf, "ad/awards/content")

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
	arg_6_0:updateItemsCount(#arg_6_0.shopDatasList[arg_6_1])

	arg_6_0.selectPool = arg_6_0.activityPools[arg_6_0.templeIds[arg_6_1]]

	for iter_6_0 = 1, #arg_6_0._awardItems do
		setActive(arg_6_0._awardItems[iter_6_0], false)

		if iter_6_0 <= #arg_6_0.shopDatasList[arg_6_1] then
			setActive(arg_6_0._awardItems[iter_6_0], true)
			arg_6_0:setItemData(arg_6_0._awardItems[iter_6_0], arg_6_0.shopDatasList[arg_6_1][iter_6_0])
		end
	end

	setText(findTF(arg_6_0._tf, "ad/title/text"), i18n(var_0_2[arg_6_1]))

	return
end

function var_0_0.setItemData(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.selectPool.awards[arg_7_2.id] or 0
	local var_7_1 = arg_7_2.count - var_7_0
	local var_7_2 = Drop.New({
		type = pg.activity_random_award_item[arg_7_2.id].resource_category,
		id = pg.activity_random_award_item[arg_7_2.id].commodity_id,
		count = pg.activity_random_award_item[arg_7_2.id].num
	})

	updateDrop(findTF(arg_7_1, "ad/icon/IconTpl"), var_7_2)
	onButton(arg_7_0._event, arg_7_1, function()
		arg_7_0._event:emit(BaseUI.ON_DROP, var_7_2)

		return
	end, SFX_PANEL)
	setScrollText(findTF(arg_7_1, "ad/name/text"), var_7_2:getName())
	setText(findTF(arg_7_1, "ad/amount/text"), i18n(var_0_1, var_7_1, arg_7_2.count))
	setActive(findTF(arg_7_1, "ad/soldOut"), var_7_1 == 0)

	return
end

function var_0_0.updateItemsCount(arg_9_0, arg_9_1)
	local var_9_0 = 0

	if arg_9_1 > #arg_9_0._awardItems then
		var_9_0 = arg_9_1 - #arg_9_0._awardItems
	end

	for iter_9_0 = 1, var_9_0 do
		local var_9_1 = tf(instantiate(arg_9_0._awardTpl))

		SetParent(var_9_1, arg_9_0._awardContent)
		table.insert(arg_9_0._awardItems, var_9_1)
	end

	return
end

function var_0_0.setActive(arg_10_0, arg_10_1)
	setActive(arg_10_0._tf, arg_10_1)

	return
end

return var_0_0

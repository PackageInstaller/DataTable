local OtherWorldTempleAward = class("OtherWorldTempleAward")
local var_0_1 = "other_world_temple_award_last"
local var_0_2 = {}

var_0_2[1] = "other_world_temple_award_title_1"
var_0_2[2] = "other_world_temple_award_title_2"
var_0_2[3] = "other_world_temple_award_title_3"

function OtherWorldTempleAward:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2

	onButton(self._event, findTF(self._tf, "ad/btnClose"), function()
		self:setActive(false)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self._tf, "ad/clickClose"), function()
		self:setActive(false)

		return
	end, SFX_CANCEL)

	self._awardTpl = findTF(self._tf, "ad/awards/content/awardTpl")

	setActive(self._awardTpl, false)

	self._awardItems = {}
	self._awardContent = findTF(self._tf, "ad/awards/content")

	return
end

function OtherWorldTempleAward:setData(arg_4_1, arg_4_2)
	self.templeIds = arg_4_1
	self.shopDatasList = arg_4_2

	return
end

function OtherWorldTempleAward:updateActivityPool(arg_5_1)
	self.activityPools = arg_5_1

	return
end

function OtherWorldTempleAward:updateSelect(arg_6_1)
	self:updateItemsCount(#self.shopDatasList[arg_6_1])

	self.selectPool = self.activityPools[self.templeIds[arg_6_1]]

	for iter_6_0 = 1, #self._awardItems do
		setActive(self._awardItems[iter_6_0], false)

		if iter_6_0 <= #self.shopDatasList[arg_6_1] then
			setActive(self._awardItems[iter_6_0], true)
			self:setItemData(self._awardItems[iter_6_0], self.shopDatasList[arg_6_1][iter_6_0])
		end
	end

	setText(findTF(self._tf, "ad/title/text"), i18n(var_0_2[arg_6_1]))

	return
end

function OtherWorldTempleAward:setItemData(arg_7_1, arg_7_2)
	local var_7_1 = arg_7_2.count - (self.selectPool.awards[arg_7_2.id] or 0)
	local var_7_2 = Drop.New({
		type = pg.activity_random_award_item[arg_7_2.id].resource_category,
		id = pg.activity_random_award_item[arg_7_2.id].commodity_id,
		count = pg.activity_random_award_item[arg_7_2.id].num
	})

	updateDrop(findTF(arg_7_1, "ad/icon/IconTpl"), var_7_2)
	onButton(self._event, arg_7_1, function()
		self._event:emit(BaseUI.ON_DROP, var_7_2)

		return
	end, SFX_PANEL)
	setScrollText(findTF(arg_7_1, "ad/name/text"), var_7_2:getName())
	setText(findTF(arg_7_1, "ad/amount/text"), i18n(var_0_1, var_7_1, arg_7_2.count))
	setActive(findTF(arg_7_1, "ad/soldOut"), var_7_1 == 0)

	return
end

function OtherWorldTempleAward:updateItemsCount(arg_9_1)
	for iter_9_0 = 1, (arg_9_1 > #self._awardItems or nil) and arg_9_1 - #self._awardItems do
		local var_9_1 = tf(instantiate(self._awardTpl))

		SetParent(var_9_1, self._awardContent)
		table.insert(self._awardItems, var_9_1)
	end

	return
end

function OtherWorldTempleAward:setActive(arg_10_1)
	setActive(self._tf, arg_10_1)

	return
end

return OtherWorldTempleAward

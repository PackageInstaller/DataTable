local GuildDonateCard = class("GuildDonateCard")

function GuildDonateCard:Ctor(arg_1_1)
	self._tf = arg_1_1
	self.title = self._tf:Find("name"):GetComponent(typeof(Text))
	self.awardTF = self._tf:Find("item")
	self.awardTxtTF = self._tf:Find("item/Text")
	self.res = self._tf:Find("award/Text"):GetComponent(typeof(Text))
	self.commitBtn = self._tf:Find("submit")

	return
end

function GuildDonateCard:update(arg_2_1)
	self.dtask = arg_2_1

	local var_2_0 = arg_2_1:getCommitItem()

	updateDrop(self.awardTF, {
		type = var_2_0[1],
		id = var_2_0[2],
		count = var_2_0[3]
	})

	self.title.text = arg_2_1:getConfig("name")

	local var_2_1 = self:GetResCntByAward(var_2_0)

	setText(self.awardTxtTF, string.format((var_2_1 < var_2_0[3] or nil) and ("<color=" .. COLOR_RED .. ">%s</color>/%s" or "%s/%s"), self:WrapNum(var_2_1), self:WrapNum(var_2_0[3])))

	self.res.text = arg_2_1:getConfig("award_contribution")

	return
end

function GuildDonateCard:GetResCntByAward(arg_3_1)
	if arg_3_1[1] == DROP_TYPE_RESOURCE then
		return getProxy(PlayerProxy):getRawData():getResource(arg_3_1[2])
	elseif arg_3_1[1] == DROP_TYPE_ITEM then
		return getProxy(BagProxy):getItemCountById(arg_3_1[2])
	else
		assert(false)
	end

	return
end

function GuildDonateCard:WrapNum(arg_4_1)
	if arg_4_1 > 1000000 then
		return math.floor(arg_4_1 / 1000000) .. "M"
	elseif arg_4_1 > 1000 then
		return math.floor(arg_4_1 / 1000) .. "K"
	end

	return arg_4_1
end

function GuildDonateCard:Dispose()
	return
end

return GuildDonateCard

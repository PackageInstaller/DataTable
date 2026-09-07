local WorldBossRankPage = class("WorldBossRankPage", import("....base.BaseSubView"))

function WorldBossRankPage:getUIName()
	return "WorldBossRankUI"
end

function WorldBossRankPage:OnLoaded()
	self.numberTF1 = self._tf:Find("frame/list/number1")

	setActive(self.numberTF1, false)

	self.numberTF2 = self._tf:Find("frame/list/number2")

	setActive(self.numberTF2, false)

	self.numberTF3 = self._tf:Find("frame/list/number3")

	setActive(self.numberTF3, false)

	self.numberTF4 = self._tf:Find("frame/list/number4")

	setActive(self.numberTF4, false)

	return
end

function WorldBossRankPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function WorldBossRankPage:Update(arg_5_1, arg_5_2)
	self.bossProxy = arg_5_1
	self.bossId = arg_5_2

	self:Show()
	self:UpdateRankList()

	return
end

function WorldBossRankPage:UpdateRankList()
	local var_6_0 = self.bossProxy:GetRank(self.bossId)

	if var_6_0 == nil then
		self:emit(WorldBossMediator.ON_RANK_LIST, self.bossId)
	else
		self:UpdateRanks(var_6_0)
	end

	return
end

function WorldBossRankPage:UpdateRanks(arg_7_1)
	for iter_7_0 = 1, 3 do
		setActive(self["numberTF" .. iter_7_0], arg_7_1[iter_7_0])

		if arg_7_1[iter_7_0] then
			self:UpdateRank(self["numberTF" .. iter_7_0], arg_7_1[iter_7_0])
		end
	end

	local var_7_0 = getProxy(PlayerProxy):getRawData().id
	local var_7_1

	for iter_7_1, iter_7_2 in ipairs(arg_7_1) do
		if iter_7_2.id == var_7_0 then
			var_7_1 = iter_7_2
			var_7_1.number = iter_7_1

			break
		end
	end

	if var_7_1 then
		self:UpdateMyRank(self.numberTF4, var_7_1)
	else
		setActive(self.numberTF4, false)
	end

	return
end

function WorldBossRankPage:UpdateRank(arg_8_1, arg_8_2)
	setText(arg_8_1:Find("Text"), arg_8_2.name)
	setText(arg_8_1:Find("damage/Text"), arg_8_2.damage)
	setActive(arg_8_1:Find("view"), arg_8_2.id ~= getProxy(PlayerProxy):getRawData().id)
	onButton(self, arg_8_1:Find("view"), function()
		self:emit(WorldBossMediator.FETCH_RANK_FORMATION, arg_8_2.id, self.bossId)

		return
	end, SFX_PANEL)

	return
end

function WorldBossRankPage:UpdateMyRank(arg_10_1, arg_10_2)
	self:UpdateRank(arg_10_1, arg_10_2)
	setText(arg_10_1:Find("number"), arg_10_2.number)

	return
end

function WorldBossRankPage:isActive()
	return isActive(self._tf)
end

function WorldBossRankPage:OnDestroy()
	return
end

return WorldBossRankPage

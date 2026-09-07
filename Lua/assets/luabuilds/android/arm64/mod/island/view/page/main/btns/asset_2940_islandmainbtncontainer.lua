local IslandMainBtnContainer = class("IslandMainBtnContainer")

IslandMainBtnContainer.SPECIAL_BTN = {
	season = "IslandMainSeasonBtn",
	technology = "IslandMainTechnologyBtn"
}

function IslandMainBtnContainer:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self.event = arg_1_2
	self.tpl = self._tf:Find("tpl")

	setActive(self.tpl, false)
	self:InitBtns()

	return
end

function IslandMainBtnContainer:InitBtns()
	self.btns = {}
	self.unlockIds = {}

	table.sort(pg.island_main_btns.get_id_list_by_main_type[1], CompareFuncs({
		function(arg_3_0)
			return pg.island_main_btns[arg_3_0].order
		end,
		function(arg_4_0)
			return arg_4_0
		end
	}))

	for iter_2_0, iter_2_1 in ipairs(pg.island_main_btns.get_id_list_by_main_type[1]) do
		table.insert(self.unlockIds, pg.island_main_btns[iter_2_1].ability_id)

		local var_2_0 = pg.island_main_btns[iter_2_1].btn_name

		self.btns[var_2_0] = IslandMainBtnContainer.SPECIAL_BTN[pg.island_main_btns[iter_2_1].btn_name] and _G[IslandMainBtnContainer.SPECIAL_BTN[var_2_0]].New(self._tf:Find(var_2_0), self.event, iter_2_1) or IslandMainBaseBtn.New(cloneTplTo(self.tpl, self._tf), self.event, iter_2_1)

		self.btns[var_2_0]:SetAsLastSibling()
	end

	self:Flush()

	return
end

function IslandMainBtnContainer:OnTaskUpdate()
	self.btns.season:TipCheck()

	return
end

function IslandMainBtnContainer:OnUnlockSystem(arg_6_1)
	if table.contains(self.unlockIds, arg_6_1) then
		for iter_6_0, iter_6_1 in pairs(self.btns) do
			iter_6_1:UnlockCheck()
		end
	end

	return
end

function IslandMainBtnContainer:OnTrackTaskChange()
	if self.btns.map and self.btns.map:IsUnlock() then
		self.btns.map:TipCheck()
	end

	return
end

function IslandMainBtnContainer:OnFinishDelegation()
	if self.btns.technology and self.btns.technology:IsUnlock() then
		self.btns.technology:TipCheck()
		self.btns.technology:StatusCheck()
	end

	return
end

function IslandMainBtnContainer:OnUnlockTechnology()
	if self.btns.technology and self.btns.technology:IsUnlock() then
		self.btns.technology:StatusCheck()
	end

	return
end

function IslandMainBtnContainer:Flush()
	for iter_10_0, iter_10_1 in pairs(self.btns) do
		iter_10_1:Flush()
	end

	return
end

function IslandMainBtnContainer:ActiveOrDisactive(arg_11_1)
	setActive(self._tf, arg_11_1)

	return
end

function IslandMainBtnContainer:Dispose()
	for iter_12_0, iter_12_1 in pairs(self.btns) do
		iter_12_1:Dispose()
	end

	self.btns = nil

	return
end

return IslandMainBtnContainer

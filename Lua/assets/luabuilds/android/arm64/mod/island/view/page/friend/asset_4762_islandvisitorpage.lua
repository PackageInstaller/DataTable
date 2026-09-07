local IslandVisitorPage = class("IslandVisitorPage", import("...base.IslandBasePage"))
local var_0_1 = 1
local var_0_2 = 2

function IslandVisitorPage:getUIName()
	return "IslandVisitorUI"
end

function IslandVisitorPage:OnLoaded()
	self.kickAllBtn = self._tf:Find("frame/public")
	self.closeAccessBtn = self._tf:Find("frame/onkey")
	self.closeBtn = self._tf:Find("frame/close")
	self.peopleCntTxt = self._tf:Find("frame/cnt/Text"):GetComponent(typeof(Text))
	self.toggles = {
		self._tf:Find("frame/toggles/1"),
		self._tf:Find("frame/toggles/2")
	}

	local var_2_0 = {}

	var_2_0[1] = self._tf:Find("frame/toggles/1/Text"):GetComponent(typeof(Text))
	var_2_0[2] = self._tf:Find("frame/toggles/2/Text"):GetComponent(typeof(Text))
	self.texts = var_2_0
	self.names = {
		i18n("island_curr_visitor"),
		i18n("island_visitor_log")
	}
	self._scrollrect = self._tf:Find("frame/scrollrect"):GetComponent("LScrollRect")
	self._scrollrectLog = self._tf:Find("frame/scrollrect4Log"):GetComponent("LScrollRect")
	self.scrollrects = {
		self._scrollrect,
		self._scrollrectLog
	}
	self.cards = {}
	self.logCards = {}
	self.cardList = {
		self.cards,
		self.logCards
	}

	function self._scrollrect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self._scrollrect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	function self._scrollrectLog.onInitItem(arg_5_0)
		self:OnInitItem4Log(arg_5_0)

		return
	end

	function self._scrollrectLog.onUpdateItem(arg_6_0, arg_6_1)
		self:OnUpdateItem4Log(arg_6_0, arg_6_1)

		return
	end

	setText(self._tf:Find("frame/public/Text"), i18n("island_kick_all"))
	setText(self._tf:Find("frame/onkey/Text"), i18n("island_close_visit"))
	setText(self._tf:Find("frame/cnt/label"), i18n("island_curr_people_cnt"))

	return
end

function IslandVisitorPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.kickAllBtn, function()
		local var_10_0 = _.map(self.displays, function(arg_11_0)
			return arg_11_0.id
		end)

		if #var_10_0 <= 0 then
			return
		end

		self:emit(IslandMediator.KICK_ALL_VISITOR, var_10_0)

		return
	end, SFX_PANEL)
	onButton(self, self.closeAccessBtn, function()
		if not self:GetIsland():GetAccessAgency():HasOpenFlag(IslandConst.OPEN_ALL) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_close_access_state"))

			return
		end

		self:emit(IslandMediator.SET_ACCESS_FLAG, {}, {
			IslandConst.OPEN_ALL
		})

		return
	end, SFX_PANEL)

	for iter_7_0, iter_7_1 in pairs(self.toggles) do
		local var_7_0 = self.texts[iter_7_0]
		local var_7_1 = self.names[iter_7_0]

		onToggle(self, iter_7_1, function(arg_13_0)
			if arg_13_0 then
				self:SwitchPage(iter_7_0)
			end

			var_7_0.text = arg_13_0 and setColorStr(var_7_1, "#FEFEFE") or setColorStr(var_7_1, "#6B6E75")

			return
		end, SFX_PANEL)

		self.texts[iter_7_0].text = setColorStr(self.names[iter_7_0], "#6B6E75")
	end

	return
end

function IslandVisitorPage:AddListeners()
	self:AddListener(IslandVisitorAgency.PLAYER_ADD, self.OnFlush)
	self:AddListener(IslandVisitorAgency.PLAYER_EXIT, self.OnFlush)

	return
end

function IslandVisitorPage:RemoveListeners()
	self:RemoveListener(IslandVisitorAgency.PLAYER_ADD, self.OnFlush)
	self:RemoveListener(IslandVisitorAgency.PLAYER_EXIT, self.OnFlush)

	return
end

function IslandVisitorPage:OnFlush()
	self:FlushList()

	return
end

function IslandVisitorPage:GetDisplayData(arg_17_1)
	local var_17_0 = {}

	if arg_17_1 == var_0_1 then
		for iter_17_0, iter_17_1 in pairs((self:GetIsland():GetVisitorAgency():GetPlayerList())) do
			if not iter_17_1:IsSelf() then
				table.insert(var_17_0, iter_17_1)
			end
		end
	elseif arg_17_1 == var_0_2 then
		local var_17_1 = {}

		for iter_17_2, iter_17_3 in ipairs((getProxy(IslandProxy):GetIsland():GetAccessAgency():GetVisitorLogList())) do
			if not iter_17_3:IsSelf() then
				table.insert(var_17_1, iter_17_3)
			end
		end

		table.sort(var_17_1, function(arg_18_0, arg_18_1)
			return arg_18_0.time > arg_18_1.time
		end)

		if #var_17_1 <= 1 then
			return {}
		end

		table.insert(var_17_0, var_17_1[1])

		for iter_17_4 = 2, #var_17_1 do
			if not pg.TimeMgr.GetInstance():IsSameDay(var_17_1[1].time, var_17_1[iter_17_4].time) then
				table.insert(var_17_0, IslandVisitorLog.New({
					id = -1,
					time = var_17_1[iter_17_4].time
				}))
			end

			table.insert(var_17_0, var_17_1[iter_17_4])
		end
	end

	return var_17_0
end

function IslandVisitorPage:SwitchPage(arg_19_1)
	self.pageIndex = arg_19_1

	self:FlushList()

	return
end

function IslandVisitorPage:OnInitItem(arg_20_1)
	local var_20_0 = IslandVisitorCard.New(arg_20_1)

	onButton(self, var_20_0.btn, function()
		self:emit(IslandMediator.ON_KICK_PLAYER, IslandConst.ACCESS_OP_KICK, var_20_0.player.id)

		return
	end, SFX_PANEL)
	onButton(self, var_20_0.cardBtn, function()
		self:emit(IslandMediator.OPEN_PAGE, "IslandOtherCardPage", {
			var_20_0.player.id
		})

		return
	end, SFX_PANEL)

	self.cardList[self.pageIndex][arg_20_1] = var_20_0

	return
end

function IslandVisitorPage:OnUpdateItem(arg_23_1, arg_23_2)
	if not self.cardList[self.pageIndex][arg_23_2] then
		self:OnInitItem(arg_23_2)
	end

	self.cardList[self.pageIndex][arg_23_2]:Update(self.displays[arg_23_1 + 1])

	return
end

function IslandVisitorPage:OnInitItem4Log(arg_24_1)
	self.cardList[self.pageIndex][arg_24_1] = IslandVisitorLogCard.New(arg_24_1)

	return
end

function IslandVisitorPage:OnUpdateItem4Log(arg_25_1, arg_25_2)
	if not self.cardList[self.pageIndex][arg_25_2] then
		self:OnInitItem(arg_25_2)
	end

	self.cardList[self.pageIndex][arg_25_2]:Update(self.displays[arg_25_1 + 1])

	return
end

function IslandVisitorPage:Show()
	IslandVisitorPage.super.Show(self)
	triggerToggle(self.toggles[var_0_1], true)

	return
end

function IslandVisitorPage:FlushList()
	self.displays = self:GetDisplayData(self.pageIndex)

	self.scrollrects[self.pageIndex]:SetTotalCount(#self.displays)
	self:FlushPeopleCnt()

	return
end

function IslandVisitorPage:FlushPeopleCnt()
	self.peopleCntTxt.text = #self.displays .. "/10"

	return
end

function IslandVisitorPage:OnDestroy()
	ClearLScrollrect(self._scrollrect)
	ClearLScrollrect(self._scrollrectLog)

	for iter_29_0, iter_29_1 in pairs(self.cardList) do
		for iter_29_2, iter_29_3 in pairs(iter_29_1) do
			iter_29_3:Dispose()
		end
	end

	self.cardList = nil

	return
end

return IslandVisitorPage

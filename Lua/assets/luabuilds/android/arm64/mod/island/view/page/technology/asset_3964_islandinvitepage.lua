local IslandInvitePage = class("IslandInvitePage", import("...base.IslandBasePage"))

function IslandInvitePage:getUIName()
	return "IslandInviteUI"
end

function IslandInvitePage:OnLoaded()
	setText(self._tf:Find("top/title/Text"), i18n("island_invite_title"))

	self.contentText = self._tf:Find("Text")

	setText(self.contentText, "")

	self.prevBtn = self._tf:Find("bottom/left_arr")
	self.nextBtn = self._tf:Find("bottom/right_arr")
	self.scrollrect = self._tf:Find("bottom/scroll/content"):GetComponent("LScrollRect")
	self.scrollrect.isNewLoadingMethod = true

	function self.scrollrect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self.scrollrect.onUpdateItem(arg_4_0, arg_4_1)
		self:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	return
end

function IslandInvitePage:OnInit()
	onButton(self, self._tf:Find("top/back"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.prevBtn, function()
		self:OnPrev()

		return
	end, SFX_PANEL)
	onButton(self, self.nextBtn, function()
		self:OnNext()

		return
	end, SFX_PANEL)

	self.cards = {}

	return
end

function IslandInvitePage:AddListeners()
	self:AddListener(IslandCharacterAgency.ADD_SHIP, self.Flush)

	return
end

function IslandInvitePage:RemoveListeners()
	self:RemoveListener(IslandCharacterAgency.ADD_SHIP, self.Flush)

	return
end

function IslandInvitePage:OnShow()
	self.triggerFirstCard = true
	self.selectedId = nil

	self:Flush()

	return
end

function IslandInvitePage:Flush()
	self.triggerFirstCard = true
	self.displays = {}

	for iter_12_0, iter_12_1 in ipairs((getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetInviteList())) do
		table.insert(self.displays, (IslandInvitation.New(iter_12_1)))
	end

	self.scrollrect:SetTotalCount(#self.displays)

	return
end

function IslandInvitePage:OnInitItem(arg_13_1)
	local var_13_0 = IslandInviteShipCard.New(arg_13_1)

	onButton(self, var_13_0.frameTF, function()
		for iter_14_0, iter_14_1 in pairs(self.cards) do
			iter_14_1:UpdateSelected(nil)
		end

		self.selectedId = var_13_0.item.shipId

		var_13_0:UpdateSelected(self.selectedId)

		return
	end, SFX_PANEL)
	self:AddDrag(var_13_0.frameTF, function()
		self:emit(IslandMediator.INVITE_SHIP, var_13_0.item.shipId)

		return
	end)

	self.cards[arg_13_1] = var_13_0

	return
end

function IslandInvitePage:OnUpdateItem(arg_16_1, arg_16_2)
	local var_16_0 = self.cards[arg_16_2]

	if not self.cards[arg_16_2] then
		self:OnInitItem(arg_16_2)

		var_16_0 = self.cards[arg_16_2]
	end

	var_16_0:Update(self.displays[arg_16_1 + 1], self.selectedId)

	arg_16_2.name = var_16_0.item.shipId

	if self.triggerFirstCard and arg_16_1 == 0 then
		self.triggerFirstCard = nil

		triggerButton(var_16_0.frameTF)
	end

	return
end

function IslandInvitePage:AddDrag(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = GetOrAddComponent(arg_17_1, "EventTriggerListener")
	local var_17_1
	local var_17_2 = 0
	local var_17_3 = 50
	local var_17_4 = arg_17_1.rect.height / 2

	var_17_0:AddPointDownFunc(function()
		var_17_2 = 0
		var_17_1 = nil

		return
	end)
	var_17_0:AddDragFunc(function(arg_19_0, arg_19_1)
		var_17_1 = var_17_1 or arg_19_1.position
		var_17_2 = arg_19_1.position.y - var_17_1.y

		if var_17_2 > 0 then
			setLocalPosition(arg_17_1, {
				x = 0,
				y = var_17_2 - var_17_4
			})
		else
			setLocalPosition(arg_17_1, {
				x = 0,
				y = -var_17_4
			})
		end

		return
	end)
	var_17_0:AddPointUpFunc(function(arg_20_0, arg_20_1)
		setLocalPosition(arg_17_1, {
			x = 0,
			y = -var_17_4
		})

		if var_17_2 > var_17_3 then
			existCall(arg_17_2)
		else
			existCall(arg_17_3)
		end

		return
	end)

	return
end

function IslandInvitePage:GetCommodityIndex(arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(self.displays) do
		if iter_21_1.shipId == arg_21_1 then
			return iter_21_0
		end
	end

	return
end

function IslandInvitePage:OnPrev()
	if not self.selectedId then
		return
	end

	local var_22_0 = self:GetCommodityIndex(self.selectedId)

	if var_22_0 - 1 > 0 then
		self:TriggerCommodity(var_22_0, -1)
	end

	return
end

function IslandInvitePage:OnNext()
	if not self.selectedId then
		return
	end

	local var_23_0 = self:GetCommodityIndex(self.selectedId)

	if var_23_0 + 1 <= #self.displays then
		self:TriggerCommodity(var_23_0, 1)
	end

	return
end

function IslandInvitePage:TriggerCommodity(arg_24_1, arg_24_2)
	local var_24_0
	local var_24_1

	for iter_24_0, iter_24_1 in pairs(self.cards) do
		if iter_24_1._tf.gameObject.name ~= "-1" then
			if iter_24_1.item.shipId == self.displays[arg_24_1 + arg_24_2].shipId then
				var_24_0 = iter_24_1
			elseif iter_24_1.item.shipId == self.displays[arg_24_1].shipId then
				var_24_1 = iter_24_1
			end
		end
	end

	if var_24_0 then
		triggerButton(var_24_0.frameTF)
	end

	if var_24_0 and var_24_1 then
		self:CheckCardBound(var_24_0, var_24_1, arg_24_2 > 0, arg_24_1 + arg_24_2)
	end

	return
end

function IslandInvitePage:CheckCardBound(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = getBounds(self.scrollrect.gameObject.transform)

	if arg_25_3 then
		if math.ceil(getBounds(arg_25_1._tf):GetMax().x - var_25_0:GetMax().x) > getBounds(arg_25_2._tf).size.x then
			self.scrollrect:SetNormalizedPosition(self.scrollrect.value - (self.scrollrect:HeadIndexToValue(arg_25_4 - 1) - self.scrollrect:HeadIndexToValue(arg_25_4)), 0)
		end
	elseif getBounds(arg_25_1._tf.parent):GetMin().x < var_25_0:GetMin().x and getBounds(arg_25_1._tf):GetMin().x < var_25_0:GetMin().x then
		self.scrollrect:SetNormalizedPosition(self.scrollrect:HeadIndexToValue(arg_25_4 - 1), 0)
	end

	return
end

function IslandInvitePage:OnDestroy()
	ClearLScrollrect(self.scrollrect)

	return
end

return IslandInvitePage

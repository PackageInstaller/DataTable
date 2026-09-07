local NewEducateRankLayer = class("NewEducateRankLayer", import("view.newEducate.base.NewEducateBaseUI"))

NewEducateRankLayer.TYPE = {
	ATTR = PowerRank.TYPE_TB_ATTR_SUM,
	ENDLESS = PowerRank.TYPE_TB_ENDLESS_WAVE
}

function NewEducateRankLayer:getUIName()
	return "NewEducateRankUI"
end

function NewEducateRankLayer:init()
	local var_2_0 = self._tf:Find("window")

	setText(var_2_0:Find("tip"), i18n("child2_rank_refresh_tip"))

	local var_2_1 = var_2_0:Find("header")

	setText(var_2_1:Find("rank"), i18n("child2_rank_header_rank"))
	setText(var_2_1:Find("info"), i18n("child2_rank_header_info"))

	self.headerValueTF = var_2_1:Find("value")
	self.toggleTFs = {}
	self.toggleTFs[NewEducateRankLayer.TYPE.ATTR] = var_2_0:Find("toggles/attr")

	setText(var_2_0:Find("toggles/attr/Text"), i18n("child2_rank_toggle_attr"))

	self.toggleTFs[NewEducateRankLayer.TYPE.ENDLESS] = var_2_0:Find("toggles/endless")

	setText(var_2_0:Find("toggles/endless/Text"), i18n("child2_rank_toggle_endless"))

	self.playerRankTF = var_2_0:Find("player")
	self.rankRect = var_2_0:Find("view/content"):GetComponent("LScrollRect")

	return
end

function NewEducateRankLayer:didEnter()
	self:OverlayPanel(self._tf, {
		groupDelta = 1
	})
	onButton(self, self._tf:Find("mask"), function()
		self:closeView()

		return
	end, SFX_PANEL)

	for iter_3_0, iter_3_1 in pairs(self.toggleTFs) do
		onToggle(self, iter_3_1, function(arg_5_0)
			local var_5_0

			if arg_5_0 and (not self.curType or self.curType ~= iter_3_0) then
				self.curType = iter_3_0

				self:UpdateView()

				var_5_0 = quickPlayAnimation
			end

			var_5_0(iter_3_1, arg_5_0 and "Anim_NewEducateRankUI_sel" or "Anim_NewEducateRankUI_sel2")

			return
		end, SFX_PANEL)
	end

	function self.rankRect.onInitItem(arg_6_0)
		self:OnInitItem(arg_6_0)

		return
	end

	function self.rankRect.onUpdateItem(arg_7_0, arg_7_1)
		self:OnUpdateItem(arg_7_0, arg_7_1)

		return
	end

	self.playerCard = NewEducateRankCard.New(self.playerRankTF, NewEducateRankCard.TYPE_SELF, self)

	self:InitData()
	triggerToggle(self.toggleTFs[NewEducateRankLayer.TYPE.ATTR], true)
	NewEducateGuideSequence.CheckGuide(self.__cname)

	return
end

function NewEducateRankLayer:InitData()
	self.cards = {}
	self.rankVOs = {}
	self.playerRankVOs = {}
	self.charId = self.contextData.char.id

	return
end

function NewEducateRankLayer:OnInitItem(arg_9_1)
	self.cards[arg_9_1] = NewEducateRankCard.New(arg_9_1, NewEducateRankCard.TYPE_OTHER, self)

	return
end

function NewEducateRankLayer:OnUpdateItem(arg_10_1, arg_10_2)
	if not self.cards[arg_10_2] then
		self:OnInitItem(arg_10_2)
	end

	self.cards[arg_10_2]:Update(self.displayRankVOs[arg_10_1 + 1], self.curType)

	return
end

function NewEducateRankLayer:UpdateView()
	setText(self.headerValueTF, self.curType == NewEducateRankLayer.TYPE.ATTR and i18n("child2_rank_header_attr") or i18n("child2_rank_header_wave"))

	if self.rankVOs[self.curType] then
		if getProxy(BillboardProxy):canFetch(self.curType, self.charId) then
			self:emit(NewEducateRankMediator.ON_GET_RANK, self.curType, self.charId)

			goto label_11_0
		end
	end

	self:UpdataRankList()

	::label_11_0::

	return
end

function NewEducateRankLayer:UpdataRankList()
	self.displayRankVOs = {}

	for iter_12_0, iter_12_1 in ipairs(self.rankVOs[self.curType]) do
		table.insert(self.displayRankVOs, iter_12_1)
	end

	self.rankRect:SetTotalCount(#self.displayRankVOs)
	setActive(self.playerRankTF, self.playerRankVOs[self.curType])

	if self.playerRankVOs[self.curType] then
		self.playerCard:Update(self.playerRankVOs[self.curType], self.curType)
	end

	return
end

function NewEducateRankLayer:OnGetRankDone(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	self.rankVOs[arg_13_1] = arg_13_3
	self.playerRankVOs[arg_13_1] = arg_13_4

	self:UpdataRankList()

	return
end

function NewEducateRankLayer:willExit()
	ClearLScrollrect(self.rankRect)

	for iter_14_0, iter_14_1 in ipairs(self.cards) do
		iter_14_1:Dispose()
	end

	self.cards = nil

	self.playerCard:Dispose()
	self:UnOverlayPanel(self._tf)

	return
end

return NewEducateRankLayer

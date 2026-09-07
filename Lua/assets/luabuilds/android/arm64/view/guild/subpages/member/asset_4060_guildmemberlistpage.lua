local GuildMemberListPage = class("GuildMemberListPage", import("...base.GuildBasePage"))

function GuildMemberListPage:getTargetUI()
	return "GuildMemberListBlueUI", "GuildMemberListRedUI"
end

function GuildMemberListPage:OnLoaded()
	self.rectView = self._tf:Find("scroll")
	self.rectRect = self.rectView:GetComponent("LScrollRect")
	self.rankBtn = self._tf:Find("rank")
	self.blurBg = self._tf:Find("blur_bg")

	return
end

function GuildMemberListPage:OnInit()
	onButton(self, self.rankBtn, function()
		self.contextData.rankPage:ExecuteAction("Flush", self.ranks)

		return
	end, SFX_PANEL)
	pg.UIMgr.GetInstance():OverlayPanel(self._tf, {
		pbList = {
			self.blurBg
		},
		overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
	})

	self.items = {}

	function self.rectRect.onInitItem(arg_5_0)
		self:OnInitItem(arg_5_0)

		return
	end

	function self.rectRect.onUpdateItem(arg_6_0, arg_6_1)
		self:OnUpdateItem(arg_6_0, arg_6_1)

		return
	end

	return
end

function GuildMemberListPage:SetUp(arg_7_1, arg_7_2, arg_7_3)
	self:Show()
	self:Flush(arg_7_1, arg_7_2, arg_7_3)

	return
end

function GuildMemberListPage:Flush(arg_8_1, arg_8_2, arg_8_3)
	self.ranks = arg_8_3
	self.memberVOs = arg_8_2
	self.guildVO = arg_8_1

	self:SetTotalCount()

	return
end

function GuildMemberListPage:SetTotalCount()
	table.sort(self.memberVOs, function(arg_10_0, arg_10_1)
		if arg_10_0.duty ~= arg_10_1.duty then
			return arg_10_0.duty < arg_10_1.duty
		else
			return arg_10_0.liveness > arg_10_1.liveness
		end

		return
	end)
	self.rectRect:SetTotalCount(#self.memberVOs, 0)

	return
end

function GuildMemberListPage:OnInitItem(arg_11_1)
	local var_11_0 = GuildMemberCard.New(arg_11_1)

	onButton(self, var_11_0.tf, function()
		if self.selected == var_11_0 then
			return
		end

		if self.selected then
			self.selected:SetSelected(false)
		end

		self.selected = var_11_0

		self.selected:SetSelected(true)

		self.selectedId = var_11_0.memberVO.id

		if self.OnClickMember then
			self.OnClickMember(var_11_0.memberVO)
		end

		return
	end, SFX_PANEL)

	self.items[arg_11_1] = var_11_0

	return
end

function GuildMemberListPage:OnUpdateItem(arg_13_1, arg_13_2)
	local var_13_0 = self.items[arg_13_2]

	if not self.items[arg_13_2] then
		self:OnInitItem(arg_13_2)

		var_13_0 = self.items[arg_13_2]
	end

	local var_13_1 = self.memberVOs[arg_13_1 + 1]

	var_13_0:Update(self.memberVOs[arg_13_1 + 1], self.guildVO)
	var_13_0:SetSelected(self.selectedId and self.selectedId == var_13_1.id)

	if not self.selected and arg_13_1 == 0 then
		triggerButton(var_13_0.tf)
	end

	return
end

function GuildMemberListPage:TriggerFirstCard()
	for iter_14_0, iter_14_1 in pairs(self.items) do
		if iter_14_1.memberVO.id == self.memberVOs[1].id then
			triggerButton(iter_14_1.tf)

			break
		end
	end

	return
end

function GuildMemberListPage:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	for iter_15_0, iter_15_1 in pairs(self.items) do
		iter_15_1:Dispose()
	end

	return
end

return GuildMemberListPage

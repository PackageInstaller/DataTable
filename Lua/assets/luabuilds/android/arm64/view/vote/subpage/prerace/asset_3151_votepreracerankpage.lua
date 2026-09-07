local VotePreRaceRankPage = class("VotePreRaceRankPage", import("....base.BaseSubView"))

VotePreRaceRankPage.RANK_DISPLAY_COUNT = 15

function VotePreRaceRankPage:getUIName()
	return "PreRaceRank"
end

function VotePreRaceRankPage:OnInit()
	self.uiitemlist = UIItemList.New(self._tf:Find("content"), self._tf:Find("content/tpl"))
	self.prevBtn = self._tf:Find("prev")
	self.nextBtn = self._tf:Find("next")
	self.tip = self._tf:Find("tip")
	self.title1 = self._tf:Find("stages/title1")
	self.title2 = self._tf:Find("stages/title2")
	self.rankTitle = self._tf:Find("titles/rank_title")

	onButton(self, self.nextBtn, function()
		if self.page + 1 > self.maxPage then
			self.page = 1
		end

		self:initRank(self.page)

		return
	end, SFX_PANEL)
	onButton(self, self.prevBtn, function()
		if self.page - 1 <= 0 then
			self.page = self.maxPage
		end

		self:initRank(self.page)

		return
	end, SFX_PANEL)
	setText(self._tf:Find("titles/rank_title"), i18n("vote_label_rank"))
	setText(self._tf:Find("tip"), i18n("vote_label_rank_fresh_time_tip"))

	return
end

function VotePreRaceRankPage:initRank(arg_5_1)
	local var_5_0 = (arg_5_1 - 1) * VotePreRaceRankPage.RANK_DISPLAY_COUNT
	local var_5_1 = self.voteShips

	self.uiitemlist:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			if var_5_1[var_5_0 + arg_6_1 + 1] then
				self:UpdateShipInfo(arg_6_2, var_5_1[var_5_0 + arg_6_1 + 1]:getShipName(), var_5_0 + arg_6_1 + 1)
			end

			setActive(arg_6_2, var_5_1[var_5_0 + arg_6_1 + 1])
		end

		return
	end)
	self.uiitemlist:align(VotePreRaceRankPage.RANK_DISPLAY_COUNT)
	self:UpdateTitle()

	return
end

function VotePreRaceRankPage:UpdateShipInfo(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = self.voteGroup:GetRiseColor(arg_7_3)

	setText(arg_7_1:Find("Text"), setColorStr(shortenString(arg_7_2, 9), var_7_0))
	setText(arg_7_1:Find("number"), setColorStr(arg_7_3, var_7_0))

	return
end

function VotePreRaceRankPage:UpdateTitle()
	local var_8_0 = self.voteGroup:getConfig("next_round_number")

	setActive(self.rankTitle, true)

	return
end

function VotePreRaceRankPage:Update(arg_9_1)
	self.voteGroup = arg_9_1
	self.voteShips = arg_9_1:getList()
	self.page = 1
	self.maxPage = math.ceil(#self.voteShips / VotePreRaceRankPage.RANK_DISPLAY_COUNT)
	self.phase = arg_9_1:GetStage()

	setActive(self.title1, self.phase == VoteGroup.VOTE_STAGE)
	setActive(self.title2, self.phase ~= VoteGroup.VOTE_STAGE)
	setActive(self.tip, self.phase == VoteGroup.VOTE_STAGE)
	self:UpdateTitle()
	self:initRank(self.page)
	self:Show()

	return
end

function VotePreRaceRankPage:OnDestroy()
	return
end

return VotePreRaceRankPage

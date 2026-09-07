local VoteScene = class("VoteScene", import("..base.BaseUI"))

VoteScene.ShipIndexData = {
	customPanels = {
		typeIndex = {
			blueSeleted = true,
			mode = CustomIndexLayer.Mode.AND,
			options = ShipIndexConst.TypeIndexs,
			names = ShipIndexConst.TypeNames
		},
		campIndex = {
			blueSeleted = true,
			mode = CustomIndexLayer.Mode.AND,
			options = ShipIndexConst.CampIndexs,
			names = ShipIndexConst.CampNames
		},
		rarityIndex = {
			blueSeleted = true,
			mode = CustomIndexLayer.Mode.AND,
			options = ShipIndexConst.RarityIndexs,
			names = ShipIndexConst.RarityNames
		}
	},
	groupList = {
		{
			dropdown = false,
			titleENTxt = "indexsort_indexeng",
			titleTxt = "indexsort_index",
			tags = {
				"typeIndex"
			}
		},
		{
			dropdown = false,
			titleENTxt = "indexsort_campeng",
			titleTxt = "indexsort_camp",
			tags = {
				"campIndex"
			}
		},
		{
			dropdown = false,
			titleENTxt = "indexsort_rarityeng",
			titleTxt = "indexsort_rarity",
			tags = {
				"rarityIndex"
			}
		}
	}
}

function VoteScene:getUIName()
	return "VoteUI"
end

function VoteScene:LoadUIFromPool(arg_2_1, arg_2_2)
	local var_2_0 = self.contextData.voteGroup

	VoteScene.super.LoadUIFromPool(self, self.contextData.voteGroup:isFinalsRace() and "VoteUIForFinal" or var_2_0:isResurrectionRace() and "VoteUIForResurrection" or var_2_0:IsFunMetaRace() and "VoteUIForMeta" or var_2_0:IsFunSireRace() and "VoteUIForSire" or var_2_0:IsFunKidRace() and "VoteUIForKid" or "VoteUI", arg_2_2)

	return
end

function VoteScene:init()
	self.title = self._tf:Find("main/right_panel/title/main"):GetComponent(typeof(Text))
	self.titleBg1 = self._tf:Find("main/right_panel/title/title_bg1")
	self.titleBg2 = self._tf:Find("main/right_panel/title/title_bg2")
	self.titleBg3 = self._tf:Find("main/right_panel/title/title_bg3")
	self.subTitle = self._tf:Find("main/right_panel/title/Text"):GetComponent(typeof(Text))
	self.tagtimeTF = self._tf:Find("main/right_panel/title/main/sub"):GetComponent(typeof(Text))
	self.backBtn = self._tf:Find("blur_panel/adapt/top/back_btn")
	self.helpBtn = self._tf:Find("main/right_panel/title/help")
	self.filterBtn = self._tf:Find("main/right_panel/filter_bg/filter_btn")
	self.filterSel = self._tf:Find("main/right_panel/filter_bg/filter_btn/Image")
	self.scheduleBtn = self._tf:Find("main/right_panel/title/schedule")
	self.awardBtn = self._tf:Find("main/right_panel/filter_bg/award_btn")
	self.ticketBtn = self._tf:Find("main/right_panel/filter_bg/ticket")
	self.numberTxt = self._tf:Find("main/right_panel/filter_bg/Text"):GetComponent(typeof(Text))
	self.search = self._tf:Find("main/right_panel/filter_bg/search")

	setText(self._tf:Find("main/right_panel/filter_bg/search/hold"), i18n("dockyard_search_holder"))

	self.ShipIndex = {
		typeIndex = ShipIndexConst.TypeAll,
		campIndex = ShipIndexConst.CampAll,
		rarityIndex = ShipIndexConst.RarityAll
	}

	return
end

function VoteScene:GetPageMap()
	return {
		[VoteConst.RACE_TYPE_PRE] = {
			VotePreRaceShipPage,
			VotePreRaceRankPage
		},
		[VoteConst.RACE_TYPE_GROUP] = {
			VoteGroupRaceShipPage,
			VoteGroupRaceRankPage
		},
		[VoteConst.RACE_TYPE_RESURGENCE] = {
			VoteGroupRaceShipPage,
			VoteGroupRaceRankPage
		},
		[VoteConst.RACE_TYPE_FINAL] = {
			VoteFinalsRaceShipsPage,
			VoteFinalsRaceRankPage
		},
		[VoteConst.RACE_TYPE_PRE_RESURGENCE] = {
			VoteGroupRaceShipPage,
			VoteGroupRaceRankPage
		},
		[VoteConst.RACE_TYPE_FUN] = {
			FunRaceShipsPage,
			VoteFunRaceRankPage
		}
	}
end

function VoteScene:didEnter()
	local var_5_0 = self:GetPageMap()
	local var_5_1 = self.contextData.voteGroup:getConfig("type")

	self.shipsPage = var_5_0[var_5_1][1].New(self._tf:Find("main/right_panel"), self.event, self.contextData)

	self.shipsPage:SetCallBack(function(arg_6_0, arg_6_1)
		seriesAsync({
			function(arg_7_0)
				self:CheckPaintingRes(arg_6_0, arg_7_0)

				return
			end
		}, function()
			self:OnVote(arg_6_0, arg_6_1)

			return
		end)

		return
	end)

	self.rankPage = var_5_0[var_5_1][2].New(self._tf:Find("main/left_panel"), self.event, self.contextData)
	self.voteMsgBox = VoteDiaplayPage.New(self._tf, self.event)
	self.awardWindowPage = VoteAwardWindowPage.New(self._tf, self.event)

	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[self.contextData.voteGroup:getConfig("help_text")].tip
		})

		return
	end, SFX_PANEL)
	setActive(self.helpBtn, false)
	onButton(self, self.filterBtn, function()
		local var_11_0 = Clone(VoteScene.ShipIndexData)

		var_11_0.indexDatas = Clone(self.ShipIndex)

		function var_11_0:callback()
			self.ShipIndex.typeIndex = self.typeIndex
			self.ShipIndex.rarityIndex = self.rarityIndex
			self.ShipIndex.campIndex = self.campIndex

			self:initShips()

			return
		end

		self:emit(VoteMediator.ON_FILTER, var_11_0)

		return
	end, SFX_PANEL)
	onInputEndEdit(self, self.search, function()
		self:initShips()

		return
	end)
	onButton(self, self.scheduleBtn, function()
		self:emit(VoteMediator.ON_SCHEDULE)

		return
	end, SFX_PANEL)
	onButton(self, self.awardBtn, function()
		self.awardWindowPage:ExecuteAction("Show")

		return
	end, SFX_PANEL)
	onButton(self, self.ticketBtn, function()
		self:emit(VoteMediator.OPEN_EXCHANGE)

		return
	end)
	self:updateMainview()
	self:initTitles()

	return
end

function VoteScene:CheckPaintingRes(arg_17_1, arg_17_2)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs({
		(arg_17_1.voteShip:getPainting())
	}) do
		PaintingGroupConst.AddPaintingNameWithFilteMap(var_17_0, iter_17_1)
	end

	PaintingGroupConst.PaintingDownload({
		isShowBox = true,
		paintingNameList = var_17_0,
		finishFunc = arg_17_2
	})

	return
end

function VoteScene:OnVote(arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1.voteShip
	local var_18_1 = self:GetVotes()

	arg_18_2 = defaultValue(arg_18_2, false)

	self.voteMsgBox:ExecuteAction("Open", arg_18_1.voteShip, self.contextData.voteGroup:GetRank(arg_18_1.voteShip), var_18_1, arg_18_2, function(arg_19_0)
		if self.contextData.voteGroup:GetStage() ~= VoteGroup.VOTE_STAGE then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		if arg_19_0 <= var_18_1 then
			self:emit(VoteMediator.ON_VOTE, self.contextData.voteGroup.id, var_18_0.group, arg_19_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("vote_not_enough"))
		end

		return
	end)

	return
end

function VoteScene:updateMainview()
	self:initShips()
	self:initRanks()
	self:updateNumber()

	return
end

function VoteScene:initRanks()
	self.rankPage:ExecuteAction("Update", self.contextData.voteGroup)

	return
end

function VoteScene:initShips()
	self.displays = {}

	local var_22_0 = getInputText(self.search)

	for iter_22_0, iter_22_1 in ipairs((self.contextData.voteGroup:GetRankList())) do
		if self.ShipIndex.typeIndex == ShipIndexConst.TypeAll and self.ShipIndex.rarityIndex == ShipIndexConst.RarityAll and self.ShipIndex.campIndex == ShipIndexConst.CampAll and iter_22_1:IsMatchSearchKey(var_22_0) then
			table.insert(self.displays, iter_22_1)
		else
			local var_22_1 = iter_22_1

			if ShipIndexConst.filterByType(iter_22_1, self.ShipIndex.typeIndex) and ShipIndexConst.filterByRarity(var_22_1, self.ShipIndex.rarityIndex) and ShipIndexConst.filterByCamp(var_22_1, self.ShipIndex.campIndex) and iter_22_1:IsMatchSearchKey(var_22_0) then
				table.insert(self.displays, iter_22_1)
			end
		end
	end

	self.shipsPage:ExecuteAction("Update", self.contextData.voteGroup, self.displays, (self:GetVotes()))
	setActive(self.filterSel, self.ShipIndex.typeIndex ~= ShipIndexConst.TypeAll or self.ShipIndex.campIndex ~= ShipIndexConst.CampAll or self.ShipIndex.rarityIndex ~= ShipIndexConst.RarityAll)

	return
end

function VoteScene:initTitles()
	self.tagtimeTF.text = self.contextData.voteGroup:getTimeDesc()

	if not self.contextData.voteGroup:isFinalsRace() then
		self.title.text = self.contextData.voteGroup:getConfig("name")
	end

	self.subTitle.text = self.contextData.voteGroup:getConfig("desc")

	return
end

function VoteScene:updateNumber()
	self.numberTxt.text = "X" .. self:GetVotes()

	return
end

function VoteScene:GetVotes()
	return (getProxy(VoteProxy):GetVotesByConfigId(self.contextData.voteGroup.configId))
end

function VoteScene:onBackPressed()
	if self.voteMsgBox and self.voteMsgBox:GetLoaded() and self.voteMsgBox:isShowing() then
		self.voteMsgBox:Close()

		return
	end

	if self.awardWindowPage and self.awardWindowPage:GetLoaded() and self.awardWindowPage:isShowing() then
		self.awardWindowPage:Hide()

		return
	end

	self:emit(VoteScene.ON_BACK_PRESSED)

	return
end

function VoteScene:willExit()
	if self.rankPage then
		self.rankPage:Destroy()

		self.rankPage = nil
	end

	if self.shipsPage then
		self.shipsPage:Destroy()

		self.shipsPage = nil
	end

	if self.voteMsgBox then
		self.voteMsgBox:Destroy()

		self.voteMsgBox = nil
	end

	if self.awardWindowPage then
		self.awardWindowPage:Destroy()

		self.awardWindowPage = nil
	end

	return
end

return VoteScene

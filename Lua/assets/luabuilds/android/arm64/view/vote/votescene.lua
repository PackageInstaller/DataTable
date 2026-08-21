local var_0_0 = class("VoteScene", import("..base.BaseUI"))

var_0_0.ShipIndexData = {
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

function var_0_0.getUIName(arg_1_0)
	return "VoteUI"
end

function var_0_0.LoadUIFromPool(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.LoadUIFromPool(arg_2_0, arg_2_0.contextData.voteGroup:isFinalsRace() and "VoteUIForFinal" or var_2_0:isResurrectionRace() and "VoteUIForResurrection" or var_2_0:IsFunMetaRace() and "VoteUIForMeta" or var_2_0:IsFunSireRace() and "VoteUIForSire" or var_2_0:IsFunKidRace() and "VoteUIForKid" or "VoteUI", arg_2_2)

	return
end

function var_0_0.init(arg_3_0)
	arg_3_0.title = arg_3_0._tf:Find("main/right_panel/title/main"):GetComponent(typeof(Text))
	arg_3_0.titleBg1 = arg_3_0._tf:Find("main/right_panel/title/title_bg1")
	arg_3_0.titleBg2 = arg_3_0._tf:Find("main/right_panel/title/title_bg2")
	arg_3_0.titleBg3 = arg_3_0._tf:Find("main/right_panel/title/title_bg3")
	arg_3_0.subTitle = arg_3_0._tf:Find("main/right_panel/title/Text"):GetComponent(typeof(Text))
	arg_3_0.tagtimeTF = arg_3_0._tf:Find("main/right_panel/title/main/sub"):GetComponent(typeof(Text))
	arg_3_0.backBtn = arg_3_0._tf:Find("blur_panel/adapt/top/back_btn")
	arg_3_0.helpBtn = arg_3_0._tf:Find("main/right_panel/title/help")
	arg_3_0.filterBtn = arg_3_0._tf:Find("main/right_panel/filter_bg/filter_btn")
	arg_3_0.filterSel = arg_3_0._tf:Find("main/right_panel/filter_bg/filter_btn/Image")
	arg_3_0.scheduleBtn = arg_3_0._tf:Find("main/right_panel/title/schedule")
	arg_3_0.awardBtn = arg_3_0._tf:Find("main/right_panel/filter_bg/award_btn")
	arg_3_0.ticketBtn = arg_3_0._tf:Find("main/right_panel/filter_bg/ticket")
	arg_3_0.numberTxt = arg_3_0._tf:Find("main/right_panel/filter_bg/Text"):GetComponent(typeof(Text))
	arg_3_0.search = arg_3_0._tf:Find("main/right_panel/filter_bg/search")

	setText(arg_3_0._tf:Find("main/right_panel/filter_bg/search/hold"), i18n("dockyard_search_holder"))

	arg_3_0.ShipIndex = {
		typeIndex = ShipIndexConst.TypeAll,
		campIndex = ShipIndexConst.CampAll,
		rarityIndex = ShipIndexConst.RarityAll
	}

	return
end

function var_0_0.GetPageMap(arg_4_0)
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

function var_0_0.didEnter(arg_5_0)
	local var_5_0 = arg_5_0:GetPageMap()
	local var_5_1 = arg_5_0.contextData.voteGroup:getConfig("type")

	arg_5_0.shipsPage = var_5_0[var_5_1][1].New(arg_5_0._tf:Find("main/right_panel"), arg_5_0.event, arg_5_0.contextData)

	arg_5_0.shipsPage:SetCallBack(function(arg_6_0, arg_6_1)
		seriesAsync({
			function(arg_7_0)
				arg_5_0:CheckPaintingRes(arg_6_0, arg_7_0)

				return
			end
		}, function()
			arg_5_0:OnVote(arg_6_0, arg_6_1)

			return
		end)

		return
	end)

	arg_5_0.rankPage = var_5_0[var_5_1][2].New(arg_5_0._tf:Find("main/left_panel"), arg_5_0.event, arg_5_0.contextData)
	arg_5_0.voteMsgBox = VoteDiaplayPage.New(arg_5_0._tf, arg_5_0.event)
	arg_5_0.awardWindowPage = VoteAwardWindowPage.New(arg_5_0._tf, arg_5_0.event)

	onButton(arg_5_0, arg_5_0.backBtn, function()
		arg_5_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_5_0, arg_5_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[arg_5_0.contextData.voteGroup:getConfig("help_text")].tip
		})

		return
	end, SFX_PANEL)
	setActive(arg_5_0.helpBtn, false)
	onButton(arg_5_0, arg_5_0.filterBtn, function()
		local var_11_0 = Clone(var_0_0.ShipIndexData)

		var_11_0.indexDatas = Clone(arg_5_0.ShipIndex)

		function var_11_0.callback(arg_12_0)
			arg_5_0.ShipIndex.typeIndex = arg_12_0.typeIndex
			arg_5_0.ShipIndex.rarityIndex = arg_12_0.rarityIndex
			arg_5_0.ShipIndex.campIndex = arg_12_0.campIndex

			arg_5_0:initShips()

			return
		end

		arg_5_0:emit(VoteMediator.ON_FILTER, var_11_0)

		return
	end, SFX_PANEL)
	onInputEndEdit(arg_5_0, arg_5_0.search, function()
		arg_5_0:initShips()

		return
	end)
	onButton(arg_5_0, arg_5_0.scheduleBtn, function()
		arg_5_0:emit(VoteMediator.ON_SCHEDULE)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.awardBtn, function()
		arg_5_0.awardWindowPage:ExecuteAction("Show")

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.ticketBtn, function()
		arg_5_0:emit(VoteMediator.OPEN_EXCHANGE)

		return
	end)
	arg_5_0:updateMainview()
	arg_5_0:initTitles()

	return
end

function var_0_0.CheckPaintingRes(arg_17_0, arg_17_1, arg_17_2)
	for iter_17_0, iter_17_1 in ipairs({
		(arg_17_1.voteShip:getPainting())
	}) do
		PaintingGroupConst.AddPaintingNameWithFilteMap({}, iter_17_1)
	end

	PaintingGroupConst.PaintingDownload({
		isShowBox = true,
		paintingNameList = {},
		finishFunc = arg_17_2
	})

	return
end

function var_0_0.OnVote(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2 = defaultValue(arg_18_2, false)

	arg_18_0.voteMsgBox:ExecuteAction("Open", arg_18_1.voteShip, arg_18_0.contextData.voteGroup:GetRank(arg_18_1.voteShip), arg_18_0:GetVotes(), arg_18_2, function(arg_19_0)
		if arg_18_0.contextData.voteGroup:GetStage() ~= VoteGroup.VOTE_STAGE then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		if arg_19_0 <= var_0 then
			arg_18_0:emit(VoteMediator.ON_VOTE, arg_18_0.contextData.voteGroup.id, var_0.group, arg_19_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("vote_not_enough"))
		end

		return
	end)

	return
end

function var_0_0.updateMainview(arg_20_0)
	arg_20_0:initShips()
	arg_20_0:initRanks()
	arg_20_0:updateNumber()

	return
end

function var_0_0.initRanks(arg_21_0)
	arg_21_0.rankPage:ExecuteAction("Update", arg_21_0.contextData.voteGroup)

	return
end

function var_0_0.initShips(arg_22_0)
	arg_22_0.displays = {}

	local var_22_0 = getInputText(arg_22_0.search)

	for iter_22_0, iter_22_1 in ipairs((arg_22_0.contextData.voteGroup:GetRankList())) do
		if arg_22_0.ShipIndex.typeIndex == ShipIndexConst.TypeAll and arg_22_0.ShipIndex.rarityIndex == ShipIndexConst.RarityAll and arg_22_0.ShipIndex.campIndex == ShipIndexConst.CampAll and iter_22_1:IsMatchSearchKey(var_22_0) then
			table.insert(arg_22_0.displays, iter_22_1)
		else
			local var_22_1 = iter_22_1

			if ShipIndexConst.filterByType(iter_22_1, arg_22_0.ShipIndex.typeIndex) and ShipIndexConst.filterByRarity(var_22_1, arg_22_0.ShipIndex.rarityIndex) and ShipIndexConst.filterByCamp(var_22_1, arg_22_0.ShipIndex.campIndex) and iter_22_1:IsMatchSearchKey(var_22_0) then
				table.insert(arg_22_0.displays, iter_22_1)
			end
		end
	end

	arg_22_0.shipsPage:ExecuteAction("Update", arg_22_0.contextData.voteGroup, arg_22_0.displays, (arg_22_0:GetVotes()))
	setActive(arg_22_0.filterSel, arg_22_0.ShipIndex.typeIndex ~= ShipIndexConst.TypeAll or arg_22_0.ShipIndex.campIndex ~= ShipIndexConst.CampAll or arg_22_0.ShipIndex.rarityIndex ~= ShipIndexConst.RarityAll)

	return
end

function var_0_0.initTitles(arg_23_0)
	arg_23_0.tagtimeTF.text = arg_23_0.contextData.voteGroup:getTimeDesc()

	if not arg_23_0.contextData.voteGroup:isFinalsRace() then
		arg_23_0.title.text = arg_23_0.contextData.voteGroup:getConfig("name")
	end

	arg_23_0.subTitle.text = arg_23_0.contextData.voteGroup:getConfig("desc")

	return
end

function var_0_0.updateNumber(arg_24_0)
	arg_24_0.numberTxt.text = "X" .. arg_24_0:GetVotes()

	return
end

function var_0_0.GetVotes(arg_25_0)
	return (getProxy(VoteProxy):GetVotesByConfigId(arg_25_0.contextData.voteGroup.configId))
end

function var_0_0.onBackPressed(arg_26_0)
	if arg_26_0.voteMsgBox and arg_26_0.voteMsgBox:GetLoaded() and arg_26_0.voteMsgBox:isShowing() then
		arg_26_0.voteMsgBox:Close()

		return
	end

	if arg_26_0.awardWindowPage and arg_26_0.awardWindowPage:GetLoaded() and arg_26_0.awardWindowPage:isShowing() then
		arg_26_0.awardWindowPage:Hide()

		return
	end

	arg_26_0:emit(var_0_0.ON_BACK_PRESSED)

	return
end

function var_0_0.willExit(arg_27_0)
	if arg_27_0.rankPage then
		arg_27_0.rankPage:Destroy()

		arg_27_0.rankPage = nil
	end

	if arg_27_0.shipsPage then
		arg_27_0.shipsPage:Destroy()

		arg_27_0.shipsPage = nil
	end

	if arg_27_0.voteMsgBox then
		arg_27_0.voteMsgBox:Destroy()

		arg_27_0.voteMsgBox = nil
	end

	if arg_27_0.awardWindowPage then
		arg_27_0.awardWindowPage:Destroy()

		arg_27_0.awardWindowPage = nil
	end

	return
end

return var_0_0

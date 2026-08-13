class = var_0_10000

local var_0_0 = "VoteScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {
	blueSeleted = true
}

CustomIndexLayer = var_0_10004
var_0_4.mode = var_0_10004.Mode.AND
ShipIndexConst = var_4
var_0_4.options = var_4.TypeIndexs
ShipIndexConst = var_4
var_0_4.names = var_4.TypeNames
var_0_3.typeIndex = var_0_4

local var_0_5 = {
	blueSeleted = true
}

CustomIndexLayer = var_4
var_0_5.mode = var_4.Mode.AND
ShipIndexConst = var_4
var_0_5.options = var_4.CampIndexs
ShipIndexConst = var_4
var_0_5.names = var_4.CampNames
var_0_3.campIndex = var_0_5

local var_0_6 = {
	blueSeleted = true
}

CustomIndexLayer = var_4
var_0_6.mode = var_4.Mode.AND
ShipIndexConst = var_4
var_0_6.options = var_4.RarityIndexs
ShipIndexConst = var_4
var_0_6.names = var_4.RarityNames
var_0_3.rarityIndex = var_0_6
var_0_2.customPanels = var_0_3
var_0_2.groupList = {
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
var_0_1.ShipIndexData = var_0_2

function var_0_1.getUIName(arg_1_0)
	return "VoteUI"
end

function var_0_1.LoadUIFromPool(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0.contextData.voteGroup
	local var_2_1
	local var_2_2 = var_2_0:isFinalsRace() and "VoteUIForFinal" or var_2_0:isResurrectionRace() and "VoteUIForResurrection" or var_2_0:IsFunMetaRace() and "VoteUIForMeta" or var_2_0:IsFunSireRace() and "VoteUIForSire" or var_2_0:IsFunKidRace() and "VoteUIForKid" or "VoteUI"

	var_0_1.super.LoadUIFromPool(arg_2_0, var_2_2, arg_2_2)

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "main/right_panel/title/main")
	local var_3_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0.title = var_3_2(var_3_1, var_3(var_1_10004))

	local var_3_3 = arg_3_0._tf

	arg_3_0.titleBg1 = var_1.Find(var_3_3, "main/right_panel/title/title_bg1")

	local var_3_4 = arg_3_0._tf

	arg_3_0.titleBg2 = var_1.Find(var_3_4, "main/right_panel/title/title_bg2")

	local var_3_5 = arg_3_0._tf

	arg_3_0.titleBg3 = var_1.Find(var_3_5, "main/right_panel/title/title_bg3")

	local var_3_6 = arg_3_0._tf
	local var_3_7 = var_1.Find(var_3_6, "main/right_panel/title/Text")
	local var_3_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0.subTitle = var_3_8(var_3_7, var_3(var_1_10004))

	local var_3_9 = arg_3_0._tf
	local var_3_10 = var_1.Find(var_3_9, "main/right_panel/title/main/sub")
	local var_3_11 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0.tagtimeTF = var_3_11(var_3_10, var_3(var_1_10004))

	local var_3_12 = arg_3_0._tf

	arg_3_0.backBtn = var_1.Find(var_3_12, "blur_panel/adapt/top/back_btn")

	local var_3_13 = arg_3_0._tf

	arg_3_0.helpBtn = var_1.Find(var_3_13, "main/right_panel/title/help")

	local var_3_14 = arg_3_0._tf

	arg_3_0.filterBtn = var_1.Find(var_3_14, "main/right_panel/filter_bg/filter_btn")

	local var_3_15 = arg_3_0._tf

	arg_3_0.filterSel = var_1.Find(var_3_15, "main/right_panel/filter_bg/filter_btn/Image")

	local var_3_16 = arg_3_0._tf

	arg_3_0.scheduleBtn = var_1.Find(var_3_16, "main/right_panel/title/schedule")

	local var_3_17 = arg_3_0._tf

	arg_3_0.awardBtn = var_1.Find(var_3_17, "main/right_panel/filter_bg/award_btn")

	local var_3_18 = arg_3_0._tf

	arg_3_0.ticketBtn = var_1.Find(var_3_18, "main/right_panel/filter_bg/ticket")

	local var_3_19 = arg_3_0._tf
	local var_3_20 = var_1.Find(var_3_19, "main/right_panel/filter_bg/Text")
	local var_3_21 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0.numberTxt = var_3_21(var_3_20, var_3(var_1_10004))

	local var_3_22 = arg_3_0._tf

	arg_3_0.search = var_1.Find(var_3_22, "main/right_panel/filter_bg/search")
	setText = var_1

	local var_3_23 = arg_3_0._tf
	local var_3_24 = var_2.Find(var_3_23, "main/right_panel/filter_bg/search/hold")

	i18n = var_3_23

	var_1(var_3_24, var_3_23("dockyard_search_holder"))

	local var_3_25 = {}

	ShipIndexConst = var_3_24
	var_3_25.typeIndex = var_3_24.TypeAll
	ShipIndexConst = var_2
	var_3_25.campIndex = var_2.CampAll
	ShipIndexConst = var_2
	var_3_25.rarityIndex = var_2.RarityAll
	arg_3_0.ShipIndex = var_3_25

	return
end

function var_0_1.GetPageMap(arg_4_0)
	local var_4_0 = {}

	VoteConst = var_1_10002

	local var_4_1 = var_1_10002.RACE_TYPE_PRE
	local var_4_2 = {}

	VotePreRaceShipPage = var_1_10004
	var_4_2[1] = var_1_10004
	VotePreRaceRankPage = var_1_10004
	var_4_2[2] = var_1_10004
	var_4_0[var_4_1] = var_4_2
	VoteConst = var_4_1

	local var_4_3 = var_4_1.RACE_TYPE_GROUP
	local var_4_4 = {}

	VoteGroupRaceShipPage = var_1_10004
	var_4_4[1] = var_1_10004
	VoteGroupRaceRankPage = var_1_10004
	var_4_4[2] = var_1_10004
	var_4_0[var_4_3] = var_4_4
	VoteConst = var_4_3

	local var_4_5 = var_4_3.RACE_TYPE_RESURGENCE
	local var_4_6 = {}

	VoteGroupRaceShipPage = var_1_10004
	var_4_6[1] = var_1_10004
	VoteGroupRaceRankPage = var_1_10004
	var_4_6[2] = var_1_10004
	var_4_0[var_4_5] = var_4_6
	VoteConst = var_4_5

	local var_4_7 = var_4_5.RACE_TYPE_FINAL
	local var_4_8 = {}

	VoteFinalsRaceShipsPage = var_1_10004
	var_4_8[1] = var_1_10004
	VoteFinalsRaceRankPage = var_1_10004
	var_4_8[2] = var_1_10004
	var_4_0[var_4_7] = var_4_8
	VoteConst = var_4_7

	local var_4_9 = var_4_7.RACE_TYPE_PRE_RESURGENCE
	local var_4_10 = {}

	VoteGroupRaceShipPage = var_1_10004
	var_4_10[1] = var_1_10004
	VoteGroupRaceRankPage = var_1_10004
	var_4_10[2] = var_1_10004
	var_4_0[var_4_9] = var_4_10
	VoteConst = var_4_9

	local var_4_11 = var_4_9.RACE_TYPE_FUN
	local var_4_12 = {}

	FunRaceShipsPage = var_1_10004
	var_4_12[1] = var_1_10004
	VoteFunRaceRankPage = var_1_10004
	var_4_12[2] = var_1_10004
	var_4_0[var_4_11] = var_4_12

	return var_4_0
end

function var_0_1.didEnter(arg_5_0)
	local var_5_0 = arg_5_0:GetPageMap()
	local var_5_1 = arg_5_0.contextData.voteGroup
	local var_5_2 = var_5_0[var_2.getConfig(var_5_1, "type")][1]
	local var_5_3 = var_5_0[var_2][2]
	local var_5_4 = var_5_2.New
	local var_5_5 = arg_5_0._tf

	arg_5_0.shipsPage = var_5_4(var_6.Find(var_5_5, "main/right_panel"), arg_5_0.event, arg_5_0.contextData)

	local var_5_6 = arg_5_0.shipsPage

	var_5.SetCallBack(var_5_6, function(arg_6_0, arg_6_1)
		seriesAsync = var_2_10002

		var_2_10002({
			function(arg_7_0)
				local var_7_0 = arg_5_0

				var_1.CheckPaintingRes(var_7_0, arg_6_0, arg_7_0)

				return
			end
		}, function()
			local var_8_0 = arg_5_0

			var_0.OnVote(var_8_0, arg_6_0, arg_6_1)

			return
		end)

		return
	end)

	local var_5_7 = var_5_3.New
	local var_5_8 = arg_5_0._tf

	arg_5_0.rankPage = var_5_7(var_6.Find(var_5_8, "main/left_panel"), arg_5_0.event, arg_5_0.contextData)
	VoteDiaplayPage = var_5
	arg_5_0.voteMsgBox = var_5.New(arg_5_0._tf, arg_5_0.event)
	VoteAwardWindowPage = var_5
	arg_5_0.awardWindowPage = var_5.New(arg_5_0._tf, arg_5_0.event)
	onButton = var_5

	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0.backBtn

	local function var_5_11()
		local var_9_0 = arg_5_0

		var_0.closeView(var_9_0)

		return
	end

	SFX_CANCEL = var_1_10009

	var_5(var_5_9, var_5_10, var_5_11, var_1_10009)

	onButton = var_5

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.helpBtn

	local function var_5_14()
		local var_10_0 = arg_5_0.contextData.voteGroup
		local var_10_1 = var_0.getConfig(var_10_0, "help_text")

		pg = var_10_0

		local var_10_2 = var_10_0.MsgboxMgr.GetInstance()
		local var_10_3 = var_1.ShowMsgBox
		local var_10_4 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_10_4.type = var_2_10004
		pg = var_2_10004
		var_10_4.helps = var_2_10004.gametip[var_10_1].tip

		var_10_3(var_10_2, var_10_4)

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_5_12, var_5_13, var_5_14, var_1_10009)

	setActive = var_5

	var_5(arg_5_0.helpBtn, false)

	onButton = var_5

	local var_5_15 = arg_5_0
	local var_5_16 = arg_5_0.filterBtn

	local function var_5_17()
		Clone = var_2_10000

		local var_11_0 = var_2_10000(var_0_1.ShipIndexData)

		Clone = var_1
		var_11_0.indexDatas = var_1(arg_5_0.ShipIndex)

		function var_11_0.callback(arg_12_0)
			arg_5_0.ShipIndex.typeIndex = arg_12_0.typeIndex
			arg_5_0.ShipIndex.rarityIndex = arg_12_0.rarityIndex
			arg_5_0.ShipIndex.campIndex = arg_12_0.campIndex

			local var_12_0 = arg_5_0

			var_1.initShips(var_12_0)

			return
		end

		local var_11_1 = arg_5_0
		local var_11_2 = var_1.emit

		VoteMediator = var_2_10003

		var_11_2(var_11_1, var_2_10003.ON_FILTER, var_11_0)

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_5_15, var_5_16, var_5_17, var_1_10009)

	onInputEndEdit = var_5

	var_5(arg_5_0, arg_5_0.search, function()
		local var_13_0 = arg_5_0

		var_0.initShips(var_13_0)

		return
	end)

	onButton = var_5

	local var_5_18 = arg_5_0
	local var_5_19 = arg_5_0.scheduleBtn

	local function var_5_20()
		local var_14_0 = arg_5_0
		local var_14_1 = var_0.emit

		VoteMediator = var_2_10002

		var_14_1(var_14_0, var_2_10002.ON_SCHEDULE)

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_5_18, var_5_19, var_5_20, var_1_10009)

	onButton = var_5

	local var_5_21 = arg_5_0
	local var_5_22 = arg_5_0.awardBtn

	local function var_5_23()
		local var_15_0 = arg_5_0.awardWindowPage

		var_0.ExecuteAction(var_15_0, "Show")

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_5_21, var_5_22, var_5_23, var_1_10009)

	onButton = var_5

	var_5(arg_5_0, arg_5_0.ticketBtn, function()
		local var_16_0 = arg_5_0
		local var_16_1 = var_0.emit

		VoteMediator = var_2_10002

		var_16_1(var_16_0, var_2_10002.OPEN_EXCHANGE)

		return
	end)
	arg_5_0:updateMainview()
	arg_5_0:initTitles()

	return
end

function var_0_1.CheckPaintingRes(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1.voteShip
	local var_17_1 = var_3.getPainting(var_17_0)
	local var_17_2 = {}

	ipairs = var_1_10006

	for iter_17_0, iter_17_1 in var_1_10006({
		var_17_1
	}) do
		PaintingGroupConst = var_1_10011

		var_1_10011.AddPaintingNameWithFilteMap(var_17_2, iter_17_1)
	end

	PaintingGroupConst = var_6

	var_6.PaintingDownload({
		isShowBox = true,
		paintingNameList = var_17_2,
		finishFunc = arg_17_2
	})

	return
end

function var_0_1.OnVote(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1.voteShip
	local var_18_1 = arg_18_0.contextData.voteGroup
	local var_18_2 = var_4.GetRank(var_18_1, var_18_0)
	local var_18_3 = arg_18_0
	local var_18_4 = arg_18_0.GetVotes(var_18_3)

	defaultValue = var_18_3
	arg_18_2 = var_18_3(arg_18_2, false)

	local var_18_5 = arg_18_0.voteMsgBox

	var_6.ExecuteAction(var_18_5, "Open", var_18_0, var_18_2, var_18_4, arg_18_2, function(arg_19_0)
		local var_19_0 = arg_18_0.contextData.voteGroup
		local var_19_1 = var_1.GetStage(var_19_0)

		VoteGroup = var_19_0

		if var_19_1 ~= var_19_0.VOTE_STAGE then
			pg = var_19_1

			local var_19_2 = var_19_1.TipsMgr.GetInstance()
			local var_19_3 = var_1.ShowTips

			i18n = var_2_10003

			var_19_3(var_19_2, var_2_10003("common_activity_end"))

			return
		end

		local var_19_5

		if arg_19_0 <= var_18_4 then
			local var_19_4 = arg_18_0

			var_19_5 = var_19_5.emit
			VoteMediator = var_2_10003

			var_19_5(var_19_4, var_2_10003.ON_VOTE, arg_18_0.contextData.voteGroup.id, var_18_0.group, arg_19_0)
		else
			pg = var_19_5

			local var_19_6 = var_19_5.TipsMgr.GetInstance()
			local var_19_7 = var_1.ShowTips

			i18n = var_2_10003

			var_19_7(var_19_6, var_2_10003("vote_not_enough"))
		end

		return
	end)

	return
end

function var_0_1.updateMainview(arg_20_0)
	arg_20_0:initShips()
	arg_20_0:initRanks()
	arg_20_0:updateNumber()

	return
end

function var_0_1.initRanks(arg_21_0)
	local var_21_0 = arg_21_0.rankPage

	var_1.ExecuteAction(var_21_0, "Update", arg_21_0.contextData.voteGroup)

	return
end

function var_0_1.initShips(arg_22_0)
	arg_22_0.displays = {}

	local var_22_0 = arg_22_0.contextData.voteGroup
	local var_22_1 = var_1.GetRankList(var_22_0)

	getInputText = var_22_0

	local var_22_2 = var_22_0(arg_22_0.search)

	ipairs = var_3

	for iter_22_0, iter_22_1 in var_3(var_22_1) do
		local var_22_3 = arg_22_0.ShipIndex.typeIndex

		ShipIndexConst = var_1_10009

		if var_22_3 == var_1_10009.TypeAll then
			local var_22_4 = arg_22_0.ShipIndex.rarityIndex

			ShipIndexConst = var_1_10009

			if var_22_4 == var_1_10009.RarityAll then
				local var_22_5 = arg_22_0.ShipIndex.campIndex

				ShipIndexConst = var_1_10009

				if var_22_5 == var_1_10009.CampAll then
					var_1_10009 = iter_22_1

					if iter_22_1.IsMatchSearchKey(var_1_10009, var_22_2) then
						table = var_8

						var_8.insert(arg_22_0.displays, iter_22_1)

						goto label_22_0
					end
				end
			end
		end

		do
			local var_22_6 = iter_22_1

			ShipIndexConst = var_1_10009

			if var_1_10009.filterByType(var_22_6, arg_22_0.ShipIndex.typeIndex) then
				ShipIndexConst = var_1_10009

				if var_1_10009.filterByRarity(var_22_6, arg_22_0.ShipIndex.rarityIndex) then
					ShipIndexConst = var_1_10009

					if var_1_10009.filterByCamp(var_22_6, arg_22_0.ShipIndex.campIndex) and iter_22_1:IsMatchSearchKey(var_22_2) then
						table = var_1_10009

						var_1_10009.insert(arg_22_0.displays, iter_22_1)
					end
				end
			end
		end

		::label_22_0::
	end

	local var_22_7 = arg_22_0:GetVotes()
	local var_22_8 = arg_22_0.shipsPage

	var_4.ExecuteAction(var_22_8, "Update", arg_22_0.contextData.voteGroup, arg_22_0.displays, var_22_7)

	setActive = var_4

	local var_22_9 = arg_22_0.filterSel
	local var_22_10 = arg_22_0.ShipIndex.typeIndex

	ShipIndexConst = var_7

	local var_22_13

	if var_22_10 == var_7.TypeAll then
		local var_22_11 = arg_22_0.ShipIndex.campIndex

		ShipIndexConst = var_7

		if var_22_11 == var_7.CampAll then
			local var_22_12 = arg_22_0.ShipIndex.rarityIndex

			ShipIndexConst = var_7

			if var_22_12 == var_7.RarityAll then
				var_22_13 = false

				goto label_22_1
			end
		end
	end

	var_22_13 = true

	::label_22_1::

	var_4(var_22_9, var_22_13)

	return
end

function var_0_1.initTitles(arg_23_0)
	local var_23_0 = arg_23_0.tagtimeTF
	local var_23_1 = arg_23_0.contextData.voteGroup

	var_23_0.text = var_2.getTimeDesc(var_23_1)

	local var_23_2 = arg_23_0.contextData.voteGroup

	if not var_1.isFinalsRace(var_23_2) then
		local var_23_3 = arg_23_0.title
		local var_23_4 = arg_23_0.contextData.voteGroup

		var_23_3.text = var_2.getConfig(var_23_4, "name")
	end

	local var_23_5 = arg_23_0.subTitle
	local var_23_6 = arg_23_0.contextData.voteGroup

	var_23_5.text = var_2.getConfig(var_23_6, "desc")

	return
end

function var_0_1.updateNumber(arg_24_0)
	arg_24_0.numberTxt.text = "X" .. arg_24_0:GetVotes()

	return
end

function var_0_1.GetVotes(arg_25_0)
	getProxy = var_1_10001
	VoteProxy = var_1_10002

	local var_25_0 = var_1_10001(var_1_10002)

	return (var_1.GetVotesByConfigId(var_25_0, arg_25_0.contextData.voteGroup.configId))
end

function var_0_1.onBackPressed(arg_26_0)
	if arg_26_0.voteMsgBox then
		local var_26_0 = arg_26_0.voteMsgBox

		if var_1.GetLoaded(var_26_0) then
			local var_26_1 = arg_26_0.voteMsgBox

			if var_1.isShowing(var_26_1) then
				local var_26_2 = arg_26_0.voteMsgBox

				var_1.Close(var_26_2)

				return
			end
		end
	end

	if arg_26_0.awardWindowPage then
		local var_26_3 = arg_26_0.awardWindowPage

		if var_1.GetLoaded(var_26_3) then
			local var_26_4 = arg_26_0.awardWindowPage

			if var_1.isShowing(var_26_4) then
				local var_26_5 = arg_26_0.awardWindowPage

				var_1.Hide(var_26_5)

				return
			end
		end
	end

	arg_26_0:emit(var_0_1.ON_BACK_PRESSED)

	return
end

function var_0_1.willExit(arg_27_0)
	if arg_27_0.rankPage then
		local var_27_0 = arg_27_0.rankPage

		var_1.Destroy(var_27_0)

		arg_27_0.rankPage = nil
	end

	if arg_27_0.shipsPage then
		local var_27_1 = arg_27_0.shipsPage

		var_1.Destroy(var_27_1)

		arg_27_0.shipsPage = nil
	end

	if arg_27_0.voteMsgBox then
		local var_27_2 = arg_27_0.voteMsgBox

		var_1.Destroy(var_27_2)

		arg_27_0.voteMsgBox = nil
	end

	if arg_27_0.awardWindowPage then
		local var_27_3 = arg_27_0.awardWindowPage

		var_1.Destroy(var_27_3)

		arg_27_0.awardWindowPage = nil
	end

	return
end

return var_0_1

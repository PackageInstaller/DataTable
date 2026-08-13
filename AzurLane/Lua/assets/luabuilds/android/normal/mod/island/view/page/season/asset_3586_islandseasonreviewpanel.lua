class = var_0_10000

local var_0_0 = "IslandSeasonReviewPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandSeasonReviewPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "content")

	arg_2_0.leftPanel = var_1.Find(var_2_1, "left")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "content/left/Image")
	local var_2_4 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_2_0.titleImg = var_2_4(var_2_3, var_4(var_1_10005))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_2.Find(var_2_5, "content/left/num")
	local var_2_7 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_2_0.seasonNumImg = var_2_7(var_2_6, var_4(var_1_10005))
	arg_2_0.infoPanel = var_1:Find("infos")
	arg_2_0.emptyTF = var_1:Find("empty")
	setText = var_2

	local var_2_8 = arg_2_0.emptyTF
	local var_2_9 = var_3.Find(var_2_8, "Text")

	i18n = var_2_8

	var_2(var_2_9, var_2_8("island_season_review_miss"))

	setText = var_2

	local var_2_10 = arg_2_0.infoPanel
	local var_2_11 = var_3.Find(var_2_10, "season/title/Text")

	i18n = var_2_10

	var_2(var_2_11, var_2_10("island_season_title"))

	setText = var_2

	local var_2_12 = arg_2_0.infoPanel
	local var_2_13 = var_3.Find(var_2_12, "prod/title/Text")

	i18n = var_2_12

	var_2(var_2_13, var_2_12("island_season_review_produce"))

	setText = var_2

	local var_2_14 = arg_2_0.infoPanel
	local var_2_15 = var_3.Find(var_2_14, "relax/title/Text")

	i18n = var_2_14

	var_2(var_2_15, var_2_14("island_season_review_relax"))

	IslandSeasonSwitchPanel = var_2
	arg_2_0.switchPanel = var_2.New(arg_2_0._tf)

	local var_2_16 = arg_2_0.infoPanel

	arg_2_0.iconTF = var_2.Find(var_2_16, "island/icon_mask/icon")

	local var_2_17 = {}
	local var_2_18 = arg_2_0.infoPanel

	var_2_17[1] = var_3.Find(var_2_18, "island/list")

	local var_2_19 = arg_2_0.infoPanel

	var_2_17[2] = var_3.Find(var_2_19, "season/list")

	local var_2_20 = arg_2_0.infoPanel

	var_2_17[3] = var_3.Find(var_2_20, "prod/list")

	local var_2_21 = arg_2_0.infoPanel

	var_2_17[4] = var_3.Find(var_2_21, "relax/list")
	arg_2_0.infoTFs = var_2_17
	ipairs = var_2_17

	for iter_2_0, iter_2_1 in var_2_17(arg_2_0.infoTFs) do
		eachChild = var_1_10007

		var_1_10007(iter_2_1, function(arg_3_0)
			setText = var_2_10001

			local var_3_0 = arg_3_0
			local var_3_1 = arg_3_0.Find(var_3_0, "name")

			IslandSeasonReview = var_3_0

			local var_3_2 = var_3_0.KEY2NAME

			tonumber = var_4

			var_2_10001(var_3_1, var_3_2[var_4(arg_3_0.name)])

			return
		end)
	end

	return
end

function var_0_1.OnInit(arg_4_0)
	IslandSeasonAgency = var_1_10001
	arg_4_0.newestId = var_1_10001.GetCurrentSeason() - 1
	PowerRank = var_1
	arg_4_0.rankType = var_1.TYPE_ISLAND_SEASON_PT
	arg_4_0.playerRankVOs = {}

	return
end

function var_0_1.Show(arg_5_0)
	arg_5_0.super.Show(arg_5_0)
	arg_5_0:Flush(arg_5_0.newestId)

	IslandSeasonRedDotHelper = var_1

	var_1.UpdateEnterReview()

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.emit

	IslandSeasonPage = var_3

	local var_5_2 = var_3.UPDATE_REDDOT

	IslandSeasonPage = var_1_10004

	var_5_1(var_5_0, var_5_2, var_1_10004.PAGE_REVIEW)

	return
end

function var_0_1.Hide(arg_6_0)
	var_0_1.super.Hide(arg_6_0)

	local var_6_0 = arg_6_0.switchPanel

	var_1.ExecuteAction(var_6_0, "Hide")

	return
end

function var_0_1.Flush(arg_7_0, arg_7_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_7_0 = var_1_10002(var_1_10003)
	local var_7_1 = var_2.GetIsland(var_7_0)
	local var_7_2 = var_2.GetSeasonAgency(var_7_1)
	local var_7_3 = var_2.GetReviewData(var_7_2, arg_7_1)

	setActive = var_7_2

	var_7_2(arg_7_0.emptyTF, not var_7_3)

	setActive = var_7_2

	var_7_2(arg_7_0.infoPanel, var_7_3)

	if var_7_3 then
		ipairs = var_7_2

		for iter_7_0, iter_7_1 in var_7_2(arg_7_0.infoTFs) do
			eachChild = var_1_10008

			var_1_10008(iter_7_1, function(arg_8_0)
				setText = var_2_10001

				local var_8_0 = arg_8_0:Find("value")
				local var_8_1 = var_7_3
				local var_8_2 = var_3.GetRecordData

				tonumber = var_2_10005

				var_2_10001(var_8_0, var_8_2(var_8_1, var_2_10005(arg_8_0.name)))

				return
			end)
		end
	end

	arg_7_0.seasonId = arg_7_1

	if arg_7_0.playerRankVOs[arg_7_1] then
		getProxy = var_4
		BillboardProxy = var_5

		local var_7_4 = var_4(var_5)

		if var_4.canFetch(var_7_4, arg_7_0.rankType, arg_7_0.seasonId) then
			local var_7_5 = arg_7_0
			local var_7_6 = arg_7_0.emit

			IslandMediator = iter_7_0

			var_7_6(var_7_5, iter_7_0.ON_GET_SEASON_RANK, arg_7_0.rankType, arg_7_0.seasonId)
		else
			arg_7_0:UpdataIcon()
		end

		local var_7_7 = arg_7_0.switchPanel

		var_4.ExecuteAction(var_7_7, "Show", arg_7_1, function(arg_9_0)
			local var_9_0 = arg_7_0

			var_1.Flush(var_9_0, arg_9_0)

			return
		end)

		local var_7_8 = arg_7_0.titleImg

		GetSpriteFromAtlas = var_7_7
		var_7_8.sprite = var_7_7("ui/IslandSeasonTheme" .. arg_7_1 .. "_atlas", "title")

		local var_7_9 = arg_7_0.seasonNumImg

		GetSpriteFromAtlas = var_5
		var_7_9.sprite = var_5("ui/IslandSeasonTheme" .. arg_7_1 .. "_atlas", "num")

		return
	end
end

function var_0_1.UpdateRankVOs(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.playerRankVOs[arg_10_1] = arg_10_3

	return
end

function var_0_1.UpdataIcon(arg_11_0)
	if arg_11_0.playerRankVOs[arg_11_0.seasonId] then
		-- block empty
	end

	return
end

function var_0_1.OnDestroy(arg_12_0)
	if arg_12_0.switchPanel then
		local var_12_0 = arg_12_0.switchPanel

		var_1.Destroy(var_12_0)

		arg_12_0.switchPanel = nil
	end

	return
end

return var_0_1

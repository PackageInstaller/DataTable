local var_0_0 = class("IslandSeasonReviewPanel", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandSeasonReviewPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf:Find("content")

	arg_2_0.leftPanel = var_2_0:Find("left")
	arg_2_0.titleImg = arg_2_0._tf:Find("content/left/Image"):GetComponent(typeof(Image))
	arg_2_0.seasonNumImg = arg_2_0._tf:Find("content/left/num"):GetComponent(typeof(Image))
	arg_2_0.infoPanel = var_2_0:Find("infos")
	arg_2_0.emptyTF = var_2_0:Find("empty")

	setText(arg_2_0.emptyTF:Find("Text"), i18n("island_season_review_miss"))
	setText(arg_2_0.infoPanel:Find("season/title/Text"), i18n("island_season_title"))
	setText(arg_2_0.infoPanel:Find("prod/title/Text"), i18n("island_season_review_produce"))
	setText(arg_2_0.infoPanel:Find("relax/title/Text"), i18n("island_season_review_relax"))

	arg_2_0.switchPanel = IslandSeasonSwitchPanel.New(arg_2_0._tf)
	arg_2_0.iconTF = arg_2_0.infoPanel:Find("island/icon_mask/icon")
	arg_2_0.infoTFs = {
		arg_2_0.infoPanel:Find("island/list"),
		arg_2_0.infoPanel:Find("season/list"),
		arg_2_0.infoPanel:Find("prod/list"),
		arg_2_0.infoPanel:Find("relax/list")
	}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.infoTFs) do
		eachChild(iter_2_1, function(arg_3_0)
			setText(arg_3_0:Find("name"), IslandSeasonReview.KEY2NAME[tonumber(arg_3_0.name)])

			return
		end)
	end

	return
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.newestId = IslandSeasonAgency.GetCurrentSeason() - 1
	arg_4_0.rankType = PowerRank.TYPE_ISLAND_SEASON_PT
	arg_4_0.playerRankVOs = {}

	return
end

function var_0_0.Show(arg_5_0)
	arg_5_0.super.Show(arg_5_0)
	arg_5_0:Flush(arg_5_0.newestId)
	IslandSeasonRedDotHelper.UpdateEnterReview()
	arg_5_0:emit(IslandSeasonPage.UPDATE_REDDOT, IslandSeasonPage.PAGE_REVIEW)

	return
end

function var_0_0.Hide(arg_6_0)
	var_0_0.super.Hide(arg_6_0)
	arg_6_0.switchPanel:ExecuteAction("Hide")

	return
end

function var_0_0.Flush(arg_7_0, arg_7_1)
	local var_7_0 = getProxy(IslandProxy):GetIsland():GetSeasonAgency():GetReviewData(arg_7_1)

	setActive(arg_7_0.emptyTF, not var_7_0)
	setActive(arg_7_0.infoPanel, var_7_0)

	if var_7_0 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0.infoTFs) do
			eachChild(iter_7_1, function(arg_8_0)
				setText(arg_8_0:Find("value"), var_7_0:GetRecordData(tonumber(arg_8_0.name)))

				return
			end)
		end
	end

	arg_7_0.seasonId = arg_7_1

	if arg_7_0.playerRankVOs[arg_7_1] then
		if getProxy(BillboardProxy):canFetch(arg_7_0.rankType, arg_7_0.seasonId) then
			arg_7_0:emit(IslandMediator.ON_GET_SEASON_RANK, arg_7_0.rankType, arg_7_0.seasonId)
		else
			arg_7_0:UpdataIcon()
		end

		arg_7_0.switchPanel:ExecuteAction("Show", arg_7_1, function(arg_9_0)
			arg_7_0:Flush(arg_9_0)

			return
		end)

		arg_7_0.titleImg.sprite = GetSpriteFromAtlas("ui/IslandSeasonTheme" .. arg_7_1 .. "_atlas", "title")
		arg_7_0.seasonNumImg.sprite = GetSpriteFromAtlas("ui/IslandSeasonTheme" .. arg_7_1 .. "_atlas", "num")

		return
	end
end

function var_0_0.UpdateRankVOs(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.playerRankVOs[arg_10_1] = arg_10_3

	return
end

function var_0_0.UpdataIcon(arg_11_0)
	if arg_11_0.playerRankVOs[arg_11_0.seasonId] then
		-- block empty
	end

	return
end

function var_0_0.OnDestroy(arg_12_0)
	if arg_12_0.switchPanel then
		arg_12_0.switchPanel:Destroy()

		arg_12_0.switchPanel = nil
	end

	return
end

return var_0_0

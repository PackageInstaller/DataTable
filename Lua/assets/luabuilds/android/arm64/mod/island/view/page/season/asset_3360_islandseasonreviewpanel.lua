local IslandSeasonReviewPanel = class("IslandSeasonReviewPanel", import("view.base.BaseSubView"))

function IslandSeasonReviewPanel:getUIName()
	return "IslandSeasonReviewPanel"
end

function IslandSeasonReviewPanel:OnLoaded()
	local var_2_0 = self._tf:Find("content")

	self.leftPanel = var_2_0:Find("left")
	self.titleImg = self._tf:Find("content/left/Image"):GetComponent(typeof(Image))
	self.seasonNumImg = self._tf:Find("content/left/num"):GetComponent(typeof(Image))
	self.infoPanel = var_2_0:Find("infos")
	self.emptyTF = var_2_0:Find("empty")

	setText(self.emptyTF:Find("Text"), i18n("island_season_review_miss"))
	setText(self.infoPanel:Find("season/title/Text"), i18n("island_season_title"))
	setText(self.infoPanel:Find("prod/title/Text"), i18n("island_season_review_produce"))
	setText(self.infoPanel:Find("relax/title/Text"), i18n("island_season_review_relax"))

	self.switchPanel = IslandSeasonSwitchPanel.New(self._tf)
	self.iconTF = self.infoPanel:Find("island/icon_mask/icon")
	self.infoTFs = {
		self.infoPanel:Find("island/list"),
		self.infoPanel:Find("season/list"),
		self.infoPanel:Find("prod/list"),
		self.infoPanel:Find("relax/list")
	}

	for iter_2_0, iter_2_1 in ipairs(self.infoTFs) do
		eachChild(iter_2_1, function(arg_3_0)
			setText(arg_3_0:Find("name"), IslandSeasonReview.KEY2NAME[tonumber(arg_3_0.name)])

			return
		end)
	end

	return
end

function IslandSeasonReviewPanel:OnInit()
	self.newestId = IslandSeasonAgency.GetCurrentSeason() - 1
	self.rankType = PowerRank.TYPE_ISLAND_SEASON_PT
	self.playerRankVOs = {}

	return
end

function IslandSeasonReviewPanel:Show()
	self.super.Show(self)
	self:Flush(self.newestId)
	IslandSeasonRedDotHelper.UpdateEnterReview()
	self:emit(IslandSeasonPage.UPDATE_REDDOT, IslandSeasonPage.PAGE_REVIEW)

	return
end

function IslandSeasonReviewPanel:Hide()
	IslandSeasonReviewPanel.super.Hide(self)
	self.switchPanel:ExecuteAction("Hide")

	return
end

function IslandSeasonReviewPanel:Flush(arg_7_1)
	local var_7_0 = getProxy(IslandProxy):GetIsland():GetSeasonAgency():GetReviewData(arg_7_1)

	setActive(self.emptyTF, not var_7_0)
	setActive(self.infoPanel, var_7_0)

	if var_7_0 then
		for iter_7_0, iter_7_1 in ipairs(self.infoTFs) do
			eachChild(iter_7_1, function(arg_8_0)
				setText(arg_8_0:Find("value"), var_7_0:GetRecordData(tonumber(arg_8_0.name)))

				return
			end)
		end
	end

	self.seasonId = arg_7_1

	if self.playerRankVOs[arg_7_1] then
		if getProxy(BillboardProxy):canFetch(self.rankType, self.seasonId) then
			self:emit(IslandMediator.ON_GET_SEASON_RANK, self.rankType, self.seasonId)

			goto label_7_0
		end
	end

	self:UpdataIcon()

	::label_7_0::

	self.switchPanel:ExecuteAction("Show", arg_7_1, function(arg_9_0)
		self:Flush(arg_9_0)

		return
	end)

	self.titleImg.sprite = GetSpriteFromAtlas("ui/IslandSeasonTheme" .. arg_7_1 .. "_atlas", "title")
	self.seasonNumImg.sprite = GetSpriteFromAtlas("ui/IslandSeasonTheme" .. arg_7_1 .. "_atlas", "num")

	return
end

function IslandSeasonReviewPanel:UpdateRankVOs(arg_10_1, arg_10_2, arg_10_3)
	self.playerRankVOs[arg_10_1] = arg_10_3

	return
end

function IslandSeasonReviewPanel:UpdataIcon()
	if self.playerRankVOs[self.seasonId] then
		-- block empty
	end

	return
end

function IslandSeasonReviewPanel:OnDestroy()
	if self.switchPanel then
		self.switchPanel:Destroy()

		self.switchPanel = nil
	end

	return
end

return IslandSeasonReviewPanel

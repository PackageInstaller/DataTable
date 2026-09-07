local IslandSeasonAgency = class("IslandSeasonAgency", import(".IslandBaseAgency"))

IslandSeasonAgency.ADD_PT = "IslandSeasonAgency.ADD_PT"

function IslandSeasonAgency:OnInit(arg_1_1)
	self.season = IslandSeason.New(arg_1_1.season)
	self.reviews = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.season_review_list or {}) do
		self.reviews[iter_1_1.id] = IslandSeasonReview.New(iter_1_1)
	end

	return
end

function IslandSeasonAgency:NeedReset()
	return self.season.id < IslandSeasonAgency.GetCurrentSeason() and self.season:IsEnd()
end

function IslandSeasonAgency:Reset(arg_3_1)
	self.season = IslandSeason.New({
		id = IslandSeasonAgency.GetCurrentSeason()
	})

	if arg_3_1 then
		self.reviews[arg_3_1.id] = arg_3_1
	end

	return
end

function IslandSeasonAgency:IsShowResetTip()
	return self.season:NeedTip()
end

function IslandSeasonAgency:SetResetTipFlag(arg_5_1)
	self.season:SetTipFlag(arg_5_1)

	return
end

function IslandSeasonAgency:GetSeason()
	return self.season
end

function IslandSeasonAgency:AddPt(arg_7_1)
	self.season:AddPt(arg_7_1)
	self:DispatchEvent(IslandSeasonAgency.ADD_PT)

	return
end

function IslandSeasonAgency:GetReviewData(arg_8_1)
	return self.reviews[arg_8_1]
end

function IslandSeasonAgency:GetHighestRank()
	local var_9_0 = math.huge

	for iter_9_0, iter_9_1 in pairs(self.reviews) do
		local var_9_1 = iter_9_1:GetRecordData(IslandSeasonReview.KEYS.PT_RANK)

		if var_9_1 < var_9_0 then
			var_9_0 = var_9_1
		end
	end

	return var_9_0
end

function IslandSeasonAgency:GetSeasonNum()
	return #underscore.keys(self.reviews) + (self.season:GetPt() > 0 and 1 or 0)
end

function IslandSeasonAgency:IsCurSeasonPtZero()
	return self.season:GetPt() == 0
end

function IslandSeasonAgency.GetCurrentSeason()
	return pg.island_set.season_now.key_value_int
end

IslandSeasonAgency.seasonResetData = nil

function IslandSeasonAgency:AddResetData()
	IslandSeasonAgency.seasonResetData = {
		awards = self.awards,
		pt = self.pt,
		seasonId = self.seasonId,
		rank = self.rank
	}

	return
end

function IslandSeasonAgency.CheckReset()
	if IslandSeasonAgency.seasonResetData then
		IslandSeasonAgency.seasonResetData = nil

		return true, (Clone(IslandSeasonAgency.seasonResetData))
	else
		return false, nil
	end

	return
end

return IslandSeasonAgency

NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local BattleResultSkuldView = class("BattleResultSkuldView", NewBattleSettlementView)

function BattleResultSkuldView:UIName()
	return "Widget/System/Activity_Skuld/Activity_Skuld_ResultWinUI"
end

function BattleResultSkuldView:OnEnter()
	BattleResultSkuldView.super.OnEnter(self)

	if self.params_.skuldIconNum == 0 then
		SetActive(self.trustGo_, false)
	else
		SetActive(self.trustGo_, true)
	end

	self.frontSkuldIconText_.text = SkuldSystemData:GetCacheSkuldIconNum()
	self.curSkuldIconText_.text = SkuldSystemData:GetCacheSkuldIconNum() + self.params_.skuldIconNum

	if SkuldSystemData:GetLevelIDIsClear(self.params_.levelID) then
		SetActive(self.contentContainer_.gameObject, false)
	else
		SetActive(self.contentContainer_.gameObject, true)
		SetActive(self.missionView.conditionGo_, false)
	end

	SkuldSystemData:UpdateSkuldStageArchiveRed()
end

function BattleResultSkuldView:NeedOnceMore()
	if SkuldStageCfg[self.params_.levelID].ending == 1 then
		return true, GetTips("ACTIVITY_HERO_ENHANCE_BUTTON_CONTINUE")
	else
		return false
	end
end

function BattleResultSkuldView:OnAddListner()
	self:AddBtnListener(self.nextStageBtn_, nil, function()
		local var_5_1 = table.indexof(SkuldStageCfg.all, self.params_.levelID)

		if var_5_1 > 0 and var_5_1 ~= #SkuldStageCfg.all then
			if SkuldSystemData:GetLevelIDIsOpen(SkuldStageCfg.all[var_5_1 + 1]) then
				self.params_.stageData:SetStartNext()
				BattleInstance.QuitBattle(self.params_.stageData)
			else
				ShowTips("ACTIVITY_ZUMA_OPEN_FRONT")
			end
		end
	end)
end

function BattleResultSkuldView:RefreshBottomBtn()
	SetActive(self.nextStageBtn_, not (table.indexof({
		1008,
		1019,
		1026,
		1030,
		2006
	}, self.params_.levelID) ~= false))
end

return BattleResultSkuldView

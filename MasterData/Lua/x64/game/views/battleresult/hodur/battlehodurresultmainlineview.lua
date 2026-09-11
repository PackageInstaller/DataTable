local BattleHodurResultMainlineView = class("BattleHodurResultMainlineView", NewBattleSettlementView)

function BattleHodurResultMainlineView:UIName()
	return "Widget/System/Activity_Hodur/BattleResultWinUI_Hodur_Mainline"
end

function BattleHodurResultMainlineView:RenderView()
	self:RenderTitleView()
	self:RefreshMyExpS()
	self:RefreshHeroS()
	self:RenderCommonUI()
	self:RefreshBattleTime()
	self:RefreshBottomBtn()
	self:RenderChapterInfo()
end

function BattleHodurResultMainlineView:RenderChapterInfo()
	local var_3_0, var_3_1 = HodurTools.GetChapterProgress(self.params_.chapterID)

	self.chapterText_.text = string.format("%d/%d", var_3_0, var_3_1)
end

function BattleHodurResultMainlineView:RefreshHeroS()
	local var_4_0, var_4_1 = self.stageData:GetHeroTeam()
	local var_4_2 = self.stageData:GetSystemHeroTeam()

	if var_4_0[2] == 0 then
		table.remove(var_4_0, 2)
		table.remove(var_4_1, 2)
		table.insert(var_4_0, 0)
		table.insert(var_4_1, 0)
	end

	local var_4_3 = self.params_.battleResult.heroDataCollect

	for iter_4_0 = 1, 3 do
		if not var_4_0[iter_4_0] or var_4_0[iter_4_0] == 0 then
			self.heroModule[iter_4_0]:SetHeroData(nil)
			self.heroModule[iter_4_0]:ShowCaptain(false)
		else
			self.heroModule[iter_4_0]:ShowCaptain(iter_4_0 == 1)

			local var_4_4 = self.stageData:GetHeroDataByPos(iter_4_0)
			local var_4_5 = {
				id = var_4_4.id,
				using_skin = var_4_4.using_skin
			}

			var_4_5.star = var_4_4.star or 0

			self.heroModule[iter_4_0]:SetHeroData(var_4_5)

			if var_4_3[iter_4_0] and self:NeedAddExp() then
				self.heroModule[iter_4_0]:PlayLevelUpTween(var_4_3[iter_4_0].oldLv, var_4_3[iter_4_0].newLv, var_4_3[iter_4_0].oldPersent, var_4_3[iter_4_0].newPersent, 2)
			else
				self.heroModule[iter_4_0]:ShowLevel(var_4_4.level, 1)
			end

			local var_4_7, var_4_8 = HodurTools.GetChapterHeroHP(self.params_.chapterID, (var_4_4.tempID == 0 or nil) and var_4_4.id)

			self.heroModule[iter_4_0].hpNum_.text = var_4_7 == 0 and string.format("%s%%", 0) or string.format("%s%%", math.max(1, math.floor(var_4_7 / var_4_8 * 100)))
			self.heroModule[iter_4_0].hpImg_.fillAmount = var_4_7 / var_4_8
		end
	end
end

function BattleHodurResultMainlineView:OnAddListner()
	self:AddBtnListener(self.confirmBtn_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.restartBtn_, nil, function()
		BattleInstance.OnceMoreBattle(self.stageData)
	end)
end

return BattleHodurResultMainlineView

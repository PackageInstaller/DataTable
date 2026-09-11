local NewBattleStatisticsView = class("NewBattleStatisticsView", ReduxView)

function NewBattleStatisticsView:UIName()
	return "Widget/System/BattleResult/Common/BattleResultStatisticsUI"
end

function NewBattleStatisticsView:UIParent()
	return manager.ui.uiPop.transform
end

function NewBattleStatisticsView:Init()
	self:InitUI()

	self.adaptComp = self:FindCom("AdaptImage", nil, self.commonBgMask_.transform)

	self:AddListeners()
end

function NewBattleStatisticsView:OnEnter()
	SetActive(self.shareBtn_.gameObject, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))

	self.stageData = self.params_.stageData
	self.hasSnapshot_ = self.params_.hasSnapshot_
	self.statisticsHeroItem_ = {}

	local var_4_0, var_4_1, var_4_2 = BattleTools.GetBattleStatisticsData()
	local var_4_3 = LuaExchangeHelper.GetBattleStatisticsData()
	local var_4_4

	if var_4_3 then
		var_4_4 = var_4_3.dataForLua.currentHPHero or {}
	end

	local var_4_5 = self.stageData:GetHeroTeam()
	local var_4_6 = 0

	for iter_4_0, iter_4_1 in ipairs(var_4_5) do
		if iter_4_1 ~= 0 then
			var_4_6 = var_4_6 + 1
		end
	end

	local var_4_7 = var_4_4.Count or 0

	if var_4_7 ~= var_4_6 then
		for iter_4_2 = 1, 3 do
			if iter_4_2 <= var_4_7 then
				self.heroModule[iter_4_2]:SetHeroData(iter_4_2, (self.stageData:GetHeroDataByPos((table.indexof(var_4_5, var_4_4[iter_4_2 - 1])))))
				self.heroModule[iter_4_2]:SetStatisticsData(var_4_1, var_4_2, var_4_0[iter_4_2])
			else
				self.heroModule[iter_4_2]:SetHeroData(iter_4_2, nil)
			end
		end
	else
		for iter_4_3 = 1, 3 do
			self.heroModule[iter_4_3]:SetHeroData(iter_4_3, (self.stageData:GetHeroDataByPos(iter_4_3)))
			self.heroModule[iter_4_3]:SetStatisticsData(var_4_1, var_4_2, var_4_0[iter_4_3])
		end
	end

	self:SetLevelTitle()
	self:RefreshTimeText()
	self:RenderMaskBg()

	if self.params_.battleResult ~= nil and self.params_.battleResult.errorCode ~= nil and self.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				self:CloseFunc()
			end
		})
	end
end

function NewBattleStatisticsView:CloseFunc()
	BattleInstance.QuitBattle(self.stageData)
end

function NewBattleStatisticsView:OnExit()
	return
end

function NewBattleStatisticsView:Dispose()
	for iter_8_0 = 1, 3 do
		self.heroModule[iter_8_0]:Dispose()
	end

	self:RemoveAllListeners()
	NewBattleStatisticsView.super.Dispose(self)
end

function NewBattleStatisticsView:InitUI()
	self:BindCfgUI()

	self.heroModule = {
		NewBattleStatisticsHeroItem.New(self.hero1Obj_),
		NewBattleStatisticsHeroItem.New(self.hero2Obj_),
		(NewBattleStatisticsHeroItem.New(self.hero3Obj_))
	}
end

function NewBattleStatisticsView:SetLevelTitle(arg_10_1)
	local var_10_0 = self.stageData:GetStageId()
	local var_10_1 = self.stageData:GetType()
	local var_10_2 = BattleStageTools.GetStageName(var_10_1, var_10_0)
	local var_10_3, var_10_4 = BattleStageTools.GetChapterSectionIndex(var_10_1, var_10_0)

	self.titleTxt_.text = var_10_3 ~= "" and string.format("%s-%s ", GetI18NText(var_10_3), GetI18NText(var_10_4)) .. var_10_2 or var_10_2
end

function NewBattleStatisticsView:RefreshTimeText()
	SetActive(self.timeTxt_.gameObject, self.params_.battleTime ~= nil)

	if not self.params_.battleTime then
		return
	end

	local var_11_0 = self.timeTxt_
	local var_11_1 = {
		GetTips("BATTLE_TOTAL_TIME"),
		": "
	}

	var_11_1[3] = self.params_.battleTime or "00"
	var_11_0.text = table.concat(var_11_1)
end

function NewBattleStatisticsView:RenderMaskBg()
	if not self.hasSnapshot_ then
		self.commonBgMask_.sprite = pureGetSpriteWithoutAtlas("TextureBg/BattleResult/battleResult_bg_common")

		self.adaptComp:AdaptImg()
		SetActive(self.commonBgMask_.gameObject, true)
		SetActive(self.bgMask_.gameObject, false)
	else
		self.bgMask_.texture = self.hasSnapshot_

		SetActive(self.commonBgMask_.gameObject, false)
		SetActive(self.bgMask_.gameObject, true)
	end
end

function NewBattleStatisticsView:AddListeners()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.shareBtn_, nil, function()
		manager.share:Share(function()
			SetActive(self.shareBtn_.gameObject, false)
			SetActive(self.backBtn_.gameObject, false)
		end, function()
			SetActive(self.shareBtn_.gameObject, true)
			SetActive(self.backBtn_.gameObject, true)
		end)
	end)
end

return NewBattleStatisticsView

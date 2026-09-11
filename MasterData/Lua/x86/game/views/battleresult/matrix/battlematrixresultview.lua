local BattleMatrixResultView = class("BattleMatrixResultView", ReduxView)

function BattleMatrixResultView:UIName()
	return "Widget/System/MatrixlUI/BattleVariableUI"
end

function BattleMatrixResultView:UIParent()
	return manager.ui.uiMain.transform
end

function BattleMatrixResultView:Init()
	self:InitUI()
	self:AddListener()

	self.affixList = LuaList.New(handler(self, self.IndexAffixItem), self.affixListGo_, BattleMatrixAffixItem)
end

function BattleMatrixResultView:OnEnter()
	BattleInstance.hideBattlePanel()

	self.stageData = self.params_.stageData

	self:RefreshUI()

	if self.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
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

function BattleMatrixResultView:NeedOnceMore()
	return false
end

function BattleMatrixResultView:OnTop()
	SetActive(self.gameObject_, true)

	self.toStat_ = false
end

function BattleMatrixResultView:OnBehind()
	if self.toStat_ then
		SetActive(self.gameObject_, false)
	end
end

function BattleMatrixResultView:OnExit()
	return
end

function BattleMatrixResultView:Dispose()
	for iter_10_0, iter_10_1 in ipairs(self.rewardItems_) do
		iter_10_1:Dispose()
	end

	self.rewardItems_ = nil

	self.affixList:Dispose()

	for iter_10_2, iter_10_3 in ipairs(self.rewardItemGos_) do
		Object.Destroy(iter_10_3)
	end

	self.rewardItemGos_ = nil
	self.heroGo_ = nil
	self.heroImg_ = nil
	self.hpText_ = nil
	self.rewardList_ = nil
	self.stareText_ = nil
	self.lvText_ = nil
	self.mask_ = nil
	self.btnBack_ = nil
	self.btnBattleCount_ = nil

	BattleMatrixResultView.super.Dispose(self)
end

function BattleMatrixResultView:InitUI()
	self:BindCfgUI()

	self.itemPrefeb = Asset.Load("UI/Common/CommonItem")
	self.rewardItems_ = {}
	self.rewardItemGos_ = {}
	self.heroGo_ = {}
	self.heroImg_ = {}
	self.hpText_ = {}

	for iter_11_0 = 1, 3 do
		self.heroGo_[iter_11_0] = self["hero" .. iter_11_0]
		self.heroImg_[iter_11_0] = self["heroMaskIcon" .. iter_11_0]
		self.hpText_[iter_11_0] = self[string.format("hpText%s_", iter_11_0)]
	end

	LeanTween.alphaCanvas(self.mask_, 0, 0.1):setOnComplete(LuaHelper.VoidAction(function()
		self.mask_.blocksRaycasts = false
	end))
end

function BattleMatrixResultView:GetRewardData()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(self.params_.rewardList) do
		table.insert(var_13_0, iter_13_1)
	end

	return var_13_0
end

function BattleMatrixResultView:ShowVitalityBox(arg_14_1)
	if needShowVitalityFullBox(self:GetRewardData()) then
		showVitalitySendMail(arg_14_1)
	else
		arg_14_1()
	end
end

function BattleMatrixResultView:ShowEquipBox(arg_15_1)
	if needShowBagFullBox(self:GetRewardData()) then
		showEquipSendMail(arg_15_1)
	else
		arg_15_1()
	end
end

function BattleMatrixResultView:AddListener()
	self:AddBtnListener(self.btnBack_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.btnBattleCount_, nil, function()
		self.toStat_ = true

		JumpTools.OpenPageByJump("battleStatisticsMatrix", {
			stageData = self.stageData,
			battleTime = self:GetBattleTime()
		})
	end)
end

function BattleMatrixResultView:CloseFunc()
	self:ShowVitalityBox(function()
		self:ShowEquipBox(function()
			BattleInstance.QuitBattle(self.stageData)
		end)
	end)
end

function BattleMatrixResultView:RemoveListener()
	self.btnBack_.onClick:RemoveAllListeners()
	self.btnBattleCount_.onClick:RemoveAllListeners()
end

function BattleMatrixResultView:RefreshUI()
	self:SetLevelTitle()
	self:RefreshRewardItemS()
	self:RefreshHeroS()
	self:RefreshBattleTime()
end

function BattleMatrixResultView:SetLevelTitle()
	local var_24_0 = MatrixTierCfg[MatrixData:GetTierID()]

	self.stareText_.text = string.format("%s-%s", var_24_0.tier, var_24_0.level)
	self.lvText_.text = GetI18NText(BattleMatrixStageCfg[self.stageData:GetStageId()].name)

	local var_24_1 = MatrixData:GetDifficulty()

	self.difficultText_.text = string.format("<color=#%s>(%s)</color>", MatrixConst.DIFFICULTY_COLOR[var_24_1], GetTips(BattleConst.HARD_LANGUAGE[var_24_1]))
	self.timeText_.text = manager.time:DescCTime(BattleFieldData:GetBattleResultData().useSecond, "%M:%S")
	self.affixData = MatrixData:GetAffixList()

	self.affixList:StartScroll(math.max(#self.affixData, 3))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.titleTransform_)
end

function BattleMatrixResultView:RefreshRewardItemS()
	local var_25_0 = {}

	if self.params_.rewardList then
		for iter_25_0, iter_25_1 in pairs(self.params_.rewardList) do
			table.insert(var_25_0, iter_25_1)
		end

		var_25_0 = formatRewardCfgList(var_25_0)
		var_25_0 = mergeReward(var_25_0)
		var_25_0 = sortReward(var_25_0)
	end

	for iter_25_2 = 1, #var_25_0 do
		if not self.rewardItems_[iter_25_2] then
			local var_25_1 = Object.Instantiate(self.itemPrefeb, self.rewardList_)

			self.rewardItems_[iter_25_2] = CommonItem.New(var_25_1)

			self.rewardItems_[iter_25_2]:RegistCallBack(function(arg_26_0)
				ShowPopItem(POP_ITEM, {
					arg_26_0.id,
					arg_26_0.number
				})
			end)

			self.rewardItemGos_[iter_25_2] = var_25_1

			self.rewardItems_[iter_25_2]:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
		end

		self.rewardItems_[iter_25_2]:RefreshData(var_25_0[iter_25_2])
		self.rewardItems_[iter_25_2]:SetBottomText("<color=#%s>" .. var_25_0[iter_25_2].num .. "</color>")
	end
end

function BattleMatrixResultView:RefreshHeroS()
	local var_27_0 = self.stageData:GetHeroTeam()

	for iter_27_0 = 1, 3 do
		if not var_27_0[iter_27_0] or var_27_0[iter_27_0] == 0 then
			SetActive(self.heroGo_[iter_27_0], false)
		else
			SetActive(self.heroGo_[iter_27_0], true)

			self.heroImg_[iter_27_0].sprite = getSpriteViaConfig("HeroIcon", SkinCfg[MatrixData:GetHeroSkin(var_27_0[iter_27_0])].picture_id)

			local var_27_1 = MatrixData:GetHeroData(var_27_0[iter_27_0])
			local var_27_2 = var_27_1:GetHeroHP()
			local var_27_3 = var_27_1:GetHeroMaxHP()

			self.hpText_[iter_27_0].text = string.format("<color=#FF9500>%s</color>/%s", var_27_2, var_27_3)
			self[string.format("hpSlider%s_", iter_27_0)].value = var_27_2 / var_27_3
		end
	end
end

function BattleMatrixResultView:RefreshBattleTime()
	self.battleTimeText_.text = self:GetBattleTime()
end

function BattleMatrixResultView:GetBattleTime()
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function BattleMatrixResultView:IndexAffixItem(arg_30_1, arg_30_2)
	arg_30_2:SetData(self.affixData[arg_30_1])
end

return BattleMatrixResultView

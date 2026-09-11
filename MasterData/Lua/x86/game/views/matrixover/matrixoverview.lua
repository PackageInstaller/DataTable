local matrixOverNewView = class("matrixOverNewView", ReduxView)

function matrixOverNewView:UIName()
	return "UI/BattleResult/BattleMatrixOverUI"
end

function matrixOverNewView:UIParent()
	return manager.ui.uiMain.transform
end

function matrixOverNewView:Init()
	self:InitUI()
	self:AddListeners()
end

function matrixOverNewView:InitUI()
	self:BindCfgUI()

	self.heroItemList_ = {}

	for iter_4_0 = 1, 3 do
		self.heroItemList_[iter_4_0] = MatrixOverHeroItem.New(self[string.format("heroItem%s_", iter_4_0)])
	end

	self.affixList_ = LuaList.New(handler(self, self.AffixIndexItem), self.m_affixList, MatrixOverAffixItem)
	self.treasureList_ = LuaList.New(handler(self, self.ArtifactIndexItem), self.m_treasureList, MatrixOverArtifactItem)
	self.beaconList_ = LuaList.New(handler(self, self.BeaconIndexItem), self.m_beaconList, MatrixOverBeaconItem)
	self.resultController_ = ControllerUtil.GetController(self.transform_, "result")
	self.difficultyController_ = ControllerUtil.GetController(self.transform_, "difficulty")
end

function matrixOverNewView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		if self:GetGameState() == MatrixConst.STATE_TYPE.NOTSTARTED then
			self:Go("/matrixBlank/matrixPrepare")
		else
			MatrixAction.QueryMatrixOver(function(arg_7_0)
				if isSuccess(arg_7_0.result) then
					self:Go("/matrixBlank/matrixPrepare")
				end
			end)
		end
	end)
	self:AddBtnListener(self.m_evaluateBtn, nil, function()
		if self:GetGameState() == MatrixConst.STATE_TYPE.SUCCESS then
			self:Go("matrixOverEvaluate")
		end
	end)
	self:AddBtnListener(self.statisticsBtn_, nil, function()
		JumpTools.OpenPageByJump("battleStatisticsMatrixOver")
	end)
end

function matrixOverNewView:OnEnter()
	self:Refresh()
end

function matrixOverNewView:OnExit()
	return
end

function matrixOverNewView:ParseTime(arg_12_1)
	local var_12_0 = math.floor(arg_12_1 / 3600)
	local var_12_1 = math.floor(arg_12_1 % 3600 / 60)
	local var_12_2 = arg_12_1 % 60

	var_12_0 = var_12_0 < 10 and "0" .. var_12_0 or var_12_0
	var_12_1 = var_12_1 < 10 and "0" .. var_12_1 or var_12_1
	var_12_2 = var_12_2 < 10 and "0" .. var_12_2 or var_12_2

	return var_12_0 .. ":" .. var_12_1 .. ":" .. var_12_2
end

function matrixOverNewView:Refresh()
	if self:GetGameState() == MatrixConst.STATE_TYPE.SUCCESS then
		self.resultController_:SetSelectedIndex(0)

		self.currentTimeText_.text = self:ParseTime(self:GetCurrentClearTime())
		self.bestTimeText_.text = self:ParseTime(self:GetMinClearTime())

		local var_13_0 = self:GetEvaluateList()

		self.stageName_.text = #var_13_0 > 0 and MatrixEvaluateCfg[var_13_0[1]] and GetI18NText(MatrixEvaluateCfg[var_13_0[1]].title) or self:GetTierDes()
	else
		self.resultController_:SetSelectedIndex(1)

		self.stageName_.text = self:GetTierDes()
	end

	self.m_rankScoreText.text = self:GetMatrixOverScore()

	if self:GetDifficulty() == 1 then
		self.difficultyController_:SetSelectedIndex(0)
	else
		self.difficultyController_:SetSelectedIndex(1)

		self.regularData = self:GetRegularAffix()
		self.customData = self:GetCustomAffix()

		local var_13_1 = 0

		for iter_13_0, iter_13_1 in ipairs(self.regularData) do
			var_13_1 = var_13_1 + ActivityAffixPoolCfg[iter_13_1].point
		end

		for iter_13_2, iter_13_3 in ipairs(self.customData) do
			var_13_1 = var_13_1 + ActivityAffixPoolCfg[iter_13_3].point
		end

		self.m_difficultyScore.text = "" .. var_13_1
	end

	local var_13_3 = self:GetMatrixHeroTeam()

	for iter_13_4 = 1, 3 do
		if var_13_3[iter_13_4] and var_13_3[iter_13_4] ~= 0 then
			self.heroItemList_[iter_13_4]:Refresh(var_13_3[iter_13_4])
			self.heroItemList_[iter_13_4]:SetActive(true)
		else
			self.heroItemList_[iter_13_4]:SetActive(false)
		end
	end

	self.affixData = self:GetAffixList()

	self.affixList_:StartScroll(#self.affixData)

	self.artifactData = self:GetArtifactList()

	table.sort(self.artifactData, function(arg_14_0, arg_14_1)
		if MatrixItemCfg[arg_14_0.id].rare ~= MatrixItemCfg[arg_14_1.id].rare then
			return MatrixItemCfg[arg_14_0.id].rare > MatrixItemCfg[arg_14_1.id].rare
		end

		return arg_14_0.id < arg_14_1.id
	end)
	self.treasureList_:StartScroll(#self.artifactData)

	self.beaconData = self:GetUseBeaconList()

	self.beaconList_:StartScroll(#self.beaconData)

	self.scoreText_.text = self:GetMatrixCurrencyList()[CurrencyConst.CURRENCY_TYPE_MATRIX_PT] or 0
end

function matrixOverNewView:AffixIndexItem(arg_15_1, arg_15_2)
	arg_15_2:Refresh(self.affixData[arg_15_1])
end

function matrixOverNewView:ArtifactIndexItem(arg_16_1, arg_16_2)
	arg_16_2:Refresh(self.artifactData[arg_16_1])
end

function matrixOverNewView:BeaconIndexItem(arg_17_1, arg_17_2)
	arg_17_2:Refresh(self.beaconData[arg_17_1])
end

function matrixOverNewView:Dispose()
	for iter_18_0, iter_18_1 in pairs(self.heroItemList_) do
		iter_18_1:Dispose()
	end

	self.heroItemList_ = nil

	self.affixList_:Dispose()
	self.treasureList_:Dispose()
	self.beaconList_:Dispose()
	matrixOverNewView.super.Dispose(self)
end

function matrixOverNewView:OnMatrixOverUpdate()
	self:Refresh()
end

function matrixOverNewView:GetGameState()
	return MatrixData:GetGameState()
end

function matrixOverNewView:GetCurrentClearTime()
	return MatrixData:GetCurrentClearTime()
end

function matrixOverNewView:GetMinClearTime()
	return MatrixData:GetMinClearTime()
end

function matrixOverNewView:GetEvaluateList()
	return MatrixData:GetEvaluateList()
end

function matrixOverNewView:GetTierDes()
	local var_24_0 = MatrixTierCfg[MatrixData:GetTierID()]

	return string.format("%s-%s", var_24_0.tier, var_24_0.level)
end

function matrixOverNewView:GetAffixList()
	return MatrixData:GetAffixList()
end

function matrixOverNewView:GetArtifactList()
	return MatrixData:GetArtifactList()
end

function matrixOverNewView:GetUseBeaconList()
	return MatrixData:GetUseBeaconList()
end

function matrixOverNewView:GetMatrixCurrencyList()
	return MatrixData:GetMatrixCurrencyList()
end

function matrixOverNewView:GetMatrixHeroTeam()
	return MatrixData:GetMatrixHeroTeam()
end

function matrixOverNewView:GetMatrixOverScore()
	return MatrixData:GetMatrixOverScore()
end

function matrixOverNewView:GetDifficulty()
	return MatrixData:GetDifficulty()
end

function matrixOverNewView:GetRegularAffix()
	return MatrixData:GetDifficultyData():GetRegularAffix()
end

function matrixOverNewView:GetCustomAffix()
	return MatrixData:GetCustomAffix()
end

return matrixOverNewView

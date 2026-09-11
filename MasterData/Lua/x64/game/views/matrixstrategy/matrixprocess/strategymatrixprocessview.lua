local StrategyMatrixProcessView = class("StrategyMatrixProcessView", MatrixProcessView)

function StrategyMatrixProcessView:UIBackCount()
	return 2
end

function StrategyMatrixProcessView:UIName()
	return "Widget/System/MatrixlUI/StrategyMatrixProcessUI"
end

function StrategyMatrixProcessView:InitUI()
	self:BindCfgUI()

	self.rewardList_ = LuaList.New(handler(self, self.indexRewardItem), self.m_rewardList, StrategyMatrixProcessRewardItem)
	self.incidentList_ = LuaList.New(handler(self, self.indexIncidentItem), self.m_incidentList, MatrixProcessIncidentItem)
	self.phaseController_ = ControllerUtil.GetController(self.m_phaseController, "phase")
	self.hasGiveUpRewadController_ = ControllerUtil.GetController(self.m_phaseController, "hasGiveUpRewad")
end

function StrategyMatrixProcessView:AddUIListener()
	self:AddBtnListener(self.m_rewardCommon, nil, function()
		StrategyMatrixAction.QueryNextProgress(self.matrix_activity_id, {})
	end)
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		self:OnRewardAction()
	end)
	self:AddBtnListener(self.m_giveUpBtn, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_MATRIX"),
			OkCallback = function()
				StrategyMatrixAction.QueryMatrixGiveUp(self.matrix_activity_id)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	self:AddBtnListener(self.m_incidentBtn, nil, function()
		local var_10_0

		if self.selectItemIndex == -1 then
			do return end

			var_10_0 = {}
		end

		var_10_0[1] = self.incidentData[self.selectItemIndex]

		StrategyMatrixAction.QueryNextProgress(self.matrix_activity_id, var_10_0)
	end)
	self:AddBtnListener(self.m_infoBtn, nil, function()
		local var_11_0 = StrategyMatrixData:GetMatrixHeroTeam(self.matrix_activity_id)

		JumpTools.OpenPageByJump("/strategyMatrixHero_new", {
			isEnter = true,
			matrix_activity_id = self.matrix_activity_id,
			type = HeroConst.HERO_DATA_TYPE.STRATEGYMATRIX,
			tempHeroList = var_11_0,
			hid = var_11_0[1]
		})
	end)
end

function StrategyMatrixProcessView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(self.matrix_activity_id))
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, self.matrix_activity_id)
end

function StrategyMatrixProcessView:OnEnter()
	manager.ui:SetMainCamera("hero")

	self.matrix_activity_id = self.params_.matrix_activity_id

	StrategyMatrixProcessView.super.OnEnter(self)
end

function StrategyMatrixProcessView:OnExit()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
end

function StrategyMatrixProcessView:Refresh(arg_15_1)
	self.phaseData = self:GetMatrixPhaseData()
	self.phasesParams = clone(self.phaseData:GetParams())
	self.matrixGiveUpItemId = self.phaseData:GetGiveUpItemId()
	self.incidentData = {}
	self.selectItemIndex = -1
	self.m_rewardBtn.interactable = false
	self.m_eventBtn.interactable = false
	self.m_incidentBtn.interactable = false

	local var_15_0 = self.phaseData:GetPhase()

	if var_15_0 == 1 then
		self.phaseController_:SetSelectedIndex(1)
	elseif var_15_0 == 2 then
		if MatrixConst.EVENT_TYPE.INCIDENT == StrategyMatrixEventTemplateCfg[self.phasesParams[1]].event_type then
			local var_15_1 = self.phaseData:GetData()

			self.incidentData = {}

			for iter_15_0, iter_15_1 in ipairs(StrategyMatrixChanceCfg.get_id_list_by_title_id[var_15_1]) do
				table.insert(self.incidentData, StrategyMatrixChanceCfg[iter_15_1].option)
			end

			self.m_incidentTitle.text = MatrixDescCfg[var_15_1] and GetI18NText(MatrixDescCfg[var_15_1].desc) or ""

			self.phaseController_:SetSelectedIndex(3)
			self.incidentList_:StartScroll(#self.incidentData)
		elseif not arg_15_1 then
			self.phaseController_:SetSelectedIndex(0)
		end
	else
		if var_15_0 == 3 then
			if self.matrixGiveUpItemId and self.matrixGiveUpItemId ~= 0 then
				self.hasGiveUpRewadController_:SetSelectedIndex(1)

				if MatrixConst.ITEM_TYPE.ITEM == MatrixItemCfg[self.matrixGiveUpItemId].matrix_item_type and #MatrixItemCfg[self.matrixGiveUpItemId].params > 0 then
					local var_15_3 = MatrixItemCfg[self.matrixGiveUpItemId].params[1][2]

					if MatrixItemCfg[self.matrixGiveUpItemId].params[1][1] == CurrencyConst.CURRENCY_TYPE_MATRIX_COIN then
						var_15_3 = var_15_3 * (1 + self:GetGiveUpRewardAddition())
					end

					self.m_rewardCommonText.text = string.format(GetTips("MATRIX_GET"), var_15_3, GetI18NText(MatrixItemCfg[self.matrixGiveUpItemId].name))
				else
					self.m_rewardCommonText.text = GetI18NText(MatrixItemCfg[self.matrixGiveUpItemId].desc)
				end
			else
				self.hasGiveUpRewadController_:SetSelectedIndex(0)
			end

			self.phaseController_:SetSelectedIndex(2)
			self.rewardList_:StartScroll(#self.phasesParams)
		end

		local var_15_4

		do
			self.phaseController_:SetSelectedIndex(0)

			var_15_4 = self.m_difficultyLab
		end
	end

	var_15_4.text = self:GetDifficulty() == 1 and GetTips("HARDLEVEL_EASY") or GetTips("HARDLEVEL_HARD")
	self.m_tierLab.text = self:GetTierDes()
end

function StrategyMatrixProcessView:OnRewardAction()
	if self.selectItemIndex == -1 then
		return
	end

	local var_16_0 = self.phasesParams[self.selectItemIndex]
	local var_16_1 = self.phasesParams[self.selectItemIndex] and MatrixItemCfg[var_16_0]

	if not (self.phasesParams[self.selectItemIndex] and MatrixItemCfg[var_16_0]) then
		print("MatrixItemCfg cant find item by id :" .. var_16_0)

		return
	end

	local var_16_2 = var_16_1.matrix_item_type

	if MatrixConst.ITEM_TYPE.ASTROLABE == var_16_1.matrix_item_type then
		local var_16_3 = math.floor(var_16_1.params[1] / 1000)
		local var_16_4 = self:GetHeroData(var_16_3)

		if var_16_4:GetAstrolabeNum(var_16_1.params[1]) >= 3 then
			ShowTips("MATRIX_NOT_GET_ASTROLABEL")

			return
		end

		if self:GetAstrolabeMaxCount() <= #var_16_4:GetAstrolabeList() then
			JumpTools.OpenPageByJump("strategyMatrixProcessAstrolabeReplace", {
				heroId = var_16_3,
				astrolabeId = var_16_0,
				callback = function(arg_17_0)
					StrategyMatrixAction.QueryNextProgress(self.matrix_activity_id, {
						var_16_0,
						arg_17_0,
						var_16_4:GetStandardId()
					})
				end
			})
		else
			StrategyMatrixAction.QueryNextProgress(self.matrix_activity_id, {
				var_16_0,
				0,
				var_16_4:GetStandardId()
			})
		end
	elseif MatrixConst.ITEM_TYPE.EQUIP == var_16_2 then
		local var_16_5 = self:GetMatrixHeroTeam()

		if #var_16_5 == 1 then
			local var_16_6 = self:GetHeroData(var_16_5[1])

			if self:GetHeroEquipMaxCount() <= #var_16_6:GetEquipList() then
				JumpTools.OpenPageByJump("strategyMatrixProcessEquipReplace", {
					heroId = var_16_5[1],
					equipId = var_16_0,
					callback = function(arg_18_0)
						StrategyMatrixAction.QueryNextProgress(self.matrix_activity_id, {
							var_16_0,
							arg_18_0,
							var_16_6:GetStandardId()
						})
					end
				})
			else
				StrategyMatrixAction.QueryNextProgress(self.matrix_activity_id, {
					var_16_0,
					0,
					var_16_6:GetStandardId()
				})
			end
		else
			JumpTools.OpenPageByJump("strategyMatrixProcessSelectHero", {
				id = var_16_0
			})
		end
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_16_2 then
		local var_16_7 = MatrixTools.GetWeaponSpecHero(var_16_1.params[1])
		local var_16_8 = self:GetMatrixHeroTeam()

		if var_16_7 == 0 and #var_16_8 == 1 then
			var_16_7 = var_16_8[1]
		end

		if var_16_7 == 0 then
			JumpTools.OpenPageByJump("strategyMatrixProcessSelectHero", {
				id = var_16_0
			})
		else
			local var_16_9 = self:GetHeroData(var_16_7)
			local var_16_10 = var_16_9:GetWeaponServant()

			if var_16_10 ~= 0 then
				JumpTools.OpenPageByJump("strategyMatrixProcessWeaponReplace", {
					heroId = var_16_7,
					weaponId = var_16_0,
					callback = function()
						StrategyMatrixAction.QueryNextProgress(self.matrix_activity_id, {
							var_16_0,
							var_16_10,
							var_16_9:GetStandardId()
						})
					end
				})
			else
				StrategyMatrixAction.QueryNextProgress(self.matrix_activity_id, {
					var_16_0,
					0,
					var_16_9:GetStandardId()
				})
			end
		end
	else
		StrategyMatrixAction.QueryNextProgress(self.matrix_activity_id, {
			var_16_0
		})
	end
end

function StrategyMatrixProcessView:indexRewardItem(arg_20_1, arg_20_2)
	arg_20_2:SetMatrixActivityId(self.matrix_activity_id)
	StrategyMatrixProcessView.super.indexRewardItem(self, arg_20_1, arg_20_2)
end

function StrategyMatrixProcessView:GetGameState()
	return StrategyMatrixData:GetGameState(self.matrix_activity_id)
end

function StrategyMatrixProcessView:GetHeroData(arg_22_1)
	return StrategyMatrixData:GetHeroDataNew(arg_22_1)
end

function StrategyMatrixProcessView:GetAstrolabeMaxCount()
	return StrategyMatrixData:GetAstrolabeMaxCount(self.matrix_activity_id)
end

function StrategyMatrixProcessView:GetMatrixPhaseData()
	return StrategyMatrixData:GetMatrixPhaseData(self.matrix_activity_id)
end

function StrategyMatrixProcessView:GetDifficulty()
	return 1
end

function StrategyMatrixProcessView:GetTierID()
	return StrategyMatrixData:GetTierID(self.matrix_activity_id)
end

function StrategyMatrixProcessView:GetTierDes()
	local var_27_0 = StrategyMatrixTierTemplateCfg[StrategyMatrixData:GetTierID(self.matrix_activity_id)]

	return string.format("%s-%s", var_27_0.tier, var_27_0.level)
end

function StrategyMatrixProcessView:GetMatrixHeroTeam()
	return StrategyMatrixData:GetMatrixHeroTeam(self.matrix_activity_id)
end

function StrategyMatrixProcessView:GetHeroEquipMaxCount()
	return StrategyMatrixData:GetHeroEquipMaxCount(self.matrix_activity_id)
end

function StrategyMatrixProcessView:GetGiveUpRewardAddition()
	return StrategyMatrixData:GetGiveUpRewardAddition(self.matrix_activity_id)
end

return StrategyMatrixProcessView

local MatrixProcessView = class("MatrixProcessView", ReduxView)

function MatrixProcessView:UIBackCount()
	return 3
end

function MatrixProcessView:UIName()
	return "UI/Matrix/Process/MatrixProcessUI"
end

function MatrixProcessView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixProcessView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixProcessView:InitUI()
	self:BindCfgUI()

	self.eventList_ = LuaList.New(handler(self, self.indexEventItem), self.m_eventList, MatrixProcessEventItem)
	self.rewardList_ = LuaList.New(handler(self, self.indexRewardItem), self.m_rewardList, MatrixProcessRewardItem)
	self.incidentList_ = LuaList.New(handler(self, self.indexIncidentItem), self.m_incidentList, MatrixProcessIncidentItem)
	self.phaseController_ = ControllerUtil.GetController(self.m_phaseController, "phase")
	self.hasGiveUpRewadController_ = ControllerUtil.GetController(self.m_phaseController, "hasGiveUpRewad")
end

function MatrixProcessView:AddUIListener()
	self:AddBtnListener(self.m_rewardCommon, nil, function()
		MatrixAction.QueryNextProgress({})
	end)
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		self:OnRewardAction()
	end)
	self:AddBtnListener(self.m_eventBtn, nil, function()
		self:OnEventAction()
	end)
	self:AddBtnListener(self.m_giveUpBtn, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_MATRIX"),
			OkCallback = function()
				MatrixAction.QueryMatrixGiveUp(function(arg_12_0)
					return
				end)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	self:AddBtnListener(self.m_incidentBtn, nil, function()
		local var_14_0

		if self.selectItemIndex == -1 then
			do return end

			var_14_0 = {}
		end

		var_14_0[1] = self.incidentData[self.selectItemIndex]

		MatrixAction.QueryNextProgress(var_14_0)
	end)
end

function MatrixProcessView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = MatrixConst.MATRIX_GAME_HELP_PAGES
		}
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare")
	end)
end

function MatrixProcessView:OnEnter()
	self:Refresh()
end

function MatrixProcessView:Refresh()
	self.phaseData = self:GetMatrixPhaseData()
	self.phasesParams = clone(self.phaseData:GetParams())
	self.matrixGiveUpItemId = self.phaseData:GetGiveUpItemId()
	self.incidentData = {}
	self.selectItemIndex = -1
	self.m_rewardBtn.interactable = false
	self.m_eventBtn.interactable = false
	self.m_incidentBtn.interactable = false

	local var_18_0 = self.phaseData:GetPhase()

	if var_18_0 == 1 then
		self.phaseController_:SetSelectedIndex(1)
		self.eventList_:StartScroll(#self.phasesParams)
	elseif var_18_0 == 2 then
		if MatrixConst.EVENT_TYPE.INCIDENT == MatrixEventCfg[self.phasesParams[1]].event_type then
			local var_18_1 = self.phaseData:GetData()

			self.incidentData = {}

			for iter_18_0, iter_18_1 in ipairs(MatrixChanceCfg.get_id_list_by_title_id[var_18_1]) do
				table.insert(self.incidentData, MatrixChanceCfg[iter_18_1].option)
			end

			self.m_incidentTitle.text = MatrixDescCfg[var_18_1] and GetI18NText(MatrixDescCfg[var_18_1].desc) or ""

			self.phaseController_:SetSelectedIndex(3)
			self.incidentList_:StartScroll(#self.incidentData)
		else
			self.phaseController_:SetSelectedIndex(1)
			self.eventList_:StartScroll(#self.phasesParams)
		end
	elseif var_18_0 == 3 then
		if self.matrixGiveUpItemId and self.matrixGiveUpItemId ~= 0 then
			self.hasGiveUpRewadController_:SetSelectedIndex(1)

			if MatrixConst.ITEM_TYPE.ITEM == MatrixItemCfg[self.matrixGiveUpItemId].matrix_item_type and #MatrixItemCfg[self.matrixGiveUpItemId].params > 0 then
				local var_18_3 = MatrixItemCfg[self.matrixGiveUpItemId].params[1][2]

				if MatrixItemCfg[self.matrixGiveUpItemId].params[1][1] == CurrencyConst.CURRENCY_TYPE_MATRIX_COIN then
					var_18_3 = var_18_3 * (1 + self:GetGiveUpRewardAddition())
				end

				self.m_rewardCommonText.text = string.format(GetTips("MATRIX_GET"), var_18_3, GetI18NText(MatrixItemCfg[self.matrixGiveUpItemId].name))
			else
				self.m_rewardCommonText.text = GetI18NText(MatrixItemCfg[self.matrixGiveUpItemId].desc)
			end
		else
			self.hasGiveUpRewadController_:SetSelectedIndex(0)
		end

		self.phaseController_:SetSelectedIndex(2)
		self.rewardList_:StartScroll(#self.phasesParams)
	else
		self.phaseController_:SetSelectedIndex(0)
	end

	local var_18_4 = self:GetDifficulty()

	self.m_difficultyLab.text = var_18_4 == 1 and GetTips("HARDLEVEL_EASY") or var_18_4 == 3 and GetTips("HARDLEVEL_SINGULARITY") or GetTips("HARDLEVEL_HARD")
	self.m_tierLab.text = self:GetTierDes()
end

function MatrixProcessView:indexEventItem(arg_19_1, arg_19_2)
	arg_19_2:RegistCallBack(handler(self, self.OnEvengtItemClick))
	arg_19_2:Refresh(self.phasesParams[arg_19_1], arg_19_1)
	arg_19_2:SetSelected(arg_19_1 == self.selectItemIndex)
end

function MatrixProcessView:indexRewardItem(arg_20_1, arg_20_2)
	arg_20_2:RegistCallBack(handler(self, self.OnRewardItemClick))
	arg_20_2:Refresh(self.phasesParams[arg_20_1], arg_20_1)
	arg_20_2:SetSelected(arg_20_1 == self.selectItemIndex)
end

function MatrixProcessView:indexIncidentItem(arg_21_1, arg_21_2)
	arg_21_2:RegistCallBack(handler(self, self.OnIncidentItemClick))
	arg_21_2:Refresh(self.incidentData[arg_21_1], arg_21_1)
	arg_21_2:SetSelected(arg_21_1 == self.selectItemIndex)
end

function MatrixProcessView:OnEvengtItemClick(arg_22_1)
	if arg_22_1 == self.selectItemIndex then
		return
	end

	self.selectItemIndex = arg_22_1

	for iter_22_0, iter_22_1 in pairs((self.eventList_:GetItemList())) do
		iter_22_1:SetSelected(iter_22_1:GetIndex() == self.selectItemIndex)
	end

	self.m_eventBtn.interactable = true
end

function MatrixProcessView:OnRewardItemClick(arg_23_1, arg_23_2)
	if arg_23_1 == self.selectItemIndex then
		return
	end

	self.selectItemIndex = arg_23_1

	for iter_23_0, iter_23_1 in pairs((self.rewardList_:GetItemList())) do
		iter_23_1:SetSelected(iter_23_1:GetIndex() == self.selectItemIndex)
	end

	self.m_rewardBtn.interactable = true
end

function MatrixProcessView:OnIncidentItemClick(arg_24_1)
	if arg_24_1 == self.selectItemIndex then
		return
	end

	self.selectItemIndex = arg_24_1

	for iter_24_0, iter_24_1 in pairs((self.incidentList_:GetItemList())) do
		iter_24_1:SetSelected(iter_24_1:GetIndex() == self.selectItemIndex)
	end

	self.m_incidentBtn.interactable = true
end

function MatrixProcessView:OnEventAction()
	if self.selectItemIndex == -1 then
		return
	end

	local var_25_0 = self.phasesParams[self.selectItemIndex]

	if not MatrixEventCfg[self.phasesParams[self.selectItemIndex]] then
		print("MatrixEventCfg cant find event by id :" .. var_25_0)

		return
	end

	if MatrixConst.EVENT_TYPE.SHOP == MatrixEventCfg[self.phasesParams[self.selectItemIndex]].event_type or MatrixConst.EVENT_TYPE.INCIDENT == MatrixEventCfg[self.phasesParams[self.selectItemIndex]].event_type then
		if self:GetMatrixPhaseData():GetPhase() == 2 then
			MatrixAction.DoEvent()
		else
			MatrixAction.QueryNextProgress({
				var_25_0
			})
		end
	else
		local var_25_1 = {
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX
		}

		var_25_1.section = MatrixEventCfg[self.phasesParams[self.selectItemIndex]].params[1]
		var_25_1.eventId = var_25_0

		JumpTools.OpenPageByJump("/sectionSelectHero", var_25_1)
	end
end

function MatrixProcessView:OnRewardAction()
	if self.selectItemIndex == -1 then
		return
	end

	local var_26_0 = self.phasesParams[self.selectItemIndex]
	local var_26_1 = self.phasesParams[self.selectItemIndex] and MatrixItemCfg[var_26_0]

	if not (self.phasesParams[self.selectItemIndex] and MatrixItemCfg[var_26_0]) then
		print("MatrixItemCfg cant find item by id :" .. var_26_0)

		return
	end

	local var_26_2 = var_26_1.matrix_item_type

	if MatrixConst.ITEM_TYPE.ASTROLABE == var_26_1.matrix_item_type then
		local var_26_3 = math.floor(var_26_1.params[1] / 1000)
		local var_26_4 = self:GetHeroData(var_26_3)

		if var_26_4:GetAstrolabeNum(var_26_1.params[1]) >= 3 then
			ShowTips("MATRIX_NOT_GET_ASTROLABEL")

			return
		end

		if self:GetAstrolabeMaxCount() <= #var_26_4:GetAstrolabeList() then
			JumpTools.OpenPageByJump("matrixProcessAstrolabeReplace", {
				heroId = var_26_3,
				astrolabeId = var_26_0,
				callback = function(arg_27_0)
					MatrixAction.QueryNextProgress({
						var_26_0,
						arg_27_0,
						var_26_4:GetStandardId()
					})
				end
			})
		else
			MatrixAction.QueryNextProgress({
				var_26_0,
				0,
				var_26_4:GetStandardId()
			})
		end
	elseif MatrixConst.ITEM_TYPE.EQUIP == var_26_2 then
		JumpTools.OpenPageByJump("matrixProcessSelectHero", {
			id = var_26_0
		})
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_26_2 then
		local var_26_5 = MatrixTools.GetWeaponSpecHero(var_26_1.params[1])

		if var_26_5 == 0 then
			JumpTools.OpenPageByJump("matrixProcessSelectHero", {
				id = var_26_0
			})
		else
			local var_26_6 = self:GetHeroData(var_26_5)
			local var_26_7 = var_26_6:GetWeaponServant()

			if var_26_7 ~= 0 then
				JumpTools.OpenPageByJump("matrixProcessWeaponReplace", {
					heroId = var_26_5,
					weaponId = var_26_0,
					callback = function()
						MatrixAction.QueryNextProgress({
							var_26_0,
							var_26_7,
							var_26_6:GetStandardId()
						})
					end
				})
			else
				MatrixAction.QueryNextProgress({
					var_26_0,
					0,
					var_26_6:GetStandardId()
				})
			end
		end
	else
		MatrixAction.QueryNextProgress({
			var_26_0
		})
	end
end

function MatrixProcessView:Dispose()
	if self.eventList_ then
		self.eventList_:Dispose()
	end

	if self.rewardList_ then
		self.rewardList_:Dispose()
	end

	if self.incidentList_ then
		self.incidentList_:Dispose()
	end

	MatrixProcessView.super.Dispose(self)
end

function MatrixProcessView:OnMatrixUserUpdate()
	if MatrixConst.STATE_TYPE.STARTED == self:GetGameState() then
		self:Refresh(true)
	end
end

function MatrixProcessView:GetGameState()
	return MatrixData:GetGameState()
end

function MatrixProcessView:GetHeroData(arg_32_1)
	return MatrixData:GetHeroData(arg_32_1)
end

function MatrixProcessView:GetAstrolabeMaxCount()
	return MatrixData:GetAstrolabeMaxCount()
end

function MatrixProcessView:GetMatrixPhaseData()
	return MatrixData:GetMatrixPhaseData()
end

function MatrixProcessView:GetDifficulty()
	return MatrixData:GetDifficulty()
end

function MatrixProcessView:GetGiveUpRewardAddition()
	return MatrixData:GetGiveUpRewardAddition()
end

function MatrixProcessView:GetTierDes()
	local var_37_0 = MatrixTierCfg[MatrixData:GetTierID()]

	return string.format("%s-%s", var_37_0.tier, var_37_0.level)
end

return MatrixProcessView

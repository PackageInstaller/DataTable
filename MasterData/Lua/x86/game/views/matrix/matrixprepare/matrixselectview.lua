local MatrixSelectView = class("MatrixSelectView", ReduxView)
local var_0_1 = {
	AI = "AI",
	CAPTAIN = "CAPTAIN",
	AFFIX = "AFFIX",
	BEACON = "BEACON",
	DIFFICULTY = "DIFFICULTY"
}

function MatrixSelectView:UIName()
	return "UI/Matrix/Prepare/MatrixSelectUI"
end

function MatrixSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function MatrixSelectView:Init()
	self:InitUI()
	self:AddUIListener()

	self.MAXSELECT = 2
	self.viewState = var_0_1.DIFFICULTY
	self.openDifficultyLv = -1

	for iter_3_0, iter_3_1 in ipairs(MatrixTerminalLevelCfg.all) do
		if table.indexof(MatrixTerminalLevelCfg[iter_3_1].difficulty_open_list, 2) then
			self.openDifficultyLv = iter_3_1

			break
		end
	end
end

function MatrixSelectView:InitUI()
	self:BindCfgUI()

	self.viewStateController_ = ControllerUtil.GetController(self.m_viewStateController, "state")
	self.tHero = {}

	ComponentBinder.GetInstance():BindCfgUI(self.tHero, self.m_hero)

	self.tDifficulty = {}

	ComponentBinder.GetInstance():BindCfgUI(self.tDifficulty, self.m_difficulty)

	self.tBeacon = {}

	ComponentBinder.GetInstance():BindCfgUI(self.tBeacon, self.m_beacon)

	self.heroList_ = LuaList.New(handler(self, self.IndexItem), self.tHero.m_heroList, MatrixSelectHeroItem)
	self.difficultyList_ = LuaList.New(handler(self, self.IndexDifficultyItem), self.tDifficulty.m_difficultyList, MatrixSelectDifficultyItem)
	self.selectAfiifxView = MatrixSelectAffixView.New(self.m_affix)
	self.beaconList_ = LuaList.New(handler(self, self.IndexBeaconItem), self.tBeacon.m_list, MatrixSelectBeaconItem)
end

function MatrixSelectView:AddUIListener()
	self:AddBtnListener(self.tHero.m_confirmBtn, nil, function()
		if var_0_1.CAPTAIN == self.viewState then
			if self.captainId == 0 then
				return
			end

			if self:HaveLoneWolf() then
				if self.selectDifficulty == 1 then
					self:StartMatrix()
				else
					self.viewState = var_0_1.AFFIX

					self:Refresh()
				end
			else
				self.viewState = var_0_1.AI

				self:Refresh()
			end
		else
			if self.captainId == 0 or #self.selectHeroList ~= 2 then
				return
			end

			if self.selectDifficulty == 1 then
				self:StartMatrix()
			else
				self.viewState = var_0_1.AFFIX

				self:Refresh()
			end
		end
	end)
	self:AddBtnListener(self.tDifficulty.m_okBtn, nil, function()
		self.viewState = var_0_1.BEACON

		self:Refresh()
	end)
	self:AddBtnListener(self.selectAfiifxView.m_okBtn, nil, function()
		self:StartMatrix()
	end)
	self:AddBtnListener(self.tBeacon.m_okBtn, nil, function()
		if #self.selectBeaconList == 0 then
			ShowTips(GetTips("MATRIX_SELECT_BEACON"))

			return
		end

		self.viewState = var_0_1.CAPTAIN

		self:Refresh()
	end)
end

function MatrixSelectView:HaveLoneWolf()
	return table.indexof(self.selectBeaconList, 10)
end

function MatrixSelectView:StartMatrix()
	local var_11_0 = clone(self.selectHeroList)

	table.insert(var_11_0, 1, self.captainId)
	MatrixAction.QueryStartMatrix(var_11_0, self.selectDifficulty, self.selectDifficulty == 1 and {} or self.selectAfiifxView.customData, self.selectBeaconList)
end

function MatrixSelectView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if var_0_1.AI == self.viewState then
			self.viewState = var_0_1.CAPTAIN
			self.selectHeroList = {}

			self:Refresh()
		elseif var_0_1.CAPTAIN == self.viewState then
			self.viewState = var_0_1.BEACON

			self:Refresh()
		elseif var_0_1.AFFIX == self.viewState then
			self.viewState = self:HaveLoneWolf() and var_0_1.CAPTAIN or var_0_1.AI

			self:Refresh()
		elseif var_0_1.BEACON == self.viewState then
			self.viewState = var_0_1.DIFFICULTY

			self:Refresh()
		else
			self:Back(1)
		end
	end)
end

function MatrixSelectView:OnTop()
	self:UpdateBar()
	self:Refresh()
end

function MatrixSelectView:OnEnter()
	MatrixData:SetCacheCustomAffix({})

	self.heroData = MatrixData:GetReadyHeroList()
	self.viewState = var_0_1.DIFFICULTY
	self.selectDifficulty = -1
	self.captainId = 0
	self.selectHeroList = {}
	self.selectBeaconList = {}

	self.selectAfiifxView:Reset()
	self:Refresh()
end

function MatrixSelectView:OnExit()
	manager.windowBar:HideBar()
end

function MatrixSelectView:Refresh()
	if var_0_1.CAPTAIN == self.viewState then
		self.viewStateController_:SetSelectedIndex(0)

		self.tHero.m_tip.text = GetTips("MATRIX_SELECT_TEAM_LEADER")
		self.tHero.m_confirmBtn.interactable = self.captainId ~= 0

		self.heroList_:StartScroll(#self.heroData)
	elseif var_0_1.AI == self.viewState then
		self.viewStateController_:SetSelectedIndex(0)

		self.tHero.m_tip.text = GetTips("MATRIX_SELECT_TEAM")
		self.tHero.m_confirmBtn.interactable = #self.selectHeroList == 2

		self.heroList_:StartScroll(#self.heroData)
	elseif var_0_1.DIFFICULTY == self.viewState then
		self.viewStateController_:SetSelectedIndex(1)
		self.difficultyList_:StartScroll(2)

		self.affixCustomData = {}
		self.tDifficulty.m_okBtn.interactable = self.selectDifficulty ~= -1
	elseif var_0_1.AFFIX == self.viewState then
		self.viewStateController_:SetSelectedIndex(2)
		self.selectAfiifxView:SetData(self.selectDifficulty)
	elseif var_0_1.BEACON == self.viewState then
		self.viewStateController_:SetSelectedIndex(3)

		self.maxBeaconSelect = MatrixTerminalLevelCfg[MatrixData:GetTerminalLevel()].beacon_number
		self.beaconData = MatrixData:GetUnlockBeaconList()

		self.beaconList_:StartScroll(#self.beaconData)

		self.tBeacon.m_numLab.text = #self.selectBeaconList .. "/" .. self.maxBeaconSelect
		self.tBeacon.m_okBtn.interactable = #self.selectBeaconList > 0
	end
end

function MatrixSelectView:IndexItem(arg_18_1, arg_18_2)
	local var_18_0 = self.heroData[arg_18_1]
	local var_18_1 = 0

	if var_0_1.CAPTAIN == self.viewState then
		if var_18_0 == self.captainId then
			var_18_1 = 1
		end
	elseif var_18_0 == self.captainId then
		var_18_1 = 3
	elseif table.indexof(self.selectHeroList, var_18_0) then
		var_18_1 = 1
	else
		if self.MAXSELECT > #self.selectHeroList then
			var_18_1 = 0
		end

		local var_18_2

		do
			var_18_1 = 2
			var_18_2 = self.selectDifficulty
		end
	end

	arg_18_2:Refresh(var_18_0, var_18_1, var_18_0 == self.captainId, var_18_2)
	arg_18_2:RegistCallBack(function()
		self:OnHeroItemClick(var_18_0)
	end)
end

function MatrixSelectView:OnHeroItemClick(arg_20_1)
	if var_0_1.CAPTAIN == self.viewState then
		self.captainId = arg_20_1 == self.captainId and 0 or arg_20_1
	elseif arg_20_1 ~= self.captainId then
		local var_20_0 = table.indexof(self.selectHeroList, arg_20_1)

		if var_20_0 then
			table.remove(self.selectHeroList, var_20_0)
		elseif self.MAXSELECT > #self.selectHeroList then
			table.insert(self.selectHeroList, arg_20_1)
		end
	end

	self:Refresh()
end

function MatrixSelectView:IndexDifficultyItem(arg_21_1, arg_21_2)
	arg_21_2:Refresh(arg_21_1, arg_21_1 == self.selectDifficulty)
	arg_21_2:RegistCallBack(function()
		self:OnDifficultyItemClick(arg_21_1)
	end)
end

function MatrixSelectView:OnDifficultyItemClick(arg_23_1)
	if arg_23_1 == 2 then
		if not table.indexof(MatrixTerminalLevelCfg[MatrixData:GetTerminalLevel()].difficulty_open_list, 2) then
			ShowTips(string.format(GetTips("MATRIX_TERMINAL_LEVEL_UNLOCK"), self.openDifficultyLv))

			return
		end

		if not IsConditionAchieved(MatrixConst.MATRIX_UNLOCK_DIFFICULTY_CONDITION) then
			ShowTips(GetTips("MATRIX_CLEARANCE_DIFFICULTY_UNLOCK"))

			return
		end
	end

	if arg_23_1 == self.selectDifficulty then
		return
	else
		self.selectDifficulty = arg_23_1
	end

	self:Refresh()
end

function MatrixSelectView:IndexBeaconItem(arg_24_1, arg_24_2)
	local var_24_0 = not not table.indexof(self.selectBeaconList, self.beaconData[arg_24_1])

	arg_24_2:Refresh(self.beaconData[arg_24_1])
	arg_24_2:SetChoice(var_24_0)
	arg_24_2:SetMask(not var_24_0 and #self.selectBeaconList >= self.maxBeaconSelect)
	arg_24_2:RegistCallBack(handler(self, self.OnBeaconItemClick))
end

function MatrixSelectView:OnBeaconItemClick(arg_25_1, arg_25_2)
	if table.indexof(self.selectBeaconList, arg_25_1) then
		self:UnSelectBeacon(arg_25_1)
	else
		if #self.selectBeaconList >= self.maxBeaconSelect then
			ShowTips("MATRIX_SELECT_BEACON_MAX")

			return
		end

		local var_25_0 = MatrixBeaconCfg[arg_25_1]
		local var_25_1 = {}
		local var_25_2 = MatrixData:GetTerminalGift() or {}

		for iter_25_0, iter_25_1 in ipairs(MatrixBeaconCfg[arg_25_1].require_terminal_list or {}) do
			if not var_25_2[iter_25_1] or var_25_2[iter_25_1] == 0 then
				table.insert(var_25_1, iter_25_1)
			end
		end

		if #var_25_1 > 0 then
			local var_25_3 = ""

			for iter_25_2, iter_25_3 in ipairs(var_25_1) do
				var_25_3 = iter_25_2 == 1 and MatrixTerminalGiftCfg[iter_25_3].name or var_25_3 .. "," .. MatrixTerminalGiftCfg[iter_25_3].name
			end

			ShowMessageBox({
				content = string.format(GetTips("ERROR_MATRIX_NOT_EFFECTIVE"), GetI18NText(var_25_0.name), GetI18NText(var_25_3)),
				OkCallback = function()
					self:SelectBeacon(arg_25_1)
				end
			})

			return
		end

		self:SelectBeacon(arg_25_1)
	end
end

function MatrixSelectView:SelectBeacon(arg_27_1)
	table.insert(self.selectBeaconList, arg_27_1)

	self.tBeacon.m_numLab.text = #self.selectBeaconList .. "/" .. self.maxBeaconSelect

	self.beaconList_:Refresh()

	self.tBeacon.m_okBtn.interactable = #self.selectBeaconList > 0
end

function MatrixSelectView:UnSelectBeacon(arg_28_1)
	table.remove(self.selectBeaconList, (table.indexof(self.selectBeaconList, arg_28_1)))

	self.tBeacon.m_numLab.text = #self.selectBeaconList .. "/" .. self.maxBeaconSelect

	self.beaconList_:Refresh()

	self.tBeacon.m_okBtn.interactable = #self.selectBeaconList > 0
end

function MatrixSelectView:Dispose()
	MatrixSelectView.super.Dispose(self)
	self.heroList_:Dispose()
	self.difficultyList_:Dispose()
	self.beaconList_:Dispose()
	self.selectAfiifxView:Dispose()
end

function MatrixSelectView:OnMatrixSystemOverdue()
	self:Back()
end

return MatrixSelectView

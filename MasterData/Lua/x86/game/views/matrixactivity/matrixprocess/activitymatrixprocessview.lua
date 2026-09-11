local ActivityMatrixProcessView = class("ActivityMatrixProcessView", MatrixProcessView)

function ActivityMatrixProcessView:InitUI()
	self:BindCfgUI()

	self.eventList_ = LuaList.New(handler(self, self.indexEventItem), self.m_eventList, ActivityMatrixProcessEventItem)
	self.rewardList_ = LuaList.New(handler(self, self.indexRewardItem), self.m_rewardList, ActivityMatrixProcessRewardItem)
	self.incidentList_ = LuaList.New(handler(self, self.indexIncidentItem), self.m_incidentList, MatrixProcessIncidentItem)
	self.phaseController_ = ControllerUtil.GetController(self.m_phaseController, "phase")
	self.hasGiveUpRewadController_ = ControllerUtil.GetController(self.m_phaseController, "hasGiveUpRewad")
end

function ActivityMatrixProcessView:AddUIListener()
	self:AddBtnListener(self.m_rewardCommon, nil, function()
		ActivityMatrixAction.QueryNextProgress(self.matrix_activity_id, {})
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
				ActivityMatrixAction.QueryMatrixGiveUp(self.matrix_activity_id)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	self:AddBtnListener(self.m_incidentBtn, nil, function()
		local var_9_0

		if self.selectItemIndex == -1 then
			do return end

			var_9_0 = {}
		end

		var_9_0[1] = self.incidentData[self.selectItemIndex]

		ActivityMatrixAction.QueryNextProgress(self.matrix_activity_id, var_9_0)
	end)
end

function ActivityMatrixProcessView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, self.matrix_activity_id)
end

function ActivityMatrixProcessView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	ActivityMatrixProcessView.super.OnEnter(self)
end

function ActivityMatrixProcessView:OnEventAction()
	if self.selectItemIndex == -1 then
		return
	end

	local var_12_0 = self.phasesParams[self.selectItemIndex]

	if not ActivityMatrixEventTemplateCfg[self.phasesParams[self.selectItemIndex]] then
		print("ActivityMatrixEventTemplateCfg cant find event by id :" .. var_12_0)

		return
	end

	if MatrixConst.EVENT_TYPE.SHOP == ActivityMatrixEventTemplateCfg[self.phasesParams[self.selectItemIndex]].event_type or MatrixConst.EVENT_TYPE.INCIDENT == ActivityMatrixEventTemplateCfg[self.phasesParams[self.selectItemIndex]].event_type then
		if self:GetMatrixPhaseData():GetPhase() == 2 then
			ActivityMatrixAction.DoEvent(self.matrix_activity_id)
		else
			ActivityMatrixAction.QueryNextProgress(self.matrix_activity_id, {
				var_12_0
			})
		end
	else
		local var_12_1 = {
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX
		}

		var_12_1.section = ActivityMatrixEventTemplateCfg[self.phasesParams[self.selectItemIndex]].params[1]
		var_12_1.eventId = var_12_0
		var_12_1.matrix_activity_id = self.matrix_activity_id
		var_12_1.activityID = self.matrix_activity_id

		JumpTools.OpenPageByJump("/sectionSelectHero", var_12_1)
	end
end

function ActivityMatrixProcessView:OnRewardAction()
	if self.selectItemIndex == -1 then
		return
	end

	local var_13_0 = self.phasesParams[self.selectItemIndex]
	local var_13_1 = self.phasesParams[self.selectItemIndex] and MatrixItemCfg[var_13_0]

	if not (self.phasesParams[self.selectItemIndex] and MatrixItemCfg[var_13_0]) then
		print("MatrixItemCfg cant find item by id :" .. var_13_0)

		return
	end

	local var_13_2 = var_13_1.matrix_item_type

	if MatrixConst.ITEM_TYPE.ASTROLABE == var_13_1.matrix_item_type then
		local var_13_3 = math.floor(var_13_1.params[1] / 1000)
		local var_13_4 = self:GetHeroData(var_13_3)

		if var_13_4:GetAstrolabeNum(var_13_1.params[1]) >= 3 then
			ShowTips("MATRIX_NOT_GET_ASTROLABEL")

			return
		end

		if self:GetAstrolabeMaxCount() <= #var_13_4:GetAstrolabeList() then
			JumpTools.OpenPageByJump("activityMatrixProcessAstrolabeReplace", {
				heroId = var_13_3,
				astrolabeId = var_13_0,
				callback = function(arg_14_0)
					ActivityMatrixAction.QueryNextProgress(self.matrix_activity_id, {
						var_13_0,
						arg_14_0,
						var_13_4:GetStandardId()
					})
				end
			})
		else
			ActivityMatrixAction.QueryNextProgress(self.matrix_activity_id, {
				var_13_0,
				0,
				var_13_4:GetStandardId()
			})
		end
	elseif MatrixConst.ITEM_TYPE.EQUIP == var_13_2 then
		local var_13_5 = self:GetMatrixHeroTeam()

		if #var_13_5 == 1 then
			local var_13_6 = self:GetHeroData(var_13_5[1])

			if self:GetHeroEquipMaxCount() <= #var_13_6:GetEquipList() then
				JumpTools.OpenPageByJump("activityMatrixProcessEquipReplace", {
					heroId = var_13_5[1],
					equipId = var_13_0,
					callback = function(arg_15_0)
						ActivityMatrixAction.QueryNextProgress(self.matrix_activity_id, {
							var_13_0,
							arg_15_0,
							var_13_6:GetStandardId()
						})
					end
				})
			else
				ActivityMatrixAction.QueryNextProgress(self.matrix_activity_id, {
					var_13_0,
					0,
					var_13_6:GetStandardId()
				})
			end
		else
			JumpTools.OpenPageByJump("activityMatrixProcessSelectHero", {
				id = var_13_0
			})
		end
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_13_2 then
		local var_13_7 = MatrixTools.GetWeaponSpecHero(var_13_1.params[1])
		local var_13_8 = self:GetMatrixHeroTeam()

		if var_13_7 == 0 and #var_13_8 == 1 then
			var_13_7 = var_13_8[1]
		end

		if var_13_7 == 0 then
			JumpTools.OpenPageByJump("activityMatrixProcessSelectHero", {
				id = var_13_0
			})
		else
			local var_13_9 = self:GetHeroData(var_13_7)
			local var_13_10 = var_13_9:GetWeaponServant()

			if var_13_10 ~= 0 then
				JumpTools.OpenPageByJump("activityMatrixProcessWeaponReplace", {
					heroId = var_13_7,
					weaponId = var_13_0,
					callback = function()
						ActivityMatrixAction.QueryNextProgress(self.matrix_activity_id, {
							var_13_0,
							var_13_10,
							var_13_9:GetStandardId()
						})
					end
				})
			else
				ActivityMatrixAction.QueryNextProgress(self.matrix_activity_id, {
					var_13_0,
					0,
					var_13_9:GetStandardId()
				})
			end
		end
	else
		ActivityMatrixAction.QueryNextProgress(self.matrix_activity_id, {
			var_13_0
		})
	end
end

function ActivityMatrixProcessView:indexRewardItem(arg_17_1, arg_17_2)
	arg_17_2:SetMatrixActivityId(self.matrix_activity_id)
	ActivityMatrixProcessView.super.indexRewardItem(self, arg_17_1, arg_17_2)
end

function ActivityMatrixProcessView:indexEventItem(arg_18_1, arg_18_2)
	arg_18_2:RegistCallBack(handler(self, self.OnEvengtItemClick))
	arg_18_2:Refresh(self.phasesParams[arg_18_1], arg_18_1, self.matrix_activity_id)
	arg_18_2:SetSelected(arg_18_1 == self.selectItemIndex)
end

function ActivityMatrixProcessView:GetGameState()
	return ActivityMatrixData:GetGameState(self.matrix_activity_id)
end

function ActivityMatrixProcessView:GetHeroData(arg_20_1)
	return ActivityMatrixData:GetHeroData(self.matrix_activity_id, arg_20_1)
end

function ActivityMatrixProcessView:GetAstrolabeMaxCount()
	return ActivityMatrixData:GetAstrolabeMaxCount(self.matrix_activity_id)
end

function ActivityMatrixProcessView:GetMatrixPhaseData()
	return ActivityMatrixData:GetMatrixPhaseData(self.matrix_activity_id)
end

function ActivityMatrixProcessView:GetDifficulty()
	return 1
end

function ActivityMatrixProcessView:GetTierID()
	return ActivityMatrixData:GetTierID(self.matrix_activity_id)
end

function ActivityMatrixProcessView:GetTierDes()
	local var_25_0 = ActivityMatrixTierTemplateCfg[ActivityMatrixData:GetTierID(self.matrix_activity_id)]

	return string.format("%s-%s", var_25_0.tier, var_25_0.level)
end

function ActivityMatrixProcessView:GetMatrixHeroTeam()
	return ActivityMatrixData:GetMatrixHeroTeam(self.matrix_activity_id)
end

function ActivityMatrixProcessView:GetHeroEquipMaxCount()
	return ActivityMatrixData:GetHeroEquipMaxCount(self.matrix_activity_id)
end

return ActivityMatrixProcessView

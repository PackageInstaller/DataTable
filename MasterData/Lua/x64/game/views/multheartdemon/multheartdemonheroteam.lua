local MultHeartDemonHeroTeam = class("MultHeartDemonHeroTeam", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function MultHeartDemonHeroTeam:UIName()
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_FormationHeroUI"
end

function MultHeartDemonHeroTeam:AddUIListener()
	self:AddBtnListener(self.infoBtn_, nil, handler(self, self.OnInfoBtnClick))
	self:AddBtnListener(self.joinBtn_, nil, handler(self, self.OnJoinClick))
	self:AddToggleListener(self.multBtn_, function(arg_3_0)
		self.isMult = arg_3_0

		local var_3_0

		if not self.isMult then
			self.multHeroList = self:GetMultHeartDemonTeam()
			var_3_0 = {}
		end

		var_3_0.button_name = self.isMult and "combat_team_edit_morehero_open" or "combat_team_edit_morehero_close"
		var_3_0.stage_id = self.params_.stage_id

		OperationRecorder.RecordButtonTouch(var_3_0)
		self:RefreshHeroList()
	end)
end

function MultHeartDemonHeroTeam:OnJoinClick()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(self.isMult and self.multHeroList or self:GetMultHeartDemonTeam()) do
		var_4_0[iter_4_0] = iter_4_1.trialID ~= 0 and iter_4_1.trialID or iter_4_1.id
	end

	if not self.isMult then
		if self:IsSameHeroInTeam(self.selectHeroData_.id) then
			if self:IsClickInTeam(self.selectHeroData_.id, self.selectHeroData_.trialID) then
				var_4_0[self.clickIndex] = nil
				self.multHeroList[self.clickIndex] = nil
			elseif self:IsInTeam(self.selectHeroData_.id, self.selectHeroData_.trialID) then
				var_4_0[self.clickIndex] = var_4_0[self.swapIndex]
				var_4_0[self.swapIndex] = var_4_0[self.clickIndex]
				self.multHeroList[self.swapIndex], self.multHeroList[self.clickIndex] = self.multHeroList[self.clickIndex], self.multHeroList[self.swapIndex]
			end
		else
			var_4_0[self.clickIndex] = self.selectHeroData_.trialID ~= 0 and self.selectHeroData_.trialID or self.selectHeroData_.id
			self.multHeroList[self.clickIndex] = self.selectHeroData_
		end
	end

	MultHeartDemonData:UpdateHeroList(var_4_0, self.difficult)
	MultHeartDemonData:UpdateTempHeroList(self.multHeroList, self.difficult)
	self:Back()
end

function MultHeartDemonHeroTeam:SelectHero(arg_5_1, arg_5_2)
	self.selectHeroData_ = arg_5_1

	if self.isMult and arg_5_2 ~= true then
		for iter_5_0, iter_5_1 in pairs(self.multHeroList) do
			if iter_5_1.id == arg_5_1.id and arg_5_1.trialID ~= iter_5_1.trialID then
				ShowTips("MULTI_HEART_DEMON_SELECT_SAME_HERO")

				return
			end
		end

		local var_5_0 = 4

		for iter_5_2, iter_5_3 in pairs(self.multHeroList) do
			if iter_5_3.id == arg_5_1.id and arg_5_1.trialID == iter_5_3.trialID then
				var_5_0 = iter_5_2

				break
			end
		end

		if self.multHeroList[var_5_0] then
			self.multHeroList[var_5_0] = nil
		else
			local var_5_1

			for iter_5_4 = 1, 3 do
				if self.multHeroList[iter_5_4] == nil then
					var_5_1 = iter_5_4

					break
				end
			end

			if var_5_1 then
				self.multHeroList[var_5_1] = arg_5_1
			end
		end

		for iter_5_5, iter_5_6 in pairs(self.heroHeadList_:GetItemList()) do
			iter_5_6:SetSelected(iter_5_6.heroId_ == self.selectHeroData_.id and iter_5_6.trialID_ == self.selectHeroData_.trialID)
			iter_5_6:UpdateMultiSelected(false)

			for iter_5_7, iter_5_8 in pairs(self.multHeroList) do
				if iter_5_8.id == iter_5_6.heroId_ and iter_5_6.trialID_ == iter_5_8.trialID then
					iter_5_6:UpdateMultiSelected(true)
				end
			end
		end
	else
		for iter_5_9, iter_5_10 in pairs(self.heroHeadList_:GetItemList()) do
			iter_5_10:SetSelected(iter_5_10.heroId_ == self.selectHeroData_.id and iter_5_10.trialID_ == self.selectHeroData_.trialID)
		end
	end

	self:RefreshInfoBtn()
	self:UpdateHeroView()
	self:RefreshJoinBtn()
end

function MultHeartDemonHeroTeam:OnEnter()
	self:UpdateData()
	self:UpdateBar()
	self:ProcessParams()
	self:SubViewOnEnter()
	self:GetHeroTeam()
	self:RefreshHeroDataList()
	self:RefreshHeroList()
	self:RefreshUI()
end

function MultHeartDemonHeroTeam:GetHeroTeam()
	self.heroTeam_, self.lockStateList_, self.lockHeroList_, self.heroTrialList_ = self.sectionProxy_:CustomGetTeamData()
	self.heroTeam_ = self:GetMultHeartDemonTeam()
end

function MultHeartDemonHeroTeam:GetMultHeartDemonTeam()
	local var_8_0 = MultHeartDemonData:GetDataByPara("heroTempData")

	if var_8_0 == nil then
		return {}
	else
		return deepClone(var_8_0[self.difficult]) or {}
	end
end

function MultHeartDemonHeroTeam:UpdateData()
	self.difficult = self.params_.difficult
	self.multHeroList = self:GetMultHeartDemonTeam()
	self.clickIndex = self.params_.clickIndex or 1
	self.params_.selectHeroPos = self.clickIndex
	self.isMult = false
	self.multBtn_.isOn = false
	self.isLock = self.params_.isLock

	SetActive(self.multBtn_.gameObject, not self.isLock and self.difficult ~= 2)
	SetActive(self.joinBtn_.gameObject, not self.isLock)
end

function MultHeartDemonHeroTeam:GetHeroHeadClass()
	return MultHeartHeroTeamHeadItem
end

function MultHeartDemonHeroTeam:HeadRenderer(arg_11_1, arg_11_2)
	local var_11_0 = self.heroDataList_[arg_11_1].id
	local var_11_1 = self.heroDataList_[arg_11_1].trialID

	arg_11_2:SetSectionHeroData(self.heroDataList_[arg_11_1], self.isMult, self.multHeroList)
	arg_11_2:SetSelected(arg_11_2.heroId_ == self.selectHeroData_.id and arg_11_2.trialID_ == self.selectHeroData_.trialID)
	arg_11_2:RegisterClickListener(function()
		self:SelectHero(self.heroDataList_[arg_11_1])
	end)
	arg_11_2:SetHeroLock(table.keyof(self.lockHeroList_, var_11_0) ~= nil or table.keyof(self.lockHeroList_, var_11_1) ~= nil)
end

function MultHeartDemonHeroTeam:GetDefaultHeroData()
	if not self.params_.isBack and self.heroTeam_[self.clickIndex] then
		if self.heroTeam_[self.clickIndex].id ~= 0 then
			for iter_13_0, iter_13_1 in ipairs(self.heroDataList_) do
				if iter_13_1.id == self.heroTeam_[self.clickIndex].id and iter_13_1.trialID == self.heroTeam_[self.clickIndex].trialID then
					return iter_13_1
				end
			end

			return {
				id = self.heroTeam_[self.clickIndex].id,
				trialID = self.heroTeam_[self.clickIndex].trialID,
				type = self.heroDataType_,
				heroViewProxy = self:GetHeroViewProxy(self.heroDataType_)
			}
		end
	end

	if #self.heroDataList_ > 0 then
		return self.heroDataList_[1]
	end

	return nil
end

function MultHeartDemonHeroTeam:RefreshUI()
	self.filterView_:SetHeroIdList(self.heroDataList_)
end

function MultHeartDemonHeroTeam:RefreshHeroList()
	if #self.heroDataList_ <= 0 then
		return
	end

	self.selectHeroData_ = self:GetDefaultHeroData()

	local var_15_0 = 1

	for iter_15_0, iter_15_1 in ipairs(self.heroDataList_) do
		if iter_15_1.id == self.selectHeroData_.id and iter_15_1.trialID == self.selectHeroData_.trialID then
			var_15_0 = iter_15_0

			break
		end
	end

	self.heroHeadList_:StartScroll(#self.heroDataList_, var_15_0)
	self:SelectHero(self.selectHeroData_, true)
end

function MultHeartDemonHeroTeam:IsSameHeroInTeam(arg_16_1)
	for iter_16_0, iter_16_1 in pairs(self.heroTeam_) do
		if arg_16_1 == iter_16_1.id then
			self.swapIndex = iter_16_0

			return true
		end
	end

	return false
end

function MultHeartDemonHeroTeam:IsInTeam(arg_17_1, arg_17_2)
	for iter_17_0, iter_17_1 in pairs(self.heroTeam_ or {}) do
		if iter_17_1.id == arg_17_1 and iter_17_1.trialID == arg_17_2 then
			return true, nil, iter_17_0
		end
	end

	return false
end

function MultHeartDemonHeroTeam:IsClickInTeam(arg_18_1, arg_18_2)
	if self.heroTeam_[self.clickIndex] == nil then
		return false
	end

	if arg_18_1 == self.heroTeam_[self.clickIndex].id and arg_18_2 == self.heroTeam_[self.clickIndex].trialID then
		return true
	end

	return false
end

function MultHeartDemonHeroTeam:RefreshJoinBtn()
	self.joinBtn_.interactable = true

	if self.isMult then
		self.joinBtnController_:SetSelectedState("add")

		return
	end

	if self.difficult == 2 then
		if self:IsSameHeroInTeam(self.selectHeroData_.id) then
			if self:IsClickInTeam(self.selectHeroData_.id, self.selectHeroData_.trialID) then
				self.joinBtn_.interactable = false

				self.joinBtnController_:SetSelectedState("cantRemove")
			else
				self.joinBtnController_:SetSelectedState("change")
			end
		else
			self.joinBtn_.interactable = false

			self.joinBtnController_:SetSelectedState("cantAdd")
		end
	elseif self:IsSameHeroInTeam(self.selectHeroData_.id) then
		if self:IsClickInTeam(self.selectHeroData_.id, self.selectHeroData_.trialID) then
			self.joinBtnController_:SetSelectedState("out")
		elseif self:IsInTeam(self.selectHeroData_.id, self.selectHeroData_.trialID) then
			self.joinBtnController_:SetSelectedState("change")
		else
			self.joinBtn_.interactable = false

			self.joinBtnController_:SetSelectedState("lock")
		end
	else
		self.joinBtnController_:SetSelectedState("add")
	end
end

function MultHeartDemonHeroTeam:ExtraSorter(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0, var_20_1, var_20_2 = self:IsInTeam(arg_20_1.id, arg_20_1.trialID, self.heroTeam_, self.heroTrialList_)
	local var_20_3, var_20_4, var_20_5 = self:IsInTeam(arg_20_2.id, arg_20_2.trialID, self.heroTeam_, self.heroTrialList_)

	if var_20_0 ~= var_20_3 then
		if var_20_0 and not var_20_3 then
			return true, true
		elseif not var_20_0 and var_20_3 then
			return true, false
		else
			return true, var_20_5 < var_20_2
		end
	end

	if arg_20_1.trialID ~= 0 or arg_20_2.trialID ~= 0 then
		if arg_20_1.trialID ~= 0 and arg_20_2.trialID ~= 0 then
			if arg_20_3 == 0 and arg_20_1.star ~= arg_20_2.star then
				if self.curOrder_ == "desc" then
					return true, arg_20_1.star > arg_20_2.star
				else
					return true, arg_20_1.star < arg_20_2.star
				end
			end

			local var_20_6 = getHeroPower(arg_20_1.trialID, true)
			local var_20_7 = getHeroPower(arg_20_2.trialID, true)

			if var_20_6 ~= var_20_7 then
				if arg_20_4 == "desc" then
					return true, var_20_7 < var_20_6
				else
					return true, var_20_6 < var_20_7
				end
			else
				return true, arg_20_1.trialID > arg_20_2.trialID
			end
		else
			return true, arg_20_1.trialID > arg_20_2.trialID
		end
	end

	return false, false
end

function MultHeartDemonHeroTeam:OnListChange(arg_21_1, arg_21_2)
	self.heroDataList_ = arg_21_2
	self.selectHeroData_ = self.heroDataList_[1]

	self.heroHeadList_:StartScroll(#self.heroDataList_)

	if #self.heroDataList_ == 0 then
		self.emptyController_:SetSelectedState("true")
	else
		self.emptyController_:SetSelectedState("false")

		if not self.params_.isEnter then
			self:SelectHero(self.heroDataList_[1])
		else
			self.params_.isEnter = false
		end
	end
end

function MultHeartDemonHeroTeam:ProcessHeroDataList(arg_22_1, arg_22_2, arg_22_3)
	if self.customHeroList_[self.params_.selectHeroPos][1] then
		self:ProcessCustomHeroData(arg_22_1, arg_22_2)
	else
		if self.difficult ~= 2 then
			self:ProcessOwnHeroData(arg_22_1, arg_22_3)
		end

		self:ProcessTrialHeroData(arg_22_1, arg_22_2)
	end
end

return MultHeartDemonHeroTeam

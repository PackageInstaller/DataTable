local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("MultHeartDemonHeroTeam", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_FormationHeroUI"
end

function var_0_1.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.infoBtn_, nil, handler(arg_2_0, arg_2_0.OnInfoBtnClick))
	arg_2_0:AddBtnListener(arg_2_0.joinBtn_, nil, handler(arg_2_0, arg_2_0.OnJoinClick))
	arg_2_0:AddToggleListener(arg_2_0.multBtn_, function(arg_3_0)
		arg_2_0.isMult = arg_3_0

		if not arg_2_0.isMult then
			arg_2_0.multHeroList = arg_2_0:GetMultHeartDemonTeam()
		end

		local var_3_0 = arg_2_0.isMult and "combat_team_edit_morehero_open" or "combat_team_edit_morehero_close"

		OperationRecorder.RecordButtonTouch({
			button_name = var_3_0,
			stage_id = arg_2_0.params_.stage_id
		})
		arg_2_0:RefreshHeroList()
	end)
end

function var_0_1.OnJoinClick(arg_4_0)
	local var_4_0 = {}
	local var_4_1

	if arg_4_0.isMult then
		var_4_1 = arg_4_0.multHeroList
	else
		var_4_1 = arg_4_0:GetMultHeartDemonTeam()
	end

	for iter_4_0, iter_4_1 in pairs(var_4_1) do
		if iter_4_1.trialID ~= 0 then
			var_4_0[iter_4_0] = iter_4_1.trialID
		else
			var_4_0[iter_4_0] = iter_4_1.id
		end
	end

	if not arg_4_0.isMult then
		if arg_4_0:IsSameHeroInTeam(arg_4_0.selectHeroData_.id) then
			if arg_4_0:IsClickInTeam(arg_4_0.selectHeroData_.id, arg_4_0.selectHeroData_.trialID) then
				var_4_0[arg_4_0.clickIndex] = nil
				arg_4_0.multHeroList[arg_4_0.clickIndex] = nil
			elseif arg_4_0:IsInTeam(arg_4_0.selectHeroData_.id, arg_4_0.selectHeroData_.trialID) then
				local var_4_2 = arg_4_0.swapIndex
				local var_4_3 = arg_4_0.clickIndex

				var_4_0[var_4_2], var_4_0[var_4_3] = var_4_0[var_4_3], var_4_0[var_4_2]
				arg_4_0.multHeroList[var_4_2], arg_4_0.multHeroList[var_4_3] = arg_4_0.multHeroList[var_4_3], arg_4_0.multHeroList[var_4_2]
			end
		else
			if arg_4_0.selectHeroData_.trialID ~= 0 then
				var_4_0[arg_4_0.clickIndex] = arg_4_0.selectHeroData_.trialID
			else
				var_4_0[arg_4_0.clickIndex] = arg_4_0.selectHeroData_.id
			end

			arg_4_0.multHeroList[arg_4_0.clickIndex] = arg_4_0.selectHeroData_
		end
	end

	MultHeartDemonData:UpdateHeroList(var_4_0, arg_4_0.difficult)
	MultHeartDemonData:UpdateTempHeroList(arg_4_0.multHeroList, arg_4_0.difficult)
	arg_4_0:Back()
end

function var_0_1.SelectHero(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.selectHeroData_ = arg_5_1

	if arg_5_0.isMult and arg_5_2 ~= true then
		for iter_5_0, iter_5_1 in pairs(arg_5_0.multHeroList) do
			if iter_5_1.id == arg_5_1.id and arg_5_1.trialID ~= iter_5_1.trialID then
				ShowTips("MULTI_HEART_DEMON_SELECT_SAME_HERO")

				return
			end
		end

		local var_5_0 = 4

		for iter_5_2, iter_5_3 in pairs(arg_5_0.multHeroList) do
			if iter_5_3.id == arg_5_1.id and arg_5_1.trialID == iter_5_3.trialID then
				var_5_0 = iter_5_2

				break
			end
		end

		if arg_5_0.multHeroList[var_5_0] then
			arg_5_0.multHeroList[var_5_0] = nil
		else
			local var_5_1

			for iter_5_4 = 1, 3 do
				if arg_5_0.multHeroList[iter_5_4] == nil then
					var_5_1 = iter_5_4

					break
				end
			end

			if var_5_1 then
				arg_5_0.multHeroList[var_5_1] = arg_5_1
			end
		end

		for iter_5_5, iter_5_6 in pairs(arg_5_0.heroHeadList_:GetItemList()) do
			iter_5_6:SetSelected(iter_5_6.heroId_ == arg_5_0.selectHeroData_.id and iter_5_6.trialID_ == arg_5_0.selectHeroData_.trialID)
			iter_5_6:UpdateMultiSelected(false)

			for iter_5_7, iter_5_8 in pairs(arg_5_0.multHeroList) do
				if iter_5_8.id == iter_5_6.heroId_ and iter_5_6.trialID_ == iter_5_8.trialID then
					iter_5_6:UpdateMultiSelected(true)
				end
			end
		end
	else
		for iter_5_9, iter_5_10 in pairs(arg_5_0.heroHeadList_:GetItemList()) do
			iter_5_10:SetSelected(iter_5_10.heroId_ == arg_5_0.selectHeroData_.id and iter_5_10.trialID_ == arg_5_0.selectHeroData_.trialID)
		end
	end

	arg_5_0:RefreshInfoBtn()
	arg_5_0:UpdateHeroView()
	arg_5_0:RefreshJoinBtn()
end

function var_0_1.OnEnter(arg_6_0)
	arg_6_0:UpdateData()
	arg_6_0:UpdateBar()
	arg_6_0:ProcessParams()
	arg_6_0:SubViewOnEnter()
	arg_6_0:GetHeroTeam()
	arg_6_0:RefreshHeroDataList()
	arg_6_0:RefreshHeroList()
	arg_6_0:RefreshUI()
end

function var_0_1.GetHeroTeam(arg_7_0)
	arg_7_0.heroTeam_, arg_7_0.lockStateList_, arg_7_0.lockHeroList_, arg_7_0.heroTrialList_ = arg_7_0.sectionProxy_:CustomGetTeamData()
	arg_7_0.heroTeam_ = arg_7_0:GetMultHeartDemonTeam()
end

function var_0_1.GetMultHeartDemonTeam(arg_8_0)
	local var_8_0 = MultHeartDemonData:GetDataByPara("heroTempData")

	if var_8_0 == nil then
		return {}
	else
		return deepClone(var_8_0[arg_8_0.difficult]) or {}
	end
end

function var_0_1.UpdateData(arg_9_0)
	arg_9_0.difficult = arg_9_0.params_.difficult
	arg_9_0.multHeroList = arg_9_0:GetMultHeartDemonTeam()
	arg_9_0.clickIndex = arg_9_0.params_.clickIndex or 1
	arg_9_0.params_.selectHeroPos = arg_9_0.clickIndex
	arg_9_0.isMult = false
	arg_9_0.multBtn_.isOn = false
	arg_9_0.isLock = arg_9_0.params_.isLock

	SetActive(arg_9_0.multBtn_.gameObject, not arg_9_0.isLock and arg_9_0.difficult ~= 2)
	SetActive(arg_9_0.joinBtn_.gameObject, not arg_9_0.isLock)
end

function var_0_1.GetHeroHeadClass(arg_10_0)
	return MultHeartHeroTeamHeadItem
end

function var_0_1.HeadRenderer(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.heroDataList_[arg_11_1].id
	local var_11_1 = arg_11_0.heroDataList_[arg_11_1].trialID

	arg_11_2:SetSectionHeroData(arg_11_0.heroDataList_[arg_11_1], arg_11_0.isMult, arg_11_0.multHeroList)
	arg_11_2:SetSelected(arg_11_2.heroId_ == arg_11_0.selectHeroData_.id and arg_11_2.trialID_ == arg_11_0.selectHeroData_.trialID)
	arg_11_2:RegisterClickListener(function()
		arg_11_0:SelectHero(arg_11_0.heroDataList_[arg_11_1])
	end)
	arg_11_2:SetHeroLock(table.keyof(arg_11_0.lockHeroList_, var_11_0) ~= nil or table.keyof(arg_11_0.lockHeroList_, var_11_1) ~= nil)
end

function var_0_1.GetDefaultHeroData(arg_13_0)
	if not arg_13_0.params_.isBack and arg_13_0.heroTeam_[arg_13_0.clickIndex] then
		local var_13_0 = arg_13_0.heroTeam_[arg_13_0.clickIndex].id
		local var_13_1 = arg_13_0.heroTeam_[arg_13_0.clickIndex].trialID

		if var_13_0 ~= 0 then
			for iter_13_0, iter_13_1 in ipairs(arg_13_0.heroDataList_) do
				if iter_13_1.id == var_13_0 and iter_13_1.trialID == var_13_1 then
					return iter_13_1
				end
			end

			return {
				id = var_13_0,
				trialID = var_13_1,
				type = arg_13_0.heroDataType_,
				heroViewProxy = arg_13_0:GetHeroViewProxy(arg_13_0.heroDataType_)
			}
		end
	end

	if #arg_13_0.heroDataList_ > 0 then
		return arg_13_0.heroDataList_[1]
	end

	return nil
end

function var_0_1.RefreshUI(arg_14_0)
	arg_14_0.filterView_:SetHeroIdList(arg_14_0.heroDataList_)
end

function var_0_1.RefreshHeroList(arg_15_0)
	if #arg_15_0.heroDataList_ <= 0 then
		return
	end

	arg_15_0.selectHeroData_ = arg_15_0:GetDefaultHeroData()

	local var_15_0 = 1

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.heroDataList_) do
		if iter_15_1.id == arg_15_0.selectHeroData_.id and iter_15_1.trialID == arg_15_0.selectHeroData_.trialID then
			var_15_0 = iter_15_0

			break
		end
	end

	arg_15_0.heroHeadList_:StartScroll(#arg_15_0.heroDataList_, var_15_0)
	arg_15_0:SelectHero(arg_15_0.selectHeroData_, true)
end

function var_0_1.IsSameHeroInTeam(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.heroTeam_) do
		if arg_16_1 == iter_16_1.id then
			arg_16_0.swapIndex = iter_16_0

			return true
		end
	end

	return false
end

function var_0_1.IsInTeam(arg_17_0, arg_17_1, arg_17_2)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.heroTeam_ or {}) do
		if iter_17_1.id == arg_17_1 and iter_17_1.trialID == arg_17_2 then
			return true, nil, iter_17_0
		end
	end

	return false
end

function var_0_1.IsClickInTeam(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.heroTeam_[arg_18_0.clickIndex] == nil then
		return false
	end

	if arg_18_1 == arg_18_0.heroTeam_[arg_18_0.clickIndex].id and arg_18_2 == arg_18_0.heroTeam_[arg_18_0.clickIndex].trialID then
		return true
	end

	return false
end

function var_0_1.RefreshJoinBtn(arg_19_0)
	arg_19_0.joinBtn_.interactable = true

	if arg_19_0.isMult then
		arg_19_0.joinBtnController_:SetSelectedState("add")

		return
	end

	if arg_19_0.difficult == 2 then
		if arg_19_0:IsSameHeroInTeam(arg_19_0.selectHeroData_.id) then
			if arg_19_0:IsClickInTeam(arg_19_0.selectHeroData_.id, arg_19_0.selectHeroData_.trialID) then
				arg_19_0.joinBtn_.interactable = false

				arg_19_0.joinBtnController_:SetSelectedState("cantRemove")
			else
				arg_19_0.joinBtnController_:SetSelectedState("change")
			end
		else
			arg_19_0.joinBtn_.interactable = false

			arg_19_0.joinBtnController_:SetSelectedState("cantAdd")
		end
	elseif arg_19_0:IsSameHeroInTeam(arg_19_0.selectHeroData_.id) then
		if arg_19_0:IsClickInTeam(arg_19_0.selectHeroData_.id, arg_19_0.selectHeroData_.trialID) then
			arg_19_0.joinBtnController_:SetSelectedState("out")
		elseif arg_19_0:IsInTeam(arg_19_0.selectHeroData_.id, arg_19_0.selectHeroData_.trialID) then
			arg_19_0.joinBtnController_:SetSelectedState("change")
		else
			arg_19_0.joinBtn_.interactable = false

			arg_19_0.joinBtnController_:SetSelectedState("lock")
		end
	else
		arg_19_0.joinBtnController_:SetSelectedState("add")
	end
end

function var_0_1.ExtraSorter(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0, var_20_1, var_20_2 = arg_20_0:IsInTeam(arg_20_1.id, arg_20_1.trialID, arg_20_0.heroTeam_, arg_20_0.heroTrialList_)
	local var_20_3, var_20_4, var_20_5 = arg_20_0:IsInTeam(arg_20_2.id, arg_20_2.trialID, arg_20_0.heroTeam_, arg_20_0.heroTrialList_)

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
				if arg_20_0.curOrder_ == "desc" then
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

function var_0_1.OnListChange(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.heroDataList_ = arg_21_2
	arg_21_0.selectHeroData_ = arg_21_0.heroDataList_[1]

	arg_21_0.heroHeadList_:StartScroll(#arg_21_0.heroDataList_)

	if #arg_21_0.heroDataList_ == 0 then
		arg_21_0.emptyController_:SetSelectedState("true")
	else
		arg_21_0.emptyController_:SetSelectedState("false")

		if not arg_21_0.params_.isEnter then
			arg_21_0:SelectHero(arg_21_0.heroDataList_[1])
		else
			arg_21_0.params_.isEnter = false
		end
	end
end

function var_0_1.ProcessHeroDataList(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_0.customHeroList_[arg_22_0.params_.selectHeroPos][1] then
		arg_22_0:ProcessCustomHeroData(arg_22_1, arg_22_2)
	else
		if arg_22_0.difficult ~= 2 then
			arg_22_0:ProcessOwnHeroData(arg_22_1, arg_22_3)
		end

		arg_22_0:ProcessTrialHeroData(arg_22_1, arg_22_2)
	end
end

return var_0_1

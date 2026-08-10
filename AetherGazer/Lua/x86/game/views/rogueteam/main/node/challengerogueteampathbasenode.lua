local var_0_0 = class("ChallengeRogueTeamPathBaseNode", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.id_ = arg_1_3
	arg_1_0.position_ = Vector3.New(0, 0, 0)
	arg_1_0.eulerAngles_ = Vector3(0, 0, 0)

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.isActiveController_ = arg_1_0.itemControllerEx_:GetController("Select")
	arg_1_0.isSelectController_ = arg_1_0.itemControllerEx_:GetController("ray")
	arg_1_0.showLongUpLineController_ = arg_1_0.controllerEx_:GetController("showLongUpLine")
	arg_1_0.showShortUpLineController_ = arg_1_0.controllerEx_:GetController("showShortUpLine")
	arg_1_0.showMiddleLineController_ = arg_1_0.controllerEx_:GetController("showMiddleLine")
	arg_1_0.showShortDownLineController_ = arg_1_0.controllerEx_:GetController("showShortDownLine")
	arg_1_0.showLongDownLineController_ = arg_1_0.controllerEx_:GetController("showLongDownLine")
	arg_1_0.arrowController_ = arg_1_0.controllerEx_:GetController("arrow")
	arg_1_0.unlockLightController_ = arg_1_0.itemControllerEx_:GetController("unlockLight")
	arg_1_0.completeController_ = arg_1_0.itemControllerEx_:GetController("complete")
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0:StopLineTimer()
	arg_2_0:StopTimer()
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.itemBtn_, nil, function()
		arg_3_0:OnClickItem()
	end)
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = (ChallengeRogueTeamTools.GetMapMaxRowCnt() + 1) / 2
	local var_5_1 = ChallengeRogueTeamData:PathGetNodeData(arg_5_0.id_)
	local var_5_2 = var_5_1.col
	local var_5_3 = (var_5_0 - (var_5_1.row == 0 and var_5_0 or var_5_1.row)) * ChallengeRogueTeamTools.GetRotationValueX()
	local var_5_4 = ChallengeRogueTeamTools.GetMapRadio()

	arg_5_0.position_.y = -var_5_4 * math.sin(var_5_3 / 180 * math.pi)
	arg_5_0.position_.z = var_5_4 * math.cos(var_5_3 / 180 * math.pi) - var_5_4
	arg_5_0.position_.x = var_5_2 * ChallengeRogueTeamConst.COL_SPACE - 150
	arg_5_0.transform_.localPosition = arg_5_0.position_
	arg_5_0.eulerAngles_.x = var_5_3
	arg_5_0.transform_.localEulerAngles = arg_5_0.eulerAngles_
	arg_5_0.transform_.name = arg_5_0.id_

	local var_5_5 = var_5_1.nodeType
	local var_5_6 = RogueTeamRoomTypeCfg[var_5_5]

	arg_5_0.nameText_.text = var_5_6.name
	arg_5_0.icon_.sprite = pureGetSpriteWithoutAtlas(var_5_6.icon)

	arg_5_0:RefreshState(var_5_1.state)
	arg_5_0:RefreshLine(var_5_1)
	SetActive(arg_5_0.gameObject_, true)
	arg_5_0:InitLineAnimator()
end

function var_0_0.RefreshState(arg_6_0, arg_6_1)
	local var_6_0 = ChallengeRogueTeamData:PathGetSelectedNodeID()
	local var_6_1 = ChallengeRogueTeamTools.HasMapNodeEffect() or ChallengeRogueTeamTools.HasMapSwitchEffect() or ChallengeRogueTeamData:UIGetNodeEffectID() ~= nil
	local var_6_2 = ChallengeRogueTeamTools.IsPostNode(arg_6_0.id_)

	if var_6_1 and arg_6_1 == ChallengeRogueTeamConst.NODE_STATE.UNCLEAN then
		arg_6_0.isActiveController_:SetSelectedState("already")
		arg_6_0.arrowController_:SetSelectedState("true")
		arg_6_0.completeController_:SetSelectedState("off")
	elseif arg_6_1 == ChallengeRogueTeamConst.NODE_STATE.OVER or var_6_2 then
		arg_6_0.isActiveController_:SetSelectedState("already")
		arg_6_0.arrowController_:SetSelectedState("true")

		if var_6_2 then
			arg_6_0.completeController_:SetSelectedState("off")
		else
			arg_6_0.completeController_:SetSelectedState("on")
		end
	elseif not var_6_1 and ChallengeRogueTeamTools.IsActiveNode(arg_6_0.id_) then
		arg_6_0.isActiveController_:SetSelectedState("await")
		arg_6_0.arrowController_:SetSelectedState("true")
		arg_6_0.completeController_:SetSelectedState("off")
	else
		arg_6_0.isActiveController_:SetSelectedState("not")
		arg_6_0.arrowController_:SetSelectedState("unselect")
		arg_6_0.completeController_:SetSelectedState("off")
	end

	if #ChallengeRogueTeamData:PathGetNodeData(arg_6_0.id_).nextIDList <= 0 then
		arg_6_0.arrowController_:SetSelectedState("off")
	end

	arg_6_0:RefreshSelectState()
end

function var_0_0.RefreshSelectState(arg_7_0)
	if ChallengeRogueTeamData:PathGetSelectedNodeID() == arg_7_0.id_ or ChallengeRogueTeamData:UIGetSelectNodeID() == arg_7_0.id_ then
		arg_7_0.isSelectController_:SetSelectedState("on")
	else
		arg_7_0.isSelectController_:SetSelectedState("off")
	end
end

function var_0_0.RefreshLine(arg_8_0, arg_8_1)
	local var_8_0 = (ChallengeRogueTeamTools.GetMapMaxRowCnt() + 1) / 2
	local var_8_1 = arg_8_1.row == 0 and var_8_0 or arg_8_1.row

	arg_8_0.showLongUpLineController_:SetSelectedState("false")
	arg_8_0.showShortUpLineController_:SetSelectedState("false")
	arg_8_0.showMiddleLineController_:SetSelectedState("false")
	arg_8_0.showShortDownLineController_:SetSelectedState("false")
	arg_8_0.showLongDownLineController_:SetSelectedState("false")

	if ChallengeRogueTeamTools.HasMapNodeEffect() then
		local var_8_2

		var_8_2 = ChallengeRogueTeamData:UIGetNodeEffectID() == arg_8_0.id_
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.nextIDList) do
		local var_8_3 = ChallengeRogueTeamData:PathGetNodeData(iter_8_1)
		local var_8_4 = var_8_1 - (var_8_3.row == 0 and var_8_0 or var_8_3.row)
		local var_8_5 = arg_8_0.showLongUpLineController_

		if var_8_4 == 1 then
			var_8_5 = arg_8_0.showShortUpLineController_
		elseif var_8_4 == 0 then
			var_8_5 = arg_8_0.showMiddleLineController_
		elseif var_8_4 == -1 then
			var_8_5 = arg_8_0.showShortDownLineController_
		elseif var_8_4 == -2 then
			var_8_5 = arg_8_0.showLongDownLineController_
		end

		if not ChallengeRogueTeamTools.IsActiveLine(arg_8_0.id_, iter_8_1) then
			var_8_5:SetSelectedState("unselect")
		else
			var_8_5:SetSelectedState("true")
		end
	end
end

function var_0_0.OnClickItem(arg_9_0)
	if ChallengeRogueTeamTools.IsCanClickNode(arg_9_0.id_) then
		if ChallengeRogueTeamData:UIGetSelectNodeID() == arg_9_0.id_ then
			return
		end

		ChallengeRogueTeamData:UISetSelectNodeID(arg_9_0.id_)
		arg_9_0:Go("challengeRogueTeamSectionInfo", {
			nodeID = arg_9_0.id_
		})
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_PATH_SELECTED_UI_NODE, arg_9_0.id_)
	end
end

function var_0_0.GetNodeID(arg_10_0)
	return arg_10_0.id_
end

function var_0_0.GetPosition(arg_11_0)
	return arg_11_0.transform_.localPosition
end

function var_0_0.PlayUnlockLight(arg_12_0)
	arg_12_0:StopTimer()
	arg_12_0.unlockLightController_:SetSelectedState("on")

	arg_12_0.timer_ = FrameTimer.New(function()
		if arg_12_0.unlockAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime < 1 then
			return
		end

		arg_12_0:StopTimer()

		local var_13_0 = ChallengeRogueTeamData:PathGetNodeData(arg_12_0.id_)

		arg_12_0:RefreshState(var_13_0.state)
		arg_12_0:RefreshLine(var_13_0)
	end, 1, -1)

	arg_12_0.timer_:Start()
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.timer_ then
		arg_14_0.unlockLightController_:SetSelectedState("off")
		arg_14_0.timer_:Stop()

		arg_14_0.timer_ = nil
	end
end

function var_0_0.SetCanClickState(arg_15_0)
	arg_15_0.isActiveController_:SetSelectedState("already")
end

function var_0_0.InitLineAnimator(arg_16_0)
	arg_16_0.lineAnimator1_.enabled = false
	arg_16_0.lineAnimator2_.enabled = false
	arg_16_0.lineAnimator3_.enabled = false
	arg_16_0.lineAnimator4_.enabled = false
	arg_16_0.lineAnimator5_.enabled = false

	local var_16_0 = ChallengeRogueTeamData:PathGetFinishPath()
	local var_16_1 = var_16_0[#var_16_0] == arg_16_0.id_
	local var_16_2 = ChallengeRogueTeamData:PathGetNodeData(arg_16_0.id_)

	if not ChallengeRogueTeamTools.HasMapNodeEffect() and var_16_2.state == ChallengeRogueTeamConst.NODE_STATE.OVER and var_16_1 and not ChallengeRogueTeamTools.HasMapSwitchEffect() then
		if arg_16_0.lineAnimator1_.gameObject.activeInHierarchy then
			arg_16_0.lineAnimator1_:Play("UI_rayline01", -1, 1)
			arg_16_0.lineAnimator1_:Update(1)
		end

		if arg_16_0.lineAnimator2_.gameObject.activeInHierarchy then
			arg_16_0.lineAnimator2_:Play("UI_rayline01", -1, 1)
			arg_16_0.lineAnimator2_:Update(1)
		end

		if arg_16_0.lineAnimator3_.gameObject.activeInHierarchy then
			arg_16_0.lineAnimator3_:Play("UI_rayline01", -1, 1)
			arg_16_0.lineAnimator3_:Update(1)
		end

		if arg_16_0.lineAnimator4_.gameObject.activeInHierarchy then
			arg_16_0.lineAnimator4_:Play("UI_rayline01", -1, 1)
			arg_16_0.lineAnimator4_:Update(1)
		end

		if arg_16_0.lineAnimator5_.gameObject.activeInHierarchy then
			arg_16_0.lineAnimator5_:Play("UI_rayline01", -1, 1)
			arg_16_0.lineAnimator5_:Update(1)
		end
	else
		if arg_16_0.lineAnimator1_.gameObject.activeInHierarchy then
			arg_16_0.lineAnimator1_:Play("UI_rayline01", -1, 0)
			arg_16_0.lineAnimator1_:Update(0)
		end

		if arg_16_0.lineAnimator2_.gameObject.activeInHierarchy then
			arg_16_0.lineAnimator2_:Play("UI_rayline01", -1, 0)
			arg_16_0.lineAnimator2_:Update(0)
		end

		if arg_16_0.lineAnimator3_.gameObject.activeInHierarchy then
			arg_16_0.lineAnimator3_:Play("UI_rayline01", -1, 0)
			arg_16_0.lineAnimator3_:Update(0)
		end

		if arg_16_0.lineAnimator4_.gameObject.activeInHierarchy then
			arg_16_0.lineAnimator4_:Play("UI_rayline01", -1, 0)
			arg_16_0.lineAnimator4_:Update(0)
		end

		if arg_16_0.lineAnimator5_.gameObject.activeInHierarchy then
			arg_16_0.lineAnimator5_:Play("UI_rayline01", -1, 0)
			arg_16_0.lineAnimator5_:Update(0)
		end
	end
end

function var_0_0.PlayLineAnimator(arg_17_0, arg_17_1)
	local var_17_0 = ChallengeRogueTeamData:PathGetNodeData(arg_17_0.id_)
	local var_17_1 = (ChallengeRogueTeamTools.GetMapMaxRowCnt() + 1) / 2
	local var_17_2 = var_17_0.row == 0 and var_17_1 or var_17_0.row
	local var_17_3 = {}

	for iter_17_0, iter_17_1 in ipairs(var_17_0.nextIDList) do
		local var_17_4 = ChallengeRogueTeamData:PathGetNodeData(iter_17_1)
		local var_17_5 = var_17_2 - (var_17_4.row == 0 and var_17_1 or var_17_4.row)
		local var_17_6 = arg_17_0.showLongUpLineController_

		if var_17_5 == 2 then
			arg_17_0.lineAnimator1_.enabled = true

			arg_17_0.lineAnimator1_:Play("UI_rayline01", -1, 0)
			table.insert(var_17_3, arg_17_0.lineAnimator1_)
		elseif var_17_5 == 1 then
			arg_17_0.lineAnimator2_.enabled = true

			arg_17_0.lineAnimator2_:Play("UI_rayline01", -1, 0)
			table.insert(var_17_3, arg_17_0.lineAnimator2_)
		elseif var_17_5 == 0 then
			arg_17_0.lineAnimator3_.enabled = true

			arg_17_0.lineAnimator3_:Play("UI_rayline01", -1, 0)
			table.insert(var_17_3, arg_17_0.lineAnimator3_)
		elseif var_17_5 == -1 then
			arg_17_0.lineAnimator4_.enabled = true

			arg_17_0.lineAnimator4_:Play("UI_rayline01", -1, 0)
			table.insert(var_17_3, arg_17_0.lineAnimator4_)
		elseif var_17_5 == -2 then
			arg_17_0.lineAnimator5_.enabled = true

			arg_17_0.lineAnimator5_:Play("UI_rayline01", -1, 0)
			table.insert(var_17_3, arg_17_0.lineAnimator5_)
		end
	end

	arg_17_0:StopLineTimer()

	arg_17_0.lineTimer_ = FrameTimer.New(function()
		for iter_18_0, iter_18_1 in ipairs(var_17_3) do
			if iter_18_1:GetCurrentAnimatorStateInfo(0).normalizedTime < 1 then
				return
			end

			arg_17_0:StopLineTimer()
			arg_17_1()
		end
	end, 1, -1)

	arg_17_0.lineTimer_:Start()
end

function var_0_0.StopLineTimer(arg_19_0)
	if arg_19_0.lineTimer_ then
		arg_19_0.lineTimer_:Stop()

		arg_19_0.lineTimer_ = nil
	end
end

function var_0_0.StopAnimator(arg_20_0)
	arg_20_0:StopTimer()

	arg_20_0.timer_ = Timer.New(function()
		arg_20_0.lineAnimator1_.enabled = false
		arg_20_0.lineAnimator2_.enabled = false
		arg_20_0.lineAnimator3_.enabled = false
		arg_20_0.lineAnimator4_.enabled = false
		arg_20_0.lineAnimator5_.enabled = false

		local var_21_0 = ChallengeRogueTeamData:PathGetNodeData(arg_20_0.id_)

		arg_20_0:RefreshLine(var_21_0)
	end, 0.2, 1)

	arg_20_0.timer_:Start()
end

return var_0_0

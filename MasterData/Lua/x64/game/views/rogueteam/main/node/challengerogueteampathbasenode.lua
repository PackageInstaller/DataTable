local ChallengeRogueTeamPathBaseNode = class("ChallengeRogueTeamPathBaseNode", ReduxView)

function ChallengeRogueTeamPathBaseNode:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.id_ = arg_1_3
	self.position_ = Vector3.New(0, 0, 0)
	self.eulerAngles_ = Vector3(0, 0, 0)

	self:BindCfgUI()
	self:AddListeners()

	self.isActiveController_ = self.itemControllerEx_:GetController("Select")
	self.isSelectController_ = self.itemControllerEx_:GetController("ray")
	self.showLongUpLineController_ = self.controllerEx_:GetController("showLongUpLine")
	self.showShortUpLineController_ = self.controllerEx_:GetController("showShortUpLine")
	self.showMiddleLineController_ = self.controllerEx_:GetController("showMiddleLine")
	self.showShortDownLineController_ = self.controllerEx_:GetController("showShortDownLine")
	self.showLongDownLineController_ = self.controllerEx_:GetController("showLongDownLine")
	self.arrowController_ = self.controllerEx_:GetController("arrow")
	self.unlockLightController_ = self.itemControllerEx_:GetController("unlockLight")
	self.completeController_ = self.itemControllerEx_:GetController("complete")
end

function ChallengeRogueTeamPathBaseNode:Dispose()
	self:StopLineTimer()
	self:StopTimer()
	ChallengeRogueTeamPathBaseNode.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamPathBaseNode:AddListeners()
	self:AddBtnListener(self.itemBtn_, nil, function()
		self:OnClickItem()
	end)
end

function ChallengeRogueTeamPathBaseNode:RefreshUI()
	local var_5_0 = (ChallengeRogueTeamTools.GetMapMaxRowCnt() + 1) / 2
	local var_5_1 = ChallengeRogueTeamData:PathGetNodeData(self.id_)
	local var_5_2 = var_5_1.col
	local var_5_3 = (var_5_0 - (var_5_1.row == 0 and var_5_0 or var_5_1.row)) * ChallengeRogueTeamTools.GetRotationValueX()
	local var_5_4 = ChallengeRogueTeamTools.GetMapRadio()

	self.position_.y = -var_5_4 * math.sin(var_5_3 / 180 * math.pi)
	self.position_.z = var_5_4 * math.cos(var_5_3 / 180 * math.pi) - var_5_4
	self.position_.x = var_5_2 * ChallengeRogueTeamConst.COL_SPACE - 150
	self.transform_.localPosition = self.position_
	self.eulerAngles_.x = var_5_3
	self.transform_.localEulerAngles = self.eulerAngles_
	self.transform_.name = self.id_
	self.nameText_.text = RogueTeamRoomTypeCfg[var_5_1.nodeType].name
	self.icon_.sprite = pureGetSpriteWithoutAtlas(RogueTeamRoomTypeCfg[var_5_1.nodeType].icon)

	self:RefreshState(var_5_1.state)
	self:RefreshLine(var_5_1)
	SetActive(self.gameObject_, true)
	self:InitLineAnimator()
end

function ChallengeRogueTeamPathBaseNode:RefreshState(arg_6_1)
	local var_6_0 = ChallengeRogueTeamData:PathGetSelectedNodeID()
	local var_6_1 = ChallengeRogueTeamTools.HasMapNodeEffect() or ChallengeRogueTeamTools.HasMapSwitchEffect() or ChallengeRogueTeamData:UIGetNodeEffectID() ~= nil
	local var_6_2 = ChallengeRogueTeamTools.IsPostNode(self.id_)

	if var_6_1 and arg_6_1 == ChallengeRogueTeamConst.NODE_STATE.UNCLEAN then
		self.isActiveController_:SetSelectedState("already")
		self.arrowController_:SetSelectedState("true")
		self.completeController_:SetSelectedState("off")
	elseif arg_6_1 == ChallengeRogueTeamConst.NODE_STATE.OVER or var_6_2 then
		self.isActiveController_:SetSelectedState("already")
		self.arrowController_:SetSelectedState("true")

		if var_6_2 then
			self.completeController_:SetSelectedState("off")
		else
			self.completeController_:SetSelectedState("on")
		end
	elseif not var_6_1 and ChallengeRogueTeamTools.IsActiveNode(self.id_) then
		self.isActiveController_:SetSelectedState("await")
		self.arrowController_:SetSelectedState("true")
		self.completeController_:SetSelectedState("off")
	else
		self.isActiveController_:SetSelectedState("not")
		self.arrowController_:SetSelectedState("unselect")
		self.completeController_:SetSelectedState("off")
	end

	if #ChallengeRogueTeamData:PathGetNodeData(self.id_).nextIDList <= 0 then
		self.arrowController_:SetSelectedState("off")
	end

	self:RefreshSelectState()
end

function ChallengeRogueTeamPathBaseNode:RefreshSelectState()
	if ChallengeRogueTeamData:PathGetSelectedNodeID() == self.id_ or ChallengeRogueTeamData:UIGetSelectNodeID() == self.id_ then
		self.isSelectController_:SetSelectedState("on")
	else
		self.isSelectController_:SetSelectedState("off")
	end
end

function ChallengeRogueTeamPathBaseNode:RefreshLine(arg_8_1)
	local var_8_0 = (ChallengeRogueTeamTools.GetMapMaxRowCnt() + 1) / 2
	local var_8_1 = arg_8_1.row == 0 and var_8_0 or arg_8_1.row

	self.showLongUpLineController_:SetSelectedState("false")
	self.showShortUpLineController_:SetSelectedState("false")
	self.showMiddleLineController_:SetSelectedState("false")
	self.showShortDownLineController_:SetSelectedState("false")
	self.showLongDownLineController_:SetSelectedState("false")

	if ChallengeRogueTeamTools.HasMapNodeEffect() then
		local var_8_2 = ChallengeRogueTeamData:UIGetNodeEffectID() == self.id_
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.nextIDList) do
		local var_8_3 = ChallengeRogueTeamData:PathGetNodeData(iter_8_1)
		local var_8_4 = self.showLongUpLineController_

		if var_8_1 - (var_8_3.row == 0 and var_8_0 or var_8_3.row) == 1 then
			var_8_4 = self.showShortUpLineController_
		elseif var_8_1 - (var_8_3.row == 0 and var_8_0 or var_8_3.row) == 0 then
			var_8_4 = self.showMiddleLineController_
		elseif var_8_1 - (var_8_3.row == 0 and var_8_0 or var_8_3.row) == -1 then
			var_8_4 = self.showShortDownLineController_
		elseif var_8_1 - (var_8_3.row == 0 and var_8_0 or var_8_3.row) == -2 then
			var_8_4 = self.showLongDownLineController_
		end

		if not ChallengeRogueTeamTools.IsActiveLine(self.id_, iter_8_1) then
			var_8_4:SetSelectedState("unselect")
		else
			var_8_4:SetSelectedState("true")
		end
	end
end

function ChallengeRogueTeamPathBaseNode:OnClickItem()
	if ChallengeRogueTeamTools.IsCanClickNode(self.id_) then
		if ChallengeRogueTeamData:UIGetSelectNodeID() == self.id_ then
			return
		end

		ChallengeRogueTeamData:UISetSelectNodeID(self.id_)
		self:Go("challengeRogueTeamSectionInfo", {
			nodeID = self.id_
		})
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_PATH_SELECTED_UI_NODE, self.id_)
	end
end

function ChallengeRogueTeamPathBaseNode:GetNodeID()
	return self.id_
end

function ChallengeRogueTeamPathBaseNode:GetPosition()
	return self.transform_.localPosition
end

function ChallengeRogueTeamPathBaseNode:PlayUnlockLight()
	self:StopTimer()
	self.unlockLightController_:SetSelectedState("on")

	self.timer_ = FrameTimer.New(function()
		if self.unlockAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime < 1 then
			return
		end

		self:StopTimer()

		local var_13_0 = ChallengeRogueTeamData:PathGetNodeData(self.id_)

		self:RefreshState(var_13_0.state)
		self:RefreshLine(var_13_0)
	end, 1, -1)

	self.timer_:Start()
end

function ChallengeRogueTeamPathBaseNode:StopTimer()
	if self.timer_ then
		self.unlockLightController_:SetSelectedState("off")
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ChallengeRogueTeamPathBaseNode:SetCanClickState()
	self.isActiveController_:SetSelectedState("already")
end

function ChallengeRogueTeamPathBaseNode:InitLineAnimator()
	self.lineAnimator1_.enabled = false
	self.lineAnimator2_.enabled = false
	self.lineAnimator3_.enabled = false
	self.lineAnimator4_.enabled = false
	self.lineAnimator5_.enabled = false

	local var_16_0 = ChallengeRogueTeamData:PathGetFinishPath()

	if not ChallengeRogueTeamTools.HasMapNodeEffect() and ChallengeRogueTeamData:PathGetNodeData(self.id_).state == ChallengeRogueTeamConst.NODE_STATE.OVER and var_16_0[#var_16_0] == self.id_ and not ChallengeRogueTeamTools.HasMapSwitchEffect() then
		if self.lineAnimator1_.gameObject.activeInHierarchy then
			self.lineAnimator1_:Play("UI_rayline01", -1, 1)
			self.lineAnimator1_:Update(1)
		end

		if self.lineAnimator2_.gameObject.activeInHierarchy then
			self.lineAnimator2_:Play("UI_rayline01", -1, 1)
			self.lineAnimator2_:Update(1)
		end

		if self.lineAnimator3_.gameObject.activeInHierarchy then
			self.lineAnimator3_:Play("UI_rayline01", -1, 1)
			self.lineAnimator3_:Update(1)
		end

		if self.lineAnimator4_.gameObject.activeInHierarchy then
			self.lineAnimator4_:Play("UI_rayline01", -1, 1)
			self.lineAnimator4_:Update(1)
		end

		if self.lineAnimator5_.gameObject.activeInHierarchy then
			self.lineAnimator5_:Play("UI_rayline01", -1, 1)
			self.lineAnimator5_:Update(1)
		end
	else
		if self.lineAnimator1_.gameObject.activeInHierarchy then
			self.lineAnimator1_:Play("UI_rayline01", -1, 0)
			self.lineAnimator1_:Update(0)
		end

		if self.lineAnimator2_.gameObject.activeInHierarchy then
			self.lineAnimator2_:Play("UI_rayline01", -1, 0)
			self.lineAnimator2_:Update(0)
		end

		if self.lineAnimator3_.gameObject.activeInHierarchy then
			self.lineAnimator3_:Play("UI_rayline01", -1, 0)
			self.lineAnimator3_:Update(0)
		end

		if self.lineAnimator4_.gameObject.activeInHierarchy then
			self.lineAnimator4_:Play("UI_rayline01", -1, 0)
			self.lineAnimator4_:Update(0)
		end

		if self.lineAnimator5_.gameObject.activeInHierarchy then
			self.lineAnimator5_:Play("UI_rayline01", -1, 0)
			self.lineAnimator5_:Update(0)
		end
	end
end

function ChallengeRogueTeamPathBaseNode:PlayLineAnimator(arg_17_1)
	local var_17_0 = ChallengeRogueTeamData:PathGetNodeData(self.id_)
	local var_17_1 = (ChallengeRogueTeamTools.GetMapMaxRowCnt() + 1) / 2
	local var_17_2 = var_17_0.row == 0 and var_17_1 or var_17_0.row
	local var_17_3 = {}

	for iter_17_0, iter_17_1 in ipairs(var_17_0.nextIDList) do
		local var_17_4 = ChallengeRogueTeamData:PathGetNodeData(iter_17_1)

		if var_17_2 - (var_17_4.row == 0 and var_17_1 or var_17_4.row) == 2 then
			self.lineAnimator1_.enabled = true

			self.lineAnimator1_:Play("UI_rayline01", -1, 0)
			table.insert(var_17_3, self.lineAnimator1_)
		elseif var_17_2 - (var_17_4.row == 0 and var_17_1 or var_17_4.row) == 1 then
			self.lineAnimator2_.enabled = true

			self.lineAnimator2_:Play("UI_rayline01", -1, 0)
			table.insert(var_17_3, self.lineAnimator2_)
		elseif var_17_2 - (var_17_4.row == 0 and var_17_1 or var_17_4.row) == 0 then
			self.lineAnimator3_.enabled = true

			self.lineAnimator3_:Play("UI_rayline01", -1, 0)
			table.insert(var_17_3, self.lineAnimator3_)
		elseif var_17_2 - (var_17_4.row == 0 and var_17_1 or var_17_4.row) == -1 then
			self.lineAnimator4_.enabled = true

			self.lineAnimator4_:Play("UI_rayline01", -1, 0)
			table.insert(var_17_3, self.lineAnimator4_)
		elseif var_17_2 - (var_17_4.row == 0 and var_17_1 or var_17_4.row) == -2 then
			self.lineAnimator5_.enabled = true

			self.lineAnimator5_:Play("UI_rayline01", -1, 0)
			table.insert(var_17_3, self.lineAnimator5_)
		end
	end

	self:StopLineTimer()

	self.lineTimer_ = FrameTimer.New(function()
		for iter_18_0, iter_18_1 in ipairs(var_17_3) do
			if iter_18_1:GetCurrentAnimatorStateInfo(0).normalizedTime < 1 then
				return
			end

			self:StopLineTimer()
			arg_17_1()
		end
	end, 1, -1)

	self.lineTimer_:Start()
end

function ChallengeRogueTeamPathBaseNode:StopLineTimer()
	if self.lineTimer_ then
		self.lineTimer_:Stop()

		self.lineTimer_ = nil
	end
end

function ChallengeRogueTeamPathBaseNode:StopAnimator()
	self:StopTimer()

	self.timer_ = Timer.New(function()
		self.lineAnimator1_.enabled = false
		self.lineAnimator2_.enabled = false
		self.lineAnimator3_.enabled = false
		self.lineAnimator4_.enabled = false
		self.lineAnimator5_.enabled = false

		self:RefreshLine((ChallengeRogueTeamData:PathGetNodeData(self.id_)))
	end, 0.2, 1)

	self.timer_:Start()
end

return ChallengeRogueTeamPathBaseNode

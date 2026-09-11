local BilliardGameMergeSkillPopView = class("BilliardGameMergeSkillPopView", ReduxView)

function BilliardGameMergeSkillPopView:UIName()
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_BallxPit/Activity_WuLuo_BallxPit_BuffFusionPopUI"
end

function BilliardGameMergeSkillPopView:UIParent()
	return manager.ui.uiPop.transform
end

function BilliardGameMergeSkillPopView:Init()
	self:OnInit()
	self:AddUIListener()
end

function BilliardGameMergeSkillPopView:OnInit()
	self:BindCfgUI()

	self.typeController_ = self.transCon_:GetController("type")
	self.bgController_ = self.transCon_:GetController("bg")
	self.skillList_ = LuaList.New(handler(self, self.IndexItem), self.mergeSkillListGo_, BilliardGameMergeSkillItemView)
	self.mainBuffItem_ = BilliardGameSmallSkillItemView.New(self.buffItemGo_)
	self.conbineTagTextList_ = {}
	self.conbineSkillItemList_ = {}

	for iter_4_0 = 1, 2 do
		self.conbineTagTextList_[iter_4_0] = self["combineTagText_" .. iter_4_0]
		self.conbineSkillItemList_[iter_4_0] = {}

		ComponentBinder.GetInstance():BindCfgUI(self.conbineSkillItemList_[iter_4_0], self["combineSkillGo_" .. iter_4_0])

		self.conbineSkillItemList_[iter_4_0].buffItem = BilliardGameSmallSkillItemView.New(self.conbineSkillItemList_[iter_4_0].buffItemGo_)
	end

	self.upgradeSkillItemList_ = {}

	for iter_4_1 = 1, 6 do
		self.upgradeSkillItemList_[iter_4_1] = BilliardGameSmallSkillItemView.New(self["upgradeSkillGo_" .. iter_4_1])
	end
end

function BilliardGameMergeSkillPopView:AddUIListener()
	self:AddBtnListener(self.comfirmBtn_, nil, function()
		AnimatorTools.PlayAnimationWithCallback(self.anim_, "Exit", function()
			self:Back()

			if self.params_.backCallBack then
				self.params_.backCallBack()
			end

			if self.selectedSkillItem_ and self.selectedSkillItem_.skill_ and self.selectedSkillItem_.skill_.mainBuffId then
				if BilliardGameMgr:OnMergeSkill(self.selectedSkillItem_.skill_) then
					manager.notify:Invoke(BilliardGameEvent.SET_MERGE_AND_BALL_ACTIVE, false)
					JumpTools.OpenPageByJump("billiardGameMergeSuccessPopView", {
						skill = self.selectedSkillItem_.skill_
					})
				end
			else
				manager.notify:Invoke(BilliardGameEvent.SET_MERGE_AND_BALL_ACTIVE, false)
				JumpTools.OpenPageByJump("billiardGameUpgradeSuccessPopView", {
					skillList = BilliardGameMgr:OnUpgradeRandomSkill()
				})
			end
		end)
	end)
end

function BilliardGameMergeSkillPopView:OnEnter()
	self.mergeSkillList_ = BilliardGameMgr:FindAvailableMergeSkills()
	self.selectedIndex_ = 1
	self.selectedSkillItem_ = nil
	self.selectedItem_ = nil

	self.skillList_:StartScroll(#self.mergeSkillList_)
	SetActive(self.gameObject_, true)
end

function BilliardGameMergeSkillPopView:IndexItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.mergeSkillList_[arg_9_1], arg_9_1)
	arg_9_2:RegisterClickEvent(handler(self, self.OnClickSkillItem))

	if arg_9_1 == self.selectedIndex_ then
		self:SelectSkillItem(arg_9_2)
	else
		arg_9_2:SetSelected(false)
	end
end

function BilliardGameMergeSkillPopView:RefreshItemTrack()
	for iter_10_0, iter_10_1 in ipairs(self.skillList_:GetItemList()) do
		iter_10_1:RefreshTrackState()
	end
end

function BilliardGameMergeSkillPopView:OnClickSkillItem(arg_11_1)
	if self.selectedIndex_ == arg_11_1.index_ then
		return
	end

	if self.selectedSkillItem_ then
		self.selectedSkillItem_:SetSelected(false)
	end

	self.selectedIndex_ = arg_11_1.index_

	self.switchAnim_:Play("Panel_refresh")
	self:SelectSkillItem(arg_11_1)
end

function BilliardGameMergeSkillPopView:SelectSkillItem(arg_12_1)
	self.selectedSkillItem_ = arg_12_1

	self.selectedSkillItem_:SetSelected(true)

	if arg_12_1.skill_.mainBuffId == nil then
		self:RefreshUpgradeSkill()
	elseif arg_12_1.skill_.isCombine_ then
		self:RefreshCombineSkill(arg_12_1.skill_)
	else
		self:RefreshSkill(arg_12_1.skill_)
	end
end

function BilliardGameMergeSkillPopView:RefreshUpgradeSkill()
	self.typeController_:SetSelectedState("upgrade")
	self.bgController_:SetSelectedState("other")

	self.upgradeSkillList_ = BilliardGameMgr:GetCanUpgradeSkillList()

	for iter_13_0 = 1, #self.upgradeSkillItemList_ do
		if self.upgradeSkillList_[iter_13_0] then
			SetActive(self.upgradeSkillItemList_[iter_13_0].gameObject_, true)
			self.upgradeSkillItemList_[iter_13_0]:SetSkillData(self.upgradeSkillList_[iter_13_0])
		else
			SetActive(self.upgradeSkillItemList_[iter_13_0].gameObject_, false)
		end
	end
end

function BilliardGameMergeSkillPopView:RefreshCombineSkill(arg_14_1)
	self.combineScroll_.verticalNormalizedPosition = 1

	self.typeController_:SetSelectedState("combine")

	if MergeBallBuffCfg[arg_14_1.buffIdList[1]].type == BilliardGameConst.MergeBallBuffType.BASIC and MergeBallBuffCfg[arg_14_1.buffIdList[2]].type == BilliardGameConst.MergeBallBuffType.BASIC then
		self.bgController_:SetSelectedState("basic")
	elseif MergeBallBuffCfg[arg_14_1.buffIdList[1]].type == BilliardGameConst.MergeBallBuffType.ULTIMATE or MergeBallBuffCfg[arg_14_1.buffIdList[2]].type == BilliardGameConst.MergeBallBuffType.ULTIMATE then
		self.bgController_:SetSelectedState("ultimate")
	elseif MergeBallBuffCfg[arg_14_1.buffIdList[1]].type == BilliardGameConst.MergeBallBuffType.ADVANCE or MergeBallBuffCfg[arg_14_1.buffIdList[2]].type == BilliardGameConst.MergeBallBuffType.ADVANCE then
		self.bgController_:SetSelectedState("advanced")
	else
		self.typeController_:SetSelectedState("other")
	end

	self.mainBuffItem_:SetSkillData(arg_14_1)

	local var_14_0 = {}

	for iter_14_0 = 1, #arg_14_1.buffIdList do
		if self.conbineTagTextList_[iter_14_0] then
			self.conbineTagTextList_[iter_14_0].text = GetTips("MERGE_BALL_TAG_" .. MergeBallBuffCfg[arg_14_1.buffIdList[iter_14_0]].tag[1])
		end

		if self.conbineSkillItemList_[iter_14_0] then
			self.conbineSkillItemList_[iter_14_0].buffItem:SetBuffData(arg_14_1.buffIdList[iter_14_0])

			self.conbineSkillItemList_[iter_14_0].nameText_.text = MergeBallBuffCfg[arg_14_1.buffIdList[iter_14_0]].name
			self.conbineSkillItemList_[iter_14_0].descText_.text = string.format(MergeBallBuffCfg[arg_14_1.buffIdList[iter_14_0]].desc, unpack(MergeBallBuffCfg[arg_14_1.buffIdList[iter_14_0]].param_level[arg_14_1.level]))
		end

		table.insert(var_14_0, MergeBallBuffCfg[arg_14_1.buffIdList[iter_14_0]])
	end

	if #var_14_0 == 1 then
		self.nameText_.text = var_14_0[1].name
		self.combineDesc_.text = ""
	elseif #var_14_0 == 2 then
		self.nameText_.text = string.format("%s X %s", var_14_0[1].name, var_14_0[2].name)
		self.combineDesc_.text = (var_14_0[1].merge_weight == var_14_0[2].merge_weight or var_14_0[1].merge_weight == 0 or var_14_0[2].merge_weight == 0) and GetTips("MERGE_BALL_COMBINE_TIP_BLANK") or string.format(GetTips("MERGE_BALL_COMBINE_TIP"), var_14_0[1].combine_text1, var_14_0[2].combine_text2)
	end
end

function BilliardGameMergeSkillPopView:RefreshSkill(arg_15_1)
	local var_15_0 = MergeBallBuffCfg[arg_15_1.mainBuffId]

	if MergeBallBuffCfg[arg_15_1.mainBuffId].type == BilliardGameConst.MergeBallBuffType.ULTIMATE then
		self.typeController_:SetSelectedState("ultimate")
		self.bgController_:SetSelectedState("ultimate")
	elseif var_15_0.type == BilliardGameConst.MergeBallBuffType.ADVANCE then
		self.typeController_:SetSelectedState("advanced")
		self.bgController_:SetSelectedState("advanced")
	elseif var_15_0.type == BilliardGameConst.MergeBallBuffType.EFFECT then
		self.typeController_:SetSelectedState("effect")
		self.bgController_:SetSelectedState("other")

		self.effectImg_.sprite = pureGetSpriteWithoutAtlas(var_15_0.icon)
	else
		self.typeController_:SetSelectedState("notFound")
		self.bgController_:SetSelectedState("other")
	end

	self.mainBuffItem_:SetBuffData(arg_15_1.mainBuffId, true)

	self.nameText_.text = var_15_0.name
	self.tagText_.text = GetTips("MERGE_BALL_TAG_" .. var_15_0.tag[1])
	self.descText_.text = string.format(var_15_0.desc, unpack(var_15_0.param_level[1]))
end

function BilliardGameMergeSkillPopView:OnTop()
	manager.windowBar:SwitchBar({})
	self:RefreshItemTrack()
end

function BilliardGameMergeSkillPopView:OnExit()
	if self.selectedSkillItem_ then
		self.selectedSkillItem_:SetSelected(false)
	end
end

function BilliardGameMergeSkillPopView:Dispose()
	if self.skillList_ then
		self.skillList_:Dispose()
	end

	self.skillList_ = nil

	self.mainBuffItem_:Dispose()

	for iter_18_0 = 1, #self.conbineSkillItemList_ do
		self.conbineSkillItemList_[iter_18_0].buffItem:Dispose()
	end

	for iter_18_1 = 1, #self.upgradeSkillItemList_ do
		self.upgradeSkillItemList_[iter_18_1]:Dispose()
	end

	BilliardGameMergeSkillPopView.super.Dispose(self)
end

return BilliardGameMergeSkillPopView

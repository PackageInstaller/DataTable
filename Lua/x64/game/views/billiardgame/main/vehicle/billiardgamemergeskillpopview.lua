local var_0_0 = class("BilliardGameMergeSkillPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_BallxPit/Activity_WuLuo_BallxPit_BuffFusionPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:OnInit()
	arg_3_0:AddUIListener()
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.typeController_ = arg_4_0.transCon_:GetController("type")
	arg_4_0.bgController_ = arg_4_0.transCon_:GetController("bg")
	arg_4_0.skillList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.mergeSkillListGo_, BilliardGameMergeSkillItemView)
	arg_4_0.mainBuffItem_ = BilliardGameSmallSkillItemView.New(arg_4_0.buffItemGo_)
	arg_4_0.conbineTagTextList_ = {}
	arg_4_0.conbineSkillItemList_ = {}

	for iter_4_0 = 1, 2 do
		arg_4_0.conbineTagTextList_[iter_4_0] = arg_4_0["combineTagText_" .. iter_4_0]
		arg_4_0.conbineSkillItemList_[iter_4_0] = {}

		ComponentBinder.GetInstance():BindCfgUI(arg_4_0.conbineSkillItemList_[iter_4_0], arg_4_0["combineSkillGo_" .. iter_4_0])

		arg_4_0.conbineSkillItemList_[iter_4_0].buffItem = BilliardGameSmallSkillItemView.New(arg_4_0.conbineSkillItemList_[iter_4_0].buffItemGo_)
	end

	arg_4_0.upgradeSkillItemList_ = {}

	for iter_4_1 = 1, 6 do
		arg_4_0.upgradeSkillItemList_[iter_4_1] = BilliardGameSmallSkillItemView.New(arg_4_0["upgradeSkillGo_" .. iter_4_1])
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.comfirmBtn_, nil, function()
		AnimatorTools.PlayAnimationWithCallback(arg_5_0.anim_, "Exit", function()
			arg_5_0:Back()

			if arg_5_0.params_.backCallBack then
				arg_5_0.params_.backCallBack()
			end

			if arg_5_0.selectedSkillItem_ and arg_5_0.selectedSkillItem_.skill_ and arg_5_0.selectedSkillItem_.skill_.mainBuffId then
				if BilliardGameMgr:OnMergeSkill(arg_5_0.selectedSkillItem_.skill_) then
					manager.notify:Invoke(BilliardGameEvent.SET_MERGE_AND_BALL_ACTIVE, false)
					JumpTools.OpenPageByJump("billiardGameMergeSuccessPopView", {
						skill = arg_5_0.selectedSkillItem_.skill_
					})
				end
			else
				manager.notify:Invoke(BilliardGameEvent.SET_MERGE_AND_BALL_ACTIVE, false)

				local var_7_0 = BilliardGameMgr:OnUpgradeRandomSkill()

				JumpTools.OpenPageByJump("billiardGameUpgradeSuccessPopView", {
					skillList = var_7_0
				})
			end
		end)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.mergeSkillList_ = BilliardGameMgr:FindAvailableMergeSkills()
	arg_8_0.selectedIndex_ = 1
	arg_8_0.selectedSkillItem_ = nil
	arg_8_0.selectedItem_ = nil

	arg_8_0.skillList_:StartScroll(#arg_8_0.mergeSkillList_)
	SetActive(arg_8_0.gameObject_, true)
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_0.mergeSkillList_[arg_9_1], arg_9_1)
	arg_9_2:RegisterClickEvent(handler(arg_9_0, arg_9_0.OnClickSkillItem))

	if arg_9_1 == arg_9_0.selectedIndex_ then
		arg_9_0:SelectSkillItem(arg_9_2)
	else
		arg_9_2:SetSelected(false)
	end
end

function var_0_0.RefreshItemTrack(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.skillList_:GetItemList()) do
		iter_10_1:RefreshTrackState()
	end
end

function var_0_0.OnClickSkillItem(arg_11_0, arg_11_1)
	if arg_11_0.selectedIndex_ == arg_11_1.index_ then
		return
	end

	if arg_11_0.selectedSkillItem_ then
		arg_11_0.selectedSkillItem_:SetSelected(false)
	end

	arg_11_0.selectedIndex_ = arg_11_1.index_

	arg_11_0.switchAnim_:Play("Panel_refresh")
	arg_11_0:SelectSkillItem(arg_11_1)
end

function var_0_0.SelectSkillItem(arg_12_0, arg_12_1)
	arg_12_0.selectedSkillItem_ = arg_12_1

	arg_12_0.selectedSkillItem_:SetSelected(true)

	if arg_12_1.skill_.mainBuffId == nil then
		arg_12_0:RefreshUpgradeSkill()
	elseif arg_12_1.skill_.isCombine_ then
		arg_12_0:RefreshCombineSkill(arg_12_1.skill_)
	else
		arg_12_0:RefreshSkill(arg_12_1.skill_)
	end
end

function var_0_0.RefreshUpgradeSkill(arg_13_0)
	arg_13_0.typeController_:SetSelectedState("upgrade")
	arg_13_0.bgController_:SetSelectedState("other")

	arg_13_0.upgradeSkillList_ = BilliardGameMgr:GetCanUpgradeSkillList()

	for iter_13_0 = 1, #arg_13_0.upgradeSkillItemList_ do
		if arg_13_0.upgradeSkillList_[iter_13_0] then
			SetActive(arg_13_0.upgradeSkillItemList_[iter_13_0].gameObject_, true)
			arg_13_0.upgradeSkillItemList_[iter_13_0]:SetSkillData(arg_13_0.upgradeSkillList_[iter_13_0])
		else
			SetActive(arg_13_0.upgradeSkillItemList_[iter_13_0].gameObject_, false)
		end
	end
end

function var_0_0.RefreshCombineSkill(arg_14_0, arg_14_1)
	arg_14_0.combineScroll_.verticalNormalizedPosition = 1

	local var_14_0 = MergeBallBuffCfg[arg_14_1.buffIdList[1]]
	local var_14_1 = MergeBallBuffCfg[arg_14_1.buffIdList[2]]

	arg_14_0.typeController_:SetSelectedState("combine")

	if var_14_0.type == BilliardGameConst.MergeBallBuffType.BASIC and var_14_1.type == BilliardGameConst.MergeBallBuffType.BASIC then
		arg_14_0.bgController_:SetSelectedState("basic")
	elseif var_14_0.type == BilliardGameConst.MergeBallBuffType.ULTIMATE or var_14_1.type == BilliardGameConst.MergeBallBuffType.ULTIMATE then
		arg_14_0.bgController_:SetSelectedState("ultimate")
	elseif var_14_0.type == BilliardGameConst.MergeBallBuffType.ADVANCE or var_14_1.type == BilliardGameConst.MergeBallBuffType.ADVANCE then
		arg_14_0.bgController_:SetSelectedState("advanced")
	else
		arg_14_0.typeController_:SetSelectedState("other")
	end

	arg_14_0.mainBuffItem_:SetSkillData(arg_14_1)

	local var_14_2 = {}

	for iter_14_0 = 1, #arg_14_1.buffIdList do
		local var_14_3 = MergeBallBuffCfg[arg_14_1.buffIdList[iter_14_0]]

		if arg_14_0.conbineTagTextList_[iter_14_0] then
			arg_14_0.conbineTagTextList_[iter_14_0].text = GetTips("MERGE_BALL_TAG_" .. var_14_3.tag[1])
		end

		if arg_14_0.conbineSkillItemList_[iter_14_0] then
			arg_14_0.conbineSkillItemList_[iter_14_0].buffItem:SetBuffData(arg_14_1.buffIdList[iter_14_0])

			arg_14_0.conbineSkillItemList_[iter_14_0].nameText_.text = var_14_3.name
			arg_14_0.conbineSkillItemList_[iter_14_0].descText_.text = string.format(var_14_3.desc, unpack(var_14_3.param_level[arg_14_1.level]))
		end

		table.insert(var_14_2, var_14_3)
	end

	if #var_14_2 == 1 then
		arg_14_0.nameText_.text = var_14_2[1].name
		arg_14_0.combineDesc_.text = ""
	elseif #var_14_2 == 2 then
		arg_14_0.nameText_.text = string.format("%s X %s", var_14_2[1].name, var_14_2[2].name)

		if var_14_2[1].merge_weight == var_14_2[2].merge_weight or var_14_2[1].merge_weight == 0 or var_14_2[2].merge_weight == 0 then
			arg_14_0.combineDesc_.text = GetTips("MERGE_BALL_COMBINE_TIP_BLANK")
		else
			arg_14_0.combineDesc_.text = string.format(GetTips("MERGE_BALL_COMBINE_TIP"), var_14_2[1].combine_text1, var_14_2[2].combine_text2)
		end
	end
end

function var_0_0.RefreshSkill(arg_15_0, arg_15_1)
	local var_15_0 = MergeBallBuffCfg[arg_15_1.mainBuffId]

	if var_15_0.type == BilliardGameConst.MergeBallBuffType.ULTIMATE then
		arg_15_0.typeController_:SetSelectedState("ultimate")
		arg_15_0.bgController_:SetSelectedState("ultimate")
	elseif var_15_0.type == BilliardGameConst.MergeBallBuffType.ADVANCE then
		arg_15_0.typeController_:SetSelectedState("advanced")
		arg_15_0.bgController_:SetSelectedState("advanced")
	elseif var_15_0.type == BilliardGameConst.MergeBallBuffType.EFFECT then
		arg_15_0.typeController_:SetSelectedState("effect")
		arg_15_0.bgController_:SetSelectedState("other")

		arg_15_0.effectImg_.sprite = pureGetSpriteWithoutAtlas(var_15_0.icon)
	else
		arg_15_0.typeController_:SetSelectedState("notFound")
		arg_15_0.bgController_:SetSelectedState("other")
	end

	arg_15_0.mainBuffItem_:SetBuffData(arg_15_1.mainBuffId, true)

	arg_15_0.nameText_.text = var_15_0.name
	arg_15_0.tagText_.text = GetTips("MERGE_BALL_TAG_" .. var_15_0.tag[1])
	arg_15_0.descText_.text = string.format(var_15_0.desc, unpack(var_15_0.param_level[1]))
end

function var_0_0.OnTop(arg_16_0)
	manager.windowBar:SwitchBar({})
	arg_16_0:RefreshItemTrack()
end

function var_0_0.OnExit(arg_17_0)
	if arg_17_0.selectedSkillItem_ then
		arg_17_0.selectedSkillItem_:SetSelected(false)
	end
end

function var_0_0.Dispose(arg_18_0)
	if arg_18_0.skillList_ then
		arg_18_0.skillList_:Dispose()
	end

	arg_18_0.skillList_ = nil

	arg_18_0.mainBuffItem_:Dispose()

	for iter_18_0 = 1, #arg_18_0.conbineSkillItemList_ do
		arg_18_0.conbineSkillItemList_[iter_18_0].buffItem:Dispose()
	end

	for iter_18_1 = 1, #arg_18_0.upgradeSkillItemList_ do
		arg_18_0.upgradeSkillItemList_[iter_18_1]:Dispose()
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0

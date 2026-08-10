local var_0_0 = class("BilliardGameSelectSkillCardItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.typeController_ = arg_3_0.transCon_:GetController("type")
	arg_3_0.tagController_ = arg_3_0.transCon_:GetController("buffTag")
	arg_3_0.connectController_ = arg_3_0.transCon_:GetController("connect")
	arg_3_0.smallBuffItem_ = BilliardGameSmallSkillItemView.New(arg_3_0.skillItemGo_)
	arg_3_0.connectSkillBuffList_ = {}

	for iter_3_0 = 1, 4 do
		arg_3_0.connectSkillBuffList_[iter_3_0] = BilliardGameSmallSkillItemView.New(arg_3_0["connectItemGo_" .. iter_3_0])
	end
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickCallback_ then
			arg_4_0.clickCallback_(arg_4_0.buffId_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.buffId_ = arg_6_1

	local var_6_0 = MergeBallBuffCfg[arg_6_1]

	arg_6_0.smallBuffItem_:SetBuffData(arg_6_1, true)
	arg_6_0:RefreshTrackState()

	local var_6_1 = BilliardGameMgr:GetSkillByMainBuffId(arg_6_1)
	local var_6_2 = var_6_1 and var_6_1.level + 1 or 1

	arg_6_0.smallBuffItem_:ForceShowStar(var_6_2)

	if var_6_1 and not var_6_1.isCombine_ then
		arg_6_0.smallBuffItem_:ShowStarBreathAnim(var_6_2, true)
	end

	arg_6_0:RefreshType(var_6_0)
	arg_6_0:RefreshConnectSkillBuff(var_6_0.relate)

	arg_6_0.nameText_.text = var_6_0.name
	arg_6_0.descText_.text = string.format(var_6_0.desc, unpack(var_6_0.param_level[var_6_2]))

	if var_6_0.tag[1] then
		arg_6_0.tagController_:SetSelectedState("show")

		arg_6_0.tagText_.text = GetTips("MERGE_BALL_TAG_" .. var_6_0.tag[1])
	else
		arg_6_0.tagController_:SetSelectedState("hide")
	end
end

function var_0_0.RefreshType(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.type

	if var_7_0 == BilliardGameConst.MergeBallBuffType.PASSIVE then
		arg_7_0.typeController_:SetSelectedState("passive")

		arg_7_0.tittleText_.text = GetTips("MERGE_BALL_MERGE_PASSIVE")
	elseif var_7_0 == BilliardGameConst.MergeBallBuffType.BASIC then
		arg_7_0.typeController_:SetSelectedState("activity_basic")

		arg_7_0.tittleText_.text = GetTips("MERGE_BALL_MERGE_BASIC")
	elseif var_7_0 == BilliardGameConst.MergeBallBuffType.ADVANCE then
		arg_7_0.typeController_:SetSelectedState("activity_advanced")

		arg_7_0.tittleText_.text = GetTips("MERGE_BALL_MERGE_ADVANCE")
	elseif var_7_0 == BilliardGameConst.MergeBallBuffType.ULTIMATE then
		arg_7_0.typeController_:SetSelectedState("activity_ultimate")

		arg_7_0.tittleText_.text = GetTips("MERGE_BALL_MERGE_ULT")
	elseif var_7_0 == BilliardGameConst.MergeBallBuffType.EFFECT then
		arg_7_0.typeController_:SetSelectedState("effect")

		arg_7_0.tittleText_.text = GetTips("MERGE_BALL_MERGE_EFFECT")
		arg_7_0.effectIconImg_.sprite = pureGetSpriteWithoutAtlas(arg_7_1.icon)
	end
end

function var_0_0.RefreshConnectSkillBuff(arg_8_0, arg_8_1)
	if arg_8_1 and #arg_8_1 > 0 then
		arg_8_0.connectController_:SetSelectedState("show")

		for iter_8_0 = 1, #arg_8_1 do
			SetActive(arg_8_0.connectSkillBuffList_[iter_8_0].gameObject_, true)
			arg_8_0.connectSkillBuffList_[iter_8_0]:SetBuffData(arg_8_1[iter_8_0])
			arg_8_0.connectSkillBuffList_[iter_8_0]:ShowBuffIsGet(BilliardGameMgr:GetIsSelectedBuff(arg_8_1[iter_8_0]))
			arg_8_0.connectSkillBuffList_[iter_8_0]:RegisterClick(function()
				manager.notify:Invoke(BilliardGameEvent.SET_CLICK_SKILL_ITEM, arg_8_0.connectSkillBuffList_[iter_8_0])
			end)
		end

		for iter_8_1 = #arg_8_1 + 1, 4 do
			SetActive(arg_8_0.connectSkillBuffList_[iter_8_1].gameObject_, false)
		end
	else
		arg_8_0.connectController_:SetSelectedState("hide")
	end
end

function var_0_0.RefreshTrackState(arg_10_0)
	arg_10_0.smallBuffItem_:CheckTrackState(arg_10_0.buffId_)
end

function var_0_0.RegisterClickListener(arg_11_0, arg_11_1)
	arg_11_0.clickCallback_ = arg_11_1
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.smallBuffItem_:Dispose()

	for iter_12_0 = 1, #arg_12_0.connectSkillBuffList_ do
		arg_12_0.connectSkillBuffList_[iter_12_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0

local var_0_0 = class("StrongholdOperateSkillPage", StrongholdOperateBasePage)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.hander_ = arg_1_1

	local var_1_0 = Asset.Load("UI/VersionUI/XuHeng3rdUI/Stronghold/Operate/StrongholdIncreaseUI")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:Refresh()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.node_list = {}

	local var_4_0 = ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		local var_4_1 = arg_4_0.m_nodes:Find(tostring(iter_4_0))
		local var_4_2 = StrongholdOperateIncreaseItem.New(var_4_1, iter_4_0)

		var_4_2:RegistCallBack(handler(arg_4_0, arg_4_0.SetSelectNode))

		arg_4_0.node_list[iter_4_0] = var_4_2
	end

	arg_4_0.stateConotroller = ControllerUtil.GetController(arg_4_0.transform_, "state")
	arg_4_0.showConotroller = ControllerUtil.GetController(arg_4_0.transform_, "show")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_unlockBtn, nil, function()
		if arg_5_0.curNodeId == nil then
			return
		end

		StrongholdAction.QueryUpgradeIncrease(arg_5_0.activity_id, arg_5_0.curNodeId)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_upgradeBtn, nil, function()
		if arg_5_0.curNodeId == nil then
			return
		end

		StrongholdAction.QueryUpgradeIncrease(arg_5_0.activity_id, arg_5_0.curNodeId)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_mask, nil, function()
		arg_5_0:SetSelectNode(nil)
	end)
end

function var_0_0.Refresh(arg_9_0, arg_9_1)
	arg_9_0.activity_id = arg_9_1

	arg_9_0:SetSelectNode(nil, false)
	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.all_level, arg_10_0.all_poit = StrongholdData:GetStrongholdLevelAndIncreasePoint(arg_10_0.activity_id)
	arg_10_0.m_allLvLab.text = arg_10_0.all_level
	arg_10_0.use_point = StrongholdData:GetUsePoint(arg_10_0.activity_id)

	local var_10_0 = arg_10_0.all_poit - arg_10_0.use_point

	arg_10_0.m_point.text = string.format(GetTips("ACTIVITY_STRONGHOLD_POINT_LEFT"), var_10_0)

	for iter_10_0, iter_10_1 in pairs(arg_10_0.node_list) do
		local var_10_1 = StrongholdData:GetIncreaseLevel(arg_10_0.activity_id, iter_10_1.node_id)

		iter_10_1:Refresh(var_10_1, var_10_0)
	end
end

function var_0_0.SetSelectNode(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.curNodeId = arg_11_1

	for iter_11_0, iter_11_1 in pairs(arg_11_0.node_list) do
		iter_11_1:SetSelect(arg_11_0.curNodeId)
	end

	if arg_11_0.curNodeId == nil then
		arg_11_0.showConotroller:SetSelectedIndex(0)

		arg_11_0.m_scrollCom.movementType = ScrollRect.MovementType.Elastic

		arg_11_0:RemoveTween()

		return
	end

	local var_11_0 = arg_11_3.transform_:TransformPoint(Vector3(0, 0, 0))
	local var_11_1 = arg_11_0.m_scrollContent.transform:InverseTransformPoint(var_11_0)
	local var_11_2 = Vector3.New(-var_11_1.x, 0, 0)

	arg_11_0:RemoveTween()

	arg_11_0.tween_ = LeanTween.moveLocal(arg_11_0.m_scrollContent.gameObject, var_11_2, 0.2)
	arg_11_0.m_scrollCom.movementType = ScrollRect.MovementType.Unrestricted

	arg_11_0.showConotroller:SetSelectedIndex(1)
	arg_11_0:RefreshRightInfo()

	if arg_11_2 then
		arg_11_0.m_animator:Play("Fx_messagebg_cx_01", 0, 0)
	end
end

function var_0_0.RefreshRightInfo(arg_12_0)
	local var_12_0 = ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[arg_12_0.curNodeId]
	local var_12_1 = StrongholdData:GetIncreaseLevel(arg_12_0.activity_id, arg_12_0.curNodeId)

	if var_12_1 == 0 then
		arg_12_0.stateConotroller:SetSelectedIndex(0)

		local var_12_2 = var_12_0[1]
		local var_12_3 = ActivityStrongholdIncreaseCfg[var_12_2]

		arg_12_0.m_name.text = var_12_3.skill_name
		arg_12_0.m_des.text = arg_12_0:GetSkillDes(var_12_3)
		arg_12_0.m_lvLab.text = "Lv" .. var_12_3.skill_level
		arg_12_0.m_nextLvDes.text = ""
		arg_12_0.m_costLab.text = string.format(GetTips("ACTIVITY_STRONGHOLD_POINT_COST"), var_12_3.cost)
		arg_12_0.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdIncrease/" .. var_12_3.skill_id)
	elseif var_12_1 >= #var_12_0 then
		arg_12_0.stateConotroller:SetSelectedIndex(2)

		local var_12_4 = var_12_0[#var_12_0]
		local var_12_5 = ActivityStrongholdIncreaseCfg[var_12_4]

		arg_12_0.m_name.text = var_12_5.skill_name
		arg_12_0.m_des.text = arg_12_0:GetSkillDes(var_12_5)
		arg_12_0.m_lvLab.text = GetTips("ACTIVITY_STRONGHOLD_SKILL_MAX")
		arg_12_0.m_nextLvDes.text = ""
		arg_12_0.m_costLab.text = ""
		arg_12_0.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdIncrease/" .. var_12_5.skill_id)
	else
		arg_12_0.stateConotroller:SetSelectedIndex(1)

		local var_12_6 = var_12_0[var_12_1]
		local var_12_7 = var_12_0[var_12_1 + 1]
		local var_12_8 = ActivityStrongholdIncreaseCfg[var_12_6]
		local var_12_9 = ActivityStrongholdIncreaseCfg[var_12_7]

		arg_12_0.m_name.text = var_12_8.skill_name
		arg_12_0.m_des.text = arg_12_0:GetSkillDes(var_12_8)
		arg_12_0.m_lvLab.text = "Lv" .. var_12_8.skill_level
		arg_12_0.m_nextLvDes.text = string.format(GetTips("ACTIVITY_STRONGHOLD_INCREASE_NEXT_LV"), "", arg_12_0:GetSkillDes(var_12_9))
		arg_12_0.m_costLab.text = string.format(GetTips("ACTIVITY_STRONGHOLD_POINT_COST"), var_12_9.cost)
		arg_12_0.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdIncrease/" .. var_12_8.skill_id)
	end
end

function var_0_0.RemoveTween(arg_13_0)
	if arg_13_0.tween_ then
		arg_13_0.tween_:setOnUpdate(nil)
		LeanTween.cancel(arg_13_0.m_scrollContent)

		arg_13_0.tween_ = nil
	end
end

function var_0_0.GetSkillDes(arg_14_0, arg_14_1)
	if arg_14_1.effect_type == 1 then
		return getAffixDesc(arg_14_1.effect_params)
	elseif arg_14_1.effect_type == 2 then
		return string.format(GetTips("ACTIVITY_STRONGHOLD_INCREASE_REVIVAL"), arg_14_1.effect_params[1])
	else
		rteurn("")
	end
end

function var_0_0.Dispose(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.node_list) do
		iter_15_1:Dispose()
	end

	arg_15_0:RemoveTween()

	arg_15_0.node_list = {}

	var_0_0.super.Dispose(arg_15_0)
end

function var_0_0.OnStrongholdUpgradeIncrease(arg_16_0)
	arg_16_0:RefreshUI()
	arg_16_0:RefreshRightInfo()
end

return var_0_0

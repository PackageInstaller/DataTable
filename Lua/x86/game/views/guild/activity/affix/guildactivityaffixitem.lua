local var_0_0 = class("GuildActivityAffixItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1.gameObject
	arg_1_0.transform_ = arg_1_1

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.transform_, "select")
	arg_3_0.unlockController_ = ControllerUtil.GetController(arg_3_0.transform_, "unlock")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.Btn_, nil, function()
		if arg_4_0.selectCallBack_ then
			arg_4_0.selectCallBack_(arg_4_0.affixID_, arg_4_0.level_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_0.affixID_ == nil then
		local var_6_0 = TalentTreeCfg[arg_6_1].activity_id

		manager.redPoint:bindUIandKey(arg_6_0.transform_, string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, var_6_0, TalentTreeCfg[arg_6_1].race, arg_6_1))
	elseif arg_6_0.affixID_ ~= arg_6_1 then
		local var_6_1 = TalentTreeCfg[arg_6_0.affixID_].activity_id
		local var_6_2 = string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, var_6_1, TalentTreeCfg[arg_6_0.affixID_].race, arg_6_0.affixID_)

		manager.redPoint:unbindUIandKey(arg_6_0.transform_, var_6_2)

		local var_6_3 = TalentTreeCfg[arg_6_1].activity_id
		local var_6_4 = string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, var_6_3, TalentTreeCfg[arg_6_1].race, arg_6_1)

		manager.redPoint:bindUIandKey(arg_6_0.transform_, var_6_4)
	end

	arg_6_0.affixID_ = arg_6_1
	arg_6_0.unlock_ = arg_6_2
	arg_6_0.level_ = arg_6_3

	arg_6_0.unlockController_:SetSelectedState(tostring(arg_6_2))

	if arg_6_2 then
		arg_6_0.levelText_.text = GetTips("LEVEL") .. arg_6_3
	end

	local var_6_5 = TalentTreeCfg[arg_6_1].affix_id

	arg_6_0.nameText_.text = GetI18NText(AffixTypeCfg[var_6_5].name)
end

function var_0_0.SetSelectCallBack(arg_7_0, arg_7_1)
	arg_7_0.selectCallBack_ = arg_7_1
end

function var_0_0.SetSelect(arg_8_0, arg_8_1)
	arg_8_0.selectController_:SetSelectedState(tostring(arg_8_0.affixID_ == arg_8_1))
end

function var_0_0.Dispose(arg_9_0)
	local var_9_0 = TalentTreeCfg[arg_9_0.affixID_].activity_id

	manager.redPoint:unbindUIandKey(arg_9_0.transform_, string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, var_9_0, TalentTreeCfg[arg_9_0.affixID_].race, arg_9_0.affixID_))

	arg_9_0.gameObject_ = nil
	arg_9_0.transform_ = nil
	arg_9_0.selectCallBack_ = nil

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.SetActive(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)
end

return var_0_0

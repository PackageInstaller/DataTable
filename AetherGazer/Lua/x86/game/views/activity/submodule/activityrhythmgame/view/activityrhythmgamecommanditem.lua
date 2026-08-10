local var_0_0 = class("ActivityRhythmGameCommandItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.iconController_ = arg_2_0.controllerEx_:GetController("icon")

	arg_2_0:AddUIListener()
end

function var_0_0.InitOwnData(arg_3_0)
	arg_3_0.index_ = -1
	arg_3_0.cfgID_ = -1
	arg_3_0.activityID_ = -1
	arg_3_0.cfg_ = {}
end

function var_0_0.OnExit(arg_4_0)
	AtlasManager.UnloadSprite("Atlas/Summer2024Atlas", arg_4_0.cfg_.pitcture_path)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.battleBtn_, nil, function()
		arg_6_0:StartBattle()
	end)
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.index_ = arg_8_1
	arg_8_0.cfgID_ = arg_8_2
	arg_8_0.cfg_ = ActivityRhythmGameCommandCfg[arg_8_0.cfgID_]
	arg_8_0.activityID_ = arg_8_3

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = false

	if arg_9_0.cfg_.stage_id ~= 0 then
		var_9_0 = true
	end

	SetActive(arg_9_0.battleGo_, var_9_0)

	if arg_9_0.index_ == 1 or arg_9_0.index_ == 5 then
		arg_9_0.iconController_:SetSelectedIndex(3)
		SetActive(arg_9_0.messageTextGo_, false)
	else
		arg_9_0.iconController_:SetSelectedIndex(arg_9_0.index_ - 2)
		SetActive(arg_9_0.messageTextGo_, true)
	end

	arg_9_0.typeImg_.sprite = getSprite("Atlas/Summer2024Atlas", arg_9_0.cfg_.pitcture_path)
	arg_9_0.nameText_.text = arg_9_0.cfg_.name
	arg_9_0.descText_.text = arg_9_0.cfg_.desc
end

function var_0_0.StartBattle(arg_10_0)
	ActivityRhythmGameTools.StartBattle(arg_10_0.cfg_.stage_id, arg_10_0.cfg_.stage_id, arg_10_0.activityID_)
end

return var_0_0

local var_0_0 = class("SkuldSystemStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index_ = arg_1_2
	arg_1_0.levelID_ = arg_1_3
	arg_1_0.cfg_ = SkuldStageCfg[arg_1_0.levelID_]
	arg_1_0.selectHandler_ = arg_1_4

	arg_1_0:Init()
	arg_1_0:RefreshUI()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.lockController_ = arg_3_0.controllerEx_:GetController("lock")
	arg_3_0.typeController_ = arg_3_0.controllerEx_:GetController("type")
	arg_3_0.selectController_ = arg_3_0.controllerEx_:GetController("select")
	arg_3_0.completeController_ = arg_3_0.controllerEx_:GetController("complete")
end

function var_0_0.RefreshUI(arg_4_0)
	arg_4_0.levelNameText_.text = arg_4_0.cfg_.name

	if SkuldSystemData:GetLevelIDIsOpen(arg_4_0.levelID_) then
		arg_4_0.lockController_:SetSelectedState("false")
	else
		arg_4_0.lockController_:SetSelectedState("true")
	end

	if SkuldSystemData:GetLevelIDIsClear(arg_4_0.levelID_) then
		arg_4_0.completeController_:SetSelectedState("true")
	else
		arg_4_0.completeController_:SetSelectedState("false")
	end

	if arg_4_0.cfg_.type[1] == 1 then
		arg_4_0.typeController_:SetSelectedState("plot")
	elseif arg_4_0.cfg_.type[1] == 2 then
		arg_4_0.typeController_:SetSelectedState("schedule")
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		if arg_5_0.selectHandler_ then
			arg_5_0.selectHandler_(arg_5_0.index_, arg_5_0.levelID_)
		end

		JumpTools.OpenPageByJump("skuldSystemStageSectionView", {
			levelID = arg_5_0.levelID_,
			battleType = BattleConst.STAGE_TYPE_NEW.SKULD
		})
	end)
end

function var_0_0.RefreshSelect(arg_7_0, arg_7_1)
	if arg_7_0.levelID_ == arg_7_1 then
		arg_7_0.selectController_:SetSelectedState("true")
	else
		arg_7_0.selectController_:SetSelectedState("false")
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0

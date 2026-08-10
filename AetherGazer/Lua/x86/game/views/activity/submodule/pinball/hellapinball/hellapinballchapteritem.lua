local var_0_0 = class("HellaPinballChapterItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selectController_ = arg_2_0.controllerEx_:GetController("select")
	arg_2_0.bossController_ = arg_2_0.controllerEx_:GetController("boss")
	arg_2_0.lockController_ = arg_2_0.controllerEx_:GetController("lock")

	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.clickCallBack_ and PinballData:GetStageUnlocked(arg_3_0.id_) then
			arg_3_0.clickCallBack_(arg_3_0.index_)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.index_ = arg_5_1
	arg_5_0.id_ = arg_5_2

	local var_5_0 = PinballStageCfg[arg_5_2]

	if var_5_0 then
		arg_5_0.text_.text = var_5_0.name
		arg_5_0.isBossStage_, arg_5_0.bossType_ = PinballData:IsBossStage(arg_5_0.id_)

		if not arg_5_0.isBossStage_ then
			arg_5_0.bossController_:SetSelectedState("normal")
		elseif arg_5_0.bossType_ == 4 then
			arg_5_0.bossController_:SetSelectedState("boss2")
		else
			arg_5_0.bossController_:SetSelectedState("boss")
		end
	end

	arg_5_0.lockController_:SetSelectedState(not PinballData:GetStageUnlocked(arg_5_0.id_) and "on" or "off")
end

function var_0_0.SetSelect(arg_6_0, arg_6_1)
	arg_6_0.selectController_:SetSelectedState(arg_6_1 and "on" or "off")
end

function var_0_0.SetClickCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickCallBack_ = arg_7_1
end

return var_0_0

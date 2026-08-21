local var_0_0 = class("BilliardGameBigBuffItemView", ReduxView)

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

	arg_3_0.connectController_ = arg_3_0.skillCon_:GetController("buffConnect")
	arg_3_0.nameController_ = arg_3_0.skillCon_:GetController("skillName")
	arg_3_0.connectSkillBuffList_ = {}

	for iter_3_0 = 1, 4 do
		arg_3_0.connectSkillBuffList_[iter_3_0] = BilliardGameSmallSkillItemView.New(arg_3_0["containSkillGo_" .. iter_3_0])
	end
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = MergeBallBuffCfg[arg_5_1]
	local var_5_1 = VehicleBallData:IsBuffUnlocked(arg_5_1)

	arg_5_0.nameText_.text = var_5_1 and var_5_0.name or "???"
	arg_5_0.descText_.text = var_5_1 and string.format(var_5_0.desc, unpack(var_5_0.param_level[arg_5_2])) or "???"

	if not arg_5_3 and var_5_0.relate and #var_5_0.relate > 0 then
		arg_5_0.connectController_:SetSelectedState("show")

		for iter_5_0, iter_5_1 in ipairs(var_5_0.relate) do
			SetActive(arg_5_0.connectSkillBuffList_[iter_5_0].gameObject_, true)
			arg_5_0.connectSkillBuffList_[iter_5_0]:SetBuffData(iter_5_1)
		end

		for iter_5_2 = #var_5_0.relate + 1, 4 do
			SetActive(arg_5_0.connectSkillBuffList_[iter_5_2].gameObject_, false)
		end
	else
		arg_5_0.connectController_:SetSelectedState("hide")
	end
end

function var_0_0.IsShowName(arg_6_0, arg_6_1)
	SetActive(arg_6_0.nameText_.gameObject, arg_6_1)
end

function var_0_0.Dispose(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.connectSkillBuffList_) do
		iter_7_1:Dispose()
	end

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0

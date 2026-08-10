local var_0_0 = class("StrongholdOperateSkillPage", StrongholdOperateBasePage)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.hander_ = arg_1_1

	local var_1_0 = Asset.Load("UI/VersionUI/XuHeng3rdUI/Stronghold/Operate/StrongholdSkillUI")

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

	arg_3_0.items = {}

	for iter_3_0 = 1, 3 do
		local var_3_0 = arg_3_0["m_skill" .. iter_3_0]
		local var_3_1 = StrongholdOperateSkillItem.New(var_3_0, iter_3_0)

		table.insert(arg_3_0.items, var_3_1)
	end
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.Refresh(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.items) do
		iter_6_1:RefreshUI()
	end
end

function var_0_0.Dispose(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.items) do
		iter_7_1:Dispose()
	end

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0

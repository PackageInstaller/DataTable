local var_0_0 = import("manager.tips.TipsLongView")
local var_0_1 = class("TipsMgr")

function var_0_1.Ctor(arg_1_0)
	arg_1_0.gameObject_ = nil
end

function var_0_1.OnCtor(arg_2_0)
	print("initializing tip manager...")
end

function var_0_1.InitUI(arg_3_0)
	local var_3_0 = GameObject.Find("UICamera_DontDestroy/Canvas/UITip")

	arg_3_0.gameObject_ = GameObject.Instantiate(Asset.Load("UI/TipPanel"), var_3_0.transform)
	arg_3_0.transform_ = arg_3_0.gameObject_.transform
	arg_3_0.longTips_ = var_0_0.New(arg_3_0.gameObject_)
end

function var_0_1.ShowTips(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0.gameObject_ == nil then
		arg_4_0:InitUI()
	end

	if TipsCfg[arg_4_2] then
		arg_4_0.longTips_:ShowTips(arg_4_1)
		manager.audio:PlayEffect("ui_system", TipsCfg[arg_4_2].audio, "")
	else
		arg_4_0.longTips_:ShowTips(arg_4_1)
		manager.audio:PlayEffect("ui_system", "success", "")
	end
end

function var_0_1.Show(arg_5_0, arg_5_1)
	if arg_5_0.gameObject_ then
		SetActive(arg_5_0.gameObject_, arg_5_1)
	end
end

function var_0_1.Dispose(arg_6_0)
	if arg_6_0.longTips_ then
		arg_6_0.longTips_:Dispose()

		arg_6_0.longTips_ = nil
	end

	if arg_6_0.gameObject_ then
		Object.Destroy(arg_6_0.gameObject_)

		arg_6_0.transform_ = nil
		arg_6_0.gameObject_ = nil
	end
end

return var_0_1

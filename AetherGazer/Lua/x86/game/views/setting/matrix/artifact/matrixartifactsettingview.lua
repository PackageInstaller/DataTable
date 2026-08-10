local var_0_0 = class("MatrixArtifactSettingView", ReduxView)

function var_0_0.SetActive(arg_1_0, arg_1_1)
	if arg_1_0.gameObject_ then
		SetActive(arg_1_0.gameObject_, arg_1_1)
	end
end

function var_0_0.OnCtor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.gameObject_ = arg_2_2
	arg_2_0.transform_ = arg_2_2.transform
	arg_2_0.settingView_ = arg_2_1
	arg_2_0.artifactList_ = arg_2_3

	arg_2_0:Init()
	arg_2_0:OnEnter()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.ItemRenderers), arg_4_0.uiListGo_, MatrixArtifactSettingItemView)

	arg_4_0.uiList_:StartScroll(#arg_4_0.artifactList_)
end

function var_0_0.ItemRenderers(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.artifactList_[arg_5_1]

	arg_5_2:SetData(var_5_0.id)
end

function var_0_0.Dispose(arg_6_0)
	if arg_6_0.uiList_ then
		arg_6_0.uiList_:Dispose()

		arg_6_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.transform_ = nil
	arg_6_0.gameObject_ = nil
end

return var_0_0

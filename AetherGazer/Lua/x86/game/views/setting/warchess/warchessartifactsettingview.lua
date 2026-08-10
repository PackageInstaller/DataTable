local var_0_0 = class("WarChessArtifactSettingView", MatrixArtifactSettingView)

function var_0_0.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.uiList_ = LuaList.New(handler(arg_1_0, arg_1_0.ItemRenderers), arg_1_0.uiListGo_, WarChessArtifactSettingItemView)

	arg_1_0.uiList_:StartScroll(#arg_1_0.artifactList_)
end

return var_0_0

local var_0_0 = class("ActivitySkinDrawDLCItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = arg_3_0.controller_:GetController("select")
	arg_3_0.getController_ = arg_3_0.controller_:GetController("get")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickHandler_ then
			arg_4_0.clickHandler_(arg_4_0.index_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.index_ = arg_6_1
	arg_6_0.dlcId_ = arg_6_2

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = HomeSceneBundleCfg[arg_7_0.dlcId_].item_id
	local var_7_1 = ItemTools.getItemNum(var_7_0) > 0

	arg_7_0.getController_:SetSelectedState(var_7_1 and "get" or "none")

	arg_7_0.icon_.sprite = pureGetSpriteWithoutAtlas(HomeSceneBundleCfg[arg_7_0.dlcId_].icon)
end

function var_0_0.SetSelected(arg_8_0, arg_8_1)
	arg_8_0.selectController_:SetSelectedState(arg_8_1 and "select" or "unselect")
end

function var_0_0.RegisterClickCallBack(arg_9_0, arg_9_1)
	arg_9_0.clickHandler_ = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0

local var_0_0 = class("SuitSelectItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:Init()
end

function var_0_0.RefreshData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.info_ = arg_2_2

	arg_2_0:Render()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddBtnListener(arg_3_0.itemBtn_, nil, "OnClick")
end

function var_0_0.Render(arg_4_0)
	arg_4_0:RefreshUI(arg_4_0.info_)
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0.iconImg_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.EquipIcon_s.path .. arg_5_1.id)
	end
end

function var_0_0.TurnToStart(arg_6_0)
	arg_6_0.bgImg_.color = Color.New(1, 1, 1, 1)
	arg_6_0.iconImg_.color = Color.New(1, 1, 1, 1)
end

function var_0_0.ShowSelect(arg_7_0, arg_7_1)
	SetActive(arg_7_0.selectGo_, arg_7_1)
end

function var_0_0.ShowCurrentUp(arg_8_0, arg_8_1)
	SetActive(arg_8_0.currentGo_, arg_8_1)
end

function var_0_0.OnClick(arg_9_0)
	if arg_9_0.clickFunc then
		arg_9_0.clickFunc(arg_9_0.info_)
	end
end

function var_0_0.RegistCallBack(arg_10_0, arg_10_1)
	arg_10_0.clickFunc = arg_10_1
end

function var_0_0.GetItemInfo(arg_11_0)
	return arg_11_0.info_
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.clickFunc = nil

	arg_12_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0

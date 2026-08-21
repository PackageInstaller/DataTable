local var_0_0 = class("DormIlluBasePage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.itemGo_ = arg_1_2

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.uiList = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.uiListGo_, arg_2_0:ItemClass())
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.SetActive(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)

	if arg_4_1 then
		arg_4_0:OnShow()
	else
		arg_4_0:OnHide()
	end
end

function var_0_0.OnShow(arg_5_0)
	return
end

function var_0_0.OnHide(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.ItemClass(arg_9_0)
	return nil
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1, arg_10_0.cardDataList_[arg_10_1])
end

return var_0_0

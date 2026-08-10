local var_0_0 = class("MatrixHeroEquipPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.list_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.m_list, MatrixHeroEquipItem)
end

function var_0_0.SetMatirxHeroInfo(arg_4_0, arg_4_1)
	arg_4_0.heroId_ = arg_4_1
	arg_4_0.equipListData_ = arg_4_0:GetHeroData(arg_4_1):GetEquipList()

	arg_4_0:UpdateView()
end

function var_0_0.UpdateView(arg_5_0)
	local var_5_0 = #arg_5_0.equipListData_

	arg_5_0.list_:StartScroll(var_5_0)

	local var_5_1 = arg_5_0:GetHeroEquipMaxCount()

	arg_5_0.m_countLab.text = var_5_0 .. "/" .. var_5_1
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.equipListData_[arg_6_1]

	arg_6_2:Refresh(var_6_0)
end

function var_0_0.Hide(arg_7_0)
	SetActive(arg_7_0.gameObject_, false)
end

function var_0_0.Show(arg_8_0)
	SetActive(arg_8_0.gameObject_, true)
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()

	arg_9_0.handler_ = nil

	arg_9_0.list_:Dispose()
	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.GetHeroData(arg_10_0, arg_10_1)
	return MatrixData:GetHeroData(arg_10_1)
end

function var_0_0.GetHeroEquipMaxCount(arg_11_0)
	return MatrixData:GetHeroEquipMaxCount()
end

return var_0_0

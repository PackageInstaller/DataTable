local var_0_0 = import("game.views.newHero.HeroPageBase")
local var_0_1 = class("MatrixHeroEquipNewPage", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.list_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.m_list, MatrixHeroEquipItem)
end

function var_0_1.OnEnter(arg_4_0, arg_4_1)
	arg_4_0.heroViewProxy_ = arg_4_1
end

function var_0_1.SetHeroInfo(arg_5_0, arg_5_1)
	arg_5_0.heroInfo_ = arg_5_1
	arg_5_0.equipListData_ = StrategyMatrixData:GetEquipDataListNew(arg_5_1.id)
end

function var_0_1.UpdateView(arg_6_0)
	local var_6_0 = #arg_6_0.equipListData_

	arg_6_0.list_:StartScroll(var_6_0)

	local var_6_1 = arg_6_0:GetHeroEquipMaxCount()

	arg_6_0.m_countLab.text = var_6_0 .. "/" .. var_6_1
end

function var_0_1.indexItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.equipListData_[arg_7_1]

	arg_7_2:Refresh(var_7_0)
end

function var_0_1.CameraEnter(arg_8_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		4,
		0
	})
end

function var_0_1.Show(arg_9_0)
	SetActive(arg_9_0.gameObject_, true)
	arg_9_0:UpdateView()
end

function var_0_1.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()

	arg_10_0.handler_ = nil

	arg_10_0.list_:Dispose()
	var_0_1.super.Dispose(arg_10_0)
end

function var_0_1.OnExit(arg_11_0)
	return
end

function var_0_1.GetHeroEquipMaxCount(arg_12_0)
	return StrategyMatrixData:GetHeroEquipMaxCount()
end

return var_0_1

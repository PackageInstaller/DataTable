local var_0_0 = import("game.views.newHero.HeroPageBase")
local var_0_1 = class("StrategyMatrixTreasurePage", var_0_0)

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

	arg_3_0.list_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.m_list, MatrixTreasureAtlasItem)
end

function var_0_1.OnEnter(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.heroViewProxy_ = arg_4_1
	arg_4_0.isHided = true
	arg_4_0.params_ = arg_4_2

	arg_4_0:UpdateView()
end

function var_0_1.UpdateView(arg_5_0)
	arg_5_0:SetMatirxHeroInfo(arg_5_0.params_.matrix_activity_id)
end

function var_0_1.CameraEnter(arg_6_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		4,
		0
	})
end

function var_0_1.SetMatirxHeroInfo(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.matrix_activity_id = arg_7_1
	arg_7_0.data = arg_7_0:GetArtifactList()

	table.sort(arg_7_0.data, function(arg_8_0, arg_8_1)
		local var_8_0 = MatrixItemCfg[arg_8_0.id]
		local var_8_1 = MatrixItemCfg[arg_8_1.id]

		if var_8_0.rare ~= var_8_1.rare then
			return var_8_0.rare > var_8_1.rare
		end

		return arg_8_0.id < arg_8_1.id
	end)

	local var_7_0 = #arg_7_0.data

	arg_7_0.list_:StartScroll(var_7_0)
end

function var_0_1.indexItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.data[arg_9_1].id
	local var_9_1 = arg_9_0.data[arg_9_1].wins

	arg_9_2:Refresh(var_9_0, var_9_1)
end

function var_0_1.Hide(arg_10_0)
	SetActive(arg_10_0.gameObject_, false)
end

function var_0_1.Show(arg_11_0)
	SetActive(arg_11_0.gameObject_, true)
end

function var_0_1.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()

	arg_12_0.handler_ = nil

	arg_12_0.list_:Dispose()
	var_0_1.super.Dispose(arg_12_0)
end

function var_0_1.GetArtifactList(arg_13_0)
	return StrategyMatrixData:GetArtifactList(arg_13_0.matrix_activity_id)
end

return var_0_1

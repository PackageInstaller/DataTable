local var_0_0 = class("AbyssTeamCheckItemView", ReduxView)

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

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.uiListGo_, AbyssTeamCheckHeroItemView)
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, arg_4_0.userId_, arg_4_0.heroInfoList_[arg_4_1])
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.index_ = arg_7_1
	arg_7_0.layerId_ = arg_7_2
	arg_7_0.userId_ = arg_7_3
	arg_7_0.stageRankInfo_ = arg_7_4
	arg_7_0.stageId_ = arg_7_4.stage_id
	arg_7_0.heroInfoList_ = arg_7_4.heroList

	arg_7_0:UpdateView()
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0.nameText_.text = GetI18NText(BattleAbyssCfg[arg_8_0.stageId_].name or "关卡" .. arg_8_0.index_)

	arg_8_0.uiList_:StartScroll(#arg_8_0.heroInfoList_)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:AddEventListeners()
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.data_ = nil

	if arg_12_0.uiList_ then
		arg_12_0.uiList_:Dispose()

		arg_12_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0

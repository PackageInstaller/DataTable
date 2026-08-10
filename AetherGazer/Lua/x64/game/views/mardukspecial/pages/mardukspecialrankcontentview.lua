local var_0_0 = class("MardukSpecialRankContentView", ReduxView)

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

	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.listGo_, MardukSpecialRankItemView)
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, arg_4_0.data_.rankList[arg_4_1])
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.activityId_ = activityId
	arg_7_0.battleId_ = arg_7_1
	arg_7_0.battleCfg_ = BattleQuickTrainingCfg[arg_7_1]
	arg_7_0.data_ = RankData:GetActivityRank(arg_7_2)

	arg_7_0:UpdateView()
end

function var_0_0.SetMySelfData(arg_8_0, arg_8_1)
	local var_8_0 = PlayerData:GetPlayerInfo()

	arg_8_0.frame_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. var_8_0.icon_frame)
	arg_8_0.name_.text = GetI18NText(var_8_0.nick)
	arg_8_0.icon_.sprite = ItemTools.getItemSprite(var_8_0 and var_8_0.portrait)
	arg_8_0.battleId_ = arg_8_1
	arg_8_0.battleCfg_ = BattleQuickTrainingCfg[arg_8_1]
	arg_8_0.rankNameLabel_.text = arg_8_0.battleCfg_.name
end

function var_0_0.UpdateView(arg_9_0)
	if not arg_9_0.data_ then
		return
	end

	arg_9_0.uiList_:StartScroll(#arg_9_0.data_.rankList)

	local var_9_0 = arg_9_0.data_.myRank

	if var_9_0 and var_9_0.score > 0 then
		local var_9_1 = var_9_0.score
		local var_9_2 = var_9_0.rank

		if var_9_2 >= 1 and var_9_2 <= 100 then
			arg_9_0.rank_.text = var_9_2
			arg_9_0.score_.text = var_9_1
		else
			local var_9_3 = var_9_2 / (arg_9_0.data_.total or 1) * 100

			arg_9_0.rank_.text = string.format("%.2f", var_9_3) .. "%"
			arg_9_0.score_.text = var_9_1
		end
	else
		arg_9_0.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
		arg_9_0.score_.text = GetTips("MATRIX_RANK_NO_INFO")
	end
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:AddEventListeners()
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.data_ = nil

	if arg_13_0.uiList_ then
		arg_13_0.uiList_:Dispose()

		arg_13_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0

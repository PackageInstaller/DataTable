local var_0_0 = class("RoguelikeRankItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.gameObject_:InjectUI(arg_2_0)

	arg_2_0.commonPortrait_ = CommonHeadPortrait.New(arg_2_0.GoHeadItem)

	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	return
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.AddEventListeners(arg_5_0)
	return
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.index = arg_6_1
	arg_6_0.data = arg_6_2
	arg_6_0.isGuild = arg_6_3

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	local var_7_0 = arg_7_0.data:GetSingleSelectHeroList()
	local var_7_1 = var_7_0[1].skin_id

	if var_7_1 == 0 then
		var_7_1 = var_7_0[1].hero_id
	end

	arg_7_0.commonPortrait_:RenderHead(arg_7_0.data.portrait)
	arg_7_0.commonPortrait_:RenderFrame(arg_7_0.data.frame)

	arg_7_0.ImgRole.sprite = ItemTools.getItemSprite(var_7_1)

	if arg_7_0.data.rank < 4 then
		arg_7_0.CtrlRank:SetSelectedIndex(arg_7_0.data.rank)
	else
		arg_7_0.CtrlRank:SetSelectedIndex(0)
	end

	arg_7_0.TxtRank.text = arg_7_0.data.rank
	arg_7_0.TxtNick.text = arg_7_0.data.nick
	arg_7_0.TxtScore.text = arg_7_0.data.score
	arg_7_0.TxtDifficulty.text = arg_7_0.data.difficulty
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:AddEventListeners()
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.commonPortrait_:Dispose()

	arg_11_0.data = nil

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0

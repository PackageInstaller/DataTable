local var_0_0 = class("AbyssTeamCheckHeroItemView", ReduxView)

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
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		return
	end)
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.index_ = arg_7_1
	arg_7_0.userId_ = arg_7_2
	arg_7_0.heroInfo_ = arg_7_3

	arg_7_0:UpdateView()
end

function var_0_0.UpdateView(arg_8_0)
	local var_8_0 = arg_8_0.heroInfo_.skin_id

	if var_8_0 == 0 then
		var_8_0 = arg_8_0.heroInfo_.hero_id
	end

	arg_8_0.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. var_8_0)
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

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0

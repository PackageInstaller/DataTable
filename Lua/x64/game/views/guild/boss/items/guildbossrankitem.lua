local var_0_0 = class("GuildBossRankItem", ReduxView)

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

	arg_3_0.heroCountController_ = arg_3_0.conExCollection_:GetController("heroCount")
	arg_3_0.rankController_ = arg_3_0.conExCollection_:GetController("rank")
	arg_3_0.positionController_ = arg_3_0.posExCon_:GetController("position")
	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.index_ = arg_4_1
	arg_4_0.data_ = arg_4_2

	arg_4_0:UpdateView()
end

function var_0_0.UpdateView(arg_5_0)
	arg_5_0.userID_ = arg_5_0.data_.id
	arg_5_0.nickText_.text = GetI18NText(arg_5_0.data_.nick)
	arg_5_0.rankText_.text = tostring(arg_5_0.index_)
	arg_5_0.scoreText_.text = arg_5_0.data_.score

	arg_5_0.commonPortrait_:RenderHead(arg_5_0.data_.icon)
	arg_5_0.commonPortrait_:RenderFrame(arg_5_0.data_.icon_frame)
	arg_5_0.positionController_:SetSelectedState(tostring(arg_5_0.data_.member_post))

	local var_5_0 = math.min(#arg_5_0.data_.hero_type_info, 3)
	local var_5_1 = arg_5_0.data_.hero_type_info

	arg_5_0.heroCountController_:SetSelectedIndex(var_5_0)

	for iter_5_0 = 1, var_5_0 do
		local var_5_2 = var_5_1[iter_5_0].skin_id

		if var_5_2 == 0 then
			var_5_2 = var_5_1[iter_5_0].hero_id
		end

		arg_5_0["heroImg_" .. iter_5_0].sprite = getSpriteViaConfig("HeroLittleIcon", var_5_2)
	end

	if arg_5_0.index_ <= 3 then
		arg_5_0.rankController_:SetSelectedState(arg_5_0.index_)
	else
		arg_5_0.rankController_:SetSelectedState(0)
	end
end

function var_0_0.AddUIListener(arg_6_0)
	return
end

function var_0_0.AddEventListeners(arg_7_0)
	return
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
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0

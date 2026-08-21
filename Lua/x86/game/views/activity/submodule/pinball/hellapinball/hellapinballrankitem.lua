local var_0_0 = class("HellaPinballRankItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.commonPortrait = CommonHeadPortrait.New(arg_2_0.headItem_)

	arg_2_0:AddUIListeners()

	arg_2_0.rankController = arg_2_0.conExCollection_:GetController("rank")
	arg_2_0.viewController = arg_2_0.conExCollection_:GetController("viewBtn")
end

function var_0_0.AddUIListeners(arg_3_0)
	return
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.commonPortrait:Dispose()
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.GetRankActivityID(arg_5_0)
	return 3840901
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.data = arg_6_1
	arg_6_0.rankText_.text = GetI18NText(arg_6_1.rank)
	arg_6_0.scoreText_.text = GetI18NText(arg_6_1.score)

	if arg_6_1.rank <= 3 then
		arg_6_0.rankController:SetSelectedIndex(arg_6_1.rank)
	else
		arg_6_0.rankController:SetSelectedIndex(0)
	end

	arg_6_0.nickText_.text = GetI18NText(arg_6_1.nick)

	arg_6_0.commonPortrait:RenderHead(arg_6_1.portrait)
	arg_6_0.commonPortrait:RenderFrame(arg_6_1.frame)

	if #arg_6_1.extraInfo > 0 then
		arg_6_0.viewController:SetSelectedState("normal")

		for iter_6_0 = 1, 2 do
			if arg_6_1.extraInfo[iter_6_0] then
				SetActive(arg_6_0["skillItem" .. iter_6_0 .. "_"], true)

				local var_6_0 = PinballSkillCfg[arg_6_1.extraInfo[iter_6_0]]

				arg_6_0["skillItemIcon" .. iter_6_0 .. "_"].sprite = pureGetSpriteWithoutAtlas(var_6_0.icon)
			else
				SetActive(arg_6_0["skillItem" .. iter_6_0 .. "_"], false)
			end
		end
	else
		arg_6_0.viewController:SetSelectedState("lock")
	end
end

return var_0_0

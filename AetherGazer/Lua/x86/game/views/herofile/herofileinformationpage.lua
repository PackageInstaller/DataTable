local var_0_0 = class("HeroFileInformationPage", ReduxView)

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

	arg_3_0.curHeroID_ = 0
	arg_3_0.curRecordID_ = 0
	arg_3_0.relationNetController_ = arg_3_0.rightControllerEx_:GetController("relationNet")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.relationBtn_, nil, function()
		if ArchiveData:GetTrustLevel(arg_4_0.curHeroID_) == 0 then
			ShowTips("HERO_RELATION_UNLOCK_TRUST")

			return
		end

		JumpTools.OpenPageByJump("/heroTrammels", {
			heroId = arg_4_0.curHeroID_
		})
	end)
end

function var_0_0.Show(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:UpdateView(arg_6_1, arg_6_2)
	SetActive(arg_6_0.gameObject_, true)
end

function var_0_0.UpdateView(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 ~= arg_7_0.curHeroID_ then
		local var_7_0 = HeroCfg[arg_7_2]

		arg_7_0.lableText_.text = GetI18NText(var_7_0.name)
		arg_7_0.summaryText_.text = GetI18NText(var_7_0.hero_desc)

		if HeroRelationNetCfg.get_id_list_by_hero_id[arg_7_2] then
			arg_7_0.relationNetController_:SetSelectedState("unlock")
		else
			arg_7_0.relationNetController_:SetSelectedState("lock")
		end

		arg_7_0.curHeroID_ = arg_7_2
	end

	if arg_7_1 ~= arg_7_0.curRecordID_ then
		local var_7_1 = HeroRecordCfg[arg_7_1]

		arg_7_0.nameText_.text = GetI18NText(var_7_1.name)
		arg_7_0.heightText_.text = GetI18NText(var_7_1.height)
		arg_7_0.weightText_.text = GetI18NText(var_7_1.weight)
		arg_7_0.birthdayText_.text = GetI18NText(var_7_1.birthday)
		arg_7_0.organizationText_.text = GetI18NText(var_7_1.organization)
		arg_7_0.hobbyText_.text = GetI18NText(var_7_1.like)
		arg_7_0.curRecordID_ = arg_7_1
	end

	arg_7_0:UpdateAdult()
	manager.redPoint:bindUIandKey(arg_7_0.relationBtn_.transform, string.format("%s_%s", RedPointConst.HERO_REALTION, arg_7_0.curHeroID_))
end

function var_0_0.UpdateAdult(arg_8_0)
	SetActive(arg_8_0.adultMarkGo_, HeroTools.IsNeedDisplayAdult(arg_8_0.curHeroID_))
end

function var_0_0.Hide(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0.relationBtn_.transform)
	SetActive(arg_9_0.gameObject_, false)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0

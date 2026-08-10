local var_0_0 = class("DormIlluHeroDetailInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.OnEnter(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:UpdateView(arg_2_1)

	arg_2_0.callBackFunc_ = arg_2_2

	arg_2_0:ChangeContent(1)
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0.heroID_ = 0
end

function var_0_0.Dispose(arg_4_0)
	if arg_4_0.actionScroll_ then
		arg_4_0.actionScroll_:Dispose()
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0.skillItemList_) do
		iter_4_1:Dispose()
	end

	for iter_4_2, iter_4_3 in pairs(arg_4_0.canteenSkillItemList_) do
		iter_4_3:Dispose()
	end

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:BindController()
	arg_5_0:AddUIListener()

	arg_5_0.skillItemList_ = {}

	for iter_5_0 = 1, 3 do
		arg_5_0.skillItemList_[iter_5_0] = TrainInfoSkillItem.New(arg_5_0["skill" .. iter_5_0 .. "Go_"])
	end

	arg_5_0.canteenSkillItemList_ = {}
	arg_5_0.actionScroll_ = LuaList.New(handler(arg_5_0, arg_5_0.HeroActionItem), arg_5_0.actionList_, IlluHeroActionItem)
	arg_5_0.heroID_ = 0
	arg_5_0.contentIndex_ = 0
end

function var_0_0.BindController(arg_6_0)
	arg_6_0.contentController_ = arg_6_0.mainControllerEx_:GetController("content")
	arg_6_0.lockController_ = arg_6_0.mainControllerEx_:GetController("lock")
	arg_6_0.isIdolController_ = arg_6_0.mainControllerEx_:GetController("isIdol")
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.actionBtn_, nil, function()
		arg_7_0:ChangeContent(1)
	end)
	arg_7_0:AddBtnListener(arg_7_0.skillBtn_, nil, function()
		arg_7_0.callBackFunc_(-1)
		arg_7_0:SetPlay(-1)
		arg_7_0:ChangeContent(2)
	end)
end

function var_0_0.HeroActionItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = BackHomeHeroCfg[arg_10_0.heroID_].illu_interaction

	arg_10_2:SetData(arg_10_1, var_10_0[arg_10_1], function(arg_11_0)
		arg_10_0.callBackFunc_(arg_11_0)
		arg_10_0:SetPlay(arg_10_1)
	end)
end

function var_0_0.SetPlay(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.actionScroll_:GetItemList()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if iter_12_0 == arg_12_1 then
			iter_12_1:SetPlay(true)
		else
			iter_12_1:SetPlay(false)
		end
	end
end

function var_0_0.ChangeContent(arg_13_0, arg_13_1)
	if arg_13_1 == arg_13_0.contentIndex_ then
		return
	end

	arg_13_0.contentIndex_ = arg_13_1

	if arg_13_1 == 1 then
		arg_13_0:UpdateActionView()
	elseif arg_13_1 == 2 then
		arg_13_0:UpdateCanteenView()
		arg_13_0:UpdateSkillView()
	end

	arg_13_0:ForceUpdate()
	arg_13_0.contentController_:SetSelectedIndex(arg_13_0.contentIndex_ - 1)
	arg_13_0:ForceUpdate()
	arg_13_0:ForceUpdate()
end

function var_0_0.UpdateView(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.heroID_ == arg_14_1 then
		return
	end

	arg_14_0.heroID_ = arg_14_1

	local var_14_0 = HeroCfg[arg_14_0.heroID_]

	arg_14_0.nameText_.text = GetI18NText(var_14_0.name)
	arg_14_0.suffixText_.text = HeroTools.GetHeroName(arg_14_0.heroID_)
	arg_14_0.attacktypeImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(var_14_0.id)
	arg_14_0.groupImg_.sprite = HeroTools.GetRaceIcon(var_14_0.race)

	arg_14_0.lockController_:SetSelectedState(HeroTools.GetHeroIsUnlock(arg_14_0.heroID_) and "unlock" or "lock")
	arg_14_0:UpdateActionView()
	arg_14_0:UpdateCanteenView()
	arg_14_0:UpdateSkillView()
	arg_14_0:SetPlay(-1)
	arg_14_0:ForceUpdate()
	arg_14_0:ForceUpdate()
end

function var_0_0.UpdateActionView(arg_15_0)
	arg_15_0.actionList_ = {}
	arg_15_0.actionList_ = BackHomeHeroCfg[arg_15_0.heroID_].illu_interaction

	arg_15_0.actionScroll_:StartScroll(#arg_15_0.actionList_)
end

function var_0_0.UpdateCanteenView(arg_16_0)
	arg_16_0.canteenSkillIDList_ = BackHomeHeroCfg[arg_16_0.heroID_].skill_list

	local var_16_0 = 1

	for iter_16_0, iter_16_1 in pairs(arg_16_0.canteenSkillIDList_) do
		if not arg_16_0.canteenSkillItemList_[var_16_0] then
			local var_16_1 = Object.Instantiate(arg_16_0.canteenSkillItemGo_, arg_16_0.canteenContent_)

			arg_16_0.canteenSkillItemList_[var_16_0] = CanteenSkillItem.New(var_16_1)
		end

		SetActive(arg_16_0.canteenSkillItemList_[var_16_0].gameObject_, true)
		arg_16_0.canteenSkillItemList_[var_16_0]:RefreshUI(arg_16_0.canteenSkillIDList_[var_16_0], nil, var_16_0)

		var_16_0 = var_16_0 + 1
	end

	for iter_16_2, iter_16_3 in pairs(arg_16_0.canteenSkillItemList_) do
		if var_16_0 <= iter_16_2 then
			SetActive(arg_16_0.canteenSkillItemList_[var_16_0].gameObject_, false)
		end
	end
end

function var_0_0.UpdateSkillView(arg_17_0)
	if BackHomeHeroCfg[arg_17_0.heroID_].idol_usable == 0 then
		for iter_17_0 = 1, 3 do
			if arg_17_0.skillItemList_[iter_17_0] then
				SetActive(arg_17_0.skillItemList_[iter_17_0].gameObject_, false)
			end
		end

		arg_17_0.isIdolController_:SetSelectedIndex(1)

		return
	end

	arg_17_0.isIdolController_:SetSelectedIndex(0)

	local var_17_0 = IdolTraineeTools:GetHeroBattleInfoTemplate(arg_17_0.heroID_)
	local var_17_1 = var_17_0.skill

	for iter_17_1 = 1, #var_17_1 do
		local var_17_2 = 0

		for iter_17_2, iter_17_3 in ipairs(var_17_0.propertyData) do
			var_17_2 = var_17_2 + iter_17_3
		end

		arg_17_0.skillItemList_[iter_17_1]:SetData(var_17_1[iter_17_1], var_17_2)
		SetActive(arg_17_0.skillItemList_[iter_17_1].gameObject_, true)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_0.skillItemList_[iter_17_1].transform_)
	end

	for iter_17_4 = #var_17_1 + 1, #arg_17_0.skillItemList_ do
		SetActive(arg_17_0.skillItemList_[iter_17_4].gameObject_, false)
	end
end

function var_0_0.ForceUpdate(arg_18_0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_0.canteenContent_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_0.danceContent_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_0.skillRootTrs_)
end

return var_0_0

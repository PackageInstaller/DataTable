local var_0_0 = class("HeroTransitionSimpleInfoView", ReduxView)

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

	arg_3_0.emptyController_ = arg_3_0.controller_:GetController("empty")
	arg_3_0.transitionItemList_ = {}
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetHeroInfo(arg_5_0, arg_5_1)
	arg_5_0.heroInfo_ = arg_5_1
	arg_5_0.heroID_ = arg_5_1.id
end

function var_0_0.UpdateView(arg_6_0)
	arg_6_0.transitionList_ = arg_6_0:RebuildTransitionSkills()

	arg_6_0.emptyController_:SetSelectedState(#arg_6_0.transitionList_ == 0 and "true" or "false")

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.transitionItemList_) do
		SetActive(iter_6_1.gameObject_, false)
	end

	local var_6_0 = 1

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.transitionList_) do
		if not arg_6_0.transitionItemList_[var_6_0] then
			local var_6_1 = Object.Instantiate(arg_6_0.jumpItemGo_, arg_6_0.jumpItemListTrs_, false)
			local var_6_2 = HeroTransitionItem.New(var_6_1)

			var_6_2:SetData(iter_6_3)
			table.insert(arg_6_0.transitionItemList_, var_6_2)
		else
			arg_6_0.transitionItemList_[var_6_0]:SetData(iter_6_3)
		end

		SetActive(arg_6_0.transitionItemList_[var_6_0].gameObject_, true)

		var_6_0 = var_6_0 + 1
	end
end

function var_0_0.OnEnter(arg_7_0, arg_7_1)
	arg_7_0.heroViewProxy_ = arg_7_1

	arg_7_0:RegistEventListener(HERO_TRANSITION_CHANGE, handler(arg_7_0, arg_7_0.OnHeroModify))
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0:RemoveAllEventListener()
end

function var_0_0.OnHeroModify(arg_9_0, arg_9_1)
	if arg_9_1 == arg_9_0.heroID_ then
		arg_9_0.heroInfo_ = arg_9_0.heroViewProxy_:GetHeroData(arg_9_0.heroID_)

		arg_9_0:UpdateView()
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.transitionItemList_) do
		if iter_10_1 then
			iter_10_1:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.RebuildTransitionSkills(arg_11_0)
	local var_11_0 = arg_11_0.heroViewProxy_:GetHeroTransitionInfoList(arg_11_0.heroID_)
	local var_11_1 = arg_11_0.heroViewProxy_:GetHeroData(arg_11_0.heroID_)
	local var_11_2 = HeroTools.GetHeroEquipTransitionAddLevel(var_11_1)
	local var_11_3 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if not arg_11_0:GetSlotLockStatus(iter_11_1.slot_id) then
			for iter_11_2, iter_11_3 in ipairs(iter_11_1.skill_list) do
				local var_11_4 = iter_11_3.skill_id
				local var_11_5 = iter_11_3.skill_level

				var_11_3[var_11_4] = (var_11_3[var_11_4] or 0) + var_11_5
			end
		end
	end

	local var_11_6 = {}

	for iter_11_4, iter_11_5 in pairs(var_11_3) do
		table.insert(var_11_6, {
			skillId = iter_11_4,
			level = iter_11_5 + var_11_2
		})
	end

	table.sort(var_11_6, function(arg_12_0, arg_12_1)
		if arg_12_0.skillId == arg_12_1.skillId then
			return false
		end

		return arg_12_0.skillId < arg_12_1.skillId
	end)

	return var_11_6
end

function var_0_0.GetSlotLockStatus(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.heroViewProxy_:GetEquipDataList(arg_13_0.heroID_)
	local var_13_1 = 0

	if var_13_0[arg_13_1] and var_13_0[arg_13_1].prefab_id and var_13_0[arg_13_1].prefab_id ~= 0 then
		var_13_1 = var_13_0[arg_13_1]:GetLevel()
	end

	return var_13_1 < GameSetting.exclusive_open_need.value[1]
end

return var_0_0

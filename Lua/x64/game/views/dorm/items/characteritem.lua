local var_0_0 = class("CharacterItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.flag = false

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "name")
	arg_3_0.fatigueComtroller = ControllerUtil.GetController(arg_3_0.transform_, "fatigue")
	arg_3_0.skillComtroller = ControllerUtil.GetController(arg_3_0.transform_, "skill")
	arg_3_0.typeScroll = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.uilistGo_, DormRecommendSmallItem)
	arg_3_0.sameNameController = ControllerUtil.GetController(arg_3_0.transform_, "sameName")
	arg_3_0.lockHeroController = arg_3_0.controllers_:GetController("lock")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.characterbuttonBtn_, nil, function()
		if arg_4_0.chooseFunc and arg_4_0.stateController:GetSelectedState() ~= "full" then
			arg_4_0.chooseFunc(arg_4_0.uid_, arg_4_0.stateController, arg_4_0.fatigueComtroller)
		end
	end)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:RefreshUI(arg_6_0.attributeList[arg_6_1], arg_6_0.flag)
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.chooseFunc = arg_7_1
	end
end

function var_0_0.RegistFullListCallBack(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0.fullListFunc = arg_8_1
	end
end

function var_0_0.RefreshUI(arg_9_0, arg_9_1)
	arg_9_0.entrustPosID = CanteenEntrustData:GetCurDispatchTask().pos
	arg_9_0.uid_ = arg_9_1

	local var_9_0 = arg_9_0:CheckSkillCanOpen()

	if #var_9_0 > 0 then
		local var_9_1 = var_9_0[1]

		arg_9_0.skillIcon.sprite = CanteenTools.GetCanteenSkillSprite(var_9_1)

		arg_9_0.skillComtroller:SetSelectedState("true")
	else
		arg_9_0.skillComtroller:SetSelectedState("false")
	end

	local var_9_2 = BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_9_1)

	arg_9_0.lockHeroController:SetSelectedState(var_9_2 and "on" or "off")

	arg_9_0.maxText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]

	local var_9_3 = DormData:GetHeroFatigue(arg_9_1)

	arg_9_0.curText_.text = var_9_3
	arg_9_0.headiconImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_9_0.uid_)
	arg_9_0.progressImg_.fillAmount = 1 - math.min(var_9_3 / GameSetting.canteen_hero_fatigue_max.value[1], 1)

	local var_9_4 = GameDisplayCfg.dorm_hero_fatigue_level.value

	if var_9_3 <= var_9_4[1] then
		arg_9_0.fatigueComtroller:SetSelectedState("lack")
	elseif var_9_3 > var_9_4[1] and var_9_3 <= var_9_4[2] then
		arg_9_0.fatigueComtroller:SetSelectedState("middle")
	else
		arg_9_0.fatigueComtroller:SetSelectedState("full")
	end

	arg_9_0:RefreshHeroAttributes(arg_9_1)

	if CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_9_1) or DormData:GetHeroTemplateInfo(arg_9_1).jobType ~= nil then
		arg_9_0.stateController:SetSelectedState("full")

		return
	end

	local var_9_5 = CanteenEntrustData:CheckDispatchCharacterArchiveList(arg_9_1) and not CanteenEntrustData:CheckDispatchCharacterList(arg_9_1)

	arg_9_0.sameNameController:SetSelectedState(var_9_5 and "true" or "false")

	if CanteenEntrustData:CheckDispatchCharacterList(arg_9_1) then
		arg_9_0.stateController:SetSelectedState("select")

		arg_9_0.flag = true
	else
		arg_9_0.flag = false
	end

	arg_9_0.fullListFunc(arg_9_0.uid_, arg_9_0.stateController)
end

function var_0_0.CheckSkillCanOpen(arg_10_0)
	local var_10_0 = BackHomeHeroCfg[arg_10_0.uid_].skill_list
	local var_10_1 = GameSetting.dorm_hero_skill_unlock.value
	local var_10_2 = {}
	local var_10_3 = HeroData:GetHeroData(arg_10_0.uid_).level

	for iter_10_0 = 1, #var_10_0 do
		if var_10_3 >= var_10_1[iter_10_0] then
			table.insert(var_10_2, var_10_0[iter_10_0])
		end
	end

	local var_10_4 = {}

	for iter_10_1, iter_10_2 in ipairs(var_10_2) do
		local var_10_5 = BackHomeHeroSkillCfg[iter_10_2].condition

		if var_10_5 and #var_10_5 > 0 then
			if var_10_5[1] == 3 then
				table.insert(var_10_4, iter_10_2)
			end
		else
			table.insert(var_10_4, iter_10_2)
		end
	end

	return var_10_4
end

function var_0_0.RefreshHeroAttributes(arg_11_0, arg_11_1)
	arg_11_0.attributeList = {}

	local var_11_0 = CanteenEntrustData:GetEntrustByPos(arg_11_0.entrustPosID).tags

	arg_11_0.attributeList = {
		{
			type = 1,
			tag = CharactorParamCfg[arg_11_1].RangeType
		},
		{
			type = 2,
			tag = HeroCfg[arg_11_1].race
		},
		{
			type = 3,
			tag = HeroCfg[arg_11_1].ATK_attribute[1]
		},
		{
			type = 4,
			tag = HeroCfg[arg_11_1].mechanism_type[1]
		}
	}

	arg_11_0.typeScroll:StartScroll(#arg_11_0.attributeList)

	arg_11_0.uilistGo_:GetComponent("ScrollRectEx").vertical = false
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.typeScroll then
		arg_12_0.typeScroll:Dispose()
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0

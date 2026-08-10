local var_0_0 = class("HeroSkillAddTipsView", ReduxView)
local var_0_1 = {
	[HeroConst.HERO_SKILL_ADD_TYPE.WEAPONMODULE] = 1,
	[HeroConst.HERO_SKILL_ADD_TYPE.ASTROLABE] = 2,
	[HeroConst.HERO_SKILL_ADD_TYPE.WEAPONSERVANT] = 3,
	[HeroConst.HERO_SKILL_ADD_TYPE.ATTRIBUTE] = 4
}
local var_0_2 = {
	empty = "empty",
	noEmpty = "noEmpty"
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_skill/HeroSkillTipUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
	arg_3_0:SetInfoIsShow(false)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.emptyController = arg_4_0.controllerexcollection_:GetController("empty")
	arg_4_0.textItemList = {}
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.backBtnCallback = arg_5_0.params_.backBtnCallback

	arg_5_0:RefreshUi(arg_5_0.params_)
end

function var_0_0.OnHeroSkillAddViewUpdate(arg_6_0, arg_6_1)
	arg_6_0:RefreshUi(arg_6_1)
end

function var_0_0.RefreshUi(arg_7_0, arg_7_1)
	arg_7_0.showType = arg_7_1.showType
	arg_7_0.showTextList = arg_7_1.showTextList
	arg_7_0.heroId = arg_7_1.heroId

	arg_7_0:SetDataAndShow(arg_7_0.showType, arg_7_0.showTextList)
end

function var_0_0.SetBackBtnCallback(arg_8_0, arg_8_1)
	arg_8_0.backBtnCallback = arg_8_1
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.backBtn_, nil, function()
		arg_9_0:SetInfoIsShow(false)

		if arg_9_0.backBtnCallback then
			arg_9_0.backBtnCallback()
		end

		JumpTools.Back()
	end)
	arg_9_0:AddBtnListener(arg_9_0.gobtnBtn_, nil, function()
		arg_9_0:OnGoBtn()
	end)
end

function var_0_0.OnGoBtn(arg_12_0)
	if arg_12_0.showType == HeroConst.HERO_SKILL_ADD_TYPE.WEAPONSERVANT then
		if arg_12_0.params_.dataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
			JumpTools.GoToSystem("/polyhedronHero", {
				isEnter = true,
				pageIndex = 3,
				hid = arg_12_0.heroId,
				type = HeroConst.HERO_DATA_TYPE.POLYHEDRON
			})
		else
			JumpTools.GoToSystem("/newHero", {
				isEnter = true,
				pageIndex = 3,
				hid = arg_12_0.heroId,
				type = HeroConst.HERO_DATA_TYPE.DEFAULT
			})
		end
	elseif arg_12_0.showType == HeroConst.HERO_SKILL_ADD_TYPE.WEAPONMODULE then
		JumpTools.Back()
		JumpTools.OpenPageByJump("/weaponModuleView", {
			heroID = arg_12_0.heroId
		})
	elseif arg_12_0.showType == HeroConst.HERO_SKILL_ADD_TYPE.ASTROLABE then
		if arg_12_0.params_.dataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
			JumpTools.GoToSystem("/polyhedronHero", {
				isEnter = true,
				pageIndex = 6,
				hid = arg_12_0.heroId,
				type = HeroConst.HERO_DATA_TYPE.POLYHEDRON
			})
		else
			JumpTools.GoToSystem("/newHero", {
				isEnter = true,
				pageIndex = 6,
				hid = arg_12_0.heroId,
				type = HeroConst.HERO_DATA_TYPE.DEFAULT
			})
		end
	elseif arg_12_0.showType == HeroConst.HERO_SKILL_ADD_TYPE.ATTRIBUTE then
		local var_12_0 = gameContext:GetOpenPageHandler("skillView")

		if var_12_0 then
			JumpTools.Back()
			var_12_0:ChangeTab(2)
		end
	end
end

function var_0_0.SetInfoIsShow(arg_13_0, arg_13_1)
	arg_13_0.isShow_ = arg_13_1

	if not arg_13_0.timer_ then
		arg_13_0.timer_ = Timer.New(function()
			SetActive(arg_13_0.gameObject_, arg_13_0.isShow_)

			arg_13_0.timer_ = nil
		end, 0.034, 1)

		arg_13_0.timer_:Start()
	end
end

function var_0_0.CreateItem(arg_15_0, arg_15_1)
	local var_15_0 = GameObject.Instantiate(arg_15_0.skillitemGo_, arg_15_0.contentTrs_)
	local var_15_1 = HeroSkillAddTipsItem.New(var_15_0)

	arg_15_0.textItemList[arg_15_1] = var_15_1

	return var_15_1
end

function var_0_0.SetDataAndShow(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:SetInfoIsShow(true)

	for iter_16_0, iter_16_1 in pairs(arg_16_2) do
		(arg_16_0.textItemList[iter_16_0] or arg_16_0:CreateItem(iter_16_0)):RefreshUI(iter_16_1)
	end

	for iter_16_2 = #arg_16_2 + 1, #arg_16_0.textItemList do
		local var_16_0 = arg_16_0.textItemList[iter_16_2]

		if var_16_0 then
			SetActive(var_16_0.gameObject_, false)
		end
	end

	local var_16_1 = var_0_1[arg_16_1]

	if var_16_1 then
		arg_16_0.titleText_.text = GetTips("Skill_Effect" .. var_16_1)
	end

	local var_16_2 = #arg_16_2 > 0 and var_0_2.noEmpty or var_0_2.empty

	arg_16_0.emptyController:SetSelectedState(var_16_2)
end

function var_0_0.OnExit(arg_17_0)
	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.textItemList) do
		iter_18_1:Dispose()
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0

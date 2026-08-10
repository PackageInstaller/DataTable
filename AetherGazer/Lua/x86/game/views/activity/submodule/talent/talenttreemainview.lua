local var_0_0 = class("TalentTreeMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return nil
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

local var_0_1 = 6

function var_0_0.InitGo(arg_3_0, arg_3_1)
	if arg_3_0.gameObject_ then
		Object.Destroy(arg_3_0.gameObject_)
	end

	local var_3_0 = Asset.Load(arg_3_1)

	arg_3_0.gameObject_ = Object.Instantiate(var_3_0, arg_3_0:UIParent())
	arg_3_0.transform_ = arg_3_0.gameObject_.transform

	if arg_3_0.params_.activityId == ActivityConst.HELLA_TALENT_TREE then
		var_0_1 = 5
	else
		var_0_1 = 6
	end

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.levelUpGo_ = arg_3_0.levelUpTrs_.gameObject
	arg_3_0.levelUpAni_ = arg_3_0.levelUpTrs_:GetComponent("Animator")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.upGo_ = arg_4_0.upBtn_.gameObject
	arg_4_0.subDesControllerS_ = {}

	for iter_4_0 = 0, 5 do
		local var_4_0 = arg_4_0[string.format("item%dTrs_", iter_4_0)]

		if var_4_0 then
			arg_4_0.subDesControllerS_[iter_4_0] = ControllerUtil.GetController(var_4_0, "item")
		end
	end

	if arg_4_0.params_.activityId == ActivityConst.HELLA_TALENT_TREE then
		SetActive(arg_4_0.race6Btn_.gameObject, false)
	end

	arg_4_0.raceToId_ = {}
end

function var_0_0.AddUIListener(arg_5_0)
	for iter_5_0 = 0, var_0_1 do
		local var_5_0 = arg_5_0[string.format("race%dBtn_", iter_5_0)]

		if var_5_0 then
			arg_5_0:AddBtnListener(var_5_0, nil, function()
				arg_5_0:SelectItem(iter_5_0)
			end)
		end
	end

	arg_5_0:AddBtnListener(arg_5_0.upBtn_, nil, function()
		local var_7_0 = arg_5_0.currenttalentID_
		local var_7_1 = TalentTreeCfg[var_7_0]
		local var_7_2 = TalentTreeData:GetTalentLevel(var_7_0)
		local var_7_3 = var_7_1.cost[var_7_2 + 1]

		if ItemTools.getItemNum(var_7_3[1]) < var_7_3[2] then
			local var_7_4 = ItemCfg[var_7_3[1]]

			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(var_7_3[1])))

			return
		end

		TalentTreeAction.UpTalentLevel(var_7_0, var_7_1.cost[var_7_2 + 1])
	end)
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = TalentTreeCfg.get_id_list_by_activity_id[arg_8_0.activityId_]

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = TalentTreeCfg[iter_8_1]

		arg_8_0.raceToId_[var_8_1.index] = iter_8_1

		if var_8_1.race == 0 then
			arg_8_0.coreText_.text = GetI18NText(getAffixName({
				var_8_1.affix_id,
				1
			}))
			arg_8_0.coreDesText_.text = GetI18NText(getAffixDesc({
				var_8_1.affix_id,
				1
			}))
		else
			arg_8_0:RefreshItemMainLevel(iter_8_1)
		end
	end
end

function var_0_0.RefreshItem(arg_9_0, arg_9_1)
	local var_9_0 = TalentTreeCfg[arg_9_1]
	local var_9_1 = TalentTreeData:GetTalentLevel(arg_9_1)

	arg_9_0:RefreshItemMainLevel(arg_9_1)

	arg_9_0.talentText_.text = GetI18NText(getAffixName({
		var_9_0.affix_id,
		1
	}))

	if arg_9_0.descText_ then
		arg_9_0.descText_.text = GetI18NText(var_9_0.desc)
	end

	for iter_9_0 = 1, var_9_0.max_level do
		local var_9_2 = arg_9_0[string.format("subDes%dText_", iter_9_0)]

		if var_9_2 then
			var_9_2.text = GetI18NText(getAffixDesc({
				var_9_0.affix_id,
				iter_9_0
			}))
		end

		if arg_9_0.subDesControllerS_[iter_9_0] then
			arg_9_0.subDesControllerS_[iter_9_0]:SetSelectedState(tostring(iter_9_0 <= var_9_1))
		end
	end
end

function var_0_0.PlayLevelUpAni(arg_10_0, arg_10_1)
	local var_10_0 = TalentTreeData:GetTalentLevel(arg_10_1)

	arg_10_0.levelUpTrs_.parent = arg_10_0[string.format("item%dTrs_", var_10_0)]
	arg_10_0.levelUpTrs_.localPosition = Vector3.zero

	arg_10_0.levelUpAni_:Play("TalentUILevelUp", 0, 0)
end

function var_0_0.RefreshItemMainLevel(arg_11_0, arg_11_1)
	local var_11_0 = TalentTreeCfg[arg_11_1]
	local var_11_1 = TalentTreeData:GetTalentLevel(arg_11_1)
	local var_11_2 = arg_11_0[string.format("num%dText_", var_11_0.index)]

	if var_11_2 then
		var_11_2.text = string.format("%d%%", var_11_1 / var_11_0.max_level * 100)
	end
end

function var_0_0.RefreshCost(arg_12_0)
	local var_12_0 = arg_12_0.currenttalentID_
	local var_12_1 = TalentTreeCfg[var_12_0]
	local var_12_2 = TalentTreeData:GetTalentLevel(var_12_0)

	if var_12_2 < var_12_1.max_level then
		SetActive(arg_12_0.upGo_, true)

		local var_12_3 = var_12_1.cost[var_12_2 + 1]

		arg_12_0.costText_.text = var_12_3[2]

		if ItemTools.getItemNum(var_12_3[1]) >= var_12_3[2] then
			arg_12_0.costText_.color = CurrencyConst.ENOUGH_COLOR_LIGHT
		else
			arg_12_0.costText_.color = CurrencyConst.LACK_COLOR
		end
	else
		SetActive(arg_12_0.upGo_, false)
	end
end

function var_0_0.RefreshRedPoint(arg_13_0)
	for iter_13_0 = 1, var_0_1 do
		local var_13_0 = arg_13_0[string.format("race%dBtn_", iter_13_0)]

		if var_13_0 then
			local var_13_1 = arg_13_0.raceToId_[iter_13_0]

			manager.redPoint:SetRedPointIndependent(var_13_0.transform, TalentTreeTools.IsCanUp(var_13_1))
		end
	end
end

function var_0_0.SelectItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.raceToId_[arg_14_1]
	local var_14_1 = TalentTreeCfg[var_14_0].race

	if arg_14_0.currenttalentID_ == var_14_0 then
		return
	end

	if arg_14_0.currenttalentID_ then
		local var_14_2 = arg_14_0[string.format("select%dGo_", TalentTreeCfg[arg_14_0.currenttalentID_].index)]

		if var_14_2 then
			SetActive(var_14_2, false)
		end
	end

	arg_14_0.currenttalentID_ = var_14_0

	SetActive(arg_14_0.introduceGo_, var_14_1 == 0)
	SetActive(arg_14_0.talentProgressGo_, var_14_1 ~= 0)

	local var_14_3 = arg_14_0[string.format("select%dGo_", arg_14_1)]

	if var_14_3 then
		SetActive(var_14_3, true)
	end

	if var_14_1 ~= 0 then
		arg_14_0:RefreshItem(var_14_0)
	else
		arg_14_0.levelUpTrs_.localPosition = Vector3.New(0, 9999, 0)
	end

	arg_14_0:RefreshCost()
end

function var_0_0.OnUpTalentLevel(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:RefreshItem(arg_15_2.id)
	arg_15_0:PlayLevelUpAni(arg_15_2.id)
	arg_15_0:RefreshCost()
	arg_15_0:RefreshRedPoint()
end

function var_0_0.OnEnter(arg_16_0)
	if not arg_16_0.activityId_ or arg_16_0.params_.activityID ~= arg_16_0.activityId_ then
		arg_16_0.activityId_ = arg_16_0.params_.activityID

		arg_16_0:InitGo(TalentTreeTools.GetMainUIName(arg_16_0.activityId_))
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_HELLA_TALENT_TREE_COIN
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_HELLA_TALENT_TREE_COIN, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_HELLA_TALENT_DESCRIPE")
	arg_16_0:RefreshUI()
	arg_16_0:RefreshRedPoint()
	arg_16_0:SelectItem(0)
end

function var_0_0.OnExit(arg_17_0)
	manager.windowBar:HideBar()

	arg_17_0.raceToId_ = {}
	arg_17_0.levelUpTrs_.localPosition = Vector3.New(0, 9999, 0)
end

return var_0_0

local var_0_0 = class("AdminCatExploreCatCultivateView", ReduxView)
local var_0_1 = 56

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ExploreUI/ExplpreChipUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.adminCatList_ = LuaList.New(handler(arg_4_0, arg_4_0.SetItemData), arg_4_0.listGo_, AdminCatExploreCultureItem)
	arg_4_0.stateController = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "state")
	arg_4_0.conditionController1 = ControllerUtil.GetController(arg_4_0.condition1_.transform, "state")
	arg_4_0.conditionController2 = ControllerUtil.GetController(arg_4_0.condition2_.transform, "state")
end

function var_0_0.SetItemData(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.allAdminCatList[arg_5_1]

	table.insert(arg_5_0.itemList, arg_5_2)
	arg_5_2:SetData(var_5_0, arg_5_1, handler(arg_5_0, arg_5_0.ItemRegisterFunction), arg_5_0.selectIndex)
end

function var_0_0.ItemRegisterFunction(arg_6_0, arg_6_1)
	arg_6_0.selectIndex = arg_6_1

	arg_6_0:PlayAnimation()
	arg_6_0:UpdateView()
end

function var_0_0.PlayAnimation(arg_7_0)
	arg_7_0.animPanelGo1_:Play("Fx_ExplpreChipUI_icon_cx", -1, 0)
	arg_7_0.animPanelGo2_:Play("Fx_ExplpreChipUI_right_cx", -1, 0)
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.unlockBtn_, nil, function()
		arg_8_0.sortId = arg_8_0.allAdminCatList[arg_8_0.selectIndex].id

		AdminCatExploreAction.UnlockAdminCat(arg_8_0.sortId)
	end)
	arg_8_0:AddBtnListener(arg_8_0.levelUpBtn_, nil, function()
		if arg_8_0.stateController:GetSelectedState() == "normal" then
			AdminCatExploreAction.AdminCatSkillLevelUp(arg_8_0.allAdminCatList[arg_8_0.selectIndex].id, arg_8_0.skillID)
		else
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")
		end
	end)
end

function var_0_0.OnSkillLevelUpUpdate(arg_11_0)
	arg_11_0:UpdateView()
end

function var_0_0.OnUnlockAdminCatUpdate(arg_12_0)
	AdminCatExploreData:ModifyData({
		arg_12_0.skillConsume
	}, false)
	arg_12_0:UpdateView()
end

function var_0_0.UpdateBar(arg_13_0)
	return
end

function var_0_0.CheckEnough(arg_14_0)
	return ItemTools.getItemNum(arg_14_0.skillConsume[1]) >= arg_14_0.skillConsume[2]
end

function var_0_0.UpdateView(arg_15_0)
	arg_15_0.selectIndex = arg_15_0.selectIndex or 1
	arg_15_0.allAdminCatList = AdminCatExploreData:SortAllAdminCatList()

	if arg_15_0.sortId then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0.allAdminCatList) do
			if iter_15_1.id == arg_15_0.sortId then
				arg_15_0.selectIndex = iter_15_0
			end
		end

		arg_15_0.sortId = nil
	end

	local var_15_0 = arg_15_0.allAdminCatList[arg_15_0.selectIndex]
	local var_15_1 = AdminCatExploreData:GetDataByPara("level")
	local var_15_2 = ExploreMeowCfg[var_15_0.id]
	local var_15_3 = ExploreMeowSkillCfg[var_15_2.skill]
	local var_15_4 = ExploreMeowInbornCfg[var_15_2.inborn]
	local var_15_5 = AdminCatExploreData:GetDataByPara("totalAdminCat")
	local var_15_6 = AdminCatExploreData:GetDataByPara("skillData")[var_15_3.id] or 1
	local var_15_7 = AdminCatExploreData:GetDataByPara("adminCatLockList")
	local var_15_8 = AdminCatExploreData:GetDataByPara("accumulateC")

	arg_15_0.skillID = var_15_3.id
	arg_15_0.skillConsume = nil
	arg_15_0.itemList = {}
	arg_15_0.adminCatConsume = var_15_2.unlock_condition

	if var_15_0.canUse == false then
		local var_15_9 = var_15_7[var_15_0.id] and (var_15_1 < var_15_7[var_15_0.id] or AdminCatExploreData:CheckCanLock(arg_15_0.adminCatConsume) == false)

		arg_15_0.stateController:SetSelectedState(var_15_9 and "lock" or "unlock")

		arg_15_0.conditionDesc1_.text = string.format(GetTips("EXPLORE_LEVEL"), var_15_7[var_15_0.id] or 1)
		arg_15_0.conditionDesc2_.text = GetTips("EXPLORE_MEOW_DEBLOCKING_CONDITION") .. ItemTools.getItemName(var_0_1)
		arg_15_0.conditionNum1_.text = var_15_1 .. "/" .. var_15_7[var_15_0.id]
		arg_15_0.conditionNum2_.text = (var_15_8 > arg_15_0.adminCatConsume[1][2] and arg_15_0.adminCatConsume[1][2] or var_15_8) .. "/" .. arg_15_0.adminCatConsume[1][2]

		arg_15_0.conditionController1:SetSelectedState(var_15_1 >= var_15_7[var_15_0.id] and "can" or "cannot")
		arg_15_0.conditionController2:SetSelectedState(var_15_8 >= arg_15_0.adminCatConsume[1][2] and "can" or "cannot")
	elseif var_15_6 == #var_15_3.skill_effect then
		arg_15_0.stateController:SetSelectedState("max")
	else
		arg_15_0.skillConsume = var_15_3.skill_up_consume[var_15_6][1]

		arg_15_0.stateController:SetSelectedState(arg_15_0:CheckEnough() and "normal" or "lack")

		arg_15_0.levelUpTxt_.text = "Lv" .. var_15_6 + 1
		arg_15_0.consumeTxt_.text = (arg_15_0:CheckEnough() and "<color=#ffffff>" or "<color=#B94A53>") .. ItemTools.getItemNum(arg_15_0.skillConsume[1]) .. "</color>/" .. arg_15_0.skillConsume[2]
		arg_15_0.itemImage_.sprite = ItemTools.getItemSprite(arg_15_0.skillConsume[1])
	end

	arg_15_0.adminCatList_:StartScroll(var_15_5)

	arg_15_0.inbornImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Chip/" .. var_15_4.inborn_icon)
	arg_15_0.skillImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Chip/" .. var_15_3.skill_icon)
	arg_15_0.adminCatImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Managecat_l/" .. var_15_2.meow_icon)
	arg_15_0.lvImage_.sprite = pureGetSpriteWithoutAtlas("TextureBg/ExploreUI/icon_" .. var_15_1)
	arg_15_0.skillLv_.text = "Lv." .. var_15_6
	arg_15_0.adminCatTxt_.text = GetI18NText(var_15_2.meow_name)
	arg_15_0.inbornDescTxt_.text = GetI18NText(var_15_4.inborn_description)
	arg_15_0.inbornNameTxt_.text = GetI18NText(var_15_4.inborn_name)
	arg_15_0.skillNameTxt_.text = GetI18NText(var_15_3.skill_name)
	arg_15_0.skillDescTxt_.text = string.format(GetI18NText(var_15_3.skill_description), tostring(var_15_3.skill_effect[var_15_6]))
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0:UpdateView()
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0.selectIndex = nil

	if arg_17_0.itemList then
		for iter_17_0, iter_17_1 in ipairs(arg_17_0.itemList) do
			iter_17_1:OnExit()
		end
	end

	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_0_1
	})
end

function var_0_0.Dispose(arg_19_0)
	if arg_19_0.itemList then
		for iter_19_0, iter_19_1 in ipairs(arg_19_0.itemList) do
			iter_19_1:Dispose()
		end
	end

	arg_19_0.itemList = {}

	if arg_19_0.adminCatList_ then
		arg_19_0.adminCatList_:Dispose()

		arg_19_0.adminCatList_ = nil
	end

	var_0_0.super.Dispose(arg_19_0)
	Object.Destroy(arg_19_0.gameObject_)
end

return var_0_0

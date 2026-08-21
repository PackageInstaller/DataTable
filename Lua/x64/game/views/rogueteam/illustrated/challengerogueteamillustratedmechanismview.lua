local var_0_0 = class("ChallengeRogueTeamIllustratedMechanismView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/Illustrated/IllustratedMechanismUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.lockController_ = arg_3_0.controller_:GetController("lock")
	arg_3_0.list_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.itemList_, ChallengeRogueTeamIllustratedMechanismItem)
end

function var_0_0.OnEnter(arg_4_0, arg_4_1)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_4_0.templateID_ = arg_4_0.params_.templateID or ChallengeRogueTeamData:GetCacheTemplateID()
	arg_4_0.itemTemplate_ = RogueTeamCfg[arg_4_0.templateID_].item_temp

	arg_4_0:RefreshUI()
	arg_4_0:ShowItemInfo(arg_4_0.dataList_[1])

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.list_:GetItemList()) do
		iter_4_1:RefreshSelect(arg_4_0.dataList_[1])
	end
end

function var_0_0.RefreshUI(arg_5_0)
	arg_5_0.dataList_ = ChallengeRogueTeamData:GetAllItemIDByTempAndType(arg_5_0.itemTemplate_, ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM)
	arg_5_0.unlockList_ = ChallengeRogueTeamData:GetIllustratedDataByType(arg_5_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.SEASON)

	table.sort(arg_5_0.dataList_, function(arg_6_0, arg_6_1)
		if arg_5_0.unlockList_[arg_6_0] and not arg_5_0.unlockList_[arg_6_1] then
			return arg_6_0
		elseif arg_5_0.unlockList_[arg_6_1] and arg_5_0.unlockList_[arg_6_1] then
			return arg_6_1
		else
			return arg_6_0 < arg_6_1
		end
	end)
	arg_5_0.list_:StartScroll(#arg_5_0.dataList_)

	arg_5_0.taskProgressText_.text = #arg_5_0.unlockList_ .. "/" .. #arg_5_0.dataList_
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_1, arg_7_0.dataList_[arg_7_1])
	arg_7_2:SetClickCallBack(function(arg_8_0)
		arg_7_0:ShowItemInfo(arg_8_0)

		for iter_8_0, iter_8_1 in ipairs(arg_7_0.list_:GetItemList()) do
			iter_8_1:RefreshSelect(arg_8_0)
		end
	end)
end

function var_0_0.ShowItemInfo(arg_9_0, arg_9_1)
	if not arg_9_1 then
		SetActive(arg_9_0.infoGo_, false)
	else
		local var_9_0 = RogueTeamItemCfg[arg_9_1]

		SetActive(arg_9_0.infoGo_, true)

		arg_9_0.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_9_1))
		arg_9_0.text_.text = var_9_0.name
		arg_9_0.itemDesc_.text = var_9_0.desc
		arg_9_0.effectDesc_.text = var_9_0.story_desc

		local var_9_1 = not ChallengeRogueTeamData:IsIllustratedObtained(arg_9_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TYPE.SEASON, arg_9_1)

		if var_9_1 then
			arg_9_0.text_.text = "???"
		end

		arg_9_0.lockController_:SetSelectedState(tostring(var_9_1))
	end
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_10_0:RefreshUI()
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
	arg_11_0.list_:Dispose()

	arg_11_0.list_ = nil
end

function var_0_0.AddListeners(arg_12_0)
	return
end

return var_0_0

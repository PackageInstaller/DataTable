local var_0_0 = class("ActivitySkinDrawRewardViewOld", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivitySkinDrawToolsOld.GetDrawRewardUIName(arg_1_0.params_.mainActivityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.soundEffect_ = {
		"search_scene_03_blue",
		"search_scene_03_purple",
		"search_scene_03_gold",
		special = "search_scene_03_special"
	}
	arg_4_0.typeGo_ = {}
	arg_4_0.typeItem_ = {}
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.nextBtn_, nil, function()
		arg_5_0:NextCode()
	end)
	arg_5_0:AddBtnListener(arg_5_0.skipBtn_, nil, function()
		arg_5_0:GotoResult()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.index_ = 0
	arg_8_0.list_ = arg_8_0.params_.list
	arg_8_0.showList_ = arg_8_0.params_.showList
	arg_8_0.replaceList_ = arg_8_0.params_.replaceList

	arg_8_0:RefreshReplace()
	arg_8_0:RefreshGoList()
	arg_8_0:NextCode()
end

function var_0_0.RefreshReplace(arg_9_0)
	arg_9_0.isReplaceFrame_ = false
	arg_9_0.isReplaceSkin_ = false
	arg_9_0.isReplaceScene_ = false
	arg_9_0.isReplaceSticker_ = false

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.replaceList_) do
		local var_9_0 = ActivityLimitedDrawPoolCfg[iter_9_1].reward[1][1]
		local var_9_1 = ItemCfg[var_9_0]

		if var_9_1.type == ItemConst.ITEM_TYPE.FRAME then
			arg_9_0.isReplaceFrame_ = true
		elseif var_9_1.type == ItemConst.ITEM_TYPE.HERO_SKIN then
			arg_9_0.isReplaceSkin_ = true
		elseif var_9_1.type == ItemConst.ITEM_TYPE.SCENE then
			arg_9_0.isReplaceScene_ = true
		elseif var_9_1.type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
			arg_9_0.isReplaceSticker_ = true
		end
	end
end

function var_0_0.RefreshGoList(arg_10_0)
	if arg_10_0.activityID_ ~= arg_10_0.params_.mainActivityID then
		arg_10_0.typeGo_ = ActivitySkinDrawToolsOld.GetTypeGo(arg_10_0.params_.mainActivityID)
		arg_10_0.activityID_ = arg_10_0.params_.mainActivityID

		for iter_10_0, iter_10_1 in pairs(arg_10_0.typeItem_) do
			iter_10_1:Dispose()
		end

		arg_10_0.typeItem_ = {}
	end
end

function var_0_0.NextCode(arg_11_0)
	SetActive(arg_11_0.tipGo_, false)

	if arg_11_0.curItem_ then
		arg_11_0.curItem_:Hide()
	end

	if arg_11_0.index_ < #arg_11_0.showList_ then
		arg_11_0.index_ = arg_11_0.index_ + 1

		local var_11_0 = arg_11_0.showList_[arg_11_0.index_]
		local var_11_1 = ActivityLimitedDrawPoolCfg[var_11_0]
		local var_11_2 = var_11_1.reward[1][1]
		local var_11_3 = ItemCfg[var_11_2]
		local var_11_4 = 1
		local var_11_5 = var_11_1.minimum_guarantee == 2 and 3 or 2
		local var_11_6 = ItemCfg[var_11_2]

		if var_11_6.type == ItemConst.ITEM_TYPE.FRAME then
			arg_11_0:ShowReward(var_11_5, var_11_0, arg_11_0.isReplaceFrame_)
		elseif var_11_6.type == ItemConst.ITEM_TYPE.HERO_SKIN then
			arg_11_0:ShowAni("special", var_11_0, arg_11_0.isReplaceSkin_)
		elseif var_11_6.type == ItemConst.ITEM_TYPE.SCENE then
			arg_11_0.isScene_ = not arg_11_0.isReplaceScene_

			arg_11_0:ShowReward("special", var_11_0, arg_11_0.isReplaceScene_)
		elseif var_11_6.type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
			arg_11_0:ShowReward(var_11_5, var_11_0, arg_11_0.isReplaceSticker_)
		else
			arg_11_0:ShowReward(var_11_5, var_11_0)
		end
	else
		arg_11_0:GotoResult()
	end
end

function var_0_0.ShowAni(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	SetActive(arg_12_0.skipBtn_, false)

	arg_12_0.nextBtn_.interactable = false

	manager.audio:PlayEffect("ui_system_search", "search_scene_musicdown", "")

	if not arg_12_0.typeItem_.movie then
		local var_12_0 = Asset.Load(arg_12_0.typeGo_.movie)
		local var_12_1 = Object.Instantiate(var_12_0, arg_12_0.content_)

		arg_12_0.typeItem_.movie = ActivitySkinDrawMovieView.New(var_12_1)
	end

	arg_12_0.typeItem_.movie:SetData(arg_12_2, function()
		print("测试回放")
		SetActive(arg_12_0.skipBtn_, true)

		arg_12_0.nextBtn_.interactable = true

		manager.audio:PlayEffect("ui_system_search", "search_scene_musicup", "")
		arg_12_0:ShowReward(arg_12_1, arg_12_2, arg_12_3)
	end)
end

function var_0_0.ShowReward(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if not arg_14_0.typeItem_[arg_14_1] then
		local var_14_0 = Asset.Load(arg_14_0.typeGo_[arg_14_1])
		local var_14_1 = Object.Instantiate(var_14_0, arg_14_0.content_)

		arg_14_0.typeItem_[arg_14_1] = ActivitySkinDrawShowView.New(var_14_1)
	end

	arg_14_0.typeItem_[arg_14_1]:SetData(arg_14_2)

	arg_14_0.curItem_ = arg_14_0.typeItem_[arg_14_1]

	manager.audio:StopEffect()
	manager.audio:PlayEffect("ui_system_search", arg_14_0.soundEffect_[arg_14_1], "")

	local var_14_2 = ActivityLimitedDrawPoolCfg[arg_14_2].reward[1][1]

	if arg_14_3 and ItemCfg[var_14_2].num_exchange_item then
		if ItemCfg[var_14_2].type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER and not table.indexof(arg_14_0.replaceList_, arg_14_2) then
			return
		end

		local var_14_3 = ItemCfg[var_14_2].num_exchange_item[1]

		arg_14_0.tipText_.text = "x" .. GetI18NText(var_14_3[2])
		arg_14_0.tipIcon_.sprite = ItemTools.getItemSprite(var_14_3[1])
		arg_14_0.nameText_.text = ItemTools.getItemName(var_14_3[1])

		SetActive(arg_14_0.tipGo_, true)
	end
end

function var_0_0.GotoResult(arg_15_0)
	if #arg_15_0.list_ > 1 then
		local var_15_0 = {
			showList = arg_15_0.showList_,
			list = arg_15_0.list_,
			replaceList = arg_15_0.replaceList_,
			activityID = arg_15_0.params_.poolActivityID,
			mainActivityID = arg_15_0.params_.mainActivityID
		}

		JumpTools.OpenPageByJump("/activitySkinResultRewardOld", var_15_0)
	else
		JumpTools.OpenPageByJump("/activityskinDrawOld", {
			activityID = arg_15_0.params_.mainActivityID,
			isSceneDrawed = arg_15_0.isScene_
		})
	end
end

function var_0_0.OnTop(arg_16_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_17_0)
	SetActive(arg_17_0.skipBtn_, true)

	arg_17_0.nextBtn_.interactable = true
	arg_17_0.isScene_ = false

	if arg_17_0.curItem_ then
		arg_17_0.curItem_:Hide()

		arg_17_0.curItem_ = nil
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_0.typeItem_) do
		iter_17_1:OnExit()
	end

	manager.audio:StopEffect()
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:RemoveAllListeners()

	for iter_18_0, iter_18_1 in pairs(arg_18_0.typeItem_) do
		iter_18_1:Dispose()
	end

	arg_18_0.super.Dispose(arg_18_0)
end

return var_0_0

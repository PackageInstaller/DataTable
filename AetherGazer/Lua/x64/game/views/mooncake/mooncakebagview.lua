local var_0_0 = class("M", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeBagUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.needAdaptRight_ = true

	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.tree_ = LuaTree.New(arg_4_0.treeGo_)

	arg_4_0.tree_:SetSelectedHandler(handler(arg_4_0, arg_4_0.OnGroupSelect))

	arg_4_0.normalList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexNormalItem), arg_4_0.normalListGo_, MoonCakeBagNormalItem)
	arg_4_0.moonCakeList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexExtraItem), arg_4_0.groupListGo_, MoonCakeBagGroupItem)
	arg_4_0.typeController_ = ControllerUtil.GetController(arg_4_0.transform_, "type")
	arg_4_0.clickNormalItemHandler_ = handler(arg_4_0, arg_4_0.OnClickNormalItem)
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.mainActivityID_ = arg_5_0.params_.mainActivityID
	arg_5_0.activityID_ = arg_5_0.params_.activityID

	arg_5_0.tree_:SelectGroup(1)
	arg_5_0:BindRedPoint()
end

function var_0_0.OnTop(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if arg_6_0.curSelectNormalItemIndex_ then
		arg_6_0.normalList_:GetItemList()[arg_6_0.curSelectNormalItemIndex_]:SetData(arg_6_0.normalIdList_[arg_6_0.curSelectNormalItemIndex_], arg_6_0.curSelectNormalItemIndex_)

		arg_6_0.curSelectNormalItemIndex_ = nil
	end
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()

	arg_7_0.curGroupIndex = nil
	arg_7_0.curSelectNormalItemIndex_ = nil

	arg_7_0:UnBindRedPoint()
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.tree_:Dispose()

	arg_8_0.tree_ = nil

	arg_8_0.normalList_:Dispose()

	arg_8_0.normalList_ = nil

	arg_8_0.moonCakeList_:Dispose()

	arg_8_0.moonCakeList_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.OnGroupSelect(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_0.curGroupIndex == arg_9_2 then
		return
	end

	arg_9_0.curGroupIndex = arg_9_2

	if arg_9_2 == MoonCakeConst.BAG_TYPE.MOON_CAKE then
		arg_9_0.moonCakeGroupList_ = MoonCakeTools.GetSortedCakeGroupList(arg_9_0.activityID_)

		arg_9_0.moonCakeList_:StartScroll(#arg_9_0.moonCakeGroupList_)
		arg_9_0.typeController_:SetSelectedState("extra")
	else
		if arg_9_2 == MoonCakeConst.BAG_TYPE.FILLING then
			arg_9_0.normalIdList_ = MoonCakeTools.GetFillingItemIdList(arg_9_0.mainActivityID_)
		elseif arg_9_2 == MoonCakeConst.BAG_TYPE.MATERIAL then
			arg_9_0.normalIdList_ = MoonCakeTools.GetMaterialItemIdList(arg_9_0.mainActivityID_)
		elseif arg_9_2 == MoonCakeConst.BAG_TYPE.GIFT then
			arg_9_0.normalIdList_ = MoonCakeTools.GetGiftItemIdList(arg_9_0.activityID_)
		end

		arg_9_0.normalList_:StartScroll(#arg_9_0.normalIdList_)
		arg_9_0.typeController_:SetSelectedState("normal")
	end
end

function var_0_0.IndexNormalItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_0.normalIdList_[arg_10_1], arg_10_1)
	arg_10_2:SetClickHandler(arg_10_0.clickNormalItemHandler_)
end

function var_0_0.IndexExtraItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:SetData(arg_11_0.moonCakeGroupList_[arg_11_1], arg_11_0.activityID_)
end

function var_0_0.OnReCeiveCakeCollectReward(arg_12_0)
	arg_12_0.moonCakeGroupList_ = MoonCakeTools.GetSortedCakeGroupList(arg_12_0.activityID_)

	arg_12_0.moonCakeList_:StartScroll(#arg_12_0.moonCakeGroupList_)
end

function var_0_0.OnClickNormalItem(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1.number > 0 then
		ShowPopItem(POP_OPERATE_ITEM, {
			arg_13_1.id,
			arg_13_1.number
		})
	else
		ShowPopItem(POP_ITEM, {
			arg_13_1.id,
			arg_13_1.number
		})
	end

	arg_13_0.curSelectNormalItemIndex_ = arg_13_2
end

function var_0_0.BindRedPoint(arg_14_0)
	local var_14_0 = string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, arg_14_0.activityID_)

	manager.redPoint:bindUIandKey(arg_14_0.tree_:GetGroupRedPointContainerById(1), var_14_0)
end

function var_0_0.UnBindRedPoint(arg_15_0)
	local var_15_0 = string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, arg_15_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_15_0.tree_:GetGroupRedPointContainerById(1), var_15_0)
end

return var_0_0

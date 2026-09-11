local M = class("M", ReduxView)

function M:UIName()
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeBagUI"
end

function M:UIParent()
	return manager.ui.uiMain.transform
end

function M:Init()
	self.needAdaptRight_ = true

	self:InitUI()
end

function M:InitUI()
	self:BindCfgUI()

	self.tree_ = LuaTree.New(self.treeGo_)

	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect))

	self.normalList_ = LuaList.New(handler(self, self.IndexNormalItem), self.normalListGo_, MoonCakeBagNormalItem)
	self.moonCakeList_ = LuaList.New(handler(self, self.IndexExtraItem), self.groupListGo_, MoonCakeBagGroupItem)
	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
	self.clickNormalItemHandler_ = handler(self, self.OnClickNormalItem)
end

function M:OnEnter()
	self.mainActivityID_ = self.params_.mainActivityID
	self.activityID_ = self.params_.activityID

	self.tree_:SelectGroup(1)
	self:BindRedPoint()
end

function M:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if self.curSelectNormalItemIndex_ then
		self.normalList_:GetItemList()[self.curSelectNormalItemIndex_]:SetData(self.normalIdList_[self.curSelectNormalItemIndex_], self.curSelectNormalItemIndex_)

		self.curSelectNormalItemIndex_ = nil
	end
end

function M:OnExit()
	manager.windowBar:HideBar()

	self.curGroupIndex = nil
	self.curSelectNormalItemIndex_ = nil

	self:UnBindRedPoint()
end

function M:Dispose()
	self.tree_:Dispose()

	self.tree_ = nil

	self.normalList_:Dispose()

	self.normalList_ = nil

	self.moonCakeList_:Dispose()

	self.moonCakeList_ = nil

	M.super.Dispose(self)
end

function M:OnGroupSelect(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if self.curGroupIndex == arg_9_2 then
		return
	end

	self.curGroupIndex = arg_9_2

	if arg_9_2 == MoonCakeConst.BAG_TYPE.MOON_CAKE then
		self.moonCakeGroupList_ = MoonCakeTools.GetSortedCakeGroupList(self.activityID_)

		self.moonCakeList_:StartScroll(#self.moonCakeGroupList_)
		self.typeController_:SetSelectedState("extra")
	else
		if arg_9_2 == MoonCakeConst.BAG_TYPE.FILLING then
			self.normalIdList_ = MoonCakeTools.GetFillingItemIdList(self.mainActivityID_)
		elseif arg_9_2 == MoonCakeConst.BAG_TYPE.MATERIAL then
			self.normalIdList_ = MoonCakeTools.GetMaterialItemIdList(self.mainActivityID_)
		elseif arg_9_2 == MoonCakeConst.BAG_TYPE.GIFT then
			self.normalIdList_ = MoonCakeTools.GetGiftItemIdList(self.activityID_)
		end

		self.normalList_:StartScroll(#self.normalIdList_)
		self.typeController_:SetSelectedState("normal")
	end
end

function M:IndexNormalItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.normalIdList_[arg_10_1], arg_10_1)
	arg_10_2:SetClickHandler(self.clickNormalItemHandler_)
end

function M:IndexExtraItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(self.moonCakeGroupList_[arg_11_1], self.activityID_)
end

function M:OnReCeiveCakeCollectReward()
	self.moonCakeGroupList_ = MoonCakeTools.GetSortedCakeGroupList(self.activityID_)

	self.moonCakeList_:StartScroll(#self.moonCakeGroupList_)
end

function M:OnClickNormalItem(arg_13_1, arg_13_2)
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

	self.curSelectNormalItemIndex_ = arg_13_2
end

function M:BindRedPoint()
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(1), (string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, self.activityID_)))
end

function M:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(1), (string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, self.activityID_)))
end

return M

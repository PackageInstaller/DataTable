SevenDaySkinPage_4_0 = import("game.views.activity.sign.pages.SevenDaySkinPage_4_0")

local SevenDaySkinPage_5_0 = class("SevenDaySkinPage_5_0", SevenDaySkinPage_4_0)

function SevenDaySkinPage_5_0:RefreshView()
	self.changePage_ = SevenDaySkinData_New:GetDlcReward()
	self.data_ = SevenDaySkinData_New:GetActivityData(self.activityID_)

	local var_1_0 = self.data_.gift_reward

	if self.changePage_ then
		self.pageCon_:SetSelectedIndex(0)
	else
		self.pageCon_:SetSelectedIndex(var_1_0 == 0 and 1 or 0)
	end

	self.freeCon_:SetSelectedIndex(var_1_0 == 0 and 1 or 0)

	if not self.itemData_ then
		self.itemData_ = clone(ItemTemplateData)

		function self.itemData_:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id
			})
		end
	end

	self.itemData_.id = ActivityCumulativeSignCfg[self.activityID_].gift_item_list[1][1]
	self.itemData_.number = ActivityCumulativeSignCfg[self.activityID_].gift_item_list[1][2]

	self.freeItemGo_:SetData(self.itemData_)

	self.sItemNameTxt_.text = ItemCfg[self.itemData_.id].name
	self.descText_.text = GetTips("ACTIVITY_4_0_SIGN_DESC")
	self.titleTxt_.text = GetI18NText(ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].name)
	self.leftTxt_.text = GetTips("SEVENDAY_SKIN_OPTIONAL_HERO")
	self.rightTxt_.text = GetTips("SEVENDAY_SKIN_WELFARE_SIGNIN")

	self:RefreshItems()
end

return SevenDaySkinPage_5_0

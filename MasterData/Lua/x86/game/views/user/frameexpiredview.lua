StoreExpiredView = import("game.views.store.expired.StoreExpiredView")

local FrameExpiredView = class("FrameExpiredView", StoreExpiredView)

function FrameExpiredView:indexItem(arg_1_1, arg_1_2)
	arg_1_2:RefreshData({
		id = self.params_.materialList[arg_1_1].id,
		number = self.params_.materialList[arg_1_1].num,
		timeValid = self.params_.materialList[arg_1_1].timeValid
	})
	arg_1_2:RegistCallBack(function(arg_2_0)
		ShowPopItem(POP_OTHER_ITEM, {
			arg_2_0.id,
			arg_2_0.number,
			0,
			arg_2_0.timeValid
		})
	end)
end

function FrameExpiredView:OnEnter()
	FrameExpiredView.super.OnEnter(self)
	self:RefreshUI()
end

function FrameExpiredView:RefreshUI()
	local var_4_0 = self.titleText1_
	local var_4_1 = self.descText1_

	if #self.getItemDataList_ > 0 then
		var_4_0 = self.titleText2_
		var_4_1 = self.descText2_
	end

	if self.params_.type == ItemConst.ITEM_TYPE.FRAME then
		var_4_0.text = GetTips("PROFILE_AVATAR_FRAME_OVERDUE_TITLE")
		var_4_1.text = GetTips("PROFILE_AVATAR_FRAME_OVERDUE_CONTENT")
	elseif self.params_.type == ItemConst.ITEM_TYPE.CARD_BG then
		var_4_0.text = GetTips("PROFILE_BUSINESS_CARD_OVERDUE_TITLE")
		var_4_1.text = GetTips("PROFILE_BUSINESS_CARD_OVERDUE_CONTENT")
	elseif self.params_.type == ItemConst.ITEM_TYPE.TAG then
		var_4_0.text = GetTips("PROFILE_LABEL_OVERDUE_TITLE")
		var_4_1.text = GetTips("PROFILE_LABEL_OVERDUE_CONTENT")
	end
end

return FrameExpiredView

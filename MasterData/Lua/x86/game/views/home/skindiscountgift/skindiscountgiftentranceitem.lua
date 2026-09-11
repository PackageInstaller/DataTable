local SkinDiscountGiftEntranceItem = class("SkinDiscountGiftEntranceItem", ReduxView)

function SkinDiscountGiftEntranceItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()
end

function SkinDiscountGiftEntranceItem:Dispose()
	SkinDiscountGiftEntranceItem.super.Dispose(self)
	self:DestroyItem()
end

function SkinDiscountGiftEntranceItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "homepage_banner_activity_" .. self.activityID_
		})
		JumpTools.GoToSystem("/skinDiscountGiftMain", {
			activityID = self.activityID_
		}, ViewConst.SYSTEM_ID.SKIN_DISCOUNT_GIFT)
	end)
end

function SkinDiscountGiftEntranceItem:Refresh(arg_5_1)
	SkinDiscountGiftAction.RefresRedPointNewTag(arg_5_1)

	if self.activityID_ ~= arg_5_1 and self.activitySkinItem_ then
		self:UnbindRedPointUI()
		self:DestroyItem()
	end

	self.activityID_ = arg_5_1

	self:BindRedPointUI()

	if not self.activitySkinItem_ then
		local var_5_0 = Asset.Load(SkinDiscountGiftTools.GetEntramceItemPrefabPath(self.activityID_))

		if not isNil(var_5_0) then
			self.activitySkinItem_ = GameObject.Instantiate(var_5_0, self.transform_, false)
			self.activitySkinItem_.transform.anchoredPosition = Vector2.New(0, 0)
		end
	end
end

function SkinDiscountGiftEntranceItem:DestroyItem()
	if self.activitySkinItem_ then
		Object.Destroy(self.activitySkinItem_)

		self.activitySkinItem_ = nil
	end
end

function SkinDiscountGiftEntranceItem:BindRedPointUI()
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DISCOUNT_GIFT) then
		manager.redPoint:bindUIandKey(self.redPointPanel_, RedPointConst.SKIN_DISCOUNT_GIFT .. "_" .. self.activityID_)
	end
end

function SkinDiscountGiftEntranceItem:UnbindRedPointUI()
	manager.redPoint:unbindUIandKey(self.redPointPanel_, RedPointConst.SKIN_DISCOUNT_GIFT .. "_" .. self.activityID_)
end

function SkinDiscountGiftEntranceItem:OnExit()
	self:UnbindRedPointUI()
end

return SkinDiscountGiftEntranceItem

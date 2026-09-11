local ActivitySkinDrawEntraceItem = class("ActivitySkinDrawEntraceItem", ReduxView)

function ActivitySkinDrawEntraceItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivitySkinDrawEntraceItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawEntraceItem:InitUI()
	self:BindCfgUI()

	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
end

function ActivitySkinDrawEntraceItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		self:OnClickBtn()
	end)
end

function ActivitySkinDrawEntraceItem:OnEnter()
	return
end

function ActivitySkinDrawEntraceItem:OnClickBtn()
	if ActivityTemplateConst.ACTIVITY_SKIN_DRAW == ActivityTools.GetActivityType(self.activityID_) then
		ActivitySkinDrawTools.OnJumpToSkinDraw(self.activityID_)
	elseif ActivityTemplateConst.ACTIVITY_OATH_DRAW_MAIN == ActivityTools.GetActivityType(self.activityID_) then
		if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW) and ActivityData:GetActivityData(self.activityID_):IsActivitying() then
			local var_7_0 = ActivityOathDrawAction.GetNowSkinKey(self.activityID_)

			if not getData("OathDrawNew", var_7_0) then
				saveData("OathDrawNew", var_7_0, 1)
				manager.redPoint:setTip(RedPointConst.OATH_DRAW_NEW, 0, RedPointStyle.SHOW_NEW_TAG)
			end

			JumpTools.OpenPageByJump("/activityOathDrawMainView", {
				activityID = self.activityID_
			})
		else
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.SKIN_DRAW, JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW)))
		end
	end
end

function ActivitySkinDrawEntraceItem:GetLoadGoPath()
	if ActivityTemplateConst.ACTIVITY_SKIN_DRAW == ActivityTools.GetActivityType(self.activityID_) then
		return T0SkinDrawCfg[self.activityID_].enterItem
	elseif ActivityTemplateConst.ACTIVITY_OATH_DRAW_MAIN == ActivityTools.GetActivityType(self.activityID_) then
		return WeddingSkinDrawCfg[self.activityID_].enterItem
	end

	return nil
end

function ActivitySkinDrawEntraceItem:Refresh(arg_9_1)
	self.activityID_ = arg_9_1

	if not self.activitySkinItem_ then
		local var_9_0 = Asset.Load((self:GetLoadGoPath()))

		if not isNil(var_9_0) then
			self.activitySkinItem_ = GameObject.Instantiate(var_9_0, self.transform_, false)
			self.activitySkinItem_.transform.anchoredPosition = Vector2.New(0, 0)
		end
	end

	self:BindRedPointUI()
end

function ActivitySkinDrawEntraceItem:BindRedPointUI()
	if ActivityData:GetActivityIsOpen(self.activityID_) and not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW) and self.redPointPanel_ then
		manager.redPoint:bindUIandKey(self.redPointPanel_, RedPointConst.ACTIVITY_DRAW .. "_" .. self.activityID_)
	end
end

function ActivitySkinDrawEntraceItem:UnbindRedPointUI()
	if self.redPointPanel_ then
		manager.redPoint:unbindUIandKey(self.redPointPanel_, RedPointConst.ACTIVITY_DRAW .. "_" .. self.activityID_)
	end
end

function ActivitySkinDrawEntraceItem:Dispose()
	self:UnbindRedPointUI()
	self:RemoveAllListeners()
	ActivitySkinDrawEntraceItem.super.Dispose(self)
end

return ActivitySkinDrawEntraceItem

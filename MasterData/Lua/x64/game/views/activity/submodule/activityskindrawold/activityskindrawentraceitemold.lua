local ActivitySkinDrawEntraceItemOld = class("ActivitySkinDrawEntraceItemOld", ReduxView)

function ActivitySkinDrawEntraceItemOld:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivitySkinDrawEntraceItemOld:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawEntraceItemOld:InitUI()
	self:BindCfgUI()
end

function ActivitySkinDrawEntraceItemOld:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if ActivityData:GetActivityData(self.activityID_):IsActivitying() then
			if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW) then
				local var_5_0 = ActivitySkinDrawDataOld:GetStartStoryId()

				if var_5_0 and not manager.story:IsStoryPlayed(var_5_0) then
					manager.notify:Invoke(MUTE_MAIN_AUDIO)
					manager.story:StartStoryById(var_5_0, function()
						manager.loadScene:ForceSetShouldLoadSceneName("home", function()
							JumpTools.GoToSystem("/activityskinDrawOld", {
								checkReward = true,
								activityID = self.activityID_
							}, ViewConst.SYSTEM_ID.SKIN_DRAW)
						end)
					end)
				else
					JumpTools.GoToSystem("/activityskinDrawOld", {
						checkReward = true,
						activityID = self.activityID_
					}, ViewConst.SYSTEM_ID.SKIN_DRAW)
				end
			else
				ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.SKIN_DRAW, JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW)))
			end
		end
	end)
end

function ActivitySkinDrawEntraceItemOld:OnEnter()
	return
end

function ActivitySkinDrawEntraceItemOld:Refresh(arg_9_1)
	self.activityID_ = arg_9_1

	self:BindRedPointUI()

	if not self.activitySkinItem_ then
		local var_9_0 = Asset.Load(T0SkinDrawCfg[arg_9_1].enterItem)

		if not isNil(var_9_0) then
			self.activitySkinItem_ = GameObject.Instantiate(var_9_0, self.transform_, false)
			self.activitySkinItem_.transform.anchoredPosition = Vector2.New(0, 0)
		end
	end

	local var_9_1 = ActivitySkinDrawDataOld:GetStartStoryId()

	self.typeCon_ = ControllerUtil.GetController(self.activitySkinItem_.transform, "type")

	self.typeCon_:SetSelectedState(var_9_1 and not manager.story:IsStoryPlayed(var_9_1) and "story" or "draw")
end

function ActivitySkinDrawEntraceItemOld:BindRedPointUI()
	if ActivityData:GetActivityIsOpen(self.activityID_) and not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW) and self.redPointPanel_ then
		manager.redPoint:bindUIandKey(self.redPointPanel_, RedPointConst.ACTIVITY_DRAW .. "_" .. self.activityID_)
	end
end

function ActivitySkinDrawEntraceItemOld:UnbindRedPointUI()
	if ActivityData:GetActivityIsOpen(self.activityID_) and not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW) and self.redPointPanel_ then
		manager.redPoint:unbindUIandKey(self.redPointPanel_, RedPointConst.ACTIVITY_DRAW .. "_" .. self.activityID_)
	end
end

function ActivitySkinDrawEntraceItemOld:OnExit()
	self:UnbindRedPointUI()
end

function ActivitySkinDrawEntraceItemOld:Dispose()
	self:RemoveAllListeners()
	ActivitySkinDrawEntraceItemOld.super.Dispose(self)
end

return ActivitySkinDrawEntraceItemOld

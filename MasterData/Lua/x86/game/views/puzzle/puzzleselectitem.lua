local PuzzleSelectItem = class("PuzzleSelectItem", ReduxView)

function PuzzleSelectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:Init()
end

function PuzzleSelectItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.lockStateController_ = ControllerUtil.GetController(self.transform_, "lock")
	self.completedController_ = ControllerUtil.GetController(self.transform_, "complete")
	self.enterGameController_ = ControllerUtil.GetController(self.transform_, "enterGame")
end

function PuzzleSelectItem:InitUI()
	self:BindCfgUI()
end

function PuzzleSelectItem:AddUIListener()
	self:AddBtnListener(self.Btn_, nil, function()
		if self.isLock_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.openTime_)))

			return
		end

		if manager.time:GetServerTime() >= self.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleData:SetSelectActivity(self.activityID_)

		if self.clickCallBack_ ~= nil then
			self.clickCallBack_(self.index_, self.activityID_)
		end

		self.transform_:SetAsLastSibling()
	end)
end

local var_0_1 = 0.25
local var_0_2 = 0.25
local var_0_3
local var_0_4
local var_0_5
local var_0_6
local var_0_8 = Vector2(1, 1)

function PuzzleSelectItem:OnClickItem(arg_6_1)
	if self.index_ == arg_6_1 then
		var_0_3 = PuzzleTool:GetPuzzlePanelWidth()
		var_0_4 = var_0_3 / self.drawTrans_.rect.width
		var_0_5 = Vector3(var_0_4, var_0_4, 1)

		PuzzleTool:ScaleBg(var_0_4)

		var_0_6 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

		local var_6_0, var_6_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.parentTrans_, manager.ui.mainCameraCom_:WorldToScreenPoint(PuzzleTool:GetPanelTrans().position), var_0_6, var_0_8)
		local var_6_2 = Vector3(var_6_1.x, var_6_1.y, 1)

		self.transform_.pivot.x = self.transform_.pivot.x - 0.5
		self.transform_.pivot.y = self.transform_.pivot.y - 0.5
		var_6_2.x = var_6_2.x + self.transform_.pivot.x * (self.transform_.rect.width * var_0_4)
		var_6_2.y = var_6_2.y + self.transform_.pivot.y * (self.transform_.rect.height * var_0_4)
		self.originPos_ = self.transform_.localPosition
		self.originScale_ = self.transform_.localScale

		manager.notify:Invoke(PUZZLE_GAME_ANIM_START)

		self.posLeanTween_ = LeanTween.moveLocal(self.gameObject_, var_6_2, var_0_1):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
			manager.notify:Invoke(PUZZLE_GAME_ANIM_END)

			if self.posLeanTween_ then
				self.posLeanTween_:setOnComplete(nil)

				self.posLeanTween_ = nil
			end

			self.enterGameController_:SetSelectedState("true")
		end))

		manager.notify:Invoke(PUZZLE_GAME_ANIM_START)

		self.scaleLeanTween_ = LeanTween.scale(self.transform_, var_0_5, var_0_2):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
			manager.notify:Invoke(PUZZLE_GAME_ANIM_END)

			if self.scaleLeanTween_ then
				self.scaleLeanTween_:setOnComplete(nil)

				self.scaleLeanTween_ = nil
			end
		end))

		self:EnterGamePlay()
	else
		self.fadeAnim_.enabled = true

		self.fadeAnim_:Play("VolumePuzzleMainUI_itemFade", -1, 0)
	end
end

function PuzzleSelectItem:EnterGamePlay()
	if not PuzzleData:IsCompleted(self.activityID_) then
		self.startAnim_.enabled = true

		local var_9_0 = "VolumePuzzleMainUI_mess"

		self.startAnim_:Play("VolumePuzzleMainUI_mess", -1, 0)
		manager.notify:Invoke(PUZZLE_GAME_ANIM_START)

		if self.timer_ then
			self.timer_:Stop()

			self.timer_ = nil
		end

		self.timer_ = Timer.New(function()
			local var_10_0 = self.startAnim_:GetCurrentAnimatorStateInfo(0)

			if var_10_0:IsName(var_9_0) and var_10_0.normalizedTime >= 1 then
				manager.notify:Invoke(PUZZLE_GAME_ANIM_END)

				if self.timer_ ~= nil then
					self.timer_:Stop()

					self.timer_ = nil
				end

				self.startAnim_.enabled = false
			end
		end, 0.033, -1)

		self.timer_:Start()
		manager.audio:PlayEffect("minigame_activity_1_3", "minigame_puzzleselect", "")
	end

	self:Go("puzzleSelect", {
		mainActivityID = self.mainActivityID_,
		activityID = self.activityID_
	})
	PuzzleTool:RefreshPuzzleBg(self.activityID_)
end

function PuzzleSelectItem:SetClickCallBack(arg_11_1)
	self.clickCallBack_ = arg_11_1
end

function PuzzleSelectItem:SetData(arg_12_1, arg_12_2, arg_12_3)
	self.index_ = arg_12_3

	if self.activityID_ == nil then
		self.redPointStr_ = string.format("%s_%s_%s", RedPointConst.ACTIVITY_PUZZLE, arg_12_1, arg_12_2)

		manager.redPoint:bindUIandKey(self.panelTrans_, self.redPointStr_)
	elseif self.activityID_ ~= arg_12_2 then
		manager.redPoint:unbindUIandKey(self.panelTrans_, self.redPointStr_)

		self.redPointStr_ = string.format("%s_%s_%s", RedPointConst.ACTIVITY_PUZZLE, arg_12_1, arg_12_2)

		manager.redPoint:bindUIandKey(self.panelTrans_, self.redPointStr_)
	end

	self.mainActivityID_ = arg_12_1
	self.activityID_ = arg_12_2

	local var_12_0 = ActivityData:GetActivityData(self.activityID_)

	self.openTime_ = var_12_0.startTime
	self.stopTime_ = var_12_0.stopTime
	self.isLock_ = manager.time:GetServerTime() < self.openTime_

	self:RefreshUI()
end

function PuzzleSelectItem:RefreshUI()
	self.isLock_ = manager.time:GetServerTime() < self.openTime_

	self.lockStateController_:SetSelectedState(tostring(self.isLock_))
	self:RefreshLock()
	self:RefreshCompletedState()
end

function PuzzleSelectItem:RefreshLock()
	if not self.isLock_ then
		return
	end

	self.isLock_ = manager.time:GetServerTime() < self.openTime_

	if self.isLock_ then
		self.openTimeText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(self.openTime_))
	else
		self.lockStateController_:SetSelectedState("false")
	end
end

function PuzzleSelectItem:RefreshCompletedState()
	if not PuzzleData:IsCompleted(self.activityID_) then
		self.completedController_:SetSelectedState("false")
	else
		self.completedController_:SetSelectedState("true")
	end
end

function PuzzleSelectItem:UnRegisterRedPoint()
	manager.redPoint:unbindUIandKey(self.panelTrans_, (string.format("%s_%s_%s", RedPointConst.ACTIVITY_PUZZLE, ActivityPuzzleCfg[self.activityID_].main_activity_id, self.activityID_)))
end

function PuzzleSelectItem:OnExit()
	self:Reset()
end

function PuzzleSelectItem:Dispose()
	self:UnRegisterRedPoint()
	PuzzleSelectItem.super.Dispose(self)
end

function PuzzleSelectItem:Reset()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	if self.posLeanTween_ then
		self.posLeanTween_:setOnComplete(nil)
		LeanTween.cancel(self.gameObject_)

		self.posLeanTween_ = nil
	end

	if self.scaleLeanTween_ then
		self.scaleLeanTween_:setOnComplete(nil)
		LeanTween.cancel(self.gameObject_)

		self.scaleLeanTween_ = nil
	end

	if self.originPos_ ~= nil then
		self.transform_.localPosition = self.originPos_
		self.originPos_ = nil
	end

	if self.originScale_ ~= nil then
		self.transform_.localScale = self.originScale_
		self.originScale_ = nil
	end

	self.fadeAnim_.enabled = false
	self.canvasGroup_.alpha = 1

	self.enterGameController_:SetSelectedState("false")
end

return PuzzleSelectItem

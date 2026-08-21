local var_0_0 = class("PuzzleSelectItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.lockStateController_ = ControllerUtil.GetController(arg_2_0.transform_, "lock")
	arg_2_0.completedController_ = ControllerUtil.GetController(arg_2_0.transform_, "complete")
	arg_2_0.enterGameController_ = ControllerUtil.GetController(arg_2_0.transform_, "enterGame")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.Btn_, nil, function()
		if arg_4_0.isLock_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_4_0.openTime_)))

			return
		end

		if manager.time:GetServerTime() >= arg_4_0.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		PuzzleData:SetSelectActivity(arg_4_0.activityID_)

		if arg_4_0.clickCallBack_ ~= nil then
			arg_4_0.clickCallBack_(arg_4_0.index_, arg_4_0.activityID_)
		end

		arg_4_0.transform_:SetAsLastSibling()
	end)
end

local var_0_1 = 0.25
local var_0_2 = 0.25
local var_0_3
local var_0_4
local var_0_5
local var_0_6
local var_0_7
local var_0_8 = Vector2(1, 1)

function var_0_0.OnClickItem(arg_6_0, arg_6_1)
	if arg_6_0.index_ == arg_6_1 then
		var_0_3 = PuzzleTool:GetPuzzlePanelWidth()
		var_0_4 = var_0_3 / arg_6_0.drawTrans_.rect.width
		var_0_5 = Vector3(var_0_4, var_0_4, 1)

		PuzzleTool:ScaleBg(var_0_4)

		var_0_6 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

		local var_6_0 = manager.ui.mainCameraCom_
		local var_6_1 = PuzzleTool:GetPanelTrans()
		local var_6_2 = var_6_0:WorldToScreenPoint(var_6_1.position)
		local var_6_3, var_6_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_6_0.parentTrans_, var_6_2, var_0_6, var_0_8)
		local var_6_5 = Vector3(var_6_4.x, var_6_4.y, 1)
		local var_6_6 = arg_6_0.transform_.rect.width * var_0_4
		local var_6_7 = arg_6_0.transform_.rect.height * var_0_4
		local var_6_8 = arg_6_0.transform_.pivot

		var_6_8.x = var_6_8.x - 0.5
		var_6_8.y = var_6_8.y - 0.5
		var_6_5.x = var_6_5.x + var_6_8.x * var_6_6
		var_6_5.y = var_6_5.y + var_6_8.y * var_6_7
		arg_6_0.originPos_ = arg_6_0.transform_.localPosition
		arg_6_0.originScale_ = arg_6_0.transform_.localScale

		manager.notify:Invoke(PUZZLE_GAME_ANIM_START)

		arg_6_0.posLeanTween_ = LeanTween.moveLocal(arg_6_0.gameObject_, var_6_5, var_0_1):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
			manager.notify:Invoke(PUZZLE_GAME_ANIM_END)

			if arg_6_0.posLeanTween_ then
				arg_6_0.posLeanTween_:setOnComplete(nil)

				arg_6_0.posLeanTween_ = nil
			end

			arg_6_0.enterGameController_:SetSelectedState("true")
		end))

		manager.notify:Invoke(PUZZLE_GAME_ANIM_START)

		arg_6_0.scaleLeanTween_ = LeanTween.scale(arg_6_0.transform_, var_0_5, var_0_2):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
			manager.notify:Invoke(PUZZLE_GAME_ANIM_END)

			if arg_6_0.scaleLeanTween_ then
				arg_6_0.scaleLeanTween_:setOnComplete(nil)

				arg_6_0.scaleLeanTween_ = nil
			end
		end))

		arg_6_0:EnterGamePlay()
	else
		arg_6_0.fadeAnim_.enabled = true

		arg_6_0.fadeAnim_:Play("VolumePuzzleMainUI_itemFade", -1, 0)
	end
end

function var_0_0.EnterGamePlay(arg_9_0)
	if not PuzzleData:IsCompleted(arg_9_0.activityID_) then
		arg_9_0.startAnim_.enabled = true

		local var_9_0 = "VolumePuzzleMainUI_mess"

		arg_9_0.startAnim_:Play(var_9_0, -1, 0)
		manager.notify:Invoke(PUZZLE_GAME_ANIM_START)

		if arg_9_0.timer_ then
			arg_9_0.timer_:Stop()

			arg_9_0.timer_ = nil
		end

		arg_9_0.timer_ = Timer.New(function()
			local var_10_0 = arg_9_0.startAnim_:GetCurrentAnimatorStateInfo(0)

			if var_10_0:IsName(var_9_0) and var_10_0.normalizedTime >= 1 then
				manager.notify:Invoke(PUZZLE_GAME_ANIM_END)

				if arg_9_0.timer_ ~= nil then
					arg_9_0.timer_:Stop()

					arg_9_0.timer_ = nil
				end

				arg_9_0.startAnim_.enabled = false
			end
		end, 0.033, -1)

		arg_9_0.timer_:Start()
		manager.audio:PlayEffect("minigame_activity_1_3", "minigame_puzzleselect", "")
	end

	arg_9_0:Go("puzzleSelect", {
		mainActivityID = arg_9_0.mainActivityID_,
		activityID = arg_9_0.activityID_
	})
	PuzzleTool:RefreshPuzzleBg(arg_9_0.activityID_)
end

function var_0_0.SetClickCallBack(arg_11_0, arg_11_1)
	arg_11_0.clickCallBack_ = arg_11_1
end

function var_0_0.SetData(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0.index_ = arg_12_3

	if arg_12_0.activityID_ == nil then
		arg_12_0.redPointStr_ = string.format("%s_%s_%s", RedPointConst.ACTIVITY_PUZZLE, arg_12_1, arg_12_2)

		manager.redPoint:bindUIandKey(arg_12_0.panelTrans_, arg_12_0.redPointStr_)
	elseif arg_12_0.activityID_ ~= arg_12_2 then
		manager.redPoint:unbindUIandKey(arg_12_0.panelTrans_, arg_12_0.redPointStr_)

		arg_12_0.redPointStr_ = string.format("%s_%s_%s", RedPointConst.ACTIVITY_PUZZLE, arg_12_1, arg_12_2)

		manager.redPoint:bindUIandKey(arg_12_0.panelTrans_, arg_12_0.redPointStr_)
	end

	arg_12_0.mainActivityID_ = arg_12_1
	arg_12_0.activityID_ = arg_12_2

	local var_12_0 = ActivityData:GetActivityData(arg_12_0.activityID_)

	arg_12_0.openTime_ = var_12_0.startTime
	arg_12_0.stopTime_ = var_12_0.stopTime
	arg_12_0.isLock_ = manager.time:GetServerTime() < arg_12_0.openTime_

	arg_12_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0.isLock_ = manager.time:GetServerTime() < arg_13_0.openTime_

	arg_13_0.lockStateController_:SetSelectedState(tostring(arg_13_0.isLock_))
	arg_13_0:RefreshLock()
	arg_13_0:RefreshCompletedState()
end

function var_0_0.RefreshLock(arg_14_0)
	if not arg_14_0.isLock_ then
		return
	end

	arg_14_0.isLock_ = manager.time:GetServerTime() < arg_14_0.openTime_

	if arg_14_0.isLock_ then
		arg_14_0.openTimeText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_14_0.openTime_))
	else
		arg_14_0.lockStateController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshCompletedState(arg_15_0)
	if not PuzzleData:IsCompleted(arg_15_0.activityID_) then
		arg_15_0.completedController_:SetSelectedState("false")
	else
		arg_15_0.completedController_:SetSelectedState("true")
	end
end

function var_0_0.UnRegisterRedPoint(arg_16_0)
	local var_16_0 = ActivityPuzzleCfg[arg_16_0.activityID_].main_activity_id
	local var_16_1 = string.format("%s_%s_%s", RedPointConst.ACTIVITY_PUZZLE, var_16_0, arg_16_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_16_0.panelTrans_, var_16_1)
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0:Reset()
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:UnRegisterRedPoint()
	var_0_0.super.Dispose(arg_18_0)
end

function var_0_0.Reset(arg_19_0)
	if arg_19_0.timer_ then
		arg_19_0.timer_:Stop()

		arg_19_0.timer_ = nil
	end

	if arg_19_0.posLeanTween_ then
		arg_19_0.posLeanTween_:setOnComplete(nil)
		LeanTween.cancel(arg_19_0.gameObject_)

		arg_19_0.posLeanTween_ = nil
	end

	if arg_19_0.scaleLeanTween_ then
		arg_19_0.scaleLeanTween_:setOnComplete(nil)
		LeanTween.cancel(arg_19_0.gameObject_)

		arg_19_0.scaleLeanTween_ = nil
	end

	if arg_19_0.originPos_ ~= nil then
		arg_19_0.transform_.localPosition = arg_19_0.originPos_
		arg_19_0.originPos_ = nil
	end

	if arg_19_0.originScale_ ~= nil then
		arg_19_0.transform_.localScale = arg_19_0.originScale_
		arg_19_0.originScale_ = nil
	end

	arg_19_0.fadeAnim_.enabled = false
	arg_19_0.canvasGroup_.alpha = 1

	arg_19_0.enterGameController_:SetSelectedState("false")
end

return var_0_0

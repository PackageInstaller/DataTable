local var_0_0 = import("game.extend.ReduxView")
local var_0_1 = class("StoryShakePictureGame", var_0_0)

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.storyPlayer_ = arg_1_1
	arg_1_0.prefabPath = "Widget/System/Story/ActionPrefab/StoryAction_4_0_Panel"
	arg_1_0.gameObject_ = Object.Instantiate(Asset.Load(arg_1_0.prefabPath), arg_1_0.storyPlayer_.showGo_.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.gameObject_.name = "photoitem"

	arg_1_0:Init()
end

function var_0_1.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListener()
end

function var_0_1.AddListener(arg_3_0)
	arg_3_0.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_3_0, arg_3_0.BeginDrag)))
	arg_3_0.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(arg_3_0, arg_3_0.Drag)))
	arg_3_0.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_3_0, arg_3_0.EndDrag)))
end

function var_0_1.SetData(arg_4_0, arg_4_1)
	arg_4_0.params_ = arg_4_1
	arg_4_0.pictureImg_.sprite = pureGetSpriteWithoutAtlas(arg_4_0.params_.path)

	arg_4_0:InitGame()
end

function var_0_1.InitGame(arg_5_0)
	arg_5_0:InitGameStatus()
	arg_5_0:StartGame()
	arg_5_0:PlayStartAnim()
end

function var_0_1.InitGameStatus(arg_6_0)
	arg_6_0.gameStatus_ = "start"
	arg_6_0.moveHorizontalDistancePerShake_ = arg_6_0.params_.moveHorizontalDistancePerShake
	arg_6_0.shakeTimes_ = arg_6_0.params_.shakeTimes
	arg_6_0.curProgress_ = 0
	arg_6_0.maxProgress_ = 100
	arg_6_0.deltaProgress_ = math.ceil(1 / arg_6_0.shakeTimes_ * 100)
	arg_6_0.isMoveRight_ = true
	arg_6_0.nextMoveIsRight_ = nil
	arg_6_0.accumulatedMoveDistance_ = 0
end

function var_0_1.StartGame(arg_7_0)
	arg_7_0.pictureTrans_.localPosition = Vector3.New(0, 0, 0)
	arg_7_0.maskCanvasGroup_.alpha = 1
	arg_7_0.storyPlayer_.allBtn_.enabled = false

	arg_7_0.storyPlayer_.hideAllUIController_:SetSelectedState("true")

	arg_7_0.storyAutoPlay_ = arg_7_0.storyPlayer_.auto_
	arg_7_0.storyPlayer_.auto_ = false

	SetActive(arg_7_0.storyPlayer_.showGo_, true)
	SetActive(arg_7_0.tipsPanelGo_, true)
end

function var_0_1.EndGame(arg_8_0)
	arg_8_0.gameStatus_ = "end"

	arg_8_0:PlayEndAnim()
end

function var_0_1.ExitGame(arg_9_0)
	arg_9_0.storyPlayer_.allBtn_.enabled = true
	arg_9_0.storyPlayer_.auto_ = arg_9_0.storyAutoPlay_

	SetActive(arg_9_0.storyPlayer_.showGo_, false)
	arg_9_0.storyPlayer_.playNext_(1)
	AnimatorTools.Stop()
	FrameTimer.New(function()
		arg_9_0.storyPlayer_.hideAllUIController_:SetSelectedState("false")
	end, 1, 1):Start()
end

function var_0_1.IsValidShake(arg_11_0)
	return arg_11_0.accumulatedMoveDistance_ >= arg_11_0.moveHorizontalDistancePerShake_
end

function var_0_1.Shake(arg_12_0)
	arg_12_0.curProgress_ = arg_12_0.curProgress_ + arg_12_0.deltaProgress_
	arg_12_0.accumulatedMoveDistance_ = 0
	arg_12_0.nextMoveIsRight_ = not arg_12_0.isMoveRight_
	arg_12_0.maskCanvasGroup_.alpha = 1 - arg_12_0.curProgress_ / arg_12_0.maxProgress_
end

function var_0_1.PlayStartAnim(arg_13_0)
	SetActive(arg_13_0.tipsPanelGo_, false)

	arg_13_0.enterAnim_.enabled = true

	arg_13_0.enterAnim_:Update(0)
	AnimatorTools.PlayAnimatorWithCallback(arg_13_0.enterAnim_, "StoryAction_4_0_Panel", function()
		arg_13_0.gameStatus_ = "play"

		SetActive(arg_13_0.tipsPanelGo_, true)

		arg_13_0.enterAnim_.enabled = false
	end)
end

function var_0_1.PlayEndAnim(arg_15_0)
	arg_15_0:StartResetPosAnim(function()
		AnimatorTools.PlayAnimationWithCallback(arg_15_0.completeAnim_, "StoryAction_4_0", function()
			arg_15_0:ExitGame()
		end)
	end)
end

function var_0_1.StartResetPosAnim(arg_18_0, arg_18_1)
	arg_18_0:StopResetPosAnim()

	arg_18_0.accumulatedMoveDistance_ = 0
	arg_18_0.resetPosTween_ = LeanTween.moveLocal(arg_18_0.pictureGo_, Vector3.New(0, 0, 0), 0.15)

	arg_18_0.resetPosTween_:setEase(LeanTweenType.easeInOutQuad):setOnComplete(System.Action(function()
		LeanTween.cancel(arg_18_0.pictureGo_)
		arg_18_0.resetPosTween_:setOnUpdate(nil):setOnComplete(nil)

		if arg_18_1 then
			arg_18_1()
		end
	end))
end

function var_0_1.StopResetPosAnim(arg_20_0)
	if arg_20_0.resetPosTween_ then
		LeanTween.cancel(arg_20_0.pictureGo_)
		arg_20_0.resetPosTween_:setOnUpdate(nil):setOnComplete(nil)

		arg_20_0.resetPosTween_ = nil
	end
end

function var_0_1.BeginDrag(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0.gameStatus_ ~= "play" then
		return
	end

	SetActive(arg_21_0.tipsPanelGo_, false)
	arg_21_0:StopResetPosAnim()
end

function var_0_1.Drag(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0.gameStatus_ ~= "play" then
		return
	end

	arg_22_0:ProcessMove(arg_22_2)

	if arg_22_0:IsValidShake() then
		arg_22_0:Shake()
	end

	if arg_22_0.curProgress_ >= arg_22_0.maxProgress_ then
		arg_22_0:EndGame()
	end
end

function var_0_1.ProcessMove(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.delta * manager.ui.canvasRate
	local var_23_1 = arg_23_0.pictureTrans_:GetLocalPosition()

	var_23_1.x = var_23_1.x + var_23_0.x
	var_23_1.y = var_23_1.y + var_23_0.y

	arg_23_0.pictureTrans_:SetLocalPosition(var_23_1)

	local var_23_2 = var_23_0.x > 0

	if var_23_2 ~= arg_23_0.isMoveRight_ then
		arg_23_0.isMoveRight_ = var_23_2
		arg_23_0.accumulatedMoveDistance_ = 0
	end

	if arg_23_0.nextMoveIsRight_ == nil then
		arg_23_0.nextMoveIsRight_ = arg_23_0.isMoveRight_
	end

	if arg_23_0.isMoveRight_ ~= arg_23_0.nextMoveIsRight_ then
		arg_23_0.accumulatedMoveDistance_ = 0
	end

	arg_23_0.accumulatedMoveDistance_ = arg_23_0.accumulatedMoveDistance_ + math.abs(var_23_0.x)
end

function var_0_1.EndDrag(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0.gameStatus_ ~= "play" then
		return
	end

	if arg_24_0.curProgress_ < arg_24_0.maxProgress_ then
		arg_24_0:StartResetPosAnim(function()
			SetActive(arg_24_0.tipsPanelGo_, true)
		end)
	end
end

function var_0_1.Dispose(arg_26_0)
	print("Dispose Shake Picture Game !!!!!!!!!!!!!!!")
	Asset.Unload(arg_26_0.prefabPath)
	arg_26_0.dragEventListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_26_0.dragEventListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	arg_26_0.dragEventListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	var_0_1.super.Dispose(arg_26_0)
end

return var_0_1

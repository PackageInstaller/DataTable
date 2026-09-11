local StoryShakePictureGame = class("StoryShakePictureGame", (import("game.extend.ReduxView")))

function StoryShakePictureGame:Ctor(arg_1_1)
	self.storyPlayer_ = arg_1_1
	self.prefabPath = "Widget/System/Story/ActionPrefab/StoryAction_4_0_Panel"
	self.gameObject_ = Object.Instantiate(Asset.Load(self.prefabPath), self.storyPlayer_.showGo_.transform)
	self.transform_ = self.gameObject_.transform
	self.gameObject_.name = "photoitem"

	self:Init()
end

function StoryShakePictureGame:Init()
	self:BindCfgUI()
	self:AddListener()
end

function StoryShakePictureGame:AddListener()
	self.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginDrag)))
	self.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(self, self.Drag)))
	self.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDrag)))
end

function StoryShakePictureGame:SetData(arg_4_1)
	self.params_ = arg_4_1
	self.pictureImg_.sprite = pureGetSpriteWithoutAtlas(self.params_.path)

	self:InitGame()
end

function StoryShakePictureGame:InitGame()
	self:InitGameStatus()
	self:StartGame()
	self:PlayStartAnim()
end

function StoryShakePictureGame:InitGameStatus()
	self.gameStatus_ = "start"
	self.moveHorizontalDistancePerShake_ = self.params_.moveHorizontalDistancePerShake
	self.shakeTimes_ = self.params_.shakeTimes
	self.curProgress_ = 0
	self.maxProgress_ = 100
	self.deltaProgress_ = math.ceil(1 / self.shakeTimes_ * 100)
	self.isMoveRight_ = true
	self.nextMoveIsRight_ = nil
	self.accumulatedMoveDistance_ = 0
end

function StoryShakePictureGame:StartGame()
	self.pictureTrans_.localPosition = Vector3.New(0, 0, 0)
	self.maskCanvasGroup_.alpha = 1
	self.storyPlayer_.allBtn_.enabled = false

	self.storyPlayer_.hideAllUIController_:SetSelectedState("true")

	self.storyAutoPlay_ = self.storyPlayer_.auto_
	self.storyPlayer_.auto_ = false

	SetActive(self.storyPlayer_.showGo_, true)
	SetActive(self.tipsPanelGo_, true)
end

function StoryShakePictureGame:EndGame()
	self.gameStatus_ = "end"

	self:PlayEndAnim()
end

function StoryShakePictureGame:ExitGame()
	self.storyPlayer_.allBtn_.enabled = true
	self.storyPlayer_.auto_ = self.storyAutoPlay_

	SetActive(self.storyPlayer_.showGo_, false)
	self.storyPlayer_.playNext_(1)
	AnimatorTools.Stop()
	FrameTimer.New(function()
		self.storyPlayer_.hideAllUIController_:SetSelectedState("false")
	end, 1, 1):Start()
end

function StoryShakePictureGame:IsValidShake()
	return self.accumulatedMoveDistance_ >= self.moveHorizontalDistancePerShake_
end

function StoryShakePictureGame:Shake()
	self.curProgress_ = self.curProgress_ + self.deltaProgress_
	self.accumulatedMoveDistance_ = 0
	self.nextMoveIsRight_ = not self.isMoveRight_
	self.maskCanvasGroup_.alpha = 1 - self.curProgress_ / self.maxProgress_
end

function StoryShakePictureGame:PlayStartAnim()
	SetActive(self.tipsPanelGo_, false)

	self.enterAnim_.enabled = true

	self.enterAnim_:Update(0)
	AnimatorTools.PlayAnimatorWithCallback(self.enterAnim_, "StoryAction_4_0_Panel", function()
		self.gameStatus_ = "play"

		SetActive(self.tipsPanelGo_, true)

		self.enterAnim_.enabled = false
	end)
end

function StoryShakePictureGame:PlayEndAnim()
	self:StartResetPosAnim(function()
		AnimatorTools.PlayAnimationWithCallback(self.completeAnim_, "StoryAction_4_0", function()
			self:ExitGame()
		end)
	end)
end

function StoryShakePictureGame:StartResetPosAnim(arg_18_1)
	self:StopResetPosAnim()

	self.accumulatedMoveDistance_ = 0
	self.resetPosTween_ = LeanTween.moveLocal(self.pictureGo_, Vector3.New(0, 0, 0), 0.15)

	self.resetPosTween_:setEase(LeanTweenType.easeInOutQuad):setOnComplete(System.Action(function()
		LeanTween.cancel(self.pictureGo_)
		self.resetPosTween_:setOnUpdate(nil):setOnComplete(nil)

		if arg_18_1 then
			arg_18_1()
		end
	end))
end

function StoryShakePictureGame:StopResetPosAnim()
	if self.resetPosTween_ then
		LeanTween.cancel(self.pictureGo_)
		self.resetPosTween_:setOnUpdate(nil):setOnComplete(nil)

		self.resetPosTween_ = nil
	end
end

function StoryShakePictureGame:BeginDrag(arg_21_1, arg_21_2)
	if self.gameStatus_ ~= "play" then
		return
	end

	SetActive(self.tipsPanelGo_, false)
	self:StopResetPosAnim()
end

function StoryShakePictureGame:Drag(arg_22_1, arg_22_2)
	if self.gameStatus_ ~= "play" then
		return
	end

	self:ProcessMove(arg_22_2)

	if self:IsValidShake() then
		self:Shake()
	end

	if self.curProgress_ >= self.maxProgress_ then
		self:EndGame()
	end
end

function StoryShakePictureGame:ProcessMove(arg_23_1)
	local var_23_0 = arg_23_1.delta * manager.ui.canvasRate
	local var_23_1 = self.pictureTrans_:GetLocalPosition()

	var_23_1.x = var_23_1.x + (arg_23_1.delta * manager.ui.canvasRate).x
	var_23_1.y = var_23_1.y + var_23_0.y

	self.pictureTrans_:SetLocalPosition(var_23_1)

	if var_23_0.x > 0 ~= self.isMoveRight_ then
		self.isMoveRight_ = var_23_0.x > 0
		self.accumulatedMoveDistance_ = 0
	end

	if self.nextMoveIsRight_ == nil then
		self.nextMoveIsRight_ = self.isMoveRight_
	end

	if self.isMoveRight_ ~= self.nextMoveIsRight_ then
		self.accumulatedMoveDistance_ = 0
	end

	self.accumulatedMoveDistance_ = self.accumulatedMoveDistance_ + math.abs(var_23_0.x)
end

function StoryShakePictureGame:EndDrag(arg_24_1, arg_24_2)
	if self.gameStatus_ ~= "play" then
		return
	end

	if self.curProgress_ < self.maxProgress_ then
		self:StartResetPosAnim(function()
			SetActive(self.tipsPanelGo_, true)
		end)
	end
end

function StoryShakePictureGame:Dispose()
	print("Dispose Shake Picture Game !!!!!!!!!!!!!!!")
	Asset.Unload(self.prefabPath)
	self.dragEventListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.dragEventListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	self.dragEventListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	StoryShakePictureGame.super.Dispose(self)
end

return StoryShakePictureGame

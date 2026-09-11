local GuideWeakView = class("GuideWeakView")
local var_0_1 = Vector2(40, 30)

function GuideWeakView:Ctor()
	self._isInit = false
end

function GuideWeakView:Init()
	if self._isInit then
		return
	end

	self.gameObject_ = GameObject.Instantiate(Asset.Load("Widget/System/GuideNewUI/GuideWeakUI"), manager.ui.uiStory.transform)
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddUIListener()

	self._isInit = true

	SetActive(self.gameObject_, false)
end

function GuideWeakView:InitUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)
end

function GuideWeakView:AddUIListener()
	self.btnTextPanel_.onClick:AddListener(function()
		self:Hide()
	end)
	self.btnIcon_.onClick:AddListener(function()
		self:Hide()
	end)
	self.btnMaskBtn_.onClick:AddListener(function()
		self:Hide()
	end)
end

function GuideWeakView:RemoveUIListener()
	if isNil(self.btnTextPanel_) or isNil(self.btnIcon_) or isNil(self.btnMaskBtn_) then
		return
	end

	self.btnTextPanel_.onClick:RemoveAllListeners()
	self.btnIcon_.onClick:RemoveAllListeners()
	self.btnMaskBtn_.onClick:RemoveAllListeners()
end

function GuideWeakView:UpdateView(arg_9_1, arg_9_2, arg_9_3)
	self.id_ = arg_9_1.id

	self:ShowTalk(arg_9_1)
	self:ShowHoldMask(arg_9_3 or arg_9_2)
	self:SetCloseTime(arg_9_1.closetime)
end

function GuideWeakView:ShowTalk(arg_10_1)
	local var_10_0 = arg_10_1.talk_position
	local var_10_1 = arg_10_1.talk_adapt

	if not arg_10_1.talk_content or arg_10_1.talk_content == "" then
		SetActive(self.textPanel_, false)

		return
	end

	SetActive(self.textPanel_, true)

	self.textCom_.text = arg_10_1.talk_content
	self.dialogNameText_.text = arg_10_1.narrator_name
	self.dialogHeadImg_.sprite = getSpriteViaConfig("StoryHeadIcon", string.format("story_%s", arg_10_1.narrator_icon))

	if arg_10_1.talk_anchors == 1 then
		self.textRect_.anchorMax = Vector2.New(0, 1)
		self.textRect_.anchorMin = Vector2.New(0, 1)
	elseif arg_10_1.talk_anchors == 2 then
		self.textRect_.anchorMax = Vector2.New(1, 1)
		self.textRect_.anchorMin = Vector2.New(1, 1)
	elseif arg_10_1.talk_anchors == 3 then
		self.textRect_.anchorMax = Vector2.New(1, 0)
		self.textRect_.anchorMin = Vector2.New(1, 0)
	elseif arg_10_1.talk_anchors == 4 then
		self.textRect_.anchorMax = Vector2.New(0, 0)
		self.textRect_.anchorMin = Vector2.New(0, 0)
	elseif arg_10_1.talk_anchors == 5 then
		self.textRect_.anchorMax = Vector2.New(0, 0.5)
		self.textRect_.anchorMin = Vector2.New(0, 0.5)
	elseif arg_10_1.talk_anchors == 6 then
		self.textRect_.anchorMax = Vector2.New(0.5, 1)
		self.textRect_.anchorMin = Vector2.New(0.5, 1)
	elseif arg_10_1.talk_anchors == 7 then
		self.textRect_.anchorMax = Vector2.New(1, 0.5)
		self.textRect_.anchorMin = Vector2.New(1, 0.5)
	elseif arg_10_1.talk_anchors == 8 then
		self.textRect_.anchorMax = Vector2.New(0.5, 0)
		self.textRect_.anchorMin = Vector2.New(0.5, 0)
	else
		self.textRect_.anchorMax = Vector2.New(0.5, 0.5)
		self.textRect_.anchorMin = Vector2.New(0.5, 0.5)
	end

	self.textRect_.anchoredPosition = var_10_1 == 1 and Vector2.New((var_10_0[1] or 0) + ReduxView.VIEW_ADAPT_DISTANCE, var_10_0[2] or 0) or var_10_1 == 2 and Vector2.New((var_10_0[1] or 0) - ReduxView.VIEW_ADAPT_DISTANCE, var_10_0[2] or 0) or Vector2.New(var_10_0[1] or 0, var_10_0[2] or 0)
end

function GuideWeakView:ShowHoldMask(arg_11_1)
	local var_11_0 = arg_11_1:GetComponent("RectTransform")

	self.isHide_ = false

	SetActive(self.gameObject_, not self.isHide_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(var_11_0)

	local var_11_1 = Vector3((0.5 - var_11_0.pivot.x) * var_11_0.rect.width, (0.5 - var_11_0.pivot.y) * var_11_0.rect.height, 0)

	if self.timer_ then
		self.timer_:Stop()
	end

	self.timer_ = Timer.New(function()
		if isNil(arg_11_1) then
			self.timer_:Stop()

			self.timer_ = nil

			return
		end

		self.btnMaskCom_.sizeDelta = Vector2(var_11_0.rect.width, var_11_0.rect.height) + var_0_1
		self.btnMaskCom_.position = var_11_0.position
		self.btnMaskCom_.anchoredPosition = self.btnMaskCom_.anchoredPosition + var_11_1
		self.btnMaskCom_.eulerAngles = var_11_0.eulerAngles
	end, 0.033, -1)

	self.timer_:Start()
end

function GuideWeakView:SetCloseTime(arg_13_1)
	if arg_13_1 == 0 then
		return
	end

	self.closeTimer = Timer.New(function()
		self:Hide()
	end, arg_13_1, 0)

	self.closeTimer:Start()
end

function GuideWeakView:GetIsInWeakGuide()
	return not self.isHide_
end

function GuideWeakView:Hide(arg_16_1)
	if self.isHide_ then
		return
	end

	if self.id_ and not arg_16_1 then
		NewPlayerGuideAction.FinishWeakGuide(self.id_)

		self.id_ = nil
	end

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	if self.closeTimer then
		self.closeTimer:Stop()

		self.closeTimer = nil
	end

	self.isHide_ = true

	SetActive(self.gameObject_, not self.isHide_)
end

function GuideWeakView:Dispose(arg_17_1)
	if self.id_ and arg_17_1 then
		NewPlayerGuideAction.FinishWeakGuide(self.id_)
	end

	self.id_ = nil

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	if self.closeTimer then
		self.closeTimer:Stop()

		self.closeTimer = nil
	end

	if self._isInit then
		self:RemoveUIListener()
		Object.Destroy(self.gameObject_)
	end

	self._isInit = false
end

return GuideWeakView

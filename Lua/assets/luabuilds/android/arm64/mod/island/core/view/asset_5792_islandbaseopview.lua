local IslandBaseOpView = class("IslandBaseOpView", import(".IslandBaseSubView"))

function IslandBaseOpView:Ctor(arg_1_1)
	IslandBaseOpView.super.Ctor(self, arg_1_1)
	self:Init()

	self.enableCnt = 0

	return
end

function IslandBaseOpView:DoInit(arg_2_1, arg_2_2)
	IslandBaseOpView.super.DoInit(self, arg_2_1, arg_2_2)

	if self:GetEnterAnimationName() or self:GetExitAnimationName() then
		self.animataion = arg_2_1:GetComponent(typeof(Animation))
		self.dftAniEvent = self.animataion:GetComponent(typeof(DftAniEvent))
	end

	return
end

function IslandBaseOpView:GetUIParent(arg_3_1)
	return self:GetView().opContainer
end

function IslandBaseOpView:TryDisable(arg_4_1)
	if self.exiting then
		return
	end

	self.enableCnt = self.enableCnt - 1

	if self.enableCnt == 0 then
		self.exiting = true

		self:HideUI(arg_4_1, function()
			self.exiting = false

			self:OnDisable()

			return
		end)
	end

	return
end

function IslandBaseOpView:CloseAndReset()
	if self.enableCnt <= 0 then
		return
	end

	self.enableCnt = 1

	self:TryDisable()

	return
end

function IslandBaseOpView:TryEnable()
	self.enableCnt = self.enableCnt + 1

	if self.enableCnt == 1 then
		self:ShowUI()
		self:OnEnable()
	end

	return
end

function IslandBaseOpView:ShowOrHideGameObject(arg_8_1, arg_8_2)
	local var_8_0 = GetOrAddComponent(arg_8_1, typeof(CanvasGroup))

	var_8_0.alpha = arg_8_2 and 1 or 0
	var_8_0.blocksRaycasts = arg_8_2

	return
end

function IslandBaseOpView:HideUI(arg_9_1, arg_9_2)
	arg_9_1 = defaultValue(arg_9_1, true)

	if arg_9_1 then
		self:PlayExitAnimation(function()
			self:ShowOrHideGameObject(self._go, false)
			arg_9_2()

			return
		end)
	else
		self:ShowOrHideGameObject(self._go, false)
		arg_9_2()
	end

	return
end

function IslandBaseOpView:ShowUI()
	self:PlayeEnterAnimation()
	self:ShowOrHideGameObject(self._go, true)

	return
end

function IslandBaseOpView:PlayeEnterAnimation()
	local var_12_0 = self:GetEnterAnimationName()

	if var_12_0 then
		self.animataion:Play(var_12_0)
	end

	return
end

function IslandBaseOpView:PlayExitAnimation(arg_13_1)
	local var_13_0 = self:GetExitAnimationName()

	if var_13_0 then
		self.dftAniEvent:SetEndEvent(function()
			self.dftAniEvent:SetEndEvent(nil)
			arg_13_1()

			return
		end)
		self.animataion:Play(var_13_0)
	else
		arg_13_1()
	end

	return
end

function IslandBaseOpView:OnBeforeLoaded()
	self.enableCnt = 1

	return
end

function IslandBaseOpView:OnDispose()
	IslandBaseOpView.super.OnDispose(self)

	if self.dftAniEvent then
		self.dftAniEvent:SetEndEvent(nil)
	end

	return
end

function IslandBaseOpView:OnDisable()
	return
end

function IslandBaseOpView:OnEnable()
	return
end

function IslandBaseOpView:GetEnterAnimationName()
	return nil
end

function IslandBaseOpView:GetExitAnimationName()
	return nil
end

return IslandBaseOpView

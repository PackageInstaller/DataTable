local ShipDialog = class("ShipDialog")
local var_0_1 = 0.3
local var_0_2 = 2

function ShipDialog:Ctor(arg_1_1, arg_1_2)
	self.dialog = arg_1_1
	self.label = self.dialog.gameObject:GetComponentInChildren(typeof(Text))
	self.content = arg_1_2
	self.started = false

	return
end

function ShipDialog:loop(arg_2_1, arg_2_2, arg_2_3)
	self.timer = Timer.New(function()
		self:display()

		return
	end, arg_2_2 + arg_2_3 * math.random(), arg_2_1)

	return
end

function ShipDialog:display()
	if self.chatOn then
		return
	end

	self.chatOn = true
	rtf(self.dialog).localScale = Vector3.New(0, 0, 1)
	self.label.text = self.content

	if #self.content > CHAT_POP_STR_LEN then
		self.label.alignment = TextAnchor.MiddleLeft or TextAnchor.MiddleCenter
	end

	LeanTween.scale(rtf(self.dialog), Vector3.New(1, 1, 1), var_0_1):setEase(LeanTweenType.easeOutBack)
	LeanTween.scale(rtf(self.dialog), Vector3.New(0, 0, 1), var_0_1):setOnComplete(System.Action(function()
		self.chatOn = false

		return
	end)):setDelay(var_0_1 + var_0_2):setEase(LeanTweenType.easeInBack)

	return
end

function ShipDialog:play()
	if not self.started then
		self.started = true

		self.timer:Start()
	else
		self.timer:Resume()
	end

	return
end

function ShipDialog:pause()
	if self.started then
		self.timer:Pause()
	end

	return
end

function ShipDialog:stop()
	self.timer:Stop()

	self.started = false

	return
end

return ShipDialog

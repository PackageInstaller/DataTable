local RectKeyTriggerController = class("RectKeyTriggerController")

function RectKeyTriggerController:Ctor(arg_1_1)
	self._keyInfo = arg_1_1
	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function RectKeyTriggerController:Update()
	if Application.isEditor then
		if Input.GetKeyDown(KeyCode.A) then
			self._keyInfo:setKeyPress(KeyCode.A, true)
		end

		if Input.GetKeyDown(KeyCode.D) then
			self._keyInfo:setKeyPress(KeyCode.D, true)
		end

		if Input.GetKeyUp(KeyCode.A) then
			self._keyInfo:setKeyPress(KeyCode.A, false)
		end

		if Input.GetKeyUp(KeyCode.D) then
			self._keyInfo:setKeyPress(KeyCode.D, false)
		end

		if Input.GetKeyDown(KeyCode.Space) then
			self._keyInfo:setKeyPress(KeyCode.Space, true)
		end

		if Input.GetKeyUp(KeyCode.Space) then
			self._keyInfo:setKeyPress(KeyCode.Space, false)
		end

		if Input.GetKeyDown(KeyCode.J) then
			self._keyInfo:setKeyPress(KeyCode.J, true)
		end

		if Input.GetKeyUp(KeyCode.J) then
			self._keyInfo:setKeyPress(KeyCode.J, false)
		end
	end

	return
end

function RectKeyTriggerController:destroy()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)

		self.handle = nil
	end

	return
end

return RectKeyTriggerController

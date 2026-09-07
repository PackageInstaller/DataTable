local UIAnim = class("UIAnim", import("...BaseEntity"))

UIAnim.Fields = {
	playing = "boolean",
	aniEvent = "userdata",
	onEnd = "function",
	transform = "userdata",
	prefab = "string",
	onTrigger = "function",
	onStart = "function"
}
UIAnim.EventLoaded = "UIAnim.EventLoaded"

function UIAnim:Setup(arg_1_1)
	self.prefab = arg_1_1

	return
end

function UIAnim:Dispose()
	self:Unload()
	self:Clear()

	return
end

function UIAnim:Load()
	local var_3_0 = self.prefab
	local var_3_1 = PoolMgr.GetInstance()

	var_3_1:GetUI(self.prefab, true, function(arg_4_0)
		if var_3_0 == self.prefab then
			self.transform = arg_4_0.transform

			self:Init()
			self:DispatchEvent(UIAnim.EventLoaded)
		else
			var_3_1:ReturnUI(var_3_0, arg_4_0)
		end

		return
	end)

	return
end

function UIAnim:Unload()
	if self.prefab and self.transform then
		PoolMgr.GetInstance():ReturnUI(self.prefab, self.transform.gameObject)
	end

	self.prefab = nil
	self.transform = nil

	return
end

function UIAnim:Play(arg_6_1)
	self.playing = true
	self.onStart = nil
	self.onTrigger = nil
	self.onEnd = arg_6_1

	self:Update()

	return
end

function UIAnim:Stop()
	self.playing = false

	self:Update()

	return
end

function UIAnim:Init()
	setActive(self.transform, false)

	self.aniEvent = self.transform:GetComponent("DftAniEvent")

	self:Update()

	return
end

function UIAnim:Update()
	if self.aniEvent then
		setActive(self.transform, self.playing)

		if self.playing then
			self.aniEvent:SetStartEvent(function()
				if self.onStart then
					self.onStart()
				end

				return
			end)
			self.aniEvent:SetTriggerEvent(function()
				if self.onTrigger then
					self.onTrigger()
				end

				return
			end)
			self.aniEvent:SetEndEvent(function(arg_12_0)
				self:Stop()

				if self.onEnd then
					self.onEnd()
				end

				return
			end)
		end
	end

	return
end

return UIAnim

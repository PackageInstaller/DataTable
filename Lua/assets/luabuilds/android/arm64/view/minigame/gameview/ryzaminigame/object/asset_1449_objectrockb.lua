local ObjectRockB = class("ObjectRockB", import("view.miniGame.gameView.RyzaMiniGame.object.ObjectBreakable"))

function ObjectRockB:FirePassability()
	return self.isWater and 2 or 1
end

function ObjectRockB:InTimeRiver()
	return true
end

function ObjectRockB:InitUI(arg_3_1)
	self.comAnimator = self._tf:Find("Image"):GetComponent(typeof(Animator))

	local var_3_0 = self._tf:Find("Image"):GetComponent(typeof(DftAniEvent))

	var_3_0:SetTriggerEvent(function()
		self.waterTime = arg_3_1.waterTime or 4

		return
	end)
	var_3_0:SetEndEvent(function()
		self:Destroy()

		return
	end)

	self.waterTime = 0

	return
end

function ObjectRockB:Break()
	self:DeregisterAll()
	self.comAnimator:Play("B2")

	return
end

function ObjectRockB:TimeUpdate(arg_7_1)
	if self.waterTime > 0 then
		self.waterTime = self.waterTime - arg_7_1

		if self.waterTime <= 0 then
			self.comAnimator:Play("B4")
		end
	end

	return
end

return ObjectRockB

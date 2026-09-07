local ObjectBreakable = class("ObjectBreakable", import("view.miniGame.gameView.RyzaMiniGame.object.TargetObject"))

function ObjectBreakable:FirePassability()
	return 1
end

function ObjectBreakable:InitUI(arg_2_1)
	self._tf:Find("Image"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		self:TryDrop(arg_2_1.drop, "Drop")
		self:Destroy()

		return
	end)

	return
end

function ObjectBreakable:InitRegister(arg_4_1)
	self:Register("burn", function()
		self:Break()

		return
	end, {
		{
			0,
			0
		}
	})
	self:Register("break", function()
		self:Break()

		return
	end, {})

	return
end

function ObjectBreakable:Break()
	self:DeregisterAll()
	self._tf:Find("Image"):GetComponent(typeof(Animator)):Play("Break")

	return
end

return ObjectBreakable

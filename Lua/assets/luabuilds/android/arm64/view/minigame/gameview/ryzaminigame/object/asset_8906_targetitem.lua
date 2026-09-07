local TargetItem = class("TargetItem", import("view.miniGame.gameView.RyzaMiniGame.Reactor"))
local var_0_1 = {
	hp1 = "4",
	speed = "3",
	spirit = "6",
	power = "2",
	bomb = "1",
	hp2 = "5"
}

function TargetItem:InitUI(arg_1_1)
	self.type = arg_1_1.type

	self._tf:Find("Image"):GetComponent(typeof(Animator)):Play(var_0_1[self.type])
	setActive(self._tf:Find("Burn"), false)
	self._tf:Find("Burn"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		self:Destroy(false)

		return
	end)
	eachChild(self._tf:Find("front"), function(arg_3_0)
		arg_3_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			setActive(arg_3_0, false)

			return
		end)
		setActive(arg_3_0, arg_3_0.name == arg_1_1.drop)

		return
	end)

	return
end

function TargetItem:InitRegister(arg_5_1)
	self:Register("move", function(arg_6_0)
		if isa(arg_6_0, MoveRyza) then
			arg_6_0:AddItem(self.type)
			self:Destroy()
		else
			self:Destroy(false)
		end

		return
	end, {
		{
			0,
			0
		}
	})
	self:Register("burn", function()
		self:DeregisterAll()
		setActive(self._tf:Find("Image"), false)
		setActive(self._tf:Find("Burn"), true)

		return
	end, {
		{
			0,
			0
		}
	})

	return
end

return TargetItem

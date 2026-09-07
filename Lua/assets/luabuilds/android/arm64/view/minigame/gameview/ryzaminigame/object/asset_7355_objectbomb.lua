local ObjectBomb = class("ObjectBomb", import("view.miniGame.gameView.RyzaMiniGame.object.TargetObject"))

function ObjectBomb:FirePassability()
	return 0
end

function ObjectBomb:InTimeRiver()
	return true
end

function ObjectBomb:InitUI(arg_3_1)
	self.cooldown = arg_3_1.cooldown or 3
	self.power = arg_3_1.power

	self:Calling("move", {
		self
	}, {
		{
			0,
			0
		}
	})

	return
end

function ObjectBomb:InitRegister(arg_4_1)
	self:Register("burn", function()
		self:Burning()

		return
	end, {
		{
			0,
			0
		}
	})

	return
end

function ObjectBomb:Burning()
	if self.burst then
		return
	else
		self.burst = true
	end

	self.cooldown = 0

	self:DeregisterAll()
	self:Calling("leave", {
		self
	}, {
		{
			0,
			0
		}
	})
	self:Calling("feedback", {}, MoveRyza)
	self.responder:Create({
		name = "Fire",
		pos = {
			self.pos.x,
			self.pos.y
		},
		power = self.power
	})
	self:Destroy()

	return
end

function ObjectBomb:TimeUpdate(arg_7_1)
	if self.cooldown > 0 then
		if self.cooldown > 2.87 and self.cooldown - arg_7_1 <= 2.87 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-ryza-minigame-blasting fuse")
		end

		self.cooldown = self.cooldown - arg_7_1

		if self.cooldown <= 0 then
			self:Burning()
		end
	end

	return
end

function ObjectBomb:SetHide(arg_8_1)
	self.hide = arg_8_1

	return
end

return ObjectBomb

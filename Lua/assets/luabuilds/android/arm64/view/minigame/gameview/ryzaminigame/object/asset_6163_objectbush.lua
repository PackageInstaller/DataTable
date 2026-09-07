local ObjectBush = class("ObjectBush", import("view.miniGame.gameView.RyzaMiniGame.object.TargetObject"))

function ObjectBush:GetBaseOrder()
	return 3
end

function ObjectBush:CellPassability()
	return true
end

function ObjectBush:FirePassability()
	return 0
end

function ObjectBush:InitUI(arg_4_1)
	self.hideCount = 0

	return
end

function ObjectBush:InitRegister(arg_5_1)
	local var_5_0 = self._tf:Find("Image"):GetComponent(typeof(Animator))

	self:Register("burn", function()
		var_5_0:Play("New State")
		var_5_0:Play("Burn_A")

		return
	end, {
		{
			0,
			0
		}
	})
	self:Register("move", function(arg_7_0)
		var_5_0:Play("New State")
		var_5_0:Play("Sway")
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-ryza-minigame-grass")
		arg_7_0:SetHide(true)

		if not isa(arg_7_0, MoveEnemy) then
			self:ChangeHide(true)
		end

		return
	end, {
		{
			0,
			0
		}
	})
	self:Register("leave", function(arg_8_0)
		var_5_0:Play("New State")
		var_5_0:Play("Sway")
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-ryza-minigame-grass")
		arg_8_0:SetHide(false)

		if not isa(arg_8_0, MoveEnemy) then
			self:ChangeHide(false)
		end

		return
	end, {
		{
			0,
			0
		}
	})

	return
end

function ObjectBush:ChangeHide(arg_9_1)
	self.hideCount = self.hideCount + (arg_9_1 and 1 or -1)
	GetOrAddComponent(self._tf, typeof(CanvasGroup)).alpha = self.hideCount > 0 and 0.5 or 1

	return
end

return ObjectBush

local FushunEliteBeastChar = class("FushunEliteBeastChar", import(".FushunBeastChar"))

function FushunEliteBeastChar:Hurt(arg_1_1)
	if self:IsDeath() or self:IsEscape() then
		return
	end

	self.animatorEvent:SetEndEvent(nil)
	self.animatorEvent:SetEndEvent(function()
		self:Unfreeze()

		return
	end)
	self:Freeze()
	self:UpdateHp(self.hp - arg_1_1)
	self.animator:SetTrigger("damage")

	return
end

function FushunEliteBeastChar:UpdateHp(arg_3_1)
	FushunEliteBeastChar.super.UpdateHp(self, arg_3_1)
	self.animator:SetInteger("hp", self.hp)

	return
end

return FushunEliteBeastChar

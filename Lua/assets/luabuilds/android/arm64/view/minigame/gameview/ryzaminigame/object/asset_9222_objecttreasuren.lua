local ObjectTreasureN = class("ObjectTreasureN", import("view.miniGame.gameView.RyzaMiniGame.object.ObjectBreakable"))

function ObjectTreasureN:InitRegister(arg_1_1)
	ObjectTreasureN.super.InitRegister(self, arg_1_1)
	self:Register("touch", function()
		self:DeregisterAll()
		self._tf:Find("Image"):GetComponent(typeof(Animator)):Play("Open")

		return
	end, {
		{
			0,
			0
		}
	})

	return
end

return ObjectTreasureN

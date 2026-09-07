local ObjectTreasureR = class("ObjectTreasureR", import("view.miniGame.gameView.RyzaMiniGame.object.TargetObject"))

function ObjectTreasureR:FirePassability()
	return 2
end

function ObjectTreasureR:InitUI(arg_2_1)
	self._tf:Find("Image"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		self:TryDrop(arg_2_1.drop, "Drop_Treasure_R")
		self:Destroy()

		return
	end)

	return
end

function ObjectTreasureR:InitRegister(arg_4_1)
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

return ObjectTreasureR

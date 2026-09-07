local StoryShip = class("StoryShip", import("model.vo.Ship"))

function StoryShip:Ctor(arg_1_1)
	self.configId = 9999999999
	self.skinId = arg_1_1.skin_id or 0
	self.noChangeSkin = true

	return
end

return StoryShip

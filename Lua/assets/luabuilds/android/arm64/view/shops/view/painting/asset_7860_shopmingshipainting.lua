local ShopMingShiPainting = class("ShopMingShiPainting")

function ShopMingShiPainting:Ctor(arg_1_1)
	self._painting = arg_1_1
	self.live2dContainer = findTF(self._painting, "live2d")

	setActive(self.live2dContainer, true)

	return
end

function ShopMingShiPainting:Load(arg_2_1, arg_2_2, arg_2_3)
	Live2DPainting.New(Live2DPainting.GenerateData({
		ship = Ship.New({
			configId = 312011
		}),
		offset = {
			nil,
			nil,
			nil,
			72
		},
		position = Vector3(0, 0, 0),
		parent = self.live2dContainer
	}), function(arg_3_0)
		self.live2dChar = arg_3_0

		if self.cacheAnimationName then
			self:Action(self.cacheAnimationName)

			self.cacheAnimationName = nil
		end

		arg_2_3()

		return
	end)

	return
end

function ShopMingShiPainting:Action(arg_4_1)
	if self.live2dChar then
		self.live2dChar:TriggerAction(arg_4_1, nil, true)
	else
		self.cacheAnimationName = arg_4_1
	end

	return
end

function ShopMingShiPainting:UnLoad()
	setActive(self.live2dContainer, false)

	if self.live2dChar then
		self.live2dChar:Dispose()

		self.live2dChar = nil
	end

	return
end

return ShopMingShiPainting

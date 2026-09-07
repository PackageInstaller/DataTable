local ShopBgView = class("ShopBgView")

function ShopBgView:Ctor(arg_1_1)
	self._bg = arg_1_1
	self.img = self._bg:GetComponent(typeof(Image))

	setActive(arg_1_1, false)

	self.bgs = {}

	return
end

function ShopBgView:Init(arg_2_1)
	setActive(self._bg, arg_2_1 ~= nil)

	if arg_2_1 then
		self.img.sprite = self.bgs[arg_2_1] and self.bgs[arg_2_1] or GetSpriteFromAtlas(arg_2_1, "")
	end

	return
end

function ShopBgView:Dispose()
	UIUtil.ClearImageSprite(self._bg.gameObject)

	self.bgs = nil

	return
end

return ShopBgView

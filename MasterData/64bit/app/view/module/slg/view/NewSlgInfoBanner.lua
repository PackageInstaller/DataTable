local NewSlgInfoBanner = class("NewSlgInfoBanner")
local var_0_1 = g.core.const.ConstMgr.NewSlgConst.SLGBannerType

function NewSlgInfoBanner:ctor()
	self._compPlace = self:getChild("Comp_place")
	self._bannerCtrl = self:getController("banner")
end

function NewSlgInfoBanner:updateView(arg_2_1)
	if arg_2_1.bannerType == var_0_1.BOSS or arg_2_1.bannerType == var_0_1.MONSTER then
		if self._sprite then
			self._sprite:removeFromParent()

			self._sprite = nil
		end

		self._sprite = display.newSprite(arg_2_1.res)

		self._sprite:setAnchorPoint(0.5, 0.5)
		self._sprite:setPosition(25, 15)
		self._sprite:setScale(arg_2_1.scale or 1)
		self._compPlace:addNode(self._sprite)
	else
		self._compPlace:setURL(arg_2_1.res)
	end
end

return NewSlgInfoBanner

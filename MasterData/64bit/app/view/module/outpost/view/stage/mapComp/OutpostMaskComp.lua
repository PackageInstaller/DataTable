local var_0_1 = g.core.const.ConstMgr.outpostConst
local OutpostMask = class("OutpostMask", function()
	return display.newSprite("ui_cocos/outpost/mask/bg_mask_1.png")
end)

function OutpostMask:ctor()
	self._objType = var_0_1.EntityType.Mask

	self:setScale(1)
	self:setOpacity(120)
end

function OutpostMask:getEntityType()
	return self._objType
end

function OutpostMask:isMask()
	return true
end

function OutpostMask:updateEntityShowParam()
	return
end

return OutpostMask

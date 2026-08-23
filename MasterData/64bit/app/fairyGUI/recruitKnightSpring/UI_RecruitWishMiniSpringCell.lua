local var_0_0 = {}

var_0_0.URL = "ui://16fa1nlapo2z5q"

function var_0_0:__ctor()
	self.m_isWishController = self:getController("isWish")
	self.m_isCompletedController = self:getController("isCompleted")
	self.m_itemIcon = self:getChild("itemIcon")
end

var_0_0.IsWishCtrl = {
	wish = 1,
	none = 0
}
var_0_0.IsCompletedCtrl = {
	normal = 0,
	completed = 1
}

return var_0_0

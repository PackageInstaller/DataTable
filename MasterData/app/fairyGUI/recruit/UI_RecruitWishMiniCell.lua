local var_0_0 = {}

var_0_0.URL = "ui://nz3msl46is15gibw7"

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
	completed = 1,
	normal = 0
}

return var_0_0

local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2gwxe5s"

function var_0_0:__ctor()
	self.m_is_rank32Controller = self:getController("is_rank32")
	self.m_is_selfController = self:getController("is_self")
	self.m_List_sucAward = self:getChild("List_sucAward")
	self.m_List_failAward = self:getChild("List_failAward")
end

var_0_0.Is_rank32Ctrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_selfCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0

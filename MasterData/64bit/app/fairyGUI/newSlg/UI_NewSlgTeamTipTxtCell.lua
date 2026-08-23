local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jdif969m6"

function var_0_0:__ctor()
	self.m_matchController = self:getController("match")
	self.m_text = self:getChild("text")
end

var_0_0.MatchCtrl = {
	match = 0,
	normal = 1
}

return var_0_0

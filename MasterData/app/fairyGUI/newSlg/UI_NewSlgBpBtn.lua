local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9tt9d68db"

function var_0_0:__ctor()
	self.m_isShowExtTeamController = self:getController("isShowExtTeam")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsShowExtTeamCtrl = {
	hide = 0,
	show = 1
}

return var_0_0

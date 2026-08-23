local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2gwxe5o"

function var_0_0:__ctor()
	self.m_is_selfController = self:getController("is_self")
	self.m_is_guessController = self:getController("is_guess")
	self.m_is_winController = self:getController("is_win")
	self.m_Comp_userIcon = self:getChild("Comp_userIcon")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Txt_fightValue = self:getChild("Txt_fightValue")
	self.m_Txt_teamNum = self:getChild("Txt_teamNum")
	self.m_Txt_lose = self:getChild("Txt_lose")
	self.m_Txt_win = self:getChild("Txt_win")
	self.m_Txt_betNum = self:getChild("Txt_betNum")
	self.m_Btn_guess = self:getChild("Btn_guess")
	self.m_Btn_fixGuess = self:getChild("Btn_fixGuess")
	self.m_Group_guessed = self:getChild("Group_guessed")
	self.m_Loader_box = self:getChild("Loader_box")
	self.m_Group_box = self:getChild("Group_box")
end

var_0_0.Is_selfCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_guessCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.Is_winCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0

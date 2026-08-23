local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9dzft96983"

function var_0_0:__ctor()
	self.m_farm_typeController = self:getController("farm_type")
	self.m_farmRewardLimitTxt1 = self:getChild("farmRewardLimitTxt1")
	self.m_farmRewardLimitTxt2 = self:getChild("farmRewardLimitTxt2")
	self.m_farmIcon1 = self:getChild("farmIcon1")
	self.m_farmIcon2 = self:getChild("farmIcon2")
	self.m_Txt_countDown = self:getChild("Txt_countDown")
end

var_0_0.Farm_typeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0

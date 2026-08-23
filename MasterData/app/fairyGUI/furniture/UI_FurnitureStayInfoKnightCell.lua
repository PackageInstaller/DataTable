local var_0_0 = {}

var_0_0.URL = "ui://irs65rts10brm3f"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_choseController = self:getController("chose")
	self.m_picComp = self:getChild("picComp")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_starComp = self:getChild("starComp")
	self.m_checkInDormIdTxt = self:getChild("checkInDormIdTxt")
	self.m_dispatchRoomNameTxt = self:getChild("dispatchRoomNameTxt")
	self.m_mobilityBar = self:getChild("mobilityBar")
	self.m_mobilityCircleBarComp = self:getChild("mobilityCircleBarComp")
end

return var_0_0

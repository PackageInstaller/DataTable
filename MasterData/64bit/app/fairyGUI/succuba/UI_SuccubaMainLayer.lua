local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1uhvy32"

function var_0_0:__ctor()
	self.m_interactionStateController = self:getController("interactionState")
	self.m_selectedIdxController = self:getController("selectedIdx")
	self.m_roomStateController = self:getController("roomState")
	self.m_spineHold = self:getChild("spineHold")
	self.m_fragSellBtn = self:getChild("fragSellBtn")
	self.m_formationBtn = self:getChild("formationBtn")
	self.m_roomListComp = self:getChild("roomListComp")
	self.m_handbookBtn = self:getChild("handbookBtn")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_chatBtn = self:getChild("chatBtn")
	self.m_interactionBtn = self:getChild("interactionBtn")
	self.m_developBtn = self:getChild("developBtn")
	self.m_infoComp = self:getChild("infoComp")
	self.m_rightArrow = self:getChild("rightArrow")
	self.m_leftArrow = self:getChild("leftArrow")
	self.m_succubaList = self:getChild("succubaList")
	self.m_interactionNode = self:getChild("interactionNode")
	self.m_dailyTalkComp = self:getChild("dailyTalkComp")
	self.m_dailyTouch = self:getChild("dailyTouch")
	self.m_succbaIcon1 = self:getChild("succbaIcon1")
	self.m_succbaIcon2 = self:getChild("succbaIcon2")
	self.m_succbaIcon3 = self:getChild("succbaIcon3")
	self.m_callBtn = self:getChild("callBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enter0Transition = self:getTransition("enter0")
	self.m_enter2Transition = self:getTransition("enter2")
	self.m_enter4Transition = self:getTransition("enter4")
	self.m_back0Transition = self:getTransition("back0")
	self.m_back2Transition = self:getTransition("back2")
	self.m_back4Transition = self:getTransition("back4")
	self.m_switch0Transition = self:getTransition("switch0")
end

return var_0_0

local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6ppb7kk39j"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_titleName = self:getChild("titleName")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_phaseComp = self:getChild("phaseComp")
	self.m_surplusTimeComp = self:getChild("surplusTimeComp")
	self.m_waveComp = self:getChild("waveComp")
	self.m_baseTimeComp = self:getChild("baseTimeComp")
	self.m_awardList = self:getChild("awardList")
	self.m_startGameBtn = self:getChild("startGameBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.TypeCtrl = {
	page45 = 79,
	page23 = 23,
	page7 = 7,
	page17 = 17,
	page43 = 77,
	page25 = 59,
	page32 = 66,
	page34 = 68,
	page41 = 75,
	page27 = 61,
	page40 = 74,
	page36 = 70,
	page29 = 63,
	page31 = 65,
	page9 = 9,
	page2 = 2,
	page18 = 18,
	page13 = 13,
	page8 = 8,
	page44 = 78,
	page22 = 22,
	page38 = 72,
	page5 = 5,
	page42 = 76,
	page24 = 58,
	page47 = 81,
	page21 = 21,
	page3 = 3,
	page26 = 60,
	page10 = 10,
	page1 = 1,
	page28 = 62,
	page0 = 0,
	page16 = 16,
	page35 = 69,
	page19 = 19,
	page6 = 6,
	page14 = 14,
	page39 = 73,
	page33 = 67,
	page46 = 80,
	page20 = 20,
	page11 = 11,
	page30 = 64,
	page37 = 71,
	page4 = 4,
	page12 = 12,
	page15 = 15
}

return var_0_0

local var_0_0 = g.core.model.User.anniversaryData
local AnniversarySignComp = class("AnniversarySignComp", require("app.fairyGUI.anniversary.UI_AnniversarySignComp"))

function AnniversarySignComp:ctor()
	self.m_title:setURL(var_0_0:getActivityResource("pic", "txt_xmhy_gsfc.png"))
	self.m_bg:setURL(var_0_0:getActivityResource("ui_cocos", "pic_xmhy_qiandaodi.png"))
end

function AnniversarySignComp:updateSignComp()
	self._signAwards = var_0_0:getSignAwards()

	for iter_2_0 = 1, #self._signAwards do
		if self["m_sign" .. iter_2_0] then
			self["m_sign" .. iter_2_0]:updateSignCell(self._signAwards[iter_2_0])
		end
	end

	self._finalInfo = self._signAwards[#self._signAwards]

	self.m_bigAward:updateBigAward(self._finalInfo)
end

function AnniversarySignComp:updateBigState()
	self.m_bigAward:updateBigAward(self._finalInfo)
end

return AnniversarySignComp

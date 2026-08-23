local GuildFightConst = require("app.view.module.guildFight.const.GuildFightConst")
local var_0_3 = g.core.model.User.GuildFightData
local GuildFightChariotComp = class("GuildFightChariotComp", require("app.fairyGUI.guildFight.UI_GuildFightChariotComp"))

function GuildFightChariotComp:ctor(arg_1_1)
	self._varIndex = 0
	self._newChariotIds = {}
	self._varIndexs = {}
end

function GuildFightChariotComp:onLoad()
	return
end

function GuildFightChariotComp:updateComp()
	self._chariotListData = var_0_3:getChariotList()

	for iter_3_0 = 1, GuildFightConst.CHARIOT_AREA_NUM do
		self["m_chariotEntrance" .. iter_3_0]:updateInfo(self._chariotListData[iter_3_0])
	end

	self.m_enterTransition:play()
end

return GuildFightChariotComp

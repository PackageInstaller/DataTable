local var_0_0 = g.core.common.Path
local var_0_1 = g.core.config.guild_alliance_buildings_info
local var_0_2 = g.core.model.User.allianceData
local AllianceLevelUpComp = class("AllianceLevelUpComp", require("app.fairyGUI.alliance.UI_AllianceLevelUpComp"))

function AllianceLevelUpComp:ctor()
	self._unlockBuildList = {}

	self:initView()
	var_0_2:savePopLevelUpAlliance()
end

function AllianceLevelUpComp:initView()
	local var_2_0 = var_0_2:getAllianceLevel()

	self.m_beforeLevel:setText(var_2_0 - 1)
	self.m_afterLevel:setText(var_2_0)
	self.m_afterGuildNum:setText(var_0_2:getAllianceGuildMaxNum())
	self.m_unlockBuildList:setItemRenderer(handler(self, self._onRenderUnlockBuild))

	for iter_2_0, iter_2_1 in var_0_1.ipairs() do
		if iter_2_1.level == var_2_0 then
			table.insert(self._unlockBuildList, iter_2_1)
		end
	end

	if #self._unlockBuildList == 0 then
		self.m_showUnlockGroup:setVisible(false)
	else
		self.m_showUnlockGroup:setVisible(true)
		self.m_unlockBuildList:setNumItems(#self._unlockBuildList)
	end
end

function AllianceLevelUpComp:_onRenderUnlockBuild(arg_3_1, arg_3_2)
	arg_3_2:setTitle(self._unlockBuildList[arg_3_1 + 1].name)
	arg_3_2:setIcon(var_0_0:getAllianceBuildIcon(self._unlockBuildList[arg_3_1 + 1].icon, true))
end

function AllianceLevelUpComp:playAnimate()
	self.m_enterTransition:play()
end

return AllianceLevelUpComp

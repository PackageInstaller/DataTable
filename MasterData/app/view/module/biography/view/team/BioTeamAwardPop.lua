local var_0_0 = g.core.model.User.bioData
local BioTeamAwardPop = class("BioTeamAwardPop", require("app.fairyGUI.biography.UI_BioTeamAwardPop"), function()
	return fgui.GComponent:create({
		resName = "BioTeamAwardPop",
		pkgPath = "ui/biography/biography",
		pkgName = "biography"
	}, ...)
end)

function BioTeamAwardPop:ctor(arg_2_1)
	self:showAtCenter()

	self._selTab = 1

	self.m_list:setIniter()
	self.m_list:setItemRenderer(handler(self, self._onListRenderer))
	self.m_selTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTitleStyle))

	local var_2_0 = 0

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.NIGHTMARE_BIO_TEAM) then
		var_2_0 = 3
	elseif g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DESPERATE_BIO_TEAM) then
		var_2_0 = 2
	elseif g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HARD_BIO_TEAM) then
		var_2_0 = 1
	end

	self.m_openHardController:setSelectedIndex(var_2_0)

	self._red1 = self.m_tab1:getChild("redPointComp")
	self._red2 = self.m_tab2:getChild("redPointComp")
	self._red3 = self.m_tab3:getChild("redPointComp")
	self._red4 = self.m_tab4:getChild("redPointComp")
end

function BioTeamAwardPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_GETCAMPAIGNFIRSTAWARD, self._onGetAward, self)
	self:_updateList()
end

function BioTeamAwardPop:_updateList()
	self._allCampaignData = var_0_0:getAllSortCampaignByLands(self._selTab)

	self.m_list:setNumItems(#self._allCampaignData)
	self:updateRedPoint()
end

function BioTeamAwardPop:updateRedPoint()
	self._red1:setShow(var_0_0:isShowCampaignRed(1))
	self._red2:setShow(var_0_0:isShowCampaignRed(2))
	self._red3:setShow(var_0_0:isShowCampaignRed(3))
	self._red4:setShow(var_0_0:isShowCampaignRed(4))
end

function BioTeamAwardPop:_onChangeTitleStyle()
	self._selTab = self.m_selTabController:getSelectedIndex() + 1

	self:_updateList()
end

function BioTeamAwardPop:_onListRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._allCampaignData[arg_7_1 + 1])
end

function BioTeamAwardPop:_onGetAward(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_3 and arg_8_3.awards then
		g.core.module.ModuleManager:awardSummary(arg_8_3.awards)
		self:_updateList()
	end
end

return BioTeamAwardPop

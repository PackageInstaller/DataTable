local var_0_0 = g.core.model.User.bioData
local var_0_2 = g.core.common.Path
local BioTeamCampaignInfoLayer = class("BioTeamCampaignInfoLayer", require("app.fairyGUI.biography.UI_BioTeamCampaignInfoLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/biography/biography",
		resName = "BioTeamCampaignInfoLayer",
		pkgName = "biography"
	}, ...)
end)

function BioTeamCampaignInfoLayer:ctor(arg_2_1)
	self._campaignId = arg_2_1.cid
	self._info = var_0_0:getCampaign(self._campaignId)

	self:_initBg()
end

function BioTeamCampaignInfoLayer:_initBg()
	self:addBg((self._info.bg or nil) and var_0_2:getBioTeamCampaignBgRes(self._info.bg))
end

function BioTeamCampaignInfoLayer:onLoad()
	if not self._campaignId then
		return
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_CREATETEAM, handler(self, self._onNetRecvcheckTeamInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_JOINTEAM, self._onNetRecvcheckTeamInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM, self._updateWhenGetLeftCount, self)
	self.m_isHardController:setSelectedIndex(self._info.tab - 1)
	self.m_topBar:setResInfoById(33)
	self:_updateLeftCount()
	self:_showKnightDraw()
	self.m_rightInfoComp:updateCampaignInfo(self._campaignId)
	self.m_enterTransition:play()
end

function BioTeamCampaignInfoLayer:_updateLeftCount()
	self.m_leftCountComp:updateLeftCount()
end

function BioTeamCampaignInfoLayer:_showKnightDraw()
	local var_6_0 = var_0_0:getDisplayVersion()

	self.m_knightPicComp:updateKnight({
		resId = tonumber((var_6_0 == 1 or nil) and (self._info.knight_id or self._info["knight_id_" .. var_6_0]))
	})
	self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-300, 0, 500, 0), 200)
end

function BioTeamCampaignInfoLayer:_onNetRecvcheckTeamInfo(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if var_0_0:getTeamInfo().id > 0 then
		local var_7_0 = g.core.module.ModuleManager:getCurModule()

		if not var_7_0 then
			return
		end

		if var_7_0.module ~= g.view.entrance.BIO_TEAM then
			if arg_7_4 and arg_7_4.id then
				var_0_0:resetAllListNewState()
			end

			g.core.module.ModuleManager:pushModule(g.view.entrance.BIO_TEAM)
		end
	end
end

function BioTeamCampaignInfoLayer:onUnload()
	return
end

function BioTeamCampaignInfoLayer:_updateWhenGetLeftCount()
	self.m_topBar:updateResource(false)
	self.m_rightInfoComp:updateCampaignInfo(self._campaignId)
end

return BioTeamCampaignInfoLayer

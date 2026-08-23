local var_0_0 = g.core.const.ConstMgr.ShareConst
local var_0_1 = g.core.model.User.newYearWishData
local var_0_2 = g.core.const.ConstMgr.PlatformConst
local ShareNewYearWishShotComp = class("ShareNewYearWishShotComp", require("app.fairyGUI.share.UI_ShareNewYearWishShotComp"))

function ShareNewYearWishShotComp:ctor()
	self:initView()
end

function ShareNewYearWishShotComp:_shotPic()
	local var_2_0 = cc.utils:captureNode(self)

	g.core.model.User.ShareData:saveImg(var_2_0)
	var_2_0:release()
end

function ShareNewYearWishShotComp:initView()
	self.m_enterTransition:play(handler(self, self._shotPic))

	if var_0_2.REGION_CFG[config.PUBLISH_REGION] and var_0_2.REGION_CFG[config.PUBLISH_REGION].SHARE_PNG_PATH and not g.core.platform.PlatformProxy:isChannelOfEnPC() and not g.core.platform.PlatformProxy:isChannelOfKrPC() then
		self.m_inviteCode:setURL(var_0_2.REGION_CFG[config.PUBLISH_REGION].SHARE_PNG_PATH)
	else
		self.m_inviteCode:setVisible(false)
	end

	local var_3_0 = var_0_0.SHARE_REGION_CFG[config.PUBLISH_REGION] or {}

	self.m_cntController:setSelectedIndex(#var_3_0)

	for iter_3_0 = 1, #var_3_0 do
		local var_3_1 = var_3_0[iter_3_0]

		self["m_shareBtn" .. iter_3_0]:getChild("icon"):setURL(var_0_0.SHARE_PLATFORM_CFG[var_3_0[iter_3_0]].icon)
		self["m_shareBtn" .. iter_3_0]:addClickListener(function()
			if not g.core.platform.PlatformProxy:checkNewFunctionByVersion1_1_0(true) then
				return
			end

			g.core.platform.PlatformProxy:shareGame(nil, nil, nil, g.core.model.User.ShareData:getSavaPath(), var_3_1)
		end)

		if iter_3_0 >= 3 then
			break
		end
	end

	self.m_logo:setURL(g.core.common.Path:getShareLogoByRegionId(config.PUBLISH_REGION))
end

function ShareNewYearWishShotComp:onLoad()
	self:updateView()
end

function ShareNewYearWishShotComp:updateView()
	local var_6_0 = g.core.model.User.ShareData:getShotPath()

	display.removeImage(var_6_0)
	self.m_bgLoader:setURL(var_6_0)
	self.m_typeLoader:setURL("ui://text_new/txt_fx_word_" .. var_0_1:getCurInfo().type_1)
end

return ShareNewYearWishShotComp

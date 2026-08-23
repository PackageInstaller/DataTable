local var_0_0 = g.core.const.ConstMgr.ShareConst
local var_0_1 = g.core.const.ConstMgr.PlatformConst
local var_0_2 = g.core.config.knight_base_info
local ShareShotComp = class("ShareShotComp", require("app.fairyGUI.share.UI_ShareShotComp"))

function ShareShotComp:ctor()
	if var_0_1.REGION_CFG[config.PUBLISH_REGION] and var_0_1.REGION_CFG[config.PUBLISH_REGION].SHARE_PNG_PATH and not g.core.platform.PlatformProxy:isChannelOfEnPC() and not g.core.platform.PlatformProxy:isChannelOfKrPC() then
		self.m_inviteCode:setURL(var_0_1.REGION_CFG[config.PUBLISH_REGION].SHARE_PNG_PATH)
	else
		self.m_inviteCode:setVisible(false)
	end

	self.m_showBgController:setSelectedIndex(0)
	self.m_nameText:setText((g.core.model.User:getName()))
	self.m_idText:disableAutoChange()
	self.m_idText:setText((g.core.model.User:getId()))
	self.m_logo:setURL(g.core.common.Path:getShareLogoByRegionId(config.PUBLISH_REGION))
	self:_changeShotSize()
end

function ShareShotComp:updateView(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	if arg_2_1.shareType == var_0_0.SHARE_TYPE.TYPE_ID_3 then
		self.m_showBgController:setSelectedIndex(1)
		self.m_bgLoader:setURL("bg/common/pic_yht_beijing.jpg")
		self.m_shotLoader:setURL((g.core.common.Path:getKnightPicById(var_0_2.get(arg_2_1.resId).painted_id)))
	else
		local var_2_0 = g.core.model.User.ShareData:getShotPath()

		display.removeImage(var_2_0)
		self.m_shotLoader:setURL(var_2_0)
	end
end

function ShareShotComp:_changeShotSize()
	local var_3_0 = cc.Director:getInstance():getOpenGLView():getFrameSize()
	local var_3_1 = self.m_shotLoader:getSize().width
	local var_3_2 = self.m_shotLoader:getSize().height
	local var_3_3 = var_3_2 * (var_3_0.width / var_3_0.height)
	local var_3_4 = var_3_2

	if var_3_0.width / var_3_0.height < 1.53 then
		var_3_3 = var_3_1
		var_3_4 = var_3_1 / (var_3_0.width / var_3_0.height)
	end

	self.m_shotLoader:setSize(var_3_3, var_3_4)
	self.m_bgLoader:setSize(var_3_3, var_3_4)
end

return ShareShotComp

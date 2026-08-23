local BaseEmptyText = class("BaseEmptyText", require("app.fairyGUI.base_new.UI_BaseEmptyText"))

function BaseEmptyText:ctor()
	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
		self.m_englishText:setVisible(false)
	end
end

return BaseEmptyText

local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.newYearWishData
local NewYearWishConst = require("app.view.module.newYearWish.const.NewYearWishConst")
local GMWishUnsignBtn = class("GMWishUnsignBtn", require("app.fairyGUI.newYearWish.UI_GMWishUnsignBtn"))
local var_0_5 = {
	AWARD = 0,
	UNSIGN = 1
}

function GMWishUnsignBtn:ctor()
	self.m_effComp:addEffectSpine({
		isLoop = true,
		name = "eff_ui_newYearWish_btnlizi"
	})

	self._colorType = "chun"

	self:_initView()
end

function GMWishUnsignBtn:_initView()
	local var_2_0 = var_0_2:getResId()

	self._colorType = NewYearWishConst.GM_COLOR_TYPE[var_2_0]

	self.m_unsignBg:setURL(var_0_1:getGMWishResultPopRes(var_2_0) .. self._colorType .. NewYearWishConst.GM_RES_NAME.UNSIGN_BG .. ".png")
	self.m_titleLoader:setURL("ui://text_new/" .. self._colorType .. NewYearWishConst.GM_TEXT_RES_NAME.UNSIGN)
end

function GMWishUnsignBtn:refreshTitleRes()
	self.m_titleLoader:setURL(self.m_viewTypeController:getSelectedIndex() == var_0_5.AWARD and "ui://text_new/" .. self._colorType .. NewYearWishConst.GM_TEXT_RES_NAME.UNSIGN or "ui://text_new/" .. self._colorType .. NewYearWishConst.GM_TEXT_RES_NAME.BACK)
end

return GMWishUnsignBtn

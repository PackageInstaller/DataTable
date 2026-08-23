local RecruitLimitCompBase = require("app.view.module.recruit.view.limitRecruit.RecruitLimitCompBase")
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local RecruitLimitKnightshipComp = class("RecruitLimitKnightshipComp", require("app.fairyGUI.recruitKnight.UI_RecruitLimitKnightshipComp"), RecruitLimitCompBase)

function RecruitLimitKnightshipComp:ctor()
	if not self._initSubComps then
		RecruitLimitCompBase.bindClassRef(self, RecruitLimitKnightshipComp)
		RecruitLimitCompBase.ctor(self)
	end

	if self.m_giftBtn then
		self.m_giftBtn:addClickListener(handler(self, self._onClickGiftBtn))
	end
end

function RecruitLimitKnightshipComp:_initOtherUI()
	if self.m_giftBtn then
		local var_2_0 = self:_checkThemeActivityOpen()

		self.m_giftBtn:setVisible(var_2_0)

		if var_2_0 then
			local var_2_1 = self._recruitCfg.activity_id
			local var_2_2 = g.core.config.activity_theme_display_info.fetch(self._recruitCfg.activity_id)

			self.m_giftBtn:setTitle((var_2_2 or nil) and (var_2_2.gift_name or ""))
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = self.m_giftBtn,
				customData = {
					themeValue = var_2_1
				}
			})
		end
	end
end

function RecruitLimitKnightshipComp:_checkThemeActivityOpen()
	if self._recruitCfg.activity_id == 0 then
		return false
	end

	local var_3_0 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(var_0_1.THEME_TYPE, self._recruitCfg.activity_id)

	if not var_3_0 then
		return false
	end

	return var_3_0:isOpen() and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SUMMER_ACTIVITY)
end

function RecruitLimitKnightshipComp:_onClickGiftBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.shop.view.shopThemeGift.ShopThemeGiftPop").new({
		activityValue = self._recruitCfg.activity_id
	})))
end

return RecruitLimitKnightshipComp

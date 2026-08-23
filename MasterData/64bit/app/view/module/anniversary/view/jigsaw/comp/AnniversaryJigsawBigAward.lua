local var_0_0 = g.core.model.User.anniversaryData
local var_0_1 = g.core.const.ConstMgr.AnniversaryConst
local AnniversaryJigsawBigAward = class("AnniversaryJigsawBigAward", require("app.fairyGUI.anniversary.UI_AnniversaryJigsawBigAward"))

function AnniversaryJigsawBigAward:ctor()
	self.m_bg:setURL(var_0_0:getActivityResource("ui_cocos", "pic_xmhy_zzjianglidi.png"))
	self.m_effLoop:addEffectSpine({
		anim = "play",
		isLoop = true,
		name = (var_0_0:getActivityId() > 1 or nil) and "eff_ui_anniversaryJigsaw_lastbgglow" .. var_0_0:getAnniversaryInfo().file_type
	})
end

function AnniversaryJigsawBigAward:updateBigAward()
	self.m_bigNameTxt:setColor(var_0_1.hexToRgb(var_0_0:getAnniversaryInfo().jigsaw_final_reward_purple_color))

	local var_2_0 = var_0_0:getJigSawAllCollectedAward()[1]

	self.m_awardIconLoader:setURL(g.core.common.Goods:convert(var_2_0).icon)
	self.m_numTxt:setText(g.core.lang:get(109066, {
		num = var_2_0.size
	}))
	self.m_numTxt:setColor(g.core.common.Color.A6)
	self.m_isGetController:setSelectedIndex(var_0_0:isGetFinallyBigAward() and 1 or 0)
	self.m_awardTxt:enableOutline(2, var_0_1.hexToRgb(var_0_0:getAnniversaryInfo().jigsaw_white_font_color))
end

return AnniversaryJigsawBigAward

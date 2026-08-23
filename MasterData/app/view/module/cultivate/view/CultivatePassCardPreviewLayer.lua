local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.cultivateDataMgr
local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local var_0_4 = g.core.common.Path
local CultivatePassCardPreviewLayer = class("CultivatePassCardPreviewLayer", require("app.fairyGUI.cultivate.UI_CultivatePassCardPreviewLayer"), function()
	return fgui.GComponent:create({
		resName = "CultivatePassCardPreviewLayer",
		pkgPath = "ui/cultivate/cultivate",
		isFullScreen = true,
		pkgName = "cultivate"
	}, ...)
end)

function CultivatePassCardPreviewLayer:ctor(arg_2_1)
	self._actId = type(arg_2_1) ~= "table" and arg_2_1 or arg_2_1.route1
	self._actData = var_0_2:getCultivateData(self._actId)

	self:addBg("bg/cultivate/" .. var_0_2:getResDirId(self._actId) .. "/bg_main.jpg")

	self._freeReward = nil
	self._payReward = nil

	self.m_freeRewardList:setVirtual()
	self.m_freeRewardList:setItemRenderer(handler(self, self._onFreeRewardRenderer))
	self.m_payRewardList:setVirtual()
	self.m_payRewardList:setItemRenderer(handler(self, self._onPayRewardRenderer))
	self:initPassCardView()
end

function CultivatePassCardPreviewLayer:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	self.m_enterTransition:play()

	if not self._actData:isInNormalOpenTime() then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function CultivatePassCardPreviewLayer:_onCrossDayUpdate()
	if not self._actData:isInNormalOpenTime() then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	if self._actId then
		g.core.network.GameNetProxy:send_C2S_CultivateActivity_GetInfo({
			activity_id = self._actId
		})
	end
end

function CultivatePassCardPreviewLayer:initPassCardView()
	local var_5_0 = self._actData:getActivityCfg()
	local var_5_1 = g.core.config.cultivate_activity_display_info.get(var_5_0.id)

	self.m_freeRewardTxt:setText(var_5_1.free_des)
	self.m_payRewardTxt:setText(var_5_1.pay_des)
	self.m_topBarComp:setResInfoById(var_5_1.interface_passcard)
	self.m_topBarComp:setTitle(var_5_1.module_passcard)
	self.m_colorTypeController:setSelectedIndex(var_5_1.color_des - 1)
	self.m_textLoader:setURL(var_0_4:getCultivateMulLangImage("txt_zl_tishi", var_0_2:getResDirId(self._actId)))
	self.m_itemLoader:setIcon(var_0_4:getCultivateImage("pic_main", var_0_2:getResDirId(self._actId)))
	self.m_titleLoader:setURL(var_0_4:getCultivateMulLangImage("txt_zl_yxss", var_0_2:getResDirId(self._actId)))
	self.m_freeRewardBgLoader:setURL(var_0_4:getCultivateImage("pic_bg_zl_1free", var_0_2:getResDirId(self._actId)))
	self.m_rewardBgLoader:setURL(var_0_4:getCultivateImage("pic_bg_zl_2value", var_0_2:getResDirId(self._actId)))
	self.m_iconBgLoader:setURL(var_0_4:getCultivateImage("pic_zl_zs", var_0_2:getResDirId(self._actId)))
	self.m_lineLoader:setIcon(var_0_4:getCultivateImage("pic_mainzs", var_0_2:getResDirId(var_5_0.id)))
	self.m_rewardBtn:updatePassCardActiveBtn(self._actId)
	self.m_timeDiGraph:setColor(cc.c3b(CultivateConst.hexToRgb(var_5_1.color_time)))

	local var_5_2, var_5_3 = self._actData:getPassCardData():getPreviewFreeReward()

	self._freeReward = var_5_2
	self._payReward = var_5_3

	self.m_freeRewardList:setNumItems(#var_5_2)
	self.m_payRewardList:setNumItems(#var_5_3)
	self:updatePassCardTime()
end

function CultivatePassCardPreviewLayer:updatePassCardTime()
	local var_6_0, var_6_1, var_6_2, var_6_3 = g.core.common.ServerTime:getLeftTimeParts((self._actData:getEndTime()))

	self.m_timeTxt:setText(g.core.lang:get(421407, {
		day = var_6_0,
		hour = var_6_1
	}))
end

function CultivatePassCardPreviewLayer:_onFreeRewardRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateBigReward(self._freeReward[arg_7_1 + 1], self._actId)
end

function CultivatePassCardPreviewLayer:_onPayRewardRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateSmallReward(self._payReward[arg_8_1 + 1], self._actId)
end

return CultivatePassCardPreviewLayer

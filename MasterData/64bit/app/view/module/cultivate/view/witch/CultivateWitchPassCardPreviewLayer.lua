local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local DrawSuccuba = require("app.view.common.DrawSuccuba")
local var_0_3 = g.core.model.User.cultivateDataMgr
local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local var_0_5 = g.core.common.Path
local CultivateWitchPassCardPreviewLayer = class("CultivateWitchPassCardPreviewLayer", require("app.fairyGUI.cultivate.UI_CultivateWitchPassCardPreviewLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/cultivate/cultivate",
		resName = "CultivateWitchPassCardPreviewLayer",
		pkgName = "cultivate"
	}, ...)
end)

function CultivateWitchPassCardPreviewLayer:ctor(arg_2_1)
	self._actId = type(arg_2_1) ~= "table" and arg_2_1 or arg_2_1.route1
	self._actData = var_0_3:getCultivateData(self._actId)

	self:addBg("bg/cultivate/" .. var_0_3:getResDirId(self._actId) .. "/bg_main.jpg")

	self._freeReward = nil
	self._payReward = nil

	self.m_freeRewardList:setVirtual()
	self.m_freeRewardList:setItemRenderer(handler(self, self._onFreeRewardRenderer))
	self.m_payRewardList:setVirtual()
	self.m_payRewardList:setItemRenderer(handler(self, self._onPayRewardRenderer))
	self:initPassCardView()
end

function CultivateWitchPassCardPreviewLayer:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	self.m_enterTransition:play()

	if not self._actData:isInNormalOpenTime() then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function CultivateWitchPassCardPreviewLayer:_onCrossDayUpdate()
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

function CultivateWitchPassCardPreviewLayer:initPassCardView()
	local var_5_0 = g.core.config.cultivate_activity_display_info.get(self._actData:getActivityCfg().id)

	self.m_freeRewardTxt:setText(var_5_0.free_des)
	self.m_payRewardTxt:setText(var_5_0.pay_des)
	self.m_topBarComp:setResInfoById(var_5_0.interface_passcard)
	self.m_topBarComp:setTitle(var_5_0.module_passcard)
	self.m_passCardBgLoader:setURL(var_0_5:getCultivateImage("pic_bg_mnzj_zhanlingdikuang", var_0_3:getResDirId(self._actId)))
	self.m_colorTypeController:setSelectedIndex(var_5_0.color_des - 1)
	self.m_textLoader:setURL(var_0_5:getCultivateMulLangImage("txt_mnzj_tishi1", var_0_3:getResDirId(self._actId)))
	self.m_freeRewardBgLoader:setURL(var_0_5:getCultivateImage("pic_bg_mnzj_free", var_0_3:getResDirId(self._actId)))
	self.m_rewardBgLoader:setURL(var_0_5:getCultivateImage("pic_bg_mnzj_value", var_0_3:getResDirId(self._actId)))
	self.m_rewardBtn:updatePassCardActiveBtn(self._actId)
	self.m_timeDiGraph:setColor(cc.c3b(CultivateConst.hexToRgb(var_5_0.color_time)))
	self:_addAssistant()

	local var_5_1, var_5_2 = self._actData:getPassCardData():getPreviewFreeReward()

	self._freeReward = var_5_1
	self._payReward = var_5_2

	self.m_freeRewardList:setNumItems(#var_5_1)
	self.m_payRewardList:setNumItems(#var_5_2)
	self:updatePassCardTime()
end

function CultivateWitchPassCardPreviewLayer:_addAssistant()
	self.m_knightComp:removeChildren()

	local var_6_0 = self._actData:getActivityCfg().recruit_route
	local var_6_1 = {
		resId = var_6_0 > 0 and var_6_0 or 20700720,
		dir_res = var_6_0 > 0 and var_6_0 or 20700720
	}

	var_6_1.isShowBg = false
	var_6_1.isAlphaNode = true

	self.m_knightComp:addChild((DrawSuccuba.new(var_6_1)))
end

function CultivateWitchPassCardPreviewLayer:updatePassCardTime()
	local var_7_0, var_7_1, var_7_2, var_7_3 = g.core.common.ServerTime:getLeftTimeParts((self._actData:getEndTime()))

	self.m_timeTxt:setText(g.core.lang:get(421407, {
		day = var_7_0,
		hour = var_7_1
	}))
end

function CultivateWitchPassCardPreviewLayer:_onFreeRewardRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateBigReward(self._freeReward[arg_8_1 + 1], self._actId)
end

function CultivateWitchPassCardPreviewLayer:_onPayRewardRenderer(arg_9_1, arg_9_2)
	arg_9_2:updateSmallReward(self._payReward[arg_9_1 + 1], self._actId)
end

return CultivateWitchPassCardPreviewLayer

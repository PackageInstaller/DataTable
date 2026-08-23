local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.network.GameNetProxy
local var_0_3 = g.core.model.User.skinGoodsData
local var_0_4 = g.core.model.User.skinData
local var_0_5 = g.core.config.recharge_rebate_info
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_7 = g.core.model.User.activityPermanentRechargeData
local ActivityPermanentRechargeComp = class("ActivityPermanentRechargeComp", require("app.fairyGUI.activity.UI_ActivityPermanentRechargeComp"))

function ActivityPermanentRechargeComp:ctor()
	self:addListen(self.m_buyComp)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.PERMANENT_RECHARGE)
end

function ActivityPermanentRechargeComp:onLoad()
	if not var_0_7:getTempSavePreId() then
		var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_RECHARGE_GETRECHARGEREBATEINFO, self._onRcvRechargeRebateInfo, self)
	end

	var_0_2:send_C2S_Recharge_GetRechargeRebateInfo({})
end

function ActivityPermanentRechargeComp:_onRcvRechargeRebateInfo()
	self.m_buyComp:updateView((var_0_7:getFirstNotReceiveId()))
end

function ActivityPermanentRechargeComp:updateComp(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = var_0_7:getTempSavePreId()

	var_0_7:tempSavePreId(nil)

	var_4_0 = var_4_0 or var_0_7:getFirstNotReceiveId()

	self.m_buyComp:updateView(var_4_0)
	self:_refreshSkinInfo(var_4_0)
	self.m_enterTransition:play()
end

function ActivityPermanentRechargeComp:_refreshSkinInfo(arg_5_1)
	self._skinIndex = var_0_7:getSkinIndex()

	local var_5_0 = var_0_5.get(arg_5_1).spine
	local var_5_1 = g.core.common.Goods.TYPE_KNIGHT

	if self._skinIndex == arg_5_1 then
		var_5_1 = g.core.common.Goods.TYPE_SKIN

		local var_5_2, var_5_3 = var_0_3:getSkinTalentSkillBySkinId(var_5_0)

		self.m_attrTxt:setText((var_5_3 ~= "" or nil) and var_5_2 .. "\n" .. var_5_3)
		self.m_canBuyController:setSelectedIndex(var_0_4:getSkinState(var_5_0) ~= 1 and 1 or 0)
		self.m_skinAttrGroup:setVisible(true)
	else
		self.m_skinAttrGroup:setVisible(false)
	end

	self.m_lookBtn:initButton(var_5_0, var_5_1)
	self:_addAssistant(var_5_0)
end

function ActivityPermanentRechargeComp:_addAssistant(arg_6_1)
	self.m_knightComp:removeChildren()

	local var_6_0 = {
		resId = arg_6_1 > 0 and arg_6_1 or 700060
	}

	var_6_0.isShowBg = true
	var_6_0.isAlphaNode = true

	local var_6_1 = DrawKnight.new(var_6_0)

	var_6_1:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-150, -10, 390, 100), 300)
	self.m_knightComp:addChild(var_6_1)
end

function ActivityPermanentRechargeComp:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "CurIndex" then
		self:_refreshSkinInfo(arg_7_2.index)
	end
end

return ActivityPermanentRechargeComp

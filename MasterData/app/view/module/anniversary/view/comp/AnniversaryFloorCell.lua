local var_0_0 = g.core.const.ConstMgr.AnniversaryConst
local var_0_1 = g.core.model.User.anniversaryData
local AnniversaryFloorCell = class("AnniversaryFloorCell", require("app.fairyGUI.anniversary.UI_AnniversaryFloorCell"))

function AnniversaryFloorCell:ctor()
	self._awardData = nil
	self._index = 1
	self._rewardList = {}

	self:_initView()
	self:_initBtn()
	self:_initListView()
end

function AnniversaryFloorCell:_initView()
	self.getSharedTrans(self, "enter_left", "CommonCardCellList", self)

	self._getEff = self.m_getEffLoader:addEffectSpine({
		anim = "play",
		isLoop = true,
		name = (var_0_1:getActivityId() > 1 or nil) and "eff_ui_anniversary_getlight" .. var_0_1:getAnniversaryInfo().file_type
	})

	self.m_limitNumText:enableRich()
end

function AnniversaryFloorCell:_initBtn()
	self.m_getAwardBtn:addClickListener(handler(self, self._onBuyClick))
end

function AnniversaryFloorCell:_initListView()
	self.m_rewardList:setVirtual()
	self.m_rewardList:doFairyBatching(false)
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
	self.m_bg:setURL(var_0_1:getActivityResource("ui_cocos", "pic_xmhy_jfjianglidi.png"))
	self.m_zhezhao:setURL(var_0_1:getActivityResource("ui_cocos", "pic_xmhy_jfjianglidizz.png"))
	self.m_getAwardBtn:setURL(var_0_1:getActivityResource("ui_cocos", "btn_xmhy_lingqu.png"))
	self.m_nameText:setColor(var_0_0.hexToRgb(var_0_1:getAnniversaryInfo().theater_reward_name_color))
	self.m_getAwardTxt:setColor(var_0_0.hexToRgb(var_0_1:getAnniversaryInfo().theater_receive_color))
end

function AnniversaryFloorCell:_onRenderRewardList(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._rewardList[arg_5_1 + 1], self._awardData.state)
end

function AnniversaryFloorCell:updateCell(arg_6_1, arg_6_2)
	if not arg_6_1 then
		return
	end

	self._awardData = arg_6_1
	self._index = arg_6_2

	local var_6_0 = var_0_1:getCurFloor()
	local var_6_1 = var_0_1:getCurScore()
	local var_6_2 = var_6_1 < arg_6_1.scoreNum and 431603 or 431604

	self._rewardList = arg_6_1.awards

	self.m_rewardList:setNumItems(#self._rewardList)
	self.m_nameText:setText(g.core.lang:get(431602, {
		floor = var_6_0,
		index = arg_6_2
	}))
	self.m_iconLoader:setURL(g.core.common.Goods:convert({
		size = 0,
		type = var_0_0.SCORE_TYPE,
		value = var_0_0.SCORE_VALUE
	}).icon_mini)
	self.m_limitNumText:setText(g.core.lang:get(var_6_2, {
		curNum = var_6_1,
		targetNum = arg_6_1.scoreNum
	}))
	self.m_stateController:setSelectedIndex(arg_6_1.state)
	self.m_indexController:setSelectedIndex(arg_6_2 - 1)
	self._getEff:setVisible(arg_6_1.state == var_0_0.FLOOR_AWARD.CAN_GET)
end

function AnniversaryFloorCell:_onBuyClick()
	if not self._awardData or self._awardData.state ~= var_0_0.FLOOR_AWARD.CAN_GET then
		return
	end

	g.core.network.GameNetProxy:send_C2S_Anniversary_GetFloorAward({
		floor = var_0_1:getCurFloor(),
		target = self._index
	})
end

return AnniversaryFloorCell

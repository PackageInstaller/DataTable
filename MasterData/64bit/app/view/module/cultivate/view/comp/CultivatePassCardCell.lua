local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local var_0_1 = g.core.model.User.cultivateDataMgr
local var_0_2 = g.core.common.Path
local CultivatePassCardCell = class("CultivatePassCardCell", require("app.fairyGUI.cultivate.UI_CultivatePassCardCell"))

function CultivatePassCardCell:ctor()
	self.m_rewardBtn:addClickListener(handler(self, self._onRewardClick))
	self.m_freeItem:addClickListener(handler(self, self._onClickRewardFree))
	self.m_freeItem:setUnClickSelfEvent(true)
	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self.onItemRenderer))
end

function CultivatePassCardCell:_onRewardClick()
	if var_0_1:getCultivateData(self._actId):getPassCardData():getLevel() >= self._item.lvCfg.level then
		if self._item.payNum < self._item.lvCfg.buy_num then
			if self._rechargeInfo then
				g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._rechargeInfo, self._actId, self._item.lvCfg.id)
			end
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(421411))
		end
	else
		g.view.entrance.ModuleGotoProxy:gotoModule(self._item.lvCfg.route_id)
	end
end

function CultivatePassCardCell:_onClickRewardFree()
	if var_0_1:getCultivateData(self._actId):getPassCardData():getLevel() >= self._item.lvCfg.level then
		if self._item and not self._item.rewardFree then
			g.core.network.GameNetProxy:send_C2S_CultivateActivity_PasscardGift({
				activity_id = self._actId,
				passcard_ids = {
					self._item.lvCfg.id
				}
			})
		end
	else
		self.m_freeItem:showGetTip()
	end
end

function CultivatePassCardCell:updatePassCardCell(arg_4_1, arg_4_2, arg_4_3)
	self._actId = arg_4_3
	self._item = arg_4_1
	self._actData = var_0_1:getCultivateData(arg_4_3)

	local var_4_0 = var_0_1:getCultivateData(arg_4_3):getPassCardData():getLevel()

	if var_4_0 < arg_4_1.lvCfg.level then
		self.m_indexLoader:setURL(var_0_2:getCultivateImage(self._actData:isWitchActivity() and "pic_mnzj_zl_star2" or "pic_zl_star2", g.core.model.User.cultivateDataMgr:getResDirId(arg_4_3)))
		self.m_indexController:setSelectedIndex(1)
	else
		self.m_indexLoader:setURL(var_0_2:getCultivateImage(self._actData:isWitchActivity() and "pic_mnzj_zl_star1" or "pic_zl_star1", g.core.model.User.cultivateDataMgr:getResDirId(arg_4_3)))
		self.m_indexController:setSelectedIndex(0)
	end

	self.m_limitTxt:setText("")
	self.m_indexTxt:setText(arg_4_1.lvCfg.level - 1)
	self.m_indexTxt2:setText(arg_4_1.lvCfg.level - 1)

	local var_4_1 = CultivateConst.PASS_CARE_PAY_STATE.UN_ACTIVE

	self.m_freeItem:updateItemState(0)

	local var_4_2 = g.core.config.cultivate_activity_display_info.get(arg_4_3)

	self.m_lineGraph1:setColor(cc.c3b(CultivateConst.hexToRgb(var_4_2.color_line)))
	self.m_lineGraph2:setColor(cc.c3b(CultivateConst.hexToRgb(var_4_2.color_line)))

	if var_4_0 >= arg_4_1.lvCfg.level then
		if not arg_4_1.rewardFree then
			self.m_freeItem:updateItemState(1)
		else
			self.m_freeItem:updateItemState(2)
		end

		var_4_1 = arg_4_1.payNum >= arg_4_1.lvCfg.buy_num and CultivateConst.PASS_CARE_PAY_STATE.ALL_BUY or CultivateConst.PASS_CARE_PAY_STATE.ACTIVE

		self.m_limitTxt:setText(g.core.lang:get(421404, {
			num = arg_4_1.payNum,
			num2 = arg_4_1.lvCfg.buy_num
		}))
	end

	local var_4_3 = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(28, arg_4_1.lvCfg.money)
	local var_4_4 = ""

	if var_4_3 then
		var_4_4 = var_4_3.moneyUnit .. var_4_3.realMoney
	end

	self._rechargeInfo = var_4_3

	self.m_rewardBtn:updatePassCardBtn(arg_4_3, var_4_1, var_4_4)
	self.m_freeItem:updateCultivatePassItem(arg_4_1.freeDrop[1], arg_4_3)

	self._rewardItems = arg_4_1.payDrop
	self._activeState = var_4_1

	self.m_itemList:setNumItems(#arg_4_1.payDrop)
end

function CultivatePassCardCell:onItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateCultivatePassItem(self._rewardItems[arg_5_1 + 1], self._actId)

	if self._activeState == CultivateConst.PASS_CARE_PAY_STATE.ALL_BUY then
		arg_5_2:updateItemState(2)
	else
		arg_5_2:updateItemState(0)
	end
end

return CultivatePassCardCell

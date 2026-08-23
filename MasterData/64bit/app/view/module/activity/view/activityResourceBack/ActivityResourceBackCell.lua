local var_0_0 = g.core.const.ConstMgr.ResourceBackConst
local var_0_1 = g.core.model.User.resouceBackData
local ActivityResourceBackCell = class("ActivityResourceBackCell", require("app.fairyGUI.activity.UI_ActivityResourceBackCell"))

function ActivityResourceBackCell:ctor()
	self._data = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self.m_getBtn:addClickListener(handler(self, self._onGetResourceBtn))
	self.m_debugBtn:addClickListener(handler(self, self._onClickDebugBtn))
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function ActivityResourceBackCell:updateResourceBackCell(arg_2_1, arg_2_2)
	self._awardData = var_0_1:getRetrieveAwards(arg_2_1.cfg.id, arg_2_2)

	self.m_nameTxt:setText(arg_2_1.cfg.name)
	self.m_timeTxt:setText(arg_2_1.svrData.remainder_times)
	self.m_getBtn:updateBtnInfo(arg_2_1, arg_2_2)

	self._data = arg_2_1
	self._getType = arg_2_2

	self.m_awardList:setNumItems(#self._awardData)
end

function ActivityResourceBackCell:_onAwardItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awardData[arg_3_1 + 1])
end

function ActivityResourceBackCell:_onGetResourceBtn()
	local var_4_0 = 0
	local var_4_1 = 0

	if self._getType == 1 then
		var_4_0 = self._data.cfg.normal_cost * self._data.svrData.retrieveDays
		var_4_1 = g.core.model.User.resourceData:getCoin()
	else
		var_4_0 = self._data.cfg.buy_cost * self._data.svrData.retrieveDays
		var_4_1 = g.core.model.User:getFreeGold()
	end

	if var_4_0 <= var_4_1 then
		if self._getType == 1 or not var_0_1:getIsShowBuyTip() then
			self:_sendC2SRetrieveRes()
		else
			local var_4_2 = require("app.view.base.pop.BaseConfirmPop").new

			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(410500),
				desc = g.core.lang:get(410501, {
					cost = var_4_0,
					functionName = self._data.cfg.name
				}),
				onConfirm = handler(self, self._sendC2SRetrieveRes),
				onCheck = function(arg_5_0)
					var_0_1:setIsShowBuyTip(not arg_5_0)
				end,
				tip = {
					txt = g.core.lang:get(408110)
				}
			}))
		end
	else
		local var_4_3

		if self._getType == var_0_0.NORMAL_TYPE then
			var_4_3 = var_0_0.NORMAL_COST or var_0_0.GOLD_COST
		end

		var_4_3.curSize = var_4_1
		var_4_3.needSize = var_4_0

		g.view.entrance.ModuleGotoProxy:gotoModuleBySource(var_4_3, {
			ignoreConfirm = true
		})
	end
end

function ActivityResourceBackCell:_sendC2SRetrieveRes()
	if tolua.isnull(self) then
		return
	end

	g.core.network.GameNetProxy:send_C2S_Retrieve_Res({
		id = self._data.cfg.id,
		buy_type = self._getType
	})
end

function ActivityResourceBackCell:_onClickDebugBtn()
	local var_7_0 = var_0_1:getRetrieveResDebugData(self._data.cfg.id)

	if var_7_0 then
		self:addPopup(require("app.view.module.activity.view.activityResourceBack.ActivityRetrieveDebugPop").new(var_7_0))
	end
end

return ActivityResourceBackCell

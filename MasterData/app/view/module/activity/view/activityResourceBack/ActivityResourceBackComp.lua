local var_0_0 = g.core.model.User.resouceBackData
local var_0_1 = g.core.const.ConstMgr.ResourceBackConst
local ActivityResourceBackComp = class("ActivityResourceBackComp", require("app.fairyGUI.activity.UI_ActivityResourceBackComp"))

function ActivityResourceBackComp:ctor()
	self._backType = 2
	self._retrieveData = {}

	self:_initRegisterUI()
end

function ActivityResourceBackComp:_initRegisterUI()
	self.m_taskList:setVirtual()
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onItemRenderTaskList))
	self.m_typeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTypeCtrlChange))
	self.m_typeController:setSelectedIndex(math.max(0, self._backType - 1))
	self.m_getAllBtn:addClickListener(handler(self, self._onClickGetAllBtn))
end

function ActivityResourceBackComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RETRIEVE_GETINFO, handler(self, self._onS2CRetrieveGetInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RETRIEVE_RES, handler(self, self._onS2CRetrieveRes), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RETRIEVE_OPRETRIEVERES, handler(self, self._onS2COpRetrieveres), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RETRIEVE_RES_ONEKEY, handler(self, self._onS2COpRetrieveresOneKey), self)
	g.core.network.GameNetProxy:send_C2S_Retrieve_GetInfo({})
end

function ActivityResourceBackComp:updateComp()
	self.m_enterTransition:play()
end

function ActivityResourceBackComp:_updateResourceBackView()
	self._retrieveData = var_0_0:getRetrieveResList(self._backType)

	self.m_isEmptyController:setSelectedIndex(#self._retrieveData == 0 and 1 or 0)
	self.m_taskList:setNumItems(#self._retrieveData)
	self.m_taskList:transitionShowCells("enter_left", 0.03)
	self.m_getAllBtn:updateAllCostInfo(var_0_0:getAllRetrieveCostByType(self._backType), self._backType)
	self.m_descTxt:setText(g.core.lang:get(410503, {
		day = var_0_1.MAX_RETRIEVE_DAY
	}))
end

function ActivityResourceBackComp:_onItemRenderTaskList(arg_6_1, arg_6_2)
	arg_6_2:updateResourceBackCell(self._retrieveData[arg_6_1 + 1], self._backType)
end

function ActivityResourceBackComp:_onTypeCtrlChange()
	self._backType = self.m_typeController:getSelectedIndex() + 1

	self:_updateResourceBackView()
end

function ActivityResourceBackComp:_onClickGetAllBtn()
	local var_8_0 = var_0_0:getAllRetrieveCostByType(self._backType)
	local var_8_1 = 0

	var_8_1 = self._backType == var_0_1.NORMAL_TYPE and g.core.model.User.resourceData:getCoin() or g.core.model.User:getFreeGold()

	if var_8_0 <= var_8_1 then
		local var_8_2 = var_0_0:getRetrieveResIds(self._backType)

		if self._backType == var_0_1.NORMAL_TYPE then
			g.core.network.GameNetProxy:send_C2S_Retrieve_Res_OneKey({
				ids = var_8_2,
				buy_type = self._backType
			})
		else
			local var_8_3 = self._backType

			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(410500),
				desc = g.core.lang:get(410502, {
					cost = var_8_0
				}),
				onConfirm = function()
					g.core.network.GameNetProxy:send_C2S_Retrieve_Res_OneKey({
						ids = var_8_2,
						buy_type = var_8_3
					})
				end
			}))
		end
	else
		local var_8_4

		if self._backType == var_0_1.NORMAL_TYPE then
			var_8_4 = var_0_1.NORMAL_COST or var_0_1.GOLD_COST
		end

		var_8_4.curSize = var_8_1
		var_8_4.needSize = var_8_0

		g.view.entrance.ModuleGotoProxy:gotoModuleBySource(var_8_4, {
			ignoreConfirm = true
		})
	end
end

function ActivityResourceBackComp:_onS2CRetrieveGetInfo()
	self:_updateResourceBackView()
end

function ActivityResourceBackComp:_onS2CRetrieveRes(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_4 and arg_11_4.id and arg_11_4.buy_type then
		g.core.module.ModuleManager:awardSummary(var_0_0:getRetrieveAwards(arg_11_4.id, arg_11_4.buy_type), true)
	end
end

function ActivityResourceBackComp:_onS2COpRetrieveresOneKey(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_4 and arg_12_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_12_4.awards, true)
		self:_updateResourceBackView()
	end
end

function ActivityResourceBackComp:_onS2COpRetrieveres()
	self:_updateResourceBackView()
end

return ActivityResourceBackComp

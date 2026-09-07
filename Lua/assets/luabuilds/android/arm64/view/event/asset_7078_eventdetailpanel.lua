EventConst = require("view/event/EventConst")

local EventDetailPanel = class("EventDetailPanel")

function EventDetailPanel:Ctor(arg_1_1, arg_1_2)
	pg.DelegateInfo.New(self)

	self.go = arg_1_1
	self.tr = arg_1_1.transform
	self.dispatch = arg_1_2
	self.btn = self.tr:Find("btn").gameObject

	setText(findTF(self.tr, "btn_recommend/text"), pg.gametip.event_ui_recommend.tip)
	setText(findTF(self.tr, "btn_recommend_disable/text"), pg.gametip.event_ui_recommend.tip)
	setText(findTF(self.tr, "consume/label"), pg.gametip.event_ui_consume.tip)
	setText(findTF(self.tr, "btn/start/text"), pg.gametip.event_ui_start.tip)
	setText(findTF(self.tr, "btn_disable/text"), pg.gametip.event_ui_start.tip)
	setText(findTF(self.tr, "btn/giveup/text"), pg.gametip.event_ui_giveup.tip)
	setText(findTF(self.tr, "btn/finish/text"), pg.gametip.event_ui_finish.tip)

	self.conditions = findTF(self.tr, "conditions")
	self.condition1 = findTF(self.conditions, "condition_1/mask/Text")
	self.condition2 = findTF(self.conditions, "condition_2/mask/Text")
	self.condition3 = findTF(self.conditions, "condition_3/mask/Text")
	self.consume = self.tr:Find("consume/Text")
	self.leftShips = self.tr:Find("frame/ship_contain_left")
	self.rightShips = self.tr:Find("frame/ship_contain_right")
	self.disabeleBtn = self.tr:Find("btn_disable").gameObject
	self.recommentBtn = self.tr:Find("btn_recommend")
	self.recommentDisable = self.tr:Find("btn_recommend_disable")
	self.usePrevFormationBtn = self.tr:Find("use_prev_formation")
	self.shipItems = {}

	eachChild(self.leftShips, function(arg_2_0)
		table.insert(self.shipItems, 1, arg_2_0)

		return
	end)
	eachChild(self.rightShips, function(arg_3_0)
		table.insert(self.shipItems, 4, arg_3_0)

		return
	end)
	onButton(self, self.btn, function()
		self:onFuncClick()

		return
	end, SFX_PANEL)
	onButton(self, self.recommentBtn, function()
		local var_5_0 = getProxy(BayProxy)
		local var_5_1 = var_5_0:getDelegationRecommendShips(self.event)

		if #var_5_1 > 0 then
			table.insertto(self.event.shipIds, var_5_1)
			self:Flush()
		else
			local var_5_2 = var_5_0:getDelegationRecommendShipsLV1(self.event)

			if #var_5_2 > 0 then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("event_recommend_level1"),
					onYes = function()
						table.insertto(self.event.shipIds, var_5_2)
						self:Flush()

						return
					end
				})
			elseif not self.event:reachNum() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("event_recommend_fail"))
			end
		end

		return
	end)
	onButton(self, self.usePrevFormationBtn, function()
		self:UsePrevFormation()

		return
	end, SFX_PANEL)

	return
end

function EventDetailPanel:Update(arg_8_1, arg_8_2)
	self.index = arg_8_1
	self.event = arg_8_2

	self:Flush()

	return
end

function EventDetailPanel:UsePrevFormation()
	if self.event and self.event:ExistPrevFormation() then
		local var_9_0 = {}
		local var_9_1 = false
		local var_9_2 = false

		for iter_9_0, iter_9_1 in ipairs(getProxy(BayProxy):getShipList((self.event:GetPrevFormation()))) do
			if iter_9_1 then
				local var_9_3, var_9_4 = ShipStatus.ShipStatusConflict("inEvent", iter_9_1)

				if var_9_3 == ShipStatus.STATE_CHANGE_FAIL then
					var_9_1 = true
				elseif var_9_3 == ShipStatus.STATE_CHANGE_CHECK then
					var_9_2 = true
				else
					table.insert(var_9_0, iter_9_1.id)
				end
			end
		end

		if var_9_1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("collect_tip"))
		end

		if var_9_2 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("collect_tip2"))
		end

		self.event:setShipIds(var_9_0)
		self:Flush()
	end

	return
end

function EventDetailPanel:Flush()
	setActive(self.usePrevFormationBtn, self.event:ExistPrevFormation() and self.event:GetState() == EventInfo.StateNone and self.event:CanRecordPrevFormation())
	eachChild(self.btn, function(arg_11_0)
		local var_11_0 = self.event:GetState()

		if var_11_0 == EventInfo.StateNone and arg_11_0.name == "start" then
			SetActive(arg_11_0, true)
		elseif var_11_0 == EventInfo.StateActive and arg_11_0.name == "giveup" then
			SetActive(arg_11_0, true)
		elseif var_11_0 == EventInfo.StateFinish and arg_11_0.name == "finish" then
			SetActive(arg_11_0, true)
		else
			SetActive(arg_11_0, false)
		end

		return
	end)

	local var_10_0 = self.event:reachLevel()
	local var_10_1 = self.event:reachNum()
	local var_10_2 = self.event:reachTypes()

	SetActive(self.disabeleBtn, not var_10_0 or not var_10_1 or not var_10_2)

	local var_10_3 = self.event:getShipList()

	setScrollText(self.condition1, (self:setConditionStr(i18n("event_condition_ship_level", self.event.template.ship_lv), var_10_0)))
	setActive(findTF(self.conditions, "condition_1/mark"), var_10_0)
	setActive(findTF(self.conditions, "condition_1/mark1"), not var_10_0)
	setScrollText(self.condition2, (self:setConditionStr(i18n("event_condition_ship_count", self.event.template.ship_num), var_10_1)))
	setActive(findTF(self.conditions, "condition_2/mark"), var_10_1)
	setActive(findTF(self.conditions, "condition_2/mark1"), not var_10_1)
	setScrollText(self.condition3, (self:setConditionStr(self.event:getTypesStr(), var_10_2)))
	setActive(findTF(self.conditions, "condition_3/mark"), var_10_2)
	setActive(findTF(self.conditions, "condition_3/mark1"), not var_10_2)
	setText(self.consume, self.event:getOilConsume())

	for iter_10_0, iter_10_1 in ipairs(self.shipItems) do
		local var_10_4 = iter_10_1:Find("shiptpl")
		local var_10_5 = iter_10_1:Find("emptytpl")
		local var_10_6 = iter_10_0 <= #var_10_3

		SetActive(var_10_4, iter_10_0 <= #var_10_3)
		SetActive(var_10_5, not var_10_6)

		if var_10_6 then
			updateShip(var_10_4, var_10_3[iter_10_0], {
				initStar = true
			})
			setText(findTF(var_10_4, "icon_bg/lv/Text"), var_10_3[iter_10_0].level)
			onButton(self, var_10_4:Find("icon_bg"), function()
				self:onRemoveClick(iter_10_0)

				return
			end, SFX_PANEL)
		else
			onButton(self, var_10_5, function()
				self:onChangeClick()

				return
			end)
		end
	end

	if self.event:GetState() == EventInfo.StateNone then
		SetActive(self.recommentBtn, true)
		SetActive(self.recommentDisable, false)
	else
		SetActive(self.recommentBtn, false)
		SetActive(self.recommentDisable, true)
	end

	return
end

function EventDetailPanel:setConditionStr(arg_14_1, arg_14_2)
	return arg_14_2 and setColorStr(arg_14_1, COLOR_YELLOW) or setColorStr(arg_14_1, "#F35842FF")
end

function EventDetailPanel:Clear()
	pg.DelegateInfo.Dispose(self)

	return
end

function EventDetailPanel:onChangeClick()
	if self.event:GetState() == EventInfo.StateNone then
		self.dispatch(EventConst.EVENT_OPEN_DOCK, self.event)
	end

	return
end

function EventDetailPanel:onRemoveClick(arg_17_1)
	if self.event:GetState() == EventInfo.StateNone then
		table.remove(self.event.shipIds, arg_17_1)
		self:Flush()
	end

	return
end

function EventDetailPanel:onFuncClick()
	local var_18_0 = self.event:GetState()

	if var_18_0 == EventInfo.StateNone then
		self.dispatch(EventConst.EVENT_START, self.event)
	elseif var_18_0 == EventInfo.StateActive then
		self.dispatch(EventConst.EVENT_GIVEUP, self.event)
	elseif var_18_0 == EventInfo.StateFinish then
		self.dispatch(EventConst.EVENT_FINISH, self.event)
	end

	return
end

return EventDetailPanel

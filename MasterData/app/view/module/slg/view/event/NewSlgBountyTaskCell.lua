local NewSlgBountyTaskCell = class("NewSlgBountyTaskCell")

function NewSlgBountyTaskCell:ctor()
	self._scrollTxt = self:getChild("Comp_txt")
	self._scrollDesc = self:getChild("Comp_desc")
	self._targetTxt = self:getChild("Txt_target")
	self._nameTxt = self:getChild("Txt_title")
	self._timeTxt = self:getChild("Txt_time")
	self._itemList = self:getChild("List_item")

	self._itemList:setVirtual(self)
	self._itemList:setItemRenderer(handler(self, self._onRenderListCell))

	self._hasAwardCtrl = self:getController("getReward")
	self._typeCtrl = self:getController("type")
	self._getBtn = self:getChild("Btn_get")

	self._getBtn:addClickListener(handler(self, self._onGetBtnClick))

	self._refreshBtn = self:getChild("Btn_refresh")

	self._refreshBtn:addClickListener(handler(self, self._onRefreshBtnClick))

	self._compTxtMark = self:getChild("Comp_txtMark")
	self._lastType = 0
	self._effect = nil
end

function NewSlgBountyTaskCell:updateCell(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	self._data = arg_2_1
	self._index = arg_2_2

	local var_2_0 = g.core.config.new_slg_bounty_task_info.get(arg_2_1.id)

	self._taskInfo = var_2_0

	self._scrollTxt:setText(var_2_0.story)

	if var_2_0.task_value_2 > 0 then
		self._scrollDesc:setText(g.core.lang:getByString(var_2_0.describe, {
			num1 = var_2_0.task_value_2,
			num2 = var_2_0.task_value_1
		}))
	else
		self._scrollDesc:setText(g.core.lang:getByString(var_2_0.describe, {
			num = var_2_0.task_value_1
		}))
	end

	self._nameTxt:setText(var_2_0.name)
	self._timeTxt:setText(g.core.lang:get(429672))
	self._targetTxt:setText(arg_2_1.progress .. "/" .. var_2_0.task_value_1)
	self:_updateAwards(var_2_0)
	self._hasAwardCtrl:setSelectedIndex((g.core.model.User.newSlgData:getBountyTaskState(arg_2_2)))
	self._typeCtrl:setSelectedIndex(var_2_0.type == 1 and 0 or 1)

	if self._lastType > 0 then
		self:_playRefreshEffect()

		self._lastType = 0
	end
end

function NewSlgBountyTaskCell:_playRefreshEffect()
	return
end

function NewSlgBountyTaskCell:_updateAwards()
	self._awardList = {}

	for iter_4_0, iter_4_1, iter_4_2 in self._taskInfo.gmatch({
		"reward_type_%d+",
		"reward_value_%d+",
		"reward_size_%d+"
	}) do
		local var_4_0 = {
			type = iter_4_2[1],
			value = iter_4_2[2],
			size = iter_4_2[3]
		}

		g.core.model.User.newSlgData:getAndUpdateItemNumAfterAddition(var_4_0, false, g.core.const.ConstMgr.NewSlgConst.ATTR_MODULE.BOUNTY_QUEST)
		table.insert(self._awardList, var_4_0)
	end

	self._itemList:setNumItems(#self._awardList)
end

function NewSlgBountyTaskCell:_onRenderListCell(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._awardList[arg_5_1 + 1], g.core.model.User.newSlgData:getBountyTaskState(self._index) == 2)
end

function NewSlgBountyTaskCell:_onGetBtnClick()
	if g.core.model.User.newSlgData:isExpired() then
		g.core.module.ModuleManager:tip(g.core.lang:get(429673))
		g.core.network.GameNetProxy:send_C2S_NewSlg_BountyInfo({})
	elseif not g.core.model.User.newSlgData:getIgnoreBountyTaskTip() then
		self:addPopup((require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(429674, {
				num = #g.core.model.User.newSlgData:getBountyTasks()
			}),
			tip = {
				txt = g.core.lang:get(1000)
			},
			onConfirm = handler(self, function()
				g.core.network.GameNetProxy:send_C2S_NewSlg_BountyTaskAward({
					index = self._index
				})
			end),
			onCheck = handler(self, function(arg_8_0)
				g.core.model.User.newSlgData:setIgnoreBountyTaskTip(arg_8_0)
			end)
		})))
	else
		g.core.network.GameNetProxy:send_C2S_NewSlg_BountyTaskAward({
			index = self._index
		})
	end
end

function NewSlgBountyTaskCell:_onRefreshBtnClick()
	local var_9_0 = g.core.config.new_slg_bounty_refresh_info.get((math.min(g.core.model.User.newSlgData:getBountyTaskRefreshTimes() + 1, (g.core.config.new_slg_bounty_refresh_info.getLength()))))
	local var_9_1 = self._index

	if not g.core.model.User.newSlgData:getIgnoreRefreshTip() then
		local var_9_2 = {
			title = g.core.lang:get(429675),
			desc = g.core.lang:get(429676)
		}

		var_9_2.cost = var_9_0.type > 0 and {
			showLack = true,
			type = var_9_0.type,
			value = var_9_0.value,
			size = var_9_0.size
		} or nil
		var_9_2.onConfirm = handler(self, function()
			self._lastType = self._taskInfo.type

			g.core.network.GameNetProxy:send_C2S_NewSlg_BountyRefreshTask({
				index = var_9_1
			})
			self:showRefreshEff()
		end)

		self:addPopup((require("app.view.base.pop.BaseConfirmPop").new(var_9_2)))
	else
		self._lastType = self._taskInfo.type

		g.core.network.GameNetProxy:send_C2S_NewSlg_BountyRefreshTask({
			index = self._index
		})
		self:showRefreshEff()
	end
end

function NewSlgBountyTaskCell:showRefreshEff()
	self:getChild("eff"):addEffectSpine({
		anim = "play",
		name = "eff_ui_newSlg_refresh",
		remove = true,
		isLoop = false
	})
end

return NewSlgBountyTaskCell

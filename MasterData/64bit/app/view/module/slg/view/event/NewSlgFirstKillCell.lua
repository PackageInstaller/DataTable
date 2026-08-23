local NewSlgFirstKillCell = class("NewSlgFirstKillCell")

function NewSlgFirstKillCell:ctor()
	self._txtMonsterName = self:getChild("Txt_monsterName")
	self._compAward = self:getChild("Comp_award")
	self._emptyCtrl = self:getController("empty")
	self._listIcons = self:getChild("List_icons")

	self._listIcons:setVirtual(self)
	self._listIcons:setItemRenderer(handler(self, self._onRenderListIcons))

	self._users = {}
end

function NewSlgFirstKillCell:updateCell(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	self._data = arg_2_1

	if arg_2_2 then
		self._users = arg_2_2.users or {}
	end

	self._emptyCtrl:setSelectedIndex(arg_2_2 and 0 or 1)
	self._listIcons:setNumItems(#self._users)
	self._txtMonsterName:setText(g.core.lang:get(428819, {
		level = arg_2_1.level
	}) .. " " .. ((arg_2_2 or nil) and g.core.config.new_slg_boss_info.get(arg_2_2.monster_id).name))
	self:_updateAwards()
end

function NewSlgFirstKillCell:_updateAwards()
	if self._iconEffect then
		self._iconEffect:removeSelf()

		self._iconEffect = nil
	end

	self._compAward:removeAllEffect()

	local var_3_0 = g.core.model.User.newSlgData:canGetFirstKillAwardById(self._data.id)
	local var_3_1 = g.core.model.User.newSlgData:hasGetFirstKillAwardById(self._data.id)
	local var_3_2 = {
		type = self._data.reward_type_1,
		value = self._data.reward_value_1,
		size = self._data.reward_size_1,
		isMask = var_3_1,
		selectGou = var_3_1,
		effect = var_3_0
	}

	g.core.model.User.newSlgData:getAndUpdateItemNumAfterAddition(var_3_2, false, g.core.const.ConstMgr.NewSlgConst.ATTR_MODULE.FIRST_KILL)

	if var_3_0 then
		var_3_2.overrideClick = true
		var_3_2.touchFunc = handler(self, self._onClickAward)

		local var_3_3 = self._compAward:getSize()

		self._compAward:addEffectSpine({
			scale = 0.8,
			isLoop = true,
			name = "eff_ui_common_iconget",
			anim = "play_0",
			x = var_3_3.width / 2 - 2,
			y = var_3_3.height / 2 + 2
		})
	end

	self._compAward:updateIcon(var_3_2, var_3_1)
end

function NewSlgFirstKillCell:_onRenderListIcons(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._users[arg_4_1 + 1])
end

function NewSlgFirstKillCell:_onClickAward()
	self:dispatchCompEvent("NewSlgFirstKillCell_clickAward", {
		id = self._data.id
	})
end

return NewSlgFirstKillCell

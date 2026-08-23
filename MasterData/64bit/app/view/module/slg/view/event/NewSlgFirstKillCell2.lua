local NewSlgFirstKillCell2 = class("NewSlgFirstKillCell2")

function NewSlgFirstKillCell2:ctor()
	self._compUserIcon = self:getChild("Comp_user")
	self._compName = self:getChild("Comp_name")
	self._txtMonsterName = self:getChild("Txt_monsterName")
	self._txtAuthority = self:getChild("Txt_authority")
	self._txtTroops = self:getChild("Txt_troops")
	self._compAward = self:getChild("Comp_award")
	self._compFlag = self:getChild("Comp_flag")
	self._emptyCtrl = self:getController("empty")
	self._isSelfCtrl = self:getController("isself")
end

function NewSlgFirstKillCell2:updateCell(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	self._data = arg_2_1

	local var_2_1

	if arg_2_2 then
		local var_2_0 = arg_2_2.users or {}

		if #var_2_0 > 0 then
			var_2_1 = var_2_0[1] or nil
		end
	end

	local var_2_2

	if var_2_1 and var_2_1.user_id then
		var_2_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_2_1.user_id)
	end

	local var_2_3 = arg_2_1.name

	if var_2_2 then
		self._compUserIcon:updateAsUser(var_2_2)
		self._compUserIcon:setTouchCallFunc(handler(self, function(arg_3_0)
			g.core.utils.Tools.newSlgFunc.openTeamPlayerInfo(var_2_2)
		end))
		self._compName:setText(var_2_2.name)
		self._txtAuthority:setText(var_2_1.authority)
		self._txtTroops:setText(var_2_1.troops)

		var_2_3 = g.core.config.new_slg_monster_info.get(arg_2_2.monster_id, g.core.model.User.newSlgData:getSlgInfo().monster_group).name
	end

	self._txtMonsterName:setText(g.core.lang:get(428819, {
		level = arg_2_1.level
	}) .. " " .. var_2_3)
	self._emptyCtrl:setSelectedIndex(arg_2_2 and 0 or 1)
	self._isSelfCtrl:setSelectedIndex(var_2_2 and var_2_2.id == g.core.model.User:getId() and 1 or 0)
	self:_updateAwards()
end

function NewSlgFirstKillCell2:_updateAwards()
	if self._iconEffect then
		self._iconEffect:removeSelf()

		self._iconEffect = nil
	end

	local var_4_0 = g.core.model.User.newSlgData:canGetFirstKillAwardById(self._data.id)
	local var_4_1 = g.core.model.User.newSlgData:hasGetFirstKillAwardById(self._data.id)
	local var_4_2 = {
		type = self._data.reward_type_1,
		value = self._data.reward_value_1,
		size = self._data.reward_size_1,
		isMask = var_4_1,
		selectGou = var_4_1,
		effect = var_4_0
	}

	g.core.model.User.newSlgData:getAndUpdateItemNumAfterAddition(var_4_2, false, g.core.const.ConstMgr.NewSlgConst.ATTR_MODULE.FIRST_KILL)
	self._compAward:removeAllEffect()

	if var_4_0 then
		var_4_2.overrideClick = true
		var_4_2.touchFunc = handler(self, self._onClickAward)

		local var_4_3 = self._compAward:getSize()

		self._compAward:addEffectSpine({
			scale = 0.8,
			isLoop = true,
			anim = "play_0",
			name = "eff_ui_common_iconget",
			x = var_4_3.width / 2 - 2,
			y = var_4_3.height / 2 + 2
		})
	end

	self._compAward:updateIcon(var_4_2, var_4_1)
end

function NewSlgFirstKillCell2:_onClickAward()
	self:dispatchCompEvent("NewSlgFirstKillCell_clickAward", {
		id = self._data.id
	})
end

return NewSlgFirstKillCell2

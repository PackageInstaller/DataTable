local NewSlgFirstKillCell3 = class("NewSlgFirstKillCell3")

function NewSlgFirstKillCell3:ctor()
	self._compUserIcon = self:getChild("Comp_user")
	self._compName = self:getChild("Comp_name")
	self._txtMonsterName = self:getChild("Txt_monsterName")
	self._emptyCtrl = self:getController("empty")
	self._txtAuthority = self:getChild("Txt_authority")
	self._txtTroops = self:getChild("Txt_troops")
	self._listIcons = self:getChild("List_icons")

	self._listIcons:setVirtual(self)
	self._listIcons:setItemRenderer(handler(self, self._onRenderListIcons))

	self._awardList = {}
	self._isSelfCtrl = self:getController("isself")
	self._compFlag = self:getChild("Comp_flag")
end

function NewSlgFirstKillCell3:updateCell(arg_2_1, arg_2_2)
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
	end

	self._txtMonsterName:setText(g.core.lang:get(428819, {
		level = arg_2_1.level
	}) .. " " .. var_2_3)
	self._emptyCtrl:setSelectedIndex(arg_2_2 and 0 or 1)
	self._isSelfCtrl:setSelectedIndex(var_2_2 and var_2_2.id == g.core.model.User:getId() and 1 or 0)
	self:_updateAwards()
end

function NewSlgFirstKillCell3:_updateAwards()
	self._awardList = {}

	for iter_4_0, iter_4_1, iter_4_2 in self._data.gmatch({
		"reward_type_%d+",
		"reward_value_%d+",
		"reward_size_%d+"
	}) do
		table.insert(self._awardList, {
			type = iter_4_2[1],
			value = iter_4_2[2],
			size = iter_4_2[3]
		})
	end

	self._listIcons:setNumItems(#self._awardList)
end

function NewSlgFirstKillCell3:_onRenderListIcons(arg_5_1, arg_5_2)
	local var_5_0 = g.core.model.User.newSlgData:hasGetFirstKillAwardById(self._data.id)
	local var_5_1 = g.core.model.User.newSlgData:canGetFirstKillAwardById(self._data.id, g.core.const.ConstMgr.NewSlgConst.FIRST_KILL_MAX_TAB)

	self._awardList[arg_5_1 + 1].isMask = var_5_0
	self._awardList[arg_5_1 + 1].selectGou = var_5_0
	self._awardList[arg_5_1 + 1].effect = var_5_1

	g.core.model.User.newSlgData:getAndUpdateItemNumAfterAddition(self._awardList[arg_5_1 + 1], false, g.core.const.ConstMgr.NewSlgConst.ATTR_MODULE.FIRST_KILL)
	arg_5_2:removeAllEffect()

	if var_5_1 then
		self._awardList[arg_5_1 + 1].overrideClick = true
		self._awardList[arg_5_1 + 1].touchFunc = handler(self, self._onClickAward)

		local var_5_2 = arg_5_2:getSize()

		arg_5_2:addEffectSpine({
			name = "eff_ui_common_iconget",
			isLoop = true,
			anim = "play_0",
			scale = 0.8,
			x = var_5_2.width / 2 - 2,
			y = var_5_2.height / 2 + 2
		})
	end

	arg_5_2:updateIcon(self._awardList[arg_5_1 + 1], var_5_0)
end

function NewSlgFirstKillCell3:_onClickAward()
	self:dispatchCompEvent("NewSlgFirstKillCell_clickAward", {
		id = self._data.id
	})
end

return NewSlgFirstKillCell3

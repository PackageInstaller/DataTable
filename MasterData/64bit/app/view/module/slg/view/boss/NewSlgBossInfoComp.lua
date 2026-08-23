local var_0_0 = g.core.model.User.newSlgData
local NewSlgBossInfoComp = class("NewSlgBossInfoComp", require("app.fairyGUI.newSlg.UI_NewSlgBossInfoComp"))

function NewSlgBossInfoComp:ctor()
	self._compBannerInfo = self:getChild("Comp_bannerInfo")
	self._compArmyIcon = self:getChild("Comp_armyIcon")
	self._btnCheckDefenderInfo = self:getChild("Btn_checkDefenderInfo")

	self._btnCheckDefenderInfo:addClickListener(handler(self, self._onClickBtnCheckDefenderInfo))

	self._btnGather = self:getChild("Btn_gather")

	self._btnGather:addClickListener(handler(self, self._onClickBtnGather))

	self._txtName = self:getChild("Txt_name")
	self._txtAuthority = self:getChild("Txt_authority")
	self._listAward = self:getChild("List_award")

	self._listAward:setVirtual(self)
	self._listAward:setItemRenderer(handler(self, self._onRenderListAwardCell))

	self._txtDesc = self:getChild("Txt_desc")
end

function NewSlgBossInfoComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSMONSTERTEAM, handler(self, self._onRcvNewSlgGetBossDefInfo), self)
end

function NewSlgBossInfoComp:_onRcvNewSlgGetBossDefInfo(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self._txtAuthority:setText(var_0_0:getBossTotalAuthority(arg_3_4.boss_id))
end

function NewSlgBossInfoComp:updateView(arg_4_1)
	if not arg_4_1.bossId then
		return
	end

	if not var_0_0:hasBossTotalAuthority(arg_4_1.bossId) then
		g.core.network.GameNetProxy:send_C2S_NewSlg_BossMonsterTeam({
			boss_id = arg_4_1.bossId
		})
	else
		self._txtAuthority:setText(var_0_0:getBossTotalAuthority(arg_4_1.bossId))
	end

	local var_4_0 = var_0_0:getBossComponentById(arg_4_1.bossId)

	if var_0_0:getProvinceCfgByGID((var_0_0:getProvinceGIdByRC(var_4_0.anchor_x, var_4_0.anchor_y))) then
		-- block empty
	end

	self._bossCfg = var_0_0:getBossInfoById(arg_4_1.bossId)
	self._path = arg_4_1.path

	self._txtName:setText(g.core.lang:get(429010, {
		num = self._bossCfg.level,
		name = self._bossCfg.name
	}))
	self._compArmyIcon:updateView({
		armyType = self._bossCfg.boss_army_type
	})
	self._compBannerInfo:updateView({
		scale = 0.7,
		bannerType = g.core.const.ConstMgr.NewSlgConst.SLGBannerType.BOSS,
		res = "#" .. g.core.common.Path:getNewSlgMonster(var_0_0:getBossComponentById(arg_4_1.bossId).res_1)
	})
	self:_updateAwards()
	self:_updateBtn()
	self:getTransition("enter"):play()
end

function NewSlgBossInfoComp:_updateAwards()
	self._awards = g.core.common.Drops:getGoodsArray(self._bossCfg.drop_id)

	table.insert(self._awards, 1, {
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_NEW_SLG_CONTRIBUTION,
		size = self._bossCfg.contribution_4,
		max_size = self._bossCfg.contribution_1
	})
	table.insertto(self._awards, {})

	for iter_5_0, iter_5_1 in ipairs(self._awards) do
		var_0_0:getAndUpdateItemNumAfterAddition(iter_5_1, false, g.core.const.ConstMgr.NewSlgConst.ATTR_MODULE.BOSS)

		iter_5_1.sizePlus = not (iter_5_1.type == g.core.common.Goods.TYPE_RESOURCE and iter_5_1.value == g.core.common.Goods.RESOURCE.TYPE_NEW_SLG_CONTRIBUTION)
	end

	self._listAward:setNumItems(#self._awards)
end

function NewSlgBossInfoComp:_updateBtn()
	if not self._path then
		self._txtDesc:setVisible(true)
		self._txtDesc:setText(g.core.lang:get(428906))

		return
	end

	if var_0_0:getBossChallengedLevel() >= self._bossCfg.level - 1 then
		local var_6_0, var_6_1 = var_0_0:getBossChallengeTime()
		local var_6_2 = g.core.lang:get(428977, {
			num1 = var_6_0,
			num2 = var_6_1
		})

		if g.core.model.User.bagData:getOwnNum(g.core.const.ConstMgr.BAG_TYPE.ITEM, g.core.common.Goods.ITEM.TYPE_NEWSLG_BOSS_TIME) > 0 then
			-- block empty
		end

		self._txtDesc:setVisible(false)
		self.m_colorController:setSelectedIndex(0)
	else
		self.m_colorController:setSelectedIndex(1)
		self._txtDesc:setVisible(true)
		self._txtDesc:setText(g.core.lang:get(428905, {
			level = self._bossCfg.level - 1
		}))
	end
end

function NewSlgBossInfoComp:_onClickBtnCheckDefenderInfo()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_PVC_DEFENDER_POP, {
		type = g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.BOSS,
		id = self._bossCfg.id
	})
end

function NewSlgBossInfoComp:_onClickBtnGather()
	local var_8_0, var_8_1 = g.core.model.User.newSlgData:getBossChallengeTime()

	if var_8_0 == 0 then
		if g.core.model.User.bagData:getOwnNum(g.core.const.ConstMgr.BAG_TYPE.ITEM, g.core.common.Goods.ITEM.TYPE_NEWSLG_BOSS_TIME) > 0 then
			require("app.view.common.UsePop").createPlayNumItemUse(g.core.common.Goods.ITEM.TYPE_NEWSLG_BOSS_TIME, handler(self, self._updateBtn))

			return
		end
	end

	self:dispatchCompEvent("NewSlgMainLayer_hideAllUI")
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_BOSS_TEAM_LIST_POP, {
		bossId = self._bossCfg.id,
		path = self._path
	})
end

function NewSlgBossInfoComp:_onRenderListAwardCell(arg_9_1, arg_9_2)
	local var_9_0 = self._awards[arg_9_1 + 1]

	if self._awards[arg_9_1 + 1].type == g.core.common.Goods.TYPE_RESOURCE and var_9_0.value == g.core.common.Goods.RESOURCE.TYPE_NEW_SLG_CONTRIBUTION then
		arg_9_2:setCtrlState("is_spe", {
			index = 1
		})
	else
		arg_9_2:setCtrlState("is_spe", {
			index = 0
		})
	end

	arg_9_2:getChild("Comp_icon"):updateIcon(var_9_0)
end

return NewSlgBossInfoComp

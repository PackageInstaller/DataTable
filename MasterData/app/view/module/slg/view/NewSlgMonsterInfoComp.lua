local NewSlgMonsterInfoComp = class("NewSlgMonsterInfoComp", require("app.fairyGUI.newSlg.UI_NewSlgMonsterInfoComp"))
local var_0_1 = g.core.model.User.newSlgData
local var_0_2 = g.core.const.ConstMgr.NewSlgConst

function NewSlgMonsterInfoComp:ctor()
	self._data = nil
	self._list = {}
	self._listIcon = self:getChild("List_icon")

	self._listIcon:setVirtual(self)
	self._listIcon:setItemRenderer(handler(self, self._onRenderListCell))

	self._compBannerInfo = self:getChild("Comp_bannerInfo")
	self._fightBtn = self:getChild("Btn_fight")

	self._fightBtn:addClickListener(handler(self, self._onClickFight))

	self._searchBtn = self:getChild("btnSearch")

	self._searchBtn:addClickListener(handler(self, self._onClickSearch))

	self._progressBar = self:getChild("Comp_pro")
	self._monsterName = self:getChild("Txt_name")
	self._level = self:getChild("Txt_level")
	self._authority = self:getChild("Txt_authority")
	self._power = self:getChild("Txt_power")
	self._tips = self:getChild("Txt_tips")
	self._times = self:getChild("Txt_times")
	self._stateCtl = self:getController("c1")
	self._armyType = self:getChild("Loader_type")
	self._compArmyIcon = self:getChild("Comp_armyIcon")
	self._isEnough = false
	self._isSameProvince = false
	self._levelLimit = false
	self._send = false
	self._isAddVisible = false
	self._buffArr = {}
	self._compAddition = self:getChild("Comp_addition")

	self._compAddition:addClickListener(handler(self, self._onCompAdditionClick))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
end

function NewSlgMonsterInfoComp:_onTouchBegin(arg_2_1)
	local var_2_0 = arg_2_1:getInput():getTouch():getLocation()
end

function NewSlgMonsterInfoComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETMONSTERINFO, handler(self, self._onRcvMonsterInfo), self)

	if var_0_1:getSName() == "S1" then
		self:_updatePrivilege()
	end
end

function NewSlgMonsterInfoComp:_getDropsItem()
	local var_4_0 = g.core.common.Drops:getGoodsArray(self._monsterCfg.drop_common_value_1)

	table.insert(var_4_0, 1, {
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_NEW_SLG_CONTRIBUTION,
		size = self._monsterCfg.contribution
	})

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		var_0_1:getAndUpdateItemNumAfterAddition(iter_4_1, true, var_0_2.ATTR_MODULE.MONSTER)

		iter_4_1.sizePlus = not (iter_4_1.type == g.core.common.Goods.TYPE_RESOURCE and iter_4_1.value == g.core.common.Goods.RESOURCE.TYPE_NEW_SLG_CONTRIBUTION)
	end

	return var_4_0
end

function NewSlgMonsterInfoComp:_updateBaseInfo()
	self._monsterName:setText(self._monsterCfg.name)
	self._level:setText(g.core.lang:get(428987, {
		level = self._monsterCfg.level
	}))

	self._list = self:_getDropsItem()

	self._listIcon:setNumItems(#self._list)
	self._compArmyIcon:updateView({
		armyType = self._monsterCfg.army_type
	})
	self._authority:setText(self._monsterCfg.authority)
end

function NewSlgMonsterInfoComp:updateView(arg_6_1)
	if not arg_6_1 then
		return
	end

	self.m_additionComp:setVisible(false)

	self._isAddVisible = false
	self._data = arg_6_1
	self._monsterCfg = var_0_1:getMonsterInfoByGID(arg_6_1.monster.objectData.gid)

	local var_6_0 = var_0_1:getProvinceCfgByGID((var_0_1:getProvinceGIdByRC(arg_6_1.monster.pos.x, arg_6_1.monster.pos.y)))

	if var_6_0 then
		self._compAddition:updateView({
			pid = var_6_0.id
		})
	end

	self:_updateBaseInfo()
	self._tips:setText("")
	self:_updateFightTimes()
	self._compBannerInfo:updateView({
		scale = 0.8,
		bannerType = g.core.const.ConstMgr.NewSlgConst.SLGBannerType.MONSTER,
		res = "#" .. g.core.common.Path:getNewSlgMonster(self._monsterCfg.res .. "_00")
	})

	self._send = false
	self._isSameProvince = var_0_1:isMonsterCanChallengeBySameProvinceGID((var_0_1:getProvinceGIdByRC(arg_6_1.monster.pos.x, arg_6_1.monster.pos.y)))

	if self._isSameProvince then
		self._monsterSerData = var_0_1:getMonsterDataByRC(arg_6_1.monster.pos.x, arg_6_1.monster.pos.y)

		local var_6_1 = g.core.common.ServerTime:getTime()

		if not self._monsterSerData then
			self:_sendMonsterInfo()
		elseif var_6_1 > self._monsterSerData.initTime + var_0_1:getNewSlgParamsValueByKey("parameter_13") then
			self:_sendMonsterInfo()
		elseif var_6_1 < self._monsterSerData.reviveTime then
			self:_updateMonster()
		else
			self:_sendMonsterInfo()
		end
	else
		self:_sendMonsterInfo()
	end

	self:getTransition("enter"):play()
end

function NewSlgMonsterInfoComp:_sendMonsterInfo()
	if self._send then
		return
	end

	g.core.network.GameNetProxy:send_C2S_NewSlg_GetMonsterInfo({
		target_pos = self._data.monster.pos,
		monster_id = self._monsterCfg.id
	})
end

function NewSlgMonsterInfoComp:_updateMonster()
	local var_8_0, var_8_1

	if self._monsterSerData then
		var_8_0 = self._monsterSerData.maxTroops or self._monsterCfg.troops

		if self._monsterSerData then
			var_8_1 = self._monsterSerData.troops or var_8_0
		end
	end

	self._power:setText(var_8_1 .. "/" .. var_8_0)
	self._progressBar:setMax(var_8_0)
	self._progressBar:setValue(var_8_1)

	self._levelLimit = false

	if not self._isSameProvince then
		self._tips:setText(g.core.lang:get(428809))
		self._stateCtl:setSelectedIndex(1)
	elseif self._monsterCfg.level > var_0_1:getMaxMonsterLv() + 1 then
		self._levelLimit = true

		self._stateCtl:setSelectedIndex(1)
		self._tips:setText(g.core.lang:get(428810, {
			level = var_0_1:getMaxMonsterLv() + 1
		}))
	elseif var_8_1 <= 0 and self._monsterSerData.reviveTime > g.core.common.ServerTime:getTime() then
		self._stateCtl:setSelectedIndex(2)
		self:newSchedule(handler(self, self._updateReviveTime), 1)
		self:_updateReviveTime()
	else
		self._stateCtl:setSelectedIndex(0)
	end
end

function NewSlgMonsterInfoComp:_updateFightTimes()
	local var_9_0 = var_0_1:getLeftMonsterFightCount()

	self._fightBtn:updateCost(g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_ITEM,
		value = var_0_2.MONSTER_COST_ID
	}), self._monsterCfg.order_power_cost, var_9_0)

	self._isEnough = var_9_0 >= self._monsterCfg.order_power_cost
end

function NewSlgMonsterInfoComp:_onRenderListCell(arg_10_1, arg_10_2)
	arg_10_2:updateIcon(self._list[arg_10_1 + 1])
end

function NewSlgMonsterInfoComp:_updateReviveTime()
	if self._monsterSerData then
		local var_11_0 = self._monsterSerData.reviveTime - g.core.common.ServerTime:getTime() or 0

		if var_11_0 > 0 then
			self._times:setText(g.core.lang:get(428811, {
				time = g.core.common.ServerTime:secondToHMSString(var_11_0)
			}))

			goto label_11_0
		end
	end

	self:cancelSchedule(self._updateReviveTime)
	self:_sendMonsterInfo()

	::label_11_0::
end

function NewSlgMonsterInfoComp:_onClickSearch()
	local var_12_0 = var_0_1:searchCanChallengeMonster(self._monsterCfg.army_type)

	if var_12_0 then
		self:dispatchCompEvent("NewSlg_jumpToPos", {
			pos = var_12_0
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(428812))
	end
end

function NewSlgMonsterInfoComp:_onClickFight()
	self:setVisible(false)

	if self._isEnough then
		if not self._levelLimit then
			g.core.module.ModuleManager:pushPopup((require("app.view.module.slg.view.team.NewSlgTeamSelectPop").new({
				buildType = g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.MONSTER,
				info = self._monsterCfg,
				x = self._data.monster.pos.x,
				y = self._data.monster.pos.y,
				path = g.core.model.User.newSlgData:getPath(nil, self._data.monster.pos)
			})))
		else
			local var_13_0 = var_0_1:searchCanChallengeMonster(self._monsterCfg.army_type)

			if var_13_0 then
				self:dispatchCompEvent("NewSlg_jumpToPos", {
					pos = var_13_0
				})
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(428812))
			end
		end
	else
		local var_13_1 = {}

		var_13_1.name = g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_ITEM,
			value = var_0_2.MONSTER_COST_ID
		}).info.name

		g.core.module.ModuleManager:tip(g.core.lang:get(428998, var_13_1))
	end
end

function NewSlgMonsterInfoComp:_updatePrivilege()
	return
end

function NewSlgMonsterInfoComp:_onRcvMonsterInfo(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	self._send = true
	self._monsterSerData = var_0_1:genMonsterData(arg_15_4)

	self:_updateMonster()
end

function NewSlgMonsterInfoComp:_onCompAdditionClick()
	local var_16_0 = self._compAddition:getAllAddArr()

	if #var_16_0 == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(429622))

		return
	end

	self._isAddVisible = not self._isAddVisible

	if self._isAddVisible then
		self:_setSafeShowPos()
	end

	self.m_additionComp:setVisible(self._isAddVisible)
	self.m_additionComp:updateView({
		notCity = true,
		addArr = var_16_0
	})
end

function NewSlgMonsterInfoComp:_setSafeShowPos()
	if self:localToGlobal(cc.p(0, 0)).x > display.cx then
		self.m_additionComp:setX(-self.m_additionComp:getWidth())
	else
		self.m_additionComp:setX(self:getWidth())
	end
end

return NewSlgMonsterInfoComp

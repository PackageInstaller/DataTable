local NewSlgMonsterSearchComp = class("NewSlgMonsterSearchComp")
local var_0_1 = g.core.model.User.newSlgData
local var_0_2 = g.core.const.ConstMgr.NewSlgConst

function NewSlgMonsterSearchComp:ctor()
	self._curLevel = 1
	self._maxLevel = 1
	self._closeComp = self:getChild("closeComp")

	self._closeComp:addClickListener(handler(self, self._onClickClose))

	self._iconList = self:getChild("List_icon")

	self._iconList:setVirtual(self)
	self._iconList:setItemRenderer(handler(self, self._onRenderListCell))
	self._iconList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickItem))

	self._txtName = self:getChild("Txt_name")
	self._txtLimit = self:getChild("Txt_limit")
	self._slider = self:getChild("Comp_slider")
	self._notThisAreaGroup = self:getChild("notThisAreaGroup")
	self._txtValue = self._slider:getChild("value")

	self._slider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSliderChanged))
	self:getChild("Btn_add"):addClickListener(handler(self, self._onClickAdd))
	self:getChild("Btn_sub"):addClickListener(handler(self, self._onClickSub))
	self._notThisAreaGroup:setVisible(false)

	self._btnSearch = self:getChild("Btn_search")

	self._btnSearch:addClickListener(handler(self, self._onClickSearch))
end

function NewSlgMonsterSearchComp:_initData(arg_2_1)
	self._selectIdx = arg_2_1.index or 1

	local var_2_0 = arg_2_1.level or 0
	local var_2_1 = {}
	local var_2_2 = 1

	for iter_2_0 = 1, 2 do
		for iter_2_1 = 1, 3 do
			local var_2_3 = var_0_1:loadCacheWithActId("search_monster_" .. iter_2_0 .. "_" .. iter_2_1)

			var_2_1[#var_2_1 + 1] = {
				monsterType = iter_2_0,
				armyType = iter_2_1,
				level = var_2_0 > 0 and var_2_0 or var_2_3 > 0 and var_2_3 or 1
			}

			if var_2_2 == self._selectIdx then
				self._curLevel = var_2_0 > 0 and var_2_0 or var_2_3 > 0 and var_2_3 or 1
			end

			var_2_2 = var_2_2 + 1
		end
	end

	if g.core.model.User.newSlgData:getSName() == "S2" then
		local var_2_4 = var_0_1:loadCacheWithActId("search_monster_4_1")

		var_2_1[#var_2_1 + 1] = {
			armyType = 1,
			monsterType = 4,
			level = var_2_0 > 0 and var_2_0 or var_2_4 > 0 and var_2_4 or 1
		}
	end

	self._monsterList = var_2_1

	self._iconList:setNumItems(#self._monsterList)
	self._iconList:addSelection(self._selectIdx - 1, true)
end

function NewSlgMonsterSearchComp:_onRenderListCell(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._monsterList[arg_3_1 + 1], arg_3_1)
end

function NewSlgMonsterSearchComp:updateView(arg_4_1)
	self:_initData(arg_4_1)
	self:_setMaxLevel()
	self:_updateLvInfo()
end

function NewSlgMonsterSearchComp:_setMaxLevel()
	if self._monsterList[self._selectIdx].monsterType == var_0_2.MONSTER_TYPE.MONSTER then
		self._maxLevel = var_0_1:getMonsterMaxLevel()
	elseif self._monsterList[self._selectIdx].monsterType == var_0_2.MONSTER_TYPE.BOSS then
		self._maxLevel = var_0_1:getBossMaxLevel()
	elseif self._monsterList[self._selectIdx].monsterType == var_0_2.MONSTER_TYPE.FARM then
		self._maxLevel = var_0_1:getFarmMaxLevel()
	end

	self._slider:setMax(self._maxLevel - 1)
end

function NewSlgMonsterSearchComp:_updateLvInfo()
	self._slider:setValue(self._curLevel - 1)

	local var_6_0 = self._monsterList[self._selectIdx]

	var_6_0.level = self._curLevel

	local var_6_1 = var_0_1:getCanChallengeProvinceGIDArr(nil, true)
	local var_6_2 = false
	local var_6_3

	if var_6_0.monsterType == var_0_2.MONSTER_TYPE.MONSTER then
		local var_6_4 = var_0_1:getSearchMonsterMulti(var_6_1, self._curLevel, var_6_0.armyType)

		if #var_6_4 > 0 then
			local var_6_5 = var_6_4[1] or nil

			if not var_6_5 then
				local var_6_6 = var_0_1:getSearchMonster2(self._curLevel, var_6_0.armyType)

				var_6_5 = #var_6_6 > 0 and var_6_6[1] or nil
				var_6_2 = true
			end

			if var_6_5 then
				var_6_3 = var_0_1:getMonsterInfoByGID((var_0_1:getMonsterGIDByRC(var_6_5.x, var_6_5.y)))
			end
		end

		self._txtLimit:setText(g.core.lang:get(428814, {
			level = math.min(self._maxLevel, var_0_1:getMaxMonsterLv() + 1)
		}))
	elseif var_6_0.monsterType == var_0_2.MONSTER_TYPE.BOSS then
		local var_6_7 = var_0_1:getSearchTeamBossMulti(var_6_1, self._curLevel, var_6_0.armyType)

		if #var_6_7 > 0 then
			local var_6_8 = var_6_7[1] or nil

			if not var_6_8 then
				local var_6_9 = var_0_1:getSearchTeamBoss2(self._curLevel, var_6_0.armyType)

				var_6_8 = #var_6_9 > 0 and var_6_9[1] or nil
				var_6_2 = true
			end

			if var_6_8 then
				local var_6_10 = var_0_1:getComponentsByGID((var_0_1:getBarrierGIDByRC(var_6_8.x, var_6_8.y)))

				if var_6_10[1] then
					var_6_3 = var_0_1:getBossInfoById(var_6_10[1].value)
				end
			end
		end

		self._txtLimit:setText(g.core.lang:get(428815, {
			level = math.min(self._maxLevel, var_0_1:getBossChallengedLevel() + 1)
		}))
	elseif var_6_0.monsterType == var_0_2.MONSTER_TYPE.FARM then
		self._txtLimit:setText("")

		var_6_3 = var_0_1:searchFarmNearestByLevel(self._curLevel).baseCfg
	end

	if var_6_3 then
		self._txtName:setText(g.core.lang:get(428989, {
			level = var_6_3.level,
			troop_type = var_6_3.name
		}))
		self._notThisAreaGroup:setVisible(var_6_2)
	else
		self._txtName:setText("")
	end
end

function NewSlgMonsterSearchComp:_updateSelectItem()
	local var_7_0 = self._iconList:getSelectedIndex() + 1

	self._monsterList[var_7_0].level = self._curLevel

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NEW_SLG_MONSTER_LEVEL_CHANGE, false, {
		index = var_7_0 - 1,
		data = self._monsterList[var_7_0]
	})
end

function NewSlgMonsterSearchComp:_onSliderChanged()
	self._curLevel = math.floor(self._slider:getValue()) + 1

	self:_updateLvInfo()
	self:_updateSelectItem()
end

function NewSlgMonsterSearchComp:_onClickItem(arg_9_1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_ShuJu)

	local var_9_0 = arg_9_1:getDataValue()

	self._iconList:addSelection(var_9_0, false)

	self._selectIdx = var_9_0 + 1
	self._curLevel = self._monsterList[self._selectIdx].level

	self:_setMaxLevel()
	self:_updateLvInfo()
end

function NewSlgMonsterSearchComp:_onClickAdd()
	self._curLevel = self._curLevel + 1
	self._curLevel = math.min(self._curLevel, self._maxLevel)

	self:_updateLvInfo()
	self:_updateSelectItem()
end

function NewSlgMonsterSearchComp:_onClickSub()
	self._curLevel = self._curLevel - 1
	self._curLevel = math.max(self._curLevel, 1)

	self:_updateLvInfo()
	self:_updateSelectItem()
end

function NewSlgMonsterSearchComp:_onClickSearch()
	if self._monsterList[self._selectIdx].monsterType == var_0_2.MONSTER_TYPE.MONSTER then
		self:_searchMonster()
	elseif self._monsterList[self._selectIdx].monsterType == var_0_2.MONSTER_TYPE.BOSS then
		self:_searchBoss()
	elseif self._monsterList[self._selectIdx].monsterType == var_0_2.MONSTER_TYPE.FARM then
		self:_searchFarm()
	end
end

function NewSlgMonsterSearchComp:_searchMonster()
	local var_13_0 = var_0_1:searchCanChallengeMonster(self._monsterList[self._selectIdx].armyType, self._curLevel)

	if var_13_0 then
		self:dispatchCompEvent("NewSlg_jumpToPos", {
			pos = var_13_0
		})
		self:setVisible(false)
		var_0_1:saveCacheWithActId("search_monster_" .. self._monsterList[self._selectIdx].monsterType .. "_" .. self._monsterList[self._selectIdx].armyType, self._curLevel)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(428812))
	end
end

function NewSlgMonsterSearchComp:_searchBoss()
	local var_14_0 = var_0_1:searchCanChallengeBoss(self._monsterList[self._selectIdx].armyType, self._curLevel)

	if var_14_0 then
		self:dispatchCompEvent("NewSlg_jumpToPos", {
			pos = var_14_0
		})
		self:setVisible(false)
		var_0_1:saveCacheWithActId("search_monster_" .. self._monsterList[self._selectIdx].monsterType .. "_" .. self._monsterList[self._selectIdx].armyType, self._curLevel)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(428812))
	end
end

function NewSlgMonsterSearchComp:_searchFarm()
	local var_15_0 = var_0_1:searchFarmNearestByLevel(self._curLevel)
	local var_15_1 = cc.p(var_15_0.compCfg.anchor_x, var_15_0.compCfg.anchor_y)

	if var_15_1 then
		self:dispatchCompEvent("NewSlg_jumpToPos", {
			pos = var_15_1
		})
		self:setVisible(false)
		var_0_1:saveCacheWithActId("search_monster_" .. self._monsterList[self._selectIdx].monsterType .. "_" .. self._monsterList[self._selectIdx].armyType, self._curLevel)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(428812))
	end
end

function NewSlgMonsterSearchComp:_onClickClose()
	self:dispatchCompEvent("NewSlg_Touch_Close_ui")
end

return NewSlgMonsterSearchComp

local NewSlgMonsterSearchItem = class("NewSlgMonsterSearchItem", require("app.fairyGUI.newSlg.UI_NewSlgMonsterSearchItem"))
local var_0_1 = g.core.const.ConstMgr.NewSlgConst
local var_0_2 = g.core.model.User.newSlgData

function NewSlgMonsterSearchItem:ctor()
	self._iconHolder = self:getChild("imgHolder")
	self._name = self:getChild("Txt_name")
end

function NewSlgMonsterSearchItem:updateCell(arg_2_1, arg_2_2)
	self._data = arg_2_1 or {}
	self._index = arg_2_2 or self._index

	if arg_2_1.monsterType == var_0_1.MONSTER_TYPE.MONSTER then
		self:_updateMonster()
		self.m_teamTag:setVisible(false)
	elseif arg_2_1.monsterType == var_0_1.MONSTER_TYPE.BOSS then
		self:_updateBoss()
		self.m_teamTag:setVisible(true)
	elseif arg_2_1.monsterType == var_0_1.MONSTER_TYPE.FARM then
		self:_updateFarm()
	end
end

function NewSlgMonsterSearchItem:_onItemSelect(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.index == self._index then
		self:updateCell(arg_3_3.data)
	end
end

function NewSlgMonsterSearchItem:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NEW_SLG_MONSTER_LEVEL_CHANGE, handler(self, self._onItemSelect), self)
end

function NewSlgMonsterSearchItem:_updateMonster()
	local var_5_0 = var_0_2:getSearchMonster1(self._data.level, self._data.armyType)

	if #var_5_0 == 0 then
		var_5_0 = var_0_2:getSearchMonster2(self._data.level, self._data.armyType)
	end

	if #var_5_0 > 0 then
		local var_5_1 = var_0_2:getMonsterInfoByGID((var_0_2:getMonsterGIDByRC(var_5_0[1].x, var_5_0[1].y)))

		if var_5_1 then
			self.m_rewardIcon:setURL(g.core.common.Goods:convert({
				type = g.core.common.Goods.TYPE_ITEM,
				value = var_5_1.output
			}).icon_mini)
			self._name:setText(var_5_1.name)
			self:_updateRes(var_5_1.res .. "_00")
		end
	end
end

function NewSlgMonsterSearchItem:_updateBoss()
	local var_6_0 = var_0_2:getSearchTeamBoss1(self._data.level, self._data.armyType)

	if #var_6_0 == 0 then
		var_6_0 = var_0_2:getSearchTeamBoss2(self._data.level, self._data.armyType)
	end

	if #var_6_0 > 0 then
		local var_6_1 = var_0_2:getComponentsByGID((var_0_2:getBarrierGIDByRC(var_6_0[1].x, var_6_0[1].y)))

		if var_6_1[1] then
			local var_6_2 = var_0_2:getBossInfoById(var_6_1[1].value)

			self.m_rewardIcon:setURL(g.core.common.Goods:convert({
				type = g.core.common.Goods.TYPE_ITEM,
				value = var_6_2.output
			}).icon_mini)
			self._name:setText(var_6_2.name)
			self:_updateRes(var_6_1[1].res_1)
		end
	end
end

function NewSlgMonsterSearchItem:_updateFarm()
	local var_7_0 = var_0_2:searchFarmNearestByLevel(self._data.level)

	self.m_rewardIcon:setURL(g.core.common.Goods:convert({
		value = 60001,
		type = g.core.common.Goods.TYPE_ITEM
	}).icon_mini)
	self._name:setText(var_7_0.baseCfg.name)

	if self._iconImage then
		self._iconImage:removeFromParent()
	end

	self._iconImage = display.newSprite("#gengdi_0" .. var_7_0.baseCfg.res .. ".png")

	local var_7_1 = self._iconImage:getContentSize()

	self._iconImage:setAnchorPoint(0.5, 0.5)
	self._iconImage:setScale(var_7_1.width > 106 and 0.6 or 0.8)
	self._iconHolder:addNode(self._iconImage)
end

function NewSlgMonsterSearchItem:_updateRes(arg_8_1)
	if self._iconImage then
		self._iconImage:removeFromParent()
	end

	self._iconImage = display.newSprite("#" .. g.core.common.Path:getNewSlgMonster(arg_8_1))

	local var_8_0 = self._iconImage:getContentSize()

	self._iconImage:setAnchorPoint(0.5, 0.5)
	self._iconImage:setScale(var_8_0.width > 106 and 0.6 or 0.8)
	self._iconHolder:addNode(self._iconImage)
end

return NewSlgMonsterSearchItem

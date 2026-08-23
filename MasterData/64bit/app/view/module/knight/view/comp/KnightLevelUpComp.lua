local KnightLevelUpComp = class("KnightLevelUpComp", require("app.fairyGUI.knight.UI_KnightLevelUpComp"))
local var_0_1 = g.core.config.knight_level_info
local var_0_2 = g.core.model.User.itemsData
local var_0_3 = g.core.common.Goods.TYPE_ITEM
local var_0_5 = g.core.network.GameNetProxy

function KnightLevelUpComp:ctor()
	self._expItemData = {}
	self._isOverExp = false
	self._noProp = true
	self._upLevels = 0
	self._MAX_UP_LEVEL = 10

	self:_initList()
	self:_addListener()
end

function KnightLevelUpComp:_initList()
	self.m_propList:setVirtual()
	self.m_propList:setItemRenderer(handler(self, self._onPropRenderer))
end

function KnightLevelUpComp:_addListener()
	self.m_levelUpBtn:addClickListener(handler(self, self._onLevelUpBtnClick))
end

function KnightLevelUpComp:updateView(arg_4_1)
	local var_4_0

	if arg_4_1 then
		var_4_0 = arg_4_1.knight
		self._knight = arg_4_1.knight
		self._knightSid = var_4_0:getServerId()
	else
		var_4_0 = self._knight
	end

	if var_4_0 == nil then
		return
	end

	local var_4_1 = var_0_1.get(var_4_0:getBaseInfo().level_exp_id, var_4_0:getInfo().level)
	local var_4_2 = var_4_0:getLevel()

	self._expItemData = {}

	local var_4_3 = var_0_2:getExpItemData()

	for iter_4_0, iter_4_1 in ipairs(var_4_3) do
		table.insert(self._expItemData, {
			hideNum = false,
			type = var_0_3,
			value = iter_4_1.id,
			size = iter_4_1.num
		})
	end

	local var_4_4 = var_4_0:getCurMaxLevel()

	self._upLevels = var_4_4 - var_4_2
	self._isOverExp = var_4_2 == var_4_4
	self._noProp = true

	for iter_4_2, iter_4_3 in ipairs(var_4_3) do
		if iter_4_3.num > 0 then
			self._noProp = false

			break
		end
	end

	self.m_addNumComp:initMinMaxNum({
		cur = self._upLevels,
		max = self._upLevels
	})
	self.m_maxLevelUpText:setText(g.core.lang:get(201016, {
		max = self._upLevels
	}))
	self.m_propList:setNumItems(#self._expItemData)
end

function KnightLevelUpComp:_onPropRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._expItemData[arg_5_1 + 1])
end

function KnightLevelUpComp:_onLevelUpBtnClick()
	if self:_canLiveUp() and self._upLevels > 0 then
		var_0_5:send_C2S_Knight_OneKey_Upgrade({
			id = self._knightSid,
			level = self.m_addNumComp:getCurNum()
		})
	end
end

function KnightLevelUpComp:onLoad()
	self:playEnter()
end

function KnightLevelUpComp:playEnter()
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.LEVEL_SHOW_OPEN)
end

function KnightLevelUpComp:_canLiveUp()
	if self._isOverExp then
		g.core.module.ModuleManager:tip(g.core.lang:get(201007))

		return false
	end

	if self._noProp then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			size = 1,
			type = var_0_3,
			value = self._expItemData[1].value
		})

		return false
	end

	return true
end

return KnightLevelUpComp

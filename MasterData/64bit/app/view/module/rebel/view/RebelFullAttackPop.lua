local var_0_0 = g.core.model.User
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.model.User.rebelData
local RebelFullAttackPop = class("RebelFullAttackPop", require("app.fairyGUI.rebel.UI_RebelFullAttackPop"), function()
	return fgui.GComponent:create({
		resName = "RebelFullAttackPop",
		pkgName = "rebel",
		pkgPath = "ui/rebel/rebel"
	})
end)

function RebelFullAttackPop:ctor(arg_2_1)
	self:showAtCenter()

	self._attackNum = 0
	self._numToken = 0
	self._curTimes = 0
	self._rebelElemArr = nil
	self._curSelectBoss = 1

	self:initFullAttack()
end

function RebelFullAttackPop:onLoad()
	if var_0_2:isHotTime() then
		self.m_useNumComp:setCurNum(1)
	else
		self.m_useNumComp:setCurNum(2)
	end

	self.m_bossList:setNumItems(#self._rebelElemArr)
	self.m_bossList:setSelectedIndex(self._curSelectBoss - 1)
end

function RebelFullAttackPop:initFullAttack()
	self:_initFullAttackData()
	self:_initFullAttackUI()
end

function RebelFullAttackPop:_initFullAttackData()
	self._attackNum = var_0_0.resourceData:getRebelAttack()
	self._numToken = var_0_0.bagData:getOwnNum(var_0_1.TYPE_ITEM, var_0_1.ITEM.TYPE_REBEL_TOKEN)

	local var_5_0, var_5_1 = var_0_2:getRebelDefault()

	self._rebelElemArr = {}

	if var_5_0:isInValidTime() then
		table.insert(self._rebelElemArr, var_5_0)
	end

	if var_5_1:isInValidTime() then
		table.insert(self._rebelElemArr, var_5_1)
	end

	for iter_5_0, iter_5_1 in ipairs((var_0_2:getRebelArr())) do
		if iter_5_0 > 5 then
			break
		end

		table.insert(self._rebelElemArr, iter_5_1)
	end
end

function RebelFullAttackPop:_initFullAttackUI()
	self.m_useNumComp:initMinMaxNum({
		max = self:_getMaxTimes(),
		callback = handler(self, self._onSelectTimesChange)
	})
	self.m_itemAutoBtn:addEventListener(fgui.UIEventType.Changed, handler(self, self._onOptItemAutoChange))
	self.m_comAtkBtn:addClickListener(handler(self, self._onStartComAttackClick))
	self.m_twoAtkBtn:addClickListener(handler(self, self._onStartTwoAttackClick))
	self.m_bossList:setVirtual()
	self.m_bossList:setItemRenderer(handler(self, self._onRenderBossList))
	self.m_bossList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onBossHeadSelected))
end

function RebelFullAttackPop:_onRenderBossList(arg_7_1, arg_7_2)
	arg_7_2:refreshRebelBossHead(self._rebelElemArr[arg_7_1 + 1])
end

function RebelFullAttackPop:_onBossHeadSelected(arg_8_1, arg_8_2)
	self._curSelectBoss = arg_8_1:getDataValue() + 1
end

function RebelFullAttackPop:_setCurSelectTimes(arg_9_1)
	self._curTimes = arg_9_1

	self:_refreshTimesView()
end

function RebelFullAttackPop:_refreshTimesView()
	local var_10_0 = {
		size = 0,
		type = var_0_1.TYPE_ITEM,
		value = var_0_1.ITEM.TYPE_REBEL_TOKEN
	}

	if self.m_itemAutoBtn:isSelected() then
		if self._curTimes > self._attackNum then
			var_10_0.size = self._curTimes - self._attackNum
		end
	end

	self.m_itemNumComp:updateByTVS(var_10_0)
end

function RebelFullAttackPop:_getMaxTimes()
	local var_11_0 = self._attackNum

	if self.m_itemAutoBtn:isSelected() then
		var_11_0 = self._attackNum + self._numToken

		if self._attackNum + self._numToken > 100 then
			var_11_0 = 100
		end
	end

	return var_11_0
end

function RebelFullAttackPop:_onSelectTimesChange()
	self:_setCurSelectTimes((self.m_useNumComp:getCurNum()))
end

function RebelFullAttackPop:_onOptItemAutoChange()
	self.m_useNumComp:setMaxNum(self:_getMaxTimes())
	self.m_useNumComp:setCurNum((self.m_useNumComp:getCurNum()))
end

function RebelFullAttackPop:_onStartComAttackClick()
	if self._curTimes <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(303517))

		return
	end

	local var_14_0 = {
		atkRebel = self._rebelElemArr[self._curSelectBoss],
		atkCount = self._curTimes,
		isUseItem = self.m_itemAutoBtn:isSelected()
	}

	var_14_0.atkType = 1

	g.core.module.ModuleManager:popComponent()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.rebel.view.RebelFullBlitzPop").new(var_14_0), {
		touchDisappear = true,
		hideContinue = true
	})
end

function RebelFullAttackPop:_onStartTwoAttackClick()
	if self._curTimes < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(303517))

		return
	elseif self._curTimes < 2 and not var_0_2:isHotTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(303517))

		return
	end

	local var_15_0 = {
		atkRebel = self._rebelElemArr[self._curSelectBoss],
		atkCount = self._curTimes,
		isUseItem = self.m_itemAutoBtn:isSelected()
	}

	var_15_0.atkType = 2

	g.core.module.ModuleManager:popComponent()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.rebel.view.RebelFullBlitzPop").new(var_15_0), {
		touchDisappear = true,
		hideContinue = true
	})
end

return RebelFullAttackPop

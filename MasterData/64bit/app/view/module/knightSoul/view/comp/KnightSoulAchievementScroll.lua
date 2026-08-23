local var_0_0 = g.core.config.ksoul_honor_info
local var_0_1 = g.core.model.User.knightSoulData
local KnightSoulConst = require("app.view.module.knightSoul.const.KnightSoulConst")
local KnightSoulAchievementScroll = class("KnightSoulAchievementScroll", require("app.fairyGUI.knightSoul.UI_KnightSoulAchievementScroll"))

function KnightSoulAchievementScroll:ctor()
	self._startPos = cc.p(100, 60)
	self._itemShowPos = {}
	self._itemPool = {}
	self._showList = {}
	self._showIndexMap = {}
	self._scrollPnl = self:getScrollPane()

	self:initPanel()

	local var_1_0 = var_0_1:getActivationHonorId()

	if self._itemShowPos[var_1_0 + 1] then
		self._selIndex = var_1_0 + 1 or var_1_0
	end

	self:checkShow()
	self._scrollPnl:setPosX(self._itemShowPos[self._selIndex].posX - KnightSoulConst.ACHIEVEMENT_SCROLL.WIDTH)
end

function KnightSoulAchievementScroll:onLoad()
	self:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onScroll))
end

function KnightSoulAchievementScroll:getItemFromPool()
	if next(self._itemPool) then
		local var_3_0 = table.remove(self._itemPool, 1)

		var_3_0:setVisible(true)

		return var_3_0
	end

	local var_3_1 = fgui.UIPackage:createObject("knightSoul", "KnightSoulAchievementCell")

	self:addChild(var_3_1)
	self:addListen(var_3_1)

	return var_3_1
end

function KnightSoulAchievementScroll:setSelectPoint(arg_4_1)
	self._selIndex = arg_4_1

	for iter_4_0, iter_4_1 in ipairs(self._showList) do
		iter_4_1:checkSelIndex(self._selIndex)
	end
end

function KnightSoulAchievementScroll:returnItemToPool(arg_5_1)
	arg_5_1:setVisible(false)
	table.insert(self._itemPool, arg_5_1)
end

function KnightSoulAchievementScroll:initPanel()
	local var_6_0 = 100
	local var_6_1 = var_0_1:getActivationHonorId()

	for iter_6_0, iter_6_1 in var_0_0.ipairs() do
		local var_6_2 = {
			index = iter_6_0,
			cfg = iter_6_1,
			posX = var_6_0,
			posY = self._startPos.y + (iter_6_0 % 2 == 1 and 0 or 114),
			isActive = var_6_1 >= iter_6_1.id
		}

		if iter_6_0 > 1 then
			local var_6_3 = var_0_0.indexOf(iter_6_0 - 1)

			var_6_0 = var_6_3.type == 1 and iter_6_1.type == 1 and var_6_0 + 176 or var_6_3.type == 1 and var_6_0 + 222 or var_6_3.type ~= 1 and iter_6_1.type ~= 1 and var_6_0 + 226 or var_6_0 + 196
			var_6_2.isBigLine = var_6_3.type ~= 1 or iter_6_1.type ~= 1
		else
			var_6_0 = iter_6_1.type == 1 and var_6_0 + 176 or var_6_0 + 196
		end

		if iter_6_1.type ~= 1 and iter_6_0 % 2 == 0 then
			var_6_2.posY = var_6_2.posY + 5
		end

		table.insert(self._itemShowPos, var_6_2)
	end

	self._itemShowPos[#self._itemShowPos].isLast = true

	self.m_graphHolder:setWidth(var_6_0 - 200)
end

function KnightSoulAchievementScroll:getCurSelPointData()
	return self._itemShowPos[self._selIndex]
end

function KnightSoulAchievementScroll:updateActiveSuccess(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self._itemShowPos) do
		if iter_8_1.cfg.id == arg_8_1.honor_id then
			iter_8_1.isActive = true
		end
	end

	for iter_8_2, iter_8_3 in ipairs(self._showList) do
		iter_8_3:updateActiveState()
	end
end

function KnightSoulAchievementScroll:checkShow()
	self._lastCheckPos = self._scrollPnl:getPosX()

	local var_9_0 = self._scrollPnl:getPosX() + KnightSoulConst.ACHIEVEMENT_SCROLL.WIDTH

	for iter_9_0 = #self._showList, 1, -1 do
		if math.abs(self._showList[iter_9_0]:getShowX() - var_9_0) > KnightSoulConst.ACHIEVEMENT_SCROLL.SHOW_VIEW then
			local var_9_1 = table.remove(self._showList, iter_9_0)

			self._showIndexMap[var_9_1:getShowIndex()] = nil

			self:returnItemToPool(var_9_1)
		end
	end

	for iter_9_1, iter_9_2 in ipairs(self._itemShowPos) do
		if math.abs(iter_9_2.posX - var_9_0) <= KnightSoulConst.ACHIEVEMENT_SCROLL.SHOW_VIEW and not self._showIndexMap[iter_9_2.index] then
			self._showIndexMap[iter_9_2.index] = true

			local var_9_2 = self:getItemFromPool()

			var_9_2:setShowData(iter_9_2)
			var_9_2:setPosition(iter_9_2.posX, iter_9_2.posY)
			var_9_2:checkSelIndex(self._selIndex)
			table.insert(self._showList, var_9_2)
		end
	end
end

function KnightSoulAchievementScroll:_onScroll()
	if math.abs(self._lastCheckPos - self._scrollPnl:getPosX()) > 20 then
		self:checkShow()
	end
end

return KnightSoulAchievementScroll

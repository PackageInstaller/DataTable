local var_0_0 = 25
local var_0_1 = 100
local var_0_2 = 5
local var_0_3 = g.core.const.ConstMgr.InfoConst.BlitzType
local var_0_4 = g.core.common.Goods
local BeginSweepPop = class("BeginSweepPop", require("app.fairyGUI.infoPop.UI_BeginSweepPop"), function()
	return fgui.GComponent:create({
		resName = "BeginSweepPop",
		pkgPath = "ui/infoPop/infoPop",
		pkgName = "infoPop"
	}, ...)
end)

function BeginSweepPop:ctor(arg_2_1)
	self:showAtCenter()

	self._goodInfo = arg_2_1.data or {}
	self._stageId = arg_2_1.stageId

	if arg_2_1 then
		self._acqData = arg_2_1.acqData or {}
	end

	self._blitzType = arg_2_1.type or var_0_3.DUNGEON
	self._tip = nil
	self._maxTargetNum = 0

	self:_init()
	self:_updateReward()
end

function BeginSweepPop:_init()
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRendererAsync1(handler(self, self._onListRenderer), 0.02, false)
	self.m_autoChooseController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onControlChangedEvent))
	self.m_beginBtn:addClickListener(handler(self, self._onClickBegin))

	if self.m_costIcon then
		self.m_costIcon:setURL((g.core.common.Path:getIconByTypeValue(var_0_4.TYPE_ITEM, var_0_4.ITEM.TYPE_STAMINA_PILL, true)))
	end
end

function BeginSweepPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DUNGEON_FASTCHALLENGESTAGE, self._updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_FASTEXECUTEMISSION, self._updateView, self)
	self:_updateView()
end

function BeginSweepPop:_updateReward()
	self.m_rewardList:setNumItems(#self._goodInfo)
end

function BeginSweepPop:_updateView()
	local var_6_0 = g.core.common.Goods
	local var_6_1

	if self._blitzType == var_0_3.DUNGEON then
		var_6_1 = g.core.config.dungeon_stage_info.get(self._stageId)

		if self._acqData.needNum and self._acqData.needNum > 0 then
			local var_6_2 = 0

			for iter_6_0, iter_6_1 in pairs((g.core.common.Drops:getGoodsArray(var_6_1.stage_drop))) do
				if iter_6_1.type == self._acqData.type and iter_6_1.value == self._acqData.value then
					var_6_2 = iter_6_1.size

					break
				end
			end

			self._maxTargetNum = math.ceil(self._acqData.needNum / var_6_2)
		end
	elseif self._blitzType == var_0_3.BIOGRAPHY then
		var_6_1 = g.core.model.User.bioData:getMission(self._stageId)
	end

	self._singelCost = var_6_1.cost

	local var_6_3 = g.core.model.User.resourceData:getVit()

	self._powerItemCount = g.core.model.User.bagData:getOwnNum(var_6_0.TYPE_ITEM, var_6_0.ITEM.TYPE_STAMINA_PILL)
	self._canSweepNum = math.floor((var_6_3 + self._powerItemCount * var_0_0) / self._singelCost)

	local var_6_4 = math.floor(var_6_3 / self._singelCost)
	local var_6_5 = math.min(self._canSweepNum, var_0_1)

	if self._blitzType == var_0_3.BIOGRAPHY then
		local var_6_7 = math.min(var_0_2, (math.min(g.core.model.User.resourceData:getBioGraphie(), (g.core.model.User.bioData:getMissionLeftCount(self._stageId)))))

		if var_6_7 < var_6_5 then
			self._canSweepNum = math.min(self._canSweepNum, var_6_7)
			var_6_5 = var_6_7
			var_6_4 = var_6_7
		end
	else
		var_6_4 = self._blitzType == var_0_3.DUNGEON and self._maxTargetNum > 0 and var_6_4 > self._maxTargetNum and self._maxTargetNum or var_6_4
	end

	self.m_itemNum:setText(self._powerItemCount)
	self.m_chooseNumComp:initMinMaxNum({
		min = 1,
		max = var_6_5,
		cur = var_6_4,
		callback = function(arg_7_0)
			if self._selectType == 1 then
				local var_7_0 = math.ceil((arg_7_0 * self._singelCost - var_6_3) / var_0_0)

				if var_7_0 > self._powerItemCount then
					var_7_0 = self._powerItemCount
				elseif var_7_0 <= 0 then
					var_7_0 = 0
				end

				self.m_itemNum:setText("(" .. var_7_0 .. "/" .. self._powerItemCount .. ")")
			end
		end,
		reachMaxAddTipGetFunc = function(arg_8_0)
			if self._blitzType == var_0_3.BIOGRAPHY and self.m_chooseNumComp:getMaxNum() <= arg_8_0 then
				return self:_getLockTip(arg_8_0)
			end
		end
	})
	self:_onControlChangedEvent()
end

function BeginSweepPop:_onControlChangedEvent()
	self._selectType = self.m_autoChooseController:getSelectedIndex() or 0

	local var_9_0 = self._powerItemCount
	local var_9_1 = g.core.model.User.resourceData:getBioGraphie()

	if self._selectType == 0 then
		local var_9_2 = math.min(self._canSweepNum, (math.min(math.floor(g.core.model.User.resourceData:getVit() / self._singelCost), var_0_1)))

		self.m_chooseNumComp:setMaxNum(var_9_2)

		if var_9_2 < self.m_chooseNumComp:getCurNum() then
			self.m_chooseNumComp:setCurNum(var_9_2)
		end
	else
		self.m_chooseNumComp:setMaxNum(math.min(self._canSweepNum, var_0_1))
	end

	self.m_itemNum:setText("(" .. "0" .. "/" .. var_9_0 .. ")")
end

function BeginSweepPop:_onListRenderer(arg_10_1, arg_10_2)
	self._goodInfo[arg_10_1 + 1].showInfo = true

	if self._goodInfo[arg_10_1 + 1].holiday_extra_type and self._goodInfo[arg_10_1 + 1].holiday_extra_type ~= 0 then
		self._goodInfo[arg_10_1 + 1].rightTxt = self._goodInfo[arg_10_1 + 1].mark
	end

	arg_10_2:updateIcon(self._goodInfo[arg_10_1 + 1])
end

function BeginSweepPop:_onClickBegin()
	local var_11_0 = self.m_chooseNumComp:getCurNum()

	if self._blitzType == var_0_3.BIOGRAPHY then
		if var_11_0 > 1 and not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.BIO_SWEEPING_10) then
			return
		end

		if g.core.model.User.resourceData:getBioGraphie() <= 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(302068))

			return
		end
	elseif self._blitzType == var_0_3.DUNGEON and g.core.model.User.resourceData:getVit() < self._singelCost then
		g.core.module.ModuleManager:tip(g.core.lang:get(300031))

		return
	end

	g.core.module.ModuleManager:popComponent()

	local BlitzDungeonResultPop = require("app.view.base.infoPop.BlitzDungeonResultPop")

	g.core.module.ModuleManager:pushPopup(((self._blitzType == var_0_3.BIOGRAPHY or nil) and require("app.view.base.infoPop.BlitzResultPop")).new({
		num = var_11_0,
		stageId = self._stageId,
		acqData = self._acqData,
		type = self._blitzType,
		autoUse = self._selectType
	}))
end

function BeginSweepPop:_getLockTip(arg_12_1)
	self._tip = arg_12_1 == g.core.model.User.resourceData:getBioGraphie() and g.core.lang:get(302076) or arg_12_1 == g.core.model.User.bioData:getMissionLeftCount(self._stageId) and g.core.lang:get(302077) or g.core.lang:get(302075)

	return self._tip
end

return BeginSweepPop

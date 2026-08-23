local var_0_0 = g.core.module.ModuleManager
local var_0_1 = g.core.model.User.gveDataMgr
local var_0_2 = 5
local GveLineUpKnightPop = class("GveLineUpKnightPop", require("app.fairyGUI.gve.UI_GveLineUpKnightPop"), function()
	return fgui.GComponent:create({
		resName = "GveLineUpKnightPop",
		pkgPath = "ui/gve/gve",
		isFullScreen = true,
		pkgName = "gve"
	}, ...)
end)

function GveLineUpKnightPop:ctor(arg_2_1)
	self._formationData = var_0_1:getGveFormationData()
	self._curIndex = arg_2_1 or 1
	self._knightList = {}
	self._groupSelectedIndex = 0
	self._isPlayerEnter = false
	self._isFilter = true

	self:_initView()
end

function GveLineUpKnightPop:_initView()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClickClose))
	self.m_groupList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onGroupListClickItem))
	self.m_cardList:setVirtual()
	self.m_cardList:setItemRenderer(handler(self, self._onRendererKnightList))
	self.m_cardList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickCell))
	self.m_filterBtn:addClickListener(handler(self, self._onFilterChanged))
	self.m_filterBtn:setSelected(self._isFilter)
	self.m_gotoBtn:addClickListener(handler(self, self._onGoToClick))
	self.m_gotoBtn:setTitle(g.core.lang:get(309188))

	local var_3_0 = self:getView():getSharedTrans("enter", "CommonRightPanelAnim", self.m_content)

	if var_3_0 then
		self._isPlayerEnter = true

		var_3_0:setHook("listEnter", handler(self, self.updateView))
		var_3_0:play()
	end
end

function GveLineUpKnightPop:_onGoToClick()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.Recruit_Jiesuan_Single_01)
	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_FORMATION_SELECT_KNIGHT)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function GveLineUpKnightPop:_onFilterChanged(arg_5_1)
	self._isFilter = self.m_filterBtn:isSelected()

	self:updateView()
end

function GveLineUpKnightPop:_onGroupListClickItem(arg_6_1)
	local var_6_0 = self.m_groupList:getSelectedIndex()

	if var_6_0 == self._groupSelectedIndex then
		return
	end

	self._groupSelectedIndex = var_6_0

	self:updateView()
end

function GveLineUpKnightPop:_onClickCell(arg_7_1)
	local var_7_0 = self._knightList[arg_7_1:getDataValue() + 1]

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0:getServerId()

	if self._formationData:checkKnightIsUsed(var_7_1) then
		var_0_0:tip(g.core.lang:get(309106))
	elseif self._formationData:getKnightActionBySid(var_7_1) < var_0_1:getGveBaseCfg().action_cost then
		var_0_0:tip(g.core.lang:get(309107))
	else
		if var_7_0:isElementLeader() then
			for iter_7_0, iter_7_1 in ipairs((self._formationData:getFormationStruct():getKnightSidArr())) do
				if iter_7_1 > 0 and iter_7_1 ~= var_7_1 then
					local var_7_2 = self._formationData:getKnightByServerId(iter_7_1)

					if var_7_2 and var_7_2:isElementLeader() then
						var_0_0:tip(g.core.lang:get(200051))

						return
					end
				end
			end
		end

		self:dispatchCompEvent("gve_formation_lineup_knight", {
			struct = var_7_0
		})
		self:_onClickClose()
	end
end

function GveLineUpKnightPop:_onRendererKnightList(arg_8_1, arg_8_2)
	arg_8_2:updateCompByGveKnihgtStruct(self._knightList[arg_8_1 + 1])
end

function GveLineUpKnightPop:onLoad()
	self.m_groupList:setNumItems(var_0_2)
	self.m_groupList:setSelectedIndex(self._groupSelectedIndex)
	self.m_runnerBanner:init({
		target = self.m_groupList
	})

	if not self._isPlayerEnter then
		self:updateView()
	end
end

function GveLineUpKnightPop:updateView()
	self._knightList = {}

	for iter_10_0, iter_10_1 in pairs((self._formationData:getAllEquipKnight())) do
		if iter_10_1.knight:isOwn() and (self._groupSelectedIndex == 0 or iter_10_1.knight:getGroup() == self._groupSelectedIndex) then
			if self._isFilter then
				if not self._formationData:checkKnightIsLineUp(iter_10_1.knight:getServerId()) then
					table.insert(self._knightList, iter_10_1.knight)
				end
			else
				table.insert(self._knightList, iter_10_1.knight)
			end
		end
	end

	table.sort(self._knightList, function(arg_11_0, arg_11_1)
		local var_11_0 = self._formationData:checkKnightIsUsed(arg_11_0:getServerId())

		if var_11_0 ~= self._formationData:checkKnightIsUsed(arg_11_1:getServerId()) then
			return not var_11_0
		end

		local var_11_1 = self._formationData:getKnightActionBySid(arg_11_0:getServerId()) >= var_0_1:getGveBaseCfg().action_cost

		if var_11_1 ~= (self._formationData:getKnightActionBySid(arg_11_1:getServerId()) >= var_0_1:getGveBaseCfg().action_cost) then
			return var_11_1
		end

		local var_11_2 = self._formationData:checkKnightIsLineUp(arg_11_0:getServerId())

		if var_11_2 ~= self._formationData:checkKnightIsLineUp(arg_11_1:getServerId()) then
			return var_11_2
		end

		local var_11_3 = arg_11_0:getQuality()
		local var_11_4 = arg_11_1:getQuality()

		if var_11_3 ~= var_11_4 then
			return var_11_4 < var_11_3
		end

		local var_11_5 = arg_11_0:getStarLv()
		local var_11_6 = arg_11_1:getStarLv()

		if var_11_5 ~= var_11_6 then
			return var_11_6 < var_11_5
		end

		return arg_11_0:getBaseId() > arg_11_1:getBaseId()
	end)

	if #self._knightList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_cardList:setNumItems(#self._knightList)
		self.m_cardList:transitionShowCells("listCrosbandBUiRightIn_cell", 0.03)
	end
end

function GveLineUpKnightPop:_onClickClose(arg_12_1)
	if self._isOnClose then
		return
	end

	if (arg_12_1 or nil) and not self.m_bgImage:containPoint((arg_12_1:getInput():getTouch():getLocation())) then
		self.m_cardList:setTouchable(false)

		self._isOnClose = true

		local var_12_1 = self:getView():getSharedTrans("back", "CommonRightPanelAnim", self.m_content)

		if var_12_1 then
			var_12_1:play(function()
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			end)
		else
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end
	end
end

function GveLineUpKnightPop:onUnload()
	self._isPlayerEnter = false
end

return GveLineUpKnightPop

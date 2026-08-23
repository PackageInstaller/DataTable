local var_0_0 = g.core.model.User.explorationData
local var_0_1 = g.core.const.ConstMgr.ExplorationConst
local var_0_2 = g.core.model.User.knightsData
local var_0_3 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_4 = 5
local ExplorationFormationRentLineUpPop = class("ExplorationFormationRentLineUpPop", require("app.fairyGUI.exploration.UI_ExplorationFormationRentLineUpPop"), function()
	return fgui.GComponent:create({
		pkgName = "exploration",
		isFullScreen = true,
		pkgPath = "ui/exploration/exploration",
		resName = "ExplorationFormationRentLineUpPop"
	}, ...)
end)

function ExplorationFormationRentLineUpPop:ctor(arg_2_1)
	self._formationData = var_0_0:getFormationData()
	self._curIndex = arg_2_1.curIndex or 1
	self._showKnightList = {}
	self._knightListDict = {}
	self._groupSelectedIndex = 0
	self._isPlayerEnter = false

	self:_initView()
end

function ExplorationFormationRentLineUpPop:_initView()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClickClose))
	self.m_groupList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onGroupListClickItem))
	self.m_cardList:setVirtual()
	self.m_cardList:setItemRenderer(handler(self, self._onRendererKnightList))
	self.m_cardList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickCell))

	local var_3_0 = self:getView():getSharedTrans("enter", "CommonRightPanelAnim", self.m_content)

	if var_3_0 then
		self._isPlayerEnter = true

		var_3_0:setHook("listEnter", handler(self, self.updateView))
		var_3_0:play()
	end
end

function ExplorationFormationRentLineUpPop:_onGroupListClickItem(arg_4_1)
	local var_4_0 = arg_4_1:getDataValue()

	if var_4_0 == self._groupSelectedIndex then
		return
	end

	self._groupSelectedIndex = var_4_0

	self:updateView()
end

function ExplorationFormationRentLineUpPop:_onClickCell(arg_5_1)
	local var_5_0 = self._showKnightList[arg_5_1:getDataValue() + 1]

	if not var_5_0 then
		return
	end

	local var_5_1 = var_5_0:getServerId()
	local var_5_2 = self._formationData:getSelfHelpKnightDict()
	local var_5_3 = {}

	if self._formationData:isKnightUsedBySid(var_5_1) then
		local var_5_4 = 0
		local var_5_5 = 0

		for iter_5_0 = 1, var_0_1.MAX_HELP_NUM do
			local var_5_6 = var_5_2[iter_5_0] or 0

			if var_5_6 > 0 and var_5_6 == var_5_1 then
				var_5_5 = iter_5_0
			end

			if iter_5_0 == self._curIndex then
				if var_5_6 == var_5_1 then
					var_5_3[iter_5_0] = 0
					var_5_4 = 0
				else
					var_5_3[iter_5_0] = var_5_1
					var_5_4 = var_5_6
				end
			else
				var_5_3[iter_5_0] = var_5_6 == var_5_1 and 0 or var_5_6
			end
		end

		if var_5_5 > 0 and var_5_4 > 0 then
			var_5_3[var_5_5] = var_5_4
		end
	else
		for iter_5_1 = 1, var_0_1.MAX_HELP_NUM do
			var_5_3[iter_5_1] = iter_5_1 == self._curIndex and var_5_1 or var_5_2[iter_5_1] or 0
		end
	end

	local var_5_8 = {}

	for iter_5_2, iter_5_3 in pairs(var_5_3) do
		table.insert(var_5_8, {
			id = iter_5_3,
			indice = iter_5_2
		})
	end

	g.core.network.GameNetProxy:send_C2S_FriendHelper_SetKnights({
		play_type = 1,
		setting = var_5_8
	})
end

function ExplorationFormationRentLineUpPop:_onRendererKnightList(arg_6_1, arg_6_2)
	arg_6_2:updateComp(self._showKnightList[arg_6_1 + 1])
end

function ExplorationFormationRentLineUpPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_HELPER_SETKNIGHTS, self._onLineUpEnd, self)
	self.m_groupList:setNumItems(var_0_4)
	self.m_groupList:setSelectedIndex(self._groupSelectedIndex)
	self.m_runnerBanner:init({
		target = self.m_groupList
	})

	if not self._isPlayerEnter then
		self:updateView()
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_ROLE_FORM_INTERFACE)
end

function ExplorationFormationRentLineUpPop:_onLineUpEnd()
	self:_onClickClose()
end

function ExplorationFormationRentLineUpPop:updateView()
	self._showKnightList = {}

	if not self._knightListDict[var_0_3.GROUP_TYPE.DEFAULT] then
		local var_9_0 = var_0_2:getOwnKnightListWithOutMain(0)

		table.sort(var_9_0, function(arg_10_0, arg_10_1)
			local var_10_0 = arg_10_0:getQuality()
			local var_10_1 = arg_10_1:getQuality()

			if var_10_0 ~= var_10_1 then
				return var_10_1 < var_10_0
			end

			local var_10_2 = arg_10_0:getStarLv()
			local var_10_3 = arg_10_1:getStarLv()

			if var_10_2 ~= var_10_3 then
				return var_10_3 < var_10_2
			end

			return arg_10_0:getAdvanceId() > arg_10_1:getAdvanceId()
		end)

		self._knightListDict = {}
		self._knightListDict[var_0_3.GROUP_TYPE.DEFAULT] = var_9_0

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			local var_9_1 = iter_9_1:getGroup()

			self._knightListDict[var_9_1] = self._knightListDict[var_9_1] or {}

			table.insert(self._knightListDict[var_9_1], iter_9_1)
		end
	end

	self._showKnightList = self._knightListDict[self._groupSelectedIndex] or {}

	local var_9_2 = #self._showKnightList

	self.m_isEmptyController:setSelectedIndex(#self._showKnightList == 0 and 1 or 0)

	if var_9_2 > 0 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_cardList:setNumItems(var_9_2)
		self.m_cardList:transitionShowCells("listCrosbandBUiRightIn_cell", 0.03)
	end
end

function ExplorationFormationRentLineUpPop:_onClickClose(arg_11_1)
	if self._isOnClose then
		return
	end

	if (arg_11_1 or nil) and not self.m_bgImage:containPoint((arg_11_1:getInput():getTouch():getLocation())) then
		self.m_cardList:setTouchable(false)

		self._isOnClose = true

		local var_11_1 = self:getView():getSharedTrans("back", "CommonRightPanelAnim", self.m_content)

		if var_11_1 then
			var_11_1:play(function()
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			end)
		else
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end
	end
end

function ExplorationFormationRentLineUpPop:onUnload()
	self._isPlayerEnter = false
end

return ExplorationFormationRentLineUpPop

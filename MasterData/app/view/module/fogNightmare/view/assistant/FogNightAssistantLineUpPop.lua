local var_0_0 = g.core.const.ConstMgr.FogNightmareConst
local var_0_1 = g.core.model.User.knightsData
local var_0_2 = g.core.model.User.fogNightmareData
local var_0_3 = 5
local FogNightAssistantLineUpPop = class("FogNightAssistantLineUpPop", require("app.fairyGUI.fogNightmare.UI_FogNightAssistantLineUpPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightAssistantLineUpPop",
		pkgPath = "ui/fogNightmare/fogNightmare",
		isFullScreen = true,
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightAssistantLineUpPop:ctor(arg_2_1)
	self._assistantData = var_0_2:getAssistantData()
	self._curIndex = arg_2_1 or 1
	self._knightList = {}
	self._groupSelectedIndex = 0
	self._isPlayerEnter = false

	self:_initView()
end

function FogNightAssistantLineUpPop:_initView()
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

function FogNightAssistantLineUpPop:_onGroupListClickItem(arg_4_1)
	local var_4_0 = self.m_groupList:getSelectedIndex()

	if var_4_0 == self._groupSelectedIndex then
		return
	end

	self._groupSelectedIndex = var_4_0

	self:updateView()
end

function FogNightAssistantLineUpPop:_onClickCell(arg_5_1)
	local var_5_0 = self._knightList[arg_5_1:getDataValue() + 1]

	if not var_5_0 then
		return
	end

	local var_5_1 = var_5_0:getServerId()
	local var_5_2 = self._assistantData:getSelfHelperKnights()
	local var_5_3 = {}

	if self._assistantData:isUseKnightById(var_5_1) then
		local var_5_4 = 0
		local var_5_5 = 0

		for iter_5_0 = 1, var_0_0.MAX_HELPER_COUNT do
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
		for iter_5_1 = 1, var_0_0.MAX_HELPER_COUNT do
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
		play_type = 0,
		setting = var_5_8
	})
end

function FogNightAssistantLineUpPop:_onRendererKnightList(arg_6_1, arg_6_2)
	arg_6_2:updateComp(self._knightList[arg_6_1 + 1])
end

function FogNightAssistantLineUpPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_HELPER_SETKNIGHTS, self._onLineUpEnd, self)
	self.m_groupList:setNumItems(var_0_3)
	self.m_groupList:setSelectedIndex(self._groupSelectedIndex)
	self.m_runnerBanner:init({
		target = self.m_groupList
	})

	if not self._isPlayerEnter then
		self:updateView()
	end
end

function FogNightAssistantLineUpPop:_onLineUpEnd()
	self:_onClickClose()
end

function FogNightAssistantLineUpPop:updateView()
	self._knightList = {}

	for iter_9_0, iter_9_1 in pairs((var_0_1:getList())) do
		if iter_9_1:isOwn() and (self._groupSelectedIndex == 0 or iter_9_1:getGroup() == self._groupSelectedIndex) then
			table.insert(self._knightList, iter_9_1)
		end
	end

	table.sort(self._knightList, function(arg_10_0, arg_10_1)
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

		return arg_10_0:getBaseId() > arg_10_1:getBaseId()
	end)

	if #self._knightList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_cardList:setNumItems(#self._knightList)
		self.m_cardList:transitionShowCells("listCrosbandBUiRightIn_cell", 0.03)
	end
end

function FogNightAssistantLineUpPop:_onClickClose(arg_11_1)
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

function FogNightAssistantLineUpPop:onUnload()
	self._isPlayerEnter = false
end

return FogNightAssistantLineUpPop

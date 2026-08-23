local var_0_0 = g.core.model.User.explorationData
local var_0_1 = g.core.const.ConstMgr.ExplorationConst
local var_0_2 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.event.EventManager
local var_0_5 = g.core.network.GameNetProxy
local ExplorationFormationRentLayer = class("ExplorationFormationRentLayer", require("app.fairyGUI.exploration.UI_ExplorationFormationRentLayer"), function()
	return fgui.GComponent:create({
		resName = "ExplorationFormationRentLayer",
		pkgPath = "ui/exploration/exploration",
		isFullScreen = true,
		pkgName = "exploration"
	}, ...)
end)

function ExplorationFormationRentLayer:ctor()
	self._formationData = var_0_0:getFormationData()
	self._tabSel = var_0_1.ASSISTANT_TYPE.LEND
	self._campSel = var_0_2.GROUP_TYPE.DEFAULT
	self._curShowKnightList = {}
	self._clickLuaIndex = 0

	self.m_tabTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabTypeChanged))
	self.m_campController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCampChanged))
	self.m_knightList:setVirtual(self)
	self.m_knightList:setItemRenderer(handler(self, self._onRenderKnightList))
	self.m_maxNumText:setText(var_0_1.MAX_HELP_NUM)
end

function ExplorationFormationRentLayer:_onTabTypeChanged()
	self._tabSel = self.m_tabTypeController:getSelectedIndex()

	if self._tabSel == var_0_1.ASSISTANT_TYPE.LEND then
		self:_updateHelpKnights()
	else
		self:_updateKnightList()
	end
end

function ExplorationFormationRentLayer:_onCampChanged()
	self._campSel = self.m_campController:getSelectedIndex()

	self:_updateKnightList()
end

function ExplorationFormationRentLayer:_updateHelpKnights()
	local var_5_0 = self._formationData:getSelfHelpKnightDict()

	for iter_5_0 = 1, 3 do
		self["m_cardComp" .. iter_5_0]:updateKnightCard(var_5_0[iter_5_0], iter_5_0)
	end

	self.m_knightNumText:setText(self._formationData:getUsedKnightNum() .. "/")
end

function ExplorationFormationRentLayer:_updateKnightList()
	self._curShowKnightList = self._formationData:getHelperDataByGroup(self._campSel)

	self.m_emptyComp:setVisible(self._tabSel ~= var_0_1.ASSISTANT_TYPE.LEND and not (#self._curShowKnightList > 0))
	self.m_knightList:setNumItems(#self._curShowKnightList)
end

function ExplorationFormationRentLayer:_onRenderKnightList(arg_7_1, arg_7_2)
	arg_7_2:updateKnightCell(self._curShowKnightList[arg_7_1 + 1])
end

function ExplorationFormationRentLayer:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "pop_knight_list" then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.exploration.view.formation.ExplorationFormationRentLineUpPop").new({
			curIndex = arg_8_2.index
		}), {
			touchDisappear = false,
			ignoreTouch = true
		})

		return true
	elseif arg_8_1 == "Select_Helper" then
		self.m_knightList:setNumItems(#self._curShowKnightList)
	end
end

function ExplorationFormationRentLayer:_onS2CShowSetKnights(arg_9_1, arg_9_2, arg_9_3)
	self:_updateHelpKnights()
end

function ExplorationFormationRentLayer:_onS2CSetKnights(arg_10_1, arg_10_2, arg_10_3)
	self:_updateHelpKnights()
end

function ExplorationFormationRentLayer:_onS2CGetKnights(arg_11_1, arg_11_2, arg_11_3)
	self:_updateKnightList()
end

function ExplorationFormationRentLayer:_onS2CUseKnights(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3 and arg_12_3.use and arg_12_3.use[1] then
		local var_12_0, var_12_1 = self._formationData:getTempHelper()

		if arg_12_3.use[1].uid ~= var_12_0 or arg_12_3.use[1].id ~= var_12_1 then
			self.m_knightList:setNumItems(#self._curShowKnightList)
		end

		self._formationData:saveTempHelper(0, 0)
	end
end

function ExplorationFormationRentLayer:_onS2CGetUserSnapShot()
	self:_updateKnightList()
end

function ExplorationFormationRentLayer:_isGuildHasOtherMember()
	return true
end

function ExplorationFormationRentLayer:onLoad()
	var_0_4:addEventListener(var_0_3.EVENT_NET_S2C_FRIEND_HELPER_GETKNIGHTS, self._onS2CGetKnights, self)
	var_0_4:addEventListener(var_0_3.EVENT_NET_S2C_FRIEND_HELPER_SHOWSETKNIGHTS, self._onS2CShowSetKnights, self)
	var_0_4:addEventListener(var_0_3.EVENT_NET_S2C_FRIEND_HELPER_SETKNIGHTS, self._onS2CSetKnights, self)
	var_0_4:addEventListener(var_0_3.EVENT_NET_S2C_FRIEND_HELPER_USEKNIGHTS, self._onS2CUseKnights, self)
	var_0_4:addEventListener(var_0_3.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onS2CGetUserSnapShot, self)
	var_0_5:send_C2S_FriendHelper_ShowSetKnights({
		play_type = 1
	})

	if self:_isGuildHasOtherMember() then
		var_0_5:send_C2S_FriendHelper_GetKnights({
			page = 1,
			page_num = 200,
			play_type = 1
		})
	end

	self._formationData:saveTempHelper(0, 0)
	self:_updateHelpKnights()
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_HELPING_HAND)
end

function ExplorationFormationRentLayer:onUnload()
	self.m_backTransition:play()
end

return ExplorationFormationRentLayer

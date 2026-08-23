local var_0_0 = g.core.const.ConstMgr
local var_0_1 = {
	DONG_XI = 3,
	LIN_DONG = 2,
	JIAO_GUO = 1,
	LI_JIN = 4
}
local var_0_2 = {
	[0] = 0,
	var_0_1.LIN_DONG,
	var_0_1.DONG_XI,
	var_0_1.LI_JIN,
	var_0_1.JIAO_GUO
}
local var_0_3 = g.core.model.User.fogNightmareData
local FogNightAssistantFriendPop = class("FogNightAssistantFriendPop", require("app.fairyGUI.fogNightmare.UI_FogNightAssistantFriendPop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/fogNightmare/fogNightmare",
		resName = "FogNightAssistantFriendPop",
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightAssistantFriendPop:ctor(arg_2_1)
	self:showAtCenter()
	self:setSize(display.width, display.height)
	self.m_topBarComp:setResInfoById(var_0_0.HelpConst.HELP_TYPE.FOG_NIGHTMARE)

	self._group = 0
	self._curSelData = nil
	self._curGroupData = {}
	self._lineUpInfo = arg_2_1.lineUpInfo
	self._lineUpIds = {}

	for iter_2_0, iter_2_1 in pairs(self._lineUpInfo) do
		self._lineUpIds[iter_2_1.knight:getAdvanceId()] = true

		if iter_2_1.knight:isMain() then
			self._lineUpIds[99999] = true
		end
	end

	self.m_groupController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onGroupChanged))
	self.m_playerList:setVirtual()
	self.m_playerList:setItemRenderer(handler(self, self._onPlayerListRenderer))
	self.m_playerList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onItemClick))
	self.m_playerList:doFairyBatching(false)
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_OPEN_ASSISTANT)
end

function FogNightAssistantFriendPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_HELPER_GETKNIGHTS, self._onHelperFriendBack, self)

	if #g.core.model.User.friendData:getFriendList() ~= 0 then
		local var_3_0 = tonumber(g.core.common.ServerTime:getTime())

		if var_3_0 - var_0_3:getHelperKnightsConnectTime() >= 10 then
			g.core.network.GameNetProxy:send_C2S_FriendHelper_GetKnights({
				play_type = 0,
				page_num = 200,
				page = 1
			})
			var_0_3:setHelperKnightsConnectTime(var_3_0)
		else
			self:_onHelperFriendBack()
		end
	else
		var_0_3:getAssistantData():clearFriendHelper()
	end

	self:updateFriendView(true)
end

function FogNightAssistantFriendPop:onUnLoad()
	return
end

function FogNightAssistantFriendPop:_onGroupChanged()
	local var_5_0 = var_0_2[self.m_groupController:getSelectedIndex()]

	if var_5_0 ~= self._group then
		self._group = var_5_0

		self:updateFriendView(true)
	end
end

function FogNightAssistantFriendPop:_onHelperFriendBack()
	self:updateFriendView(false)
end

function FogNightAssistantFriendPop:updateFriendView(arg_7_1)
	self._curGroupData = var_0_3:getAssistantData():getOtherHelperByGroup(self._group)

	self.m_playerList:setNumItems(#self._curGroupData)

	if arg_7_1 then
		self.m_playerList:transitionShowCells("listIconUiScaleIn", 0.03)
	end
end

function FogNightAssistantFriendPop:_onPlayerListRenderer(arg_8_1, arg_8_2)
	local var_8_0 = false

	if self._curGroupData[arg_8_1 + 1].struct then
		var_8_0 = self._lineUpIds[self._curGroupData[arg_8_1 + 1].struct:getAdvanceId()]
	end

	self._curGroupData[arg_8_1 + 1].hasSameLineUp = var_8_0

	arg_8_2:updateFriendIcon(self._curGroupData[arg_8_1 + 1], var_8_0)
end

function FogNightAssistantFriendPop:_onItemClick(arg_9_1)
	local var_9_0 = self._curGroupData[arg_9_1:getDataValue() + 1]

	if var_9_0.hasSameLineUp then
		g.core.module.ModuleManager:tip(g.core.lang:get(500132))

		return
	end

	if not self._curSelData then
		self._curSelData = var_9_0

		self:onChangeSel()
	elseif self._curSelData ~= var_9_0 then
		self._curSelData = var_9_0

		self:onChangeSel()
	end
end

function FogNightAssistantFriendPop:onChangeSel()
	var_0_3:getAssistantData():setCurSelAssistantKnight({
		self._curSelData.struct
	})
	self:dispatchCompEvent("FogNightAssistantSelected")
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return FogNightAssistantFriendPop

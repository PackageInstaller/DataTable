local var_0_0 = g.core.const.ConstMgr.CommanderWorldConst
local var_0_1 = g.core.model.User.commanderWorldData
local CommanderWorldAllLordLayer = class("CommanderWorldAllLordLayer", require("app.fairyGUI.commanderWorld.UI_CommanderWorldAllLordLayer"), function()
	return fgui.GComponent:create({
		resName = "CommanderWorldAllLordLayer",
		pkgPath = "ui/commanderWorld/commanderWorld",
		isFullScreen = true,
		pkgName = "commanderWorld"
	}, ...)
end)

function CommanderWorldAllLordLayer:ctor()
	self:addBg("bg/commanderWorld/bg_haolingtianxia2.jpg")

	self._stage = 0
	self._tabType = 0
	self._marsRankDatas = {}

	self.m_tabSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
	self.m_topBar:setResInfoById(var_0_0.TOP_BAR_ID)
	self.m_enterTransition:play()
end

function CommanderWorldAllLordLayer:_onChangeTabCtrl()
	self._tabType = self.m_tabSelController:getSelectedIndex()

	self:updateItemInfos()
	self.m_leftOutTransition:play()
end

function CommanderWorldAllLordLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRevCommanderRankInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onRevCommanderRankInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_MARSAWARD, self._onRcvAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_INFO, self._onRcvCommanderWorldInfo, self)
	self:_sendRankInfo()
	self:_refreshRedPoint()
end

function CommanderWorldAllLordLayer:_refreshRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_localBtn,
		customData = {
			stage = 1
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_CrossBtn,
		customData = {
			stage = 2
		}
	})
end

function CommanderWorldAllLordLayer:_sendRankInfo()
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 15,
		id = var_0_0.RANKTYPE.LOCALSERVICERANK
	})

	if self._stage ~= var_0_0.STAGE.LOCALSERVICE then
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 20,
			id = var_0_0.RANKTYPE.CROSSSERVICERANK
		})
	end
end

function CommanderWorldAllLordLayer:updateItemInfos()
	self.m_allUserComp:updateRankLordComp(self._tabType + 1)
end

function CommanderWorldAllLordLayer:_onRevCommanderRankInfo()
	self._stage = var_0_1:getActivityStageAndRemainTime()

	self.m_svrOpenController:setSelectedIndex(0)
	self.m_titleNameTxt:setText(g.core.lang:get(410313, {
		name = g.core.model.User:packUser().guild_name
	}))

	if self._stage == var_0_0.STAGE.LOCALSERVICE then
		self.m_svrOpenController:setSelectedIndex(0)
	else
		local var_8_0 = var_0_1:getCommanderMarsRankInfo(var_0_0.SERVER_TYPE.LOCAL)

		if self._stage == var_0_0.STAGE.CROSSSERVICE then
			self.m_svrOpenController:setSelectedIndex(1)
			self.m_CrossBtn:setVisible(false)
		else
			self.m_svrOpenController:setSelectedIndex(2)

			if table.nums(var_8_0) == 0 then
				self.m_localBtn:setVisible(false)
				self.m_tabSelController:setSelectedIndex(1)
			end

			local var_8_1

			if table.nums((var_0_1:getCommanderMarsRankInfo(var_0_0.SERVER_TYPE.CROSS))) == 0 then
				self.m_CrossBtn:setVisible(false)
				self.m_tabSelController:setSelectedIndex(0)

				var_8_1 = {}
			end

			var_8_1.name = g.core.platform.ServerListProxy:getSelectedServer().name

			self.m_titleNameTxt:setText(g.core.lang:get(410313, var_8_1))
		end
	end

	self:updateItemInfos()
end

function CommanderWorldAllLordLayer:_onRcvAward(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3.awards then
		g.core.module.ModuleManager:awardSummary(arg_9_3.awards, true)
		self:updateItemInfos()
		self:_refreshRedPoint()
	end
end

function CommanderWorldAllLordLayer:_onRcvCommanderWorldInfo()
	self:_sendRankInfo()
end

return CommanderWorldAllLordLayer

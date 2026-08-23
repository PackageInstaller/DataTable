local var_0_0 = g.core.const.ConstMgr.NewSlgConst
local var_0_1 = g.core.const.ConstMgr.NewSlgConst.RANK_TYPE_ID_MAP
local var_0_2 = g.core.model.User.newSlgData
local NewSlgPvcLastDayRankPop = class("NewSlgPvcLastDayRankPop", require("app.fairyGUI.newSlg.UI_NewSlgPvcLastDayRankPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgPvcLastDayRankPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgPvcLastDayRankPop:ctor()
	self._userRankComp = self:getChild("Comp_user")
	self._unionRankComp = self:getChild("Comp_union")
	self.m_closeBtn = self:getChild("Btn_close")

	self:getController("bigTab"):addEventListener(fgui.UIEventType.Changed, handler(self, self.updateRankView))
	self:showAtCenter()

	self._rankData = {}

	self.m_closeBtn:setClickCallBack(handler(self, self.onClose))
	self.m_closeGraph:addClickListener(handler(self, self.onClose))
end

function NewSlgPvcLastDayRankPop:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETRANK, self.onS2CNewSlgGetRank, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, handler(self, self.updateRankView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self.updateRankView), self)
	g.core.network.GameNetProxy:send_C2S_NewSlg_GetRank({
		id = var_0_0.RANK_TYPE.PERSONAL_ALL,
		limit = var_0_2:getNewSlgParamsValueById(var_0_1[var_0_0.RANK_TYPE.PERSONAL_ALL])
	})

	if g.core.model.User.newSlgData:getSName() == "S2" then
		g.core.network.GameNetProxy:send_C2S_NewSlg_GetRank({
			id = var_0_0.RANK_TYPE.S2_ALLIANCE,
			limit = var_0_2:getNewSlgParamsValueById(var_0_1[var_0_0.RANK_TYPE.UNION])
		})
	else
		g.core.network.GameNetProxy:send_C2S_NewSlg_GetRank({
			id = var_0_0.RANK_TYPE.UNION,
			limit = var_0_2:getNewSlgParamsValueById(var_0_1[var_0_0.RANK_TYPE.UNION])
		})
	end
end

function NewSlgPvcLastDayRankPop:onClose()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(handler(self, self.onCloseFinish))
end

function NewSlgPvcLastDayRankPop:onCloseFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgPvcLastDayRankPop:onS2CNewSlgGetRank(arg_6_1, arg_6_2, arg_6_3)
	self._rankData[arg_6_3.id] = arg_6_3

	self:updateRankView()
end

function NewSlgPvcLastDayRankPop:updateRankView()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallClick)

	if self:getController("bigTab"):getSelectedIndex() == 0 then
		if self._rankData[var_0_0.RANK_TYPE.PERSONAL_ALL] then
			self._userRankComp:updateRankView(self._rankData[var_0_0.RANK_TYPE.PERSONAL_ALL], var_0_1[var_0_0.RANK_TYPE.PERSONAL_ALL])
		end
	elseif self._rankData[var_0_0.RANK_TYPE.UNION] then
		self._unionRankComp:updateRankView(self._rankData[var_0_0.RANK_TYPE.UNION], var_0_1[var_0_0.RANK_TYPE.UNION])
		self._unionRankComp:setVisible(true)
	end
end

return NewSlgPvcLastDayRankPop

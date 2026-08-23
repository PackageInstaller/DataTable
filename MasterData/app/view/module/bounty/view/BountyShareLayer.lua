local var_0_0 = g.core.const.ConstMgr.BountyConst
local BountyShareLayer = class("BountyShareLayer", require("app.fairyGUI.bounty.UI_BountyShareLayer"), function()
	return fgui.GComponent:create({
		resName = "BountyShareLayer",
		pkgPath = "ui/bounty/bounty",
		isFullScreen = true,
		pkgName = "bounty"
	}, ...)
end)

function BountyShareLayer:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._selectType = arg_2_1.shareType or var_0_0.SHARE_SEL_TYPE.MINE
	self._shareMonsterId = arg_2_1.monsterId
	self._hideOther = arg_2_1.hideOther
	self._monsterList = {}
	self._checkUserMap = {}
	self._filterStar = arg_2_1.star or 0
	self._needSync = false
	self._listShowRange = {
		max = 0,
		min = 0
	}
	self._isFirst = true

	self:addBg("bg/bounty/bg_sjls_fenxiang.jpg", true)
	self:_initBtn()
	self:_initListView()
	self.m_justShowMineController:setSelectedIndex(self._hideOther and 1 or 0)

	if self._hideOther then
		self._selectType = var_0_0.SHARE_SEL_TYPE.MINE

		self.m_justShowMineController:setSelectedIndex(1)
	else
		self.m_justShowMineController:setSelectedIndex(0)
	end
end

function BountyShareLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayRefresh), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETSHAREMONSTERLIST, self.updateListView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self.updateListView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BOUNTY_CHALLENGEFINISH, self.updateListView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BOUNTY_MONSTERSHAREAWARD, handler(self, self._onS2CBountyMonsterShareAward), self)

	self._selectType = nil

	self.m_selectTypeController:setSelectedIndex(self._selectType)
	self:_onTabChanged()
	self:newSchedule(handler(self, self.updateTime), 1)

	self._isFirst = false
end

function BountyShareLayer:onUnload()
	return
end

function BountyShareLayer:onRemoved()
	return
end

function BountyShareLayer:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "get_share_award" then
		self:_getShareAward(arg_6_2.monster)

		return true
	elseif arg_6_1 == "pop_battle_pop" then
		self:_popBattlePop(arg_6_2.monster)

		return true
	elseif arg_6_1 == "filter_event" then
		self._filterStar = arg_6_2.star + 1

		self.m_chooseStarBtn:setTitle(g.core.lang:get(422050 + self._filterStar))
		self.m_isChooseController:setSelectedIndex(0)
		self:_onCrossDayRefresh()

		return true
	elseif arg_6_1 == "share_monster_time_end" then
		self._needSync = true

		return true
	elseif arg_6_1 == "bounty_battle_error" then
		self:_onCrossDayRefresh()

		return true
	end
end

function BountyShareLayer:_onCrossDayRefresh(arg_7_1, arg_7_2, arg_7_3)
	g.core.network.GameNetProxy:send_C2S_Bounty_GetShareMonsterList({
		share_type = self._selectType,
		star = self._filterStar
	})
end

function BountyShareLayer:_initListView()
	self.m_monsterList:setVirtual(self)
	self.m_monsterList:setItemRenderer(handler(self, self._onRenderMonsterList))
end

function BountyShareLayer:_initBtn()
	self.m_chooseStarBtn:addClickListener(handler(self, self._onChooseClick))
	self.m_touchComp:addClickListener(handler(self, self._onTouchChooseClick))
	self.m_selectTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabChanged))
	self.m_topBarComp:setResInfoById(328)
end

function BountyShareLayer:_onRenderMonsterList(arg_10_1, arg_10_2)
	arg_10_2:updateMonsterCell({
		monster = self._monsterList[arg_10_1 + 1],
		tabType = self._selectType
	})
end

function BountyShareLayer:updateListView()
	local var_11_0 = g.core.model.User.bountyData:getShareMonsterListByShareType(self._selectType)

	if self._selectType ~= 0 and self._filterStar > 0 then
		self._monsterList = var_11_0[self._filterStar]
	else
		self._monsterList = {}

		for iter_11_0, iter_11_1 in pairs(var_11_0) do
			for iter_11_2, iter_11_3 in ipairs(iter_11_1) do
				self._monsterList[#self._monsterList + 1] = self.m_justShowMineController:getSelectedIndex() == 1 and iter_11_3:getKillUserId() ~= 0 and iter_11_3 or iter_11_3
			end
		end

		self:sortShareMonsterList(self._monsterList)
	end

	self.m_monsterList:setNumItems(#self._monsterList)
	self.m_monsterList:transitionShowCells("enter_left", 0.03)
	self.m_isEmptyController:setSelectedIndex(#self._monsterList > 0 and 0 or 1)
end

function BountyShareLayer:sortShareMonsterList(arg_12_1)
	table.sort(arg_12_1, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0:getKillUserId() ~= 0

		if var_13_0 ~= (arg_13_1:getKillUserId() ~= 0) then
			return var_13_0
		end

		local var_13_1 = arg_13_0:getStarNum()
		local var_13_2 = arg_13_1:getStarNum()

		if var_13_1 ~= var_13_2 then
			return var_13_2 < var_13_1
		end

		local var_13_3 = arg_13_0:getExpireTime()
		local var_13_4 = arg_13_1:getExpireTime()

		if var_13_3 ~= var_13_4 then
			return var_13_3 < var_13_4
		end

		return arg_13_0:getAdvanceId() > arg_13_1:getAdvanceId()
	end)
end

function BountyShareLayer:updateTime()
	for iter_14_0, iter_14_1 in ipairs((self.m_monsterList:getChildren())) do
		iter_14_1:updateCellTime()
	end

	if self._needSync then
		self:_onCrossDayRefresh()

		self._needSync = false
	end
end

function BountyShareLayer:_onChooseClick()
	self.m_isChooseController:setSelectedIndex(1)
end

function BountyShareLayer:_onTouchChooseClick()
	self.m_isChooseController:setSelectedIndex(0)
end

function BountyShareLayer:_onTabChanged(arg_17_1)
	local var_17_0 = self.m_selectTypeController:getSelectedIndex()

	if self._selectType == var_17_0 then
		return
	end

	self._selectType = var_17_0

	if self._selectType == var_0_0.SHARE_SEL_TYPE.GUILD and not g.core.model.User:isJoinGuild() then
		self.m_emptyComp:setText(g.core.lang:get(422045))
	else
		self.m_emptyComp:setText(g.core.lang:get(422044))
	end

	if not self._isFirst then
		self._filterStar = g.core.model.User.bountyData:getShareRequestStarMap()[self._selectType] or 7
	end

	if self._filterStar == 0 then
		self._filterStar = 7
	end

	self.m_chooseComp:setSelectedStar(self._filterStar - 1)
	self.m_chooseStarBtn:setTitle(g.core.lang:get(422050 + self._filterStar))
	self:_onCrossDayRefresh()
end

function BountyShareLayer:_getShareAward(arg_18_1)
	g.core.network.GameNetProxy:send_C2S_Bounty_MonsterShareAward({
		id = arg_18_1:getId()
	})
end

function BountyShareLayer:_popBattlePop(arg_19_1)
	if (g.core.model.User.bountyData:getHelpScore() or 0) >= g.core.model.User.bountyData:getHelpScoreLimit() then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			singleButton = true,
			title = g.core.lang:get(111026),
			desc = g.core.lang:get(422046),
			onConfirm = handler(self, function(arg_20_0)
				arg_20_0:_showBattlePop(arg_19_1)
			end)
		}), {
			touchDisappear = true
		})
	else
		self:_showBattlePop(arg_19_1)
	end
end

function BountyShareLayer:_showBattlePop(arg_21_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.bounty.view.pop.BountyBattlePop").new({
		monster = arg_21_1,
		shareType = self._selectType
	}), {
		touchDisappear = true
	})
end

function BountyShareLayer:_onS2CBountyMonsterShareAward(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = {
		showNow = true
	}
	local var_22_1 = {}

	var_22_1.awards = arg_22_4.awards or {}
	var_22_0.award = var_22_1

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, var_22_0)
	self:updateListView()
end

return BountyShareLayer

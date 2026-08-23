local var_0_0 = g.core.const.ConstMgr.NewSlgConst
local var_0_1 = g.core.const.ConstMgr.NewSlgConst.RANK_TYPE_ID_MAP
local var_0_2 = g.core.model.User.newSlgData
local NewSlgPvcRankLayer = class("NewSlgPvcRankLayer", function()
	return fgui.GComponent:create({
		pkgName = "newSlg",
		isFullScreen = true,
		pkgPath = "ui/newSlg/newSlg",
		resName = "NewSlgPvcRankLayer"
	}, ...)
end, require("app.fairyGUI.newSlg.UI_NewSlgPvcRankLayer"))

function NewSlgPvcRankLayer:ctor(arg_2_1)
	self:addBg("bg/common/pic_bb_beijing.jpg")

	if g.core.model.User.newSlgData:getSName() == "S2" then
		self.m_topBar:setHelpId(378)
	else
		self.m_topBar:setHelpId(373)
	end

	self.m_topBar:updateTopRes()

	self._rankData = {}
	self._curRank = nil
	self._isFirst = true

	self.m_leftTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onLeftTabChanged))
	self.m_rightTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onRightTabChanged))
	self.m_userRank:setDefaultCityId(arg_2_1 and arg_2_1.cityId)

	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.rankType or 1

		if g.core.model.User.newSlgData:getSName() == "S2" then
			var_2_0 = var_2_0 == var_0_0.RANK_TYPE.UNION and var_0_0.RANK_TYPE.S2_ALLIANCE or var_0_0.RANK_TYPE.PERSONAL_ALL

			self.m_seasonController:setSelectedIndex(1)
		end
	end

	self.m_leftTabController:setSelectedIndex(var_2_0 - 1)
	self:_onLeftTabChanged()

	if arg_2_1 then
		local var_2_1 = arg_2_1.topTab or 1

		if var_2_1 then
			self.m_rightTabController:setSelectedIndex(var_2_1 - 1)

			goto label_2_0
		end
	end

	self.m_rightTabController:setSelectedIndex(0)

	::label_2_0::
end

function NewSlgPvcRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETRANK, self.onS2CNewSlgGetRank, self)
	self:updateRankShowView()
	self:_requestRankMsg()

	self._isFirst = false
end

function NewSlgPvcRankLayer:updateRankShowView()
	if g.core.model.User.newSlgData:getSName() == "S2" then
		if g.core.model.User.newSlgData:getNewSlgParamsValueById(1016) * 86400 + g.core.model.User.newSlgData:getActStartTime() > g.core.common.ServerTime:getTime() then
			self.m_seasonController:setSelectedIndex(2)
			self.m_leftTabController:setSelectedIndex(4)
		else
			self.m_seasonController:setSelectedIndex(1)
		end
	end
end

function NewSlgPvcRankLayer:_onCrossDayUpdate()
	self:updateRankShowView()
end

function NewSlgPvcRankLayer:_onLeftTabChanged()
	if self._curRank then
		self._curRank:setRankType(nil)
	end

	local var_6_0 = self.m_leftTabController:getSelectedIndex() + 1

	if var_6_0 == var_0_0.RANK_TYPE.PERSONAL_ALL then
		self._curRank = self.m_userRank
	elseif var_6_0 == var_0_0.RANK_TYPE.PERSONAL_UNION then
		self._curRank = self.m_userRank
	elseif var_6_0 == var_0_0.RANK_TYPE.UNION then
		self._curRank = self.m_unionRank
	elseif var_6_0 == var_0_0.RANK_TYPE.FINAL_DRAGON then
		self._curRank = self.m_finalRank
	elseif var_6_0 == var_0_0.RANK_TYPE.S2_ALLIANCE then
		self._curRank = self.m_unionRank
	end

	self._curRank:setRankType(var_6_0)

	if not self._isFirst then
		self.m_rightTabController:setSelectedIndex(0)
		self:_onRightTabChanged()
		self:_requestRankMsg()
	end
end

function NewSlgPvcRankLayer:_onRightTabChanged()
	local var_7_0 = self.m_rightTabController:getSelectedIndex()

	if self._curRank then
		self._curRank:isRewardTab(var_7_0 == 1 or var_7_0 == 2, var_7_0)
	end

	if not self._rankData[self.m_leftTabController:getSelectedIndex() + 1] and var_7_0 == 0 then
		self:_requestRankMsg()
	end
end

function NewSlgPvcRankLayer:_requestRankMsg()
	local var_8_0 = self.m_leftTabController:getSelectedIndex() + 1

	self:_sendRankMsg(var_8_0, var_0_2:getNewSlgParamsValueById(var_0_1[var_8_0]), (var_8_0 == var_0_0.RANK_TYPE.PERSONAL_UNION or nil) and {
		city_id = self.m_userRank:getCityId()
	})
end

function NewSlgPvcRankLayer:receiveCompEvent(arg_9_1, arg_9_2)
	arg_9_2 = arg_9_2 or {}

	if arg_9_1 == "NEW_SLG_RANK_CHANGE_CITY" then
		self:_sendRankMsg(var_0_0.RANK_TYPE.PERSONAL_UNION, var_0_2:getNewSlgParamsValueById(var_0_1[var_0_0.RANK_TYPE.PERSONAL_UNION]), {
			city_id = self.m_userRank:getCityId()
		})
	elseif arg_9_1 == "NEW_SLG_RANK_STATE_CHANGE" and g.core.model.User.newSlgData:getSName() == "S1" then
		self:_sendRankMsg(var_0_0.RANK_TYPE.FINAL_DRAGON, (var_0_2:getNewSlgParamsValueById(var_0_1[var_0_0.RANK_TYPE.FINAL_DRAGON])))
	end
end

function NewSlgPvcRankLayer:onS2CNewSlgGetRank(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3.limit == 1 then
		return
	end

	self._rankData[arg_10_3.id] = arg_10_3

	self:_updateRankView()

	self._isFirst = false
end

function NewSlgPvcRankLayer:_updateRankView()
	local var_11_0 = self.m_leftTabController:getSelectedIndex() + 1
	local var_11_1 = 0
	local var_11_2 = 0

	if self._rankData[var_11_0] then
		self._curRank:updateRankView(self._rankData[var_11_0], var_11_0)

		if self._rankData[var_11_0].rank_units then
			if self._rankData[var_11_0].self_unit and self._rankData[var_11_0].self_unit.rank > 0 and self._rankData[var_11_0].self_unit.rank <= var_0_2:getNewSlgParamsValueById(var_0_1[var_11_0]) then
				var_11_1 = self._rankData[var_11_0].self_unit.rank
				var_11_2 = self._rankData[var_11_0].self_unit.score
			end

			self:setCtrlState("empty", {
				index = 1
			})
		else
			self:setCtrlState("empty", {
				index = 0
			})
		end
	end

	if var_11_1 > 0 then
		if var_11_0 == var_0_0.RANK_TYPE.S2_ALLIANCE then
			self.m_rankTxt:setText(g.core.lang:get(429053, {
				rank = var_11_1
			}))
			self.m_scoreNumTxt:setText("")
		else
			self.m_rankTxt:setText(g.core.lang:get(429021, {
				rank = var_11_1
			}))
			self.m_scoreNumTxt:setText(g.core.lang:get(429031, {
				score = var_11_2
			}))
		end
	else
		self.m_rankTxt:setText(g.core.lang:get(429022))
		self.m_scoreNumTxt:setText(g.core.lang:get(429032))
	end
end

function NewSlgPvcRankLayer:isInFinalRankShow()
	return true
end

function NewSlgPvcRankLayer:_sendRankMsg(arg_13_1, arg_13_2, arg_13_3)
	arg_13_3 = arg_13_3 or {}
	arg_13_3.id = arg_13_1
	arg_13_3.limit = arg_13_2

	if var_0_2:isForecasting() or not var_0_2:isOpen() then
		self:onS2CNewSlgGetRank(nil, nil, {
			id = arg_13_3.id
		})
	else
		g.core.network.GameNetProxy:send_C2S_NewSlg_GetRank(arg_13_3)
	end
end

return NewSlgPvcRankLayer

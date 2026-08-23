local NewSlgS2RankLayer = class("NewSlgS2RankLayer", function()
	return fgui.GComponent:create({
		resName = "NewSlgS2RankLayer",
		pkgPath = "ui/newSlg/newSlg",
		isFullScreen = true,
		pkgName = "newSlg"
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.NewSlgConst
local var_0_2 = {
	[0] = g.core.const.ConstMgr.NewSlgConst.RANK_TYPE.PERSONAL_ALL,
	g.core.const.ConstMgr.NewSlgConst.RANK_TYPE.S2_ALLIANCE
}
local var_0_3 = g.core.const.ConstMgr.NewSlgConst.RANK_TYPE_ID_MAP

function NewSlgS2RankLayer:ctor()
	self:addBg("bg/bg_phb.png")

	self._compFirst = self:getChild("Comp_first")
	self._btnPreview = self:getChild("Btn_preview")

	self._btnPreview:addClickListener(handler(self, self._onClickBtnPreview))

	local var_2_0 = self._btnPreview:getSize()

	self._btnPreview:addEffect({
		name = "effect_wdzy_jiangli",
		scale = 0.66,
		localX = var_2_0.width / 2,
		localY = var_2_0.height / 2 - 6
	})

	self._compUserRank = self:getChild("Comp_userRank")
	self._compAlliRank = self:getChild("Comp_alliRank")
	self._bigTabCtrl = self:getController("bigTab")

	self._bigTabCtrl:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCtrlTabChange))

	self._tabIndex = 0
	self._emptyCtrl = self:getController("empty")

	self:getChild("ComTopBar"):setHelpId(g.const.HelpConst.HELP_TYPE.NEW_SLG_RANK2)
	self:getChild("ComTopBar"):updateTopRes()
end

function NewSlgS2RankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETRANK, handler(self, self.onS2CNewSlgGetRank), self)
	self:_sendMsg()
end

function NewSlgS2RankLayer:_sendMsg()
	g.core.network.GameNetProxy:send_C2S_NewSlg_GetRank({
		id = var_0_2[self._tabIndex],
		limit = g.core.model.User.newSlgData:getNewSlgParamsValueById(var_0_3[var_0_2[self._tabIndex]])
	})
end

function NewSlgS2RankLayer:_onCtrlTabChange()
	local var_5_0 = self._bigTabCtrl:getSelectedIndex()

	if var_5_0 == self._tabIndex then
		return
	end

	self._tabIndex = var_5_0

	self:_sendMsg()
end

function NewSlgS2RankLayer:onS2CNewSlgGetRank(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_4.limit == 1 then
		return
	end

	self._selfRank = arg_6_4.self_unit
	self._rankUnits = arg_6_4.rank_units or {}

	if #self._rankUnits > 0 then
		self._emptyCtrl:setSelectedIndex(1)
		self._compFirst:updateRankView(self._rankUnits[1], arg_6_4.id)
		self:updateKnightSpine(arg_6_4.id, self._rankUnits[1])
	else
		self._emptyCtrl:setSelectedIndex(0)
	end

	if arg_6_4.id == var_0_1.RANK_TYPE.PERSONAL_ALL then
		self._compUserRank:updateView({
			selfRank = self._selfRank,
			rankUnits = self._rankUnits
		})
	elseif arg_6_4.id == var_0_1.RANK_TYPE.S2_ALLIANCE then
		self._compAlliRank:updateView({
			selfRank = self._selfRank,
			rankUnits = self._rankUnits
		})
	end
end

function NewSlgS2RankLayer:updateKnightSpine(arg_7_1, arg_7_2)
	if arg_7_1 == 1 then
		local var_7_0 = self:getChild("knight_ph")
		local var_7_1 = require("app.view.common.KnightSpine").new({
			flash = true,
			base = true,
			snapshot = arg_7_2.user
		})

		var_7_1:setTouchable(false)
		var_7_0:removeChildren()
		var_7_0:addChild(var_7_1)
	else
		local var_7_2 = self:getChild("knight_ph")
		local var_7_3 = require("app.view.common.KnightSpine").new
		local var_7_4 = {
			flash = true,
			base = true
		}

		var_7_4.snapshot = g.common.GlobalFunc.rankUnit_param(arg_7_2.param, "NewSlgAlliRankData", true).leader_user

		local var_7_5 = require("app.view.common.KnightSpine").new(var_7_4)

		var_7_5:setTouchable(false)
		var_7_2:removeChildren()
		var_7_2:addChild(var_7_5)
	end
end

function NewSlgS2RankLayer:_onClickBtnPreview()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_RANK_AWARD_POP, {
		rankType = var_0_2[self._tabIndex]
	})
end

return NewSlgS2RankLayer

local NewSlgMoveAlliancePop = class("NewSlgMoveAlliancePop", require("app.fairyGUI.newSlg.UI_NewSlgMoveAlliancePop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgMoveAlliancePop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.NewSlgConst

function NewSlgMoveAlliancePop:ctor(arg_2_1)
	self:showAtCenter()

	arg_2_1 = arg_2_1 or {}
	self._tmpl = arg_2_1.tmpl
	self._btnCancel = self:getChild("Btn_cancel")

	self._btnCancel:addClickListener(handler(self, self._onClickBtnCancel))

	self._btnOk = self:getChild("Btn_ok")

	self._btnOk:addClickListener(handler(self, self._onClickBtnOk))

	self._txtDesc = self:getChild("Txt_desc")

	self._txtDesc:setText(g.core.lang:get(428816))

	self._txtCd = self:getChild("Txt_cd")
	self._moveStateCtrl = self:getController("move_state")

	self.m_closeGraph:addClickListener(handler(self, self.onClose))
end

function NewSlgMoveAlliancePop:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, handler(self, self._onSchedule), self)
	self:_updateView()
end

function NewSlgMoveAlliancePop:onClose()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(handler(self, self.onCloseFinish))
end

function NewSlgMoveAlliancePop:onCloseFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgMoveAlliancePop:_onSchedule(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3.key == "NewSlgMoveAlliancePop_updateLeftTime" then
		self:_updateLeftTime()
	end
end

function NewSlgMoveAlliancePop:_updateView()
	self._isEnough = true
end

function NewSlgMoveAlliancePop:onUnload()
	g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgMoveAlliancePop_updateLeftTime")
end

function NewSlgMoveAlliancePop:_updateLeftTime()
	local var_9_0 = g.core.model.User.newSlgData:getMoveHomeFreeTime()

	if (g.core.model.User.newSlgData:getMyUserData().latest_move_home_time or 0) > 0 then
		var_9_0 = 0
	end

	local var_9_1 = g.core.model.User.newSlgData:getMoveHomeCDTime()

	if (var_9_0 > 0 and var_9_0 or var_9_1) > 0 then
		local var_9_2 = g.core.common.ServerTime:secondToHMSString(var_9_0 > 0 and var_9_0 or var_9_1)

		self._txtCd:setText((var_9_0 > 0 or nil) and (g.core.lang:get(428803, {
			time = var_9_2
		}) or g.core.lang:get(428802, {
			time = var_9_2
		})))
	else
		g.core.utils.Tools.newSlgFunc.removeSchedule("NewSlgMoveAlliancePop_updateLeftTime")
		self._moveStateCtrl:setSelectedIndex(0)
	end
end

function NewSlgMoveAlliancePop:_onClickBtnCancel()
	self:dispatchCompEvent("NewSlgMainLayer_hideAllUI")
	self:dispatchCompEvent("NewSlg_jumpToPos", {
		pos = cc.p(self._tmpl.anchor_x, self._tmpl.anchor_y)
	})
	g.core.module.ModuleManager:popComponent()
end

function NewSlgMoveAlliancePop:_onClickBtnOk()
	if self._isEnough then
		if not g.core.model.User.newSlgData:isAllTeamIdle() then
			g.core.module.ModuleManager:tip(g.core.lang:get(428806))
		else
			self:dispatchCompEvent("NewSlgMainLayer_hideAllUI")
			g.core.network.GameNetProxy:send_C2S_NewSlg_MoveHomeAllianceProvince({})
			g.core.module.ModuleManager:popComponent()
		end
	else
		local var_11_0 = {}

		var_11_0.name = g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_ITEM,
			value = var_0_1.MOVE_HOME_ITEM_ID
		}).info.name

		g.core.module.ModuleManager:tip(g.core.lang:get(428998, var_11_0))
	end
end

return NewSlgMoveAlliancePop

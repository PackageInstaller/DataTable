local NewSlgS2AchievePop = class("NewSlgS2AchievePop", function()
	return fgui.GComponent:create({
		resName = "NewSlgS2AchievePop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum

function NewSlgS2AchievePop:ctor()
	self:getView():center(true)
	self:getChild("ComPopPanel"):setHelpId(477)

	self._listAchievement = self:getChild("List_achievement")

	self._listAchievement:setVirtual(self)
	self._listAchievement:setItemRenderer(handler(self, self._onRenderListAchievementCell))

	self._tabCtrl = self:getController("tab")

	self._tabCtrl:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCtrlTabChange))

	self._tabIndex = 0
end

function NewSlgS2AchievePop:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_USERACHIEVEMENTNTF, handler(self, self._updateView), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_ONEKEYOBTAINREWARDS, handler(self, self._onObtainAwards), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_OBTAINQUESTREWARD, handler(self, self._onObtainAwards), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_SYNCCITYQUESTPROGRESS, handler(self, self._updateView), self)
	self:_updateView()
end

function NewSlgS2AchievePop:receiveCompEvent(arg_4_1, arg_4_2)
	if arg_4_1 == "NewSlgS2AchieveCell_onClickBtnGet" then
		g.core.network.GameNetProxy:send_C2S_NewSlg_ObtainQuestReward({
			id = arg_4_2.id
		})
	elseif arg_4_1 == "NewSlgS2AchieveCell_onClickBtnRoute" then
		if arg_4_2.routeId > 0 then
			g.view.entrance.ModuleGotoProxy:gotoModule(arg_4_2.routeId)
		end
	end
end

function NewSlgS2AchievePop:_onCtrlTabChange()
	local var_5_0 = self._tabCtrl:getSelectedIndex()

	if var_5_0 == self._tabIndex then
		return
	end

	self._tabIndex = var_5_0

	self:_updateView()
end

function NewSlgS2AchievePop:_updateView()
	self._taskArr = g.core.model.User.newSlgData:getAchievementDataArrByType(self._tabIndex + 1)

	self._listAchievement:setNumItems(#self._taskArr)
end

function NewSlgS2AchievePop:_onObtainAwards(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_7_4.awards, true)
	end

	self:_updateView()
end

function NewSlgS2AchievePop:_onRenderListAchievementCell(arg_8_1, arg_8_2)
	arg_8_2:updateCell(self._taskArr[arg_8_1 + 1])
end

return NewSlgS2AchievePop

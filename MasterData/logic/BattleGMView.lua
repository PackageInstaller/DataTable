-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleGMView.lua

module("logic.extensions.battle.view.BattleGMView", package.seeall)

local BattleGMView = class("BattleGMView", ViewComponent)

function BattleGMView:ctor()
	BattleGMView.super.ctor(self)
end

function BattleGMView:destroyUI()
	BattleGMView.super.destroyUI(self)
end

function BattleGMView:onExitFinished()
	BattleGMView.super.onExitFinished(self)
end

function BattleGMView:onEnterFinished()
	BattleGMView.super.onEnterFinished(self)
end

function BattleGMView:unbindEvents()
	BattleGMView.super.unbindEvents(self)
	self._btnHp:RemoveClickListener()
	self._btnVigour:RemoveClickListener()
	self._btnSwitch:RemoveClickListener()
end

function BattleGMView:bindEvents()
	BattleGMView.super.bindEvents(self)
	self._btnHp:AddClickListener(self._onClickHp, self)
	self._btnVigour:AddClickListener(self._onClickVigour, self)
	self._btnSwitch:AddClickListener(self._onClickSwitch, self)
end

function BattleGMView:onExit()
	BattleGMView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ActiveBattleGM, self._onActive, self)
end

function BattleGMView:buildUI()
	BattleGMView.super.buildUI(self)

	local go = self:getGo("GM")

	self._inputHp = goutil.findChildComponent(go, "Input_Hp", typeof(UnityEngine.UI.InputField))
	self._inputVigour = goutil.findChildComponent(go, "Input_Vigour", typeof(UnityEngine.UI.InputField))
	self._btnHp = Framework.ButtonAdapter.GetFrom(go, "Button_Hp")
	self._btnVigour = Framework.ButtonAdapter.GetFrom(go, "Button_Vigour")
	self._btnSwitch = Framework.ButtonAdapter.GetFrom(go, "Button_Switch")
	self._checkMark = goutil.findChild(self._btnSwitch.gameObject, "Background/Checkmark")
	self._go = go
end

function BattleGMView:onEnter()
	BattleGMView.super.onEnter(self)
	self._go:SetActive(Framework.OSDef.isEditor and GMController.instance:isOpenBattleGMView())

	self._isCheck = Framework.LocalStorage.Instance:GetInt("Battle_Data_Check_Switch", 0) ~= 0

	self._checkMark:SetActive(self._isCheck)
	GlobalDispatcher:addListener(GlobalNotify.ActiveBattleGM, self._onActive, self)
end

function BattleGMView:_onActive()
	self._go:SetActive(GMController.instance:isOpenBattleGMView())
end

function BattleGMView:_onClickHp()
	local text = checknumber(self._inputHp.text)
	local prefix = "全体精灵血量"

	if checknumber(self._inputHp.text) > 0 then
		prefix = prefix .. "+"
	end

	if text == 0 then
		return
	end

	FloatWordMgr.instance:show(prefix .. text)
	GlobalDispatcher:dispatch(GlobalNotify.ManualSetBattlePetStatus, {
		"HP",
		checknumber(text)
	})
end

function BattleGMView:_onClickVigour()
	local text = checknumber(self._inputVigour.text)
	local prefix = "全体精灵气势"

	if checknumber(self._inputVigour.text) > 0 then
		prefix = prefix .. "+"
	end

	if text == 0 then
		return
	end

	FloatWordMgr.instance:show(prefix .. text)
	GlobalDispatcher:dispatch(GlobalNotify.ManualSetBattlePetStatus, {
		"VIGOUR",
		checknumber(text)
	})
end

function BattleGMView:_onClickSwitch()
	self._isCheck = not self._isCheck

	self._checkMark:SetActive(self._isCheck)

	if self._isCheck then
		FloatWordMgr.instance:show("开启数据校验")
	else
		FloatWordMgr.instance:show("关闭数据校验")
	end

	Framework.LocalStorage.Instance:SetInt("Battle_Data_Check_Switch", self._isCheck and 1 or 0)
end

return BattleGMView

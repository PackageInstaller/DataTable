-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleSysSettingView.lua

module("logic.extensions.battle.view.BattleSysSettingView", package.seeall)

local BattleSysSettingView = class("BattleSysSettingView", ViewComponent)
local TAB_DESCRIPTION = 1
local TAB_SETTING = 2

function BattleSysSettingView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._lowDetails:AddClickListener(function()
		self:_setDetails(BattleModel.InfoType_Hp_None)
	end)
	self._midDetails:AddClickListener(function()
		self:_setDetails(BattleModel.InfoType_Hp_Vigour)
	end)
	self._highDetails:AddClickListener(function()
		self:_setDetails(BattleModel.InfoType_Hp_Vigour_Attr_Name_Level)
	end)
	self._btnSkipUtlSkill:AddClickListener(self._onClickSkipUtlSkill, self)
	self._btnDes:AddClickListener(function()
		self:onClickSwitch(TAB_DESCRIPTION)
	end, self)
	self._btnSet:AddClickListener(function()
		self:onClickSwitch(TAB_SETTING)
	end, self)
	self._btnSkipSkillShenyao:AddClickListener(self._onClickSkipShenyaoSkill, self)
end

function BattleSysSettingView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._lowDetails:RemoveClickListener()
	self._midDetails:RemoveClickListener()
	self._highDetails:RemoveClickListener()
	self._btnSkipUtlSkill:RemoveClickListener()
	self._btnDes:RemoveClickListener()
	self._btnSet:RemoveClickListener()
	self._btnSkipSkillShenyao:RemoveClickListener()
end

function BattleSysSettingView:buildUI()
	self._skillNode = self:getGo("battleSetting/skill")
	self._closeButton = self:getBtn("btnClose")
	self._lowDetails = self:getBtn("battleSetting/details/low")
	self._midDetails = self:getBtn("battleSetting/details/mid")
	self._highDetails = self:getBtn("battleSetting/details/high")
	self._btnSkipUtlSkill = self:getBtn("battleSetting/skill/toggle")
	self._targets = self:getTxt("description/battleTargets/txtTips")
	self._des = self:getTxt("description/des/txtTips")
	self._btnSkipSkillShenyao = self:getBtn("battleSetting/skillShenyao/toggle")
	self._title = self:getTxt("txtTitle")
	self.description = self:getGo("description")
	self.battleSetting = self:getGo("battleSetting")
	self._DesSelectGo = self:getGo("btnDescription/select")
	self._SetSelectGo = self:getGo("btnSetting/select")
	self._DesSelectTxt = self:getTxt("btnDescription/txtName")
	self._SetSelectTxt = self:getTxt("btnSetting/txtName")
	self._btnDes = self:getBtn("btnDescription")
	self._btnSet = self:getBtn("btnSetting")
	self._lowDetailsBox = goutil.findChild(self._lowDetails.gameObject, "checkbox")
	self._midDetailsBox = goutil.findChild(self._midDetails.gameObject, "checkbox")
	self._highDetailsBox = goutil.findChild(self._highDetails.gameObject, "checkbox")
	self._utlSkillCheckBox = goutil.findChild(self._btnSkipUtlSkill.gameObject, "checkbox")
	self._skillShenyaoCheckBox = goutil.findChild(self._btnSkipSkillShenyao.gameObject, "checkbox")
end

function BattleSysSettingView:destroyUI()
	return
end

function BattleSysSettingView:onEnter()
	if not BattleModel.instance.pauseBattle then
		BattleController.instance:pauseAll(true)

		self._isPaused = true
	end

	self:_refreshTabs()
end

function BattleSysSettingView:refreshAll()
	goutil.setActive(self.description, self.curSelect == TAB_DESCRIPTION)
	goutil.setActive(self.battleSetting, self.curSelect == TAB_SETTING)
	goutil.setActive(self._DesSelectGo, self.curSelect == TAB_DESCRIPTION)
	goutil.setActive(self._SetSelectGo, self.curSelect == TAB_SETTING)

	if self.curSelect == TAB_DESCRIPTION then
		self:_updateTargets()
		self:_refreshDescription()

		self._title.text = "关卡说明"
		self._DesSelectTxt.color = Color.New(1, 1, 1, 1)
		self._SetSelectTxt.color = Color.New(0.1411764705882353, 0.19215686274509805, 0.32941176470588235, 1)
	elseif self.curSelect == TAB_SETTING then
		self:_refreshSkipUtlSkill()
		self:_refreshSkipShenyaoSkill()
		self:_refreshDetails()

		self._title.text = "战斗设置"
		self._DesSelectTxt.color = Color.New(0.1411764705882353, 0.19215686274509805, 0.32941176470588235, 1)
		self._SetSelectTxt.color = Color.New(1, 1, 1, 1)
	end
end

function BattleSysSettingView:_refreshTabs()
	if BattleModel.instance.isPkBattle then
		self._btnDes.gameObject:SetActive(false)
		Framework.TransformUtil.SetLocalPos(self._btnSet.transform, -348, 120, 0)
		self:onClickSwitch(TAB_SETTING)
	else
		self._btnDes.gameObject:SetActive(true)
		Framework.TransformUtil.SetLocalPos(self._btnSet.transform, -348, 38, 0)
		self:onClickSwitch(TAB_SETTING)
	end
end

function BattleSysSettingView:onEnterFinished()
	return
end

function BattleSysSettingView:onExit()
	return
end

function BattleSysSettingView:onClickSwitch(selection)
	self.curSelect = selection

	self:refreshAll()
end

function BattleSysSettingView:onExitFinished()
	if self._isPaused then
		self._isPaused = nil

		BattleController.instance:pauseAll(false)
	end
end

function BattleSysSettingView:_refreshDetails()
	local detail = BattleModel.instance:getBtlInfoType()

	goutil.setActive(self._lowDetailsBox, detail == 1)
	goutil.setActive(self._midDetailsBox, detail == 2)
	goutil.setActive(self._highDetailsBox, detail == 3)
end

function BattleSysSettingView:_refreshSkipUtlSkill()
	local skip = BattleModel.instance:getAutoSkipUtilSkill()

	goutil.setActive(self._utlSkillCheckBox, skip)
end

function BattleSysSettingView:_setDetails(detail)
	if detail == BattleModel.instance:getAutoSkipUtilSkill() then
		return
	end

	BattleModel.instance:saveBtlInfoType(detail)
	BattleController.instance:updateUnitBattleInfoType()
	self:_refreshDetails()
end

function BattleSysSettingView:_onClickClose()
	self:close()
end

function BattleSysSettingView:_refreshSkipShenyaoSkill()
	local skip = BattleModel.instance:getAutoSkipShenyaoSkill()

	goutil.setActive(self._skillShenyaoCheckBox, skip)
end

function BattleSysSettingView:_onClickSkipShenyaoSkill()
	local skip = BattleModel.instance:getAutoSkipShenyaoSkill()

	BattleModel.instance:setAutoSkipShenyaoSkill(not skip)
	self:_refreshSkipShenyaoSkill()
end

function BattleSysSettingView:_onClickSkipUtlSkill()
	local skip = BattleModel.instance:getAutoSkipUtilSkill()

	BattleModel.instance:setAutoSkipUtilSkill(not skip)
	self:_refreshSkipUtlSkill()
end

function BattleSysSettingView:_refreshDescription()
	local commonRule, perfectRuleTxt = MissionModel.instance:getRuleDesc()

	if string.nilorempty(commonRule) then
		commonRule = "无"
	end

	if string.nilorempty(perfectRuleTxt) then
		perfectRuleTxt = "无完美通关条件"
	end

	self._des.text = "<color=#466887>" .. commonRule .. "</color>"
	self._targets.text = "<color=#466887>" .. perfectRuleTxt .. "</color>"
end

function BattleSysSettingView:_updateTargets()
	return
end

return BattleSysSettingView

local PolyhedronCampAddPopView = class("PolyhedronCampAddPopView", ReduxView)

function PolyhedronCampAddPopView:UIName()
	return "Widget/System/PolyhedronBattle/PolyhedronCampAddPopUI"
end

function PolyhedronCampAddPopView:UIParent()
	return manager.ui.uiPop.transform
end

function PolyhedronCampAddPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronCampAddPopView:InitUI()
	self:BindCfgUI()
end

function PolyhedronCampAddPopView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)

	self.heroController_ = ControllerUtil.GetController(self.heroGo_.transform, "name")
	self.fightController_ = ControllerUtil.GetController(self.fightingGo_.transform, "name")
end

function PolyhedronCampAddPopView:OnEnter()
	self.heroList = self.params_.heroIdList

	local var_7_0, var_7_1, var_7_2 = PolyhedronTools.GetRaceEffect(self.heroList)

	self.heroController_:SetSelectedState(var_7_0 ~= 0 and "on" or "off")
	self.fightController_:SetSelectedState(var_7_1 and "on" or "off")

	self.text1Text_.text = var_7_0 ~= 0 and GetI18NText(RaceEffectCfg[var_7_0].desc) or GetTips("NO_CORRECTOR_BUFF")
	self.text2Text_.text = var_7_1 and GetI18NText(RaceEffectCfg[var_7_0].battle_desc) or GetTips("NO_BATTLE_BUFF")
end

return PolyhedronCampAddPopView

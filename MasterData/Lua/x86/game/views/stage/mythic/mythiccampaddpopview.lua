local MythicCampAddPopView = class("MythicCampAddPopView", ReduxView)

function MythicCampAddPopView:UIName()
	return "Widget/System/Challenge_Mythic/MythicGodUpUI"
end

function MythicCampAddPopView:UIParent()
	return manager.ui.uiPop.transform
end

function MythicCampAddPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MythicCampAddPopView:InitUI()
	self:BindCfgUI()
end

function MythicCampAddPopView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)

	self.heroController_ = ControllerUtil.GetController(self.heroGo_.transform, "name")
	self.fightController_ = ControllerUtil.GetController(self.fightingGo_.transform, "name")
end

function MythicCampAddPopView:GetRaceEffect()
	local var_7_0 = {}
	local var_7_1 = 0
	local var_7_2 = false

	for iter_7_0, iter_7_1 in pairs((ReserveTools.GetHeroList((ReserveParams.New(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, self.teamID_))))) do
		if iter_7_1 ~= 0 then
			var_7_0[HeroCfg[iter_7_1].race] = (var_7_0[HeroCfg[iter_7_1].race] or 0) + 1

			if var_7_0[HeroCfg[iter_7_1].race] == 2 then
				var_7_1 = HeroCfg[iter_7_1].race
			elseif var_7_0[HeroCfg[iter_7_1].race] == 3 then
				var_7_2 = true
			end
		end
	end

	return var_7_1, var_7_2, var_7_0[var_7_1] or 1
end

function MythicCampAddPopView:RefreshRace()
	local var_8_0, var_8_1, var_8_2 = self:GetRaceEffect()

	self.heroController_:SetSelectedState(var_8_0 ~= 0 and "on" or "off")
	self.fightController_:SetSelectedState(var_8_1 and "on" or "off")

	self.text1Text_.text = var_8_0 ~= 0 and GetI18NText(RaceEffectCfg[var_8_0].desc) or GetTips("NO_CORRECTOR_BUFF")
	self.text2Text_.text = var_8_1 and GetI18NText(RaceEffectCfg[var_8_0].battle_desc) or GetTips("NO_BATTLE_BUFF")
end

function MythicCampAddPopView:OnEnter()
	self.teamID_ = self.params_.teamID

	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	self:RefreshRace()
end

function MythicCampAddPopView:OnExit()
	manager.windowBar:HideBar()
end

function MythicCampAddPopView:Dispose()
	MythicCampAddPopView.super.Dispose(self)
end

return MythicCampAddPopView

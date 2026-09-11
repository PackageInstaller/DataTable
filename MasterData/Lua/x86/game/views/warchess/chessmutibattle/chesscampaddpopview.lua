local ChessCampAddPopView = class("ChessCampAddPopView", ReduxView)

function ChessCampAddPopView:UIName()
	return "Widget/System/WarChess_Battle/WarChessGodUpUI"
end

function ChessCampAddPopView:UIParent()
	return manager.ui.uiPop.transform
end

function ChessCampAddPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessCampAddPopView:InitUI()
	self:BindCfgUI()
end

function ChessCampAddPopView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)

	self.heroController_ = ControllerUtil.GetController(self.heroGo_.transform, "name")
	self.fightController_ = ControllerUtil.GetController(self.fightingGo_.transform, "name")
end

function ChessCampAddPopView:GetRaceEffect()
	local var_7_0 = {}
	local var_7_1 = 0
	local var_7_2 = false

	for iter_7_0, iter_7_1 in pairs((ReserveTools.GetHeroList(self.reserveParams_))) do
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

function ChessCampAddPopView:RefreshRace()
	local var_8_0, var_8_1, var_8_2 = self:GetRaceEffect()

	self.heroController_:SetSelectedState(var_8_0 ~= 0 and "on" or "off")
	self.fightController_:SetSelectedState(var_8_1 and "on" or "off")

	self.text1Text_.text = var_8_0 ~= 0 and GetI18NText(RaceEffectCfg[var_8_0].desc) or GetTips("NO_CORRECTOR_BUFF")
	self.text2Text_.text = var_8_1 and GetI18NText(RaceEffectCfg[var_8_0].battle_desc) or GetTips("NO_BATTLE_BUFF")
end

function ChessCampAddPopView:OnEnter()
	self.reserveParams_ = self.params_.reserveParams

	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	self:RefreshRace()
end

function ChessCampAddPopView:OnExit()
	manager.windowBar:HideBar()
end

function ChessCampAddPopView:Dispose()
	ChessCampAddPopView.super.Dispose(self)
end

return ChessCampAddPopView

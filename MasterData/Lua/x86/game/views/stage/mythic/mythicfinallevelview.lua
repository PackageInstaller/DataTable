local MythicFinalLevelView = class("MythicFinalLevelView", ReduxView)

function MythicFinalLevelView:UIName()
	return "Widget/System/Challenge_Mythic/MythicChooseDifficlutPopUI"
end

function MythicFinalLevelView:UIParent()
	return manager.ui.uiMain.transform
end

function MythicFinalLevelView:Init()
	self:BindCfgUI()

	self.controller_ = self.controllerEx_:GetController("status")

	self:AddUIListeners()
end

function MythicFinalLevelView:OnEnter()
	self:RefreshUI()
	manager.windowBar:HideBar()
end

function MythicFinalLevelView:AddUIListeners()
	self:AddBtnListener(self.nextbtn_, nil, function()
		MythicData:SubLevel(1)
	end)
	self:AddBtnListener(self.exnextbtn_, nil, function()
		MythicData:SetCurHotLevelIdMax()
	end)
	self:AddBtnListener(self.frontbtn_, nil, function()
		MythicData:SubLevel(-1)
	end)
	self:AddBtnListener(self.exfrontbtn_, nil, function()
		MythicAction:SelectLevel(1)
	end)
	self:AddBtnListener(self.battlebtn_, nil, function()
		local var_10_0 = MythicData:GetCurLevelIdList()

		if #var_10_0 > 1 then
			gameContext:Go("/mythicFinalTeamView")
		else
			self:Go("/sectionSelectHero", {
				section = var_10_0[1],
				sectionType = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL
			})
		end
	end)
	self:AddBtnListener(self.backbtn_, nil, function()
		self:Back()
	end)
end

function MythicFinalLevelView:OnMythicFinalHotItemClick()
	self:RefreshUI()
end

function MythicFinalLevelView:RefreshUI()
	self.curleveltext_.text = MythicData:GetCurHotLevelId()
	self.leveltext_.text = string.format("<color=#FF9500>%s</color>/%s", MythicData:GetLevelMax(), #MythicFinalCfg.all)
	self.teamtext_.text = MythicFinalCfg[MythicData:GetCurHotLevelId()].team_num

	local var_13_0 = BattleMythicFinalCfg[MythicData:GetCurLevelIdList()[1]]

	self.nametext_.text = var_13_0.name
	self.destext_.text = var_13_0.tips
	self.bgimage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_13_0.background_1))

	self.controller_:SetSelectedState(MythicData:GetLevelStatus())
end

function MythicFinalLevelView:Dispose()
	MythicFinalLevelView.super.Dispose(self)
end

return MythicFinalLevelView

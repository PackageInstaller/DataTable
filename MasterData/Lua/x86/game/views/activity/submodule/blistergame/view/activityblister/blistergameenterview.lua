local BlisterGameEnterView = class("BlisterGameEnterView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function BlisterGameEnterView:GetUIName()
	return "Widget/Version/Alone_Summer2024_BlisterGame/Alone_BlisterGameMainUI"
end

function BlisterGameEnterView:Init()
	self:InitUI()
	self:AddListeners()
end

function BlisterGameEnterView:InitUI()
	self:BindCfgUI()
end

function BlisterGameEnterView:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/blisterGame_4_3", {
			activityID = ActivityConst.ACTIVITY_BLISTER_4_3
		})
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			key = "ACTIVITY_BLISTER_DESCRIPE",
			content = GetTips("ACTIVITY_BLISTER_DESCRIPE")
		})
	end)
end

function BlisterGameEnterView:OnEnter()
	BlisterGameEnterView.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.goBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_COMMON, ActivityConst.ACTIVITY_BLISTER_4_3))
end

function BlisterGameEnterView:OnExit()
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_COMMON, ActivityConst.ACTIVITY_BLISTER_4_3))
	BlisterGameEnterView.super.OnExit(self)
end

return BlisterGameEnterView

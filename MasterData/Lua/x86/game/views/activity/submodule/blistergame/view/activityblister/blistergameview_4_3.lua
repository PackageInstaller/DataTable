BlisterGameView = import("game.views.activity.Submodule.BlisterGame.View.BlisterGameView")

local BlisterGameView_4_3 = class("BlisterGameView_4_3", BlisterGameView)

function BlisterGameView_4_3:UIName()
	return "Widget/Version/Alone_Summer2024_BlisterGame/Alone_BlisterGame01"
end

function BlisterGameView_4_3:AddListeners()
	self:AddBtnListener(self.taskbtnBtn_, nil, "OnTask")

	for iter_2_0 = 1, 2 do
		self:AddBtnListener(self[string.format("nextbtn0%sBtn_", iter_2_0)], nil, function()
			if self.nowIndex == iter_2_0 then
				return
			end

			self:ChangeTab(iter_2_0)
		end)
	end

	self:AddBtnListener(self.maskBtn_, nil, function()
		if gameContext:IsOpenRoute("blisterChapterSectionInfo_4_3") then
			JumpTools.Back(1)
			SetActive(self.maskBtn_.gameObject, false)
		end
	end)
end

function BlisterGameView_4_3:OnEnter()
	BlisterGameData:SetActivityId(ActivityConst.ACTIVITY_BLISTER_4_3)
	BlisterGameView_4_3.super.OnEnter(self)
	self:RegistEventListener(BLISTERGAME_STAGE_INFO, function()
		SetActive(self.maskBtn_.gameObject, true)
	end)
end

function BlisterGameView_4_3:ChangeBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_BLISTER_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back(1)
		SetActive(self.maskBtn_.gameObject, false)
	end)
end

function BlisterGameView_4_3:OnExit()
	self.super.OnExit(self)
	SetActive(self.maskBtn_.gameObject, false)
end

function BlisterGameView_4_3:OnTask()
	JumpTools.OpenPageByJump("blisterTaskView", {
		taskActivityID = ActivityConst.ACTIVITY_BLISTER_TASK_4_3
	})
end

return BlisterGameView_4_3

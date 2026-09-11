ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local XuHeng3rdDemonHomeView = class("XuHeng3rdDemonHomeView", ActivityMainBasePanel)

function XuHeng3rdDemonHomeView:GetUIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdMindDemonUI/XuHeng3rdDemonUI"
end

function XuHeng3rdDemonHomeView:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function XuHeng3rdDemonHomeView:AddUIListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		JumpTools.OpenPageByJump("/xuHeng3rddreamDemonChallengeMain", {
			activityId = self.activityID_
		})
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_DEMON_CHALLENGE_DESCRIPE_2_2",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_DEMON_CHALLENGE_DESCRIPE_2_2")
		})
	end)
end

function XuHeng3rdDemonHomeView:Dispose()
	XuHeng3rdDemonHomeView.super.Dispose(self)
end

function XuHeng3rdDemonHomeView:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)

	if arg_7_1 == true then
		manager.redPoint:bindUIandKey(self.playBtnTrans_, string.format("%s_%s", RedPointConst.DEMON_CHALLENGE, self.activityID_))
		self:RegistEventListener(OSIRIS_TASK_UPDATE, self.taskUpdateHandler_)
	else
		manager.redPoint:unbindUIandKey(self.playBtnTrans_, string.format("%s_%s", RedPointConst.DEMON_CHALLENGE, self.activityID_))
		self:RemoveAllEventListener()
	end
end

function XuHeng3rdDemonHomeView:RefreshUI()
	return
end

function XuHeng3rdDemonHomeView:RefreshTimeText()
	if self.timeText_ then
		self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
	end
end

return XuHeng3rdDemonHomeView

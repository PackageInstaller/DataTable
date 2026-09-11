local GuildImpeachTipsView = class("GuildImpeachTipsView", ReduxView)

function GuildImpeachTipsView:UIName()
	return "Widget/System/Club/ClubImpeachTips"
end

function GuildImpeachTipsView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildImpeachTipsView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function GuildImpeachTipsView:OnEnter()
	self:AddImpeachTimer()
	GuildData:SetImpeachFlag()
end

function GuildImpeachTipsView:OnExit()
	self:StopImpeahTimer()
end

function GuildImpeachTipsView:Dispose()
	GuildImpeachTipsView.super.Dispose(self)
end

function GuildImpeachTipsView:AddListeners()
	self:AddBtnListener(self.buttonClose_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.buttonCancel_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.buttonOk_, nil, function()
		GuildAction.GuildCancelImpeach(function(arg_11_0)
			if isSuccess(arg_11_0.result) then
				self:Back()
			else
				ShowTips(arg_11_0.result)
			end
		end)
	end)
end

function GuildImpeachTipsView:AddImpeachTimer()
	local var_12_0 = GuildData:GetGuildInfo()
	local var_12_1 = GetTips("CLUB_IMPEACH_CD")

	self.textCountdown_.text = string.format("%s%s", var_12_1, manager.time:DescCDTime(var_12_0.impeachTime - manager.time:GetServerTime(), "%H:%M:%S"))
	self.impeachTimer_ = Timer.New(function()
		local var_13_0 = var_12_0.impeachTime - manager.time:GetServerTime()

		self.textCountdown_.text = string.format("%s%s", var_12_1, manager.time:DescCDTime(var_13_0, "%H:%M:%S"))

		if var_13_0 <= 0 then
			self:StopImpeahTimer()
			manager.redPoint:setTip(RedPointConst.GUILD_IMPEACH, 0)
			GuildAction.RequiredGuildMemberList(function()
				return
			end)
			self:Back()
		end
	end, 1, -1)

	self.impeachTimer_:Start()
end

function GuildImpeachTipsView:StopImpeahTimer()
	if self.impeachTimer_ then
		self.impeachTimer_:Stop()

		self.impeachTimer_ = nil
	end
end

return GuildImpeachTipsView

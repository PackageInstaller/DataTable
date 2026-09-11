local DormLinkGameFailView = class("DormLinkGameFailView", ReduxView)

function DormLinkGameFailView:UIName()
	return "Widget/Version/Alone_LinkGame/Alone_LGPlayResult2"
end

function DormLinkGameFailView:UIParent()
	return manager.ui.uiMain.transform
end

function DormLinkGameFailView:OnCtor()
	return
end

function DormLinkGameFailView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormLinkGameFailView:InitUI()
	self:BindCfgUI()
end

local function var_0_1(arg_6_0)
	local var_6_0, var_6_1, var_6_2 = DormLinkGameTools:ChecklevelUnLock(arg_6_0)

	if var_6_0 then
		return nil
	else
		if var_6_1 == DormLinkGameConst.LevelLockType.time then
			return GetOpenTimeTips(ActivityData:GetActivityData(ActivityLinkGameCfg[arg_6_0].activity_id).startTime)
		elseif var_6_1 == DormLinkGameConst.LevelLockType.stop then
			return "TIME_OVER"
		elseif var_6_1 == DormLinkGameConst.LevelLockType.preLevel then
			return GetLevelNeedUnlockTips(arg_6_0)
		end

		return ""
	end
end

function DormLinkGameFailView:AddUIListener()
	self:AddBtnListenerScale(self.restartBtn_, nil, function()
		local var_8_0 = var_0_1(DormLinkGameData:GetCurLevelID())

		if var_8_0 == nil then
			DormLinkGameData:ResetRunGameInfo()
			manager.notify:Invoke(LIANLIANKAN_GAME_RESET)
			JumpTools.OpenPageByJump("/dormLinkGamePlayView")
		else
			ShowTips(var_8_0)
		end
	end)
	self:AddBtnListenerScale(self.backBtn_, nil, function()
		DormLinkGameTools:ExitGame()
	end)
end

function DormLinkGameFailView:OnEnter()
	return
end

function DormLinkGameFailView:OnExit()
	return
end

function DormLinkGameFailView:Dispose()
	DormLinkGameFailView.super.Dispose(self)
end

return DormLinkGameFailView

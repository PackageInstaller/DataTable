local AutoChessHeadItemView = class("AutoChessHeadItemView", ReduxView)

function AutoChessHeadItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.gameType_ = arg_1_2

	self:Init()
end

function AutoChessHeadItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AutoChessHeadItemView:InitUI()
	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.title_.text = self.gameType_ == AutoChessConst.GAME_TYPE.PVE and ((AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 or AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_5_0) and GetTips("AUTO_CHESS_2_VS_TITLE") or GetTips("AUTO_CHESS_PVE_ENTRANCE")) or GetTips("AUTO_CHESS_PVP_ENTRANCE")
end

function AutoChessHeadItemView:RefreshUI()
	self.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
end

function AutoChessHeadItemView:AddUIListener()
	self.commonPortrait_:RegisteClickCallback(handler(self, self.OnClickBackCall))
end

function AutoChessHeadItemView:OnClickBackCall()
	if self.gameType_ == AutoChessConst.GAME_TYPE.PVE then
		OperationRecorder.RecordButtonTouch({
			source = 2,
			button_name = "activity_autochess_headshots_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	else
		OperationRecorder.RecordButtonTouch({
			source = 3,
			button_name = "activity_autochess_headshots_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	end

	JumpTools.OpenPageByJump("autoChessHeadTipsPopView", {
		type = 2
	})
end

function AutoChessHeadItemView:Dispose()
	self.commonPortrait_:Dispose()
	AutoChessHeadItemView.super.Dispose(self)
end

return AutoChessHeadItemView

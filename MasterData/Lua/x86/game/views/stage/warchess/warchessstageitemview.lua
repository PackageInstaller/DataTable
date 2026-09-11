local WarChessStageItemView = class("WarChessStageItemView", ReduxView)

function WarChessStageItemView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.chapterClientID_ = arg_1_3
	self.transform_.name = arg_1_3

	self:InitUI()
	self:AddListeners()
end

function WarChessStageItemView:OnEnter()
	self:RefrshData()

	if WarChessData:GetCurrentChapter(0) == self.chapterClientID_ then
		self.controller_:SetSelectedState("Exploring")
	elseif self.isLock_ then
		self.controller_:SetSelectedState("Lock")
	else
		self.controller_:SetSelectedState("Explored")
	end

	self:RefreshName()
	self:RefreshProgress()
	self:RefreshBg()
	self:BindRedPointUI()
end

function WarChessStageItemView:Show(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

function WarChessStageItemView:BindRedPointUI()
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.WAR_CHESS_NEW_LEVEL + self.chapterClientID_)
end

function WarChessStageItemView:UnbindRedPointUI()
	manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.WAR_CHESS_NEW_LEVEL + self.chapterClientID_)
end

function WarChessStageItemView:OnExit()
	self:Show(false)
	self:UnbindRedPointUI()
end

function WarChessStageItemView:Dispose()
	self:RemoveListeners()
	WarChessStageItemView.super.Dispose(self)

	self.chapterPaint_.sprite = nil

	Object.Destroy(self.gameObject_)

	self.btn_ = nil
	self.chapterPaint_ = nil
	self.chapterName_ = nil
	self.lockGo_ = nil
	self.gameObject_ = nil
	self.transform_ = nil
end

function WarChessStageItemView:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.transform_, "con")
end

function WarChessStageItemView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		self:ClickItemListener()
	end)
end

function WarChessStageItemView:ClickItemListener()
	if self.isLock_ and WarChessData:GetCurrentChapter(0) ~= self.chapterClientID_ then
		ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), ChapterClientCfg[self.chapterClientID_].level))

		return
	end

	self:ClickItem(self.chapterClientID_)
end

function WarChessStageItemView:RemoveListeners()
	self.btn_.onClick:RemoveAllListeners()
end

function WarChessStageItemView:RefrshData()
	self:IsNotice()
	self:IsLock()
end

function WarChessStageItemView:RefreshBg()
	self.chapterPaint_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WarChess_Stage/" .. ChapterClientCfg[self.chapterClientID_].chapter_paint)
end

function WarChessStageItemView:IsLock()
	self.isLock_ = PlayerData:GetPlayerInfo().userLevel < ChapterClientCfg[self.chapterClientID_].level
end

function WarChessStageItemView:IsNotice()
	self.notice_ = false
end

function WarChessStageItemView:RefreshName()
	if not ChapterClientCfg[self.chapterClientID_] then
		return
	end

	self.chapterName_.text = GetI18NText(ChapterClientCfg[self.chapterClientID_].name)
end

function WarChessStageItemView:GetChapterClientID()
	return self.chapterClientID_
end

function WarChessStageItemView:RefreshProgress()
	self.progressText_.text = ChessTools.GetChapterProgress(self.chapterClientID_) .. "%"
	self.progressbarImg_.fillAmount = ChessTools.GetChapterProgress(self.chapterClientID_) / 100
end

function WarChessStageItemView:ClickItem(arg_20_1)
	manager.redPoint:setTip(RedPointConst.WAR_CHESS_NEW_LEVEL + self.chapterClientID_, 0, RedPointStyle.SHOW_NEW_TAG)
	RedPointAction.HandleRedPoint(RedPointConst.WAR_CHESS_NEW_LEVEL + self.chapterClientID_)
	ChessTools.EnterChessMap(arg_20_1)
end

return WarChessStageItemView

local ChapterDemoItem = class("ChapterDemoItem", ReduxView)

function ChapterDemoItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChapterDemoItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChapterDemoItem:InitUI()
	self:BindCfgUI()
end

function ChapterDemoItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		self:ClickItemListener()
	end)
end

function ChapterDemoItem:SetData(arg_6_1)
	self.chapterClientID_ = arg_6_1

	if not ChapterClientCfg[self.chapterClientID_] then
		return
	end

	self.chapterName_.text = GetI18NText(ChapterClientCfg[self.chapterClientID_].name)

	SetSpriteWithoutAtlasAsync(self.chapterPaint_, SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[self.chapterClientID_].chapter_paint)

	if self.chapterClientID_ == 601 then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.COOPERATION_DEMO)
	end

	if self:IsLock() then
		SetActive(self.lockGo_, true)
	else
		SetActive(self.lockGo_, false)
	end

	if self:GetLostTimeStr() == nil then
		SetActive(self.openGo_, false)
	else
		self:RefrenTime()
		SetActive(self.openGo_, true)
	end
end

function ChapterDemoItem:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.transform_)
end

function ChapterDemoItem:ClickItemListener()
	if self:IsLock(true) then
		return
	end

	if self.chapterClientID_ == 601 and ActivityTools.GetActivityIsOpenWithTip(ActivityConst.COOPERATION_DEMO, true) then
		JumpTools.GoToSystem("/cooperationBlank/demoCooperationEntry")
	end
end

function ChapterDemoItem:RefrenTime()
	local var_9_0 = self:GetLostTimeStr()

	self.openText_.text = var_9_0 and var_9_0 or ""
end

function ChapterDemoItem:GetLostTimeStr()
	if self.chapterClientID_ == 601 then
		local var_10_0 = ActivityData:GetActivityData(ActivityConst.COOPERATION_DEMO)

		if var_10_0 and var_10_0:IsActivitying() then
			return manager.time:GetLostTimeStr(var_10_0.stopTime)
		else
			return GetTips("TIME_OVER")
		end
	end

	return nil
end

function ChapterDemoItem:IsLock(arg_11_1)
	local var_11_0 = ChapterClientCfg[self.chapterClientID_]
	local var_11_1 = PlayerData:GetPlayerInfo().userLevel < ChapterClientCfg[self.chapterClientID_].level

	if var_11_1 and arg_11_1 then
		ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_11_0.level))
	end

	return var_11_1
end

function ChapterDemoItem:Dispose()
	ChapterDemoItem.super.Dispose(self)
end

return ChapterDemoItem

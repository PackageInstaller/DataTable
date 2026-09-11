local IchiBanLevelView = class("IchiBanLevelView", ReduxView)

function IchiBanLevelView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.getAllController_ = self.uiControllerEx_:GetController("default0")
	self.scrollList_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, IchiBanLevelItem)
end

function IchiBanLevelView:Dispose()
	self.scrollList_:Dispose()

	self.scrollList_ = nil

	IchiBanLevelView.super.Dispose(self)
end

function IchiBanLevelView:AddListeners()
	self:AddBtnListener(self.uiBtn_, nil, function()
		ShowTips("ICHIBAN_COLLECT_TIPS")
	end)
	self:AddBtnListener(self.uiInfoBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_ichiban_teaser_news_touch",
			activity_id = self.cfg_.activity_id,
			type = self.cfg_.level
		})
		JumpTools.OpenPageByJump("iChiBanPop", {
			id = self.id_
		})
	end)
end

function IchiBanLevelView:SetData(arg_6_1)
	self.id_ = arg_6_1
	self.cfg_ = IchiBanTeaserCfg[arg_6_1]

	self.scrollList_:StartScroll(#IchiBanTeaserCfg[arg_6_1].reward)
	self:PlayAnimator()

	self.uiIcon_.sprite = pureGetSpriteWithoutAtlas(IchiBanTeaserCfg[arg_6_1].clue_pic)

	self:RefreshText()
end

function IchiBanLevelView:RefreshText()
	self.uiCntText_.text = string.format("%s/%s", #IchiBanData:GetIchiBanDataList(self.cfg_.activity_id, self.cfg_.level), #self.cfg_.reward)
end

function IchiBanLevelView:UpdateData()
	self.scrollList_:Refresh()
	self:PlayAnimator()
	self:RefreshText()
end

function IchiBanLevelView:PlayAnimator()
	local var_9_0 = IchiBanTools.IsGotAllLevelReward(self.id_)

	self.getAllController_:SetSelectedState(var_9_0 and "state1" or "state0")

	if table.keyof(IchiBanData:GetUILevelReward(self.cfg_.activity_id), self.cfg_.level) then
		self.uiAnimator_:Play("Rank_unlock", 0, 0)
		self.uiAnimator_:Update(0)
	elseif var_9_0 then
		self.uiAnimator_:Play("Rank_unlock", 0, 1)
		self.uiAnimator_:Update(1)
	else
		self.uiAnimator_:Play("New State", 0, 0)
		self.uiAnimator_:Update(0)
	end
end

function IchiBanLevelView:OnExit()
	return
end

function IchiBanLevelView:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(arg_11_1, self.cfg_, rewardData)
end

return IchiBanLevelView

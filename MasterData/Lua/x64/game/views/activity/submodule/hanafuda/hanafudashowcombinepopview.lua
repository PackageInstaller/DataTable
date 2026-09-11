local HanafudaShowCombinePopView = class("HanafudaShowCombinePopView", ReduxView)

function HanafudaShowCombinePopView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaCombinationUI"
end

function HanafudaShowCombinePopView:UIParent()
	return manager.ui.uiPop.transform
end

function HanafudaShowCombinePopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HanafudaShowCombinePopView:InitUI()
	self:BindCfgUI()

	self.uiList_ = {}

	for iter_4_0 = 1, 6 do
		local var_4_0 = Object.Instantiate(self.cardGo_, self.listTrs_)

		table.insert(self.uiList_, (HanafudaCardView.New(var_4_0)))
		SetActive(var_4_0, false)
	end
end

function HanafudaShowCombinePopView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:GoNextCombine()
	end)
end

function HanafudaShowCombinePopView:OnEnter()
	manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_success", "")

	self.combineIdList_ = self.params_.combineIdList
	self.curCombineIdIndex_ = 1
	self.callback_ = self.params_.callback
	self.timer_ = Timer.New(function()
		self:GoNextCombine()
	end, 1, -1, true)

	self.timer_:Start()
	self:RefreshUI()
end

function HanafudaShowCombinePopView:GoNextCombine()
	if self.curCombineIdIndex_ == #self.combineIdList_ then
		self:Back()

		if self.callback_ then
			self:callback_()
		end
	else
		manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_success", "")

		self.curCombineIdIndex_ = self.curCombineIdIndex_ + 1

		self:RefreshUI()
	end
end

function HanafudaShowCombinePopView:RefreshUI()
	self.cardIdList_ = HanafudaCardCombineCfg[self.combineIdList_[self.curCombineIdIndex_]].card_list
	self.combineNameText_.text = HanafudaCardCombineCfg[self.combineIdList_[self.curCombineIdIndex_]].name
	self.scoreText_.text = HanafudaCardCombineCfg[self.combineIdList_[self.curCombineIdIndex_]].score

	self:IndexItem()
end

function HanafudaShowCombinePopView:IndexItem()
	for iter_11_0 = 1, 6 do
		if self.cardIdList_[iter_11_0] then
			self.uiList_[iter_11_0]:SetData(iter_11_0, HanafudaCardCfg[self.cardIdList_[iter_11_0]])
			self.uiList_[iter_11_0]:FlipToFaceUp()
			SetActive(self.uiList_[iter_11_0].gameObject_, true)
		else
			SetActive(self.uiList_[iter_11_0].gameObject_, false)
		end
	end

	self.imgTrs_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 700 + 300 * #self.cardIdList_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.listTrs_)
end

function HanafudaShowCombinePopView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function HanafudaShowCombinePopView:Dispose()
	if self.uiList_ then
		for iter_13_0, iter_13_1 in ipairs(self.uiList_) do
			iter_13_1:Dispose()
		end
	end

	HanafudaShowCombinePopView.super.Dispose(self)
end

return HanafudaShowCombinePopView

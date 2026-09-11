local HanafudaGameView = class("HanafudaGameView", ReduxView)

function HanafudaGameView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaRewardUI"
end

function HanafudaGameView:UIParent()
	return manager.ui.uiPop.transform
end

function HanafudaGameView:Init()
	self:InitUI()
	self:AddUIListener()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.rewardList_, HanafudaRewardItem)
	self.cardUIList_ = LuaList.New(handler(self, self.IndexCardItem), self.cardList_, HanafudaCardView)
	self.checkController_ = ControllerUtil.GetController(self.transform_, "check")
end

function HanafudaGameView:InitUI()
	self:BindCfgUI()
end

function HanafudaGameView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.checkMaskBtn_, nil, function()
		self.checkController_:SetSelectedState("false")
	end)
end

function HanafudaGameView:IndexItem(arg_8_1, arg_8_2)
	arg_8_2:SetData(arg_8_1, self.combineCfgList_[arg_8_1])
	arg_8_2:SetCallBack(function()
		self:RefreshUI()
	end)
	arg_8_2:SetCheckCallBack(function(arg_10_0)
		self.cardIdList_ = HanafudaCardCombineCfg[arg_10_0].card_list

		self.cardUIList_:StartScroll(#self.cardIdList_)
		self.checkController_:SetSelectedState("true")

		self.titleText_.text = HanafudaCardCombineCfg[arg_10_0].name

		self.imgTrs_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 700 + 300 * #self.cardIdList_)
	end)
end

function HanafudaGameView:IndexCardItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(arg_11_1, HanafudaCardCfg[self.cardIdList_[arg_11_1]])
	arg_11_2:FlipToFaceUp()
end

function HanafudaGameView:OnEnter()
	self.combineCfgList_ = deepClone(HanafudaData:GetCombineList())

	self:RefreshUI()
end

function HanafudaGameView:RefreshUI()
	table.sort(self.combineCfgList_, function(arg_14_0, arg_14_1)
		local var_14_0 = HanafudaData:GetIsComplete(arg_14_0.id)
		local var_14_1 = HanafudaData:GetIsRewarded(arg_14_0.id)
		local var_14_2 = HanafudaData:GetIsComplete(arg_14_1.id)
		local var_14_3 = HanafudaData:GetIsRewarded(arg_14_1.id)

		if var_14_1 ~= var_14_3 then
			return not var_14_1 and var_14_3
		elseif var_14_0 ~= var_14_2 then
			return var_14_0 and not var_14_2
		else
			return arg_14_0.id < arg_14_1.id
		end
	end)
	self.uiList_:StartScroll(#self.combineCfgList_)
end

function HanafudaGameView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()
	end

	if self.cardUIList_ then
		self.cardUIList_:Dispose()
	end

	HanafudaGameView.super.Dispose(self)
end

return HanafudaGameView

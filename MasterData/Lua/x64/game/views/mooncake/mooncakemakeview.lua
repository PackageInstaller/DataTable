local MoonCakeMakeView = class("MoonCakeMakeView", ReduxView)

function MoonCakeMakeView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeMakeUI"
end

function MoonCakeMakeView:UIParent()
	return manager.ui.uiPop.transform
end

function MoonCakeMakeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MoonCakeMakeView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.failController_ = ControllerUtil.GetController(self.transform_, "fail")
	self.fillingItemList_ = LuaList.New(handler(self, self.IndexItem), self.scrollView_, MoonCakeItem)
	self.clickFillingHandler_ = handler(self, self.OnClickFilling)
	self.clickModelHandler_ = handler(self, self.OnClickModel)
	self.modelList_ = {}

	for iter_4_0 = 1, self.modelContentTrans_.childCount do
		self.modelList_[iter_4_0] = MoonCakeItem.New(self.modelContentTrans_:GetChild(iter_4_0 - 1).gameObject)

		self.modelList_[iter_4_0]:SetType(MoonCakeConst.ITEM_STYLE.NONE)
		self.modelList_[iter_4_0]:SetData(nil, iter_4_0, true)
		self.modelList_[iter_4_0]:SetClickHandler(self.clickModelHandler_)
	end

	self.originCircleRotateion_ = self.circle_.localRotation
	self.originArrowRotatetion_ = self.arror_.localRotation
end

function MoonCakeMakeView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		if self.startMake_ == true then
			return
		end

		self:Back()
	end)
	self:AddBtnListener(self.makeBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		self.startMake_ = true

		self:SwitchToMake()
		self:StartQTE()
	end)
	self:AddBtnListener(self.qteConfirmBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		self.startMake_ = false

		self:EndQTE()
	end)
	self:AddBtnListener(self.resultConfirmBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if self.curFillingID_ then
			self:SwitchToChose()
		else
			self:SwitchToPrepare()
		end
	end)
end

function MoonCakeMakeView:Dispose()
	self.fillingItemList_:Dispose()

	self.fillingItemList_ = nil

	for iter_10_0, iter_10_1 in ipairs(self.modelList_) do
		iter_10_1:Dispose()
	end

	self.modelList_ = nil
	self.clickFillingHandler_ = nil
	self.clickModelHandler_ = nil

	MoonCakeMakeView.super.Dispose(self)
end

function MoonCakeMakeView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.startMake_ = false

	self:SwitchToPrepare()
end

function MoonCakeMakeView:OnExit()
	self.status_ = nil

	AnimatorTools.Stop()
end

function MoonCakeMakeView:SwitchToPrepare()
	self.statusController_:SetSelectedIndex(MoonCakeConst.FILLING_MAKE_STATUS.PREPARE)
	self:RefreshResource()

	self.curFillingID_ = nil
	self.curFillingItem_ = nil
	self.curModelID_ = nil
end

function MoonCakeMakeView:SwitchToChose()
	self.statusController_:SetSelectedIndex(MoonCakeConst.FILLING_MAKE_STATUS.CHOSE)

	self.targetCakeID_ = MoonCakeTools.GetCakeRecipeDic(self.activityID_)[self.curFillingID_][self.curModelID_]
	self.cakeIcon_.sprite = ItemTools.getItemSprite(MoonCakeCfg[self.targetCakeID_].moon_cakes)
end

function MoonCakeMakeView:SwitchToMake()
	self.statusController_:SetSelectedIndex(MoonCakeConst.FILLING_MAKE_STATUS.MAKE)
end

function MoonCakeMakeView:SwitchToQTEResult()
	self.startMake_ = false

	if self.curQteResult_ == true then
		self.statusController_:SetSelectedIndex(MoonCakeConst.FILLING_MAKE_STATUS.SUCCESS)

		self.cakeIcon_.sprite = ItemTools.getItemSprite(self.resultItemID_)
	else
		self.statusController_:SetSelectedIndex(MoonCakeConst.FILLING_MAKE_STATUS.FAIL)

		if self.resultItemID_ == 0 then
			self.failController_:SetSelectedState("true")
		else
			self.failController_:SetSelectedState("false")

			self.cakeIcon_.sprite = ItemTools.getItemSprite(self.resultItemID_)
		end
	end

	SetActive(self.maskGo_, true)

	if self.resultItemID_ ~= 0 then
		AnimatorTools.PlayAnimatorWithCallback(self.qteResultAnim_, var_16_0, function()
			showRewardUI({
				{
					self.resultItemID_,
					1
				}
			})
			SetActive(self.maskGo_, false)
		end, false)
	else
		self.qteResultAnim_:Play(var_16_0, -1, 0)
		self.qteResultAnim_:Update(0)
	end
end

function MoonCakeMakeView:IndexItem(arg_18_1, arg_18_2)
	arg_18_2:SetData(MoonCakeFillingCfg[self.fillingIdList_[arg_18_1]].patties, self.fillingIdList_[arg_18_1])
	arg_18_2:SetType(MoonCakeConst.ITEM_STYLE.NORMAL)
	arg_18_2:SetClickHandler(self.clickFillingHandler_)
end

function MoonCakeMakeView:RefreshResource()
	self.fillingIdList_ = MoonCakeFillingCfg.get_id_list_by_activity[self.activityID_]

	self.fillingItemList_:StartScroll(#self.fillingIdList_)

	for iter_19_0, iter_19_1 in ipairs((self.fillingItemList_:GetItemList())) do
		iter_19_1:SetSelect(nil)
	end

	for iter_19_2, iter_19_3 in ipairs(self.modelList_) do
		iter_19_3:SetSelect(nil)
	end
end

function MoonCakeMakeView:RefreshTargetCake()
	if self.curFillingID_ ~= nil and self.curModelID_ ~= nil then
		self.targetCakeID_ = MoonCakeTools.GetCakeRecipeDic(self.activityID_)[self.curFillingID_][self.curModelID_]
		self.cakeIcon_.sprite = ItemTools.getItemSprite(MoonCakeCfg[self.targetCakeID_].moon_cakes)
	end
end

function MoonCakeMakeView:OnClickFilling(arg_21_1, arg_21_2)
	if ItemTools.getItemNum(MoonCakeFillingCfg[arg_21_1].patties) <= 0 then
		ShowTips("MID_AUTUMN_FESTIVAL_MOONCAKE_MAKING_INSUFFICIENT_RAW_MATERIALS")

		return
	end

	self.curFillingID_ = arg_21_1
	self.curFillingItem_ = arg_21_2

	for iter_21_0, iter_21_1 in ipairs((self.fillingItemList_:GetItemList())) do
		iter_21_1:SetSelect(arg_21_1)
	end

	if self.curFillingID_ ~= nil and self.curModelID_ ~= nil then
		self:SwitchToChose()
	end
end

function MoonCakeMakeView:OnClickModel(arg_22_1)
	self.curModelID_ = arg_22_1

	for iter_22_0, iter_22_1 in ipairs(self.modelList_) do
		iter_22_1:SetSelect(arg_22_1)
	end

	if self.curFillingID_ ~= nil and self.curModelID_ ~= nil then
		self:SwitchToChose()
	end
end

function MoonCakeMakeView:OnMakeCakeResult(arg_23_1)
	self.resultItemID_ = arg_23_1

	self.curFillingItem_:RefreshNum()

	if ItemTools.getItemNum(MoonCakeFillingCfg[self.curFillingID_].patties) <= 0 then
		self.curFillingItem_:SetSelect(nil)

		self.curFillingID_ = nil
		self.curFillingItem_ = nil
	end

	self:SwitchToQTEResult()
	self:ResetQTE()
end

function MoonCakeMakeView:ResetQTE()
	self.circle_.localRotation = self.originCircleRotateion_
	self.arror_.localRotation = self.originArrowRotatetion_
	self.countDownProgress_.fillAmount = 1
end

function MoonCakeMakeView:InitQTE()
	self.tagretAngle_ = self:RandomAngle()
	self.circle_.localRotation = Quaternion.Euler(0, 0, self.tagretAngle_)
	self.countDownProgress_.fillAmount = 1
end

function MoonCakeMakeView:StartQTE()
	self:InitQTE()
	self:RemoveTween()
	self:DoTween(self.tagretAngle_)
end

function MoonCakeMakeView:DoTween(arg_27_1)
	self.tagretAngle_ = arg_27_1
	self.circle_.localRotation = Quaternion.Euler(0, 0, self.tagretAngle_)
	self.countDownProgress_.transform.localRotation = Quaternion.Euler(0, 0, self.arror_.localEulerAngles.z)
	self.tween = LeanTween.rotateAroundLocal(self.arror_.gameObject, Vector3.New(0, 0, -1), 360, 2):setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
		self.countDownProgress_.fillAmount = (360 - arg_28_0) / 360
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self:RemoveTween()
		self:GoToResult(false)
	end))
end

function MoonCakeMakeView:EndQTE()
	if (self.tagretAngle_ + 360 - (self.arror_.localEulerAngles.z + 360) % 360) % 360 <= 35 or (self.tagretAngle_ + 360 - (self.arror_.localEulerAngles.z + 360) % 360) % 360 >= 325 then
		if (self.tagretAngle_ + 360 - (self.arror_.localEulerAngles.z + 360) % 360) % 360 <= 15 or (self.tagretAngle_ + 360 - (self.arror_.localEulerAngles.z + 360) % 360) % 360 >= 345 then
			self:RemoveTween()
			self:GoToResult(true)
		else
			local var_30_0 = self:RandomAngle()

			self:RemoveTween()
			self:DoTween(var_30_0)
		end
	else
		self:RemoveTween()
		self:GoToResult(false)
	end
end

function MoonCakeMakeView:GoToResult(arg_31_1)
	self.curQteResult_ = arg_31_1

	MoonCakeAction.MoonCakeMakeResult(self.activityID_, self.targetCakeID_, self.curQteResult_)
end

function MoonCakeMakeView:RemoveTween()
	if self.tween then
		self.tween:setOnComplete(nil)
		LeanTween.cancel(self.arror_.gameObject)

		self.tween = nil
	end
end

function MoonCakeMakeView:RandomAngle()
	return -((-self.arror_.localEulerAngles.z + 360) % 360 + math.random(120, 300)) % 360
end

return MoonCakeMakeView

local BannerView = class("BannerView", ReduxView)

function BannerView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.info_ = arg_1_3

	self:InitUI()
	self:AddUIListener()
end

function BannerView:RefreshData(arg_2_1, arg_2_2)
	self.data_ = arg_2_1
	self.info_ = arg_2_2

	self:Render()
end

function BannerView:InitUI()
	self:BindCfgUI()

	self.judgeSize_ = self.listTrs_.sizeDelta
	self.calSliderWidth_ = 0
	self.gridTrs_ = self.grid_.transform
end

function BannerView:AddUIListener()
	self:AddDragListener(self.listGo_, function()
		self.timer_:Stop()
	end, function(arg_6_0, arg_6_1)
		return
	end, function(arg_7_0, arg_7_1)
		OperationRecorder.Record("home", "activity_slide")

		if not self.space_ then
			-- block empty
		end

		local var_7_1

		if self.info_.vertical then
			var_7_1 = self.gridTrs_.localPosition.y or -self.gridTrs_.localPosition.x

			local var_7_2

			if self.info_.vertical then
				var_7_2 = self.judgeSize_.y or self.judgeSize_.x
			end
		end

		local var_7_3 = var_7_2 / 2

		self:RemoveTween2()

		self.tween2_ = var_7_3 < var_7_1 and LeanTween.moveLocal(self.grid_, self:GetDragVector(-1), 0.25):setOnComplete(LuaHelper.VoidAction(function()
			self.index_ = self:GetRealIndex(self.index_ + 1)

			self:RefreshBanner()
		end)) or var_7_1 < -1 * var_7_3 and LeanTween.moveLocal(self.grid_, self:GetDragVector(1), 0.25):setOnComplete(LuaHelper.VoidAction(function()
			self.index_ = self:GetRealIndex(self.index_ - 1)

			self:RefreshBanner()
		end)) or LeanTween.moveLocal(self.grid_, Vector3(0, 0, 0), 0.25)

		self:StartTimer()
	end)

	self.eventTriggerListener_ = self:GetOrAddComponent(self.listGo_, typeof(EventTriggerListener))

	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Scroll, LuaHelper.EventTriggerAction1(function(arg_10_0, arg_10_1)
		self.eventTriggerListener_:OnBeginDrag(arg_10_1)
		self.eventTriggerListener_:OnEndDrag(arg_10_1)
	end))
	self:AddBtnListener(self.itembtn_, nil, function()
		if self.info_.onclick then
			self.info_.onclick(self.info_.data[self.index_])
		end
	end)
end

function BannerView:Render()
	self.index_ = 1
	self.dataNum_ = #self.info_.data

	self:InitBannerBar()
	self:RefreshBanner()
	self:StartTimer()
end

function BannerView:RefreshBanner()
	self.grid_.transform.localPosition = Vector3(0, 0, 0)
	self.item2_.sprite = self.info_.data[self.index_].image
	self.item1_.sprite = self.info_.data[self:GetRealIndex(self.index_ - 1)].image
	self.item3_.sprite = self.info_.data[self:GetRealIndex(self.index_ + 1)].image

	self:SetBarPosition(self.index_ - 1)
end

function BannerView:InitBannerBar()
	self.bar_.transform:SetSiblingIndex(0)

	for iter_14_0 = self.sliderBg_.transform.childCount, self.dataNum_ + 1, -1 do
		Object.Destroy(self.sliderBg_.transform:GetChild(iter_14_0 - 1).gameObject)
	end

	for iter_14_1 = self.sliderBg_.transform.childCount + 1, self.dataNum_ do
		SetActive(Object.Instantiate(self.barItem_, self.sliderBg_.transform), true)
	end
end

function BannerView:StartTimer()
	if self.timer_ then
		self.timer_:Stop()
	end

	self.timer_ = Timer.New(function()
		self:RemoveTween()

		self.tween_ = LeanTween.moveLocal(self.grid_, self:GetDragVector(-1), 0.25):setOnComplete(LuaHelper.VoidAction(function()
			self.index_ = self:GetRealIndex(self.index_ + 1)

			self:RefreshBanner()
			self:RemoveTween()
		end))
	end, 5, -1)

	self.timer_:Start()
end

function BannerView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnComplete(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function BannerView:RemoveTween2()
	if self.tween2_ then
		self.tween2_:setOnComplete(nil)
		LeanTween.cancel(self.tween2_.id)

		self.tween2_ = nil
	end
end

function BannerView:Init()
	self:Render()
end

function BannerView:Dispose()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self:RemoveTween()
	self:RemoveTween2()
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Scroll)

	self.info_ = nil

	BannerView.super.Dispose(self)
end

function BannerView:GetRealIndex(arg_22_1)
	if arg_22_1 > self.dataNum_ then
		return 1
	elseif arg_22_1 < 1 then
		return self.dataNum_
	else
		return arg_22_1
	end
end

function BannerView:SetBarPosition(arg_23_1)
	self.bar_.transform:SetSiblingIndex(arg_23_1)
end

function BannerView:GetDragVector(arg_24_1)
	local var_24_0 = self.space_ or 0

	if self.info_.vertical then
		return Vector3(0, -1 * arg_24_1 * (var_24_0 + self.judgeSize_.y), 0)
	else
		return Vector3(arg_24_1 * (var_24_0 + self.judgeSize_.x), 0, 0)
	end
end

return BannerView

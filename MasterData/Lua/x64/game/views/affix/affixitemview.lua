local AffixItemView = class("AffixItemView", ReduxView)

function AffixItemView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_2 == nil and arg_1_1 or Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	if arg_1_3 ~= nil then
		self:SetData(arg_1_3)
	end

	self.hideInfoHandler_ = handler(self, self.HideInfo)

	manager.notify:RegistListener(CLICK_AFFIX, self.hideInfoHandler_)
end

function AffixItemView:SetData(arg_2_1)
	self:ShowInfo(false)

	self.nameText_.text = GetI18NText(getAffixName(arg_2_1))
	self.icon_.sprite = getAffixSprite(arg_2_1)
	self.level_.text = arg_2_1[2]

	self:Show(true)

	self.textInfoName_.text = GetI18NText(getAffixName(arg_2_1))
	self.textInfoDesc_.text = GetI18NText(getAffixDesc(arg_2_1))
end

function AffixItemView:Show(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

function AffixItemView:Dispose()
	AffixItemView.super.Dispose(self)
	manager.notify:RemoveListener(CLICK_AFFIX, self.hideInfoHandler_)

	self.hideInofHandler_ = nil

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
end

function AffixItemView:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		manager.notify:Invoke(CLICK_AFFIX)
		self:ShowInfo(true)
	end)
end

function AffixItemView:HideInfo()
	self:ShowInfo(false)
end

function AffixItemView:ShowInfo(arg_8_1)
	SetActive(self.goInfo_, arg_8_1)

	if arg_8_1 then
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.transformInfoName_)
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.transformInfoDesc_)
	end
end

function AffixItemView:AddHideTimer()
	self:StopHideTimer()

	self.hideTimer_ = Timer.New(function()
		self:ShowInfo(false)
	end, 3, 1)

	self.hideTimer_:Start()
end

function AffixItemView:StopHideTimer()
	if self.hideTimer_ then
		self.hideTimer_:Stop()

		self.hideTimer_ = nil
	end
end

function AffixItemView:AddClickTimer()
	self:StopTimer()

	self.buttonUp_ = 0
	self.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		if Input.GetMouseButtonUp(0) then
			self.buttonUp_ = self.buttonUp_ + 1

			if self.buttonUp_ >= 2 then
				self:ShowInfo(false)

				if self.clickTimer_ then
					FuncTimerManager.inst:RemoveFuncTimer(self.clickTimer_)

					self.clickTimer_ = nil
				end
			end
		end
	end, -1, true)
end

function AffixItemView:StopTimer()
	if self.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(self.clickTimer_)

		self.clickTimer_ = nil
	end
end

return AffixItemView

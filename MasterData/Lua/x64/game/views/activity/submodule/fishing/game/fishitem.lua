local FishItem = class("FishItem", ReduxView)

function FishItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function FishItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function FishItem:InitUI()
	self:BindCfgUI()

	self.oriX_ = self.transform_.localPosition.x
	self.direct_ = -1
end

function FishItem:AddUIListener()
	return
end

function FishItem:AddEventListeners()
	return
end

function FishItem:SetData(arg_6_1)
	self.data_ = arg_6_1
	self.fishCfg_ = GameFishCfg[arg_6_1.fishId]

	self:UpdateView()
end

function FishItem:GetData()
	return self.data_
end

function FishItem:UpdateView()
	self.hitArea_.sizeDelta = Vector2(self.data_.hitWidth, self.data_.hitHeight)

	self:DrawDebug()
end

function FishItem:DrawDebug()
	return
end

function FishItem:OnTop()
	self:UpdateBar()
end

function FishItem:UpdateBar()
	return
end

function FishItem:OnEnter()
	self:AddEventListeners()
end

function FishItem:OnExit()
	self:RemoveAllEventListener()
end

function FishItem:Update(arg_14_1)
	if self.data_.moveable == 1 then
		if FishGameManager.GetInstance():GetBuff() ~= 3 then
			local var_14_0 = self.transform_.localPosition

			var_14_0.x = self.transform_.localPosition.x + arg_14_1 * self.direct_ * self.fishCfg_.speed / 10 * 60

			if var_14_0.x < self.oriX_ - self.data_.radius then
				var_14_0.x = self.oriX_ - self.data_.radius
				self.direct_ = 1

				if self.imageTransform_.localScale == nil then
					CustomLog.Log(string.format("scale is nil"))
				end

				self.imageTransform_.localScale.x = -1
				self.imageTransform_.localScale = self.imageTransform_.localScale
			elseif var_14_0.x > self.oriX_ + self.data_.radius then
				var_14_0.x = self.oriX_ + self.data_.radius
				self.direct_ = -1
				self.imageTransform_.localScale.x = 1
				self.imageTransform_.localScale = self.imageTransform_.localScale
			end

			self.transform_.localPosition = var_14_0
		end
	end
end

function FishItem:Dispose()
	Object.Destroy(self.gameObject_)
	FishItem.super.Dispose(self)
end

return FishItem

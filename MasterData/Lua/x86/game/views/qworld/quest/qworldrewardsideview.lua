local QWorldRewardSideView = class("QWorldRewardSideView", ReduxView)

function QWorldRewardSideView:UIParent()
	return manager.ui.uiMain.transform
end

function QWorldRewardSideView:OnCtor(arg_2_1, arg_2_2)
	self.gameObject_ = arg_2_1
	self.transform_ = self.gameObject_.transform
	self.mainHomePage_ = arg_2_2

	self:InitUI()
end

function QWorldRewardSideView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.items_ = {}
	self.showData_ = {}
	self.nextGenTime_ = 0

	SetActive(self.rewardItemGo_, false)
end

function QWorldRewardSideView:AddUIListener()
	return
end

function QWorldRewardSideView:OnEnter()
	self:RefreshUI()
end

function QWorldRewardSideView:OnTop()
	self:RefreshUI()
end

function QWorldRewardSideView:OnExit()
	return
end

function QWorldRewardSideView:InsertRewards(arg_8_1)
	local var_8_0 = {}

	for iter_8_0 = 1, math.min(#arg_8_1, 8) do
		table.remove(arg_8_1, 1)
		table.insert(var_8_0, arg_8_1[1])
	end

	for iter_8_1, iter_8_2 in ipairs((ItemTools.SortRewardItemList(var_8_0))) do
		table.insert(self.showData_, {
			reward = iter_8_2
		})
	end

	if not self.timer_ then
		self.rewardBlankTrans_.sizeDelta = Vector2(10, 0)
		self.timer_ = Timer.New(function()
			if #self.showData_ > 0 then
				self:UpdateShowData()
			else
				self:StopTimer()
			end
		end, 0.033, -1)

		self.timer_:Start()
	end
end

function QWorldRewardSideView:UpdateShowData()
	local var_10_0 = self:GetCurSpaceItemCount()
	local var_10_1 = false

	if not self.rewardPanelGo_.activeSelf then
		SetActive(self.rewardPanelGo_, true)

		self.nextGenTime_ = Time.time + 0.01
		var_10_1 = true
	end

	local var_10_2 = 1

	while var_10_2 <= #self.showData_ do
		local var_10_3 = false

		if self.showData_[var_10_2].item then
			if Time.time > self.showData_[var_10_2].endTime then
				table.remove(self.items_, var_10_2)
				table.insert(self.items_, self.showData_[var_10_2].item)
				SetActive(self.showData_[var_10_2].item.gameObject_, false)
				table.remove(self.showData_, var_10_2)

				var_10_3 = true
				self.rewardBlankTrans_.sizeDelta = Vector2(10, -self.showData_[var_10_2].item.transform_.anchoredPosition.y + self.showData_[var_10_2].item.transform_.sizeDelta.y)
				var_10_1 = true
			else
				self.showData_[var_10_2].item:RefreshAnim()
			end
		elseif var_10_2 <= var_10_0 and Time.time >= self.nextGenTime_ then
			local var_10_4 = self.items_[var_10_2]

			if not self.items_[var_10_2] then
				var_10_4 = QWorldRewardSideItem.New((Object.Instantiate(self.rewardItemGo_, self.rewardListGo_.transform)))
				self.items_[var_10_2] = var_10_4
			end

			SetActive(var_10_4.gameObject_, true)
			var_10_4.gameObject_.transform:SetAsLastSibling()
			var_10_4:SetData(self.showData_[var_10_2].reward)

			self.showData_[var_10_2].item = var_10_4
			self.showData_[var_10_2].endTime = Time.time + SandplaySettingCfg.pop_reward.value[1] / 1000
			self.nextGenTime_ = Time.time + SandplaySettingCfg.pop_reward_interval.value[1] / 1000
			var_10_1 = true
		end

		if not var_10_3 then
			var_10_2 = var_10_2 + 1
		end
	end

	if self.rewardBlankTrans_.sizeDelta.y > 0 then
		self.rewardBlankTrans_.sizeDelta = Vector2(10, math.max(self.rewardBlankTrans_.sizeDelta.y - 25, 0))

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.rewardListGo_.transform)
	end

	if var_10_1 then
		self:RefreshUI()
		self.mainHomePage_:UpdateLeftPanelLayout()
	end
end

function QWorldRewardSideView:GetCurSpaceItemCount()
	return math.max(math.floor((self.leftPanelTrans_.rect.height + self.rewardPanelGo_.transform.offsetMax.y + self.rewardListGo_.transform.offsetMax.y) / self.rewardItemGo_.transform.sizeDelta.y), 1)
end

function QWorldRewardSideView:IsShowing()
	return #self.showData_ > 0 and (Time.time <= self.nextGenTime_ or self.rewardBlankTrans_.sizeDelta.y > 0)
end

function QWorldRewardSideView:RefreshUI()
	if self:IsShowing() then
		SetActive(self.rewardPanelGo_, true)
	else
		SetActive(self.rewardPanelGo_, false)
		self:StopTimer()
	end
end

function QWorldRewardSideView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function QWorldRewardSideView:Dispose()
	for iter_15_0, iter_15_1 in ipairs(self.items_) do
		iter_15_1:Dispose()
	end

	self.showData_ = nil

	self:StopTimer()

	self.gameObject_ = nil
	self.transform_ = nil

	QWorldRewardSideView.super.Dispose(self)
end

return QWorldRewardSideView

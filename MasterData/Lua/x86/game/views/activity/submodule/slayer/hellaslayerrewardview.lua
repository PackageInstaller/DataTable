local HellaSlayerRewardView = class("HellaSlayerRewardView", ReduxView)

function HellaSlayerRewardView:UIName()
	return SlayerTools.GetRewardUIName(self.params_.slayer_activity_id or 61131)
end

function HellaSlayerRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function HellaSlayerRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HellaSlayerRewardView:InitUI()
	self:BindCfgUI()

	self.rewardItems = {}
end

function HellaSlayerRewardView:AddUIListener()
	self:AddBtnListener(self.m_maskBtn, nil, function()
		self:Back()
	end)
end

function HellaSlayerRewardView:OnEnter()
	self.slayer_activity_id = self.params_.slayer_activity_id or 61131

	if self:IsOpenRoute("slayerSctionInfo") and self.params_.region_activity_id then
		self.regionList = {
			self.params_.region_activity_id
		}

		SetActive(self.m_receiveLab.gameObject, false)
	else
		if ActivityCfg[self.slayer_activity_id] then
			self.regionList = ActivityCfg[self.slayer_activity_id].sub_activity_list or {}
		end

		SetActive(self.m_receiveLab.gameObject, true)
	end

	self:Refresh()
end

function HellaSlayerRewardView:Refresh()
	local var_8_0 = 0
	local var_8_1 = 1

	for iter_8_0 = #self.regionList, 1, -1 do
		local var_8_2 = ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[self.regionList[iter_8_0]] or {}

		var_8_0 = var_8_0 + #var_8_2

		local var_8_3 = SlayerData:GetPoint(self.slayer_activity_id, self.regionList[iter_8_0])

		for iter_8_1, iter_8_2 in ipairs(var_8_2) do
			if var_8_3 >= ActivitySlayerPointRewardCfg[iter_8_2].need and not SlayerData:GetReceivedReward(self.slayer_activity_id, iter_8_2) then
				var_8_1 = iter_8_0
			end
		end
	end

	self.m_receiveLab.text = 0 + SlayerData:GetRewardCount(self.slayer_activity_id) .. "/" .. var_8_0

	for iter_8_3 = 1, #self.regionList do
		self.rewardItems[iter_8_3] = self.rewardItems[iter_8_3] or SlayerTools.GetRewardItemClass(self.slayer_activity_id).New((Object.Instantiate(self.m_item, self.m_content)))

		self.rewardItems[iter_8_3]:SetData(self.slayer_activity_id, self.regionList[iter_8_3])
		self.rewardItems[iter_8_3]:SetActive(true)
	end

	for iter_8_4 = #self.regionList + 1, #self.rewardItems do
		self.rewardItems[iter_8_4]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_content)

	if var_8_1 ~= 0 then
		local var_8_4 = 0

		for iter_8_5 = 1, var_8_1 - 1 do
			var_8_4 = var_8_4 + (self.rewardItems[iter_8_5] and self.rewardItems[iter_8_5]:GetHeight() or 0)
		end

		self.m_content.anchoredPosition = Vector2.New(0, var_8_4)
	end
end

function HellaSlayerRewardView:Dispose()
	for iter_9_0, iter_9_1 in ipairs(self.rewardItems) do
		iter_9_1:Dispose()
	end

	self.rewardItems = {}

	HellaSlayerRewardView.super.Dispose(self)
end

function HellaSlayerRewardView:OnSlayerReward()
	self:Refresh()
end

return HellaSlayerRewardView

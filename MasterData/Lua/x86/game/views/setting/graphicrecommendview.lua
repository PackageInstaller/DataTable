local GraphicRecommendView = class("GraphicRecommendView", ReduxView)

function GraphicRecommendView:UIName()
	return "Widget/System/LoginInterface/GraphicRecommendUI"
end

function GraphicRecommendView:UIParent()
	return manager.ui.uiMain.transform
end

function GraphicRecommendView:Init()
	self.qualityIdList_ = {
		3,
		4,
		5
	}

	self:InitUI()
	self:AddUIListener()
end

function GraphicRecommendView:InitUI()
	self:BindCfgUI()

	self.toggles_ = {
		self.lowToggle_,
		self.middleToggle_,
		self.highToggle_
	}
	self.recommendIconGos_ = {
		self.lowRecommendIconGo_,
		self.middleRecommendIconGo_,
		self.highRecommendIconGo_
	}
	self.recommendTips_ = {
		GetTips("GRAPHIC_RECOMMEND_3"),
		GetTips("GRAPHIC_RECOMMEND_2"),
		GetTips("GRAPHIC_RECOMMEND_1")
	}
end

function GraphicRecommendView:AddUIListener()
	self:AddBtnListener(self.okBtn_, nil, function()
		for iter_6_0, iter_6_1 in ipairs(self.toggles_) do
			if iter_6_1.isOn then
				if self.params_.callback ~= nil then
					self.params_.callback(iter_6_0, self.qualityIdList_[iter_6_0])
				end

				return
			end
		end
	end)
end

function GraphicRecommendView:OnEnter()
	local var_7_0 = SettingData:GetDefaultSetting()
	local var_7_1 = table.indexof(self.qualityIdList_, (GameToSDK.PLATFORM_ID == 4 or nil) and 3)

	if var_7_1 then
		SetActive(self.recommendIconGos_[var_7_1], true)

		self.toggles_[var_7_1].isOn = true
		self.recommendText_.text = self.recommendTips_[var_7_1]
	end
end

function GraphicRecommendView:OnExit()
	return
end

function GraphicRecommendView:Dispose()
	GraphicRecommendView.super.Dispose(self)
end

return GraphicRecommendView

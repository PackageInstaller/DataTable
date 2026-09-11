local SpringFestivalZumaEndlessEffectPopView = class("SpringFestivalZumaEndlessEffectPopView", ReduxView)

function SpringFestivalZumaEndlessEffectPopView:UIName()
	return "Widget/Version/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/SandPlay_3_11_ZumaEffectPopUI"
end

function SpringFestivalZumaEndlessEffectPopView:UIParent()
	return manager.ui.uiPop.transform
end

function SpringFestivalZumaEndlessEffectPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SpringFestivalZumaEndlessEffectPopView:InitUI()
	self:BindCfgUI()

	self.talentList = {}

	local var_4_0 = ZumaData:GetEndlessTalentList()

	for iter_4_0 = 2, #var_4_0 do
		local var_4_1 = self:CreateTalentItem()

		var_4_1:SetData(var_4_0[iter_4_0])
		table.insert(self.talentList, var_4_1)
	end
end

function SpringFestivalZumaEndlessEffectPopView:CreateTalentItem()
	return (SpringFestivalZumaEndlessTalentItem.New((GameObject.Instantiate(self.effectdetailsitemGo_, self.contentTrs_))))
end

function SpringFestivalZumaEndlessEffectPopView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		JumpTools.Back()
	end)
end

function SpringFestivalZumaEndlessEffectPopView:OnEnter()
	for iter_8_0, iter_8_1 in pairs(self.talentList) do
		iter_8_1:RefreshUI()
	end
end

function SpringFestivalZumaEndlessEffectPopView:Dispose()
	for iter_9_0, iter_9_1 in pairs(self.talentList) do
		if iter_9_1 then
			iter_9_1:Dispose()

			iter_9_1 = nil
		end
	end

	SpringFestivalZumaEndlessEffectPopView.super.Dispose(self)
end

return SpringFestivalZumaEndlessEffectPopView

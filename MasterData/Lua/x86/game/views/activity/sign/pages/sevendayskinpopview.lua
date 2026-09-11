local SevenDaySkinPopView = class("SevenDaySkinPopView", ReduxView)

function SevenDaySkinPopView:UIName()
	return "UI/SevenSignSkin/XH3rdSevenPopUI"
end

function SevenDaySkinPopView:UIParent()
	return manager.ui.uiPop.transform
end

function SevenDaySkinPopView:Init()
	self:InitUI()
	self:AddUIListeners()

	self.items = {}
end

function SevenDaySkinPopView:InitUI()
	self.gameObject_:InjectUI(self)
end

function SevenDaySkinPopView:AddUIListeners()
	self:AddBtnListener(self.BtnMask, nil, handler(self, self.OpenRewardUI))
end

function SevenDaySkinPopView:OnEnter()
	self.msg = self.params_.msg
	self.reward = self.params_.reward

	self:RefreshView()
end

function SevenDaySkinPopView:RefreshView()
	self.TxtContent.text = GetTips(self.msg.body)
	self.TxtName.text = GetTips(self.msg.author)

	self.Ctrl:SetSelectedState(self.msg.name)
end

function SevenDaySkinPopView:OnExit()
	return
end

function SevenDaySkinPopView:Dispose()
	SevenDaySkinPopView.super.Dispose(self)
end

function SevenDaySkinPopView:OpenRewardUI()
	self.Back()

	if self.reward[1][1] == 1042051 then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("USE_SKIN_CHANGE"), ItemTools.getItemName(1042051)),
			OkCallback = function()
				CommonAction.TryToUseItem({
					{
						item_info = {
							id = 1042051,
							num = 1
						},
						use_list = {}
					}
				})
			end,
			MaskCallback = function()
				getReward(formatRewardCfgList(self.reward))
			end,
			CancelCallback = function()
				getReward(formatRewardCfgList(self.reward))
			end
		})
	else
		getReward(formatRewardCfgList(self.reward))
	end
end

return SevenDaySkinPopView

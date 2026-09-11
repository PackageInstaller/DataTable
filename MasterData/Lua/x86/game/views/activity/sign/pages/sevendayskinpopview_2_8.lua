local SevenDaySkinPopView_2_8 = class("SevenDaySkinPopView_2_8", ReduxView)

function SevenDaySkinPopView_2_8:UIName()
	return "UI/SevenSignSkin/XH3rdSevenPopUI"
end

function SevenDaySkinPopView_2_8:UIParent()
	return manager.ui.uiPop.transform
end

function SevenDaySkinPopView_2_8:Init()
	self:InitUI()
	self:AddUIListeners()

	self.items = {}
end

function SevenDaySkinPopView_2_8:InitUI()
	self.gameObject_:InjectUI(self)
end

function SevenDaySkinPopView_2_8:AddUIListeners()
	self:AddBtnListener(self.BtnMask, nil, handler(self, self.OpenRewardUI))
end

function SevenDaySkinPopView_2_8:OnEnter()
	self.msg = self.params_.msg
	self.reward = self.params_.reward

	self:RefreshView()
end

function SevenDaySkinPopView_2_8:RefreshView()
	self.TxtContent.text = GetTips(self.msg.body)
	self.TxtName.text = GetTips(self.msg.author)

	self.Ctrl:SetSelectedState(self.msg.name)
end

function SevenDaySkinPopView_2_8:OnExit()
	return
end

function SevenDaySkinPopView_2_8:Dispose()
	SevenDaySkinPopView_2_8.super.Dispose(self)
end

function SevenDaySkinPopView_2_8:OpenRewardUI()
	self.Back()

	if self.reward[1][1] == 106001 then
		getReward(self.reward)
	else
		getReward(self.reward)
	end
end

function SevenDaySkinPopView_2_8:UseSkin()
	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = string.format(GetTips("USE_SKIN_CHANGE"), ItemTools.getItemName(107602)),
		OkCallback = function()
			CommonAction.TryToUseItem({
				{
					num = 1,
					item_id = 107602,
					use_list = {}
				}
			})
		end,
		MaskCallback = function()
			getReward(self.reward)
		end,
		CancelCallback = function()
			getReward(self.reward)
		end
	})
end

return SevenDaySkinPopView_2_8

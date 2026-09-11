local PassportPosterView = class("PassportPosterView", ReduxView)

function PassportPosterView:UIName()
	return "Widget/System/Passport/PassportPosterUI"
end

function PassportPosterView:UIParent()
	return manager.ui.uiMain.transform
end

function PassportPosterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PassportPosterView:InitUI()
	self:BindCfgUI()

	self.items_ = {}

	if self.itemGo1_ then
		table.insert(self.items_, {
			item = CommonItemView.New(self.itemGo1_),
			data = clone(ItemTemplateData)
		})
	end

	if self.itemGo2_ then
		table.insert(self.items_, {
			item = CommonItemView.New(self.itemGo2_),
			data = clone(ItemTemplateData)
		})
	end

	if self.itemGo3_ then
		table.insert(self.items_, {
			item = CommonItemView.New(self.itemGo3_),
			data = clone(ItemTemplateData)
		})
	end

	if self.itemGo4_ then
		table.insert(self.items_, {
			item = CommonItemView.New(self.itemGo4_),
			data = clone(ItemTemplateData)
		})
	end

	if self.itemGo5_ then
		table.insert(self.items_, {
			item = CommonItemView.New(self.itemGo5_),
			data = clone(ItemTemplateData)
		})
	end

	if self.itemGo6_ then
		table.insert(self.items_, {
			item = CommonItemView.New(self.itemGo6_),
			data = clone(ItemTemplateData)
		})
	end
end

function PassportPosterView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)

	for iter_5_0, iter_5_1 in ipairs(self.items_) do
		function iter_5_1.data:clickFun()
			ShowPopItem(POP_OTHER_ITEM, {
				self.id,
				self.number
			})
		end
	end
end

function PassportPosterView:UpdateBar()
	return
end

function PassportPosterView:OnEnter()
	self.dataList_ = BattlePassListCfg[PassportData:GetId()].display_reward_01

	for iter_9_0, iter_9_1 in ipairs(self.items_) do
		if self.dataList_[iter_9_0] then
			SetActive(self["itemGo" .. iter_9_0 .. "_"], true)

			local var_9_0 = {
				id = self.dataList_[iter_9_0][1]
			}

			if self.dataList_[iter_9_0][2] > 1 then
				var_9_0.number = self.dataList_[iter_9_0][2] or nil
			end

			CommonTools.SetCommonData(iter_9_1.item, var_9_0, iter_9_1.data)
		else
			SetActive(self["itemGo" .. iter_9_0 .. "_"], false)
		end
	end

	if BattlePassListCfg[PassportData:GetId()].battlepass_type >= 17 then
		self.rewardTxt_.text = GetTips("BATTLEPASS_REWARD_TIPS_BANNER")
		self.rewardTitleTxt_.text = GetTips("BATTLEPASS_REWARD_TIPS_TITLE")
	end

	self.bgImg_.sprite = pureGetSpriteWithoutAtlas(BattlePassListCfg[PassportData:GetId()].poster_ui)
	self.titleImg_.sprite = pureGetSpriteWithoutAtlas(BattlePassListCfg[PassportData:GetId()].slogan_ui)
end

function PassportPosterView:OnExit()
	return
end

function PassportPosterView:OnTop()
	self:UpdateBar()
end

function PassportPosterView:Cacheable()
	return false
end

function PassportPosterView:OnExitInput()
	JumpTools.Back()

	return true
end

function PassportPosterView:Dispose()
	if self.items_ then
		for iter_14_0, iter_14_1 in pairs(self.items_) do
			iter_14_1.item:Dispose()
		end

		self.items_ = nil
	end

	PassportPosterView.super.Dispose(self)
end

return PassportPosterView

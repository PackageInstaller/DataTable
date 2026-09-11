local DrawTenTimesRewardView = class("DrawTenTimesRewardView", ReduxView)

function DrawTenTimesRewardView:UIName()
	return "Widget/System/Pool/PoolTenTimesUI"
end

function DrawTenTimesRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function DrawTenTimesRewardView:OnCtor()
	return
end

function DrawTenTimesRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DrawTenTimesRewardView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, DrawTenTimesRewardItem)

	SetActive(self.goShare_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
end

function DrawTenTimesRewardView:AddUIListener()
	self:AddBtnListener(self.m_maskBtn, nil, function()
		self:Back()

		if self.params_.callBack_afterTen then
			self.params_.callBack_afterTen()
		end
	end)
	self:AddBtnListener(self.buttonShare_, nil, function()
		manager.share:Share(function()
			SetActive(self.goShare_, false)
			SetActive(self.goTips_, false)
			manager.notify:Invoke(SHAER_DAW_TEN_TIMES_START)
		end, function()
			SetActive(self.goShare_, true)
			SetActive(self.goTips_, true)
			manager.notify:Invoke(SHAER_DAW_TEN_TIMES_END)
		end, function()
			return
		end)
	end)
end

function DrawTenTimesRewardView:OnEnter()
	self.rewards = formatRewardCfgList(self.params_.reward)
	self.animePlayed = {}

	table.sort(self.rewards, function(arg_13_0, arg_13_1)
		local var_13_0 = ItemCfg[arg_13_0.id]
		local var_13_1 = ItemCfg[arg_13_1.id]

		if ItemWillConvert(arg_13_0) then
			var_13_0 = ItemCfg[arg_13_0.convert_from.id]
		end

		if ItemWillConvert(arg_13_1) then
			var_13_1 = ItemCfg[arg_13_1.convert_from.id]
		end

		local var_13_2 = arg_13_0.index or 0
		local var_13_3 = arg_13_1.index or 0

		if var_13_0.type ~= var_13_1.type then
			return var_13_0.type < var_13_1.type
		elseif var_13_0.display_rare ~= var_13_1.display_rare then
			return var_13_0.display_rare > var_13_1.display_rare
		else
			return var_13_2 < var_13_3
		end
	end)

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(self.rewards) do
		if iter_12_1.newTag then
			if not var_12_0[iter_12_1.id] then
				var_12_0[iter_12_1.id] = true
			else
				iter_12_1.newTag = false
			end
		end
	end

	self.list:StartScroll(#self.rewards)
	manager.windowBar:HideBar()
end

function DrawTenTimesRewardView:OnExit()
	for iter_14_0 = 1, #self.rewards do
		self.list:GetItemByIndex(iter_14_0):OnExit()
	end
end

function DrawTenTimesRewardView:IndexItem(arg_15_1, arg_15_2)
	arg_15_2:SetData(arg_15_1, self.rewards[arg_15_1], self.animePlayed[arg_15_1])

	self.animePlayed[arg_15_1] = true
end

function DrawTenTimesRewardView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	DrawTenTimesRewardView.super.Dispose(self)
end

return DrawTenTimesRewardView

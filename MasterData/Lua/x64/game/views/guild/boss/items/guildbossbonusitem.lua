local GuildBossBonusItem = class("GuildBossBonusItem", ReduxView)

function GuildBossBonusItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildBossBonusItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildBossBonusItem:InitUI()
	self:BindCfgUI()

	self.itemList = {}

	for iter_3_0 = 1, 3 do
		self.itemList[iter_3_0] = CommonItemView.New(self["commonitem_sGo_" .. iter_3_0])
	end

	self.statusController_ = self.controller:GetController("status")
end

function GuildBossBonusItem:AddUIListener()
	self:AddBtnListener(self.getBtn, nil, function()
		if self.remainHp_ <= self.needLessHp_ then
			GuildAction.GetGuildBossReward(GuildData:GetGuildInfo().id, 2, self.data_[1])
		end
	end)
end

function GuildBossBonusItem:AddEventListeners()
	return
end

function GuildBossBonusItem:SetData(arg_7_1, arg_7_2, arg_7_3)
	self.data_ = arg_7_1
	self.remainHp_ = arg_7_2
	self.needLessHp_ = ClubBossCfg[GuildData:GetBossDifficulty()].boss_hp * (100 - self.data_[1]) / 100
	self.bonusDataList_ = self.data_[2]
	self.numText_.text = arg_7_3 < 10 and "0" .. arg_7_3 or arg_7_3

	self:UpdateView()
	self:RefreshAwardItemList()
end

function GuildBossBonusItem:UpdateView()
	self.descLabel_.text = self.data_[1] == 100 and GetTips("CLUB_BOSS_BLOOD_CONDITION_TIP2") or string.format(GetTips("CLUB_BOSS_BLOOD_CONDITION_TIP1"), tostring(100 - self.data_[1] .. "%"))

	if GuildData:HaveGetGuildBossCommonReward(self.data_[1]) then
		self.statusController_:SetSelectedState("haveGet")
	elseif self.remainHp_ <= self.needLessHp_ then
		self.statusController_:SetSelectedState("canGet")
	else
		self.statusController_:SetSelectedState("cannotGet")
	end
end

function GuildBossBonusItem:RefreshAwardItemList()
	for iter_9_0 = 1, 3 do
		if self.bonusDataList_[iter_9_0] then
			self.itemList[iter_9_0]:SetData({
				id = self.bonusDataList_[iter_9_0][1],
				number = self.bonusDataList_[iter_9_0][2],
				clickFun = function(self)
					ShowPopItem(POP_ITEM, {
						self.id
					})
				end
			})
		else
			self.itemList[iter_9_0]:SetData()
		end
	end
end

function GuildBossBonusItem:OnEnter()
	self:AddEventListeners()
end

function GuildBossBonusItem:OnExit()
	self:RemoveAllEventListener()
end

function GuildBossBonusItem:OnMainHomeViewTop()
	return
end

function GuildBossBonusItem:Dispose()
	self.data_ = nil

	if self.itemList then
		for iter_14_0, iter_14_1 in ipairs(self.itemList) do
			iter_14_1:Dispose()
		end

		self.itemList = nil
	end

	GuildBossBonusItem.super.Dispose(self)
end

return GuildBossBonusItem

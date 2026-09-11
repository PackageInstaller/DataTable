local SequentialBattleBuffInfoView = class("SequentialBattleBuffInfoView", ReduxView)

function SequentialBattleBuffInfoView:UIName()
	return SequentialBattleUICfg[SequentialBattleUICfg.get_id_list_by_main_activity_id[SequentialBattleChapterCfg[self.params_.buffInfoActivityID].main_id][1]].buff_info_prefab
end

function SequentialBattleBuffInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function SequentialBattleBuffInfoView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.selectBuffHandler_ = handler(self, self.RefreshSelectBuff)
	self.buffUIList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, SequentialBattleBuffInfoItem)
	self.conditionList_ = {}
	self.buffController_ = self.buffControllerEx_:GetController("enabled")
end

function SequentialBattleBuffInfoView:OnEnter()
	self.activityID_ = self.params_.buffInfoActivityID
	self.stageID_ = self.params_.stageID
	self.buffList_ = clone(SequentialBattleBuffCfg.get_id_list_by_activity_id[SequentialBattleChapterCfg[self.activityID_].main_id])

	if self.stageID_ ~= nil then
		local var_4_0 = SequentialBattleTools.GetEnabledBuff(self.activityID_, (table.keyof(SequentialBattleChapterCfg[self.activityID_].stage_id, self.stageID_)))

		for iter_4_0 = #self.buffList_, 1, -1 do
			if table.keyof(var_4_0, self.buffList_[iter_4_0]) then
				table.remove(self.buffList_, iter_4_0)
			end
		end

		table.insertto(var_4_0, self.buffList_)

		self.buffList_ = var_4_0
	end

	self.selectID_ = self.buffList_[1]

	self.buffUIList_:StartScroll(#self.buffList_)
	manager.notify:RegistListener(SEQUENTIAL_BATTLE_BUFF, self.selectBuffHandler_)
	self:RefreshSelectBuff(self.selectID_)
	self:RefreshTitle()
end

function SequentialBattleBuffInfoView:OnExit()
	manager.notify:RemoveListener(SEQUENTIAL_BATTLE_BUFF, self.selectBuffHandler_)

	self.params_.stageID = nil
end

function SequentialBattleBuffInfoView:Dispose()
	SequentialBattleBuffInfoView.super.Dispose(self)

	self.selectBuffHandler_ = nil

	for iter_6_0, iter_6_1 in ipairs(self.conditionList_) do
		iter_6_1:Dispose()
	end

	self.conditionList_ = nil

	self.buffUIList_:Dispose()

	self.buffUIList_ = nil
end

function SequentialBattleBuffInfoView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

function SequentialBattleBuffInfoView:RefreshItem(arg_9_1, arg_9_2)
	arg_9_2:SetData(self.buffList_[arg_9_1], not not (self.stageID_ ~= nil and table.keyof(SequentialBattleTools.GetEnabledBuff(self.activityID_, (table.keyof(SequentialBattleChapterCfg[self.activityID_].stage_id, self.stageID_))), self.buffList_[arg_9_1])))
	arg_9_2:RefreshSelect(self.selectID_)
end

function SequentialBattleBuffInfoView:RefreshTitle()
	return
end

function SequentialBattleBuffInfoView:RefreshSelectBuff(arg_11_1)
	self.selectID_ = arg_11_1

	for iter_11_0, iter_11_1 in pairs(self.buffUIList_:GetItemList()) do
		iter_11_1:RefreshSelect(arg_11_1)
	end

	self:RefreshRightPanel()
	self:RefreshCondition()
end

function SequentialBattleBuffInfoView:RefreshRightPanel()
	local var_12_0 = SequentialBattleBuffCfg[self.selectID_]
	local var_12_1 = SequentialBattleBuffCfg[self.selectID_].affix_id

	self.selectIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/MaedukAffix/" .. PublicBuffCfg[AffixTypeCfg[SequentialBattleBuffCfg[self.selectID_].affix_id].affix_buff_id].icon)

	if not not (self.stageID_ ~= nil and table.keyof(SequentialBattleTools.GetEnabledBuff(self.activityID_, (table.keyof(SequentialBattleChapterCfg[self.activityID_].stage_id, self.stageID_))), self.selectID_)) == true then
		self.buffController_:SetSelectedState("true")
	else
		self.buffController_:SetSelectedState("false")
	end

	self.nameText_.text = GetI18NText(getAffixName({
		var_12_1
	}))
	self.descText_.text = GetI18NText(var_12_0.desc)
end

function SequentialBattleBuffInfoView:RefreshCondition()
	for iter_13_0 = #self.conditionList_, #SequentialBattleBuffCfg[self.selectID_].type + 1, -1 do
		self.conditionList_[iter_13_0]:Show(false)
	end

	for iter_13_1 = 1, #SequentialBattleBuffCfg[self.selectID_].type do
		self.conditionList_[iter_13_1] = self.conditionList_[iter_13_1] or SequentialBattleBuffInfoCondition.New(self.conditionItem_, self.conditionParent_)

		self.conditionList_[iter_13_1]:SetData(self.activityID_, self.stageID_, self.selectID_, iter_13_1)
	end
end

return SequentialBattleBuffInfoView

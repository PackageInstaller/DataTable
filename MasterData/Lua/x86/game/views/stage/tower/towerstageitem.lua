local TowerStageItem = class("TowerStageItem", ReduxView)

function TowerStageItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
	self:AddClickListen()
end

function TowerStageItem:initUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.romanController = ControllerUtil.GetController(self.transform_, "roman")
	self.rewardList = LuaList.New(handler(self, self.indexItem), self.m_rewardList, CommonItemView)
end

function TowerStageItem:AddClickListen()
	self:AddBtnListener(self.m_btn, nil, function()
		if PlayerData:GetPlayerInfo().userLevel < self.limitLv then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), self.limitLv))

			return
		end

		SetActive(self.m_redGo, false)
		manager.redPoint:setTip(RedPointConst.TOWER_NEW_LEVEL + self.chapterId, 0, RedPointStyle.SHOW_NEW_TAG)
		RedPointAction.HandleRedPoint(RedPointConst.TOWER_NEW_LEVEL + self.chapterId)
		JumpTools.GoToSystem("/tower", {
			chapterId = self.chapterId
		}, ViewConst.SYSTEM_ID.TOWER)

		if self.clickFunc then
			self.clickFunc()
		end
	end)
end

function TowerStageItem:RegistCallBack(arg_5_1)
	self.clickFunc = arg_5_1
end

function TowerStageItem:SetData(arg_6_1, arg_6_2)
	self.chapterId = arg_6_1

	self.romanController:SetSelectedIndex(arg_6_2)

	local var_6_0 = ChapterCfg[arg_6_1]
	local var_6_1 = ChapterCfg[arg_6_1].section_id_list
	local var_6_2 = TowerData:GetOverId(arg_6_1)
	local var_6_3 = #ChapterCfg[arg_6_1].section_id_list
	local var_6_4 = table.indexof(ChapterCfg[arg_6_1].section_id_list, var_6_2) or 0

	self.m_processText.text = var_6_4 .. "/" .. #ChapterCfg[arg_6_1].section_id_list
	self.m_process.value = var_6_3 == 0 and 0 or var_6_4 / var_6_3

	local var_6_5 = var_6_1[var_6_3] or 0

	if var_6_5 == 0 then
		self.rewardList:StartScroll(0)
	elseif (BattleTowerStageCfg[var_6_5] or {}).drop_lib_id ~= 0 then
		self.rewardData = getRewardFromDropCfg((BattleTowerStageCfg[var_6_5] or {}).drop_lib_id, true)

		self.rewardList:StartScroll(#self.rewardData)
	else
		self.rewardList:StartScroll(0)
	end

	self.limitLv = var_6_0.level or 0

	if PlayerData:GetPlayerInfo().userLevel < self.limitLv then
		self.stateController:SetSelectedIndex(0)
	elseif var_6_5 == var_6_2 then
		self.stateController:SetSelectedIndex(2)
	else
		self.stateController:SetSelectedIndex(1)
	end

	self.m_role.sprite = pureGetSpriteWithoutAtlas("TextureConfig/TowerUI/Boss/" .. ((ChapterClientCfg[arg_6_1] or nil) and (ChapterClientCfg[arg_6_1].chapter_paint or "")))

	SetActive(self.m_redGo, manager.redPoint:getTipValue(RedPointConst.TOWER_NEW_LEVEL + self.chapterId) > 0)
end

function TowerStageItem:indexItem(arg_7_1, arg_7_2)
	local var_7_0 = rewardToItemTemplate(self.rewardData[arg_7_1])

	var_7_0.number, var_7_0.equipLevel = nil

	arg_7_2:SetData((rewardToItemTemplate(self.rewardData[arg_7_1])))
end

function TowerStageItem:Dispose()
	self.rewardList:Dispose()
	TowerStageItem.super.Dispose(self)
end

return TowerStageItem

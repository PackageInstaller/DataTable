local TalentTreeMainView = class("TalentTreeMainView", ReduxView)

function TalentTreeMainView:UIName()
	return nil
end

function TalentTreeMainView:UIParent()
	return manager.ui.uiMain.transform
end

local var_0_1 = 6

function TalentTreeMainView:InitGo(arg_3_1)
	if self.gameObject_ then
		Object.Destroy(self.gameObject_)
	end

	self.gameObject_ = Object.Instantiate(Asset.Load(arg_3_1), self:UIParent())
	self.transform_ = self.gameObject_.transform
	var_0_1 = self.params_.activityId == ActivityConst.HELLA_TALENT_TREE and 5 or 6

	self:InitUI()
	self:AddUIListener()

	self.levelUpGo_ = self.levelUpTrs_.gameObject
	self.levelUpAni_ = self.levelUpTrs_:GetComponent("Animator")
end

function TalentTreeMainView:InitUI()
	self:BindCfgUI()

	self.upGo_ = self.upBtn_.gameObject
	self.subDesControllerS_ = {}

	for iter_4_0 = 0, 5 do
		local var_4_0 = self[string.format("item%dTrs_", iter_4_0)]

		if var_4_0 then
			self.subDesControllerS_[iter_4_0] = ControllerUtil.GetController(var_4_0, "item")
		end
	end

	if self.params_.activityId == ActivityConst.HELLA_TALENT_TREE then
		SetActive(self.race6Btn_.gameObject, false)
	end

	self.raceToId_ = {}
end

function TalentTreeMainView:AddUIListener()
	for iter_5_0 = 0, var_0_1 do
		local var_5_0 = self[string.format("race%dBtn_", iter_5_0)]

		if var_5_0 then
			self:AddBtnListener(var_5_0, nil, function()
				self:SelectItem(iter_5_0)
			end)
		end
	end

	self:AddBtnListener(self.upBtn_, nil, function()
		local var_7_0 = TalentTreeData:GetTalentLevel(self.currenttalentID_)

		if ItemTools.getItemNum(TalentTreeCfg[self.currenttalentID_].cost[var_7_0 + 1][1]) < TalentTreeCfg[self.currenttalentID_].cost[var_7_0 + 1][2] then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(TalentTreeCfg[self.currenttalentID_].cost[var_7_0 + 1][1])))

			return
		end

		TalentTreeAction.UpTalentLevel(self.currenttalentID_, TalentTreeCfg[self.currenttalentID_].cost[var_7_0 + 1])
	end)
end

function TalentTreeMainView:RefreshUI()
	for iter_8_0, iter_8_1 in ipairs(TalentTreeCfg.get_id_list_by_activity_id[self.activityId_]) do
		self.raceToId_[TalentTreeCfg[iter_8_1].index] = iter_8_1

		if TalentTreeCfg[iter_8_1].race == 0 then
			self.coreText_.text = GetI18NText(getAffixName({
				TalentTreeCfg[iter_8_1].affix_id,
				1
			}))
			self.coreDesText_.text = GetI18NText(getAffixDesc({
				TalentTreeCfg[iter_8_1].affix_id,
				1
			}))
		else
			self:RefreshItemMainLevel(iter_8_1)
		end
	end
end

function TalentTreeMainView:RefreshItem(arg_9_1)
	local var_9_0 = TalentTreeData:GetTalentLevel(arg_9_1)

	self:RefreshItemMainLevel(arg_9_1)

	self.talentText_.text = GetI18NText(getAffixName({
		TalentTreeCfg[arg_9_1].affix_id,
		1
	}))

	if self.descText_ then
		self.descText_.text = GetI18NText(TalentTreeCfg[arg_9_1].desc)
	end

	for iter_9_0 = 1, TalentTreeCfg[arg_9_1].max_level do
		local var_9_1 = self[string.format("subDes%dText_", iter_9_0)]

		if var_9_1 then
			var_9_1.text = GetI18NText(getAffixDesc({
				TalentTreeCfg[arg_9_1].affix_id,
				iter_9_0
			}))
		end

		if self.subDesControllerS_[iter_9_0] then
			self.subDesControllerS_[iter_9_0]:SetSelectedState(tostring(iter_9_0 <= var_9_0))
		end
	end
end

function TalentTreeMainView:PlayLevelUpAni(arg_10_1)
	self.levelUpTrs_.parent = self[string.format("item%dTrs_", (TalentTreeData:GetTalentLevel(arg_10_1)))]
	self.levelUpTrs_.localPosition = Vector3.zero

	self.levelUpAni_:Play("TalentUILevelUp", 0, 0)
end

function TalentTreeMainView:RefreshItemMainLevel(arg_11_1)
	local var_11_0 = self[string.format("num%dText_", TalentTreeCfg[arg_11_1].index)]

	if var_11_0 then
		var_11_0.text = string.format("%d%%", TalentTreeData:GetTalentLevel(arg_11_1) / TalentTreeCfg[arg_11_1].max_level * 100)
	end
end

function TalentTreeMainView:RefreshCost()
	local var_12_0 = TalentTreeData:GetTalentLevel(self.currenttalentID_)

	if var_12_0 < TalentTreeCfg[self.currenttalentID_].max_level then
		SetActive(self.upGo_, true)

		self.costText_.text = TalentTreeCfg[self.currenttalentID_].cost[var_12_0 + 1][2]
		self.costText_.color = ItemTools.getItemNum(TalentTreeCfg[self.currenttalentID_].cost[var_12_0 + 1][1]) >= TalentTreeCfg[self.currenttalentID_].cost[var_12_0 + 1][2] and CurrencyConst.ENOUGH_COLOR_LIGHT or CurrencyConst.LACK_COLOR
	else
		SetActive(self.upGo_, false)
	end
end

function TalentTreeMainView:RefreshRedPoint()
	for iter_13_0 = 1, var_0_1 do
		local var_13_0 = self[string.format("race%dBtn_", iter_13_0)]

		if var_13_0 then
			manager.redPoint:SetRedPointIndependent(var_13_0.transform, TalentTreeTools.IsCanUp(self.raceToId_[iter_13_0]))
		end
	end
end

function TalentTreeMainView:SelectItem(arg_14_1)
	local var_14_0 = self.raceToId_[arg_14_1]
	local var_14_1 = TalentTreeCfg[self.raceToId_[arg_14_1]].race

	if self.currenttalentID_ == self.raceToId_[arg_14_1] then
		return
	end

	if self.currenttalentID_ then
		local var_14_2 = self[string.format("select%dGo_", TalentTreeCfg[self.currenttalentID_].index)]

		if var_14_2 then
			SetActive(var_14_2, false)
		end
	end

	self.currenttalentID_ = var_14_0

	SetActive(self.introduceGo_, var_14_1 == 0)
	SetActive(self.talentProgressGo_, var_14_1 ~= 0)

	local var_14_3 = self[string.format("select%dGo_", arg_14_1)]

	if var_14_3 then
		SetActive(var_14_3, true)
	end

	if var_14_1 ~= 0 then
		self:RefreshItem(var_14_0)
	else
		self.levelUpTrs_.localPosition = Vector3.New(0, 9999, 0)
	end

	self:RefreshCost()
end

function TalentTreeMainView:OnUpTalentLevel(arg_15_1, arg_15_2)
	self:RefreshItem(arg_15_2.id)
	self:PlayLevelUpAni(arg_15_2.id)
	self:RefreshCost()
	self:RefreshRedPoint()
end

function TalentTreeMainView:OnEnter()
	if not self.activityId_ or self.params_.activityID ~= self.activityId_ then
		self.activityId_ = self.params_.activityID

		self:InitGo(TalentTreeTools.GetMainUIName(self.activityId_))
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_HELLA_TALENT_TREE_COIN
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_HELLA_TALENT_TREE_COIN, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_HELLA_TALENT_DESCRIPE")
	self:RefreshUI()
	self:RefreshRedPoint()
	self:SelectItem(0)
end

function TalentTreeMainView:OnExit()
	manager.windowBar:HideBar()

	self.raceToId_ = {}
	self.levelUpTrs_.localPosition = Vector3.New(0, 9999, 0)
end

return TalentTreeMainView

local ActivityPtScrollAffixSelectView = class("ActivityPtScrollAffixSelectView", ReduxView)

function ActivityPtScrollAffixSelectView:UIName()
	return "Widget/Common/Pop/SuitSelectUI"
end

function ActivityPtScrollAffixSelectView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityPtScrollAffixSelectView:OnCtor()
	return
end

function ActivityPtScrollAffixSelectView:Init()
	self:InitUI()
	self:AddListeners()
end

function ActivityPtScrollAffixSelectView:InitUI()
	self:BindCfgUI()

	self.tgl_ = {}
	self.tglCon_ = {}
	self.todayCon_ = {}

	for iter_5_0 = 1, 7 do
		local var_5_0 = Object.Instantiate(self.tempBtn_.gameObject, self.contentGo_.transform)

		var_5_0.transform:Find("text").gameObject:GetComponent("Text").text = GetTips("ACTIVITY_ROULETTE_WEEK_" .. iter_5_0)
		var_5_0.name = "tgl_" .. iter_5_0

		SetActive(var_5_0, true)

		self.tgl_[iter_5_0] = var_5_0.transform:GetComponent("Toggle")
		self.tglCon_[iter_5_0] = ControllerUtil.GetController(self.tgl_[iter_5_0].transform, "toggle")
		self.todayCon_[iter_5_0] = ControllerUtil.GetController(self.tgl_[iter_5_0].transform, "isToday")
	end

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.itempanelGo_, SuitSelectItem)
	self.autoDecomposeController_ = self.controllerEx_:GetController("autoDecompose")
	self.autoFlagController_ = self.controllerEx_:GetController("autoFlag")

	self.autoDecomposeController_:SetSelectedState("true")
end

function ActivityPtScrollAffixSelectView:IndexItem(arg_6_1, arg_6_2)
	local var_6_0 = self.curSuitList_[arg_6_1]

	arg_6_2:ShowSelect(self.curSuitList_[arg_6_1] == self.selectSuitId_)
	arg_6_2:ShowCurrentUp(var_6_0 == self.upID_ and self.selectDay_ == self.nowDay_)
	arg_6_2:RefreshData(self, {
		id = var_6_0
	})
	arg_6_2:RegistCallBack(function(arg_7_0)
		self:SetSelect(arg_7_0)
	end)
end

function ActivityPtScrollAffixSelectView:AddListeners()
	self:AddBtnListener(self.bgMaskBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListenerScale(self.upBtn_, nil, function()
		ActivityPtScrollAction.SetSelectSuit(self.activityID_, self.selectSuitId_)
	end)
	self:AddBtnListener(self.selectBtn_, nil, function()
		if self.buttonUp_ and self.buttonUp_ > 0 then
			self:HidePop()
			FuncTimerManager.inst:RemoveFuncTimer(self.clickTimer_)

			self.clickTimer_ = nil

			return
		end

		SetActive(self.contentGo_, true)
		self:AddClickTimer()
	end)

	for iter_8_0, iter_8_1 in ipairs(self.tgl_) do
		self:AddToggleListener(iter_8_1, function(arg_12_0)
			if arg_12_0 then
				self:RefreshDay(iter_8_0)
			end
		end)
	end

	self:AddBtnListener(self.autoDecomposeBtn_, nil, function()
		if not EquipData:GetAutoDecompose(BattleConst.BATTLE_EQUIP_TYPE.PT) then
			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("AUTO_DECOMPOSE_TIPS"),
				OkCallback = function()
					EquipAction.SetAutoDecomposeState(BattleConst.BATTLE_EQUIP_TYPE.PT, true, function()
						ShowTips("AUTO_DECOMPOSE_OPEN")
						self:RefreshAutoState()
					end)
				end,
				CancelCallback = function()
					return
				end
			})
		else
			EquipAction.SetAutoDecomposeState(BattleConst.BATTLE_EQUIP_TYPE.PT, false, function()
				ShowTips("AUTO_DECOMPOSE_CLOSE")
				self:RefreshAutoState()
			end)
		end
	end)
end

function ActivityPtScrollAffixSelectView:OnEnter()
	self.scrollList_ = {}
	self.activityID_ = self.params_.mainActivityID

	for iter_18_0, iter_18_1 in ipairs(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[self.activityID_]) do
		if ActivityPtRouletteStageCfg[iter_18_1].mode == 2 then
			self.scrollList_ = ActivityPtRouletteStageCfg[iter_18_1].roulette_id

			break
		end
	end

	self.isSelect_, self.upID_ = ActivityPtScrollData:GetUpSelect(self.activityID_)
	self.nowDay_ = ActivityPtRouletteRandomCfg[ActivityPtScrollData:GetPoolID(self.activityID_)].time

	self:RefreshDay(self.nowDay_)
	self:ResetSort()
	saveData("activityPtScroll", "last_check_up", (manager.time:GetServerTime()))
	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. self.activityID_, 0)
	self:RefreshAutoState()
end

function ActivityPtScrollAffixSelectView:RefreshDay(arg_19_1)
	self.selectDay_ = arg_19_1
	self.selectText_.text = GetTips("ACTIVITY_ROULETTE_WEEK_" .. self.selectDay_)

	self:RefreshList()
	self:RefreshInfo()
end

function ActivityPtScrollAffixSelectView:ResetSort()
	self.tgl_[self.selectDay_].isOn = true

	for iter_20_0, iter_20_1 in ipairs(self.tglCon_) do
		iter_20_1:SetSelectedState(iter_20_0 == self.selectDay_ and "on" or "off")
		self.todayCon_[iter_20_0]:SetSelectedState(iter_20_0 == self.selectDay_ and "true" or "false")
	end
end

function ActivityPtScrollAffixSelectView:RefreshList()
	self.curSuitList_ = {}

	for iter_21_0, iter_21_1 in ipairs(self.scrollList_) do
		if ActivityPtRouletteRandomCfg[iter_21_1].time == self.selectDay_ then
			self.curSuitList_ = ActivityPtRouletteRandomCfg[iter_21_1].equip_suit_list

			break
		end
	end

	if self.selectDay_ == self.nowDay_ then
		self.selectSuitId_ = self.upID_ or self.curSuitList_[1]
	end

	self.scrollHelper_:StartScroll(#self.curSuitList_)
end

function ActivityPtScrollAffixSelectView:RefreshInfo()
	if not EquipSuitCfg[self.selectSuitId_] then
		SetActive(self.infoGo_, false)

		return
	end

	SetActive(self.infoGo_, true)

	self.nameText_.text = EquipSuitCfg[self.selectSuitId_].name
	self.numText_.text = EquipSuitCfg[self.selectSuitId_].need
	self.contentText_.text = EquipTools.GetEffectDesc(EquipSuitCfg[self.selectSuitId_].suit_effect[1])

	SetActive(self.upBtn_.gameObject, self.selectSuitId_ ~= self.upID_ and self.selectDay_ == self.nowDay_)
	SetActive(self.tipGo_, self.selectDay_ ~= self.nowDay_)
end

function ActivityPtScrollAffixSelectView:SetSelect(arg_23_1)
	self.selectSuitId_ = arg_23_1.id

	for iter_23_0, iter_23_1 in ipairs(self.scrollHelper_:GetItemList()) do
		iter_23_1:ShowSelect(iter_23_1.info_.id == self.selectSuitId_)
	end

	self:RefreshInfo()
end

function ActivityPtScrollAffixSelectView:AddClickTimer()
	self:StopTimer()

	self.buttonUp_ = 0
	self.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		if Input.GetMouseButtonUp(0) then
			self.buttonUp_ = self.buttonUp_ + 1

			if self.buttonUp_ >= 2 then
				self:HidePop()
				FuncTimerManager.inst:RemoveFuncTimer(self.clickTimer_)

				self.clickTimer_ = nil
			end
		end
	end, -1, true)
end

function ActivityPtScrollAffixSelectView:StopTimer()
	if self.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(self.clickTimer_)

		self.clickTimer_ = nil
	end
end

function ActivityPtScrollAffixSelectView:HidePop()
	self.buttonUp_ = 0

	SetActive(self.contentGo_, false)
end

function ActivityPtScrollAffixSelectView:OnSetSelectSuit()
	self.isSelect_, self.upID_ = ActivityPtScrollData:GetUpSelect(self.activityID_)

	self:RefreshDay(self.nowDay_)
end

function ActivityPtScrollAffixSelectView:OnExit()
	self.selectSuitId_ = nil
end

function ActivityPtScrollAffixSelectView:Dispose()
	self.scrollHelper_:Dispose()
	ActivityPtScrollAffixSelectView.super.Dispose(self)
end

function ActivityPtScrollAffixSelectView:RefreshAutoState()
	self.autoFlagController_:SetSelectedState(tostring((EquipData:GetAutoDecompose(BattleConst.BATTLE_EQUIP_TYPE.PT))))
end

return ActivityPtScrollAffixSelectView

local HeroEquipBagView = class("HeroEquipBagView", ReduxView)

function HeroEquipBagView:UIName()
	return "Widget/System/Hero_equip/HeroEquipSwitchUI"
end

function HeroEquipBagView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroEquipBagView:OnCtor()
	return
end

function HeroEquipBagView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroEquipBagView:InitUI()
	self:BindCfgUI()

	self.equipBag_ = EquipBagView.New(self, self.equipBagGo_, {
		suitPos = self.params_.suitPos
	})

	self.equipBag_:RegisterItemClick(handler(self, self.ClickBagItem))

	self.equipInfoViewRight_ = EquipInfoView.New(self.rightInfo_)
	self.equipInfoViewMiddle_ = EquipInfoView.New(self.middleInfo_)
	self.middleTransAnchor_ = self.equipInfoViewMiddle_.transform_.anchoredPosition

	self.equipInfoViewRight_:RegisterSkillClick(handler(self, self.SkillClick), false)
	self.equipInfoViewMiddle_:RegisterSkillClick(handler(self, self.SkillClick), true)
	self.equipInfoViewRight_:RegisterChange(function(arg_6_0)
		self.equipInfoViewMiddle_:ChangeSelect(arg_6_0)

		self.rightInfoType = arg_6_0
	end)
	self.equipInfoViewMiddle_:RegisterChange(function(arg_7_0)
		if arg_7_0 == "suit" and self.popController_:GetSelectedState() ~= "onlyEquip" then
			self.popController_:SetSelectedState("onlyEquip")
		end

		self.equipInfoViewRight_:ChangeSelect(arg_7_0)

		self.rightInfoType = arg_7_0
	end)

	self.equipSkillView_ = EquipNewSkillInfoView.New(self.skillInfo_)
	self.popController_ = self.popCon_:GetController("popState")
	self.rightEmptyController_ = self.rightCon_:GetController("empty")

	self:InitEquipDiscNextFrame()

	self.leftPopTrans_ = self.swapGo_.transform
	self.rightRootTrans_ = self.rightCon_.transform
end

function HeroEquipBagView:InitEquipDiscNextFrame()
	local var_8_0

	var_8_0 = FrameTimer.New(function()
		var_8_0:Stop()

		self.equipDiscGo_ = Object.Instantiate(Asset.Load("Widget/System/Hero_equip/EquipDisc"), self.discParent_, false)
		self.equipDiscGo_.transform.localScale = Vector3(1.2, 1.2, 1.2)
		self.equipDisc_ = EquipDisc.New(self.equipDiscGo_)

		self.equipDisc_:OnEnter()
		self.equipDisc_:Rotate(5, self.selectPos_)
		self.equipDisc_:RefreshItem(self.equipDataList)
	end, 1, 1)

	;(nil):Start()
end

function HeroEquipBagView:AddUIListener()
	self:AddBtnListenerScale(self.btnUnloadAll_, nil, function()
		if not _G.SkipTip.SkipUninstallEquipTip and SettingData:GetRemindSettingData().uninstall_equip_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_ONE_CLICK_UNINSTALL_WARNING"),
				OkCallback = function()
					_G.SkipTip.SkipUninstallEquipTip = self.SkipUninstallEquipTip

					HeroAction.EquipUnloadAll(self.params_.heroId)
				end,
				ToggleCallback = function(arg_13_0)
					self.SkipUninstallEquipTip = arg_13_0
				end
			})
		else
			HeroAction.EquipUnloadAll(self.params_.heroId)
		end
	end)
	self:AddBtnListenerScale(self.btnScheme_, nil, function()
		self:Go("/EquipProposal", {
			heroID = self.params_.heroId,
			proxy = self.params_.proxy
		})
	end)
	self:AddBtnListener(self.btnMask1_, nil, function()
		self:HidePopView()
	end)
	self:AddBtnListener(self.btnDecompose_, nil, function()
		JumpTools.GoToSystem("/equipDecompose")
	end)
end

function HeroEquipBagView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		4,
		0,
		true
	})
end

function HeroEquipBagView:OnEnter()
	self.equipList_ = {}
	self.rightInfoType = "suit"
	self.heroInfo_ = HeroData:GetHeroData(self.params_.heroId)
	self.heroViewDataProxy_ = self.params_.proxy

	self.equipInfoViewRight_:OnEnter(self.heroViewDataProxy_)
	self.equipInfoViewMiddle_:OnEnter(self.heroViewDataProxy_)

	local var_18_0 = self.selectPos_ or self.params_.suitPos

	self.selectPos_ = var_18_0

	if self.equipDisc_ then
		self.equipDisc_:OnEnter()

		if self.params_.translationAnim then
			self.equipDisc_:Rotate(self.selectPos_, self.selectPos_)
		else
			self.equipDisc_:Rotate(5, self.selectPos_)
		end
	end

	self.lastPos_ = var_18_0

	self.enterAnim_:Play("Fx_Equip_change", -1, 0)
	self.enterAnim_:Update(0)
	self.equipBag_:OnEnter({
		heroId = self.params_.heroId,
		suitPos = self.selectPos_
	})
	self:RefreshHeroEquipS()
end

function HeroEquipBagView:OnTop()
	self:UpdateBar()

	if self.params_.needRefresh then
		self.equipBag_:RefreshData(self, {
			heroId = self.params_.heroId,
			suitPos = self.params_.suitPos,
			suit = self.params_.suit
		})
	end

	self.params_.suit = nil
	self.params_.needRefresh = nil
end

function HeroEquipBagView:RefreshHeroEquipS(arg_20_1)
	self.equipBag_:Render()

	self.equipDataList = self.heroViewDataProxy_:GetEquipDataList(self.params_.heroId)

	for iter_20_0, iter_20_1 in ipairs((self.heroViewDataProxy_:GetEquipInfoList(self.params_.heroId))) do
		self.equipList_[iter_20_1.pos] = iter_20_1.equip_id
	end

	self:RefreshRightEquipInfo()

	if self.equipDisc_ then
		if arg_20_1 and arg_20_1.isShow then
			self.equipDisc_:ShowAnim(arg_20_1.pos)
		end

		self.equipDisc_:RefreshItem(self.equipDataList)
	end
end

function HeroEquipBagView:RefreshRightEquipInfo()
	self.equipId_ = self.equipList_[self.selectPos_]
	self.equip_ = self.equipId_ ~= 0 and EquipData:GetEquipData(self.equipId_) or nil

	if self.equip_ then
		self.rightEmptyController_:SetSelectedState("notEmpty")

		local var_21_0 = HeroCfg[self.params_.heroId].race

		self.equipInfoViewRight_:RefreshData(self, self.equip_, handler(self, self.RefreshEquipLock), self.params_.heroId, self.equip_.equip_id)
		self.equipInfoViewRight_:ShowRaceAdd(self.equip_.race == var_21_0 or self.equip_.race == self.params_.heroId)
	else
		self.rightEmptyController_:SetSelectedState("empty")
	end
end

function HeroEquipBagView:RefreshPos(arg_22_1)
	self:HidePopView()

	self.lastPos_ = self.selectPos_
	self.selectPos_ = arg_22_1 or self.selectPos_

	self.equipDisc_:RotateServant(self.lastPos_, self.selectPos_)
	self:RefreshRightEquipInfo()
end

function HeroEquipBagView:ClickBagItem(arg_23_1, arg_23_2)
	local var_23_0 = HeroCfg[self.params_.heroId].race

	self.equipInfoViewMiddle_.transform_.anchoredPosition = Vector2.New(self.middleTransAnchor_.x + self.leftTrans_.anchoredPosition.x, self.middleTransAnchor_.y)

	self.equipInfoViewMiddle_:RefreshData(self, arg_23_1.equip_info, handler(self, self.RefreshEquipLock), self.params_.heroId, self.heroInfo_.equip[EquipCfg[arg_23_1.equip_info.prefab_id].pos].equip_id)
	self.equipInfoViewMiddle_:ShowRaceAdd(arg_23_1.equip_info.race == var_23_0 or arg_23_1.equip_info.race == self.params_.heroId)

	self.bagSelectItem_ = arg_23_2

	if self.selectSkillItem_ then
		self.selectSkillItem_:ShowSelect(false)
	end

	self.popController_:SetSelectedState("onlyEquip")
end

function HeroEquipBagView:SkillClick(arg_24_1, arg_24_2, arg_24_3)
	self.equipSkillView_:RefreshData(self, arg_24_2)

	self.selectSkillItem_ = arg_24_1

	if self.bagSelectItem_ then
		self.bagSelectItem_:RefreshSelectState2(false)
	end

	local var_24_0 = arg_24_3 and 0 or -48 - self.rightTrans_.anchoredPosition.x

	self.skillInfo_.transform.anchorMin = arg_24_3 and Vector2.New(0, 0) or Vector2.New(1, 0)
	self.skillInfo_.transform.anchorMax = arg_24_3 and Vector2.New(0, 1) or Vector2.New(1, 1)

	local var_24_3

	if arg_24_3 then
		var_24_3 = self.leftPopTrans_ or self.rightRootTrans_
	end

	self.skillInfo_.transform.pivot = var_24_3.pivot
	self.skillInfo_.transform.anchoredPosition = Vector3.New(((arg_24_3 or nil) and (var_24_3.anchoredPosition.x + 576 or var_24_3.anchoredPosition.x - 550)) - var_24_0, var_24_3.anchoredPosition.y, 0)

	self.popController_:SetSelectedState(arg_24_3 and "equipAndSkill" or "onlySkill")
end

function HeroEquipBagView:RefreshEquipLock(arg_25_1, arg_25_2)
	self.equipBag_:RefreshEquipLock(arg_25_1, arg_25_2)
end

function HeroEquipBagView:OnEquipSwap(arg_26_1, arg_26_2)
	self.heroInfo_ = HeroData:GetHeroData(self.params_.heroId)

	if isSuccess(arg_26_1.result) then
		if arg_26_2.equip_id == 0 then
			ShowTips("EQUIP_UNBIND")
		else
			ShowTips("EQUIP_BIND")
		end

		self.equipBag_:ClearSelect()
		self:RefreshHeroEquipS({
			pos = arg_26_2.pos,
			isShow = arg_26_2.equip_id ~= 0
		})
		self.popController_:SetSelectedState("hide")
	else
		ShowTips(arg_26_1.result)
	end
end

function HeroEquipBagView:OnEquipUnloadAll(arg_27_1, arg_27_2)
	if isSuccess(arg_27_1.result) then
		ShowTips("EQUIP_UNBIND")
		self:RefreshHeroEquipS()
	else
		ShowTips(arg_27_1.result)
	end
end

function HeroEquipBagView:KeepFilter()
	self.keepFilter_ = true
end

function HeroEquipBagView:HidePopView()
	self.equipBag_:ClearSelect()
	self.popController_:SetSelectedState("hide")
	self.equipInfoViewRight_:DeSelect()
	self.equipInfoViewMiddle_:DeSelect()

	if self.selectSkillItem_ then
		self.selectSkillItem_:ShowSelect(false)

		self.selectSkillItem_ = nil
	end

	if self.bagSelectItem_ then
		self.bagSelectItem_:RefreshSelectState2(false)

		self.bagSelectItem_ = nil
	end
end

function HeroEquipBagView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("EQUIP_EQUIP")
end

function HeroEquipBagView:OnExit()
	manager.windowBar:HideBar()

	if not self.keepFilter_ then
		self.equipBag_:OnExit()
	else
		self.keepFilter_ = false
	end

	self.selectPos_ = nil
	self.lastPos_ = nil

	self:HidePopView()
end

function HeroEquipBagView:Dispose()
	if self.equipBag_ then
		self.equipBag_:Dispose()

		self.equipBag_ = nil
	end

	if self.equipInfoViewRight_ then
		self.equipInfoViewRight_:Dispose()

		self.equipInfoViewRight_ = nil
	end

	if self.equipInfoViewMiddle_ then
		self.equipInfoViewMiddle_:Dispose()

		self.equipInfoViewMiddle_ = nil
	end

	if self.equipSkillView_ then
		self.equipSkillView_:Dispose()

		self.equipSkillView_ = nil
	end

	if self.equipDisc_ then
		self.equipDisc_:Dispose()

		self.equipDisc_ = nil
	end

	HeroEquipBagView.super.Dispose(self)
end

return HeroEquipBagView

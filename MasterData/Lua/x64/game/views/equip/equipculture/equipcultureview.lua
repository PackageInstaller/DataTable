local EquipCultureView = class("EquipCultureView", ReduxView)

function EquipCultureView:UIName()
	return "Widget/System/Hero_equip/Develop/EquipCultureUI"
end

function EquipCultureView:UIParent()
	return manager.ui.uiMain.transform
end

function EquipCultureView:Init()
	self.selectIndex_ = -1

	self:InitUI()
	self:AddUIListener()
end

function EquipCultureView:InitUI()
	self:BindCfgUI()

	self.group = {
		self.btn_detail,
		self.btn_levelup,
		self.btn_upgrade,
		self.btn_enchant,
		self.btn_reset,
		self.btn_inherit
	}
	self.SetBarInSelfView = {
		nil,
		true,
		true,
		nil,
		true,
		true
	}
	self.class_ = {
		EquipDetailView,
		EquipLevelUpView,
		EquipUpgradeView,
		EquipEnchantView,
		EquipResetView,
		EquipInheritView
	}
	self.prefabPath_ = {
		"Widget/System/Hero_equip/Develop/EquipDetailUI",
		"Widget/System/Hero_equip/Develop/EquipLevelUpUI",
		"Widget/System/Hero_equip/Develop/EquipUpgradeUI",
		"Widget/System/Hero_equip/Develop/EquipEnchantUI",
		"Widget/System/Hero_equip/Develop/EquipResetUI",
		"Widget/System/Hero_equip/Develop/EquipInheritUI"
	}
	self.equipTgl_ = {}
	self.posIcon_ = {}

	for iter_4_0 = 1, 6 do
		self.equipTgl_[iter_4_0] = self["equipBtn_" .. iter_4_0]
		self.posIcon_[iter_4_0] = self["posIcon_" .. iter_4_0]
	end

	self.heroEquipController_ = self.cultureCon_:GetController("equipped")
	self.popController_ = self.cultureCon_:GetController("pop")
	self.equipPosController_ = self.equipPos_:GetController("pos")
	self.equipInfo_ = EquipInfoView.New(self.equipInfoGo_)
	self.skillInfo_ = EquipNewSkillInfoView.New(self.skillInfoGo_)
	self.equipDisc_ = EquipDisc.New(self.discGo_)
	self.pages_ = {}
end

function EquipCultureView:AddUIListener()
	self.sidebarCon_ = {}

	for iter_5_0, iter_5_1 in pairs(self.group) do
		self:AddBtnListener(iter_5_1, nil, function()
			self:GoToTarget(iter_5_0)
		end)

		self.sidebarCon_[iter_5_0] = iter_5_1.gameObject:GetComponent("ControllerExCollection"):GetController("btnController")
	end

	for iter_5_2 = 1, 6 do
		self:AddBtnListener(self.equipTgl_[iter_5_2], nil, function()
			if self.equipList_[iter_5_2].equip_id ~= 0 and self.index_ ~= iter_5_2 then
				manager.audio:PlayEffect("ui_system_3_0", "ui_sight_listchange", "")
				self:RefreshDisc(iter_5_2)
				self:RefreshPosBtn(iter_5_2)
				self:RefreshSideBar(self.equipList_[iter_5_2].equip_id)
			end
		end)
	end

	self:AddBtnListener(self.btnHidePop_, nil, function()
		self:ClearSkillSelect()
		self.popController_:SetSelectedState("hide")
	end)
end

function EquipCultureView:OnEnter()
	self.heroViewProxy_ = self.params_.proxy
	self.equipId_ = self.params_.equipId
	self.equip = self.equipId_ and EquipData:GetEquipData(self.equipId_) or EquipStruct.New(0, self.params_.prefabId)

	self.equipDisc_:OnEnter()

	self.index_ = EquipCfg[self.equip.prefab_id].pos
	self.oldIndex_ = self.params_.rotateAnim and 5 or EquipCfg[self.equip.prefab_id].pos

	self.equipDisc_:Rotate(self.oldIndex_, self.index_)

	if not self.params_.rotateAnim then
		self.discAnim_:Play("EquipCultureUI")
	end

	self:RefreshView()
	self:RefreshSideBar(self.equipId_)
	self:RegistEventListener(EQUIP_UPGRADE_SUCCESS, handler(self, self.OnEquipUpgradeSuccess))
end

function EquipCultureView:ChangeBar()
	if self.SetBarInSelfView[self.curPageIndex_] then
		return
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function EquipCultureView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		4,
		1,
		true
	})
end

function EquipCultureView:OnTop()
	self:ChangeBar()

	if self.pages_[self.curPageIndex_] then
		self.pages_[self.curPageIndex_]:OnTop()
	end

	if GameSetting.equip_culture_describe then
		local var_12_0 = GameSetting.equip_culture_describe.value or {}
	end

	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_12_0
		})
	end)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back(1, {
			translationAnim = true,
			suitPos = self.index_
		})
	end)
end

function EquipCultureView:RefreshView()
	self.equipPos_ = {}
	self.heroId_ = HeroData:GetEquipMap()[self.equipId_]

	local var_15_0 = self.heroId_ and self.heroId_ ~= 0

	self.heroEquipController_:SetSelectedState(tostring(var_15_0))

	if var_15_0 then
		self.equipList_ = HeroTools.GetHeroEquipS(self.heroId_)
		self.equipDataList_ = EquipTools.GetEquipDataList(self.equipList_)

		self.equipDisc_:RefreshItem(self.equipDataList_)
		self:RefreshHero(self.heroId_)
		self:RefreshPosBtn(self.index_)
	else
		self.equipDisc_:HideItems()
		self.equipDisc_:RefreshItemByIndex(self.index_, self.equip)
	end
end

function EquipCultureView:RefreshHero(arg_16_1)
	self.heroIcon_.sprite = SpritePathCfg.HeroMediumIcon.path .. HeroTools.HeroUsingSkinInfo(arg_16_1).id
	self.heroGroupIcon_.sprite = getSprite("Atlas/SystemGroupAtlas", (string.format("com_white_icon_group_%s_c", HeroCfg[arg_16_1].race)))
end

function EquipCultureView:RefreshPosBtn(arg_17_1)
	self.equipPosController_:SetSelectedState(self.index_)

	for iter_17_0, iter_17_1 in ipairs(self.equipList_) do
		self.equipTgl_[iter_17_0].interactable = iter_17_1.equip_id ~= 0
		self.posIcon_[iter_17_0].color = iter_17_1.equip_id ~= 0 and Color.New(0.4235294117647059, 0.4980392156862745, 0.5647058823529412, 1) or Color.New(0.49019607843137253, 0.5411764705882353, 0.596078431372549, 0.5019607843137255)
	end
end

function EquipCultureView:RefreshDisc(arg_18_1)
	self.oldIndex_ = self.index_
	self.index_ = arg_18_1 or self.index_

	self.equipDisc_:RotateServant(self.oldIndex_, self.index_)
end

function EquipCultureView:GoToTarget(arg_19_1)
	if self.curPageIndex_ == arg_19_1 then
		return
	end

	if self.pages_[self.curPageIndex_] then
		self.pages_[self.curPageIndex_]:Hide()
	end

	if self.curPageIndex_ then
		self.sidebarCon_[self.curPageIndex_]:SetSelectedState("false")
	end

	self.sidebarCon_[arg_19_1]:SetSelectedState("true")

	self.curPageIndex_ = arg_19_1
	self.params_.pageIndex = arg_19_1

	local var_19_0 = {
		equipId = self.equipId_,
		heroId = self.heroId_,
		prefabId = self.params_.prefabId,
		proxy = self.heroViewProxy_
	}

	if not self.pages_[arg_19_1] then
		if self.prefabPath_[arg_19_1] and self.class_[arg_19_1] then
			self.pages_[arg_19_1] = self.class_[arg_19_1].New(self, Object.Instantiate(Asset.Load(self.prefabPath_[arg_19_1]), self.pageContainer_), var_19_0)

			self.pages_[arg_19_1]:Show(var_19_0)
		end
	else
		self.pages_[arg_19_1]:Show(var_19_0)
	end

	if arg_19_1 == 5 and self.equip.race_preview ~= 0 then
		JumpTools.OpenPageByJump("/equipRaceConfirmView", var_19_0)
	end

	self:ChangeBar()
end

function EquipCultureView:RefreshSideBar(arg_20_1)
	self.equipId_ = arg_20_1
	self.params_.equipId = arg_20_1
	self.equip = EquipData:GetEquipData(self.equipId_)

	if self.equip then
		local var_20_0 = self.params_.pageIndex
		local var_20_2 = self.equip:GetMaxLv() <= self.equip:GetLevel() and self.equip.now_break_level < EquipCfg[self.equip.prefab_id].break_times_max
		local var_20_3 = not var_20_2
		local var_20_4 = EquipCfg[self.equip.prefab_id].starlevel >= 4
		local var_20_5 = EquipCfg[self.equip.prefab_id].starlevel >= 5 and (self.equip.race == 0 or table.keyof(RaceEffectCfg.all, self.equip.race) ~= nil)
		local var_20_6 = EquipCfg[self.equip.prefab_id].starlevel >= 5 and self.equip.race ~= 0 and table.keyof(RaceEffectCfg.all, self.equip.race) == nil

		SetActive(self.gameObject_levelup, not var_20_2)
		SetActive(self.gameObject_upgrade, var_20_2)
		SetActive(self.gameObject_enchant, var_20_4)
		SetActive(self.gameObject_reset, var_20_5)
		SetActive(self.gameObject_inherit, var_20_6)

		if var_20_0 == 2 and var_20_2 then
			var_20_0 = 3
		elseif var_20_0 == 3 and var_20_3 then
			var_20_0 = 2
		elseif var_20_0 == 4 and not var_20_4 or var_20_0 == 5 and not var_20_5 or var_20_0 == 6 and not var_20_6 then
			var_20_0 = 1
		end

		self:GoToTarget(var_20_0)
		self.pages_[var_20_0]:OnEquipChange(self.equipId_)

		if var_20_0 == self.params_.pageIndex then
			self.equipDisc_:RefreshItemByIndex(self.index_, self.equip)
		end

		return var_20_0
	else
		self:GoToTarget(1)
		SetActive(self.gameObject_levelup, false)
		SetActive(self.gameObject_upgrade, false)
		SetActive(self.gameObject_enchant, false)
		SetActive(self.gameObject_reset, false)
		SetActive(self.gameObject_inherit, false)

		return 0
	end
end

function EquipCultureView:RefreshEquipInfo(arg_21_1, arg_21_2, arg_21_3)
	self.equipCommonItem_ = arg_21_2

	self.equipInfo_:RefreshData(self, arg_21_1, arg_21_3, self.heroId_, self.equipId_)
	self.popController_:SetSelectedState("equip")
end

function EquipCultureView:RefreshSkillInfo(arg_22_1, arg_22_2)
	self.skillItem_ = arg_22_1

	self.skillInfo_:RefreshData(self, arg_22_2)
	self.popController_:SetSelectedState("skill")
end

function EquipCultureView:HidePop()
	self:ClearEquipSelect()
	self:ClearSkillSelect()
	self.popController_:SetSelectedState("hide")
end

function EquipCultureView:ClearEquipSelect()
	if self.equipCommonItem_ then
		self.equipCommonItem_:RefreshSelectState(false)

		self.equipCommonItem_ = nil
	end
end

function EquipCultureView:ClearSkillSelect()
	if self.skillItem_ then
		self.skillItem_:ShowSelect(false)

		self.skillItem_ = nil
	end
end

function EquipCultureView:OnEquipUpgradeSuccess(arg_26_1)
	self:RefreshSideBar(arg_26_1.equipId)
	JumpTools.OpenPageByJump("equipCulturePopView", arg_26_1)
end

function EquipCultureView:OnEquipInherit()
	self.equip = EquipData:GetEquipData(self.equipId_)

	self.equipDisc_:RefreshItemByIndex(self.index_, self.equip)
	self.pages_[6]:ResetInherit()
end

function EquipCultureView:GetEquipId()
	return self.equipId_
end

function EquipCultureView:GetCulturePage()
	return self.curPageIndex_
end

function EquipCultureView:OnExit()
	manager.windowBar:HideBar()
	self:HidePop()

	if self.curPageIndex_ ~= nil then
		if self.sidebarCon_[self.curPageIndex_] then
			self.sidebarCon_[self.curPageIndex_]:SetSelectedState("false")
		end

		if self.pages_[self.curPageIndex_] then
			self.pages_[self.curPageIndex_]:Hide()
		end

		self.curPageIndex_ = nil
	end
end

function EquipCultureView:Dispose()
	self:RemoveAllListeners()

	for iter_31_0, iter_31_1 in pairs(self.pages_) do
		iter_31_1:Dispose()
	end

	self.pages_ = nil

	self.equipInfo_:Dispose()
	self.skillInfo_:Dispose()
	self.equipDisc_:Dispose()
	EquipCultureView.super.Dispose(self)
end

return EquipCultureView

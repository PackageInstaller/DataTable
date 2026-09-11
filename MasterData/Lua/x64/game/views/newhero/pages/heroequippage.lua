local HeroEquipPage = class("HeroEquipPage", HeroPageBase)

function HeroEquipPage:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function HeroEquipPage:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroEquipPage:InitUI()
	self:BindCfgUI()

	self.detailController_ = self.controller_:GetController("detail")
	self.isSelfController_ = self.controller_:GetController("isSelf")
	self.skillPopController_ = self.controller_:GetController("skill")
	self.equipDisc_ = EquipDisc.New(self.discGo_)

	self.equipDisc_:RegistItemButton(handler(self, self.OnClickItem))

	self.equipInfo_ = EquipInfoView.New(self.equipInfoGo_)

	self.equipInfo_:RegisterSkillClick(handler(self, self.SkillClick))
	self.equipInfo_:RegistHeroButton(handler(self, self.GoEquipBag), handler(self, self.GoEquipCulture))

	self.equipOverrall_ = EquipOverall.New(self.rightGo_)

	self.equipOverrall_:RegistSkillClick(handler(self, self.SkillClick))

	self.equipSkillPop_ = EquipNewSkillInfoView.New(self.equipSkillGo_)
end

function HeroEquipPage:AddUIListener()
	self:AddBtnListener(self.btnPopMask_, nil, function()
		self:HideMaskMessage()
	end)
	self:AddBtnListener(self.btnUnload_, nil, function()
		local var_6_0 = false

		for iter_6_0, iter_6_1 in ipairs(self.heroViewProxy_:GetEquipInfoList(self.heroInfo_.id) or {}) do
			if iter_6_1.equip_id ~= 0 then
				var_6_0 = true

				break
			end
		end

		if not var_6_0 then
			ShowTips("ERROR_EQUIP_NOT")

			return
		end

		if not _G.SkipTip.SkipUninstallEquipTip and SettingData:GetRemindSettingData().uninstall_equip_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_ONE_CLICK_UNINSTALL_WARNING"),
				OkCallback = function()
					_G.SkipTip.SkipUninstallEquipTip = self.SkipUninstallEquipTip

					HeroAction.EquipUnloadAll(self.heroInfo_.id)
				end,
				ToggleCallback = function(arg_8_0)
					self.SkipUninstallEquipTip = arg_8_0
				end
			})
		else
			HeroAction.EquipUnloadAll(self.heroInfo_.id)
		end
	end)
	self:AddBtnListener(self.btnOption_, nil, function()
		self.isGoSubPanel = true

		self:Go("/EquipProposal", {
			heroID = self.heroInfo_.id,
			proxy = self.heroViewProxy_
		})
	end)
	self:AddBtnListener(self.mask_, nil, function()
		self.detailController_:SetSelectedState("false")
		self.equipDisc_:Reset()
	end)
end

function HeroEquipPage:CheckLocked()
	self.equipInfo_:CheckLocked()
end

function HeroEquipPage:SetHeroInfo(arg_12_1)
	self.heroInfo_ = arg_12_1

	self.detailController_:SetSelectedState("false")
	self.equipDisc_:Reset()
end

function HeroEquipPage:UpdateView()
	self:RefreshEquipDisc()
	self.equipOverrall_:RefreshHeroInfo(self.heroInfo_)

	local var_13_0 = self.equipDataList_[self.enterIndex_]

	self.equipInfo_:RefreshData(self, var_13_0, nil, self.heroInfo_.id, (self.equipDataList_[self.enterIndex_] or nil) and (var_13_0.equip_id or 0))
	self:PlayAnim()
end

function HeroEquipPage:OnClickItem(arg_14_1, arg_14_2)
	self.enterIndex_ = arg_14_2

	if arg_14_1 and arg_14_1.equip_id ~= 0 then
		self.equipInfo_:RefreshData(self, arg_14_1, nil, self.heroInfo_.id, arg_14_1.equip_id)
		self.detailController_:SetSelectedState("true")
	else
		if not self.heroViewProxy_.isSelf then
			return
		end

		self:GoEquipBag()
	end
end

function HeroEquipPage:SkillClick(arg_15_1, arg_15_2)
	self.equipSkillPop_:RefreshData(self, arg_15_2, self.detailController_:GetSelectedState() == "false")
	self.skillPopController_:SetSelectedState("show")
end

function HeroEquipPage:RefreshEquipDisc()
	if self.heroInfo_ then
		self.heroEquipList_ = self.heroViewProxy_:GetEquipInfoList(self.heroInfo_.id)
		self.equipDataList_ = self.heroViewProxy_:GetEquipDataList(self.heroInfo_.id)

		self.equipDisc_:RefreshItem(self.equipDataList_)
	end
end

function HeroEquipPage:GoEquipBag()
	self.isGoSubPanel = true

	self:Go("/heroEquipBag", {
		isOpenInfo = false,
		heroId = self.heroInfo_.id,
		suitPos = self.enterIndex_,
		proxy = self.heroViewProxy_
	})
end

function HeroEquipPage:GoEquipCulture()
	if self.heroEquipList_[self.enterIndex_] and self.heroEquipList_[self.enterIndex_].equip_id ~= 0 then
		self.isGoSubPanel = true

		self:Go("/equipCultureView", {
			pageIndex = 2,
			rotateAnim = true,
			equipId = self.heroEquipList_[self.enterIndex_].equip_id,
			proxy = self.heroViewProxy_
		})
	else
		ShowTips("NO_EQUIP")
	end
end

function HeroEquipPage:HideMaskMessage()
	self.skillPopController_:SetSelectedState("hide")
	self.equipOverrall_:DeSelect()
	self.equipInfo_:DeSelect()
end

function HeroEquipPage:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		4,
		0
	})
end

function HeroEquipPage:OnEnter(arg_21_1)
	self:HideMaskMessage()

	self.heroViewProxy_ = arg_21_1

	self.equipOverrall_:OnEnter(arg_21_1)
	self.equipInfo_:OnEnter(arg_21_1)
	self.equipDisc_:OnEnter({
		isShowDetail = true
	})
	self.isSelfController_:SetSelectedState(tostring(self.heroViewProxy_.isSelf))
	self:RegistEventListener(HERO_DATA_MODIFY, handler(self, self.UpdateView))
	self:CheckLocked()

	self.enterIndex_ = self.enterIndex_ or 1
end

function HeroEquipPage:Show()
	HeroEquipPage.super.Show(self)
	SetActive(self.gameObject_, true)
	self:UpdateView()
end

function HeroEquipPage:PlayAnim()
	self.equipDisc_:PlayAnim(self.isGoSubPanel)

	self.isGoSubPanel = false
end

function HeroEquipPage:OnExit()
	self:RemoveAllEventListener()
	self.equipOverrall_:OnExit()
end

function HeroEquipPage:Dispose()
	self.equipSkillPop_:Dispose()
	self.equipInfo_:Dispose()
	self.equipDisc_:Dispose()
	self.equipOverrall_:Dispose()
	HeroEquipPage.super.Dispose(self)
end

return HeroEquipPage

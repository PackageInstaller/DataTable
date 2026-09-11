local EquipInfoView = class("EquipInfoView", ReduxView)

function EquipInfoView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.transform_ = arg_1_1.transform
	self.gameObject_ = arg_1_1
	self.info_ = arg_1_2
	self.lockHandler_ = arg_1_3

	self:InitUI()
	self:AddUIListener()
end

function EquipInfoView:InitUI()
	self:BindCfgUI()

	self.attrItem_ = {}

	for iter_2_0 = 1, 2 do
		self.attrItem_[iter_2_0] = AttributeItem.New(self, self["attrItem_" .. iter_2_0])
	end

	self.skillList_ = {}
	self.heroSkillIndex_ = 0
	self.heroSkillItems_ = {}
	self.raceController_ = self.mainController_:GetController("race")
	self.tabController_ = self.mainController_:GetController("tab")
	self.bgController_ = self.mainController_:GetController("bg")
	self.isSelfController_ = self.mainController_:GetController("btnState")
	self.emptyController_ = self.mainController_:GetController("empty")
	self.typeController_ = self.headController_:GetController("type")
	self.qualityController_ = self.headController_:GetController("quality")
	self.lockController_ = self.headController_:GetController("lock")
	self.slotController_ = self.headController_:GetController("slot")
	self.starController_ = self.headController_:GetController("star")
	self.posController_ = self.equipBg_:GetController("pos")
	self.equipSuitItem_ = EquipNewSuitItem.New(self.suitGo_)
	self.skillScrollHelper_ = LuaList.New(handler(self, self.indexSkillItem), self.skillListGo_, EquipNewSkillItem)
	self.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function EquipInfoView:AddUIListener()
	self:AddBtnListener(self.btnSkill_, nil, function()
		self:ChangeShowView("skill")
	end)
	self:AddBtnListener(self.btnSuit_, nil, function()
		self:ChangeShowView("suit")
	end)
	self:AddBtnListener(self.btnLock_, nil, function()
		self.isLock_ = not self.isLock_

		EquipAction.ApplyLockEquip(self.info_.equip_id, self.isLock_)

		if self.lockHandler_ then
			self.lockHandler_(self.isLock_, self.info_.equip_id)
		end

		self.lockController_:SetSelectedState(self.isLock_ and "lock" or "unlock")
	end)
	self:AddBtnListener(self.btnChange_, nil, function()
		if self.equipFunc_ then
			self.equipFunc_()
		elseif self.equipedId_ ~= 0 and self.equipedId_ == self.info_.equip_id then
			self:SendUseEquip(self.heroId_, 0, EquipCfg[self.info_.prefab_id].pos)
		else
			local var_7_1 = self.info_.equip_id
			local var_7_2 = self.heroId_
			local var_7_3 = EquipCfg[self.info_.prefab_id].pos
			local var_7_4 = self.info_:GetEquipHero() or 0
			local var_7_5 = HeroCfg[var_7_4]

			if var_7_4 and var_7_5 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = string.format(GetTips("EQUIP_IS_USING"), GetI18NText(var_7_5.name)),
					OkCallback = function()
						self:SendUseEquip(var_7_2, var_7_1, var_7_3)
					end
				})
			else
				self:SendUseEquip(self.heroId_, self.info_.equip_id, EquipCfg[self.info_.prefab_id].pos)
			end
		end
	end)
	self:AddBtnListener(self.btnCulture_, nil, function()
		if self.handler_.KeepFilter then
			self.handler_:KeepFilter()
		end

		if self.cultureFunc_ then
			self.cultureFunc_()
		elseif self.info_ and self.info_.prefab_id ~= 0 then
			self.info_.id = self.info_.prefab_id

			self:Go("/equipCultureView", {
				pageIndex = 2,
				equipId = self.info_.equip_id,
				proxy = self.heroViewProxy_
			})
		else
			ShowTips("NO_EQUIP")
		end
	end)
end

function EquipInfoView:RefreshData(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	self.handler_ = arg_10_1
	self.info_ = arg_10_2
	self.lockHandler_ = arg_10_3
	self.heroId_ = arg_10_4
	self.equipedId_ = arg_10_5

	self:RefreshUI()
	self:RefreshState()
end

function EquipInfoView:OnEnter(arg_11_1)
	self.heroViewProxy_ = arg_11_1 or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function EquipInfoView:RefreshUI()
	if self.info_ and self.info_.prefab_id ~= 0 then
		self.emptyController_:SetSelectedState("notEmpty")
		self:RefreshTitle()
		self:RreshRace()
		self:RefreshAttr()
		self:RefreshSuit()
		self:RefreshSkill()
	else
		self.emptyController_:SetSelectedState("empty")
	end
end

function EquipInfoView:CheckLocked()
	self.isSelfController_:SetSelectedState(tostring(not self.heroViewProxy_.isSelf))
end

function EquipInfoView:RefreshTitle()
	local var_14_0 = EquipCfg[self.info_.prefab_id]

	self.icon_.sprite = ItemTools.getItemSprite(self.info_.prefab_id, nil, true)
	self.name_.text = ItemTools.getItemName(self.info_.prefab_id)

	self.starController_:SetSelectedState(var_14_0.starlevel)
	self.qualityController_:SetSelectedState(var_14_0.starlevel)
	self.slotController_:SetSelectedIndex(self.info_:GetEnchantCount())

	self.level_ = self.info_:GetLevel()
	self.lv_.text = string.format("%s%s/%s", GetTips("LEVEL"), self.level_, (self.info_:GetMaxLv()))
	self.isLock_ = self.info_.is_lock

	if self.info_.equip_id and self.info_.equip_id ~= 0 and self.heroViewProxy_ and self.heroViewProxy_.isSelf then
		self.lockController_:SetSelectedState(self.isLock_ and "lock" or "unlock")
	else
		self.lockController_:SetSelectedState("off")
	end

	self.posController_:SetSelectedState(var_14_0.pos or 0)
end

function EquipInfoView:RreshRace()
	if self.info_.race ~= 0 then
		self.raceController_:SetSelectedState("on")

		if table.keyof(RaceEffectCfg.all, self.info_.race) ~= nil then
			self.raceText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(RaceEffectCfg[self.info_.race].name))
			self.raceImage_.sprite = getSprite("Atlas/SystemGroupAtlas", RaceEffectCfg[self.info_.race].icon2)
		else
			self.raceText_.text = string.format(GetTips("EQUIP_HERO_ATTRIBUTE_UP"), HeroTools.GetHeroFullName(self.info_.race))
			self.raceImage_.sprite = HeroTools.GetSmallHeadSprite(self.info_.race)
		end
	else
		self.raceController_:SetSelectedState("off")
	end
end

function EquipInfoView:RefreshAttr()
	for iter_16_0, iter_16_1 in pairs((EquipTools.CountEquipAttribute(self.info_))) do
		self.attrItem_[1]:RefreshData(self, {
			key = iter_16_0,
			value = iter_16_1,
			race = self.info_.race,
			heroId = self.heroId_
		}, true)
	end
end

function EquipInfoView:RefreshSuit()
	local var_17_0 = 0

	if self.heroId_ and self.heroId_ ~= 0 and self.heroViewProxy_ then
		var_17_0 = EquipTools.GetSuitEquiptCount(self.heroViewProxy_:GetEquipDataList(self.heroId_), EquipCfg[self.info_.prefab_id].suit)
	end

	if self.info_.suitNumAdd then
		var_17_0 = var_17_0 + self.info_.suitNumAdd
	end

	self.equipSuitItem_:RefreshData((self.heroViewProxy_ or nil) and (self.heroViewProxy_:GetHeroData(self.heroId_) or HeroData:GetHeroData(self.heroId_)), {
		equipId = self.info_.equip_id,
		id = EquipCfg[self.info_.prefab_id].suit,
		num = var_17_0,
		pos = EquipCfg[self.info_.prefab_id].pos,
		equipPos = EquipCfg[self.info_.prefab_id].pos,
		heroId = self.heroId_
	})
end

function EquipInfoView:RefreshSkill()
	self.skillList_ = self.info_:GetTotalSkill()

	self.skillScrollHelper_:StartScroll(#self.skillList_)
end

function EquipInfoView:indexSkillItem(arg_19_1, arg_19_2)
	self.skillList_[arg_19_1].level = self.level_
	self.skillList_[arg_19_1].hideMaxLevel = true

	arg_19_2:RegistCallBack(function(arg_20_0)
		if self.skillClickFunc then
			if self.lastSkillSelect_ then
				self.lastSkillSelect_:ShowSelect(false)
			end

			self.lastSkillSelect_ = arg_19_2

			arg_19_2:ShowSelect(true)
			self.skillClickFunc(arg_19_2, arg_20_0, self.isLeftPop_)
		end
	end)
	arg_19_2:RefreshData(self.skillList_[arg_19_1])
end

function EquipInfoView:RegisterSkillClick(arg_21_1, arg_21_2)
	self.skillClickFunc = arg_21_1
	self.isLeftPop_ = arg_21_2
end

function EquipInfoView:RegistHeroButton(arg_22_1, arg_22_2)
	self.equipFunc_ = arg_22_1
	self.cultureFunc_ = arg_22_2
end

function EquipInfoView:DeSelect()
	if self.lastSkillSelect_ then
		self.lastSkillSelect_:ShowSelect(false)

		self.lastSkillSelect_ = nil
	end
end

function EquipInfoView:RefreshState()
	self.selectType_ = self.handler_.rightInfoType or "suit"

	self:ChangeShowView(self.selectType_)

	if self.equipedId_ == 0 then
		self.textBtnChange_.text = GetTips("TIP_EQUIP")
		self.imgLeftBtn_.sprite = getSprite("Atlas/SystemCommonAtlas", "com_white_icon_30")
	elseif self.equipedId_ == self.info_.equip_id and not self.equipFunc_ then
		self.textBtnChange_.text = GetTips("TIP_UNLOAD")
		self.imgLeftBtn_.sprite = getSprite("Atlas/SystemCommonAtlas", "com_white_icon_31")
	else
		self.textBtnChange_.text = GetTips("TIP_CHANGE")
		self.imgLeftBtn_.sprite = getSprite("Atlas/SystemCommonAtlas", "com_white_icon_05")
	end
end

function EquipInfoView:ChangeShowView(arg_25_1)
	if self.changeFunc then
		self.changeFunc(arg_25_1)
	end

	self:ChangeSelect(arg_25_1)
end

function EquipInfoView:ChangeSelect(arg_26_1)
	self.selectType_ = arg_26_1

	self.tabController_:SetSelectedState(arg_26_1)
end

function EquipInfoView:RegisterChange(arg_27_1)
	self.changeFunc = arg_27_1
end

function EquipInfoView:ShowRaceAdd(arg_28_1)
	for iter_28_0, iter_28_1 in pairs(self.attrItem_) do
		iter_28_1:ShowAdd(arg_28_1)
	end
end

function EquipInfoView:SendUseEquip(arg_29_1, arg_29_2, arg_29_3)
	HeroAction.EquipSwap(arg_29_1, arg_29_2, arg_29_3)
end

function EquipInfoView:OnEquipLock(arg_30_1)
	if arg_30_1 then
		ShowTips("ERROR_EQUIP_LOCKED_SUCCESS")
	else
		ShowTips("ERROR_EQUIP_UNLOCKED_SUCCESS")
	end
end

function EquipInfoView:Dispose()
	self.equipSuitItem_:Dispose()

	if self.skillScrollHelper_ then
		self.skillScrollHelper_:Dispose()

		self.skillScrollHelper_ = nil
	end

	if self.attrItem_ then
		for iter_31_0, iter_31_1 in pairs(self.attrItem_) do
			iter_31_1:Dispose()
		end

		self.attrItem_ = nil
	end

	self:RemoveAllListeners()
	EquipInfoView.super.Dispose(self)
end

return EquipInfoView

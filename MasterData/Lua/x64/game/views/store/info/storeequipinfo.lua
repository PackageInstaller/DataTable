local StoreEquipInfo = class("StoreEquipInfo", ReduxView)

function StoreEquipInfo:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.raceController_ = self.controllerEx_:GetController("race")
	self.switchController_ = self.controllerEx_:GetController("tab")
	self.cultureController_ = self.controllerEx_:GetController("btnState")
	self.storeHeadInfoView_ = StoreHeadInfo.New(self.itemHeadGo_)
	self.attributeItemList_ = {}

	for iter_1_0 = 1, 2 do
		self.attributeItemList_[iter_1_0] = AttributeItem.New(self, self[string.format("attributeItem%s_", iter_1_0)])
	end

	self.suitUIList_ = LuaList.New(handler(self, self.IndexSuitItem), self.suitUIListGo_, EquipNewSuitItem)
	self.skillUIList_ = LuaList.New(handler(self, self.IndexSkillItem), self.skillUIListGo_, EquipNewSkillItem)
	self.selectType_ = StoreConst.EQUIP_FILTER_TYPE.SUIT
end

function StoreEquipInfo:OnEnter()
	self.storeHeadInfoView_:OnEnter()
end

function StoreEquipInfo:OnExit()
	self.storeHeadInfoView_:OnExit()
end

function StoreEquipInfo:Dispose()
	StoreEquipInfo.super.Dispose(self)

	for iter_4_0, iter_4_1 in ipairs(self.attributeItemList_) do
		iter_4_1:Dispose()
	end

	self.attributeItemList_ = nil

	self.storeHeadInfoView_:Dispose()

	self.storeHeadInfoView_ = nil

	self.suitUIList_:Dispose()

	self.suitUIList_ = nil

	self.skillUIList_:Dispose()

	self.skillUIList_ = nil
end

function StoreEquipInfo:AddListeners()
	self:AddBtnListener(self.suitBtn_, nil, function()
		if self.selectType_ ~= StoreConst.EQUIP_FILTER_TYPE.SUIT then
			self.selectType_ = StoreConst.EQUIP_FILTER_TYPE.SUIT

			self:RefreshTypePanel()
		end
	end)
	self:AddBtnListener(self.skillBtn_, nil, function()
		if self.selectType_ ~= StoreConst.EQUIP_FILTER_TYPE.SKILL then
			self.selectType_ = StoreConst.EQUIP_FILTER_TYPE.SKILL

			self:RefreshTypePanel()
		end
	end)
	self:AddBtnListener(self.cultureBtn_, nil, function()
		ShowPopItem(nil, self.itemData_, {
			page = 2
		})
	end)
end

function StoreEquipInfo:SetData(arg_9_1, arg_9_2)
	self.itemData_ = arg_9_1

	self.storeHeadInfoView_:SetData(arg_9_1)
	self:RefreshAttribute()
	self:RefreshRace()
	self:GetSuitData()
	self:RefreshSuit()
	self:GetSkillData()
	self:RefreshSkill()

	if not arg_9_2 then
		self.selectType_ = StoreConst.EQUIP_FILTER_TYPE.SUIT
	end

	self:RefreshTypePanel()
end

function StoreEquipInfo:RefreshAttribute()
	for iter_10_0, iter_10_1 in pairs((EquipTools.CountEquipAttribute((EquipData:GetEquipData(self.itemData_.equip_id))))) do
		self.attributeItemList_[1]:RefreshData(self, {
			key = iter_10_0,
			value = iter_10_1,
			race = self.itemData_.race,
			heroId = self.bintHeroID
		}, true)
	end
end

function StoreEquipInfo:RefreshRace()
	if self.itemData_.bindHeroID ~= 0 then
		self.raceController_:SetSelectedState("on")

		self.raceText_.text = string.format(GetTips("EQUIP_HERO_ATTRIBUTE_UP"), HeroTools.GetHeroFullName(self.itemData_.bindHeroID))
		self.raceImage_.sprite = HeroTools.GetSmallHeadSprite(self.itemData_.bindHeroID)

		return
	end

	if self.itemData_.race ~= 0 then
		self.raceController_:SetSelectedState("on")

		self.raceText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(RaceEffectCfg[self.itemData_.race].name))
		self.raceImage_.sprite = getSprite("Atlas/SystemGroupAtlas", RaceEffectCfg[self.itemData_.race].icon2)

		return
	end

	self.raceController_:SetSelectedState("off")
end

function StoreEquipInfo:RefreshTypePanel()
	if self.selectType_ == StoreConst.EQUIP_FILTER_TYPE.SUIT then
		self.switchController_:SetSelectedState("suit")
	else
		self.switchController_:SetSelectedState("skill")
	end
end

function StoreEquipInfo:GetSuitData()
	self.suitList_ = {}

	local var_13_0, var_13_1 = EquipTools.GetHeroEquipSuitPos(self.itemData_.equipedHeroID, EquipCfg[self.itemData_.id].suit, EquipCfg[self.itemData_.id].pos)

	table.insert(self.suitList_, {
		id = EquipCfg[self.itemData_.id].suit,
		num = var_13_1,
		pos = var_13_0,
		equipPos = EquipCfg[self.itemData_.id].pos,
		equipHero = HeroData:GetHeroData(self.itemData_.equipedHeroID)
	})
end

function StoreEquipInfo:RefreshSuit()
	self.suitUIList_:StartScroll(#self.suitList_)
end

function StoreEquipInfo:GetSkillData()
	self.skillList_ = EquipData:GetEquipData(self.itemData_.equip_id):GetTotalSkill()
end

function StoreEquipInfo:RefreshSkill()
	self.skillUIList_:StartScroll(#self.skillList_)
end

function StoreEquipInfo:IndexSuitItem(arg_17_1, arg_17_2)
	arg_17_2:RefreshData(self.suitList_[arg_17_1].equipHero, self.suitList_[arg_17_1])
end

function StoreEquipInfo:IndexSkillItem(arg_18_1, arg_18_2)
	local var_18_0 = self.skillList_[arg_18_1]

	self.skillList_[arg_18_1].level = self.itemData_.equipLevel
	self.skillList_[arg_18_1].hideMaxLevel = true

	arg_18_2:RegistCallBack(function(arg_19_0)
		JumpTools.OpenPageByJump("equipSkillInfo", {
			equipSkillData = {
				id = var_18_0.id,
				skillLevel = var_18_0.num,
				selectItem = arg_18_2
			}
		})
	end)
	arg_18_2:RefreshData(self.skillList_[arg_18_1])
end

return StoreEquipInfo

local EquipMoreAttributeView = class("EquipMoreAttributeView", ReduxView)

function EquipMoreAttributeView:UIName()
	return "UI/Equip/EquipMoreAttributesUI"
end

function EquipMoreAttributeView:UIParent()
	return manager.ui.uiPop.transform
end

function EquipMoreAttributeView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function EquipMoreAttributeView:InitUI()
	self:BindCfgUI()

	self.lvText_ = {}
	self.starCon_ = {}
	self.raceCon_ = {}
	self.activeGo_ = {}
	self.raceIcon_ = {}
	self.equipIcon_ = {}

	for iter_4_0 = 1, 6 do
		self.lvText_[iter_4_0] = self["lvText_" .. iter_4_0]
		self.starCon_[iter_4_0] = ControllerUtil.GetController(self["item_" .. iter_4_0].transform, "star")
		self.raceCon_[iter_4_0] = ControllerUtil.GetController(self["item_" .. iter_4_0].transform, "race")
		self.activeGo_[iter_4_0] = self["activeGo_" .. iter_4_0]
		self.raceIcon_[iter_4_0] = self["raceIcon_" .. iter_4_0]
		self.equipIcon_[iter_4_0] = self["equipIcon_" .. iter_4_0]
	end

	self.attributeList_ = {}
	self.attributeInfo_ = {}
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, EquipAttributeItem)
	self.equipHeroSkillView_ = EquipNewSkillInfoView.New(self.equipHeroSkillGo_)
end

function EquipMoreAttributeView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(self.attributeList_[arg_5_1], self.attributeInfo_[self.attributeList_[arg_5_1]], self.isAdd_)
	arg_5_2:RegistCallBack(function(arg_6_0)
		SetActive(self.maskGo_, true)
		SetActive(self.equipHeroSkillGo_, true)
		self.equipHeroSkillView_:RefreshData(self, arg_6_0)
	end)
end

function EquipMoreAttributeView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:HideInfoView()
	end)
end

function EquipMoreAttributeView:OnEnter()
	self.equipList_ = self.params_.equipList
	self.heroID_ = self.params_.heroID
	self.isAdd_ = self.params_.isAdd
	self.attributeList_ = {}
	self.attributeInfo_ = {}

	self:HideInfoView()
	self:RefreshUI()
end

function EquipMoreAttributeView:HideInfoView()
	SetActive(self.maskGo_, false)
	SetActive(self.equipHeroSkillGo_, false)
end

function EquipMoreAttributeView:RefreshUI()
	self:RefreshEquip()
	self:RefreshList()
end

function EquipMoreAttributeView:RefreshEquip()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(self.equipList_) do
		local var_13_1 = iter_13_1.prefab_id
		local var_13_2 = EquipCfg[iter_13_1.prefab_id]
		local var_13_3 = EquipCfg[iter_13_1.prefab_id].pos

		table.insert(var_13_0, EquipCfg[iter_13_1.prefab_id].pos)

		local var_13_4 = iter_13_1:GetLevel()

		self.lvText_[var_13_3].text = GetTips("LEVEL") .. tostring(var_13_4)

		self.starCon_[var_13_3]:SetSelectedState(var_13_2.starlevel)

		if iter_13_1.race ~= 0 then
			self.raceIcon_[var_13_3].sprite = table.keyof(RaceEffectCfg.all, iter_13_1.race) ~= nil and getSprite("Atlas/Item", string.format("icon_group_%d_c", iter_13_1.race)) or HeroTools.GetSmallHeadSprite(iter_13_1.race)

			self.raceCon_[var_13_3]:SetSelectedState("0")
		else
			self.raceCon_[var_13_3]:SetSelectedState("0")
		end

		SetSpriteWithoutAtlasAsync(self.equipIcon_[var_13_3], SpritePathCfg.EquipIcon_s.path .. ItemCfg[var_13_1].icon)

		for iter_13_2, iter_13_3 in ipairs(var_13_2.effect) do
			if iter_13_3 and var_13_4 >= var_13_2.effect_unlock_level[iter_13_2] then
				if not self.attributeInfo_[iter_13_3[1]] then
					self.attributeInfo_[iter_13_3[1]] = {}

					table.insert(self.attributeList_, iter_13_3[1])
				end

				table.insert(self.attributeInfo_[iter_13_3[1]], {
					pos = var_13_2.pos,
					level = iter_13_3[2]
				})
			end
		end

		for iter_13_4, iter_13_5 in ipairs(iter_13_1.enchant) do
			for iter_13_6, iter_13_7 in ipairs(iter_13_5) do
				if iter_13_7 and iter_13_7.id then
					if not self.attributeInfo_[iter_13_7.id] then
						self.attributeInfo_[iter_13_7.id] = {}

						table.insert(self.attributeList_, iter_13_7.id)
					end

					table.insert(self.attributeInfo_[iter_13_7.id], {
						pos = var_13_2.pos,
						level = iter_13_7.num
					})
				end
			end
		end
	end

	for iter_13_8 = 1, 6 do
		SetActive(self.activeGo_[iter_13_8], table.indexof(var_13_0, iter_13_8) ~= false)
	end
end

function EquipMoreAttributeView:RefreshList()
	local var_14_0 = HeroCfg[self.heroID_].equip_skill

	table.sort(self.attributeList_, function(arg_15_0, arg_15_1)
		local var_15_0 = table.indexof(var_14_0, arg_15_0)
		local var_15_1 = table.indexof(var_14_0, arg_15_1)

		if var_15_0 and var_15_1 then
			return var_15_0 < var_15_1
		elseif var_15_0 or var_15_1 then
			return var_15_0 ~= false
		else
			return arg_15_0 < arg_15_1
		end
	end)
	self.scrollHelper_:StartScroll(#self.attributeList_)
end

function EquipMoreAttributeView:OnExit()
	return
end

function EquipMoreAttributeView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	EquipMoreAttributeView.super.Dispose(self)
end

return EquipMoreAttributeView

local TotalEnchantSkillPopView = class("TotalEnchantSkillPopView", ReduxView)

function TotalEnchantSkillPopView:UIName()
	return "Widget/System/Hero_equip/Develop/EnchantTotalPopUPUI"
end

function TotalEnchantSkillPopView:UIParent()
	return manager.ui.uiPop.transform
end

function TotalEnchantSkillPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function TotalEnchantSkillPopView:InitUI()
	self:BindCfgUI()

	self.skillScroll_ = LuaList.New(handler(self, self.IndexItem), self.skillListGo_, EnchantSkillItem)
end

function TotalEnchantSkillPopView:AddUIListener()
	self:AddBtnListener(self.btnBack_, nil, function()
		self:Back()
	end)
end

function TotalEnchantSkillPopView:OnEnter()
	self.heroViewProxy_ = self.params_.proxy or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	self.heroId_ = self.params_.heroId
	self.equipId_ = self.params_.equipId

	self:RefreshSkill()
end

function TotalEnchantSkillPopView:IndexItem(arg_8_1, arg_8_2)
	arg_8_2:RefreshData(self.skillList_[arg_8_1], true)
end

function TotalEnchantSkillPopView:RefreshSkill()
	self.skillList_ = {}

	if self.heroId_ then
		local var_9_0, var_9_1, var_9_2 = EquipTools.CountHeroTotalSkill(self.heroViewProxy_:GetEquipDataList(self.heroId_), self.heroViewProxy_:GetHeroData(self.heroId_), true)

		for iter_9_0, iter_9_1 in pairs(var_9_0) do
			table.insert(self.skillList_, {
				unlockLevel = 0,
				total = true,
				id = iter_9_0,
				num = iter_9_1,
				isAdd = var_9_1,
				location = var_9_2[iter_9_0]
			})
		end

		local var_9_3 = HeroCfg[self.heroId_].equip_skill

		table.sort(self.skillList_, function(arg_10_0, arg_10_1)
			local var_10_0 = table.indexof(var_9_3, arg_10_0.id)
			local var_10_1 = table.indexof(var_9_3, arg_10_1.id)

			if var_10_0 and var_10_1 then
				return var_10_0 < var_10_1
			end

			return arg_10_0.id < arg_10_1.id
		end)
	else
		local var_9_4 = EquipData:GetEquipData(self.equipId_)

		for iter_9_2, iter_9_3 in ipairs((var_9_4:GetTotalSkill())) do
			if not iter_9_3.unlockLevel or var_9_4:GetLevel() >= iter_9_3.unlockLevel then
				table.insert(self.skillList_, {
					total = true,
					id = iter_9_3.id,
					num = iter_9_3.num,
					unlockLevel = iter_9_3.unlockLevel
				})
			end
		end
	end

	self.skillScroll_:StartScroll(#self.skillList_)
end

function TotalEnchantSkillPopView:Dispose()
	TotalEnchantSkillPopView.super.Dispose(self)
	self.skillScroll_:Dispose()
end

return TotalEnchantSkillPopView

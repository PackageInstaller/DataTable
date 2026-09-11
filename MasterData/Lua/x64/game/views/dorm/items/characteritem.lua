local CharacterItem = class("CharacterItem", ReduxView)

function CharacterItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.flag = false

	self:Init()
end

function CharacterItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CharacterItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "name")
	self.fatigueComtroller = ControllerUtil.GetController(self.transform_, "fatigue")
	self.skillComtroller = ControllerUtil.GetController(self.transform_, "skill")
	self.typeScroll = LuaList.New(handler(self, self.indexItem), self.uilistGo_, DormRecommendSmallItem)
	self.sameNameController = ControllerUtil.GetController(self.transform_, "sameName")
	self.lockHeroController = self.controllers_:GetController("lock")
end

function CharacterItem:AddUIListener()
	self:AddBtnListener(self.characterbuttonBtn_, nil, function()
		if self.chooseFunc and self.stateController:GetSelectedState() ~= "full" then
			self.chooseFunc(self.uid_, self.stateController, self.fatigueComtroller)
		end
	end)
end

function CharacterItem:indexItem(arg_6_1, arg_6_2)
	arg_6_2:RefreshUI(self.attributeList[arg_6_1], self.flag)
end

function CharacterItem:RegistCallBack(arg_7_1)
	if arg_7_1 then
		self.chooseFunc = arg_7_1
	end
end

function CharacterItem:RegistFullListCallBack(arg_8_1)
	if arg_8_1 then
		self.fullListFunc = arg_8_1
	end
end

function CharacterItem:RefreshUI(arg_9_1)
	self.entrustPosID = CanteenEntrustData:GetCurDispatchTask().pos
	self.uid_ = arg_9_1

	local var_9_0 = self:CheckSkillCanOpen()

	if #var_9_0 > 0 then
		self.skillIcon.sprite = CanteenTools.GetCanteenSkillSprite(var_9_0[1])

		self.skillComtroller:SetSelectedState("true")
	else
		self.skillComtroller:SetSelectedState("false")
	end

	self.lockHeroController:SetSelectedState(BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_9_1) and "on" or "off")

	self.maxText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]

	local var_9_1 = DormData:GetHeroFatigue(arg_9_1)

	self.curText_.text = var_9_1
	self.headiconImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(self.uid_)
	self.progressImg_.fillAmount = 1 - math.min(var_9_1 / GameSetting.canteen_hero_fatigue_max.value[1], 1)

	if var_9_1 <= GameDisplayCfg.dorm_hero_fatigue_level.value[1] then
		self.fatigueComtroller:SetSelectedState("lack")
	elseif var_9_1 > GameDisplayCfg.dorm_hero_fatigue_level.value[1] and var_9_1 <= GameDisplayCfg.dorm_hero_fatigue_level.value[2] then
		self.fatigueComtroller:SetSelectedState("middle")
	else
		self.fatigueComtroller:SetSelectedState("full")
	end

	self:RefreshHeroAttributes(arg_9_1)

	if CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_9_1) or DormData:GetHeroTemplateInfo(arg_9_1).jobType ~= nil then
		self.stateController:SetSelectedState("full")

		return
	end

	self.sameNameController:SetSelectedState(CanteenEntrustData:CheckDispatchCharacterArchiveList(arg_9_1) and not CanteenEntrustData:CheckDispatchCharacterList(arg_9_1) and "true" or "false")

	if CanteenEntrustData:CheckDispatchCharacterList(arg_9_1) then
		self.stateController:SetSelectedState("select")

		self.flag = true
	else
		self.flag = false
	end

	self.fullListFunc(self.uid_, self.stateController)
end

function CharacterItem:CheckSkillCanOpen()
	local var_10_0 = {}
	local var_10_1 = HeroData:GetHeroData(self.uid_).level

	for iter_10_0 = 1, #BackHomeHeroCfg[self.uid_].skill_list do
		if var_10_1 >= GameSetting.dorm_hero_skill_unlock.value[iter_10_0] then
			table.insert(var_10_0, BackHomeHeroCfg[self.uid_].skill_list[iter_10_0])
		end
	end

	local var_10_2 = {}

	for iter_10_1, iter_10_2 in ipairs(var_10_0) do
		if BackHomeHeroSkillCfg[iter_10_2].condition and #BackHomeHeroSkillCfg[iter_10_2].condition > 0 then
			if BackHomeHeroSkillCfg[iter_10_2].condition[1] == 3 then
				table.insert(var_10_2, iter_10_2)
			end
		else
			table.insert(var_10_2, iter_10_2)
		end
	end

	return var_10_2
end

function CharacterItem:RefreshHeroAttributes(arg_11_1)
	self.attributeList = {}

	local var_11_0 = CanteenEntrustData:GetEntrustByPos(self.entrustPosID).tags

	self.attributeList = {
		{
			type = 1,
			tag = CharactorParamCfg[arg_11_1].RangeType
		},
		{
			type = 2,
			tag = HeroCfg[arg_11_1].race
		},
		{
			type = 3,
			tag = HeroCfg[arg_11_1].ATK_attribute[1]
		},
		{
			type = 4,
			tag = HeroCfg[arg_11_1].mechanism_type[1]
		}
	}

	self.typeScroll:StartScroll(#self.attributeList)

	self.uilistGo_:GetComponent("ScrollRectEx").vertical = false
end

function CharacterItem:Dispose()
	if self.typeScroll then
		self.typeScroll:Dispose()
	end

	CharacterItem.super.Dispose(self)
end

return CharacterItem

local TeachStageHeroItem = class("TeachStageHeroItem", ReduxView)

function TeachStageHeroItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddListeners()
end

function TeachStageHeroItem:InitUI()
	self:BindCfgUI()

	self.icon_.immediate = true
	self.indexcontroller_ = ControllerUtil.GetController(self.transform_, "index")
	self.selectcontroller_ = ControllerUtil.GetController(self.transform_, "select")
end

function TeachStageHeroItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if HeroData:GetHeroData(self.heroID_).unlock ~= 1 then
			ShowTips("ERROR_HERO_NOT_UNLOCK")

			return
		end

		self.selectCallBack_(self.index_)
		BattleTeachData:SetCacheTeachHeroID(self.heroID_)
		self:Go("teachSectionInfo", {
			section = HeroCfg[self.heroID_].study_stage[1],
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING
		})
	end)
end

function TeachStageHeroItem:RefreshSelect(arg_5_1)
	self.selectcontroller_:SetSelectedState(arg_5_1 == self.index_ and "true" or "false")
end

function TeachStageHeroItem:Dispose()
	TeachStageHeroItem.super.Dispose(self)

	self.selectCallBack_ = nil
end

function TeachStageHeroItem:IsOpenSectionInfo()
	return self:IsOpenRoute("teachSectionInfo")
end

function TeachStageHeroItem:SetHeroID(arg_8_1)
	if self.heroID_ ~= arg_8_1 then
		self.heroID_ = arg_8_1
		self.icon_.spriteSync = getSpritePathViaConfig("HeroIcon", SkinCfg[arg_8_1].picture_id)
	end

	local var_8_0 = HeroData:GetHeroData(arg_8_1)

	SetActive(self.lockGo_, var_8_0.unlock ~= 1)
	SetActive(self.greyMask_, var_8_0.unlock ~= 1)

	self.nameText_.text = GetI18NText(HeroCfg[arg_8_1].name)

	SetActive(self.clearGo_, BattleTeachData:GetHeroTeachInfo(self.heroID_, HeroCfg[self.heroID_].study_stage[1]) > 0)
end

function TeachStageHeroItem:SetData(arg_9_1, arg_9_2, arg_9_3)
	self.index_ = arg_9_1

	self.indexcontroller_:SetSelectedState(arg_9_1 % 3)

	if not arg_9_3 then
		self.selectcontroller_:SetSelectedState(arg_9_2 == self.index_ and "true" or "false")
	end
end

function TeachStageHeroItem:SetSelectCallBack(arg_10_1)
	self.selectCallBack_ = arg_10_1
end

return TeachStageHeroItem

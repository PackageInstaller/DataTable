local NewWarChessHeroItem = class("NewWarChessHeroItem", ReduxView)

function NewWarChessHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NewWarChessHeroItem:Init()
	self:InitUI()
end

function NewWarChessHeroItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "skilltype")
	self.skillClickHandler_ = handler(self, self.OnSkillItemClick)
	self.skillItem_ = NewWarChessSkillItem.New(self.skillGo_)
	self.buffItem_ = NewWarChessBuffItem.New(self.buffGo_)
end

function NewWarChessHeroItem:SetData(arg_4_1)
	self.heroInfo_ = arg_4_1
	self.cfg_ = NewWarChessHeroCfg[self.heroInfo_[1]]
	self.heroImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.cfg_.hero_id)
	self.heroNameText_.text = self.cfg_.description

	if self.cfg_.effect_type == NewChessConst.HERO_EFFECT_TYPE.BUFF then
		self.statusController_:SetSelectedState("buff")

		local var_4_0 = manager.NewChessManager.buffManager_:GetBuffEntity(self.cfg_.effect_id)

		self.buffItem_:SetData(1, 0, var_4_0)

		self.skillDesText_.text = NewChessTools.GetBuffDes(var_4_0)
	else
		self.statusController_:SetSelectedState("skill")
		self.skillItem_:SetData((NewWarChessData:GetSkillInfo(self.cfg_.effect_id)))

		self.skillDesText_.text = NewWarChessDiceSkillCfg[self.cfg_.effect_id].simple_description
	end

	self.hpText_.text = math.ceil(self.heroInfo_[2] / NewChessConst.HERO_HP_RATE * 100) .. "%"
	self.hpImage_.fillAmount = self.heroInfo_[2] / NewChessConst.HERO_HP_RATE
end

function NewWarChessHeroItem:EnableSkillItemClick()
	self.skillItem_:SetClickCallBack(self.skillClickHandler_)
end

function NewWarChessHeroItem:BindSkillRedPoint()
	self.skillItem_:BindSkillRedPoint()
end

function NewWarChessHeroItem:OnSkillItemClick(arg_7_1)
	JumpTools.OpenPageByJump("/newWarChessDiceSkillView", {
		skillID = arg_7_1
	})
end

function NewWarChessHeroItem:Dispose()
	self.skillClickHandler_ = nil

	self.skillItem_:Dispose()
	self.buffItem_:Dispose()
	NewWarChessHeroItem.super.Dispose(self)
end

return NewWarChessHeroItem

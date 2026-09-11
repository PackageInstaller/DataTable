local MatrixOverHeroItem = class("MatrixOverHeroItem", ReduxView)

function MatrixOverHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function MatrixOverHeroItem:InitUI()
	self:BindCfgUI()

	self.servantView_ = MatrixOverHeroServantItem.New(self.servantItem_)
	self.equipItemView_ = {}

	for iter_2_0 = 1, 5 do
		table.insert(self.equipItemView_, MatrixOverHeroEquipItem.New(self[string.format("equipGo%s_", iter_2_0)]))
	end

	self.astrolabeItemView_ = {}

	for iter_2_1 = 1, 6 do
		table.insert(self.astrolabeItemView_, MatrixOverHeroAstrolabeItem.New(self[string.format("astrolabeGo%s_", iter_2_1)]))
	end
end

function MatrixOverHeroItem:SetActive(arg_3_1)
	SetActive(self.gameObject_, arg_3_1)
end

function MatrixOverHeroItem:Refresh(arg_4_1)
	self.heroID_ = arg_4_1

	local var_4_0 = self:GetHeroData(self.heroID_)

	self.icon_.sprite = HeroTools.GetHeadSprite(self:GetHeroSkin(var_4_0.hero_id))

	self.servantView_:Refresh(var_4_0:GetWeaponServant())

	local var_4_1 = var_4_0:GetEquipList()

	for iter_4_0, iter_4_1 in ipairs(self.equipItemView_) do
		iter_4_1:Refresh(var_4_1[iter_4_0])
	end

	local var_4_2 = var_4_0:GetAstrolabeList()

	for iter_4_2, iter_4_3 in ipairs(self.astrolabeItemView_) do
		iter_4_3:Refresh(var_4_2[iter_4_2], self.heroID_)
	end
end

function MatrixOverHeroItem:Dispose()
	self.servantView_:Dispose()

	self.servantView_ = nil

	for iter_5_0, iter_5_1 in ipairs(self.equipItemView_) do
		iter_5_1:Dispose()
	end

	self.equipItemView_ = nil

	for iter_5_2, iter_5_3 in ipairs(self.astrolabeItemView_) do
		iter_5_3:Dispose()
	end

	self.astrolabeItemView_ = nil

	MatrixOverHeroItem.super.Dispose(self)
end

function MatrixOverHeroItem:GetHeroData(arg_6_1)
	return MatrixData:GetHeroData(arg_6_1)
end

function MatrixOverHeroItem:GetHeroSkin(arg_7_1)
	return MatrixData:GetHeroSkin(arg_7_1)
end

return MatrixOverHeroItem

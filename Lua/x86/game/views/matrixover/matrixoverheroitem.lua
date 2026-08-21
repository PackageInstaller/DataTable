local var_0_0 = class("MatrixOverHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.servantView_ = MatrixOverHeroServantItem.New(arg_2_0.servantItem_)
	arg_2_0.equipItemView_ = {}

	for iter_2_0 = 1, 5 do
		local var_2_0 = arg_2_0[string.format("equipGo%s_", iter_2_0)]

		table.insert(arg_2_0.equipItemView_, MatrixOverHeroEquipItem.New(var_2_0))
	end

	arg_2_0.astrolabeItemView_ = {}

	for iter_2_1 = 1, 6 do
		local var_2_1 = arg_2_0[string.format("astrolabeGo%s_", iter_2_1)]

		table.insert(arg_2_0.astrolabeItemView_, MatrixOverHeroAstrolabeItem.New(var_2_1))
	end
end

function var_0_0.SetActive(arg_3_0, arg_3_1)
	SetActive(arg_3_0.gameObject_, arg_3_1)
end

function var_0_0.Refresh(arg_4_0, arg_4_1)
	arg_4_0.heroID_ = arg_4_1

	local var_4_0 = arg_4_0:GetHeroData(arg_4_0.heroID_)

	arg_4_0.icon_.sprite = HeroTools.GetHeadSprite(arg_4_0:GetHeroSkin(var_4_0.hero_id))

	arg_4_0.servantView_:Refresh(var_4_0:GetWeaponServant())

	local var_4_1 = var_4_0:GetEquipList()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.equipItemView_) do
		iter_4_1:Refresh(var_4_1[iter_4_0])
	end

	local var_4_2 = var_4_0:GetAstrolabeList()

	for iter_4_2, iter_4_3 in ipairs(arg_4_0.astrolabeItemView_) do
		iter_4_3:Refresh(var_4_2[iter_4_2], arg_4_0.heroID_)
	end
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.servantView_:Dispose()

	arg_5_0.servantView_ = nil

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.equipItemView_) do
		iter_5_1:Dispose()
	end

	arg_5_0.equipItemView_ = nil

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.astrolabeItemView_) do
		iter_5_3:Dispose()
	end

	arg_5_0.astrolabeItemView_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.GetHeroData(arg_6_0, arg_6_1)
	return MatrixData:GetHeroData(arg_6_1)
end

function var_0_0.GetHeroSkin(arg_7_0, arg_7_1)
	return MatrixData:GetHeroSkin(arg_7_1)
end

return var_0_0

local var_0_0 = class("MatrixProcessSelectHeroView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Matrix/Process/MatrixProcessSelectHeroUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.m_list, MatrixProcessSelectHeroItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_okBtn, nil, function()
		if arg_5_0.selectHeroId == 0 then
			ShowTips(GetTips("MATRIX_SELECT_HERO_PLZ"))

			return
		end

		arg_5_0:Back()
		arg_5_0:OnRewardAction()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_cancelBtn, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_maskBtn, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.id = arg_9_0.params_.id

	arg_9_0:Refresh()
end

function var_0_0.Refresh(arg_10_0)
	local var_10_0 = arg_10_0.id
	local var_10_1 = MatrixItemCfg[var_10_0]
	local var_10_2 = var_10_1.matrix_item_type
	local var_10_3 = {}

	if var_10_2 == MatrixConst.ITEM_TYPE.EQUIP then
		local var_10_4 = arg_10_0:GetMatrixHeroTeam()

		for iter_10_0, iter_10_1 in pairs(var_10_4) do
			local var_10_5 = arg_10_0:GetHeroData(iter_10_1):GetEquipList()
			local var_10_6 = not table.indexof(var_10_5, var_10_0)

			table.insert(var_10_3, {
				heroId = iter_10_1,
				canSelect = var_10_6
			})
		end
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_10_2 then
		local var_10_7 = arg_10_0:GetMatrixHeroTeam()

		for iter_10_2, iter_10_3 in pairs(var_10_7) do
			local var_10_8 = arg_10_0:GetHeroData(iter_10_3):GetWeaponServant()
			local var_10_9 = HeroCfg[iter_10_3]
			local var_10_10 = WeaponServantCfg[var_10_1.params[1]]
			local var_10_11 = false

			if var_10_9.race == var_10_10.race and (var_10_8 == 0 or MatrixTools.GetWeaponSpecHero(MatrixItemCfg[var_10_8].params[1]) == 0) then
				var_10_11 = true
			end

			table.insert(var_10_3, {
				heroId = iter_10_3,
				canSelect = var_10_11
			})
		end
	end

	arg_10_0.selectHeroId = 0
	arg_10_0.selectableList = var_10_3

	arg_10_0.list_:StartScroll(#arg_10_0.selectableList)
end

function var_0_0.indexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.selectableList[arg_11_1]
	local var_11_1 = var_11_0.heroId
	local var_11_2 = var_11_0.canSelect

	arg_11_2:Refresh(var_11_1, var_11_2)
	arg_11_2:SetSelected(arg_11_0.selectHeroId == var_11_1)
	arg_11_2:RegistCallBack(handler(arg_11_0, arg_11_0.OnItemClick))
end

function var_0_0.OnItemClick(arg_12_0, arg_12_1)
	if arg_12_1 ~= arg_12_0.selectHeroId then
		arg_12_0.selectHeroId = arg_12_1

		local var_12_0 = arg_12_0.list_:GetItemList()

		for iter_12_0, iter_12_1 in pairs(var_12_0) do
			local var_12_1 = iter_12_1:GetHeroId()

			iter_12_1:SetSelected(var_12_1 == arg_12_0.selectHeroId)
		end
	end
end

function var_0_0.OnRewardAction(arg_13_0)
	local var_13_0 = arg_13_0.id
	local var_13_1 = arg_13_0.selectHeroId
	local var_13_2 = var_13_0 and MatrixItemCfg[var_13_0] or nil

	if not var_13_2 then
		return
	end

	local var_13_3 = var_13_2.matrix_item_type

	if MatrixConst.ITEM_TYPE.EQUIP == var_13_3 then
		local var_13_4 = arg_13_0:GetHeroData(var_13_1)
		local var_13_5 = var_13_4:GetEquipList()

		if arg_13_0:GetHeroEquipMaxCount() <= #var_13_5 then
			JumpTools.OpenPageByJump("matrixProcessEquipReplace", {
				heroId = var_13_1,
				equipId = var_13_0,
				callback = function(arg_14_0)
					MatrixAction.QueryNextProgress({
						var_13_0,
						arg_14_0,
						var_13_4:GetStandardId()
					})
				end
			})
		else
			MatrixAction.QueryNextProgress({
				var_13_0,
				0,
				var_13_4:GetStandardId()
			})
		end
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_13_3 then
		local var_13_6 = arg_13_0:GetHeroData(var_13_1)
		local var_13_7 = var_13_6:GetWeaponServant()

		if var_13_7 ~= 0 then
			JumpTools.OpenPageByJump("matrixProcessWeaponReplace", {
				heroId = var_13_1,
				weaponId = var_13_0,
				callback = function()
					MatrixAction.QueryNextProgress({
						var_13_0,
						var_13_7,
						var_13_6:GetStandardId()
					})
				end
			})
		else
			MatrixAction.QueryNextProgress({
				var_13_0,
				0,
				var_13_6:GetStandardId()
			})
		end
	else
		local var_13_8 = arg_13_0:GetHeroData(var_13_1)

		MatrixAction.QueryNextProgress({
			var_13_0,
			0,
			var_13_8:GetStandardId()
		})
	end
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.list_:Dispose()
	var_0_0.super.Dispose(arg_16_0)
end

function var_0_0.GetHeroData(arg_17_0, arg_17_1)
	return MatrixData:GetHeroData(arg_17_1)
end

function var_0_0.GetMatrixHeroTeam(arg_18_0)
	return MatrixData:GetMatrixHeroTeam()
end

function var_0_0.GetHeroEquipMaxCount(arg_19_0)
	return MatrixData:GetHeroEquipMaxCount()
end

return var_0_0

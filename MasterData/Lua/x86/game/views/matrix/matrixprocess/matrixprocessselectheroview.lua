local MatrixProcessSelectHeroView = class("MatrixProcessSelectHeroView", ReduxView)

function MatrixProcessSelectHeroView:UIName()
	return "UI/Matrix/Process/MatrixProcessSelectHeroUI"
end

function MatrixProcessSelectHeroView:UIParent()
	return manager.ui.uiPop.transform
end

function MatrixProcessSelectHeroView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixProcessSelectHeroView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.indexItem), self.m_list, MatrixProcessSelectHeroItem)
end

function MatrixProcessSelectHeroView:AddUIListener()
	self:AddBtnListener(self.m_okBtn, nil, function()
		if self.selectHeroId == 0 then
			ShowTips(GetTips("MATRIX_SELECT_HERO_PLZ"))

			return
		end

		self:Back()
		self:OnRewardAction()
	end)
	self:AddBtnListener(self.m_cancelBtn, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.m_maskBtn, nil, function()
		self:Back()
	end)
end

function MatrixProcessSelectHeroView:OnEnter()
	self.id = self.params_.id

	self:Refresh()
end

function MatrixProcessSelectHeroView:Refresh()
	local var_10_0 = {}

	if MatrixItemCfg[self.id].matrix_item_type == MatrixConst.ITEM_TYPE.EQUIP then
		for iter_10_0, iter_10_1 in pairs((self:GetMatrixHeroTeam())) do
			local var_10_1 = self:GetHeroData(iter_10_1)

			table.insert(var_10_0, {
				heroId = iter_10_1,
				canSelect = not table.indexof(var_10_1:GetEquipList(), self.id)
			})
		end
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == MatrixItemCfg[self.id].matrix_item_type then
		for iter_10_2, iter_10_3 in pairs((self:GetMatrixHeroTeam())) do
			local var_10_2 = self:GetHeroData(iter_10_3):GetWeaponServant()
			local var_10_3 = HeroCfg[iter_10_3].race == WeaponServantCfg[MatrixItemCfg[self.id].params[1]].race and (var_10_2 == 0 or MatrixTools.GetWeaponSpecHero(MatrixItemCfg[var_10_2].params[1]) == 0)

			table.insert(var_10_0, {
				heroId = iter_10_3,
				canSelect = var_10_3
			})
		end
	end

	self.selectHeroId = 0
	self.selectableList = var_10_0

	self.list_:StartScroll(#self.selectableList)
end

function MatrixProcessSelectHeroView:indexItem(arg_11_1, arg_11_2)
	local var_11_0 = self.selectableList[arg_11_1].heroId

	arg_11_2:Refresh(self.selectableList[arg_11_1].heroId, self.selectableList[arg_11_1].canSelect)
	arg_11_2:SetSelected(self.selectHeroId == var_11_0)
	arg_11_2:RegistCallBack(handler(self, self.OnItemClick))
end

function MatrixProcessSelectHeroView:OnItemClick(arg_12_1)
	if arg_12_1 ~= self.selectHeroId then
		self.selectHeroId = arg_12_1

		for iter_12_0, iter_12_1 in pairs((self.list_:GetItemList())) do
			iter_12_1:SetSelected(iter_12_1:GetHeroId() == self.selectHeroId)
		end
	end
end

function MatrixProcessSelectHeroView:OnRewardAction()
	local var_13_0 = self.id
	local var_13_1 = self.selectHeroId
	local var_13_2

	if self.id then
		var_13_2 = MatrixItemCfg[self.id] or nil

		if not var_13_2 then
			return
		end
	end

	local var_13_3 = var_13_2.matrix_item_type

	if MatrixConst.ITEM_TYPE.EQUIP == var_13_2.matrix_item_type then
		local var_13_4 = self:GetHeroData(var_13_1)

		if self:GetHeroEquipMaxCount() <= #var_13_4:GetEquipList() then
			JumpTools.OpenPageByJump("matrixProcessEquipReplace", {
				heroId = var_13_1,
				equipId = self.id,
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
				self.id,
				0,
				var_13_4:GetStandardId()
			})
		end
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == var_13_3 then
		local var_13_5 = self:GetHeroData(var_13_1)
		local var_13_6 = var_13_5:GetWeaponServant()

		if var_13_6 ~= 0 then
			JumpTools.OpenPageByJump("matrixProcessWeaponReplace", {
				heroId = var_13_1,
				weaponId = self.id,
				callback = function()
					MatrixAction.QueryNextProgress({
						var_13_0,
						var_13_6,
						var_13_5:GetStandardId()
					})
				end
			})
		else
			MatrixAction.QueryNextProgress({
				self.id,
				0,
				var_13_5:GetStandardId()
			})
		end
	else
		local var_13_7 = self:GetHeroData(var_13_1)

		MatrixAction.QueryNextProgress({
			self.id,
			0,
			var_13_7:GetStandardId()
		})
	end
end

function MatrixProcessSelectHeroView:Dispose()
	self.list_:Dispose()
	MatrixProcessSelectHeroView.super.Dispose(self)
end

function MatrixProcessSelectHeroView:GetHeroData(arg_17_1)
	return MatrixData:GetHeroData(arg_17_1)
end

function MatrixProcessSelectHeroView:GetMatrixHeroTeam()
	return MatrixData:GetMatrixHeroTeam()
end

function MatrixProcessSelectHeroView:GetHeroEquipMaxCount()
	return MatrixData:GetHeroEquipMaxCount()
end

return MatrixProcessSelectHeroView

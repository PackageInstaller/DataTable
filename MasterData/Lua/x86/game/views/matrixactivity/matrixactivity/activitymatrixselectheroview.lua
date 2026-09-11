local ActivityMatrixSelectHeroView = class("ActivityMatrixSelectHeroView", ReduxView)

function ActivityMatrixSelectHeroView:UIName()
	return "UI/VolumeIIIUI/SoloRoguelike/VolumeSoloRoguelikeSelectCharacterUI"
end

function ActivityMatrixSelectHeroView:UIBackCount()
	return 2
end

function ActivityMatrixSelectHeroView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityMatrixSelectHeroView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityMatrixSelectHeroView:InitUI()
	self:BindCfgUI()

	self.heroList = LuaList.New(handler(self, self.IndexItem), self.m_list, ActivityMatrixSelectHeroItem)
end

function ActivityMatrixSelectHeroView:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		local var_7_0 = ActivityMatrixCfg[self.matrix_activity_id]
		local var_7_1 = -1
		local var_7_2 = false
		local var_7_3
		local var_7_4 = self.heros[self.selectIndex]

		if self.heros[self.selectIndex].hero_type == 1 then
			for iter_7_0, iter_7_1 in ipairs(ActivityMatrixHeroStandardTemplateCfg.get_id_list_by_template_id[ActivityMatrixCfg[self.matrix_activity_id].hero_template_id]) do
				if ActivityMatrixHeroStandardTemplateCfg[iter_7_1].hero_id == self.heros[self.selectIndex].id then
					var_7_1 = ActivityMatrixHeroStandardTemplateCfg[iter_7_1].standard_id

					break
				end
			end

			local var_7_5 = HeroData:GetHeroData(self.heros[self.selectIndex].id)

			if #var_7_5.using_astrolabe <= 0 then
				var_7_3 = false
			end

			local var_7_6

			do
				var_7_3 = true
				var_7_6 = HeroTools.GetIsSuitNumCut(var_7_5)
			end

			local var_7_7 = EquipTools.CountActiveSuit(var_7_5.equip)

			for iter_7_2 = #var_7_7, 1, -1 do
				if var_7_7[iter_7_2].num < EquipTools.GetSuitNeedNum(var_7_7[iter_7_2].id, var_7_6) then
					table.remove(var_7_7, iter_7_2)
				end
			end

			var_7_2 = #var_7_7 > 0
		else
			var_7_1 = self.heros[self.selectIndex].id

			local var_7_8 = TempHeroData:GetTempHeroDataByTempID(self.heros[self.selectIndex].id)

			if #var_7_8.using_astrolabe <= 0 then
				var_7_3 = false
			end

			local var_7_10
			local var_7_9

			do
				var_7_3 = true
				var_7_9 = HeroTools.GetIsSuitNumCut(var_7_8)
				var_7_10 = {}
			end

			for iter_7_3, iter_7_4 in pairs(var_7_8.equip_list) do
				if iter_7_4.equip_id ~= 0 then
					if var_7_10[EquipCfg[iter_7_4.prefab_id].suit] then
						var_7_10[EquipCfg[iter_7_4.prefab_id].suit].num = var_7_10[EquipCfg[iter_7_4.prefab_id].suit].num + 1
					else
						var_7_10[EquipCfg[iter_7_4.prefab_id].suit] = {
							num = 1,
							id = EquipCfg[iter_7_4.prefab_id].suit
						}
					end
				end
			end

			local var_7_11 = {}

			for iter_7_5, iter_7_6 in pairs(var_7_10) do
				table.insert(var_7_11, iter_7_6)
			end

			for iter_7_7 = #var_7_11, 1, -1 do
				if var_7_11[iter_7_7].num < EquipTools.GetSuitNeedNum(var_7_11[iter_7_7].id, var_7_9) then
					table.remove(var_7_11, iter_7_7)
				end
			end

			var_7_2 = #var_7_11 > 0
		end

		if not var_7_1 or var_7_1 == -1 then
			ShowTips("ERROR_NO_TEMPLATE")

			return
		end

		local var_7_12

		if not var_7_2 and not var_7_3 then
			var_7_12 = GetTips("ACTIVITY_MATRIX_LACK_ALL")
		elseif not var_7_2 then
			var_7_12 = GetTips("ACTIVITY_MATRIX_LACK_EQUIP")
		elseif not var_7_3 then
			var_7_12 = GetTips("ACTIVITY_MATRIX_LACK_ASTROLABE")
		end

		local var_7_13 = handler(self, function()
			if var_7_0.type == 1 then
				ActivityMatrixAction.QueryStartMatrix({
					{
						hero_standard_system_id = var_7_1,
						hero_type = var_7_4.hero_type
					}
				}, self.matrix_activity_id, {})
			elseif var_7_0.type == 2 then
				self:Go("activityMatrixSelectAffix", {
					matrix_activity_id = self.matrix_activity_id,
					select_hero_list = {
						{
							hero_standard_system_id = var_7_1,
							hero_type = var_7_4.hero_type
						}
					}
				})
			else
				ShowTips("ERROR_BAD_ARG")
			end
		end)

		if var_7_12 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = var_7_12,
				OkCallback = var_7_13
			})
		else
			var_7_13()
		end
	end)
end

function ActivityMatrixSelectHeroView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
end

function ActivityMatrixSelectHeroView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id
	self.selectIndex = -1

	if not ActivityMatrixCfg[self.matrix_activity_id] then
		self.heroList:StartScroll(0)

		return
	end

	self.heros = {}

	for iter_10_0, iter_10_1 in ipairs(ActivityMatrixCfg[self.matrix_activity_id].hero_trial) do
		table.insert(self.heros, {
			hero_type = 2,
			id = iter_10_1
		})
	end

	for iter_10_2, iter_10_3 in pairs((HeroData:GetHeroList())) do
		if iter_10_3.unlock == 1 and HeroCfg[iter_10_2] and table.indexof(ActivityMatrixCfg[self.matrix_activity_id].race_list, HeroCfg[iter_10_2].race) then
			table.insert(self.heros, {
				hero_type = 1,
				id = iter_10_2
			})
		end
	end

	self.heroList:StartScroll(#self.heros)
	self:RefreshUI()
end

function ActivityMatrixSelectHeroView:OnExit()
	manager.windowBar:HideBar()
end

function ActivityMatrixSelectHeroView:RefreshUI()
	self.m_btn.interactable = self.selectIndex ~= -1
end

function ActivityMatrixSelectHeroView:IndexItem(arg_13_1, arg_13_2)
	arg_13_2:SetIndex(arg_13_1)

	if self.heros[arg_13_1].hero_type == 1 then
		arg_13_2:SetData(self.heros[arg_13_1].id)
	else
		arg_13_2:SetStandardData(self.heros[arg_13_1].id)
	end

	arg_13_2:SetSelect(self.selectIndex)
	arg_13_2:RegistCallBack(handler(self, self.OnHeroItemClick))
end

function ActivityMatrixSelectHeroView:OnHeroItemClick(arg_14_1)
	self.selectIndex = arg_14_1

	for iter_14_0, iter_14_1 in pairs((self.heroList:GetItemList())) do
		iter_14_1:SetSelect(self.selectIndex)
	end

	self:RefreshUI()
end

function ActivityMatrixSelectHeroView:Dispose()
	self.heroList:Dispose()
	ActivityMatrixSelectHeroView.super.Dispose(self)
end

return ActivityMatrixSelectHeroView

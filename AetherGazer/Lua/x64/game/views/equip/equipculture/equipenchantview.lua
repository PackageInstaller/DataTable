local var_0_0 = class("EquipEnchantView", EquipBaseView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.params_ = arg_1_3

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	var_0_0.super.Init(arg_2_0)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:InitEnchant()

	arg_3_0.skillFixedItems_ = {}
	arg_3_0.fixedSkillScroller_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.fixedListGo_, EnchantSkillItem)
end

function var_0_0.InitEnchant(arg_4_0)
	arg_4_0.enchants = {}

	for iter_4_0 = 1, 2 do
		local var_4_0 = {
			skills = {}
		}

		ComponentBinder.GetInstance():BindCfgUI(var_4_0, arg_4_0["enchant_" .. iter_4_0])

		var_4_0.lockController_ = var_4_0.transCon_:GetController("lock")

		for iter_4_1 = 1, 2 do
			var_4_0.skills[iter_4_1] = EnchantSkillItem.New(var_4_0["skill_" .. iter_4_1])
		end

		arg_4_0:AddBtnListener(var_4_0.button_, nil, function()
			arg_4_0:OnEnchantClick(iter_4_0)
		end)
		table.insert(arg_4_0.enchants, var_4_0)
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.previewBtn_, nil, function()
		JumpTools.OpenPageByJump("equipSkillPreviewPage", {
			equipId = arg_6_0.equipId
		})
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:OnEquipChange(arg_8_0.params_.equipId)
end

function var_0_0.OnEquipChange(arg_9_0, arg_9_1)
	arg_9_0.equipId = arg_9_1
	arg_9_0.equip = EquipData:GetEquipData(arg_9_0.equipId)

	local var_9_0 = EquipCfg[arg_9_0.equip.prefab_id]

	arg_9_0.slotNum = var_9_0.slot_num or 0
	arg_9_0.slotOpenLevel = var_9_0.slot_open_level or {}

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	if not arg_10_0.equip then
		return
	end

	arg_10_0:RefreshFixedSkill()
	arg_10_0:RefreshEnchantSkill()
end

function var_0_0.RefreshFixedSkill(arg_11_0)
	arg_11_0.fixedSkillList_ = arg_11_0.equip:GetBaseSkill()

	arg_11_0.fixedSkillScroller_:StartScroll(#arg_11_0.fixedSkillList_)
end

function var_0_0.indexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.fixedSkillList_[arg_12_1]

	var_12_0.equipLevel = arg_12_0.equip:GetLevel()

	arg_12_2:RegistCallBack(handler(arg_12_0, arg_12_0.OnEnchantSkillClick))
	arg_12_2:RefreshData(var_12_0)
end

function var_0_0.RefreshEnchantSkill(arg_13_0)
	for iter_13_0 = 1, arg_13_0.slotNum do
		local var_13_0 = arg_13_0.enchants[iter_13_0]
		local var_13_1 = arg_13_0.equip.enchant[iter_13_0]

		SetActive(var_13_0.gameObject_, true)

		local var_13_2 = arg_13_0.slotOpenLevel[iter_13_0] or 0

		if var_13_2 > arg_13_0.equip:GetLevel() then
			var_13_0.lockController_:SetSelectedState("lock")

			var_13_0.lockDesc_.text = string.format(GetTips("EQUIP_SKILL_LOCK_LEVEL"), var_13_2)
		elseif not var_13_1 or #var_13_1 == 0 then
			var_13_0.lockController_:SetSelectedState("empty")
		else
			var_13_0.lockController_:SetSelectedState("skill")
		end

		if #var_13_1 > 0 then
			for iter_13_1 = 1, 2 do
				local var_13_3 = var_13_1[iter_13_1]

				if var_13_3 then
					var_13_3.equipLevel = arg_13_0.equip:GetLevel()
				end

				var_13_0.skills[iter_13_1]:RefreshData(var_13_3)
			end
		end
	end

	for iter_13_2 = arg_13_0.slotNum + 1, #arg_13_0.enchants do
		SetActive(arg_13_0.enchants[iter_13_2].gameObject_, false)
	end
end

function var_0_0.OnEnchantClick(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.slotOpenLevel[arg_14_1] or 0

	if var_14_0 > arg_14_0.equip:GetLevel() then
		ShowTips(string.format(GetTips("EQUIP_ENCHANT_OEPN_LEVEL"), var_14_0))

		return
	end

	arg_14_0.handler_:HidePop()
	arg_14_0:Go("/enchantChangeView", {
		equipId = arg_14_0.equipId,
		enchatPos = arg_14_1,
		proxy = arg_14_0.params_.proxy
	})
end

function var_0_0.OnEnchantSkillClick(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.handler_:RefreshSkillInfo(arg_15_1, arg_15_2)
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0.handler_:HidePop()
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.fixedSkillScroller_:Dispose()

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.enchants) do
		for iter_17_2 = 1, 2 do
			iter_17_1.skills[iter_17_2]:Dispose()
		end
	end

	arg_17_0.enchants = nil

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0

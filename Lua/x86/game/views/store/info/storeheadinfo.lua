local var_0_0 = class("StoreHeadInfo", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.typeController_ = arg_1_0.controllerEx_:GetController("type")
	arg_1_0.rareController_ = arg_1_0.controllerEx_:GetController("quality")
	arg_1_0.lockController_ = arg_1_0.controllerEx_:GetController("lock")
	arg_1_0.slotController_ = arg_1_0.controllerEx_:GetController("slot")
	arg_1_0.starController_ = arg_1_0.controllerEx_:GetController("star")
	arg_1_0.timeController_ = arg_1_0.controllerEx_:GetController("time")
	arg_1_0.RefreshEquipLockHandler_ = handler(arg_1_0, arg_1_0.RefreshEquipLock)
end

function var_0_0.OnEnter(arg_2_0)
	manager.notify:RegistListener(EQUIP_LOCK, arg_2_0.RefreshEquipLockHandler_)
end

function var_0_0.OnExit(arg_3_0)
	manager.notify:RemoveListener(EQUIP_LOCK, arg_3_0.RefreshEquipLockHandler_)
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.RefreshEquipLockHandler_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.lockBtn_, nil, function()
		EquipAction.ApplyLockEquip(arg_5_0.itemData_.equip_id, not arg_5_0.itemData_.equipedLocked)
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.itemData_ = arg_7_1

	local var_7_0 = arg_7_1.id
	local var_7_1 = ItemCfg[var_7_0]
	local var_7_2 = var_7_1.type

	if var_7_2 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		arg_7_0.typeController_:SetSelectedState("servant")

		arg_7_0.servantImage_.sprite = ItemTools.getItemSprite(var_7_0)
		arg_7_0.servantLevelText_.text = arg_7_1.addLevel

		arg_7_0.lockController_:SetSelectedState(tostring(arg_7_1.locked))
		arg_7_0.slotController_:SetSelectedState("0")
	elseif var_7_2 == ItemConst.ITEM_TYPE.EQUIP then
		arg_7_0.typeController_:SetSelectedState("equip")

		arg_7_0.equipImage_.sprite = ItemTools.getItemLittleSprite(var_7_0)

		local var_7_3 = GetTips("LEVEL")
		local var_7_4 = EquipData:GetEquipData(arg_7_1.equip_id):GetMaxLv()

		arg_7_0.equipLevelText_.text = string.format("%s%s/%s", var_7_3, arg_7_1.equipLevel, var_7_4)

		arg_7_0.lockController_:SetSelectedState(tostring(arg_7_1.equipedLocked))
		arg_7_0.slotController_:SetSelectedState(tostring(arg_7_1.equipEnchantCount))

		arg_7_0.equipPosTf_.localEulerAngles = Vector3.New(0, 0, 60 * EquipCfg[arg_7_1.id].pos)
	elseif var_7_2 == ItemConst.ITEM_TYPE.HERO_PIECE then
		arg_7_0.typeController_:SetSelectedState("heropiece")

		arg_7_0.itemImage_.sprite = ItemTools.getItemSprite(var_7_0)

		local var_7_5 = ItemCfg[var_7_0].hero_id

		arg_7_0.raceImage_.sprite = getSprite("Atlas/SystemGroupAtlas", RaceEffectCfg[HeroCfg[var_7_5].race].icon2)
		arg_7_0.cntText_.text = arg_7_1.number

		arg_7_0.lockController_:SetSelectedState("hide")
		arg_7_0.slotController_:SetSelectedState("0")
	else
		arg_7_0.typeController_:SetSelectedState("material")

		arg_7_0.itemImage_.sprite = ItemTools.getItemSprite(var_7_0)
		arg_7_0.cntText_.text = arg_7_1.number

		arg_7_0.lockController_:SetSelectedState("hide")
		arg_7_0.slotController_:SetSelectedState("0")
	end

	arg_7_0.nameText_.text = ItemTools.getItemName(var_7_0)

	local var_7_6 = ItemTools.GetItemExpiredTimeByInfo(arg_7_1)

	if var_7_6 == nil or var_7_6 == 0 then
		arg_7_0.timeController_:SetSelectedState("false")
	else
		arg_7_0.timeController_:SetSelectedState("true")

		arg_7_0.timeText_.text = string.format(GetTips("TIME_DISPLAY_12"), TimeMgr.GetInstance():STimeDescS(var_7_6, "!%Y/%m/%d %H:%M"))
	end

	arg_7_0.rareController_:SetSelectedState(tostring(var_7_1.rare))
	arg_7_0.starController_:SetSelectedState(tostring(var_7_1.rare))
end

function var_0_0.RefreshEquipLock(arg_8_0, arg_8_1)
	if arg_8_0.itemData_ and arg_8_1.equipID == arg_8_0.itemData_.equip_id and arg_8_0.itemData_.equip_id ~= 0 then
		arg_8_0.itemData_.equipedLocked = arg_8_1.lock

		arg_8_0.lockController_:SetSelectedState(tostring(arg_8_0.itemData_.equipedLocked))
	end
end

return var_0_0

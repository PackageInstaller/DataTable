local StoreHeadInfo = class("StoreHeadInfo", ReduxView)

function StoreHeadInfo:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.typeController_ = self.controllerEx_:GetController("type")
	self.rareController_ = self.controllerEx_:GetController("quality")
	self.lockController_ = self.controllerEx_:GetController("lock")
	self.slotController_ = self.controllerEx_:GetController("slot")
	self.starController_ = self.controllerEx_:GetController("star")
	self.timeController_ = self.controllerEx_:GetController("time")
	self.RefreshEquipLockHandler_ = handler(self, self.RefreshEquipLock)
end

function StoreHeadInfo:OnEnter()
	manager.notify:RegistListener(EQUIP_LOCK, self.RefreshEquipLockHandler_)
end

function StoreHeadInfo:OnExit()
	manager.notify:RemoveListener(EQUIP_LOCK, self.RefreshEquipLockHandler_)
end

function StoreHeadInfo:Dispose()
	self.RefreshEquipLockHandler_ = nil

	StoreHeadInfo.super.Dispose(self)
end

function StoreHeadInfo:AddListeners()
	self:AddBtnListener(self.lockBtn_, nil, function()
		EquipAction.ApplyLockEquip(self.itemData_.equip_id, not self.itemData_.equipedLocked)
	end)
end

function StoreHeadInfo:SetData(arg_7_1)
	self.itemData_ = arg_7_1

	local var_7_0 = arg_7_1.id
	local var_7_1 = ItemCfg[arg_7_1.id]

	if ItemCfg[arg_7_1.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		self.typeController_:SetSelectedState("servant")

		self.servantImage_.sprite = ItemTools.getItemSprite(var_7_0)
		self.servantLevelText_.text = arg_7_1.addLevel

		self.lockController_:SetSelectedState(tostring(arg_7_1.locked))
		self.slotController_:SetSelectedState("0")
	elseif ItemCfg[arg_7_1.id].type == ItemConst.ITEM_TYPE.EQUIP then
		self.typeController_:SetSelectedState("equip")

		self.equipImage_.sprite = ItemTools.getItemLittleSprite(var_7_0)
		self.equipLevelText_.text = string.format("%s%s/%s", GetTips("LEVEL"), arg_7_1.equipLevel, (EquipData:GetEquipData(arg_7_1.equip_id):GetMaxLv()))

		self.lockController_:SetSelectedState(tostring(arg_7_1.equipedLocked))
		self.slotController_:SetSelectedState(tostring(arg_7_1.equipEnchantCount))

		self.equipPosTf_.localEulerAngles = Vector3.New(0, 0, 60 * EquipCfg[arg_7_1.id].pos)
	elseif ItemCfg[arg_7_1.id].type == ItemConst.ITEM_TYPE.HERO_PIECE then
		self.typeController_:SetSelectedState("heropiece")

		self.itemImage_.sprite = ItemTools.getItemSprite(var_7_0)
		self.raceImage_.sprite = getSprite("Atlas/SystemGroupAtlas", RaceEffectCfg[HeroCfg[ItemCfg[var_7_0].hero_id].race].icon2)
		self.cntText_.text = arg_7_1.number

		self.lockController_:SetSelectedState("hide")
		self.slotController_:SetSelectedState("0")
	else
		self.typeController_:SetSelectedState("material")

		self.itemImage_.sprite = ItemTools.getItemSprite(var_7_0)
		self.cntText_.text = arg_7_1.number

		self.lockController_:SetSelectedState("hide")
		self.slotController_:SetSelectedState("0")
	end

	self.nameText_.text = ItemTools.getItemName(var_7_0)

	local var_7_2 = ItemTools.GetItemExpiredTimeByInfo(arg_7_1)

	if var_7_2 == nil or var_7_2 == 0 then
		self.timeController_:SetSelectedState("false")
	else
		self.timeController_:SetSelectedState("true")

		self.timeText_.text = string.format(GetTips("TIME_DISPLAY_12"), TimeMgr.GetInstance():STimeDescS(var_7_2, "!%Y/%m/%d %H:%M"))
	end

	self.rareController_:SetSelectedState(tostring(var_7_1.rare))
	self.starController_:SetSelectedState(tostring(var_7_1.rare))
end

function StoreHeadInfo:RefreshEquipLock(arg_8_1)
	if self.itemData_ and arg_8_1.equipID == self.itemData_.equip_id and self.itemData_.equip_id ~= 0 then
		self.itemData_.equipedLocked = arg_8_1.lock

		self.lockController_:SetSelectedState(tostring(self.itemData_.equipedLocked))
	end
end

return StoreHeadInfo

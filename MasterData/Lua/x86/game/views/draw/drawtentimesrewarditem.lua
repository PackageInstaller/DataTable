local DrawTenTimesRewardItem = class("DrawTenTimesRewardItem", ReduxView)

local function var_0_1(arg_1_0)
	if arg_1_0 then
		return true
	end

	return false
end

function DrawTenTimesRewardItem:OnCtor(arg_2_1)
	self.gameObject_ = arg_2_1
	self.transform_ = arg_2_1.transform

	self:Init()
end

function DrawTenTimesRewardItem:Init()
	self:InitUI()
	self:AddUIListener()

	self.shareStartHandler_ = handler(self, self.ShareStart)
	self.shareEndHandler_ = handler(self, self.ShareEnd)

	manager.notify:RegistListener(SHAER_DAW_TEN_TIMES_START, self.shareStartHandler_)
	manager.notify:RegistListener(SHAER_DAW_TEN_TIMES_END, self.shareEndHandler_)
end

function DrawTenTimesRewardItem:InitUI()
	self:BindCfgUI()

	self.m_portrait.immediate = true
	self.itemController_ = ControllerUtil.GetController(self.transform_, "item")
	self.switchController_ = ControllerUtil.GetController(self.transform_, "switch")
	self.rateController_ = ControllerUtil.GetController(self.transform_, "rare")
	self.starController_ = ControllerUtil.GetController(self.transform_, "star")
	self.item = CommonItemView.New(self.m_item)
end

function DrawTenTimesRewardItem:AddUIListener()
	return
end

function DrawTenTimesRewardItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.index = arg_6_1
	self.data_ = arg_6_2

	local var_6_0 = arg_6_2.id
	local var_6_1

	if ItemWillConvert(arg_6_2) then
		var_6_1 = arg_6_2.convert_from.id

		local var_6_4
		local var_6_2

		if not arg_6_2.convert_from.id then
			var_6_1 = var_6_0
			var_6_2 = ItemCfg[var_6_1]
			var_6_4 = ItemCfg[var_6_1].type
		end
	end

	local var_6_5 = ItemCfg[var_6_0].display_rare

	self.starController_:SetSelectedIndex((math.min(ItemCfg[var_6_0].display_rare, 5)))

	if var_6_5 >= 5 then
		self.rateController_:SetSelectedIndex(0)
	elseif var_6_5 >= 4 then
		self.rateController_:SetSelectedIndex(1)
	else
		self.rateController_:SetSelectedIndex(2)
	end

	SetActive(self.m_newTag, var_0_1(arg_6_2.newTag))

	if var_6_4 == ItemConst.ITEM_TYPE.HERO then
		self.itemController_:SetSelectedIndex(0)

		self.m_camp.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[HeroCfg[var_6_1].race].icon)
		self.m_portrait.spriteSync = "TextureConfig/Character/Icon/" .. var_6_2.id
	elseif var_6_4 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		self.itemController_:SetSelectedIndex(1)

		self.m_camp.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Group_l/" .. RaceEffectCfg[WeaponServantCfg[var_6_1].race].icon2)
		self.m_weaponName.text = string.split(ItemTools.getItemName(var_6_2.id) or "", "·")[1]
		self.m_weaponImg.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponServant/Icon/" .. var_6_2.icon)
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if ItemWillConvert(arg_6_2) then
		if arg_6_3 then
			CommonTools.SetCommonData(self.item, rewardToItemTemplate(arg_6_2))
		else
			self.m_switchAnimator:Play("CommonItem_zhuanhua", 0, 0)

			self.timer = Timer.New(function()
				if self.index == arg_6_1 then
					CommonTools.SetCommonData(self.item, rewardToItemTemplate(arg_6_2))
				end

				self.timer = nil
			end, 1, 1)

			self.timer:Start()
			CommonTools.SetCommonData(self.item, rewardToItemTemplate(arg_6_2.convert_from))
		end

		self.switchController_:SetSelectedIndex(1)
	else
		CommonTools.SetCommonData(self.item, rewardToItemTemplate(arg_6_2))
		self.switchController_:SetSelectedIndex(1)
		self.switchController_:SetSelectedIndex(0)
	end
end

function DrawTenTimesRewardItem:ShareStart()
	if ItemCfg[self.data_.id].type == ItemConst.ITEM_TYPE.HERO then
		self.switchController_:SetSelectedIndex(0)
	end
end

function DrawTenTimesRewardItem:ShareEnd()
	if ItemCfg[self.data_.id].type == ItemConst.ITEM_TYPE.HERO and self.data_.convert then
		self.switchController_:SetSelectedIndex(1)
	end
end

function DrawTenTimesRewardItem:Dispose()
	manager.notify:RemoveListener(SHAER_DAW_TEN_TIMES_START, self.shareStartHandler_)
	manager.notify:RemoveListener(SHAER_DAW_TEN_TIMES_END, self.shareEndHandler_)

	self.shareStartHandler_ = nil
	self.shareEndHandler_ = nil

	if self.item then
		self.item:Dispose()

		self.item = nil
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	DrawTenTimesRewardItem.super.Dispose(self)
end

function DrawTenTimesRewardItem:OnExit()
	self.switchController_:SetSelectedIndex(0)
end

return DrawTenTimesRewardItem

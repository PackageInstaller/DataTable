local NewSelectSkinLayer = class("NewSelectSkinLayer", import(".NewSkinAtlasLayer"))

NewSelectSkinLayer.MODE_SELECT = 1
NewSelectSkinLayer.MODE_VIEW = 2

function NewSelectSkinLayer:init()
	NewSelectSkinLayer.super.init(self)
	setText(self._tf:Find("adapt/top/title/Text"), i18n("shop_new_able_to_exchange"))
	setText(self._tf:Find("adapt/top/have/Text"), i18n("shop_new_able_to_exchange"))

	self.msgBox = SelectSkinMsgbox.New(self._tf, self.event)

	return
end

function NewSelectSkinLayer:InitData()
	self.skins = {}

	local var_2_0 = self.contextData.selectableSkinList or {}

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_0:GetTimeLimitWeight()
		local var_3_1 = arg_3_1:GetTimeLimitWeight()

		if var_3_0 == var_3_1 then
			local var_3_2 = arg_3_0:GetOwnWeight()
			local var_3_3 = arg_3_1:GetOwnWeight()

			if var_3_2 == var_3_3 then
				return arg_3_0.skinId > arg_3_1.skinId
			else
				return var_3_3 < var_3_2
			end
		else
			return var_3_1 < var_3_0
		end

		return
	end)

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		table.insert(self.skins, iter_2_1:ToShipSkin())
	end

	self:GetSkinClassify()

	self.filterValues = {
		shipHaveType = 0,
		ownType = 0,
		typeType = {
			0
		},
		campType = {
			0
		},
		rarityType = {
			0
		},
		shipType = {
			0
		},
		themeType = {
			0
		}
	}
	self.filterValuesTemp = Clone(self.filterValues)

	return
end

function NewSelectSkinLayer:Check(arg_4_1)
	local var_4_1
	local var_4_0

	if getProxy(ShipSkinProxy):hasSkin(arg_4_1.id) then
		do return end

		var_4_0 = {
			content = i18n("skin_exchange_confirm", Item.getConfigData(self.contextData.itemId).name, arg_4_1.skinName)
		}
		var_4_1 = {
			count = 1,
			type = DROP_TYPE_ITEM
		}
	end

	var_4_1.id = self.contextData.itemId
	var_4_0.leftDrop = var_4_1
	var_4_0.rightDrop = {
		count = 1,
		type = DROP_TYPE_SKIN,
		id = arg_4_1.id
	}

	function var_4_0.onYes()
		self.contextData.OnConfirm(arg_4_1.id)
		self:closeView()

		return
	end

	self.msgBox:ExecuteAction("Show", var_4_0)

	return
end

function NewSelectSkinLayer:ClickTrigger(arg_6_1, arg_6_2)
	if self.contextData.mode == NewSelectSkinLayer.MODE_VIEW then
		return
	end

	self:Check(arg_6_1.skin)

	return
end

function NewSelectSkinLayer:OnUpdateItem(arg_7_1, arg_7_2)
	TweenItemAlphaAndWhite(arg_7_2)

	arg_7_1 = arg_7_1 + 1

	local var_7_0 = self.scrollDisplays[arg_7_1]

	if self.goDic[arg_7_2] and self.goDic[arg_7_2] ~= arg_7_1 then
		local var_7_1 = self:GetDisplayIndex(self.scrollShowClassifyIds[self.goDic[arg_7_2]])

		self:ReturnIndex(self.goDic[arg_7_2])

		if var_7_1 ~= self:GetDisplayIndex(self.scrollShowClassifyIds[self.goDic[arg_7_2]]) then
			local var_7_2 = {}

			table.insert(var_7_2, var_7_1)
			table.insert(var_7_2, self:GetDisplayIndex(self.scrollShowClassifyIds[self.goDic[arg_7_2]]))
			self:ChangeClassifyName(var_7_2)
		end
	end

	self.goDic[arg_7_2] = arg_7_1

	local var_7_3 = self:GetDisplayIndex(self.scrollShowClassifyIds[arg_7_1])

	self:RegisterIndex(arg_7_1)

	local var_7_4 = {}

	if var_7_3 ~= self:GetDisplayIndex(self.scrollShowClassifyIds[arg_7_1]) then
		table.insert(var_7_4, var_7_3)
	end

	table.insert(var_7_4, arg_7_1)
	self:ChangeClassifyName(var_7_4)

	if self.scrollDisplays[arg_7_1] then
		local var_7_5 = UIItemList.New(tf(arg_7_2):Find("skins"), tf(arg_7_2):Find("skins/SkinAtlasCard"))

		var_7_5:make(function(arg_8_0, arg_8_1, arg_8_2)
			if arg_8_0 == UIItemList.EventUpdate then
				local var_8_0 = var_7_0[arg_8_1 + 1]
				local var_8_1 = SkinAtlasCard.New(arg_8_2)

				table.insert(self.cards, var_8_1)
				var_8_1:Update(var_7_0[arg_8_1 + 1], arg_8_1 + 1, true)
				onButton(self, arg_8_2, function()
					self:ClickTrigger(var_8_1, var_8_0)

					return
				end, SFX_PANEL)
				onButton(self, var_8_1.changeSkinUI, function()
					var_8_1:changeSkinNext()

					return
				end, SFX_PANEL)
			end

			return
		end)
		var_7_5:align(#self.scrollDisplays[arg_7_1])
	end

	return
end

function NewSelectSkinLayer:willExit()
	NewSelectSkinLayer.super.willExit(self)
	self.msgBox:Destroy()

	return
end

return NewSelectSkinLayer

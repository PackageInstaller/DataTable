local SelectSkinLayer = class("SelectSkinLayer", import(".SkinAtlasScene"))

SelectSkinLayer.MODE_SELECT = 1
SelectSkinLayer.MODE_VIEW = 2

function SelectSkinLayer:getUIName()
	return "SelectSkinUI"
end

function SelectSkinLayer:init()
	SelectSkinLayer.super.init(self)
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	self.msgBox = SelectSkinMsgbox.New(self._tf, self.event)

	return
end

function SelectSkinLayer:didEnter()
	SelectSkinLayer.super.didEnter(self)

	return
end

function SelectSkinLayer:GetSkinList(arg_4_1, arg_4_2)
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(self.contextData.selectableSkinList or {}) do
		local var_4_2 = iter_4_1:ToShipSkin()

		if (arg_4_1 == SelectSkinLayer.PAGE_ALL or var_4_2:IsType(arg_4_1)) and not var_4_2:IsDefault() and var_4_2:IsMatchKey(arg_4_2) and self:MatchIndex(var_4_2) then
			table.insert(var_4_1, iter_4_1)
		end
	end

	return var_4_1
end

function SelectSkinLayer:SortDisplay(arg_5_1)
	table.sort(arg_5_1, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0:GetTimeLimitWeight()
		local var_6_1 = arg_6_1:GetTimeLimitWeight()

		if var_6_0 == var_6_1 then
			local var_6_2 = arg_6_0:GetOwnWeight()
			local var_6_3 = arg_6_1:GetOwnWeight()

			if var_6_2 == var_6_3 then
				return arg_6_0.skinId > arg_6_1.skinId
			else
				return var_6_3 < var_6_2
			end
		else
			return var_6_1 < var_6_0
		end

		return
	end)

	return
end

function SelectSkinLayer:OnInitItem(arg_7_1)
	local var_7_0 = SelectSkinCard.New(arg_7_1)

	onButton(self, var_7_0._tf, function()
		if self.contextData.mode == SelectSkinLayer.MODE_VIEW then
			return
		end

		self:Check(var_7_0.skin)

		return
	end, SFX_PANEL)

	self.cards[arg_7_1] = var_7_0

	return
end

function SelectSkinLayer:OnUpdateItem(arg_9_1, arg_9_2)
	if not self.cards[arg_9_2] then
		self:OnInitItem(arg_9_2)
	end

	self.cards[arg_9_2]:Update(self.displays[arg_9_1 + 1]:ToShipSkin(), arg_9_1 + 1, self.displays[arg_9_1 + 1]:IsTimeLimit(), self.displays[arg_9_1 + 1]:OwnSkin())

	return
end

function SelectSkinLayer:Check(arg_10_1)
	local var_10_1
	local var_10_0

	if getProxy(ShipSkinProxy):hasSkin(arg_10_1.id) then
		do return end

		var_10_0 = {
			content = i18n("skin_exchange_confirm", Item.getConfigData(self.contextData.itemId).name, arg_10_1.skinName)
		}
		var_10_1 = {
			count = 1,
			type = DROP_TYPE_ITEM
		}
	end

	var_10_1.id = self.contextData.itemId
	var_10_0.leftDrop = var_10_1
	var_10_0.rightDrop = {
		count = 1,
		type = DROP_TYPE_SKIN,
		id = arg_10_1.id
	}

	function var_10_0.onYes()
		self.contextData.OnConfirm(arg_10_1.id)
		self:closeView()

		return
	end

	self.msgBox:ExecuteAction("Show", var_10_0)

	return
end

function SelectSkinLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self.msgBox:Destroy()
	SelectSkinLayer.super.willExit(self)

	return
end

return SelectSkinLayer

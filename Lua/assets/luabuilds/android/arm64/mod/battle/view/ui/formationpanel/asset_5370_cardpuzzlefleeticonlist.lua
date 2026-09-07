ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleCardPuzzleConfig
local var_0_3 = ys.Battle.BattleCardPuzzleEvent

ys.Battle.CardPuzzleFleetIconList = class("CardPuzzleFleetIconList")
ys.Battle.CardPuzzleFleetIconList.__name = "CardPuzzleFleetIconList"

function ys.Battle.CardPuzzleFleetIconList:Ctor(arg_1_1)
	self._go = arg_1_1

	self:init()

	return
end

function ys.Battle.CardPuzzleFleetIconList:SetCardPuzzleComponent(arg_2_1)
	var_0_0.EventListener.AttachEventListener(self)

	self._info = arg_2_1
	self._attrManager = self._info:GetAttrManager()
	self._buffManager = self._info:GetBuffManager()

	self._info:RegisterEventListener(self, var_0_3.UPDATE_FLEET_ATTR, self.onUpdateFleetAttr)

	return
end

function ys.Battle.CardPuzzleFleetIconList:init()
	self._buffIconList = {}
	self._attrIconList = {}
	self._tf = self._go.transform
	self._iconTpl = self._tf:Find("icon_tpl")
	self._iconContainer = self._tf:Find("icon_list")

	return
end

function ys.Battle.CardPuzzleFleetIconList:AddBuffIcon(arg_4_1)
	local var_4_0 = cloneTplTo(self._iconTpl, self._iconContainer)
	local var_4_1 = var_4_0:Find("icon")
	local var_4_2 = {
		tf = var_4_0,
		count = var_4_0:Find("count_bg/count_label"),
		durationIMG = var_4_0:Find("buff_duration"):GetComponent(typeof(Image)),
		buffID = arg_4_1
	}

	self._buffIconList[arg_4_1] = var_4_2

	self:updateBuffIcon(var_4_2)

	return
end

function ys.Battle.CardPuzzleFleetIconList:AddAttrIcon(arg_5_1)
	local var_5_0 = cloneTplTo(self._iconTpl, self._iconContainer)
	local var_5_1 = var_5_0:Find("icon")
	local var_5_2 = {
		tf = var_5_0,
		count = var_5_0:Find("count_bg/count_label"),
		attr = arg_5_1
	}

	self._attrIconList[arg_5_1] = var_5_2

	self:updateAttrIcon(var_5_2)

	return
end

function ys.Battle.CardPuzzleFleetIconList:onUpdateFleetAttr(arg_6_1)
	if var_0_2.FleetIconRegisterAttr[arg_6_1.Data.attrName] then
		if self._attrIconList[arg_6_1.Data.attrName] then
			self:updateAttrIcon(self._attrIconList[arg_6_1.Data.attrName])
		else
			self:AddAttrIcon(arg_6_1.Data.attrName)
		end
	end

	return
end

function ys.Battle.CardPuzzleFleetIconList:updateAttrIcon(arg_7_1)
	setText(arg_7_1.count, (self._attrManager:GetCurrent(arg_7_1.attr)))

	return
end

function ys.Battle.CardPuzzleFleetIconList:updateBuffIcon(arg_8_1)
	local var_8_0 = self._buffManager:GetCardPuzzleBuff(arg_8_1.buffID)

	setText(arg_8_1.count, (var_8_0:GetStack()))

	arg_8_1.durationIMG.fillAmount = var_8_0:GetDurationRate()

	return
end

function ys.Battle.CardPuzzleFleetIconList:Update()
	for iter_9_0, iter_9_1 in pairs((self._buffManager:GetCardPuzzleBuffList())) do
		if var_0_2.FleetIconRegisterBuff[iter_9_0] then
			if self._buffIconList[iter_9_0] == nil then
				self:AddBuffIcon(iter_9_0)
			else
				self:updateBuffIcon(self._buffIconList[iter_9_0])
			end
		end
	end

	return
end

function ys.Battle.CardPuzzleFleetIconList.Dispose(arg_10_0)
	arg_10_0._buffIconList = nil
	arg_10_0._attrIconList = nil
	arg_10_0._tf = nil
	arg_10_0._iconTpl = nil
	arg_10_0._iconContainer = nil

	return
end

return

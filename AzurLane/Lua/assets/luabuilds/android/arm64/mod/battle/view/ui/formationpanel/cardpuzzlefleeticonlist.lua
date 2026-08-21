ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleCardPuzzleConfig
local var_0_3 = ys.Battle.BattleCardPuzzleEvent

ys.Battle.CardPuzzleFleetIconList = class("CardPuzzleFleetIconList")
ys.Battle.CardPuzzleFleetIconList.__name = "CardPuzzleFleetIconList"

function ys.Battle.CardPuzzleFleetIconList.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	arg_1_0:init()

	return
end

function ys.Battle.CardPuzzleFleetIconList.SetCardPuzzleComponent(arg_2_0, arg_2_1)
	var_0_0.EventListener.AttachEventListener(arg_2_0)

	arg_2_0._info = arg_2_1
	arg_2_0._attrManager = arg_2_0._info:GetAttrManager()
	arg_2_0._buffManager = arg_2_0._info:GetBuffManager()

	arg_2_0._info:RegisterEventListener(arg_2_0, var_0_3.UPDATE_FLEET_ATTR, arg_2_0.onUpdateFleetAttr)

	return
end

function ys.Battle.CardPuzzleFleetIconList.init(arg_3_0)
	arg_3_0._buffIconList = {}
	arg_3_0._attrIconList = {}
	arg_3_0._tf = arg_3_0._go.transform
	arg_3_0._iconTpl = arg_3_0._tf:Find("icon_tpl")
	arg_3_0._iconContainer = arg_3_0._tf:Find("icon_list")

	return
end

function ys.Battle.CardPuzzleFleetIconList.AddBuffIcon(arg_4_0, arg_4_1)
	local var_4_0 = cloneTplTo(arg_4_0._iconTpl, arg_4_0._iconContainer)
	local var_4_1 = var_4_0:Find("icon")
	local var_4_2 = {
		tf = var_4_0,
		count = var_4_0:Find("count_bg/count_label"),
		durationIMG = var_4_0:Find("buff_duration"):GetComponent(typeof(Image)),
		buffID = arg_4_1
	}

	arg_4_0._buffIconList[arg_4_1] = var_4_2

	arg_4_0:updateBuffIcon(var_4_2)

	return
end

function ys.Battle.CardPuzzleFleetIconList.AddAttrIcon(arg_5_0, arg_5_1)
	local var_5_0 = cloneTplTo(arg_5_0._iconTpl, arg_5_0._iconContainer)
	local var_5_1 = var_5_0:Find("icon")
	local var_5_2 = {
		tf = var_5_0,
		count = var_5_0:Find("count_bg/count_label"),
		attr = arg_5_1
	}

	arg_5_0._attrIconList[arg_5_1] = var_5_2

	arg_5_0:updateAttrIcon(var_5_2)

	return
end

function ys.Battle.CardPuzzleFleetIconList.onUpdateFleetAttr(arg_6_0, arg_6_1)
	if var_0_2.FleetIconRegisterAttr[arg_6_1.Data.attrName] then
		if arg_6_0._attrIconList[arg_6_1.Data.attrName] then
			arg_6_0:updateAttrIcon(arg_6_0._attrIconList[arg_6_1.Data.attrName])
		else
			arg_6_0:AddAttrIcon(arg_6_1.Data.attrName)
		end
	end

	return
end

function ys.Battle.CardPuzzleFleetIconList.updateAttrIcon(arg_7_0, arg_7_1)
	setText(arg_7_1.count, (arg_7_0._attrManager:GetCurrent(arg_7_1.attr)))

	return
end

function ys.Battle.CardPuzzleFleetIconList.updateBuffIcon(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._buffManager:GetCardPuzzleBuff(arg_8_1.buffID)

	setText(arg_8_1.count, (var_8_0:GetStack()))

	arg_8_1.durationIMG.fillAmount = var_8_0:GetDurationRate()

	return
end

function ys.Battle.CardPuzzleFleetIconList.Update(arg_9_0)
	for iter_9_0, iter_9_1 in pairs((arg_9_0._buffManager:GetCardPuzzleBuffList())) do
		if var_0_2.FleetIconRegisterBuff[iter_9_0] then
			if arg_9_0._buffIconList[iter_9_0] == nil then
				arg_9_0:AddBuffIcon(iter_9_0)
			else
				arg_9_0:updateBuffIcon(arg_9_0._buffIconList[iter_9_0])
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

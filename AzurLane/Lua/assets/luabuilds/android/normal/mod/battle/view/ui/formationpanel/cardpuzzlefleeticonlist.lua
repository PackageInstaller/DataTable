ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleCardPuzzleConfig
local var_0_3 = var_0.Battle.BattleCardPuzzleEvent
local var_0_4 = var_0.Battle

class = var_0_10005
var_0_4.CardPuzzleFleetIconList = var_0_10005("CardPuzzleFleetIconList")

local var_0_5 = var_0.Battle.CardPuzzleFleetIconList

var_0_5.__name = "CardPuzzleFleetIconList"

function var_0_5.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	arg_1_0:init()

	return
end

function var_0_5.SetCardPuzzleComponent(arg_2_0, arg_2_1)
	var_0.EventListener.AttachEventListener(arg_2_0)

	arg_2_0._info = arg_2_1

	local var_2_0 = arg_2_0._info

	arg_2_0._attrManager = var_2.GetAttrManager(var_2_0)

	local var_2_1 = arg_2_0._info

	arg_2_0._buffManager = var_2.GetBuffManager(var_2_1)

	local var_2_2 = arg_2_0._info

	var_2.RegisterEventListener(var_2_2, arg_2_0, var_0_3.UPDATE_FLEET_ATTR, arg_2_0.onUpdateFleetAttr)

	return
end

function var_0_5.init(arg_3_0)
	arg_3_0._buffIconList = {}
	arg_3_0._attrIconList = {}
	arg_3_0._tf = arg_3_0._go.transform

	local var_3_0 = arg_3_0._tf

	arg_3_0._iconTpl = var_1.Find(var_3_0, "icon_tpl")

	local var_3_1 = arg_3_0._tf

	arg_3_0._iconContainer = var_1.Find(var_3_1, "icon_list")

	return
end

function var_0_5.AddBuffIcon(arg_4_0, arg_4_1)
	cloneTplTo = var_1_10002

	local var_4_0 = var_1_10002(arg_4_0._iconTpl, arg_4_0._iconContainer)
	local var_4_1 = var_2.Find(var_4_0, "count_bg/count_label")
	local var_4_2 = var_2:Find("icon")
	local var_4_3 = var_2:Find("buff_duration")
	local var_4_4 = var_5.GetComponent

	typeof = var_7
	Image = var_1_10008

	local var_4_5 = var_4_4(var_4_3, var_7(var_1_10008))
	local var_4_6 = {
		tf = var_2,
		count = var_4_1,
		durationIMG = var_4_5,
		buffID = arg_4_1
	}

	arg_4_0._buffIconList[arg_4_1] = var_4_6

	arg_4_0:updateBuffIcon(var_4_6)

	return
end

function var_0_5.AddAttrIcon(arg_5_0, arg_5_1)
	cloneTplTo = var_1_10002

	local var_5_0 = var_1_10002(arg_5_0._iconTpl, arg_5_0._iconContainer)
	local var_5_1 = var_2.Find(var_5_0, "count_bg/count_label")
	local var_5_2 = var_2:Find("icon")
	local var_5_3 = {
		tf = var_2,
		count = var_5_1,
		attr = arg_5_1
	}

	arg_5_0._attrIconList[arg_5_1] = var_5_3

	arg_5_0:updateAttrIcon(var_5_3)

	return
end

function var_0_5.onUpdateFleetAttr(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.Data.attrName

	if var_0_2.FleetIconRegisterAttr[var_6_0] then
		if arg_6_0._attrIconList[var_6_0] then
			arg_6_0:updateAttrIcon(var_3)
		else
			arg_6_0:AddAttrIcon(var_6_0)
		end
	end

	return
end

function var_0_5.updateAttrIcon(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.count
	local var_7_1 = arg_7_1.attr
	local var_7_2 = arg_7_0._attrManager
	local var_7_3 = var_4.GetCurrent(var_7_2, var_7_1)

	setText = var_7_2

	var_7_2(var_7_0, var_7_3)

	return
end

function var_0_5.updateBuffIcon(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.buffID
	local var_8_1 = arg_8_0._buffManager
	local var_8_2 = var_3.GetCardPuzzleBuff(var_8_1, var_8_0)
	local var_8_3 = arg_8_1.count
	local var_8_4 = var_8_2
	local var_8_5 = var_8_2.GetStack(var_8_4)

	setText = var_8_4

	var_8_4(var_8_3, var_8_5)

	arg_8_1.durationIMG.fillAmount = var_8_2:GetDurationRate()

	return
end

function var_0_5.Update(arg_9_0)
	local var_9_0 = arg_9_0._buffManager
	local var_9_1 = var_1.GetCardPuzzleBuffList(var_9_0)

	pairs = var_9_0

	for iter_9_0, iter_9_1 in var_9_0(var_9_1) do
		if var_0_2.FleetIconRegisterBuff[iter_9_0] then
			if arg_9_0._buffIconList[iter_9_0] == nil then
				arg_9_0:AddBuffIcon(iter_9_0)
			else
				arg_9_0:updateBuffIcon(var_7)
			end
		end
	end

	return
end

function var_0_5.Dispose(arg_10_0)
	arg_10_0._buffIconList = nil
	arg_10_0._attrIconList = nil
	arg_10_0._tf = nil
	arg_10_0._iconTpl = nil
	arg_10_0._iconContainer = nil

	return
end

return

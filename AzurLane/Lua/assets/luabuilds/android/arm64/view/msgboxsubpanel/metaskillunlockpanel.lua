class = var_0_10000

local var_0_0 = "MetaSkillUnlockPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MsgboxSubPanel"))

function var_0_1.getUIName(arg_1_0)
	return "MetaSkillUnlockBox"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initData()
	arg_2_0:addListener()

	return
end

function var_0_1.UpdateView(arg_3_0, arg_3_1)
	arg_3_0:PreRefresh(arg_3_1)
	arg_3_0:updateContent(arg_3_1)

	rtf = var_2

	local var_3_0 = var_2(arg_3_0.viewParent._window)

	Vector2 = var_1_10003
	var_3_0.sizeDelta = var_1_10003.New(1000, 638)

	arg_3_0:PostRefresh(arg_3_1)

	return
end

function var_0_1.findUI(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.tipText = var_1.Find(var_4_0, "Tip")

	local var_4_1 = arg_4_0._tf

	arg_4_0.materialTpl = var_1.Find(var_4_1, "Material")

	local var_4_2 = arg_4_0._tf

	arg_4_0.materialContainer = var_1.Find(var_4_2, "MaterialContainer")
	UIItemList = var_1
	arg_4_0.uiItemList = var_1.New(arg_4_0.materialContainer, arg_4_0.materialTpl)

	local var_4_3 = arg_4_0._tf

	arg_4_0.cancelBtn = var_1.Find(var_4_3, "Buttons/CancelBtn")

	local var_4_4 = arg_4_0._tf

	arg_4_0.confirmBtn = var_1.Find(var_4_4, "Buttons/ConfirmBtn")

	local var_4_5 = arg_4_0.cancelBtn
	local var_4_6 = var_1.Find(var_4_5, "Text")
	local var_4_7 = arg_4_0.confirmBtn
	local var_4_8 = var_2.Find(var_4_7, "Text")

	setText = var_4_5

	local var_4_9 = var_4_6

	i18n = var_1_10006

	var_4_5(var_4_9, var_1_10006("word_cancel"))

	setText = var_4_5

	local var_4_10 = var_4_8

	i18n = var_6

	var_4_5(var_4_10, var_6("word_ok"))

	return
end

function var_0_1.initData(arg_5_0)
	arg_5_0.curMetaShipID = nil
	arg_5_0.curUnlockSkillID = nil
	arg_5_0.curUnlockMaterialID = nil
	arg_5_0.curUnlockMaterialNeedCount = nil

	return
end

function var_0_1.addListener(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.confirmBtn

	local function var_6_2()
		local var_7_0

		if not arg_6_0.curUnlockMaterialID then
			pg = var_7_0
			var_2_10002 = var_7_0.TipsMgr.GetInstance()
			var_7_0 = var_7_0.ShowTips
			i18n = var_2_10003

			var_7_0(var_2_10002, var_2_10003("meta_unlock_skill_select"))

			return
		else
			getProxy = var_7_0
			BagProxy = var_2_10002

			local var_7_1 = var_7_0(var_2_10002)
			local var_7_2

			if var_7_0.getItemCountById(var_7_1, arg_6_0.curUnlockMaterialID) < arg_6_0.curUnlockMaterialNeedCount then
				pg = var_1
				var_7_2 = var_1.TipsMgr.GetInstance()

				local var_7_3 = var_1.ShowTips

				i18n = var_2_10004

				var_7_3(var_7_2, var_2_10004("word_materal_no_enough"))
			else
				local var_7_4 = 0
				local var_7_5 = 0

				MetaCharacterConst = var_7_2

				local var_7_6 = var_7_2.getMetaSkillTacticsConfig(arg_6_0.curUnlockSkillID, 1).skill_unlock

				ipairs = var_5

				for iter_7_0, iter_7_1 in var_5(var_7_6) do
					if arg_6_0.curUnlockMaterialID == iter_7_1[2] then
						var_7_4 = iter_7_0
						var_7_5 = iter_7_1[3]

						break
					end
				end

				pg = var_5

				local var_7_7 = var_5.m02
				local var_7_8 = var_5.sendNotification

				GAME = iter_7_0

				var_7_8(var_7_7, iter_7_0.TACTICS_META_UNLOCK_SKILL, {
					shipID = arg_6_0.curMetaShipID,
					skillID = arg_6_0.curUnlockSkillID,
					materialIndex = var_7_4,
					materialInfo = {
						id = arg_6_0.curUnlockMaterialID,
						count = var_7_5
					}
				})
			end
		end

		pg = var_7_0

		local var_7_9 = var_7_0.MsgboxMgr.GetInstance()

		var_0.hide(var_7_9)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10006)

	onButton = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.cancelBtn

	local function var_6_5()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()

		var_0.hide(var_8_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10006)

	return
end

function var_0_1.updateContent(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.metaShipVO
	local var_9_1 = var_2.getMetaCharacter(var_9_0)

	arg_9_0.curMetaShipID = var_2.id
	arg_9_0.curUnlockSkillID = arg_9_1.skillID
	ShipGroup = var_9_0

	local var_9_2 = var_9_0.getDefaultShipNameByGroupID(var_9_1.id)

	getSkillName = var_1_10006

	local var_9_3 = var_1_10006(var_4)

	setText = var_7

	local var_9_4 = arg_9_0.tipText

	i18n = var_1_10010

	var_7(var_9_4, var_1_10010("meta_unlock_skill_tip", var_9_2, var_9_3))

	MetaCharacterConst = var_7

	local var_9_5 = var_7.getMetaSkillTacticsConfig(var_4, 1).skill_unlock
	local var_9_6 = {
		var_7.skill_unlock[1]
	}
	local var_9_7 = arg_9_0.uiItemList

	var_9.make(var_9_7, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			arg_10_1 = arg_10_1 + 1

			local var_10_0 = var_9_6[arg_10_1]
			local var_10_1 = arg_10_2:Find("Item")
			local var_10_2 = arg_10_2:Find("SelectedTag")
			local var_10_3 = arg_10_2
			local var_10_4 = arg_10_2.Find(var_10_3, "Count/Text")
			local var_10_5 = {}

			DROP_TYPE_ITEM = var_10_3
			var_10_5.type = var_10_3
			var_10_5.id = var_10_0[2]
			var_10_5.count = var_10_0[3]
			updateDrop = var_8

			var_8(var_10_1, var_10_5)

			setActive = var_8

			var_8(var_10_2, false)

			local var_10_6 = var_10_0[2]
			local var_10_7 = var_10_0[3]

			getProxy = var_10
			BagProxy = var_2_10012

			local var_10_8 = var_10(var_2_10012)

			if var_10.getItemCountById(var_10_8, var_10_6) < var_10_7 then
				setColorStr = var_10_11

				local var_10_9 = var_10

				COLOR_RED = var_2_10014

				local var_10_11

				if not var_10_11(var_10_9, var_2_10014) then
					setColorStr = var_10_11

					local var_10_10 = var_10

					COLOR_GREEN = var_2_10014
					var_10_11 = var_10_11(var_10_10, var_2_10014)
				end

				setText = var_10_8

				var_10_8(var_10_4, var_10_11 .. "/" .. var_10_7)

				arg_9_0.curUnlockMaterialID = var_10_6
				arg_9_0.curUnlockMaterialNeedCount = var_10_7

				return
			end
		end
	end)

	local var_9_8 = arg_9_0.uiItemList

	var_9.align(var_9_8, #var_9_6)

	return
end

return var_0_1

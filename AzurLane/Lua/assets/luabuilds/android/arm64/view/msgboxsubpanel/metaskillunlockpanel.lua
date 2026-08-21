local var_0_0 = class("MetaSkillUnlockPanel", import(".MsgboxSubPanel"))

function var_0_0.getUIName(arg_1_0)
	return "MetaSkillUnlockBox"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:initData()
	arg_2_0:addListener()

	return
end

function var_0_0.UpdateView(arg_3_0, arg_3_1)
	arg_3_0:PreRefresh(arg_3_1)
	arg_3_0:updateContent(arg_3_1)

	rtf(arg_3_0.viewParent._window).sizeDelta = Vector2.New(1000, 638)

	arg_3_0:PostRefresh(arg_3_1)

	return
end

function var_0_0.findUI(arg_4_0)
	arg_4_0.tipText = arg_4_0._tf:Find("Tip")
	arg_4_0.materialTpl = arg_4_0._tf:Find("Material")
	arg_4_0.materialContainer = arg_4_0._tf:Find("MaterialContainer")
	arg_4_0.uiItemList = UIItemList.New(arg_4_0.materialContainer, arg_4_0.materialTpl)
	arg_4_0.cancelBtn = arg_4_0._tf:Find("Buttons/CancelBtn")
	arg_4_0.confirmBtn = arg_4_0._tf:Find("Buttons/ConfirmBtn")

	setText(arg_4_0.cancelBtn:Find("Text"), i18n("word_cancel"))
	setText(arg_4_0.confirmBtn:Find("Text"), i18n("word_ok"))

	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.curMetaShipID = nil
	arg_5_0.curUnlockSkillID = nil
	arg_5_0.curUnlockMaterialID = nil
	arg_5_0.curUnlockMaterialNeedCount = nil

	return
end

function var_0_0.addListener(arg_6_0)
	onButton(arg_6_0, arg_6_0.confirmBtn, function()
		if not arg_6_0.curUnlockMaterialID then
			pg.TipsMgr.GetInstance():ShowTips(i18n("meta_unlock_skill_select"))

			return
		else
			local var_7_0 = getProxy(BagProxy)

			if var_7_0:getItemCountById(arg_6_0.curUnlockMaterialID) < arg_6_0.curUnlockMaterialNeedCount then
				pg.TipsMgr.GetInstance():ShowTips(i18n("word_materal_no_enough"))
			else
				local var_7_1 = 0
				local var_7_2 = 0

				for iter_7_0, iter_7_1 in ipairs(MetaCharacterConst.getMetaSkillTacticsConfig(arg_6_0.curUnlockSkillID, 1).skill_unlock) do
					if arg_6_0.curUnlockMaterialID == iter_7_1[2] then
						var_7_1 = iter_7_0
						var_7_2 = iter_7_1[3]

						break
					end
				end

				pg.m02:sendNotification(GAME.TACTICS_META_UNLOCK_SKILL, {
					shipID = arg_6_0.curMetaShipID,
					skillID = arg_6_0.curUnlockSkillID,
					materialIndex = var_7_1,
					materialInfo = {
						id = arg_6_0.curUnlockMaterialID,
						count = var_7_2
					}
				})
			end
		end

		pg.MsgboxMgr.GetInstance():hide()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.cancelBtn, function()
		pg.MsgboxMgr.GetInstance():hide()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.updateContent(arg_9_0, arg_9_1)
	arg_9_0.curMetaShipID = arg_9_1.metaShipVO.id
	arg_9_0.curUnlockSkillID = arg_9_1.skillID

	setText(arg_9_0.tipText, i18n("meta_unlock_skill_tip", ShipGroup.getDefaultShipNameByGroupID(arg_9_1.metaShipVO:getMetaCharacter().id), (getSkillName(arg_9_1.skillID))))

	local var_9_0 = MetaCharacterConst.getMetaSkillTacticsConfig(arg_9_1.skillID, 1)
	local var_9_2 = {
		var_9_0.skill_unlock[1]
	}

	arg_9_0.uiItemList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			arg_10_1 = arg_10_1 + 1

			local var_10_0 = var_9_2[arg_10_1]
			local var_10_1 = arg_10_2:Find("Count/Text")

			updateDrop(arg_10_2:Find("Item"), {
				type = DROP_TYPE_ITEM,
				id = var_9_2[arg_10_1][2],
				count = var_9_2[arg_10_1][3]
			})
			setActive(arg_10_2:Find("SelectedTag"), false)

			local var_10_2 = var_10_0[2]
			local var_10_3 = var_10_0[3]
			local var_10_4 = getProxy(BagProxy):getItemCountById(var_10_0[2])
			local var_10_5 = var_10_4 < var_10_0[3] and setColorStr(var_10_4, COLOR_RED) or setColorStr(var_10_4, COLOR_GREEN)

			setText(var_10_1, var_10_5 .. "/" .. var_10_0[3])

			arg_9_0.curUnlockMaterialID = var_10_2
			arg_9_0.curUnlockMaterialNeedCount = var_10_3
		end

		return
	end)
	arg_9_0.uiItemList:align(#{
		var_9_0.skill_unlock[1]
	})

	return
end

return var_0_0

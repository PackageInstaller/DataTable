local var_0_0 = class("NavalTacticsMetaSkillsView", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "NavalTacticsMetaSkillsPanel"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:initUITip()
	arg_2_0:initUI()
	arg_2_0:addListener()
	arg_2_0:updateSkillList()
	triggerToggle(arg_2_0.skillToggleList[1], true)
	arg_2_0:Show()

	return
end

function var_0_0.Show(arg_3_0)
	var_0_0.super.Show(arg_3_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)

	return
end

function var_0_0.Hide(arg_4_0)
	var_0_0.super.Hide(arg_4_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_4_0._tf, pg.UIMgr.GetInstance().UIMain)

	return
end

function var_0_0.OnDestroy(arg_5_0)
	arg_5_0:Hide()

	return
end

function var_0_0.setData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.metaShipID = arg_6_1 or arg_6_0.metaShipID
	arg_6_0.metaShipVO = getProxy(BayProxy):getShipById(arg_6_0.metaShipID)
	arg_6_0.closeCB = arg_6_2 or arg_6_0.closeCB
	arg_6_0.metaProxy = getProxy(MetaCharacterProxy)
	arg_6_0.metaTacticsInfo = arg_6_0.metaProxy:getMetaTacticsInfoByShipID(arg_6_0.metaShipVO.id)
	arg_6_0.selectSkillID = arg_6_0.selectSkillID or nil

	return
end

function var_0_0.initUITip(arg_7_0)
	local var_7_0 = arg_7_0._tf:Find("frame/bg/title_bg/title")

	setText(arg_7_0._tf:Find("frame/buttons/detail_btn/Image"), i18n("meta_tactics_detail"))
	setText(arg_7_0._tf:Find("frame/buttons/unlock_btn/Image"), i18n("meta_tactics_unlock"))
	setText(arg_7_0._tf:Find("frame/buttons/switch_btn/Image"), i18n("meta_tactics_switch"))

	return
end

function var_0_0.initUI(arg_8_0)
	arg_8_0.bg = arg_8_0._tf:Find("print")

	local var_8_0 = arg_8_0._tf:Find("frame")

	arg_8_0.skillTpl = var_8_0:Find("skilltpl")
	arg_8_0.skillContainer = var_8_0:Find("skill_contain/content")

	local var_8_1 = var_8_0:Find("buttons")

	arg_8_0.detailBtn = var_8_1:Find("detail_btn")
	arg_8_0.unlockBtn = var_8_1:Find("unlock_btn")
	arg_8_0.switchBtn = var_8_1:Find("switch_btn")
	arg_8_0.skillUIItemList = UIItemList.New(arg_8_0.skillContainer, arg_8_0.skillTpl)

	return
end

function var_0_0.addListener(arg_9_0)
	onButton(arg_9_0, arg_9_0.bg, function()
		arg_9_0:Hide()

		if arg_9_0.closeCB then
			arg_9_0.closeCB()
		else
			arg_9_0:Destroy()
		end

		return
	end, SFX_CANCEL)
	onButton(arg_9_0, arg_9_0.detailBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.METACHARACTER, {
			autoOpenTactics = true,
			autoOpenShipConfigID = arg_9_0.metaShipVO.configId
		})

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.unlockBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideYes = true,
			hideNo = true,
			type = MSGBOX_TYPE_META_SKILL_UNLOCK,
			metaShipVO = arg_9_0.metaShipVO,
			skillID = arg_9_0.selectSkillID
		})

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.switchBtn, function()
		pg.m02:sendNotification(GAME.TACTICS_META_SWITCH_SKILL, {
			shipID = arg_9_0.metaShipVO.id,
			skillID = arg_9_0.selectSkillID
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateSkillTF(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:Find("frame")
	local var_14_1 = var_14_0:Find("skillInfo")
	local var_14_2 = var_14_0:Find("empty")
	local var_14_3 = var_14_0:Find("mask")
	local var_14_4 = var_14_1:Find("descView/Viewport/desc")
	local var_14_5 = var_14_1:Find("next_contain/label")
	local var_14_6 = var_14_1:Find("next_contain/Text")
	local var_14_7 = var_14_1:Find("name_contain/name")
	local var_14_8 = var_14_1:Find("name_contain/level_contain/Text")
	local var_14_9 = var_14_0:Find("Tag/learing")
	local var_14_10 = var_14_0:Find("Tag/unlockable")
	local var_14_11 = arg_14_0.metaShipVO:getMetaSkillLevelBySkillID(arg_14_2)
	local var_14_12 = getSkillConfig(arg_14_2)
	local var_14_13 = arg_14_2 == arg_14_0.metaTacticsInfo.curSkillID
	local var_14_14 = var_14_11 > 0

	setImageSprite(var_14_1:Find("icon"), LoadSprite("skillicon/" .. var_14_12.icon))
	setText(var_14_4, getSkillDesc(arg_14_2, var_14_14 and var_14_11 or 1))
	setText(var_14_7, getSkillName(var_14_12.id))
	setText(var_14_8, var_14_11)

	local var_14_15 = arg_14_0.metaTacticsInfo:getSkillExp(arg_14_2)
	local var_14_16 = var_14_11 >= pg.skill_data_template[arg_14_2].max_level

	if var_14_11 < pg.skill_data_template[arg_14_2].max_level then
		if var_14_14 then
			setText(var_14_6, setColorStr(var_14_15, COLOR_GREEN) .. "/" .. MetaCharacterConst.getMetaSkillTacticsConfig(arg_14_2, var_14_11).need_exp)
			setActive(var_14_5, true)
			setActive(var_14_6, true)
		else
			setActive(var_14_5, false)
			setActive(var_14_6, false)
		end
	else
		setText(var_14_6, "Max")
	end

	setActive(var_14_9, var_14_13 and not var_14_16)
	setActive(var_14_10, not var_14_14)
	setActive(var_14_3, not var_14_14)
	onToggle(arg_14_0, arg_14_1, function(arg_15_0)
		if arg_15_0 then
			arg_14_0.selectSkillID = arg_14_2

			arg_14_0:updateButtons(arg_14_0.selectSkillID)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateSkillList(arg_16_0)
	local var_16_0 = MetaCharacterConst.getTacticsSkillIDListByShipConfigID(arg_16_0.metaShipVO.configId)

	arg_16_0.skillUIItemList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			arg_17_1 = arg_17_1 + 1
			arg_16_0.skillToggleList = arg_16_0.skillToggleList or {}
			arg_16_0.skillToggleList[arg_17_1] = arg_17_2

			arg_16_0:updateSkillTF(arg_17_2, var_16_0[arg_17_1])
		end

		return
	end)
	arg_16_0.skillUIItemList:align(#MetaCharacterConst.getTacticsSkillIDListByShipConfigID(arg_16_0.metaShipVO.configId))

	return
end

function var_0_0.updateButtons(arg_18_0, arg_18_1)
	local var_18_0 = (arg_18_1 or arg_18_0.selectSkillID) == arg_18_0.metaTacticsInfo.curSkillID
	local var_18_1 = arg_18_0.metaShipVO:getMetaSkillLevelBySkillID(arg_18_1 or arg_18_0.selectSkillID) > 0

	if (arg_18_1 or arg_18_0.selectSkillID) == arg_18_0.metaTacticsInfo.curSkillID or arg_18_0.metaShipVO:isSkillLevelMax(arg_18_1 or arg_18_0.selectSkillID) then
		setActive(arg_18_0.detailBtn, true)
		setActive(arg_18_0.unlockBtn, false)
		setActive(arg_18_0.switchBtn, false)
	elseif not var_18_1 then
		setActive(arg_18_0.detailBtn, true)
		setActive(arg_18_0.unlockBtn, true)
		setActive(arg_18_0.switchBtn, false)
	elseif var_18_1 and not var_18_0 then
		setActive(arg_18_0.detailBtn, true)
		setActive(arg_18_0.unlockBtn, false)
		setActive(arg_18_0.switchBtn, true)
	end

	return
end

function var_0_0.reUpdate(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0:setData(arg_19_1, arg_19_2)
	arg_19_0:updateSkillList()
	arg_19_0:updateButtons()

	return
end

return var_0_0

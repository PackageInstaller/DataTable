local var_0_0 = class("MetaSkillDetailBoxLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "MetaSkillDetailBoxUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initUITextTips()
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)
	arg_3_0:updateShipDetail()
	arg_3_0:updateSkillList()

	return
end

function var_0_0.willExit(arg_4_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_4_0._tf)

	return
end

function var_0_0.initUITextTips(arg_5_0)
	setText(arg_5_0._tf:Find("Window/top/bg/infomation/title"), i18n("battle_end_subtitle2"))
	setText(arg_5_0._tf:Find("Window/MetaSkillDetailBox/ExpDetail/ExpTipText"), i18n("meta_skill_dailyexp"))
	setText(arg_5_0._tf:Find("Window/MetaSkillDetailBox/TipText"), i18n("meta_skill_learn"))

	return
end

function var_0_0.initData(arg_6_0)
	arg_6_0.metaProxy = getProxy(MetaCharacterProxy)
	arg_6_0.metaShipID = arg_6_0.contextData.metaShipID

	return
end

function var_0_0.findUI(arg_7_0)
	arg_7_0.bg = arg_7_0._tf:Find("BG")
	arg_7_0.window = arg_7_0._tf:Find("Window")
	arg_7_0.closeBtn = arg_7_0.window:Find("top/btnBack")
	arg_7_0.panel = arg_7_0.window:Find("MetaSkillDetailBox")
	arg_7_0.skillTpl = arg_7_0.panel:Find("SkillTpl")
	arg_7_0.expDetailTF = arg_7_0.panel:Find("ExpDetail")
	arg_7_0.shipIcon = arg_7_0.expDetailTF:Find("IconTpl/Icon")
	arg_7_0.shipNameText = arg_7_0.expDetailTF:Find("NameMask/Name")
	arg_7_0.expProgressText = arg_7_0.expDetailTF:Find("ExpProgressText")
	arg_7_0.skillContainer = arg_7_0.panel:Find("ScrollView/Content")
	arg_7_0.skillUIItemList = UIItemList.New(arg_7_0.skillContainer, arg_7_0.skillTpl)

	return
end

function var_0_0.addListener(arg_8_0)
	onButton(arg_8_0, arg_8_0.bg, function()
		arg_8_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.closeBtn, function()
		arg_8_0:closeView()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateSkillTF(arg_11_0, arg_11_1, arg_11_2)
	local var_11_9000
	local var_11_0 = arg_11_1:Find("frame")
	local var_11_1 = arg_11_1:Find("check_mark")
	local var_11_2 = var_11_0:Find("skillInfo")
	local var_11_3 = var_11_0:Find("mask")
	local var_11_4 = var_11_0:Find("Slider")
	local var_11_5 = var_11_2:Find("ExpProgressText")
	local var_11_6 = var_11_0:Find("Tag/learing")
	local var_11_7 = var_11_0:Find("Tag/unlockable")
	local var_11_8 = getProxy(BayProxy)
	local var_11_9 = var_11_8.getShipById(var_11_9000, arg_11_0.metaShipID)
	local var_11_10 = var_11_9:getMetaSkillLevelBySkillID(arg_11_2)

	setImageSprite(var_11_2:Find("icon"), LoadSprite("skillicon/" .. var_11_8.icon))
	setText(var_11_2:Find("name_contain/name"), shortenString(getSkillName(getSkillConfig(arg_11_2).id), 8))
	setText(var_11_2:Find("name_contain/level_contain/Text"), var_11_10)

	local var_11_11 = arg_11_0.metaProxy:getMetaTacticsInfoByShipID(arg_11_0.metaShipID)
	local var_11_12 = arg_11_2 == var_11_11.curSkillID
	local var_11_13 = var_11_10 > 0
	local var_11_14 = var_11_9:isSkillLevelMax(arg_11_2)
	local var_11_15 = var_11_11:getSkillExp(arg_11_2)

	if var_11_10 < pg.skill_data_template[arg_11_2].max_level then
		if var_11_13 then
			local var_11_16 = MetaCharacterConst.getMetaSkillTacticsConfig(arg_11_2, var_11_10).need_exp

			setText(var_11_5, var_11_15 .. "/" .. var_11_16)
			setSlider(var_11_4, 0, var_11_16, var_11_15)
			setActive(var_11_5, true)
			setActive(var_11_4, true)
		else
			setActive(var_11_5, false)
			setActive(var_11_4, false)
		end
	else
		setText(var_11_5, var_11_15 .. "/Max")
		setSlider(var_11_4, 0, 1, 1)
		setActive(var_11_5, true)
		setActive(var_11_4, true)
	end

	setActive(var_11_1, var_11_12 and not var_11_14)
	setActive(var_11_6, var_11_12 and not var_11_14)
	setActive(var_11_7, not var_11_13)
	setActive(var_11_3, not var_11_13)
	onToggle(arg_11_0, arg_11_1, function(arg_12_0)
		if arg_12_0 then
			if not var_11_13 then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideYes = true,
					hideNo = true,
					type = MSGBOX_TYPE_META_SKILL_UNLOCK,
					metaShipVO = var_11_9,
					skillID = arg_11_2
				})
			elseif not var_11_12 and not var_11_14 then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("meta_switch_skill_box_title", getSkillName(arg_11_2)),
					onYes = function()
						pg.m02:sendNotification(GAME.TACTICS_META_SWITCH_SKILL, {
							shipID = arg_11_0.metaShipID,
							skillID = arg_11_2
						})

						return
					end
				})
			elseif var_11_14 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("meta_skill_maxtip2"))
			end
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateSkillList(arg_14_0)
	local var_14_0 = MetaCharacterConst.getTacticsSkillIDListByShipConfigID(getProxy(BayProxy):getShipById(arg_14_0.metaShipID).configId)

	arg_14_0.skillUIItemList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			arg_15_1 = arg_15_1 + 1

			arg_14_0:updateSkillTF(arg_15_2, var_14_0[arg_15_1])
		end

		return
	end)
	arg_14_0.skillUIItemList:align(#MetaCharacterConst.getTacticsSkillIDListByShipConfigID(getProxy(BayProxy):getShipById(arg_14_0.metaShipID).configId))

	return
end

function var_0_0.updateShipDetail(arg_16_0)
	local var_16_0 = getProxy(BayProxy):getShipById(arg_16_0.metaShipID)
	local var_16_1 = var_16_0:getPainting()

	setImageSprite(arg_16_0.shipIcon, LoadSprite("SquareIcon/" .. var_16_1, var_16_1))
	setScrollText(arg_16_0.shipNameText, var_16_0:getName())
	setText(arg_16_0.expProgressText, setColorStr(arg_16_0.metaProxy:getMetaTacticsInfoByShipID(arg_16_0.metaShipID).curDayExp, "#FFF152FF") .. "/" .. pg.gameset.meta_skill_exp_max.key_value)

	return
end

return var_0_0

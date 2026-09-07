local MetaSkillDetailBoxLayer = class("MetaSkillDetailBoxLayer", import("...base.BaseUI"))

function MetaSkillDetailBoxLayer:getUIName()
	return "MetaSkillDetailBoxUI"
end

function MetaSkillDetailBoxLayer:init()
	self:initUITextTips()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function MetaSkillDetailBoxLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:updateShipDetail()
	self:updateSkillList()

	return
end

function MetaSkillDetailBoxLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function MetaSkillDetailBoxLayer:initUITextTips()
	setText(self._tf:Find("Window/top/bg/infomation/title"), i18n("battle_end_subtitle2"))
	setText(self._tf:Find("Window/MetaSkillDetailBox/ExpDetail/ExpTipText"), i18n("meta_skill_dailyexp"))
	setText(self._tf:Find("Window/MetaSkillDetailBox/TipText"), i18n("meta_skill_learn"))

	return
end

function MetaSkillDetailBoxLayer:initData()
	self.metaProxy = getProxy(MetaCharacterProxy)
	self.metaShipID = self.contextData.metaShipID

	return
end

function MetaSkillDetailBoxLayer:findUI()
	self.bg = self._tf:Find("BG")
	self.window = self._tf:Find("Window")
	self.closeBtn = self.window:Find("top/btnBack")
	self.panel = self.window:Find("MetaSkillDetailBox")
	self.skillTpl = self.panel:Find("SkillTpl")
	self.expDetailTF = self.panel:Find("ExpDetail")
	self.shipIcon = self.expDetailTF:Find("IconTpl/Icon")
	self.shipNameText = self.expDetailTF:Find("NameMask/Name")
	self.expProgressText = self.expDetailTF:Find("ExpProgressText")
	self.skillContainer = self.panel:Find("ScrollView/Content")
	self.skillUIItemList = UIItemList.New(self.skillContainer, self.skillTpl)

	return
end

function MetaSkillDetailBoxLayer:addListener()
	onButton(self, self.bg, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:closeView()

		return
	end, SFX_PANEL)

	return
end

function MetaSkillDetailBoxLayer:updateSkillTF(arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1:Find("frame")
	local var_11_1 = arg_11_1:Find("check_mark")
	local var_11_2 = var_11_0:Find("skillInfo")
	local var_11_3 = var_11_0:Find("mask")
	local var_11_4 = var_11_0:Find("Slider")
	local var_11_5 = var_11_2:Find("ExpProgressText")
	local var_11_6 = var_11_0:Find("Tag/learing")
	local var_11_7 = var_11_0:Find("Tag/unlockable")
	local var_11_8 = getProxy(BayProxy)
	local var_11_9 = var_11_8:getShipById(self.metaShipID)
	local var_11_10 = var_11_9:getMetaSkillLevelBySkillID(arg_11_2)

	setImageSprite(var_11_2:Find("icon"), LoadSprite("skillicon/" .. var_11_8.icon))
	setText(var_11_2:Find("name_contain/name"), shortenString(getSkillName(getSkillConfig(arg_11_2).id), 8))
	setText(var_11_2:Find("name_contain/level_contain/Text"), var_11_10)

	local var_11_11 = self.metaProxy:getMetaTacticsInfoByShipID(self.metaShipID)
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
	onToggle(self, arg_11_1, function(arg_12_0)
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
							shipID = self.metaShipID,
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

function MetaSkillDetailBoxLayer:updateSkillList()
	local var_14_0 = MetaCharacterConst.getTacticsSkillIDListByShipConfigID(getProxy(BayProxy):getShipById(self.metaShipID).configId)

	self.skillUIItemList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			arg_15_1 = arg_15_1 + 1

			self:updateSkillTF(arg_15_2, var_14_0[arg_15_1])
		end

		return
	end)
	self.skillUIItemList:align(#var_14_0)

	return
end

function MetaSkillDetailBoxLayer:updateShipDetail()
	local var_16_0 = getProxy(BayProxy):getShipById(self.metaShipID)
	local var_16_1 = var_16_0:getPainting()

	setImageSprite(self.shipIcon, LoadSprite("SquareIcon/" .. var_16_1, var_16_1))
	setScrollText(self.shipNameText, var_16_0:getName())
	setText(self.expProgressText, setColorStr(self.metaProxy:getMetaTacticsInfoByShipID(self.metaShipID).curDayExp, "#FFF152FF") .. "/" .. pg.gameset.meta_skill_exp_max.key_value)

	return
end

return MetaSkillDetailBoxLayer

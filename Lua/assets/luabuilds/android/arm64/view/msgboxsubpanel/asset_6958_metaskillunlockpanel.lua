local MetaSkillUnlockPanel = class("MetaSkillUnlockPanel", import(".MsgboxSubPanel"))

function MetaSkillUnlockPanel:getUIName()
	return "MetaSkillUnlockBox"
end

function MetaSkillUnlockPanel:OnInit()
	self:findUI()
	self:initData()
	self:addListener()

	return
end

function MetaSkillUnlockPanel:UpdateView(arg_3_1)
	self:PreRefresh(arg_3_1)
	self:updateContent(arg_3_1)

	rtf(self.viewParent._window).sizeDelta = Vector2.New(1000, 638)

	self:PostRefresh(arg_3_1)

	return
end

function MetaSkillUnlockPanel:findUI()
	self.tipText = self._tf:Find("Tip")
	self.materialTpl = self._tf:Find("Material")
	self.materialContainer = self._tf:Find("MaterialContainer")
	self.uiItemList = UIItemList.New(self.materialContainer, self.materialTpl)
	self.cancelBtn = self._tf:Find("Buttons/CancelBtn")
	self.confirmBtn = self._tf:Find("Buttons/ConfirmBtn")

	setText(self.cancelBtn:Find("Text"), i18n("word_cancel"))
	setText(self.confirmBtn:Find("Text"), i18n("word_ok"))

	return
end

function MetaSkillUnlockPanel:initData()
	self.curMetaShipID = nil
	self.curUnlockSkillID = nil
	self.curUnlockMaterialID = nil
	self.curUnlockMaterialNeedCount = nil

	return
end

function MetaSkillUnlockPanel:addListener()
	onButton(self, self.confirmBtn, function()
		if not self.curUnlockMaterialID then
			pg.TipsMgr.GetInstance():ShowTips(i18n("meta_unlock_skill_select"))

			return
		elseif getProxy(BagProxy):getItemCountById(self.curUnlockMaterialID) < self.curUnlockMaterialNeedCount then
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_materal_no_enough"))
		else
			local var_7_0 = 0
			local var_7_1 = 0

			for iter_7_0, iter_7_1 in ipairs(MetaCharacterConst.getMetaSkillTacticsConfig(self.curUnlockSkillID, 1).skill_unlock) do
				if self.curUnlockMaterialID == iter_7_1[2] then
					var_7_0 = iter_7_0
					var_7_1 = iter_7_1[3]

					break
				end
			end

			pg.m02:sendNotification(GAME.TACTICS_META_UNLOCK_SKILL, {
				shipID = self.curMetaShipID,
				skillID = self.curUnlockSkillID,
				materialIndex = var_7_0,
				materialInfo = {
					id = self.curUnlockMaterialID,
					count = var_7_1
				}
			})
		end

		pg.MsgboxMgr.GetInstance():hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		pg.MsgboxMgr.GetInstance():hide()

		return
	end, SFX_CANCEL)

	return
end

function MetaSkillUnlockPanel:updateContent(arg_9_1)
	self.curMetaShipID = arg_9_1.metaShipVO.id
	self.curUnlockSkillID = arg_9_1.skillID

	setText(self.tipText, i18n("meta_unlock_skill_tip", ShipGroup.getDefaultShipNameByGroupID(arg_9_1.metaShipVO:getMetaCharacter().id), (getSkillName(arg_9_1.skillID))))

	local var_9_0 = MetaCharacterConst.getMetaSkillTacticsConfig(arg_9_1.skillID, 1)
	local var_9_2 = {
		var_9_0.skill_unlock[1]
	}

	self.uiItemList:make(function(arg_10_0, arg_10_1, arg_10_2)
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

			setText(var_10_1, (var_10_4 < var_10_0[3] and setColorStr(var_10_4, COLOR_RED) or setColorStr(var_10_4, COLOR_GREEN)) .. "/" .. var_10_0[3])

			self.curUnlockMaterialID = var_10_2
			self.curUnlockMaterialNeedCount = var_10_3
		end

		return
	end)
	self.uiItemList:align(#var_9_2)

	return
end

return MetaSkillUnlockPanel

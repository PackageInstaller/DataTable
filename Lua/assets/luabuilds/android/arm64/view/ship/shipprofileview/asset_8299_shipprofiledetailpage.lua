local ShipProfileDetailPage = class("ShipProfileDetailPage", import("...base.BaseSubView"))

function ShipProfileDetailPage:getUIName()
	return "ShipProfileDetailPage"
end

function ShipProfileDetailPage:OnLoaded()
	self.detailRightBlurRect = self._tf:Find("bg")
	self.propertyTF = self._tf:Find("bg/property_panel/frame")
	self.skillRect = self._tf:Find("bg/skill_panel/frame/skills_rect")
	self.skillPanel = self.skillRect:Find("skills")
	self.skillTpl = self.skillRect:Find("skilltpl")
	self.skillArrLeft = self._tf:Find("bg/skill_panel/frame/arrow1")
	self.skillArrRight = self._tf:Find("bg/skill_panel/frame/arrow2")

	return
end

function ShipProfileDetailPage:OnInit()
	return
end

function ShipProfileDetailPage:EnterAnim(arg_4_1, arg_4_2)
	LeanTween.moveX(rtf(self._tf), 0, arg_4_1):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(function()
		if arg_4_2 then
			arg_4_2()
		end

		return
	end))

	return
end

function ShipProfileDetailPage:ExistAnim(arg_6_1, arg_6_2)
	LeanTween.moveX(rtf(self._tf), 1000, arg_6_1):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(function()
		if arg_6_2 then
			arg_6_2()
		end

		self:Hide()

		return
	end))

	return
end

function ShipProfileDetailPage:Update(arg_8_1, arg_8_2, arg_8_3)
	self:Show()

	self.shipGroup = arg_8_1
	self.showTrans = arg_8_2

	self:InitSkills()
	self:InitProperty()

	if arg_8_3 then
		arg_8_3()
	end

	return
end

function ShipProfileDetailPage:InitProperty()
	self.propertyPanel = PropertyPanel.New(self.propertyTF)

	self.propertyPanel:initProperty(self.shipGroup.shipConfig.id)

	if self.showTrans and self.shipGroup.trans then
		self.propertyPanel:initRadar(self.shipGroup.groupConfig.trans_radar_chart)
	end

	return
end

function ShipProfileDetailPage:InitSkills()
	local var_10_1 = Clone(pg.ship_data_template[self.shipGroup:getShipConfigId(self.showTrans)].buff_list_display)
	local var_10_2

	if not self.showTrans then
		_.each(self.shipGroup.groupConfig.trans_skill, function(arg_11_0)
			table.removebyvalue(var_10_1, arg_11_0)

			return
		end)

		var_10_2 = #var_10_1 < 3 and 3 or #var_10_1
	end

	for iter_10_0 = self.skillPanel.childCount + 1, var_10_2 do
		cloneTplTo(self.skillTpl, self.skillPanel)
	end

	for iter_10_1 = 1, self.skillPanel.childCount do
		local var_10_3 = self.skillPanel:GetChild(iter_10_1 - 1)

		if iter_10_1 <= #var_10_1 then
			self:UpdateSkill(var_10_3, var_10_1[iter_10_1])
		else
			setActive(var_10_3:Find("icon"), false)
			setActive(var_10_3:Find("add"), true)
		end

		setActive(var_10_3, iter_10_1 <= var_10_2)
	end

	setActive(self.skillArrLeft, #var_10_1 > 3)
	setActive(self.skillArrRight, #var_10_1 > 3)

	if #var_10_1 > 3 then
		onScroll(self, self.skillRect, function(arg_12_0)
			setActive(self.skillArrLeft, arg_12_0.x > 0.01)
			setActive(self.skillArrRight, arg_12_0.x < 0.99)

			return
		end)
	else
		GetComponent(self.skillRect, typeof(ScrollRect)).onValueChanged:RemoveAllListeners()
	end

	setAnchoredPosition(self.skillPanel, {
		x = 0
	})

	return
end

function ShipProfileDetailPage:UpdateSkill(arg_13_1, arg_13_2)
	local var_13_0

	if self.shipGroup:isBluePrintGroup() then
		for iter_13_0, iter_13_1 in ipairs(self.shipGroup:getBluePrintChangeSkillList()) do
			if iter_13_1[1] == arg_13_2 then
				arg_13_2 = iter_13_1[2]

				break
			end
		end

		var_13_0 = getSkillConfig(arg_13_2)
	end

	LoadImageSpriteAsync("skillicon/" .. var_13_0.icon, (findTF(arg_13_1, "icon")))
	setActive(arg_13_1:Find("icon"), true)
	setActive(arg_13_1:Find("add"), false)
	onButton(self, arg_13_1, function()
		self:emit(ShipProfileScene.SHOW_SKILL_INFO, var_13_0.id, {
			id = var_13_0.id,
			level = pg.skill_data_template[var_13_0.id].max_level
		})

		return
	end, SFX_PANEL)

	return
end

function ShipProfileDetailPage:OnDestroy()
	return
end

return ShipProfileDetailPage

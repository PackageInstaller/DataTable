local NewShipDocumentView = class("NewShipDocumentView", import("..base.BaseSubView"))

function NewShipDocumentView:getUIName()
	return "NewShipDocumentView"
end

function NewShipDocumentView:OnInit()
	self:InitUI()
	self:AddListener()
	setActive(self._tf, true)
	LeanTween.move(rtf(self._tf), Vector3(-30, 0, 0), 0.3)

	return
end

function NewShipDocumentView:OnDestroy()
	self._shipVO = nil
	self.confirmFunc = nil

	return
end

function NewShipDocumentView:InitUI()
	self.skillContainer = self._tf:Find("bg/skill_panel/frame/skill_list/viewport")
	self.skillTpl = self:getTpl("bg/skill_panel/frame/skilltpl", self._tf)
	self.emptyTpl = self:getTpl("bg/skill_panel/frame/emptytpl", self._tf)
	self.addTpl = self:getTpl("bg/skill_panel/frame/addtpl", self._tf)

	return
end

function NewShipDocumentView:AddListener()
	onButton(self, self._tf:Find("qr_btn"), function()
		self.confirmFunc()

		return
	end, SFX_CONFIRM)

	return
end

function NewShipDocumentView:initSkills()
	local var_7_0 = 1

	for iter_7_0, iter_7_1 in ipairs(pg.ship_data_template[self._shipVO:getMaxConfigId()].buff_list_display) do
		local var_7_1 = getSkillConfig(iter_7_1)
		local var_7_2 = self._shipVO.skills
		local var_7_3

		if self._shipVO.skills[iter_7_1] then
			var_7_3 = cloneTplTo(self.skillTpl, self.skillContainer)

			onButton(self, var_7_3, function()
				self:emit(NewShipMediator.ON_SKILLINFO, var_7_1.id, var_7_2[iter_7_1])

				return
			end, SFX_PANEL)
		else
			var_7_3 = cloneTplTo(self.emptyTpl, self.skillContainer)

			setActive(var_7_3:Find("mask"), true)
			onButton(self, var_7_3, function()
				self:emit(NewShipMediator.ON_SKILLINFO, var_7_1.id)

				return
			end, SFX_PANEL)
		end

		var_7_0 = var_7_0 + 1

		LoadImageSpriteAsync("skillicon/" .. var_7_1.icon, findTF(var_7_3, "icon"))
	end

	for iter_7_2 = var_7_0, 3 do
		cloneTplTo(self.addTpl, self.skillContainer)
	end

	return
end

function NewShipDocumentView:UpdatePropertyPanel()
	self.propertyPanel = PropertyPanel.New(self._tf:Find("bg/property_panel/frame"))

	self.propertyPanel:initProperty(self._shipVO.configId)

	return
end

function NewShipDocumentView:getTpl(arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2:Find(arg_11_1)

	var_11_0:SetParent(self._tf, false)
	SetActive(var_11_0, false)

	return var_11_0
end

function NewShipDocumentView:SetParams(arg_12_1, arg_12_2)
	self._shipVO = arg_12_1
	self.confirmFunc = arg_12_2

	return
end

function NewShipDocumentView:RefreshUI()
	self:initSkills()
	self:UpdatePropertyPanel()

	return
end

return NewShipDocumentView

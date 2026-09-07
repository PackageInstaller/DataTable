local AssignedShipForGreetingScene = class("AssignedShipForGreetingScene", import(".BaseAssignedShipScene"))
local var_0_1 = {
	select_panel_7 = {
		Vector2(80, -110),
		Vector2(80, -330),
		Vector2(80, -550),
		Vector2(80, -770),
		Vector2(240, -160),
		Vector2(240, -380),
		Vector2(240, -600)
	}
}

function AssignedShipForGreetingScene:getUIName()
	return "AssignedShipUI6"
end

function AssignedShipForGreetingScene:init()
	local var_2_0 = self._tf:Find("layer")

	self.backBtn = var_2_0:Find("top/back")
	self.confirmBtn = var_2_0:Find("confirm")
	self.print = var_2_0:Find("print")
	self.rtName = var_2_0:Find("name")
	self.rtTitle = var_2_0:Find("top/title")
	self.selectTarget = nil
	self.count = 1
	self.spList = {}
	self.afterAnima = {}

	return
end

function AssignedShipForGreetingScene:didEnter()
	onButton(self, self.backBtn, function()
		self:emit(AssignedShipForGreetingScene.ON_BACK)

		return
	end, SOUND_BACK)
	onButton(self, self.confirmBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n(self.strTip, pg.ship_data_statistics[self.selectedShipNumber].name),
			onYes = function()
				self:emit(AssignedShipMediator.ON_USE_ITEM, self.itemVO.id, self.count, {
					self.idList[self.selectTarget]
				})

				return
			end
		})

		return
	end, SFX_PANEL)
	setActive(self.rtTitle, self.title)

	if self.title then
		GetImageSpriteFromAtlasAsync("extra_page/" .. self.style .. "/" .. self.title, "", self.rtTitle, true)
	end

	local var_3_0 = "select_panel_" .. #self.shipIdList

	setActive(self._tf:Find("layer/" .. "select_panel_" .. #self.shipIdList), true)

	self.selectPanel = self._tf:Find("layer/" .. var_3_0 .. "/layout")
	self.itemList = UIItemList.New(self.selectPanel, self.selectPanel:Find("item"))

	self.itemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1

		if var_0_1[var_3_0] then
			setAnchoredPosition(arg_7_2, var_0_1[var_3_0][arg_7_1])
		end

		local var_7_0 = self.shipIdList[arg_7_1]

		if arg_7_0 == UIItemList.EventUpdate then
			GetImageSpriteFromAtlasAsync("extra_page/" .. self.style .. "/i_" .. var_7_0, "", arg_7_2:Find("unselected/icon"))
			GetImageSpriteFromAtlasAsync("extra_page/" .. self.style .. "/i_" .. var_7_0, "", arg_7_2:Find("selected/icon"))

			if arg_7_1 == 5 then
				arg_7_2:Find("unselected/icon"):GetComponent("Image"):SetNativeSize()

				arg_7_2:Find("unselected/icon"):GetComponent("Image").rectTransform.sizeDelta = Vector2(96, 228)
				arg_7_2:Find("unselected/icon"):GetComponent("Image").rectTransform.anchoredPosition = Vector2(0, -20)
			end

			onToggle(self, arg_7_2, function(arg_8_0)
				if arg_8_0 and self.selectTarget ~= arg_7_1 then
					if arg_7_1 == 5 then
						arg_7_2:Find("unselected/icon"):GetComponent("Image"):SetNativeSize()

						arg_7_2:Find("unselected/icon"):GetComponent("Image").rectTransform.sizeDelta = Vector2(96, 228)
						arg_7_2:Find("unselected/icon"):GetComponent("Image").rectTransform.anchoredPosition = Vector2(0, -20)
					end

					LeanTween.cancel(self.print)

					if self.rtName then
						LeanTween.cancel(self.rtName)
					end

					self:setSelectTarget(arg_7_1)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.itemList:align(#self.idList)
	triggerToggle(self.selectPanel:GetChild(0), true)

	return
end

return AssignedShipForGreetingScene

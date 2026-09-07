local IslandTechCentreCard = class("IslandTechCentreCard")

function IslandTechCentreCard:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.lvTF = self._tf:Find("level/lv")
	self.lineTF = self._tf:Find("line")
	self.lockTF = self._tf:Find("lock")

	setText(self.lockTF:Find("Image/tip/Text"), i18n("island_tech_lock"))

	local var_1_0 = self._tf:Find("items_view/content")

	self.uiList = UIItemList.New(var_1_0, var_1_0:Find("tpl"))

	self.uiList:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_2_1, arg_2_2)
		end

		return
	end)

	return
end

function IslandTechCentreCard:UpdateItem(arg_3_1, arg_3_2)
	local var_3_0 = self.ids[arg_3_1 + 1]
	local var_3_1 = getProxy(IslandProxy):GetIsland():GetTechnologyAgency():GetTechnology(self.ids[arg_3_1 + 1])

	setText(arg_3_2:Find("corner/Text"), var_3_1:getConfig("tech_level"))
	LoadImageSpriteAsync("island/IslandTechnology/" .. var_3_1:getConfig("tech_icon"), arg_3_2:Find("icon"), true)
	setActive(arg_3_2:Find("line"), arg_3_1 + 1 ~= #self.ids)

	local var_3_2 = var_3_1:GetStatus()

	setActive(arg_3_2:Find("receive"), var_3_2 == IslandTechnology.STATUS.RECEIVE)
	setActive(arg_3_2:Find("studying"), var_3_2 == IslandTechnology.STATUS.STUDYING)
	setImageAlpha(arg_3_2:Find("icon"), (var_3_2 == IslandTechnology.STATUS.STUDYING or var_3_2 == IslandTechnology.STATUS.LOCK or var_3_2 == IslandTechnology.STATUS.NORMAL and var_3_1:GetFinishedCnt() == 0) and 0.5 or 1)

	local var_3_3 = arg_3_2:GetComponent(typeof(Animation))

	if var_3_2 == IslandTechnology.STATUS.NORMAL and var_3_1:GetFinishedCnt() == 0 then
		var_3_3:Play("anim_Island_technology_tplicon_in")
	elseif var_3_2 == IslandTechnology.STATUS.STUDYING then
		var_3_3:Play("anim_Island_technology_tplstudy_in")
	elseif var_3_2 == IslandTechnology.STATUS.RECEIVE then
		var_3_3:Play("anim_Island_technology_tplreceive_in")
	else
		var_3_3:Stop()
	end

	onButton(self, arg_3_2, function()
		existCall(self.onItemClick, var_3_0)

		return
	end, SFX_PANEL)

	return
end

function IslandTechCentreCard:Update(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	self.ids = arg_5_2
	self.onItemClick = arg_5_5

	setText(self.lvTF, "LV." .. arg_5_1)
	setActive(self.lineTF, not arg_5_3)
	setActive(self.lockTF, arg_5_4)
	self.uiList:align(#self.ids)

	return
end

function IslandTechCentreCard:Dispose()
	pg.DelegateInfo.Dispose(self)

	return
end

return IslandTechCentreCard

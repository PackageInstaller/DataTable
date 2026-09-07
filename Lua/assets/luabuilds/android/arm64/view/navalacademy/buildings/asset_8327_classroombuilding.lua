local ClassRoomBuilding = class("ClassRoomBuilding", import(".NavalAcademyUpgradableBuilding"))

function ClassRoomBuilding:Ctor(arg_1_1)
	ClassRoomBuilding.super.Ctor(self, arg_1_1)

	self.bubbleImg = self.bubble:Find("icon"):GetComponent(typeof(Image))
	self.floatImg = self.floatTF:GetComponent(typeof(Image))
	self.isUpdateIcon = false

	return
end

function ClassRoomBuilding:UpdateBubble()
	local var_2_0 = self:GetResField()
	local var_2_1 = var_2_0:GetGenResCnt() > 0

	setActive(self.bubble, var_2_1)

	if var_2_1 then
		self:FloatAni()
	end

	if not self.isUpdateIcon then
		local var_2_2 = Item.getConfigData((var_2_0:GetResourceType())).icon

		self.bubbleImg.sprite = LoadSprite(var_2_2)
		self.floatImg.sprite = LoadSprite(var_2_2)

		onButton(self, self.bubble, function()
			local var_3_0 = self:GetResField()

			self:emit(NavalAcademyMediator.ON_GET_CLASS_RES)

			return
		end, SFX_PANEL)

		self.isUpdateIcon = true
	end

	return
end

function ClassRoomBuilding:GetGameObjectName()
	return "classRoom"
end

function ClassRoomBuilding:GetTitle()
	return i18n("school_title_dajiangtang")
end

function ClassRoomBuilding:OnClick()
	self:emit(NavalAcademyMediator.ON_OPEN_CLASSROOM)

	return
end

function ClassRoomBuilding:OnInit()
	ClassRoomBuilding.super.OnInit(self)

	local var_7_0 = self:IsUnlock()

	setActive(self._tf:Find("name/level"), var_7_0)
	setActive(self._tf:Find("name/lock"), not var_7_0)

	return
end

function ClassRoomBuilding:IsUnlock()
	return pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "ClassMediator")
end

function ClassRoomBuilding:GetResField()
	return self.parent.classResField
end

return ClassRoomBuilding

local NavalAcademyBuilding = class("NavalAcademyBuilding")

function NavalAcademyBuilding:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self.parent = arg_1_1
	self._tf = arg_1_1._tf:Find("academyMap/map/" .. self:GetGameObjectName())
	self.nameTxt = findTF(self._tf, "name/Text"):GetComponent(typeof(Text))
	self.tip = findTF(self._tf, "tip")

	return
end

function NavalAcademyBuilding:Init()
	onButton(self, self._tf, function()
		self:OnClick()

		return
	end, SFX_PANEL)

	self.nameTxt.text = self:GetTitle()

	self:RefreshTip()
	self:OnInit()

	return
end

function NavalAcademyBuilding:RefreshTip()
	setActive(self.tip, self:IsTip())

	return
end

function NavalAcademyBuilding:OnInit()
	return
end

function NavalAcademyBuilding:OnClick()
	return
end

function NavalAcademyBuilding:IsTip()
	return false
end

function NavalAcademyBuilding:GetTitle()
	return ""
end

function NavalAcademyBuilding:GetGameObjectName()
	assert(false)

	return
end

function NavalAcademyBuilding:emit(...)
	self.parent:emit(...)

	return
end

function NavalAcademyBuilding:Dispose()
	pg.DelegateInfo.Dispose(self)

	return
end

return NavalAcademyBuilding

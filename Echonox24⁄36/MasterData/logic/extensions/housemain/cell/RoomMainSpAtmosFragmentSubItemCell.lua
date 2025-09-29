-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/cell/RoomMainSpAtmosFragmentSubItemCell.lua

module("logic.extensions.housemain.cell.RoomMainSpAtmosFragmentSubItemCell", package.seeall)

local M = class("RoomMainSpAtmosFragmentSubItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "facilityIcon")
	self._backUpSprite = self._imgIcon.sprite
	self._txtName = goutil.findChildTextComponent(self.mainGO, "facilityIcon/txtFacilityName")
	self._txtNum = goutil.findChildTextComponent(self.mainGO, "txtNum")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "click").gameObject)
end

function M:destroyUI()
	self.mainGO = nil
	self._backUpSprite = nil
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._clickSelf, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	self._atmosTyp = nil
	self._zoneMo = nil
end

function M:_clickSelf()
	if self._zoneMo then
		print(string.format("[%d]点击", self._zoneMo:getId()))
	else
		print("点击 无zoneMo")
	end
end

function M:setData(atmosTyp, zoneMo)
	if zoneMo == nil then
		printError(string.format("atmosTyp[%d],zoneMo = nil", atmosTyp))

		return
	end

	self._atmosTyp = atmosTyp
	self._zoneMo = zoneMo

	local atmosVal = zoneMo:getAtmosphereSpecial()

	self:_setIcon(zoneMo)
	self:_setName(zoneMo)
	self:_setNum(atmosVal)
end

function M:_setIcon(zoneMo)
	local cfgRoomId = zoneMo:getId() or 0
	local succeed = HouseMainUtil.changeAtmosphereRoomIcon(self._imgIcon, cfgRoomId)

	if not succeed then
		self._imgIcon.sprite = self._backUpSprite
	end
end

function M:_setName(zoneMo)
	local cfgRoomId = zoneMo:getId() or 0
	local name = HouseMainUtil.getRoomName(cfgRoomId) or lang(HouseMainEnum.RoomTypName[HouseEnum.RoomType.Living])

	self._txtName.text = name
end

function M:_setNum(num)
	self._txtNum.text = string.format("+%d", num)
end

return M

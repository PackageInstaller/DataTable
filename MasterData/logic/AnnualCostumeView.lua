-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/anniversary/AnnualCostumeView.lua

module("logic.extensions.bonus.view.anniversary.AnnualCostumeView", package.seeall)

local AnnualCostumeView = class("AnnualCostumeView", SummarySubTabView)

function AnnualCostumeView:ctor()
	AnnualCostumeView.super.ctor(self)
end

function AnnualCostumeView:buildUI()
	AnnualCostumeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._rtRole = self:getGo("rtRole"):GetComponent(goutil.Type_RectTransform)

	goutil.setActive(self._rtRole.gameObject, true)

	self._photoEff = AvatarPhotoShow.Get(self._rtRole.gameObject)
	self.tableview = self:getGo("right/tableview")
	self.cell = self:getGo("right/tablecell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function AnnualCostumeView:buildBtnJump()
	return
end

function AnnualCostumeView:bindEvents()
	AnnualCostumeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function AnnualCostumeView:unbindEvents()
	AnnualCostumeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function AnnualCostumeView:onEnter()
	AnnualCostumeView.super.onEnter(self)
	self:_initRenderTexture()
	self:_loadRole()
	self:_initCostumeList()
end

function AnnualCostumeView:onExit()
	AnnualCostumeView.super.onExit(self)
	self:_clearRole()
	self.scrollList:dispose()
	self:_releaseRenderTexture()

	if self._roleModel then
		RoleObjectPool.instance:removeRole(self._roleModel)
	end
end

function AnnualCostumeView:_onClickClose()
	self:close()
end

function AnnualCostumeView:_updateCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local icon = goutil.findChild(cell, "icon")
	local btnGo = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGo")

	GameUtil.addClickHandler(btnGo, GameUtil.handler(self._onJump, self, data))

	txtName.text = data.params

	local clothesList = string.split(data.background, "#")
	local clothesName = ""

	clothesName = clothesList and #clothesList == 2 and (RoleModel.instance:getGender() == GameEnum.Gender.Female and clothesList[1] or clothesList[2]) or data.background

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/%s.png", clothesName))
end

function AnnualCostumeView:clearCell(cell)
	local icon = goutil.findChild(cell, "icon")
	local btnGo = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGo")

	MaterialMgr.clearIcon(icon)
	btnGo:RemoveClickListener()
end

function AnnualCostumeView:_loadRole()
	self._avatar = self._avatar or AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	local suitId_female = checknumber(XiaonuoBirthConfig.instance:getCommonValue("COSTUME_ID_FEMALE"))
	local suitId_male = checknumber(XiaonuoBirthConfig.instance:getCommonValue("COSTUME_ID_MALE"))
	local suitId = RoleModel.instance:getGender() == GameEnum.Gender.Female and suitId_female or suitId_male
	local cfg = DressConfig.instance:getSuitCfgById(suitId)
	local avatarMo = DressModel.instance:getAvatarMoByGrCosAndMount(RoleModel.instance:getGender(), cfg.include, 0)

	self._avatar:updateByMo(avatarMo)
	self._photoEff:addShowAvatarEffect(self._avatar, nil, function(target)
		target:setRTAdjust(1, 1, 1, 0.1)
	end)
end

function AnnualCostumeView:_clearRole()
	if self._avatar then
		AvatarsMgrNew.instance:removeAvatar(self._avatar)

		self._avatar = nil
	end
end

function AnnualCostumeView:_initRenderTexture()
	self._photoEff:setRawWidthAndHeight(2048, 2048)
	self._photoEff:setCameraPosition(0, 1, -10)
	self._photoEff:setCamSize(1.5)
	self._photoEff:setRawImgNativeSize(false)
end

function AnnualCostumeView:_releaseRenderTexture()
	self._photoEff:clear()
end

function AnnualCostumeView:_initCostumeList()
	self.scrollList:reloadData(self._cfgs)
end

return AnnualCostumeView

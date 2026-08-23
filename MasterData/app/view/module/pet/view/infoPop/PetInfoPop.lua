local var_0_0 = g.core.const.ConstMgr.SpineConst
local var_0_1 = g.core.model.User.petsData
local PetInfoPop = class("PetInfoPop", require("app.fairyGUI.pet.UI_PetInfoPop"), function()
	return fgui.GComponent:create({
		resName = "PetInfoPop",
		pkgPath = "ui/pet/pet",
		isFullScreen = true,
		pkgName = "pet"
	}, ...)
end)

function PetInfoPop:ctor(arg_2_1)
	if arg_2_1.petAdvId then
		self._petStruct = var_0_1:getPetByAdvanceId(arg_2_1.petAdvId)
	elseif arg_2_1.petId then
		self._petStruct = var_0_1:getPetBySid(arg_2_1.petId)
	elseif arg_2_1.petStruct then
		self._petStruct = arg_2_1.petStruct
		self._matchInfos = arg_2_1.matchInfos
	end

	self._isOthers = arg_2_1.isOthers
	self._domainComp = nil

	self:showAtCenter()
	self:_updateView()
	self:addClickListener(handler(self, self._hideDomainComp))
end

function PetInfoPop:_updateView()
	if not self._petStruct then
		return
	end

	local var_3_0 = self._petStruct
	local var_3_1 = self._petStruct:getCfg()
	local var_3_2 = fgui.UIPackage:createObject("pet", "PetInfoPopNameComp")

	var_3_2:setPet(self._petStruct)
	var_3_2:setIsOthers(self._isOthers)

	local var_3_3 = fgui.UIPackage:createObject("pet", "PetInfoPicComp")

	var_3_3:updatePic({
		useMiddle = true,
		advId = var_3_1.advance_id,
		resId = var_3_1.resource
	})
	var_3_3:setAlphaRect(var_0_0.MASK_TYPE.HORIZON, cc.rect(-300, 0, 500, 0), 200)

	local var_3_4 = fgui.UIPackage:createObject("pet", "PetInfoKnightComp")

	var_3_4:updateComp({
		quality = var_3_0:getQuality(),
		knightId = var_3_0:getLinkKnightAdvId()
	})

	local var_3_5 = var_3_0:getQuality()
	local var_3_6

	if var_3_5 >= g.core.const.ConstMgr.QUALITY_TYPE.UR then
		var_3_6 = fgui.UIPackage:createObject("base_new", "UniteTokenDomainButton")

		var_3_6:addClickListener(handler(self, self._onClickDomainButton))
		var_3_6:setIcon("ui://base_new/pic_lingyu1_yuanzhishou")

		self._domainComp = fgui.UIPackage:createObject("base_new", "UniteTokenDomainHelpComp")

		var_3_6:addChild(self._domainComp)
		self._domainComp:setPosition(cc.p(0, var_3_6:getSize().height))
		self._domainComp:setVisible(false)
		self._domainComp:updateHelpId(6000002, 1)
	end

	self.m_infoPopBase:setPopView({
		quality = var_3_5,
		tabParam = {
			{
				package = "pet",
				compName = "PetInfoPopInfoComp",
				title = g.core.lang:get(201097)
			},
			{
				package = "pet",
				compName = "PetInfoPopTalentComp",
				title = g.core.lang:get(201019)
			}
		},
		commonParam = var_3_0,
		itemComp = var_3_3,
		nameComp = var_3_2,
		leftComp = var_3_4,
		iconComp = var_3_6
	})
end

function PetInfoPop:_onClickDomainButton()
	if self._domainComp then
		self._domainComp:setVisible(not self._domainComp:isVisible())
	end
end

function PetInfoPop:_hideDomainComp()
	if self._domainComp then
		self._domainComp:setVisible(false)
	end
end

return PetInfoPop

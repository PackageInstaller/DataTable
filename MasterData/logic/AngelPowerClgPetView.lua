-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelpowerclg/view/AngelPowerClgPetView.lua

module("logic.extensions.angelpowerclg.view.AngelPowerClgPetView", package.seeall)

local AngelPowerClgPetView = class("AngelPowerClgPetView", ViewComponent)
local textColorInfo = {
	[GameEnum.RaceType.Cao] = {
		gradientUp = "88de3c",
		outline = "4e792dFF",
		gradientDown = "f8fed4"
	},
	[GameEnum.RaceType.Shui] = {
		gradientUp = "71a2ff",
		outline = "346bd7FF",
		gradientDown = "e5ebf9"
	},
	[GameEnum.RaceType.Huo] = {
		gradientUp = "fa8b8b",
		outline = "ea6666FF",
		gradientDown = "fff7f7"
	},
	[GameEnum.RaceType.Guang] = {
		gradientUp = "ffb95e",
		outline = "b06300FF",
		gradientDown = "fff1df"
	},
	[GameEnum.RaceType.An] = {
		gradientUp = "B486FDFF",
		outline = "783FD2FF",
		gradientDown = "FFFFFF"
	},
	[GameEnum.RaceType.Kong] = {
		gradientUp = "BDBDBD",
		outline = "9C8080FF",
		gradientDown = "FFFFFF"
	},
	[GameEnum.RaceType.Chuang] = {
		gradientUp = "81F5FDFF",
		outline = "4CCBD4FF",
		gradientDown = "FFFFFF"
	}
}

function AngelPowerClgPetView:ctor()
	AngelPowerClgPetView.super.ctor(self)
end

function AngelPowerClgPetView:unbindEvents()
	AngelPowerClgPetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AngelPowerClgPetView:bindEvents()
	AngelPowerClgPetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AngelPowerClgPetView:buildUI()
	AngelPowerClgPetView.super.buildUI(self)

	self._tableView = self:getGo("tableView")
	self._tableCell = self:getGo("tableCell")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tablePetcell = self:getGo("tablePetcell")
	self._btnClose = self:getGo("btnClose")
	self._txtTips = self:getTxt("txtTips")
end

function AngelPowerClgPetView:destroyUI()
	AngelPowerClgPetView.super.destroyUI(self)
	self._tableList:dispose()
end

function AngelPowerClgPetView:onExit()
	AngelPowerClgPetView.super.onExit(self)
	self._tableList:dispose()
end

function AngelPowerClgPetView:onEnter()
	AngelPowerClgPetView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]

	local stageCfg = AngelPowerClgConfig.instance:getStageCfg(self._activityId, self._stageId)
	local cfgs = AngelPowerClgConfig.instance:getTransferPetCfg(stageCfg.transferPetPlanId)

	self._petScrollListDic = {}

	self._tableList:reloadData(cfgs)

	self._txtTips.text = stageCfg.buffDesc
end

function AngelPowerClgPetView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtRaceType = goutil.findChildTextComponent(go, "txtRaceType")
	local gradientRaceType = goutil.findChildComponent(go, "txtRaceType", ComponentType.UIGradient)
	local outlineRaceType = goutil.findChildComponent(go, "txtRaceType", ComponentType.OutlineEx)
	local imgChangeRaceType = goutil.findChildComponent(go, "imgRaceType", "UIImageSpriteChange")
	local txtMask = goutil.findChildTextComponent(go, "txtMask")
	local gradientMask = goutil.findChildComponent(go, "txtMask", ComponentType.UIGradient)
	local outlineMask = goutil.findChildComponent(go, "txtMask", ComponentType.OutlineEx)
	local petScrollerview = goutil.findChild(go, "tableview")

	txtRaceType.text = ConstString.RaceIdToTxt[data.transferAttrId]

	imgChangeRaceType:SetState(data.transferAttrId - 1)

	txtMask.text = data.maskName

	local txtinfo = textColorInfo[data.transferAttrId]

	if txtinfo then
		local upColorInfo = GameUtil.getColorByHexColor(txtinfo.gradientUp, true)
		local downColorInfo = GameUtil.getColorByHexColor(txtinfo.gradientDown, true)
		local color1 = UnityEngine.Color32.New(upColorInfo.r, upColorInfo.g, upColorInfo.b, upColorInfo.a)
		local color2 = UnityEngine.Color32.New(downColorInfo.r, downColorInfo.g, downColorInfo.b, downColorInfo.a)

		gradientRaceType:SetColor(color1, color2)
		gradientMask:SetColor(color1, color2)

		local outlineColor = GameUtil.getColorByHexColor(txtinfo.outline)

		outlineRaceType.OutlineWidth = 1

		outlineRaceType:SetColorRGBA(outlineColor.r, outlineColor.g, outlineColor.b, outlineColor.a)

		outlineMask.OutlineWidth = 1

		outlineMask:SetColorRGBA(outlineColor.r, outlineColor.g, outlineColor.b, outlineColor.a)
	end

	if petScrollerview and self._tablePetcell then
		if not self._petScrollListDic[go] then
			local petScrollList = ScrollerList.create(petScrollerview, self._tablePetcell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

			self._petScrollListDic[go] = petScrollList

			petScrollList:reloadData(data.raceId)
			petScrollList:dragNotifyParent()
		end
	end
end

function AngelPowerClgPetView:_clearCell(cell)
	local go = cell.gameObject
	local petScrollerview = goutil.findChild(go, "tableview")
	local petScrollerview = self._petScrollListDic[go]

	if petScrollerview then
		petScrollerview:dispose()

		self._petScrollListDic[go] = nil
	end
end

function AngelPowerClgPetView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCell(MatType.Pet, data, go)
end

function AngelPowerClgPetView:_clearPetCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

return AngelPowerClgPetView

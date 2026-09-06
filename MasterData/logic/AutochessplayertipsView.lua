-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessplayertipsView.lua

module("logic.extensions.autochess.view.AutochessplayertipsView", package.seeall)

local AutochessplayertipsView = class("AutochessplayertipsView", ViewComponent)

function AutochessplayertipsView:unbindEvents()
	AutochessplayertipsView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function AutochessplayertipsView:bindEvents()
	AutochessplayertipsView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function AutochessplayertipsView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function AutochessplayertipsView:onExit()
	AutochessplayertipsView.super.onExit(self)
	self._buffScrollList:dispose()
	HeadItemController.instance:resetHeadCell(self._headGo)
	self._cFormation:onExit()
	uGuiUtil.clearImage(self._teamIconGo)
end

function AutochessplayertipsView:buildUI()
	AutochessplayertipsView.super.buildUI(self)

	self.content = self:getGo("Nego_Content")
	self._customInput = UICustomInput.Get(self.content)
	self._adjustPosition = self.content:GetComponent("UIAdjustPosition")
	self._txtName = self:getTxt("Nego_Content/top/txtName")
	self._txtLv = self:getTxt("Nego_Content/top/txtLv")
	self._tableviewGo = self:getGo("Nego_Content/buff/tableview")
	self._tablecellGo = self:getGo("Nego_Content/buff/tablecell")
	self._headGo = self:getGo("Nego_Content/top/head")
	self._formationGo = self:getGo("Nego_Content/formation")
	self._buffScrollList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateFetterCell, self), GameUtil.handler(self._clearFetterCell, self))
	self._teamIconGo = self:getGo("Nego_Content/buff/teamIcon")
	self._cFormation = CFormation.New(self._formationGo)
	self._formationGo = self:getGo("Nego_Content/formation")
	self._txtEmptyBuffGo = self:getGo("Nego_Content/buff/txtEmptyBuff")
	self._emptyFmtGo = self:getGo("Nego_Content/emptyFmt")
end

function AutochessplayertipsView:onEnter()
	AutochessplayertipsView.super.onEnter(self)

	local params = self:getOpenParam()

	self._player = params[1]

	local clickUIGo = params[2]

	self._raceId2star = {}

	self:_updateUI()
	self:_adjustPos(clickUIGo)
end

function AutochessplayertipsView:_adjustPos(clickUIGo)
	local sizeDelta = {
		0,
		0
	}
	local pos

	if clickUIGo and clickUIGo.gameObject then
		local rect = clickUIGo.gameObject:GetComponent("RectTransform")

		if rect ~= nil then
			sizeDelta = {
				rect.sizeDelta.x,
				rect.sizeDelta.y
			}
		end

		pos = clickUIGo.gameObject.transform.position

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)
	end

	if pos then
		self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
	end
end

function AutochessplayertipsView:_updateUI()
	self._player = self:getFirstParam()

	self:_updateTop()
	self:_updateFmt()
end

function AutochessplayertipsView:_updateTop()
	self._txtName.text = self._player.headInfo.userName
	self._txtLv.text = string.format("Lv.%s", self._player.headInfo.playerLv)

	HeadItemController.instance:resetHeadCell(self._headGo)
	HeadItemController.instance:setHeadCellByInfo(self._headGo, self._player.headInfo)
end

function AutochessplayertipsView:_updateFmt()
	self:_setFormation()
	self:_updateBuff()
end

function AutochessplayertipsView:_updateBuff()
	self:_setInitBuff()

	local isEmpty = not self._player:HasField("form")

	goutil.setActive(self._txtEmptyBuffGo, isEmpty)

	if isEmpty then
		self._buffScrollList:reloadData({})

		return
	end

	local fmt = self._player.form
	local fettersId2num = {}

	for i = 1, 9 do
		local petId = fmt.pos[i]

		if petId > 0 then
			local creepsCfg = AutochessConfig.instance:getCreepsCfg(petId)
			local fettersId = AutochessConfig.instance:getPetFettersId(creepsCfg.raceId)

			if not fettersId2num[fettersId] then
				fettersId2num[fettersId] = {
					num = 0,
					numDesc = "",
					fettersId = fettersId
				}

				local cfgs = AutochessConfig.instance:getFettersBuffCfgs(fettersId)
				local t = {}

				for j, cfg in ipairs(cfgs) do
					t[j] = cfg.num
				end

				fettersId2num[fettersId].numDesc = table.concat(t, "/")
			end

			fettersId2num[fettersId].num = fettersId2num[fettersId].num + 1
		end
	end

	local fetters = table.values(fettersId2num)

	table.sort(fetters, function(a, b)
		return a.fettersId < b.fettersId
	end)
	goutil.setActive(self._txtEmptyBuffGo, #fetters <= 0)
	self._buffScrollList:reloadData(fetters)
end

function AutochessplayertipsView:_setInitBuff()
	local initBuffId = self._player.initBuffId

	goutil.setActive(self._teamIconGo, initBuffId > 0)

	if initBuffId <= 0 then
		return
	end

	local buffCfg = AutochessConfig.instance:getInitBuffCfg(initBuffId)
	local spriteName = string.format("ui/icon/%s.png", buffCfg.iconPath)

	uGuiUtil.setSpriteToImage(self._teamIconGo, nil, spriteName)
end

function AutochessplayertipsView:_updateFetterCell(view, cell, data, tag)
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")
	local iconChange = goutil.findChild(cell.gameObject, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
	local fettersBuffCfg = AutochessConfig.instance:getFettersBuffCfg(data.fettersId, data.num)

	txtNum.text = data.num
	fettersBuffCfg = fettersBuffCfg or AutochessConfig.instance:getFettersCfg(data.fettersId)

	iconChange:ChangeSprite(fettersBuffCfg.iconPath)
end

function AutochessplayertipsView:_clearFetterCell(cell)
	return
end

function AutochessplayertipsView:_setFormation()
	self._cFormationMo = self._cFormationMo or CFormationMo.New()

	local isEmpty = not self._player:HasField("form")

	goutil.setActive(self._formationGo, not isEmpty)
	goutil.setActive(self._emptyFmtGo, isEmpty)

	if isEmpty then
		return
	end

	self._raceId2star = {}

	local fmt = self._player.form

	for i = 1, 9 do
		local petId = fmt.pos[i]

		if petId > 0 then
			local cfg = AutochessConfig.instance:getCreepsCfg(petId)

			self._cFormationMo:setRaceId(i, cfg.raceId)

			self._raceId2star[cfg.raceId] = cfg.starLevel
		else
			self._cFormationMo:setRaceId(i, 0)
		end
	end

	local nums = table.nums(self._raceId2star)

	goutil.setActive(self._formationGo, nums > 0)
	goutil.setActive(self._emptyFmtGo, nums <= 0)
	self._cFormation:regCellUpdateCallBack(self._updateFmtCell, self)
	self._cFormation:onEnter(self._cFormationMo)
end

function AutochessplayertipsView:_updateFmtCell(cell, raceId, index)
	if not self._raceId2star[raceId] then
		local star = 0
		local starRoot = goutil.findChild(cell.go, "star")

		for i = 1, AutochessController.MaxStarNum do
			local go = goutil.findChild(starRoot, "star" .. i)

			goutil.setActive(go, i <= star)
		end
	end
end

return AutochessplayertipsView

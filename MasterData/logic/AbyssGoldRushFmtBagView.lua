-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushFmtBagView.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushFmtBagView", package.seeall)

local AbyssGoldRushFmtBagView = class("AbyssGoldRushFmtBagView", ViewComponent)
local holyStripePosition = {
	{
		rotate = 90,
		x = -42.2,
		y = -203.9
	},
	{
		rotate = 45,
		x = 6.7,
		y = -75.7
	},
	{
		rotate = 0,
		x = 137.1,
		y = -27.9
	},
	{
		rotate = -45,
		x = 266.7,
		y = -76.8
	},
	{
		rotate = -90,
		x = 316.4,
		y = -204.1
	}
}

function AbyssGoldRushFmtBagView:ctor()
	AbyssGoldRushFmtBagView.super.ctor(self)
end

function AbyssGoldRushFmtBagView:unbindEvents()
	AbyssGoldRushFmtBagView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnUnload)
	GameUtil.rmClickHandler(self._qualityFilterBtn)
end

function AbyssGoldRushFmtBagView:bindEvents()
	AbyssGoldRushFmtBagView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnUnload, self._onClickUnload, self)
	GameUtil.addClickHandler(self._qualityFilterBtn, self._onClickFilterShow, self)
end

function AbyssGoldRushFmtBagView:buildUI()
	AbyssGoldRushFmtBagView.super.buildUI(self)
	self:_buildEquipItems()

	self._txtEffect = self:getTxt("rightRoot/attrRoot/tableview/viewport/txtEffect")
	self._txtName = self:getTxt("rightRoot/attrRoot/txtName")
	self._empty = self:getGo("bagRoot/empty")
	self._tablecell = self:getGo("bagRoot/tablecell")
	self._tableview = self:getGo("bagRoot/tableview")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._closeBtn = self:getGo("closeBtn")
	self._txtPlanName = self:getTxt("head/txtName")
	self._planTableview = self:getGo("planTableview")
	self._planTablecell = self:getGo("planTablecell")
	self._planTableList = ScrollerList.create(self._planTableview, self._planTablecell, GameUtil.handler(self._updatePlanCell, self), GameUtil.handler(self._clearPlanCell, self))
	self._btnUnload = self:getGo("btnUnload")
	self._btnSure = self:getGo("btnSure")
	self._fitlerRoot = self:getGo("fitlerRoot")
	self._filterList = {}

	for i = 1, 5 do
		local filterInfo = {}

		filterInfo.go = goutil.findChild(self._fitlerRoot, "btnQuality_" .. i)
		filterInfo.change = filterInfo.go:GetComponent(ComponentType.UIChangeGroup)
		self._filterList[i] = filterInfo
	end

	local filterAllInfo = {}

	filterAllInfo.go = goutil.findChild(self._fitlerRoot, "btnAll")
	filterAllInfo.change = filterAllInfo.go:GetComponent(ComponentType.UIChangeGroup)
	self._filterList[0] = filterAllInfo
	self._customInput = UICustomInput.Get(self._fitlerRoot)
	self._qualityFilterBtn = self:getGo("bagRoot/tabCon/qualityFilterBtn/bg")
	self._filterPosGo = self:getGo("filterPosGo")
end

function AbyssGoldRushFmtBagView:_buildEquipItems()
	local equipCell = self:getGo("rightRoot/equipRoot/cell1")
	local equipRoot = self:getGo("rightRoot/equipRoot")

	self._equipItems = {}

	local goList = {
		equipCell
	}

	for i = 2, 5 do
		goList[i] = goutil.cloneAndSetParent(equipCell, equipRoot.transform, "cell" .. i)
	end

	for i, go in ipairs(goList) do
		local btn = Framework.ButtonAdapter.GetFrom(go, "raycast")
		local icon = goutil.findChild(go, "icon")
		local lvText = goutil.findChildTextComponent(go, "lvText")
		local nameText = goutil.findChildTextComponent(go, "nameText")
		local effect = goutil.findChild(go, "effect")
		local redpoint = goutil.findChild(go, "redpoint")
		local select = goutil.findChild(go, "select")
		local quality = goutil.findChild(go, "quality")
		local qualityUIChange = goutil.findChildComponent(go, "quality", "UIImageSpriteChange")
		local tagTemp = goutil.findChild(go, "tagTemp")

		self._equipItems[i] = {
			btn = btn,
			icon = icon,
			lvText = lvText,
			effect = effect,
			nameText = nameText,
			redPoint = redpoint,
			select = select,
			quality = quality,
			qualityUIChange = qualityUIChange,
			tagTemp = tagTemp
		}

		local pos = holyStripePosition[i]

		GameUtil.setAnchoredPos(go, pos.x, pos.y)

		if select then
			Framework.TransformUtil.SetLocalRotation(select.transform, 0, 0, pos.rotate)
		end

		if quality then
			Framework.TransformUtil.SetLocalRotation(quality.transform, 0, 0, pos.rotate)
		end
	end
end

function AbyssGoldRushFmtBagView:onExit()
	AbyssGoldRushFmtBagView.super.onExit(self)
	self:_resetEquipItems()
end

function AbyssGoldRushFmtBagView:onEnter()
	AbyssGoldRushFmtBagView.super.onEnter(self)
	self.addGEvent(self, HolyStripeController.On_Select_FilterQuality, self._onClickFilter, self)

	self._activityId = checknumber(self:getFirstParam())

	local params = self:getOpenParam()

	self._fmtMo = params[2]
	self._activityCfg = AbyssGoldRushConfig.instance:getActivityCfg(self._activityId)
	self._filterQuality = nil
	self._presetList = {}

	for i = 1, self._activityCfg.presetCount do
		table.insert(self._presetList, i)
	end

	self:initBagList()

	self._curSelectIndex = 1

	self:collectRecommondType()
	self:_refreshView()
end

function AbyssGoldRushFmtBagView:initBagList()
	self._bagMap = {}
	self._posDataList = {}
	self._holyStripeInfo = AbyssGoldRushGameModel.instance:getHolyStripeInfo()
	self._curPresetId = AbyssGoldRushGameModel.instance:getUsePresetId()

	local curPresetIds = AbyssGoldRushGameModel.instance:getPresetIds(self._curPresetId)

	for i, v in ipairs(curPresetIds) do
		self._posDataList[i] = v
	end
end

function AbyssGoldRushFmtBagView:collectRecommondType()
	self._recommondHolyStripe = {}

	local formationMo = self._fmtMo:getCurFormation()
	local creepIds = {}

	for i, v in ipairs(formationMo:GetPositions()) do
		if v > 0 then
			table.insert(creepIds, v)
		end
	end

	for i, v in ipairs(creepIds) do
		local petCfg = AbyssGoldRushConfig.instance:getSupportPet(v)

		for j, id in ipairs(petCfg.recommendHolyStripe or {}) do
			self._recommondHolyStripe[id] = true
		end
	end
end

function AbyssGoldRushFmtBagView:_isRecommondHolyStripe(data)
	local var_10_0

	if data then
		::label_10_0::

		var_10_0 = self._recommondHolyStripe and self._recommondHolyStripe[data.defineId] == true
	end

	return var_10_0
end

function AbyssGoldRushFmtBagView:_setEquipItems()
	for i, v in ipairs(self._equipItems) do
		v.lvText.text = ""
		v.nameText.text = ""

		v.btn:RemoveClickListener()
		v.btn:AddClickListener(function()
			self:_onItemBtnClick(i)
		end)
		goutil.setActive(v.icon, false)
		goutil.setActive(v.quality, false)
		GameUtil.SetActive(v.tagTemp, false)
		MaterialMgr:clearIcon(v.icon)

		if v.select then
			goutil.setActive(v.select, self._curSelectIndex == i)
		end

		goutil.setActive(v.redPoint, false)
	end

	for posType, v in pairs(self._posDataList) do
		if checknumber(v.id) > 0 then
			local holyStripeCfg = AbyssGoldRushConfig.instance:getHolyStripeCfg(v.defineId)
			local targetCfg = HolyStripeConfig.instance:getHolyStripeCfg(holyStripeCfg.holyStripeTarget)
			local iconGo = self._equipItems[posType].icon
			local quality = self._equipItems[posType].quality
			local qualityUIChange = self._equipItems[posType].qualityUIChange

			self._equipItems[posType].lvText.text = ""

			local _, color
			local var_11_0, var_11_1 = PetEquipController.instance:GetQualityStrByNum(targetCfg.quality)

			_ = var_11_0
			self._equipItems[posType].nameText.text = langPara("<color=%s>%s</color>", var_11_1, targetCfg.name)

			goutil.setActive(quality, true)
			qualityUIChange:SetState(targetCfg.quality)
			MaterialMgr.setIcon(iconGo, MatType.HolyStripe, targetCfg.id)
			goutil.setActive(iconGo, true)
			self._equipItems[posType].btn:RemoveClickListener()
			goutil.setActive(self._equipItems[posType].redPoint, false)
			self._equipItems[posType].btn:AddClickListener(function()
				self:_onItemBtnClick(posType)
			end)

			if self._holyStripeInfo and self._holyStripeInfo[v.id] then
				GameUtil.SetActive(self._equipItems[posType].tagTemp, self._holyStripeInfo[v.id].type == 2)
			end
		end
	end
end

function AbyssGoldRushFmtBagView:_resetEquipItems()
	for i, item in ipairs(self._equipItems) do
		item.btn:RemoveClickListener()
		MaterialMgr:clearIcon(item.icon)
		MaterialMgr.resetAll(item.icon)
	end
end

function AbyssGoldRushFmtBagView:_onItemBtnClick(posType)
	self._curSelectIndex = posType

	self:_refreshView()
end

function AbyssGoldRushFmtBagView:_refreshView()
	self:_setEquipItems()

	local selectItem = self._posDataList[self._curSelectIndex]

	if selectItem and checknumber(selectItem.id) > 0 then
		local holyStripeCfg = AbyssGoldRushConfig.instance:getHolyStripeCfg(selectItem.defineId)

		self._txtName.text = holyStripeCfg.effectName
		self._txtEffect.text = holyStripeCfg.effectDesc

		GameUtil.SetActive(self._btnUnload, true)
	else
		self._txtName.text = lang("无")
		self._txtEffect.text = lang("无")

		GameUtil.SetActive(self._btnUnload, false)
	end

	local showList = {}
	local useMap = {}

	for i = 1, self._activityCfg.presetCount do
		if i ~= self._curPresetId then
			local curPresetIds = AbyssGoldRushGameModel.instance:getPresetIds(i)

			for k, v in pairs(curPresetIds) do
				useMap[v.id] = true
			end
		else
			for k, v in pairs(self._posDataList) do
				useMap[v.id] = true
			end
		end
	end

	for k, v in pairs(self._holyStripeInfo) do
		local holyStripeCfg = AbyssGoldRushConfig.instance:getHolyStripeCfg(v.defineId)
		local targetCfg = HolyStripeConfig.instance:getHolyStripeCfg(holyStripeCfg.holyStripeTarget)

		if not useMap[v.id] and (not self._filterQuality or targetCfg.quality == self._filterQuality) then
			table.insert(showList, v)
		end
	end

	table.sort(showList, function(a, b)
		local aRecommond = self:_isRecommondHolyStripe(a)
		local bRecommond = self:_isRecommondHolyStripe(b)

		if aRecommond ~= bRecommond then
			return aRecommond == true
		end

		return checknumber(a.id) < checknumber(b.id)
	end)
	self._tableList:reloadData(showList)
	GameUtil.SetActive(self._empty, #showList <= 0)
	self._planTableList:reloadData(self._presetList)

	self._txtPlanName.text = langPara("方案%s", GameUtil.getChineseNumber(self._curPresetId))

	self:_refreshFilter()
end

function AbyssGoldRushFmtBagView:_refreshFilter()
	for i, v in pairs(self._filterList) do
		if self._filterQuality and i == self._filterQuality or not self._filterQuality and i == 0 then
			v.change:SetState(1)
		else
			v.change:SetState(0)
		end
	end
end

function AbyssGoldRushFmtBagView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local itemCon = goutil.findChild(go, "itemCon")
	local btn = goutil.findChild(go, "raycast")
	local nameText = goutil.findChildTextComponent(go, "nameText")
	local tagTemp = goutil.findChild(go, "tagTemp")
	local tagRecommond = goutil.findChild(go, "tagRecommond")
	local holyStripeCfg = AbyssGoldRushConfig.instance:getHolyStripeCfg(data.defineId)
	local proxy = MaterialMgr.setCell(MatType.HolyStripe, holyStripeCfg.holyStripeTarget, itemCon)

	if proxy then
		proxy.binder:setAutoTips(false)
	end

	local targetCfg = HolyStripeConfig.instance:getHolyStripeCfg(holyStripeCfg.holyStripeTarget)
	local _, color
	local var_19_0, var_19_1 = PetEquipController.instance:GetQualityStrByNum(targetCfg.quality)

	_ = var_19_0
	nameText.text = langPara("<color=%s>%s</color>", var_19_1, targetCfg.name)

	GameUtil.SetActive(tagTemp, data.type == 2)
	GameUtil.SetActive(tagRecommond, self:_isRecommondHolyStripe(data))
	GameUtil.addClickHandler(btn, function()
		self:_onClickItem(data)
	end)
end

function AbyssGoldRushFmtBagView:_clearCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "raycast")

	GameUtil.rmClickHandler(btn)
	MaterialMgr.resetAll(go)
end

function AbyssGoldRushFmtBagView:_updatePlanCell(view, cell, data, tag)
	local go = cell.gameObject
	local nameText = goutil.findChildTextComponent(go, "nameText")
	local imgCur = goutil.findChild(go, "imgCur")
	local imgSelect = goutil.findChild(go, "imgSelect")
	local btn = goutil.findChild(go, "btnSelect")

	nameText.text = langPara("方案%s", GameUtil.getChineseNumber(data))

	if AbyssGoldRushGameModel.instance:isInGame() == true then
		GameUtil.SetActive(imgCur, data == AbyssGoldRushGameModel.instance:getUsePresetId())
	else
		GameUtil.SetActive(imgCur, data == AbyssGoldRushModel.instance:getUsePresetId(self._activityId))
	end

	GameUtil.SetActive(imgSelect, data == self._curPresetId)
	GameUtil.addClickHandler(btn, function()
		self:_onClickPreset(data)
	end)
end

function AbyssGoldRushFmtBagView:_clearPlanCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btnSelect")

	GameUtil.rmClickHandler(btn)
end

function AbyssGoldRushFmtBagView:saveCurPreset()
	local ids = {}

	for i, v in pairs(self._posDataList) do
		table.insert(ids, v)
	end

	AbyssGoldRushGameModel.instance:savePresetIds(self._curPresetId, ids)
end

function AbyssGoldRushFmtBagView:_onClickPreset(presetId)
	self:saveCurPreset()

	self._posDataList = {}
	self._curPresetId = presetId

	if AbyssGoldRushGameModel.instance:isInGame() == true then
		local curPresetIds = AbyssGoldRushGameModel.instance:getPresetIds(self._curPresetId)

		for i, v in ipairs(curPresetIds) do
			self._posDataList[i] = v
		end
	else
		for i, v in ipairs(AbyssGoldRushModel.instance:getPresetInfo(self._activityId, self._curPresetId)) do
			self._posDataList[i] = v
		end
	end

	self:_refreshView()
end

function AbyssGoldRushFmtBagView:_onClickItem(data)
	self._posDataList[self._curSelectIndex] = {
		defineId = data.defineId,
		id = data.id
	}

	self:_refreshView()
end

function AbyssGoldRushFmtBagView:_onClickClose()
	GlobalDispatcher:dispatch(GlobalNotify.AbyssGoldRushPresetUse)
	self:close()
end

function AbyssGoldRushFmtBagView:_onClickSure()
	self:saveCurPreset()
	AbyssGoldRushGameModel.instance:saveUsePresetId(self._curPresetId)
	GlobalDispatcher:dispatch(GlobalNotify.AbyssGoldRushPresetUse)
	self:close()
end

function AbyssGoldRushFmtBagView:_onClickFilterShow()
	self:showTabAt(self._filterPosGo, ViewName.HolyStripeQualityFilterView, self._filterQuality)
end

function AbyssGoldRushFmtBagView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._fitlerRoot, false)
	end
end

function AbyssGoldRushFmtBagView:_onClickUnload()
	self._posDataList[self._curSelectIndex] = nil

	self:_refreshView()
end

function AbyssGoldRushFmtBagView:_onClickFilter(index)
	self._filterQuality = index

	self:_refreshView()
end

return AbyssGoldRushFmtBagView

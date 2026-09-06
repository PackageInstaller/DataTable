-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushBagView.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushBagView", package.seeall)

local AbyssGoldRushBagView = class("AbyssGoldRushBagView", ViewComponent)
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

function AbyssGoldRushBagView:ctor()
	AbyssGoldRushBagView.super.ctor(self)
end

function AbyssGoldRushBagView:unbindEvents()
	AbyssGoldRushBagView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
	GameUtil.addClickHandler(self._btnSure)
	GameUtil.addClickHandler(self._btnUnload)
	GameUtil.rmClickHandler(self._qualityFilterBtn)
end

function AbyssGoldRushBagView:bindEvents()
	AbyssGoldRushBagView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnUnload, self._onClickUnload, self)
	GameUtil.addClickHandler(self._qualityFilterBtn, self._onClickFilterShow, self)
end

function AbyssGoldRushBagView:buildUI()
	AbyssGoldRushBagView.super.buildUI(self)
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

function AbyssGoldRushBagView:_buildEquipItems()
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

		self._equipItems[i] = {
			btn = btn,
			icon = icon,
			lvText = lvText,
			effect = effect,
			nameText = nameText,
			redPoint = redpoint,
			select = select,
			quality = quality,
			qualityUIChange = qualityUIChange
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

function AbyssGoldRushBagView:onExit()
	AbyssGoldRushBagView.super.onExit(self)
	self:_resetEquipItems()
end

function AbyssGoldRushBagView:onEnter()
	AbyssGoldRushBagView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AbyssGoldRushPresetRes, self._refreshView, self)
	self.addGEvent(self, HolyStripeController.On_Select_FilterQuality, self._onClickFilter, self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityCfg = AbyssGoldRushConfig.instance:getActivityCfg(self._activityId)
	self._filterQuality = nil
	self._presetList = {}

	for i = 1, self._activityCfg.presetCount do
		table.insert(self._presetList, i)
	end

	self._selectPresetId = AbyssGoldRushModel.instance:getUsePresetId(self._activityId)

	self:initBagList()

	self._curSelectIndex = 1

	self:_refreshView()
end

function AbyssGoldRushBagView:initBagList()
	self._bagMap = {}
	self._curPresetId = nil
	self._posDataList = {}

	local holyStripeInfo = AbyssGoldRushModel.instance:getHolyStripeInfo(self._activityId)

	for i, v in ipairs(holyStripeInfo) do
		self._bagMap[v.left] = v.right
	end

	self._curPresetId = AbyssGoldRushModel.instance:getUsePresetId(self._activityId)

	for i, v in ipairs(AbyssGoldRushModel.instance:getPresetInfo(self._activityId, self._curPresetId)) do
		self._posDataList[i] = v
	end
end

function AbyssGoldRushBagView:_setEquipItems()
	for i, v in ipairs(self._equipItems) do
		v.lvText.text = ""
		v.nameText.text = ""

		v.btn:RemoveClickListener()
		v.btn:AddClickListener(function()
			self:_onItemBtnClick(i)
		end)
		goutil.setActive(v.icon, false)
		goutil.setActive(v.quality, false)
		MaterialMgr:clearIcon(v.icon)

		if v.select then
			goutil.setActive(v.select, self._curSelectIndex == i)
		end

		goutil.setActive(v.redPoint, false)
	end

	local useItems = {}

	for posType, v in pairs(self._posDataList) do
		if checknumber(useItems[v]) < checknumber(self._bagMap[v]) then
			local holyStripeCfg = AbyssGoldRushConfig.instance:getHolyStripeCfg(v)
			local targetCfg = HolyStripeConfig.instance:getHolyStripeCfg(holyStripeCfg.holyStripeTarget)
			local iconGo = self._equipItems[posType].icon
			local quality = self._equipItems[posType].quality
			local qualityUIChange = self._equipItems[posType].qualityUIChange

			self._equipItems[posType].lvText.text = ""

			local _, color
			local var_9_0, var_9_1 = PetEquipController:GetQualityStrByNum(targetCfg.quality)

			_ = var_9_0
			self._equipItems[posType].nameText.text = langPara("<color=%s>%s</color>", var_9_1, targetCfg.name)

			goutil.setActive(quality, true)
			qualityUIChange:SetState(targetCfg.quality)
			MaterialMgr.setIcon(iconGo, MatType.HolyStripe, targetCfg.id)
			goutil.setActive(iconGo, true)
			self._equipItems[posType].btn:RemoveClickListener()
			goutil.setActive(self._equipItems[posType].redPoint, false)
			self._equipItems[posType].btn:AddClickListener(function()
				self:_onItemBtnClick(posType)
			end)

			useItems[v] = checknumber(useItems[v]) + 1
		end
	end
end

function AbyssGoldRushBagView:_resetEquipItems()
	for i, item in ipairs(self._equipItems) do
		item.btn:RemoveClickListener()
		MaterialMgr:clearIcon(item.icon)
		MaterialMgr.resetAll(item.icon)
	end
end

function AbyssGoldRushBagView:_onItemBtnClick(posType)
	self._curSelectIndex = posType

	self:_refreshView()
end

function AbyssGoldRushBagView:_refreshView()
	self:_setEquipItems()

	local useItems = {}

	for i = 1, self._curSelectIndex do
		local id = self._posDataList[i]

		if id then
			useItems[id] = checknumber(useItems[id]) + 1
		end
	end

	local selectItemId = self._posDataList[self._curSelectIndex]

	if checknumber(selectItemId) > 0 and checknumber(useItems[selectItemId]) <= checknumber(self._bagMap[selectItemId]) then
		local holyStripeCfg = AbyssGoldRushConfig.instance:getHolyStripeCfg(selectItemId)

		self._txtName.text = holyStripeCfg.effectName
		self._txtEffect.text = holyStripeCfg.effectDesc
	else
		self._txtName.text = lang("无")
		self._txtEffect.text = lang("无")
	end

	local showList = {}
	local bagMap = {}

	for k, v in pairs(self._bagMap) do
		bagMap[k] = v
	end

	for i = 1, self._activityCfg.presetCount do
		if i == self._curPresetId then
			for k, v in pairs(self._posDataList) do
				if bagMap[v] then
					bagMap[v] = bagMap[v] - 1
				end
			end
		else
			for i, v in ipairs(AbyssGoldRushModel.instance:getPresetInfo(self._activityId, i)) do
				if bagMap[v] then
					bagMap[v] = bagMap[v] - 1
				end
			end
		end
	end

	for k, v in pairs(bagMap) do
		if v > 0 then
			local holyStripeCfg = AbyssGoldRushConfig.instance:getHolyStripeCfg(k)
			local targetCfg = HolyStripeConfig.instance:getHolyStripeCfg(holyStripeCfg.holyStripeTarget)

			if not self._filterQuality or targetCfg.quality == self._filterQuality then
				table.insert(showList, {
					id = k,
					num = v
				})
			end
		end
	end

	self._tableList:reloadData(showList)
	GameUtil.SetActive(self._empty, #showList <= 0)
	self._planTableList:reloadData(self._presetList)

	self._txtPlanName.text = langPara("方案%s", GameUtil.getChineseNumber(self._curPresetId))
end

function AbyssGoldRushBagView:_refreshFilter()
	for i, v in pairs(self._filterList) do
		if self._filterQuality and i == self._filterQuality or not self._filterQuality and i == 0 then
			v.change:SetState(1)
		else
			v.change:SetState(0)
		end
	end
end

function AbyssGoldRushBagView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local itemCon = goutil.findChild(go, "itemCon")
	local btn = goutil.findChild(go, "raycast")
	local nameText = goutil.findChildTextComponent(go, "nameText")
	local holyStripeCfg = AbyssGoldRushConfig.instance:getHolyStripeCfg(data.id)
	local proxy = MaterialMgr.setCell(MatType.HolyStripe, holyStripeCfg.holyStripeTarget, itemCon)

	if proxy then
		proxy.binder:setAutoTips(false)
		proxy.binder:setNum(data.num)
	end

	local targetCfg = HolyStripeConfig.instance:getHolyStripeCfg(holyStripeCfg.holyStripeTarget)
	local _, color
	local var_16_0, var_16_1 = PetEquipController:GetQualityStrByNum(targetCfg.quality)

	_ = var_16_0
	nameText.text = langPara("<color=%s>%s</color>", var_16_1, targetCfg.name)

	GameUtil.addClickHandler(btn, function()
		self:_onClickItem(data.id)
	end)
end

function AbyssGoldRushBagView:_clearCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "raycast")

	GameUtil.rmClickHandler(btn)
	MaterialMgr.resetAll(go)
end

function AbyssGoldRushBagView:_updatePlanCell(view, cell, data, tag)
	local go = cell.gameObject
	local nameText = goutil.findChildTextComponent(go, "nameText")
	local imgCur = goutil.findChild(go, "imgCur")
	local imgSelect = goutil.findChild(go, "imgSelect")
	local btn = goutil.findChild(go, "btnSelect")

	nameText.text = langPara("方案%s", GameUtil.getChineseNumber(data))

	GameUtil.SetActive(imgCur, data == AbyssGoldRushModel.instance:getUsePresetId(self._activityId))
	GameUtil.SetActive(imgSelect, data == self._curPresetId)
	GameUtil.addClickHandler(btn, function()
		self:_onClickPreset(data)
	end)
end

function AbyssGoldRushBagView:_clearPlanCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btnSelect")

	GameUtil.rmClickHandler(btn)
end

function AbyssGoldRushBagView:saveCurPreset()
	local ids = {}

	for i, v in pairs(self._posDataList) do
		table.insert(ids, v)
	end

	AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushPresetReq(self._activityId, self._curPresetId, ids)
end

function AbyssGoldRushBagView:_onClickPreset(presetId)
	self:saveCurPreset()

	self._posDataList = {}
	self._curPresetId = presetId

	for i, v in ipairs(AbyssGoldRushModel.instance:getPresetInfo(self._activityId, self._curPresetId)) do
		self._posDataList[i] = v
	end
end

function AbyssGoldRushBagView:_onClickItem(id)
	self._posDataList[self._curSelectIndex] = id

	self:_refreshView()
end

function AbyssGoldRushBagView:_onClickClose()
	self:saveCurPreset()
	self:close()
end

function AbyssGoldRushBagView:_onClickSure()
	self:saveCurPreset()

	if self._curPresetId ~= AbyssGoldRushModel.instance:getUsePresetId(self._activityId) then
		AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushUsePresetReq(self._activityId, self._curPresetId)
	end

	self:close()
end

function AbyssGoldRushBagView:_onClickUnload()
	self._posDataList[self._curSelectIndex] = nil

	self:_refreshView()
end

function AbyssGoldRushBagView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._fitlerRoot, false)
	end
end

function AbyssGoldRushBagView:_onClickFilterShow()
	self:showTabAt(self._filterPosGo, ViewName.HolyStripeQualityFilterView, self._filterQuality)
end

function AbyssGoldRushBagView:_onClickFilter(index)
	self._filterQuality = index

	self:_refreshView()
end

return AbyssGoldRushBagView

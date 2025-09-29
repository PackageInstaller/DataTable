-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/handbook/RogueHandBookMemoryView.lua

module("logic.extensions.roguelike.view.explore.handbook.RogueHandBookMemoryView", package.seeall)

local NEW_SIGN_KEY = "Memory_New_Sign"

function getIsNewSign(id)
	local playerId = PlayerModel.instance:getId()
	local key = NEW_SIGN_KEY .. playerId .. "-" .. id
	local isNew = Astral.LocalStorage.Instance:GetInt(key, 1)

	return isNew == 1
end

function setIsNewSign(id)
	local playerId = PlayerModel.instance:getId()
	local key = NEW_SIGN_KEY .. playerId .. "-" .. id

	Astral.LocalStorage.Instance:SetInt(key, -1)
end

local RogueMemoryTheadItem = class("RogueMemoryTheadItem")

function RogueMemoryTheadItem:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform

	self:init()
end

function RogueMemoryTheadItem:init()
	local go = self._go

	self._goNew = goutil.findChild(go, "newSign")
	self._goEmpty = goutil.findChild(go, "empty")
	self._goNormal = goutil.findChild(go, "normal")
	self._goItem = goutil.findChild(go, "normal/cell/backpack_item")
	self._goItem2 = goutil.findChild(go, "empty/cell/backpack_item")
	self._itemCell = Astral.LuaComponentContainer.Add(self._goItem, BackpackItemCell)
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click"))
	self._txtName = goutil.findChildTextComponent(go, "txtName")

	self._btnClick:AddClickListener(self._onClick, self)

	self._goEmpty = goutil.findChild(go, "empty")
	self._imgPropIcon = goutil.findChildImageComponent(self._goItem, "imgIcon")
	self._imgPropIcon2 = goutil.findChildImageComponent(self._goItem2, "imgIcon")
	self._imgPropQuality = goutil.findChildImageComponent(self._goItem, "imgQuality")
end

function RogueMemoryTheadItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function RogueMemoryTheadItem:updateData(data)
	self._id = data.id
	self._callback = data.callback
	self._txtName.text = data.isEmpty and "???" or data.name

	goutil.setActive(self._goEmpty, data.isEmpty)
	goutil.setActive(self._goNormal, not data.isEmpty)
	goutil.setActive(self._goNew, data.isNew)

	if self._itemCell then
		local numberComp = self._itemCell:getComponent("num")

		numberComp:setCountTextActive(false)
	end

	IconLoader.setSprite(self._imgPropIcon, IconType.ItemIcon, data.co.icon)
	IconLoader.setSprite(self._imgPropIcon2, IconType.ItemIcon, data.co.icon)
	self:setActive(true)
end

function RogueMemoryTheadItem:OnDestroy()
	self._btnClick:RemoveClickListener()

	self._goNew = nil
	self._btnClick = nil
	self._txtName = nil
end

function RogueMemoryTheadItem:_onClick()
	setIsNewSign(self._id)
	goutil.setActive(self._goNew, false)

	if self._callback then
		self._callback()
	end
end

local RogueMemoryMonsterItem = class("RogueMemoryMonsterItem")

function RogueMemoryMonsterItem:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform

	self:init()
end

function RogueMemoryMonsterItem:init()
	local go = self._go

	self._goNew = goutil.findChild(go, "newSign")
	self._goEmpty = goutil.findChild(go, "empty")
	self._goNormal = goutil.findChild(go, "normal")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click"))
	self._txtName = goutil.findChildTextComponent(go, "txtName")
	self._imgIcon = goutil.findChildImageComponent(go, "normal/mask/icon")
	self._imgIcon2 = goutil.findChildImageComponent(go, "empty/mask/icon")

	self._btnClick:AddClickListener(self._onClick, self)
end

function RogueMemoryMonsterItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function RogueMemoryMonsterItem:updateData(data)
	self._id = data.id
	self._callback = data.callback
	self._txtName.text = data.isEmpty and "???" or data.name

	goutil.setActive(self._goNew, data.isNew)
	goutil.setActive(self._goEmpty, data.isEmpty)
	goutil.setActive(self._goNormal, not data.isEmpty)
	IconLoader.setSprite(self._imgIcon, IconType.RunGroup, data.icon, self._onImageCallback1, self)
	IconLoader.setSprite(self._imgIcon2, IconType.RunGroup, data.icon2, self._onImageCallback2, self)

	local cutInfo = data.cutInfo

	if cutInfo then
		Astral.TransformUtil.SetLocalScale(self._imgIcon.transform, cutInfo[3], cutInfo[4], 1)
		Astral.TransformUtil.SetLocalPos(self._imgIcon.transform, cutInfo[1], cutInfo[2], 0)
		Astral.TransformUtil.SetLocalScale(self._imgIcon2.transform, cutInfo[3], cutInfo[4], 1)
		Astral.TransformUtil.SetLocalPos(self._imgIcon2.transform, cutInfo[1], cutInfo[2], 0)
	else
		print("找不到怪物裁剪信息", data.id)
	end

	self:setActive(true)
end

function RogueMemoryMonsterItem:_onImageCallback1()
	self._imgIcon:SetNativeSize()
end

function RogueMemoryMonsterItem:_onImageCallback2()
	self._imgIcon2:SetNativeSize()
end

function RogueMemoryMonsterItem:OnDestroy()
	self._btnClick:RemoveClickListener()

	self._goNew = nil
	self._btnClick = nil
	self._txtName = nil
end

function RogueMemoryMonsterItem:_onClick()
	setIsNewSign(self._id)
	goutil.setActive(self._goNew, false)

	if self._callback then
		self._callback()
	end
end

local RogueMemoryPropItem = class("RogueMemoryPropItem")

function RogueMemoryPropItem:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform

	self:init()
end

function RogueMemoryPropItem:init()
	local go = self._go

	self._goNew = goutil.findChild(go, "newSign")
	self._goEmpty = goutil.findChild(go, "empty")
	self._goNormal = goutil.findChild(go, "normal")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click"))
	self._txtName = goutil.findChildTextComponent(go, "txtName")
	self._imgIcon = goutil.findChildImageComponent(go, "normal/mask/icon")

	local backpackItem = goutil.findChild(go, "normal/cell/backpack_item")
	local backpackItem2 = goutil.findChild(go, "empty/cell/backpack_item")
	local item = Astral.LuaComponentContainer.Add(backpackItem, RoguePropItem)
	local item2 = Astral.LuaComponentContainer.Add(backpackItem2, RoguePropItem)

	self._propItem = item
	self._propItem2 = item2

	self._btnClick:AddClickListener(self._onClick, self)
end

function RogueMemoryPropItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function RogueMemoryPropItem:updateData(data)
	self._id = data.id
	self._callback = data.callback
	self._txtName.text = data.isEmpty and "???" or data.name

	goutil.setActive(self._goEmpty, data.isEmpty)
	goutil.setActive(self._goNormal, not data.isEmpty)
	goutil.setActive(self._goNew, data.isNew)

	local data1 = {}

	data1.propId = data.id

	self._propItem:updateData(data1)
	self._propItem2:updateData(data1)
	self:setActive(true)
end

function RogueMemoryPropItem:OnDestroy()
	self._btnClick:RemoveClickListener()

	self._goNew = nil
	self._btnClick = nil
	self._txtName = nil
end

function RogueMemoryPropItem:_onClick()
	setIsNewSign(self._id)
	goutil.setActive(self._goNew, false)

	if self._callback then
		self._callback()
	end
end

local M = class("RogueHandBookMemoryView", ViewComponent)
local kTabType = {
	Thread = 1,
	Prop = 3,
	Monster = 2
}

function M:ctor()
	M.super.ctor(self)

	self._threadItems = {}
	self._monsterItems = {}
	self._propItems = {}
end

function M:buildUI()
	self._txtName = self:getText("run_group_handbook_memory_view_-698911448")
	self._txtCount = self:getText("run_group_handbook_memory_view_-1303258880")
	self._txtFill = self:getText("run_group_handbook_memory_view_-1929218847")
	self._imgFill = self:getImage("run_group_handbook_memory_view_-729522655")
	self._goThreadPanel = self:getGo("handbook_alienation_entry_view_559704454")
	self._goMonsterPanel = self:getGo("run_group_handbook_memory_view_-1414560732")
	self._goPropPanel = self:getGo("run_group_handbook_memory_view_-1551042269")
	self._goThreadItem = self:getGo("run_group_handbook_memory_view_-486963617")
	self._goMonsterItem = self:getGo("run_group_handbook_memory_view_-366164485")
	self._traThreadContent = self:getGo("run_group_handbook_memory_view_1643706396").transform
	self._traMonsterContent = self:getGo("run_group_handbook_memory_view_-942699548").transform
	self._traPropContent = self:getGo("run_group_handbook_memory_view_-495855807").transform
	self._togThread = self:getGo("2&right_tab_content_-242000516"):GetComponent(UIComponentType.SpaceXToggle)
	self._togMonster = self:getGo("2&right_tab_content_-1578871314"):GetComponent(UIComponentType.SpaceXToggle)
	self._togProp = self:getGo("2&right_tab_content_1651451756"):GetComponent(UIComponentType.SpaceXToggle)
	self._scrollView1 = LoopGridViewHelper.New(self._goThreadPanel)

	self._scrollView1:InitGridView(0, self._onCellUpdate1, self)

	self._scrollView2 = LoopGridViewHelper.New(self._goMonsterPanel)

	self._scrollView2:InitGridView(0, self._onCellUpdate2, self)

	self._scrollView3 = LoopGridViewHelper.New(self._goPropPanel)

	self._scrollView3:InitGridView(0, self._onCellUpdate3, self)
	goutil.setActive(self._goThreadItem, false)
	goutil.setActive(self._goMonsterItem, false)
end

function M:destroyUI()
	self._scrollView1:Dispose()

	self._scrollView1 = nil

	self._scrollView2:Dispose()

	self._scrollView2 = nil

	self._scrollView3:Dispose()

	self._scrollView3 = nil
end

function M:bindEvents()
	self._togThread:AddListener(self._toggleThread, self)
	self._togMonster:AddListener(self._toggleMonster, self)
	self._togProp:AddListener(self._toggleProp, self)
end

function M:unbindEvents()
	self._togThread:RemoveListener()
	self._togMonster:RemoveListener()
	self._togProp:RemoveListener()
end

function M:onEnter()
	self:updateData()
end

function M:onExit()
	self._scrollView1:ClearCells()
	self._scrollView2:ClearCells()
	self._scrollView3:ClearCells()
end

function M:_toggleThread(toggle, isOn)
	if not isOn then
		return
	end

	self:switch2Panel(kTabType.Thread)
end

function checkIsMeet(id, meetList)
	for k, v in ipairs(meetList) do
		if v == id then
			return true
		end
	end

	return false
end

function M:_toggleMonster(toggle, isOn)
	if not isOn then
		return
	end

	self:switch2Panel(kTabType.Monster)
end

function M:_toggleProp(toggle, isOn)
	if not isOn then
		return
	end

	self:switch2Panel(kTabType.Prop)
end

function M:switch2Panel(type)
	goutil.setActive(self._goThreadPanel, type == kTabType.Thread)
	goutil.setActive(self._goMonsterPanel, type == kTabType.Monster)
	goutil.setActive(self._goPropPanel, type == kTabType.Prop)

	local curCount = 0
	local allCount = 0
	local name = ""

	if type == kTabType.Thread then
		curCount = self._curThreadCount
		allCount = self._allThreadCount
		name = "线索"
	elseif type == kTabType.Monster then
		curCount = self._curMonsterCount
		allCount = self._allMonsterCount
		name = "梦魇"
	elseif type == kTabType.Prop then
		curCount = self._curPropCount
		allCount = self._allPropCount
		name = "纪念品"
	end

	self:updateTitle(name, curCount, allCount)
end

function M:updateData()
	self:updateThread()
	self:updateProp()
	self:updateMonster()
	self:updateThread()
end

function M:updateTitle(name, curCount, allCount)
	local galleryCo = self:getFirstParam()

	curCount = curCount or self:getOpenParam()[2]
	allCount = allCount or self:getOpenParam()[3]
	self._txtName.text = name
	self._txtCount.text = string.format("%d/%d", curCount, allCount)
	self._txtFill.text = math.floor(curCount / allCount * 100) .. "%"
	self._imgFill.fillAmount = curCount / allCount
end

function M:_onCellUpdate1(curIndex, row, column)
	curIndex = curIndex + 1

	local item = self._scrollView1:NewListViewItem("thread_item")
	local view = Astral.LuaComponentContainer.Add(item.gameObject, RogueMemoryTheadItem)

	view:updateData(self._threadDatas[curIndex])

	return item
end

function M:_onCellUpdate2(curIndex, row, column)
	curIndex = curIndex + 1

	local item = self._scrollView2:NewListViewItem("moster_item")
	local view = Astral.LuaComponentContainer.Add(item.gameObject, RogueMemoryMonsterItem)

	view:updateData(self._monsterDatas[curIndex])

	return item
end

function M:_onCellUpdate3(curIndex, row, column)
	curIndex = curIndex + 1

	local item = self._scrollView3:NewListViewItem("prop_item")
	local view = Astral.LuaComponentContainer.Add(item.gameObject, RogueMemoryPropItem)

	view:updateData(self._propDatas[curIndex])

	return item
end

function M:updateThread()
	local meetClue = RoguelikeModel.instance:getLogInfo().clue
	local allThreads = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.RoguelikeClueType)
	local galleryCo = self:getFirstParam()
	local curThreads = {}

	self._threadDatas = {}

	for k, v in pairs(allThreads) do
		if v.galleryId == galleryCo.id then
			table.insert(curThreads, v)
		end
	end

	local meetCount = 0

	for k, v in pairs(curThreads) do
		local data = {}
		local idx = k

		data.id = v.id
		data.isEmpty = not checkIsMeet(v.id, meetClue)

		local empty = data.isEmpty

		data.isNew = not empty and getIsNewSign(v.id)
		meetCount = data.isEmpty and meetCount or meetCount + 1

		function data.callback()
			if empty then
				FloatWordMgr.instance:show(lang("tip_r_check_unlock_thread"))

				return
			end

			data.isNew = not empty and getIsNewSign(v.id)

			ViewMgr.instance:open(ViewName.RogueMemoryThread, v)
		end

		data.name = v.name
		data.co = v

		table.insert(self._threadDatas, data)
	end

	if #curThreads > 0 then
		self._togThread.IsOn = true
	end

	self._allThreadCount = #curThreads
	self._curThreadCount = meetCount

	goutil.setActive(self._togThread.gameObject, #curThreads > 0)
	self._scrollView1:SetListItemCount(#self._threadDatas, true)
	self._scrollView1:RefreshAllShownItem()
end

function M:updateMonster()
	local meetMonsters = RoguelikeModel.instance:getLogInfo().monster
	local allMonsters = RoguelikeConfig.instance:getAllMonster()
	local galleryCo = self:getFirstParam()
	local curMonsters = {}

	for k, v in pairs(allMonsters) do
		if v.galleryId == galleryCo.id then
			table.insert(curMonsters, v)
		end
	end

	table.sort(curMonsters, function(a, b)
		return a.id < b.id
	end)

	local meetCount = 0

	self._monsterDatas = {}

	for k, v in pairs(curMonsters) do
		local data = {}
		local idx = k

		function data.callback()
			if not checkIsMeet(v.id, meetMonsters) then
				FloatWordMgr.instance:show(lang("tip_r_cur_not_unlock"))

				return
			end

			data.isNew = not empty and getIsNewSign(v.id)

			ViewMgr.instance:open(ViewName.RogueHandBookMonster, v.id)
		end

		data.icon = string.format("rungroup_monster/%s", v.staticRes)
		data.icon2 = string.format("rungroup_monster_jy/%s", v.staticRes)
		data.name = v.name
		data.id = v.id
		data.isEmpty = not checkIsMeet(v.id, meetMonsters)

		local cutInfo = CharacterConfig.instance:getRunGroupMonsterCo(v.staticRes)

		data.cutInfo = cutInfo and cutInfo.posSizeInfo1 or nil
		data.isNew = not data.isEmpty and getIsNewSign(v.id)
		meetCount = data.isEmpty and meetCount or meetCount + 1

		table.insert(self._monsterDatas, data)
	end

	if #curMonsters > 0 then
		self._togMonster.IsOn = true
	end

	self._allMonsterCount = #curMonsters
	self._curMonsterCount = meetCount

	goutil.setActive(self._togMonster.gameObject, #curMonsters > 0)
	self._scrollView2:SetListItemCount(#self._monsterDatas, true)
	self._scrollView2:RefreshAllShownItem()
end

function M:updateProp()
	local meetProps = RoguelikeModel.instance:getLogInfo().props
	local allProps = RoguelikeConfig.instance:getAllProps()
	local galleryCo = self:getFirstParam()
	local curProps = {}

	for k, v in pairs(allProps) do
		if v.galleryId == galleryCo.id then
			table.insert(curProps, v)
		end
	end

	table.sort(curProps, function(a, b)
		return a.id < b.id
	end)

	local meetCount = 0

	self._propDatas = {}

	for k, v in pairs(curProps) do
		local data = {}
		local idx = k

		function data.callback()
			if not checkIsMeet(v.id, meetProps) then
				FloatWordMgr.instance:show(lang("tip_r_cur_not_unlock"))

				return
			end

			data.isNew = not empty and getIsNewSign(v.id)

			ViewMgr.instance:open(ViewName.RogueHandBookPropTips, v)
		end

		data.icon = v.art
		data.name = v.name
		data.id = v.id
		data.isEmpty = not checkIsMeet(v.id, meetProps)
		data.isNew = not data.isEmpty and getIsNewSign(v.id)
		meetCount = data.isEmpty and meetCount or meetCount + 1

		table.insert(self._propDatas, data)
	end

	if #curProps > 0 then
		self._togProp.IsOn = true
	end

	self._allPropCount = #curProps
	self._curPropCount = meetCount

	goutil.setActive(self._togProp.gameObject, #curProps > 0)
	self._scrollView3:SetListItemCount(#self._propDatas, true)
	self._scrollView3:RefreshAllShownItem()
end

return M

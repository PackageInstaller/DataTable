-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/setting/AirWorkSettingGuanQia.lua

module("logic.extensions.airworkshop.flow.defflow.view.setting.AirWorkSettingGuanQia", package.seeall)

local M = class("AirWorkSettingGuanQia")

function M:ctor(container)
	self._go = container.gameObject
	self._scrollRectGo = goutil.findChild(self._go, "scrollView")
	self._contentGo = goutil.findChild(self._scrollRectGo, "viewPort/content")
	self._itemGo = goutil.findChild(self._scrollRectGo, "viewPort/content/itemType")
	self._btnReset = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "btnReset"))
	self._btnSave = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "btnSave"))

	goutil.addChildToParent(self._itemGo, self._contentGo.transform.parent.gameObject)
	goutil.setActive(self._itemGo, false)
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.AIRWORKSHOP_TAG_CHANGE, self._tagChange, self)
	self._btnReset:AddClickListener(self._onClickBtnReset, self)
	self._btnSave:AddClickListener(self._onClickBtnSave, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.AIRWORKSHOP_TAG_CHANGE, self._tagChange, self)
	self._btnReset:RemoveClickListener()
	self._btnSave:RemoveClickListener()
end

function M:onEnter(mapData)
	self:_bindEvents()

	self._mapData = mapData
	self._tagList = self._mapData:getTags()

	for i, v in ipairs(self._tagList) do
		if not self._tagSelectedList then
			self._tagSelectedList = {}
		end

		self._tagSelectedList[v] = true
	end

	local coList = AirWorkShopConfig.instance:getConfigList(ConfigName.AirStudioTag)

	self._moList = {}

	local moType = {}

	for i, v in ipairs(coList) do
		if not moType[v.type] then
			moType[v.type] = {}
		end

		local mo = {}

		mo.isSelect = self:_isTagSelected(v.id)
		mo.co = v

		table.insert(moType[v.type], mo)
	end

	for i, v in pairs(moType) do
		table.insert(self._moList, v)
	end

	self:_setData()
end

function M:onExit()
	self:_unbindEvents()

	self._tagSelectedList = false
end

function M:OnDestroy()
	self:_unbindEvents()
end

function M:_isTagSelected(tagId)
	for i, v in ipairs(self._tagList or {}) do
		printWarn("===_isTagSelected=====", tagId, v)

		if tagId == v then
			return true
		end
	end

	return false
end

function M:_setData()
	for i, v in ipairs(self._itemViewList or {}) do
		v:removeToggleListener()
	end

	goutil.clearChildren(self._contentGo)

	self._itemViewList = {}

	for i, v in ipairs(self._moList) do
		local itemGo = goutil.cloneAndSetParent(self._itemGo, self._contentGo.transform, "itemType" .. i)
		local itemView = Astral.LuaComponentContainer.Add(itemGo, AirWorkSettingGuanQiaItem)

		goutil.setActive(itemGo, true)
		itemView:updateData(v)
		itemView:setHandler(self)
		table.insert(self._itemViewList, itemView)
	end

	self:_setToggleAlpha()
end

function M:checkTagCanSelect()
	local canSelect = true
	local count = 0

	for i, v in pairs(self._tagSelectedList or {}) do
		if v then
			count = count + 1
		end
	end

	canSelect = not (count > 1)

	return canSelect
end

function M:_tagChange(e, params)
	if not self._tagSelectedList then
		self._tagSelectedList = {}
	end

	local tagId = params.id
	local isSelect = params.isSelect

	self._tagSelectedList[tagId] = isSelect

	self:_setToggleAlpha()
end

function M:_setToggleAlpha()
	local count = 0

	for i, v in pairs(self._tagSelectedList or {}) do
		if v then
			count = count + 1
		end
	end

	for i, v in ipairs(self._itemViewList) do
		v:setAlpha(count > 1 and 0.2 or 1)
	end
end

function M:_saveModify()
	if not self._mapData then
		return
	end

	local tagIdList = {}

	for i, v in ipairs(self._itemViewList or {}) do
		local tags = v:getTagIds()

		for n, m in ipairs(tags) do
			table.insert(tagIdList, m)
		end
	end

	self._mapData:setTags(tagIdList)
end

function M:_onClickBtnReset()
	self._mapData:setTags(self._tagList)

	self._tagSelectedList = {}

	for i, v in ipairs(self._tagList) do
		self._tagSelectedList[v] = true
	end

	self:_setData()
end

function M:_onClickBtnSave()
	self:_saveModify()
	FloatWordMgr.instance:show(lang("tip_save_success"))
	ViewMgr.instance:close(ViewName.AirWorkShopSettingView)
end

return M

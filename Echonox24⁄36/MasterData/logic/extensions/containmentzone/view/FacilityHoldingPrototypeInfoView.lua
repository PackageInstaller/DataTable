-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingPrototypeInfoView.lua

module("logic.extensions.containmentzone.view.FacilityHoldingPrototypeInfoView", package.seeall)

local M = class("FacilityHoldingPrototypeInfoView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._cellItem = {}
	self._txtName = self:getText("facility_holding_prototype_info_view_-1761900094")
	self._txtNumber = self:getText("facility_holding_prototype_info_view_-1567726536")
	self._imgDegree = self:getImage("facility_holding_prototype_info_view_-1759790883")
	self._goPrototypeGroup = self:getGo("facility_holding_prototype_info_view_1025575697")
	self._goPrototypeItem = self:getGo("facility_holding_prototype_info_view_-1856063627")
	self._imgProtomer = self:getBigBg("facility_holding_prototype_info_view_-1223367722")
	self._scrollInfo = self:getUIComponent("facility_holding_prototype_info_view_-1266025023", UIComponentType.ScrollRect)
	self._scrollAdapter = self:getScrollRect("facility_holding_prototype_info_view_-1266025023")
	self._rectScrollContent = self:getRectTransform("facility_holding_prototype_info_view_-480291573")
	self._rectScrollViewport = self:getRectTransform("facility_holding_prototype_info_view_-1499070604")
	self._infoItemCellCollection = LocalReusableCollection.New(ProtomerInfoCell, 7)
	self._goInfoItem = self:getGo("facility_holding_prototype_info_view_-782815568")
	self._goTabRoot = self:getGo("facility_holding_prototype_info_view_-1440590427")
	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:addToggleTab(self:getUIComponent("facility_holding_prototype_info_view_-1324649006", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("facility_holding_prototype_info_view_-352963623", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("facility_holding_prototype_info_view_-1370543754", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("facility_holding_prototype_info_view_-235508083", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("facility_holding_prototype_info_view_-1119921065", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("facility_holding_prototype_info_view_-247485971", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("facility_holding_prototype_info_view_-864414490", UIComponentType.SpaceXToggle))
end

function M:destroyUI()
	self._guiAnimation = nil
	self._txtName = nil
	self._txtNumber = nil
	self._imgDegree = nil
	self._goPrototypeGroup = nil
	self._goPrototypeItem = nil
	self._imgProtomer = nil
	self._infoItemCellCollection = nil
	self._scrollInfo = nil
	self._scrollAdapter = nil
	self._goInfoItem = nil

	for key, value in pairs(self._cellItem or {}) do
		value:destroyUI()
	end

	self._goTabRoot = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	for key, value in pairs(self._cellItem or {}) do
		value:unbindEvents()
	end
end

function M:onEnter()
	self._activeIndex = -1

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Room)

	local info = self:getFirstParam()

	self.protomerId = info and info.protomerId or 1

	self:_updateShow(self.protomerId)
	self:_updateProtomerInfo(self.protomerId)
	self._toggleTabControl:selectTab(1)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
	self._scrollAdapter:AddOnValueChanged(self._onScrollValChanged, self)
end

function M:onExit()
	self._scrollAdapter:RemoveOnValueChanged()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Room)

	self._createCell = nil
	self.protomerId = nil
	self._activeIndex = nil

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")

	for key, value in pairs(self._cellItem or {}) do
		value:onExit()
	end

	self._infoItemCellCollection:clearAllInstance()
end

function M:onExitFinished()
	self._imgProtomer:ClearImage()
end

function M:setPage(tabIndex)
	if tabIndex == self._activeIndex then
		return
	end

	if self._activeIndex > 0 then
		self._blockNextScrollValChangeDetect = true

		self._scrollInfo:StopMovement()

		local contentHeigh = goutil.getHeight(self._rectScrollContent)
		local viewPortHeigh = goutil.getHeight(self._rectScrollViewport)
		local limit = contentHeigh - viewPortHeigh
		local posY = 0

		for i = 0, tabIndex - 2 do
			local tempTr = self._rectScrollContent:GetChild(i)

			posY = posY + goutil.getHeight(tempTr)
		end

		posY = limit < posY and limit or posY

		Astral.TransformUtil.SetAnchoredPos(self._rectScrollContent, 0, posY)
	end

	self._activeIndex = tabIndex
end

function M:_onScrollValChanged(v2)
	local val = v2.y

	if not self._lastScrollVal then
		self._lastScrollVal = val
	end

	if val < 0 then
		val = 0.01
	end

	if self._blockNextScrollValChangeDetect then
		self._blockNextScrollValChangeDetect = nil

		return
	end

	if math.abs(self._lastScrollVal - val) > 0.03 then
		self._lastScrollVal = val

		if not self._itemChase then
			self:fixItemCellChase()
		end

		local stopStep = 1

		if self._scrollInfo.velocity.y >= 0 then
			for i = 1, 7 do
				if self._itemChase[i + 1] and 1 - self._lastScrollVal > self._itemChase[i + 1].process then
					-- block empty
				elseif self._itemChase[i] and 1 - self._lastScrollVal < self._itemChase[i].process then
					stopStep = i

					break
				end
			end

			if stopStep - self._activeIndex > 1 then
				stopStep = self._activeIndex + 1
			end
		else
			for i = 7, 1, -1 do
				if self._itemChase[i - 1] and 1 - self._lastScrollVal < self._itemChase[i - 1].process then
					-- block empty
				elseif self._itemChase[i] and 1 - self._lastScrollVal > self._itemChase[i].process then
					stopStep = i

					break
				end
			end

			if self._activeIndex - stopStep > 1 then
				stopStep = self._activeIndex - 1
			end
		end

		self._activeIndex = stopStep

		local tab = self._toggleTabControl:getTab(stopStep)

		tab.IsOn = true
	end
end

function M:_updateShow(protomerId)
	self._txtName.text = ContainmentUtil.getProtomerName(protomerId)

	self:setProtomerBg(protomerId)

	self._txtNumber.text = ContainmentUtil.getProtomerSerialNumShow(protomerId)

	local cfgDegree = ContainmentConfig.instance:getProtomerDegreeCoByProtomerId(protomerId)

	IconLoader.setSprite(self._imgDegree, IconType.DynSpriteAtlas_Room, cfgDegree.icon)
	self:_updatePrototype(ContainmentConfig.instance:getProtomerPrototypeCoLstByProtomerId(protomerId))
end

function M:setProtomerBg(protomerId)
	ContainmentUtil.setProtomerBigBg(self._imgProtomer, protomerId)
end

function M:_updatePrototype(tablePrototypeLst)
	local count = #tablePrototypeLst

	while count > self._goPrototypeGroup.transform.childCount do
		goutil.cloneAndSetParent(self._goPrototypeItem, self._goPrototypeGroup.transform)
	end

	for i = 0, self._goPrototypeGroup.transform.childCount - 1 do
		local tmpGo = self._goPrototypeGroup.transform:GetChild(i).gameObject
		local show = i < #tablePrototypeLst

		if show then
			local prototypeIconUrl = tablePrototypeLst[i + 1].icon
			local prototypeName = tablePrototypeLst[i + 1].name
			local imgIcon = goutil.findChildImageComponent(tmpGo, "Image2")
			local txtIcon = goutil.findChildTextComponent(tmpGo, "txtHint4")

			IconLoader.setSprite(imgIcon, IconType.DynSpriteAtlas_Room, prototypeIconUrl)

			txtIcon.text = prototypeName
		end

		goutil.setActive(tmpGo, show)
	end
end

function M:_updateProtomerInfo(protomerId)
	local cfgInfo = ContainmentConfig.instance:getProtomerInfoById(protomerId)
	local code = cfgInfo.unlock
	local cfgUnlockInfo = ContainmentConfig.instance:getProtomerInfoUnlockCoByCode(code)

	self._infoDataLst = {}

	for index, value in ipairs(ContainmentEnum.ProtomerInfoMsgTitle) do
		if not self._infoDataLst[index] then
			self._infoDataLst[index] = {}
		end

		for _, subVal in pairs(cfgUnlockInfo[index] or {}) do
			table.insert(self._infoDataLst[index], subVal)
		end
	end

	while self._rectScrollContent.transform.childCount < 7 do
		local item = self._infoItemCellCollection:createInstance(self._goInfoItem)

		goutil.addChildToParent(item.mainGO, self._rectScrollContent.transform)
	end

	for i = 0, self._rectScrollContent.transform.childCount - 1 do
		local tempGo = self._rectScrollContent.transform:GetChild(i).gameObject
		local itemData = self._infoDataLst[i + 1]
		local show = #itemData > 0

		if show then
			local shower = Astral.LuaComponentContainer.Add(tempGo, ProtomerInfoCell)

			shower:setData(self.protomerId, i + 1, itemData, self)

			self._cellItem[tempGo.gameObject:GetInstanceID()] = shower
		end

		goutil.setActive(tempGo, show)

		local tab = self._toggleTabControl:getTab(i + 1)

		goutil.setActive(tab.gameObject, show)
	end
end

function M:fixItemCellChase()
	if not self._itemChase then
		self._itemChase = {}
	end

	local totalHeigh = 0

	for i = 0, self._rectScrollContent.transform.childCount - 1 do
		local tempGo = self._rectScrollContent.transform:GetChild(i).gameObject
		local itemData = self._infoDataLst[i + 1]
		local curHeigh = 0

		if #itemData > 0 then
			curHeigh = goutil.getHeight(tempGo.transform)
		end

		self._itemChase[i + 1] = {
			height = curHeigh
		}
		totalHeigh = totalHeigh + curHeigh
	end

	for id, value in pairs(self._itemChase) do
		local tmpHeigh = 0
		local subIndex = id
		local itemData = self._infoDataLst[id]

		while #itemData > 0 and self._itemChase[subIndex] do
			tmpHeigh = tmpHeigh + self._itemChase[subIndex].height
			subIndex = subIndex - 1
		end

		value.process = tmpHeigh / totalHeigh
	end
end

return M

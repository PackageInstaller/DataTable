-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newnotice/view/NoticeSelectCell.lua

module("logic.extensions.newnotice.view.NoticeSelectCell", package.seeall)

local M = class("NoticeSelectCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
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
	local mainGO = self:getMainGo()
	local registry = self:getRegistry()

	self._title1 = registry:findUIElement("left_tab_list_item_-1686091243", UIComponentType.Text)
	self._title2 = registry:findUIElement("left_tab_list_item_278459844", UIComponentType.Text)
	self._signText = registry:findUIElement("1&com_label_-1513538352", UIComponentType.Text)
	self._signText2 = registry:findUIElement("1&com_label_1979641530", UIComponentType.Text)
	self._goSign1 = registry:findUIElement("1&com_label_787295976")
	self._goSign2 = registry:findUIElement("1&com_label_1181881388")
	self._goSignParent = self._goSign1.transform.parent.gameObject
	self._button = mainGO:GetComponent(UIComponentType.SpaceXToggle)
end

function M:destroyUI()
	self.mainGO = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = nil
	end

	self._title1 = nil
	self._title2 = nil
	self._signText = nil
	self._button = nil
	self._data = nil
end

function M:bindEvents()
	self:_setEvent(true)
	self._button:AddListener(self._onSwitchNotice, self)
end

function M:unbindEvents()
	self:_setEvent(false)

	if self._button then
		self._button:RemoveListener()
	end
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.NEWNOTICE_SWITCH_NOTICE, self._onSwitchNoticeBtn, self)
	else
		GlobalDispatcher:removeEventListener(EventType.NEWNOTICE_SWITCH_NOTICE, self._onSwitchNoticeBtn, self)
	end
end

function M:_onSwitchNotice(go, isOn)
	if isOn then
		CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_generic_select, nil, nil, nil)
		GlobalDispatcher:dispatchEvent(EventType.NEWNOTICE_SWITCH_NOTICE, self._data.id)
	end
end

function M:_onSwitchNoticeBtn(e, id)
	local isOn = id == self._data.id

	if self._button.IsOn ~= isOn then
		self._button.IsOn = isOn
	end
end

function M:updateData(data)
	self._data = data
	self._title1.text = data.title
	self._title2.text = data.title

	goutil.setActive(self._goSign1, NewNoticeEnum.FlagActive[data.flag] and NewNoticeEnum.FlagColor[data.flag] == NewNoticeEnum.Color.Red)
	goutil.setActive(self._goSign2, NewNoticeEnum.FlagActive[data.flag] and NewNoticeEnum.FlagColor[data.flag] == NewNoticeEnum.Color.Gray or NewNoticeEnum.FlagActive[data.flag] == nil)
	goutil.setActive(self._goSignParent, true)

	self._signText.text = data.flagName or "NEW"
	self._signText2.text = data.flagName or "NEW"
end

return M

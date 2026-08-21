-- chunkname: @IQIGame\\UI\\Common\\Screen\\CommonScreenPopupLeftContent.lua

local UIViewObjectPool = require("IQIGame/UI/Common/UIViewObjectPool")
local CommonItemView = {
	choiceValue = 0
}

function CommonItemView.New(view, clickHandler)
	local Obj = Clone(CommonItemView)

	Obj:__Init(view, clickHandler)

	return Obj
end

function CommonItemView:__Init(view, clickHandler)
	self.gameObject = view
	self.clickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__OnButtonClickEventProxy()
		if self.clickHandler ~= nil then
			self.clickHandler(self.choiceValue)
		end
	end

	self.btn:GetComponent("Button").onClick:AddListener(self.__OnButtonClickEventProxy)
end

function CommonItemView:SetData(showData, value)
	self.choiceValue = value
	self.content:GetComponent("Text").text = showData.Content

	if LuaUtility.StrIsNullOrEmpty(showData.Icon) then
		self.icon.gameObject:SetActive(false)
	else
		self.icon.gameObject:SetActive(true)
		AssetUtil.LoadImage(self, CommonScreenModule.FormatScreenIconPath(showData.Icon), self.icon.gameObject:GetComponent("Image"))
	end
end

function CommonItemView:IsFree()
	return not self.gameObject.activeSelf
end

function CommonItemView:Hide()
	self.gameObject.gameObject:SetActive(false)
end

function CommonItemView:Show()
	self.gameObject.gameObject:SetActive(true)
end

function CommonItemView:Dispose()
	self.btn:GetComponent("Button").onClick:RemoveListener(self.__OnButtonClickEventProxy)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local ChoiceItem = {
	selectValue = 0,
	screenType = 0,
	screenSubType = 0
}

function ChoiceItem.New(view, selectHandler, childTable)
	local obj = Clone(childTable)

	obj:__Init(view, selectHandler)

	return obj
end

function ChoiceItem:__Init(view, selectHandler)
	self.gameObject = view
	self.itemSelectHandler = selectHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:__OnInit()
end

function ChoiceItem:__OnInit()
	logError("未重新 ChoiceItem:__OnDispose 方法")
end

function ChoiceItem:Show(screenType, commonScreenItemData)
	self.gameObject.gameObject:SetActive(true)

	self.screenType = screenType
	self.screenSubType = commonScreenItemData.screenType

	self:__OnShow(commonScreenItemData)
end

function ChoiceItem:__OnShow(commonScreenItemData)
	logError("未重新 ChoiceItem:__OnShow 方法")
end

function ChoiceItem:Hide()
	self.gameObject.gameObject:SetActive(false)
end

function ChoiceItem:Dispose()
	AssetUtil.UnloadAsset(self)
	self:__OnDispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function ChoiceItem:__OnDispose()
	logError("未重新 ChoiceItem:__OnDispose 方法")
end

function ChoiceItem:__OnSelect(value)
	if self.itemSelectHandler == nil then
		return
	end

	self.itemSelectHandler(self.screenSubType, value)
end

function ChoiceItem:ChangeSelectStatus(isSelect)
	self.selectTag.gameObject:SetActive(isSelect)
end

function ChoiceItem:IsFree()
	return not self.gameObject.gameObject.activeSelf
end

local SingleChoiceItem = Clone(ChoiceItem)

SingleChoiceItem.choiceView = nil

function SingleChoiceItem:__OnInit()
	self.choiceView = CommonItemView.New(self.choiceItem, function(_choiceValue)
		self:__OnSelect(_choiceValue)
	end)
end

function SingleChoiceItem:__OnShow(commonScreenItemData)
	self.titleText:GetComponent("Text").text = CommonScreenModule.GetScreenItemTitle(self.screenType, commonScreenItemData.screenType)

	local choiceValue = commonScreenItemData:GetSingleChoiceID()
	local showData = CommonScreenModule.GetScreenItemShowData(self.screenType, commonScreenItemData.screenType, choiceValue)

	self.choiceView:SetData(showData, choiceValue)
end

function SingleChoiceItem:__OnDispose()
	self.choiceView:Dispose()
end

local MultipleChoiceItem = Clone(ChoiceItem)

MultipleChoiceItem.choiceAllView = nil
MultipleChoiceItem.subChoicesPool = nil

function MultipleChoiceItem:__OnInit()
	self.subChoiceItem.gameObject:SetActive(false)

	self.choiceAllView = CommonItemView.New(self.choiceAllItem, function(_value)
		self:__OnSelect(_value)
	end)
	self.subChoicesPool = UIViewObjectPool.New(self.subChoiceItem, nil, function(_subChoiceView)
		return CommonItemView.New(_subChoiceView, function(_value)
			self:__OnSelect(_value)
		end)
	end)
end

function MultipleChoiceItem:__OnShow(commonScreenItemData)
	self.titleText:GetComponent("Text").text = CommonScreenModule.GetScreenItemTitle(self.screenType, commonScreenItemData.screenType)

	local singleID = commonScreenItemData:GetSingleChoiceID()

	if singleID == Constant.CommonScreenAllValueID then
		self:__ShowAll(commonScreenItemData)
	else
		self:__ShowMultiple(commonScreenItemData)
	end
end

function MultipleChoiceItem:__ShowAll(commonScreenItemData)
	self.subChoicesPool:ForItems(function(_item)
		_item:Hide()
	end)
	self.choiceAllView:Show()

	local showAllData = CommonScreenModule.GetScreenItemShowData(self.screenType, commonScreenItemData.screenType, Constant.CommonScreenAllValueID)

	self.choiceAllView:SetData(showAllData, Constant.CommonScreenAllValueID)
end

function MultipleChoiceItem:__ShowMultiple(commonScreenItemData)
	self.choiceAllView:Hide()
	self.subChoicesPool:ForItems(function(_item)
		_item:Hide()
	end)
	ForPairs(commonScreenItemData.choiceIDList, function(_, _choiceID)
		local choiceItem = self.subChoicesPool:GetFree(function(_item)
			return _item:IsFree()
		end)

		choiceItem:Show()

		local showData = CommonScreenModule.GetScreenItemShowData(self.screenType, commonScreenItemData.screenType, _choiceID)

		choiceItem:SetData(showData, _choiceID)
	end)
end

function MultipleChoiceItem:__OnDispose()
	self.choiceAllView:Dispose()
	self.subChoicesPool:Dispose(function(item)
		item:Dispose()
	end)
end

local Content = {
	screenType = 0,
	choiceItems = {}
}

function Content.New(view, callback)
	local obj = Clone(Content)

	obj:__Init(view, callback)

	return obj
end

function Content:__Init(view, callback)
	self.gameObject = view
	self.itemSelectHandler = callback

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.singleChoice.gameObject:SetActive(false)

	self.singleChoicePool = UIViewObjectPool.New(self.singleChoice, nil, function(_singleChoiceView)
		return ChoiceItem.New(_singleChoiceView, function(_screenSubType, _selectValue)
			self:__OnChoiceItemSelectHandler(_screenSubType, _selectValue)
		end, SingleChoiceItem)
	end)

	self.multipleChoice.gameObject:SetActive(false)

	self.multipleChoicePool = UIViewObjectPool.New(self.multipleChoice, nil, function(_multipleChoiceView)
		return ChoiceItem.New(_multipleChoiceView, function(_screenSubType, _selectValue)
			self:__OnChoiceItemSelectHandler(_screenSubType, _selectValue)
		end, MultipleChoiceItem)
	end)
end

function Content:Show(commonScreenData)
	self.singleChoicePool:ForItems(function(_item)
		_item:Hide()
	end)
	self.multipleChoicePool:ForItems(function(_item)
		_item:Hide()
	end)

	self.choiceItems = {}
	self.screenType = commonScreenData.screenType

	ForPairs(commonScreenData.itemsTable, function(_, _screenItemData)
		if _screenItemData.limitData.hideInScreenView then
			return
		end

		local item

		if _screenItemData.limitData.maxChoiceCount > 1 then
			item = self.multipleChoicePool:GetFree(function(_item)
				return _item:IsFree()
			end)
		else
			item = self.singleChoicePool:GetFree(function(_item)
				return _item:IsFree()
			end)
		end

		item:Show(self.screenType, _screenItemData)

		self.choiceItems[_screenItemData.screenType] = item
	end)
end

function Content:RefreshScreenItem(subScreenType, screenItemData)
	local choiceItem = self.choiceItems[subScreenType]

	choiceItem:Show(self.screenType, screenItemData)
end

function Content:Dispose()
	self.choiceItems = nil

	self.singleChoicePool:Dispose(function(_item)
		_item:Dispose()
	end)
	self.multipleChoicePool:Dispose(function(_item)
		_item:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function Content:__OnChoiceItemSelectHandler(screenSubType, selectValue)
	if self.itemSelectHandler == nil then
		return
	end

	self.itemSelectHandler(screenSubType, selectValue)
end

function Content:RefreshChoiceItemSelectTag(screenSubType)
	ForPairs(self.choiceItems, function(_screenSubType, _item)
		_item:ChangeSelectStatus(_screenSubType == screenSubType)
	end)
end

return Content

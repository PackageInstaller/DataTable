-- chunkname: @IQIGame\\UI\\Common\\GlobalBuff\\CommonGlobalBuffView.lua

local UIViewObjectPool = require("IQIGame/UI/Common/UIViewObjectPool")
local BuffItem = {}

function BuffItem.New(view, clickHandler)
	local obj = Clone(BuffItem)

	obj:__Init(view, clickHandler)

	return obj
end

function BuffItem:__Init(view, clickHandler)
	self.__gameObject = view
	self.__clickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.__gameObject, self)
	UIEventUtil.AddClickEventListener_Button(self, "ItemBtn", self.__OnItemBtnClickHandler)
end

function BuffItem:__OnItemBtnClickHandler()
	if self.__clickHandler == nil then
		return
	end

	self.__clickHandler(self)
end

function BuffItem:Show(buffCid)
	self.buffCid = buffCid

	self.__gameObject:SetActive(true)

	local cfg = GlobalBuffModule.GetBuffCfg(buffCid)

	self.NameText:GetComponent("Text").text = cfg.Name
end

function BuffItem:Hide()
	self.__gameObject:SetActive(false)
end

function BuffItem:IsFree()
	return not self.__gameObject.activeSelf
end

function BuffItem:Dispose()
	UIEventUtil.ClearEventListener(self)
	LuaCodeInterface.ClearOutlet(self.__gameObject, self)

	self.__gameObject = nil
end

local CommonGlobalBuffView = {
	__enableTips = true
}

function CommonGlobalBuffView.New(view)
	local obj = Clone(CommonGlobalBuffView)

	obj:__Init(view)

	return obj
end

function CommonGlobalBuffView:__Init(view)
	self.__gameObject = view
	self.__enableTips = true

	LuaCodeInterface.BindOutlet(self.__gameObject, self)
	self.BuffItemTemplate.gameObject:SetActive(false)

	self.buffItemPool = UIViewObjectPool.New(self.BuffItemTemplate, nil, function(_view)
		return BuffItem.New(_view, function(_buffItemView)
			self:__OnBuffItemClickHandler(_buffItemView)
		end)
	end)
end

function CommonGlobalBuffView:SetBackgroundActive(active)
	self.BackgroundRoot.gameObject:SetActive(active)
end

function CommonGlobalBuffView:SetTipsEnable(enable)
	self.__enableTips = enable
end

function CommonGlobalBuffView:__OnBuffItemClickHandler(buffItemView)
	if not self.__enableTips then
		return
	end

	local userData = {}

	userData.buffCid = buffItemView.buffCid
	userData.position = buffItemView.__gameObject.transform.position

	UIModule.Open(Constant.UIControllerName.BuffTipsUI, Constant.UILayer.UI, userData)
end

function CommonGlobalBuffView:Show(buffCidList)
	self.buffItemPool:ForItems(function(_item)
		_item:Hide()
	end)
	self.__gameObject:SetActive(true)

	self.__buffCidList = TryToTable(buffCidList, true, nil)

	if self.__buffCidList == nil then
		self.EmptyRoot.gameObject:SetActive(true)
		self.ScrollViewRoot.gameObject:SetActive(false)

		return
	end

	self.EmptyRoot.gameObject:SetActive(false)
	self.ScrollViewRoot.gameObject:SetActive(true)
	ForArray(self.__buffCidList, function(_index, _buffCid)
		local buffItemView = self.buffItemPool:GetFree(function(_item)
			return _item:IsFree()
		end)

		buffItemView:Show(_buffCid)
	end)
end

function CommonGlobalBuffView:Hide()
	self.__gameObject:SetActive(false)
end

function CommonGlobalBuffView:Dispose()
	self.buffItemPool:Dispose(function(item)
		item:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.__gameObject, self)

	self.__gameObject = nil
end

return CommonGlobalBuffView

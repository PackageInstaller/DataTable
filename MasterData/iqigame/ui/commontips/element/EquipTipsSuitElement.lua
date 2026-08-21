-- chunkname: @IQIGame\\UI\\CommonTips\\Element\\EquipTipsSuitElement.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local __suitItem = {}

function __suitItem.New(view)
	local obj = Clone(__suitItem)

	obj:__Init(view)

	return obj
end

function __suitItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function __suitItem:Hide()
	self.gameObject:SetActive(false)
end

function __suitItem:Show(title, content)
	self.suitTitleText:GetComponent("Text").text = title
	self.suitContentText:GetComponent("Text").text = content

	self.gameObject:SetActive(true)
end

function __suitItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local EquipTipsSuitElement = {}

EquipTipsSuitElement.SuitItem = __suitItem

function EquipTipsSuitElement.New(view)
	local obj = Clone(EquipTipsSuitElement)

	obj:__Init(view)

	return obj
end

function EquipTipsSuitElement:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.effectItemPrefab:SetActive(false)

	local effectItemPrefabParent = self.effectItemPrefab.transform.parent.transform

	self.suitItemPool = UIViewObjectPool.New(self.effectItemPrefab, effectItemPrefabParent, function(_view)
		return self.SuitItem.New(_view)
	end)

	self:__AddListeners()
end

function EquipTipsSuitElement:__AddListeners()
	return
end

function EquipTipsSuitElement:__RemoveListeners()
	return
end

function EquipTipsSuitElement:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function EquipTipsSuitElement:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function EquipTipsSuitElement:Dispose()
	self:__RemoveListeners()
	self.suitItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.suitItemPool = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function EquipTipsSuitElement:SetData(suitId, type)
	self.suitItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	local suitName = ""
	local suitConfigs = EquipModule.GetSuitNeedCount(suitId, type)

	for i = 1, #suitConfigs do
		local suitCfg = suitConfigs[i]

		if suitName == "" then
			suitName = suitCfg.Name
		end

		local suitItem = self.suitItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		suitItem:Show(suitCfg.EffectName, suitCfg.EquipTips)
	end

	if type == Constant.Equip.SuitType.Awaken then
		if table.len(suitConfigs) > 0 then
			self:Show()
		else
			self:Hide()
		end
	end

	self.suitNameText:GetComponent("Text").text = suitName
	self.suitNumText:GetComponent("Text").text = ""
end

return EquipTipsSuitElement

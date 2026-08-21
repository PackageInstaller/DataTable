-- chunkname: @IQIGame\\UI\\CommonTips\\SkillTipsContent\\SkillTipsHeadContent.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local __skillStarItem = {}

function __skillStarItem.New(view)
	local obj = Clone(__skillStarItem)

	obj:__Init(view)

	return obj
end

function __skillStarItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function __skillStarItem:Show(isOn)
	self.on:SetActive(isOn)
	self.off:SetActive(true)
	self.gameObject:SetActive(true)
end

function __skillStarItem:Hide()
	self.gameObject:SetActive(false)
end

function __skillStarItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local SkillTipsHeadContent = {}

SkillTipsHeadContent.StarItem = __skillStarItem

function SkillTipsHeadContent.New(view)
	local obj = Clone(SkillTipsHeadContent)

	obj:__Init(view)

	return obj
end

function SkillTipsHeadContent:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.stars1:SetActive(false)

	local starsParent = self.stars1.transform.parent

	self.starItemPool = UIViewObjectPool.New(self.stars1, starsParent, function(_view)
		return self.StarItem.New(_view)
	end)
	self.limitImgItemPool = UIViewObjectPool.New(self.limitImgPrefab, nil)

	function self.__onLockButtonClickEventProxy()
		self:__OnLockButtonClickEventHandler()
	end

	function self.__onLockSuccessEventProxy()
		self:__OnLockSuccessEventHandler()
	end

	self:__AddListeners()
end

function SkillTipsHeadContent:__AddListeners()
	self.lockBtn:GetComponent("Button").onClick:AddListener(self.__onLockButtonClickEventProxy)
	EventDispatcher.AddEventListener(EventID.LockSkillSucess, self.__onLockSuccessEventProxy)
end

function SkillTipsHeadContent:__RemoveListeners()
	self.lockBtn:GetComponent("Button").onClick:RemoveListener(self.__onLockButtonClickEventProxy)
	EventDispatcher.RemoveEventListener(EventID.LockSkillSucess, self.__onLockSuccessEventProxy)
end

function SkillTipsHeadContent:Dispose()
	self:__RemoveListeners()

	self.skillData = nil

	self.starItemPool:Dispose(function(_item)
		_item:Dispose()
	end)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function SkillTipsHeadContent:SetData(itemData, params)
	self.skillData = itemData.skillData

	local skillCfg = self.skillData:GetCfg()
	local quality = itemData:GetCfg().Quality

	AssetUtil.LoadImage(self, CommonTipsApi:GetQualityBackground(quality), self.qualityBg:GetComponent("Image"))
	UGUIUtil.SetText(self.skillNameText, CommonSkillTipsUIApi:GetSkillName(skillCfg.Name, quality))
	UGUIUtil.SetText(self.skillTypeText, CommonSkillTipsUIApi:GetSkillTypeText(skillCfg.ReleaseType))
	UGUIUtil.SetText(self.skillLv, CommonSkillTipsUIApi:GetSkillLevelText(self.skillData.lv))
	self:__RefreshCost(self.skillData)
	UGUIUtil.SetText(self.refineNumText, self.skillData.purifyLv)
	self:__RefreshSkillRange(skillCfg.SkillRangeID)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(itemData:GetCfg().Icon), self.skillImg:GetComponent("Image"))
	self:__RefreshSkillElement(self.skillData.skillCid)
	self:__RefreshSkillBreachStar(self.skillData)
	self:__RefreshSkillLockState(self.skillData.lock)
	self:__RefreshSkillLimit(self.skillData)

	if params.forceShowLock then
		LuaUtility.SetGameObjectShow(self.lockBtn, true)
	else
		LuaUtility.SetGameObjectShow(self.lockBtn, not params.forShow)
	end
end

function SkillTipsHeadContent:__RefreshCost(skillData)
	local attributeData = CfgAttributeTable[DiySkillModule.SkillCostAttrID]

	UGUIUtil.SetText(self.skillCostNumText, skillData:GetCfg().NeedCost)
end

function SkillTipsHeadContent:__RefreshSkillBreachStar(skillData)
	self.starItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	local maxStrengthenLv = DiySkillModule.GetSkillMaxStrengthenLevel(skillData:GetCfg().Id)

	for i = 1, maxStrengthenLv do
		local item = self.starItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		item:Show(i <= skillData.strengLv)
	end
end

function SkillTipsHeadContent:__RefreshSkillRange(skillRangeId)
	local needShowRange = skillRangeId > 0

	LuaCodeInterface.SetGameObjectShow(self.rangeImg, needShowRange)

	if not needShowRange then
		return
	end

	local path = UIGlobalApi.GetImagePath(CfgSkillRangeTable[skillRangeId].SkillRangeImg)

	AssetUtil.LoadImage(self, path, self.rangeImg:GetComponent("Image"))
end

function SkillTipsHeadContent:__RefreshSkillElement(skillCid)
	local skillElement = CfgSkillDetailTable[skillCid].Element
	local needShowElement = skillElement > 0

	LuaCodeInterface.SetGameObjectShow(self.skillElementImg, needShowElement)

	if not needShowElement then
		return
	end

	local path = CommonSkillTipsUIApi:GetSkillElementIconPath(skillElement)

	AssetUtil.LoadImage(self, path, self.skillElementImg:GetComponent("Image"))
end

function SkillTipsHeadContent:__RefreshSkillLockState(isLock)
	LuaCodeInterface.SetGameObjectShow(self.on, isLock)
	LuaCodeInterface.SetGameObjectShow(self.off, not isLock)
end

function SkillTipsHeadContent:__RefreshSkillLimit(skillData)
	local skillCfg = skillData:GetCfg()
	local limitDatas = {}

	for i = 1, #skillCfg.ForceLimit do
		if skillCfg.ForceLimit[i] ~= 0 then
			table.insert(limitDatas, {
				type = Constant.SkillLimitType.Force,
				value = skillCfg.ForceLimit[i]
			})
		end
	end

	for i = 1, #skillCfg.ProfessionLimit do
		if skillCfg.ProfessionLimit[i] ~= 0 then
			table.insert(limitDatas, {
				type = Constant.SkillLimitType.Profession,
				value = skillCfg.ProfessionLimit[i]
			})
		end
	end

	for i = 1, #skillCfg.ElementLimit do
		if skillCfg.ElementLimit[i] ~= 0 then
			table.insert(limitDatas, {
				type = Constant.SkillLimitType.Element,
				value = skillCfg.ElementLimit[i]
			})
		end
	end

	self.limitImgItemPool:ForItems(function(_item)
		LuaUtility.SetGameObjectShow(_item, false)
	end)
	LuaUtility.SetGameObjectShow(self.limitItemParent, #limitDatas > 0)

	for i = 1, #limitDatas do
		local limitImgItem = self.limitImgItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		LuaUtility.SetGameObjectShow(limitImgItem, true)
		AssetUtil.LoadImage(self, CommonSkillTipsUIApi:GetSkillLimitImg(limitDatas[i].type, limitDatas[i].value), limitImgItem:GetComponent("Image"))
	end
end

function SkillTipsHeadContent:__OnLockButtonClickEventHandler()
	RoleDevelopmentModule.RoleSkillLock({
		self.skillData.id
	})
end

function SkillTipsHeadContent:__OnLockSuccessEventHandler()
	if self.skillData == nil then
		return
	end

	self.skillData = WarehouseModule.FindItem(self.skillData.id).skillData

	self:__RefreshSkillLockState(self.skillData.lock)
end

return SkillTipsHeadContent

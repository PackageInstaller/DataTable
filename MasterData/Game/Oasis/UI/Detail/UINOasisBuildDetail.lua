local UINOasisBuildDetail = class("UINOasisBuildDetail", UIBaseNode)
local base = UIBaseNode
local UINStOUpItem = require("Game.StrategyOverview.UI.Side.UINStOUpItem")
local UINStOConsumeItem = require("Game.StrategyOverview.UI.Side.UINStOConsumeItem")
local UINStOUnlockConditionItem = require("Game.StrategyOverview.UI.Side.UINStOUnlockConditionItem")

function UINOasisBuildDetail:ctor(oasisMain, resLoader, factoryTable)
  self.oasisMain = oasisMain
  self.resLoader = resLoader
  self.factoryTable = factoryTable
end

function UINOasisBuildDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Preview, self, self._OnClickPreview)
  UIUtil.AddButtonListener(self.ui.btn_Upgrade, self, self._OnClickUpgrade)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.HideOasisBuildDetail)
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self.HideOasisBuildDetail)
  self.ui.upItem:SetActive(false)
  self.upItemPool = UIItemPool.New(UINStOUpItem, self.ui.upItem)
  self.ui.consumeItem:SetActive(false)
  self.consumeItemPool = UIItemPool.New(UINStOConsumeItem, self.ui.consumeItem)
  self.ui.conditionItem:SetActive(false)
  self.conditionItemPool = UIItemPool.New(UINStOUnlockConditionItem, self.ui.conditionItem)
end

function UINOasisBuildDetail:InitOasisBuildDetail(buildingData, isInfo)
  self:Show()
  self.buildingData = buildingData
  self.isInfo = isInfo
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(buildingData.dynData.stcData.name)
  self.ui.tex_Intro.text = LanguageUtil.GetLocaleText(buildingData.dynData.stcData.intro_long)
  self.ui.tex_EnName.text = buildingData.dynData.stcData.name_en
  local path = PathConsts:GetOasisBuildingIconPath(buildingData.dynData.icon_res)
  self.ui.img_Pic.enabled = false
  self.resLoader:LoadABAssetAsync(path, function(texture)
    if texture == nil then
      return
    end
    self.ui.img_Pic.texture = texture
    self.ui.img_Pic.enabled = true
  end)
  self.ui.img_Icon.sprite = CRH:GetSprite(buildingData.dynData.stcData.small_icon)
  self.ui.tex_Intro.gameObject:SetActive(isInfo)
  self:RefreshOasisBuildDetailState()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack(true)
end

function UINOasisBuildDetail:_RefreshNum()
  local type_id = self.buildingData.dynData.stcData.type_id
  local typeIdList = ConfigData.building.buildingTypeDic[type_id]
  if typeIdList == nil then
    error("Cant get ConfigData.building.buildingTypeDic, type_id = " .. tostring(type_id))
    return
  end
  local num = 0
  for k, buildId in ipairs(typeIdList) do
    if PlayerDataCenter.AllBuildingData.built[buildId] ~= nil then
      num = num + 1
    end
  end
  self.ui.tex_Count:SetIndex(0, tostring(num), tostring(#typeIdList))
end

function UINOasisBuildDetail:_RefreshLogic()
  local buffDict = self.buildingData:GetNextLevelBuffItem()
  local isMaxLevel = self.buildingData:IsMaxLevel()
  self.upItemPool:HideAll()
  for k, v in ipairs(buffDict) do
    if v ~= nil then
      local upItem = self.upItemPool:GetOne()
      local nextInfoValue
      if self.isInfo then
        nextInfoValue = nil
      else
        nextInfoValue = v.nextInfoValue
      end
      upItem:InitStOUpItem(v.currentInfo, v.curValue, nextInfoValue, isMaxLevel)
    end
  end
  local customLogicList
  if self.isInfo then
    customLogicList = self.buildingData:GetBuildCustomLogicInfo()
  else
    local nextLevel = (self.buildingData.level or 0) + 1
    customLogicList = self.buildingData:GetBuildCustomLogicInfo()
  end
  for k, v in ipairs(customLogicList) do
    if not string.IsNullOrEmpty(v) then
      local upItem = self.upItemPool:GetOne()
      upItem:InitStOUpItem(v, "", "", isMaxLevel)
    end
  end
  self.ui.effList:SetActive(0 < #self.upItemPool.listItem)
end

function UINOasisBuildDetail:RefreshOasisBuildDetailState()
  if not self.active then
    return
  end
  self.ui.consume:SetActive(false)
  self.ui.unlockCondition:SetActive(false)
  local buildingData = self.buildingData
  local curLv = buildingData.level or 0
  self.ui.tex_Level.text = string.format("%02d", curLv)
  self:_RefreshNum()
  self:_RefreshLogic()
  if self.isInfo then
    return
  end
  local nextLevel = curLv + 1
  if buildingData:IsMaxLevel() then
  else
    local nextLevelCfg = buildingData.levelConfig[nextLevel]
    if CheckCondition.CheckLua(nextLevelCfg.pre_condition, nextLevelCfg.pre_para1, nextLevelCfg.pre_para2) then
      self.ui.consume:SetActive(true)
      self:_RefreshConsume(buildingData)
      local canUpgrade = buildingData:CanUpgrade()
      self.ui.btn_Upgrade.interactable = canUpgrade
    else
      self.ui.unlockCondition:SetActive(true)
      self:_RefreshCondition(buildingData)
    end
  end
end

function UINOasisBuildDetail:_RefreshConsume(buildingData)
  self.consumeItemPool:HideAll()
  local costList = buildingData:GetNextLevelCostItem()
  for k, cost in ipairs(costList) do
    local consumeItem = self.consumeItemPool:GetOne()
    consumeItem:InitStOConsumeItem(cost.resId, cost.resCount)
  end
end

function UINOasisBuildDetail:_RefreshCondition(buildingData)
  self.conditionItemPool:HideAll()
  local unlockTab = buildingData:GetPreBuildingLevelInfo()
  for k, condition in ipairs(unlockTab) do
    local conditionItem = self.conditionItemPool:GetOne()
    conditionItem:InitStOUnlockConditionItem(condition.unlock, condition.lockReason)
  end
end

function UINOasisBuildDetail:_OnClickPreview()
  if self.oasisMain ~= nil then
    self.oasisMain.buildPreviewNode:Show()
    self.oasisMain.buildPreviewNode:InitBuildLogicLvPreview(self.buildingData, nil)
  end
  if self.factoryTable ~= nil then
    self.factoryTable.buildPreviewNode:Show()
    self.factoryTable.buildPreviewNode:InitBuildLogicLvPreview(self.buildingData, nil)
  end
end

function UINOasisBuildDetail:_OnClickUpgrade()
  if self.oasisMain ~= nil then
    self.oasisMain.oasisCtrl:StartUpgrade(self.buildingData)
  end
  if self.factoryTable ~= nil then
    self.factoryTable.levelUpFunc(self.buildingData)
  end
end

function UINOasisBuildDetail:BackAction()
  self:Hide()
end

function UINOasisBuildDetail:HideOasisBuildDetail()
  UIUtil.OnClickBackByUiTab(self)
end

function UINOasisBuildDetail:OnShow()
  base.OnShow(self)
  AudioManager:PlayAudioById(1067)
end

function UINOasisBuildDetail:OnHide()
  AudioManager:PlayAudioById(1068)
  base.OnHide(self)
end

function UINOasisBuildDetail:OnDelete()
  self.upItemPool:DeleteAll()
  self.consumeItemPool:DeleteAll()
  self.conditionItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINOasisBuildDetail

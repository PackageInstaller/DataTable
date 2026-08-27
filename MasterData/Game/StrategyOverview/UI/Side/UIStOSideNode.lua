local UIStOSideNode = class("UIStOSideNode", UIBaseNode)
local base = UIBaseNode
local UINStOUnlockConditionItem = require("Game.StrategyOverview.UI.Side.UINStOUnlockConditionItem")
local UINStOConsumeItem = require("Game.StrategyOverview.UI.Side.UINStOConsumeItem")
local UINStOUpItem = require("Game.StrategyOverview.UI.Side.UINStOUpItem")
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local cs_MessageCommon = CS.MessageCommon

function UIStOSideNode:ctor(uiStO)
  self.uiStO = uiStO
end

function UIStOSideNode:OnInit(uiStO)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Upgrade, self, self._OnClickUpgrade)
  UIUtil.AddButtonListener(self.ui.btn_Preview, self, self._OnClickPreview)
  UIUtil.AddButtonListener(self.ui.btn_JumpNext, self, self._OnClickNextJump)
  self.ui.conditionItem:SetActive(false)
  self.conditionItemPool = UIItemPool.New(UINStOUnlockConditionItem, self.ui.conditionItem)
  self.ui.consumeItem:SetActive(false)
  self.consumeItemPool = UIItemPool.New(UINStOConsumeItem, self.ui.consumeItem)
  self.ui.rewardItem:SetActive(false)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem)
  self.ui.uPItem:SetActive(false)
  self.upItemPool = UIItemPool.New(UINStOUpItem, self.ui.uPItem)
  self.ui.deffSprite = self.ui.img_Career.sprite
end

function UIStOSideNode:InitStOSideNode(buildingData)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(buildingData.name)
  self.ui.tex_Intro.text = LanguageUtil.GetLocaleText(buildingData.dynData.stcData.intro)
  local careerCfg = ConfigData.career[buildingData.dynData.stcData.strategy_career]
  if careerCfg == nil then
    self.ui.img_Career.sprite = self.ui.deffSprite
  else
    self.ui.img_Career.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  end
  self:RefreshStOSideData(buildingData)
end

function UIStOSideNode:RefreshStOSideData(buildingData)
  self.buildingData = buildingData
  self:RefreshStOSide()
end

function UIStOSideNode:RefreshStOSide()
  local buildingData = self.buildingData
  self.ui.consume:SetActive(false)
  self.ui.unlockCondition:SetActive(false)
  self.ui.isMax:SetActive(false)
  local curLv = buildingData.level or 0
  local nextLevel = curLv + 1
  self.ui.tex_Level:SetIndex(0, tostring(buildingData.level or 0), tostring(buildingData.maxLevel))
  self:_RefreshReward()
  self:_RefreshLogic()
  if buildingData.isBuild then
    if buildingData:IsMaxLevel() then
      self.ui.isMax:SetActive(true)
    else
      local nextLevelCfg = buildingData.levelConfig[nextLevel]
      if CheckCondition.CheckLua(nextLevelCfg.pre_condition, nextLevelCfg.pre_para1, nextLevelCfg.pre_para2) then
        local canUpgrade = buildingData:CanUpgrade()
        self.ui.btn_Upgrade.interactable = canUpgrade
        self.ui.consume:SetActive(true)
        self:_RefreshConsume(buildingData)
      else
        self.ui.unlockCondition:SetActive(true)
        self:_RefreshCondition(buildingData)
      end
    end
  else
    local unlock = buildingData.dynData:Unlock()
    if unlock then
      local canBuild = buildingData.dynData:CanBuild()
      self.ui.btn_Upgrade.interactable = canBuild
      self.ui.consume:SetActive(true)
      self:_RefreshConsume(buildingData)
    else
      self.ui.unlockCondition:SetActive(true)
      self:_RefreshCondition(buildingData)
    end
  end
  self:__SetNextJumpBtnState()
end

function UIStOSideNode:_RefreshCondition(buildingData)
  self.conditionItemPool:HideAll()
  local unlockTab = buildingData:GetPreBuildingLevelInfo()
  for k, condition in ipairs(unlockTab) do
    local conditionItem = self.conditionItemPool:GetOne()
    conditionItem:InitStOUnlockConditionItem(condition.unlock, condition.lockReason)
  end
end

function UIStOSideNode:_RefreshConsume(buildingData)
  self.consumeItemPool:HideAll()
  local costList = buildingData:GetNextLevelCostItem()
  for k, cost in ipairs(costList) do
    local consumeItem = self.consumeItemPool:GetOne()
    consumeItem:InitStOConsumeItem(cost.resId, cost.resCount)
  end
end

function UIStOSideNode:_RefreshReward()
  self.ui.rewardNode:SetActive(false)
  local isMaxLevel = self.buildingData:IsMaxLevel()
  local targetLelve = self.buildingData.level or 0
  if not isMaxLevel then
    targetLelve = targetLelve + 1
  end
  local reward = self.buildingData:GetLevelUpgradeReward(targetLelve)
  self.rewardItemPool:HideAll()
  if reward == nil or table.count(reward) == 0 then
    return
  end
  self.ui.rewardNode:SetActive(true)
  self.ui.tex_upBtn:SetIndex(1)
  self.ui.tex_upTip:SetIndex(1)
  for itemId, count in pairs(reward) do
    local rewardItem = self.rewardItemPool:GetOne()
    local itemCfg = ConfigData.item[itemId]
    rewardItem:InitItemWithCount(itemCfg, count)
    rewardItem:SetPickedUIActive(isMaxLevel)
  end
end

function UIStOSideNode:_RefreshLogic()
  self.ui.boostNode:SetActive(false)
  local buffDict = self.buildingData:GetNextLevelBuffItem()
  local isMaxLevel = self.buildingData:IsMaxLevel()
  local nextLevel
  if isMaxLevel then
    nextLevel = self.buildingData.maxLevel
  else
    nextLevel = (self.buildingData.level or 0) + 1
  end
  local customLogicList = self.buildingData:GetBuildCustomLogicInfo(nextLevel)
  if #buffDict == 0 and #customLogicList == 0 then
    return
  end
  self.ui.boostNode:SetActive(true)
  self.ui.tex_upBtn:SetIndex(0)
  self.ui.tex_upTip:SetIndex(0)
  self.upItemPool:HideAll()
  for k, v in ipairs(buffDict) do
    if v ~= nil then
      local upItem = self.upItemPool:GetOne()
      upItem:InitStOUpItem(v.currentInfo, v.curValue, v.nextInfoValue, isMaxLevel)
    end
  end
  for k, v in ipairs(customLogicList) do
    local upItem = self.upItemPool:GetOne()
    upItem:InitStOUpItem(v, "", "", isMaxLevel)
  end
end

function UIStOSideNode:_OnClickUpgrade()
  self.uiStO.stOCtrl:StOTechUpgrade(self.buildingData)
end

function UIStOSideNode:_OnClickPreview()
  self.uiStO:ShowStOPreview(self.buildingData)
end

function UIStOSideNode:OnBuildUpgradeStOSide(buildingData)
  if self.buildingData.id ~= buildingData.id then
    return
  end
  self:RefreshStOSideData(buildingData)
end

function UIStOSideNode:SetNextJumpCallback(checkFunc, selectFunc)
  self._nextJumpCheckFunc = checkFunc
  self._nextJumpRunFunc = selectFunc
  self:__SetNextJumpBtnState()
end

function UIStOSideNode:__SetNextJumpBtnState()
  if self._nextJumpCheckFunc ~= nil and self._nextJumpRunFunc ~= nil then
    self.ui.btn_JumpNext.gameObject:SetActive(self._nextJumpCheckFunc())
  else
    self.ui.btn_JumpNext.gameObject:SetActive(false)
  end
end

function UIStOSideNode:_OnClickNextJump()
  if self._nextJumpRunFunc ~= nil then
    self._nextJumpRunFunc()
  end
end

function UIStOSideNode:OnDelete()
  self.conditionItemPool:DeleteAll()
  self.consumeItemPool:DeleteAll()
  self.upItemPool:DeleteAll()
  base.OnDelete(self)
end

return UIStOSideNode

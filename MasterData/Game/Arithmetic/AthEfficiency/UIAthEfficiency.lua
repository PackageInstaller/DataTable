local UIAthEfficiency = class("UIAthEfficiency", UIBaseWindow)
local base = UIBaseWindow
local UINAthList = require("Game.Arithmetic.AthList.UINAthList")
local UINAthEfccQuickSelect = require("Game.Arithmetic.AthEfficiency.UINAthEfccQuickSelect")
local AthEnum = require("Game.Arithmetic.ArthmeticEnum")
local AthUtil = require("Game.Arithmetic.AthUtil")
local cs_MessageCommon = CS.MessageCommon

function UIAthEfficiency:OnInit()
  UIUtil.SetTopStatus(self, self.__OnClickBack, nil, AthUtil.ShowATHInfoFunc)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.__OnClickUpgrade)
  UIUtil.AddButtonListener(self.ui.btn_Switch, self, self.__OnClickAutoSelect)
  self.ui.btn_Switch.gameObject:SetActive(true)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
  self.athListNode = UINAthList.New(true)
  self.athListNode:Init(self.ui.aTHListNode)
  self.quickSelectNode = UINAthEfccQuickSelect.New()
  self.quickSelectNode:Init(self.ui.quickSwitchNode)
  self.quickSelectNode:InitAthEfccQuickSelect(BindCallback(self, self.OnAthEfccQuickSelect))
  self.quickSelectNode:Hide()
  self.athSelectedDic = {}
  self.athExpAdd = 0
  self.curEfcc = 0
  self._onAthLockPreFunc = BindCallback(self, self._OnAthLockPre)
  MsgCenter:AddListener(eMsgEventId.OnAthLockPre, self._onAthLockPreFunc)
end

function UIAthEfficiency:InitAthAthEfcc(heroData, resLoader, heroResLoader, switchHeroFunc)
  self.switchHeroFunc = switchHeroFunc
  self.resLoader = resLoader
  self:__SelectHero(heroData, heroResLoader)
end

function UIAthEfficiency:__SelectHero(heroData, heroResLoader)
  self.heroData = heroData
  DestroyUnityObject(self.bigImgGameObject)
  heroResLoader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(heroData:GetResPicName()), function(prefab)
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
  end)
  self.ui.tween_Hero:DORestart()
  self.ui.tex_HeroName.text = heroData:GetName()
  self.athSelectedDic = {}
  self.athListNode.athListArea:SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
  self.athListNode:InitAthListNode(heroData, self.resLoader, true, BindCallback(self, self.__OnClickAthItem))
  self.athListNode:ShowAthListDecomposeBtn(false)
  self.athMatUpNode = self.athListNode.athListArea.athScrollList:GetAthScrollListMatUpNode()
  self.athMatUpNode:SetRefreshAthSlotAddExpFunc(BindCallback(self, self.RefreshAthSlotAddExp))
  self:RefreshCurAthEfficency()
end

function UIAthEfficiency:RefreshCurAthEfficency()
  local curLevel, curExp = PlayerDataCenter.allAthData:GetHeroAthSlotInfo(self.heroData.dataId)
  self.curLevel = curLevel
  self.curExp = curExp
  self.athSelectedDic = {}
  self.athExpAdd = 0
  self.athListNode.athListArea:SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
  self.athMatUpNode:CleanAllAthUpMat()
  self.athMatUpNode:InitAthMatUp(BindCallback(self, self.__OnMatExpAdd), ConfigData.item.growUpIds[eItemActionType.AthAreaExp])
  local maxLevel = ConfigData.ath_efficiency.maxLevel
  if curLevel >= maxLevel then
    self.ui.tex_IsMax:SetActive(true)
    self.ui.unMax:SetActive(false)
    local maxLvCfg = ConfigData.ath_efficiency[maxLevel]
    local efcc = maxLvCfg.attribute_promote / 1000
    self.curEfcc = efcc
    self.curEfccStr = string.format("%.1f", efcc)
    self.ui.tex_CurValue:SetIndex(0, self.curEfccStr)
  else
    self.ui.tex_IsMax:SetActive(false)
    self.ui.unMax:SetActive(true)
    local lvCfg = ConfigData.ath_efficiency[curLevel]
    if lvCfg == nil then
      error("Can't get ath_efficiency cfg, level = " .. tostring(curLevel))
      return
    end
    local curEfcc = lvCfg.attribute_promote / 1000
    self.curEfcc = curEfcc
    self.curEfccStr = string.format("%.1f", curEfcc)
    self.ui.tex_CurValue:SetIndex(0, self.curEfccStr)
  end
  self:RefreshAthSlotAddExp()
end

function UIAthEfficiency:RefreshAthSlotAddExp()
  local addExp = self:__GetAddExp()
  self.ui.btn_Confirm.interactable = 0 < addExp
  self.ui.tex_AddEXP:SetIndex(0, tostring(addExp))
  local testLevel, nextExp, nextTotalExp = PlayerDataCenter.allAthData:TryAddAthAreaExp(addExp, self.curLevel, self.curExp)
  local toMaxLevelExp = -self.curExp
  for i = self.curLevel, ConfigData.ath_efficiency.maxLevel - 1 do
    local levelCfg = PlayerDataCenter.allAthData:GetAthEfficiencyCfg(i)
    toMaxLevelExp = toMaxLevelExp + levelCfg.shard
  end
  self.ableAddExp = toMaxLevelExp - addExp
  self.athMatUpNode:SetAthAddExpLimt(toMaxLevelExp, addExp, function()
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_AreaUpExpIsFull))
  end)
  local targetLvCfg = PlayerDataCenter.allAthData:GetAthEfficiencyCfg(testLevel)
  local targetEfcc = targetLvCfg.attribute_promote / 1000
  self.ui.tex_NextValue:SetIndex(0, string.format("%.1f", targetEfcc))
  if ConfigData.ath_efficiency.maxLevel == testLevel then
    self.ui.tex_EXP:SetIndex(1)
  else
    self.ui.tex_EXP:SetIndex(0, tostring(nextExp), tostring(nextTotalExp))
  end
  self.ui.img_Add.fillAmount = nextExp / nextTotalExp
  self.ui.tex_NextValue.gameObject:SetActive(false)
  if testLevel > self.curLevel then
    self.ui.tex_NextValue.gameObject:SetActive(true)
    local addValue = (targetEfcc - self.curEfcc) * 100
    addValue = string.format("%.0f", addValue)
    self.ui.tex_Ratio:SetIndex(0, tostring(math.floor(self.curEfcc * 100)), tostring(addValue))
  else
    self.ui.tex_Ratio:SetIndex(1, tostring(math.floor(self.curEfcc * 100)))
  end
end

function UIAthEfficiency:__OnMatExpAdd(addExp)
  self.matExpAdd = addExp
  self:RefreshAthSlotAddExp()
end

function UIAthEfficiency:__OnAthExpAdd(addExp)
  self.athExpAdd = math.max(self.athExpAdd + addExp, 0)
  self:RefreshAthSlotAddExp()
end

function UIAthEfficiency:__GetAddExp()
  return (self.matExpAdd or 0) + (self.athExpAdd or 0)
end

function UIAthEfficiency:__OnClickAutoSelect()
  self.quickSelectNode:Show()
end

function UIAthEfficiency:OnAthEfccQuickSelect(quickSelectEnum)
  self:RefreshCurAthEfficency()
  if quickSelectEnum ~= nil and quickSelectEnum < AthEnum.AthEfccQuickSelectEnum.Material then
    local quality = quickSelectEnum + 2
    if self.ableAddExp > 0 then
      local tempList = self.athListNode.athListArea.athScrollList:GetAthScrollListCurAthList()
      local athList = {}
      for k, athData in ipairs(tempList) do
        if not athData.lockUnlock then
          local athQualityId = athData:GetAthQuality()
          local qualityOk = quality == athQualityId
          if qualityOk then
            table.insert(athList, athData)
          end
        end
      end
      table.sort(athList, function(a, b)
        local qualityA = a:GetAthQuality()
        local qualityB = b:GetAthQuality()
        if qualityA == qualityB then
          return a.uid < b.uid
        else
          return qualityA < qualityB
        end
      end)
      for k, athData in ipairs(athList) do
        if self.ableAddExp > 0 then
          local exp = athData.athCfg.shard
          self.athSelectedDic[athData.uid] = true
          self:__OnAthExpAdd(exp)
        else
          break
        end
      end
    end
  elseif quickSelectEnum == AthEnum.AthEfccQuickSelectEnum.Material then
    local matList = {}
    local matItemList = self.athMatUpNode:GetAthMatItemList()
    for k, v in pairs(matItemList) do
      local matItemId = v:GetHeroLvUpItemId()
      local itemData = PlayerDataCenter.itemDic[matItemId]
      if itemData ~= nil then
        table.insert(matList, {
          itemId = matItemId,
          exp = itemData:GetActionArg(1),
          count = itemData:GetCount(),
          matItem = v
        })
      end
    end
    table.sort(matList, function(a, b)
      return a.exp > b.exp
    end)
    local hasOne = false
    for k, data in ipairs(matList) do
      for i = 1, data.count do
        if self.ableAddExp > 0 then
          local complete = data.matItem:TryAddOne()
          if complete then
            hasOne = true
          end
        else
          break
        end
      end
    end
    if hasOne then
      AudioManager:PlayAudioById(1064)
    end
  end
  self.athListNode.athListArea:SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
  self.athListNode:RefillCurAthSortList(true)
end

function UIAthEfficiency:_ShowAthDetailFloat(athData)
  UIManager:ShowWindowAsync(UIWindowTypeID.AthItemDetailFloat, function(window)
    if window == nil then
      return
    end
    window:InitAthDetailFloat(athData)
  end)
end

function UIAthEfficiency:__OnClickAthItem(athItem)
  local athData = athItem:GetAthItemData()
  if athData.lockUnlock then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_CantSelectLockAth))
    self:_ShowAthDetailFloat(athData)
    return
  end
  local exp = athData.athCfg.shard
  if self.athSelectedDic[athData.uid] == nil then
    if self.ableAddExp <= 0 then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_AreaUpExpIsFull))
      return
    end
    self.athSelectedDic[athData.uid] = true
    self:__OnAthExpAdd(exp)
    athItem:SetAthItemSelect(true, true)
    self:_ShowAthDetailFloat(athData)
  else
    self.athSelectedDic[athData.uid] = nil
    self:__OnAthExpAdd(-exp)
    athItem:SetAthItemSelect(false)
  end
  self.athListNode.athListArea:SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
end

function UIAthEfficiency:__OnClickUpgrade()
  if self:__GetAddExp() <= 0 then
    return
  end
  local itemDic = self.athMatUpNode:GetAthMatExpAddItemDic()
  local athDic = self.athSelectedDic
  self.oldHeroPower = self.heroData:GetFightingPower()
  if self.__onUpComplete == nil then
    self.__onUpComplete = BindCallback(self, self.OnAthAreaUpgradeComplete)
  end
  self.oldEfccStr = self.curEfccStr
  local hasOrangeAth = false
  for uid, v in pairs(athDic) do
    local athData = PlayerDataCenter.allAthData.athDic[uid]
    if athData:GetAthQuality() == eItemQualityType.Orange then
      hasOrangeAth = true
    end
  end
  
  local function requestFunc()
    self.athNetwork:CS_ATH_SlotUpgrade(self.heroData.dataId, itemDic, athDic, self.__onUpComplete)
  end
  
  if hasOrangeAth then
    cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(TipContent.Ath_EfficiencyUpContainOrangeAth), requestFunc, nil)
  else
    requestFunc()
  end
end

function UIAthEfficiency:OnAthAreaUpgradeComplete()
  self:RefreshCurAthEfficency()
  if self.oldEfccStr ~= self.curEfccStr then
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonUpgradeTips, function(window)
      if window == nil then
        return
      end
      window:InitAthEffiUpSuccess(self.oldEfccStr, self.curEfccStr)
      local newHeroPower = self.heroData:GetFightingPower()
      window:SetBackClickAction(BindCallback(self, self.__ShowHeroPowerUpSuccess, newHeroPower))
    end)
  end
end

function UIAthEfficiency:__ShowHeroPowerUpSuccess(newPower)
  if newPower ~= self.oldHeroPower then
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroPowerUpSuccess, function(win)
      if win ~= nil then
        win:InitHeroPowerUpSuccess(self.oldHeroPower, newPower)
      end
    end)
  end
end

function UIAthEfficiency:__OnClickBack()
  self:Delete()
end

function UIAthEfficiency:__OnClickLeftArrow()
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = self.switchHeroFunc(-1)
    self:__SelectHero(newHeroData, reUseBigImgResloader)
  end
end

function UIAthEfficiency:__OnClickRightArrow()
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = self.switchHeroFunc(1)
    self:__SelectHero(newHeroData, reUseBigImgResloader)
  end
end

function UIAthEfficiency:_OnAthLockPre(athUid)
  local athData = PlayerDataCenter.allAthData.athDic[athUid]
  if athData:IsAthLock() or self.athSelectedDic[athUid] == nil then
    return
  end
  self.athSelectedDic[athUid] = nil
  self.athListNode.athListArea:SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
  local exp = athData.athCfg.shard
  self:__OnAthExpAdd(-exp)
end

function UIAthEfficiency:OnDelete()
  self.athListNode:Delete()
  self.quickSelectNode:Delete()
  MsgCenter:RemoveListener(eMsgEventId.OnAthLockPre, self._onAthLockPreFunc)
  UIManager:HideWindow(UIWindowTypeID.AthItemDetailFloat)
  if self.siftCondition ~= nil then
    self.siftCondition:Delete()
  end
  base.OnDelete(self)
end

return UIAthEfficiency

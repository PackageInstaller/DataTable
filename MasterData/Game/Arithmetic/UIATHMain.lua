local UIATHMain = class("UIATHMain", UIBaseWindow)
local base = UIBaseWindow
local UINAthList = require("Game.Arithmetic.AthList.UINAthList")
local UINAthAreaItem = require("Game.Arithmetic.AthArea.UINAthAreaItem")
local UINAthItem = require("Game.Arithmetic.AthList.Area.UINAthItem")
local UINAthMainAtrrItem = require("Game.Arithmetic.AthMain.UINAthMainAtrrItem")
local UINAthSuitMainItem = require("Game.Arithmetic.AthMain.UINAthSuitMainItem")
local UINAthInfoTogItem = require("Game.Arithmetic.AthMain.UINAthInfoTogItem")
local AthUtil = require("Game.Arithmetic.AthUtil")
local AthAreaGridData = require("Game.Arithmetic.Data.AthAreaGridData")
local UINShareCommonBtn = require("Game.Share.UI.UINShareCommonBtn")
local eShare = require("Game.Share.eShare")
local UIAttrUtil = require("Game.CommonUI.Hero.Attr.UIAttrUtil")
local SkinEnum = require("Game.Skin.SkinEnum")
local cs_MessageCommon = CS.MessageCommon
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_Input = CS.UnityEngine.Input
local cs_ResLoader = CS.ResLoader
local athInfoState = {BaseAttr = 1, Suit = 2}
local oneKeyUninstallSlotList = {}
for i = 1, ConfigData.game_config.athSlotCount do
  table.insert(oneKeyUninstallSlotList, i)
end

function UIATHMain:OnInit()
  UIUtil.SetTopStatus(self, self.__OnClickBack, nil, AthUtil.ShowATHInfoFunc)
  UIUtil.AddButtonListener(self.ui.btn_Efficiency, self, self.__OnClickEfficiency)
  UIUtil.AddButtonListener(self.ui.btn_TotalEfficiency, self, self.__OnClickShowHeroAttr)
  UIUtil.AddButtonListener(self.ui.btn_Dteail, self, self._OnClickDetail)
  UIUtil.AddButtonListener(self.ui.btn_Install, self, self.OneKeyInstall)
  UIUtil.AddButtonListener(self.ui.btn_Uninstall, self, self.OneKeyUninstall)
  UIUtil.AddButtonListener(self.ui.btn_LeftArrow, self, self.__OnClickLeftArrow)
  UIUtil.AddButtonListener(self.ui.btn_RightArrow, self, self.__OnClickRightArrow)
  UIUtil.AddButtonListener(self.ui.btn_Deploy, self, self.__OnClickDeploy)
  UIUtil.AddButtonListener(self.ui.btn_Suit, self, self.OnClickSuit)
  self.__OnSelectListAreaFunc = BindCallback(self, self.__OnSelectListArea)
  self.__OnClickAthItem = BindCallback(self, self.OnClickAthItem)
  self.__OnClickSuit = BindCallback(self, self.OnClickSuit)
  self.__InstallAth = BindCallback(self, self.InstallAth)
  self.__UnInstallAth = BindCallback(self, self.UnInstallAth)
  self.__ReplaceAth = BindCallback(self, self.ReplaceAth)
  self.__OnDragStart = BindCallback(self, self.OnDragAthItemStart)
  self.__onAthDataUpdate = BindCallback(self, self.OnAthDataUpdate)
  self.__OnAthItemDetailShow = BindCallback(self, self._OnAthItemDetailShow)
  self.__getAthItemFromList = BindCallback(self, self.GetAthItemFromListMain)
  self.__onFingerSet = BindCallback(self, self.OnFingerSet)
  self.__onFingerUp = BindCallback(self, self.OnFingerUp)
  self.__selectInfoTogFunc = BindCallback(self, self.SelectInfoTogItem)
  CS_LeanTouch.OnFingerSet("+", self.__onFingerSet)
  CS_LeanTouch.OnFingerUp("+", self.__onFingerUp)
  self.ATHTweenDic = self.transform:GetComponentsInChildren(typeof(CS.DG.Tweening.DOTweenAnimation))
  self.athListNode = UINAthList.New()
  self.athListNode:Init(self.ui.aTHListNode)
  self.athListNode:SetAthItemStartDragFunc(self.__OnDragStart)
  self.athListNode:ShowAthListUsingRate()
  self.athListNode:Hide()
  self.ui.areaItem:SetActive(false)
  self.athAreaPool = UIItemPool.New(UINAthAreaItem, self.ui.areaItem)
  for i = 1, ConfigData.game_config.athSlotCount do
    local areaItem = self.athAreaPool:GetOne()
    areaItem:InitAthAreaItem(i, self, self.__OnDragStart)
    areaItem.gameObject.name = tostring(i)
  end
  self.ui.attriItem:SetActive(false)
  self.attrItemPool = UIItemPool.New(UINAthMainAtrrItem, self.ui.attriItem)
  self.ui.suitItem:SetActive(false)
  self.suitItemPool = UIItemPool.New(UINAthSuitMainItem, self.ui.suitItem)
  self.infoTogItemList = {}
  for k, go in ipairs(self.ui.infoTogList) do
    local infoTogItem = UINAthInfoTogItem.New()
    infoTogItem:Init(go)
    infoTogItem:InitAthInfoTogItem(k, self.__selectInfoTogFunc)
    table.insert(self.infoTogItemList, infoTogItem)
  end
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
  MsgCenter:AddListener(eMsgEventId.OnAthItemDetailShow, self.__OnAthItemDetailShow)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
  self._shareBtn = UINShareCommonBtn.New()
  self._shareBtn:Init(self.ui.shareCommonButton)
  self._shareBtn:Hide()
end

function UIATHMain:InitATHMain(heroData, heroResLoader, addAllTouchFunc, switchHeroFunc)
  self.__multiTouchEnabledBeforeOpen = CS_Input.multiTouchEnabled
  CS_Input.multiTouchEnabled = false
  self.resLoader = cs_ResLoader.Create()
  self.addAllTouchFunc = addAllTouchFunc
  self.switchHeroFunc = switchHeroFunc
  self:__SelectHero(heroData, heroResLoader)
  if #PlayerDataCenter.allAthData.athReconsitutionDataList > 0 then
    local athData = PlayerDataCenter.allAthData.athDic[PlayerDataCenter.allAthData.athReconsitutionDataList[1].uid]
    AthUtil.ShowAthRefactorSuccess(athData, self.heroData, function()
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.ATH_HasRefactor))
    end)
  end
  self:_UpdDetailBtn()
  local shareCtr = ControllerManager:GetController(ControllerTypeId.Share, true)
  if shareCtr:IsShareUnlock() then
    self._shareId = eShare.eShareType.CommonReward
    self._shareBtn:Show()
    self._shareBtn:InitShareCommonBtn(BindCallback(self, self._OnClickShare), self._shareId)
    self._showShareBtn = true
  end
end

function UIATHMain:__SelectHero(heroData, heroResLoader)
  self.heroData = heroData
  self.heroResLoader = heroResLoader
  DestroyUnityObject(self.bigImgGameObject)
  self.heroResLoader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(heroData:GetResPicName(), SkinEnum.fromWhere.heroInfoAndHandbook), function(prefab)
    if IsNull(self.gameObject) then
      return
    end
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
    self.ui.tween_heroHolder:DORestart()
  end)
  self:RefreshAllAthInfo(true)
  self:RefreshAllAthArea()
  self.infoTogItemList[1]:SetAthInfoTogOn()
  self:__RefreshBlueDot()
  self:PlayATHTween()
end

function UIATHMain:__RefreshBlueDot()
  for k, areaItem in ipairs(self.athAreaPool.listItem) do
    areaItem:RefreshAthAreaItemBlueDot()
  end
end

function UIATHMain:PlayATHTween()
  for i = 0, self.ATHTweenDic.Length - 1 do
    local tween = self.ATHTweenDic[i]
    tween:DORestart(false)
  end
end

function UIATHMain:PlayATHTweenBackwards()
  for i = 0, self.ATHTweenDic.Length - 1 do
    local tween = self.ATHTweenDic[i]
    tween:DOPlayBackwards()
  end
end

function UIATHMain:RefreshAllAthInfo(changeAttrSort)
  local athAreaMaxSpaceList = self.heroData:GetAthSlotList(true)
  self.athAreaMaxSpaceList = athAreaMaxSpaceList
  local athAreaCurSpaceList = self.heroData:GetAthSlotList()
  self.athAreaCurSpaceList = athAreaCurSpaceList
  local areaLevel = PlayerDataCenter.allAthData:GetHeroAthSlotInfo(self.heroData.dataId)
  local areaEfcc = PlayerDataCenter.allAthData:GetAthEfficiency(areaLevel)
  self.areaEfficiency = areaEfcc
  self.ui.tex_EffNum:SetIndex(0, string.format("%.1f", areaEfcc / 1000))
  self:RefreshAthAttr(athAreaCurSpaceList, self.curAreaId, changeAttrSort)
  self.ui.tex_TotalEffNum.text = tostring(self.heroData:GetFightingPower())
end

function UIATHMain:RefreshAthAttr(athSlotList, curSlotId, changeSort)
  local allAttrDic, slotAttrTab, suitDic = PlayerDataCenter.allAthData:GetHeroAthAttr(self.heroData.dataId)
  local isAllAttr = slotAttrTab[curSlotId] == nil
  self.isAllAttr = isAllAttr
  local fightPower = PlayerDataCenter.allAthData:GetAthFightPower(allAttrDic)
  if isAllAttr then
    self.ui.tex_Efficiency:SetIndex(1, tostring(fightPower))
  else
    local curSlotAttrDic = slotAttrTab[curSlotId]
    local curSlotFightPower = PlayerDataCenter.allAthData:GetAthFightPower(curSlotAttrDic)
    self.ui.tex_Efficiency:SetIndex(0, tostring(curSlotFightPower), tostring(fightPower))
  end
  self.attrValueDic = self:__MergeAttr(allAttrDic, isAllAttr, slotAttrTab, curSlotId)
  if self.attrIdSortList == nil or changeSort then
    self.attrIdSortList = {}
    for k, attrId in ipairs(ConfigData.attribute.baseAttrIds) do
      if ConfigData.attribute[attrId].merge_attribute == 0 then
        table.insert(self.attrIdSortList, attrId)
      end
    end
    table.sort(self.attrIdSortList, function(attrIdA, attrIdB)
      local isRecommondA = self.heroData:IsHeroRecommendAttr(attrIdA)
      local isRecommondB = self.heroData:IsHeroRecommendAttr(attrIdB)
      if isRecommondA ~= isRecommondB then
        return isRecommondA
      end
      local notZeroA = self.attrValueDic[attrIdA] ~= 0
      local notZeroB = self.attrValueDic[attrIdB] ~= 0
      if notZeroA ~= notZeroB then
        return notZeroA
      end
      local priorityA = ConfigData.attribute[attrIdA].attribute_priority
      local priorityB = ConfigData.attribute[attrIdB].attribute_priority
      return priorityA < priorityB
    end)
  end
  self.attrItemPool:HideAll()
  self.ui.scroll_attriPage.verticalNormalizedPosition = 1
  local isEmpty = true
  for k, attrId in ipairs(self.attrIdSortList) do
    local value = self.attrValueDic[attrId]
    local attrItem = self.attrItemPool:GetOne()
    local isRecommond = self.heroData:IsHeroRecommendAttr(attrId)
    if value ~= 0 or isRecommond then
      attrItem:InitAthMainAtrrItem(attrId, value, isRecommond)
      isEmpty = false
    else
      attrItem.gameObject:SetActive(false)
    end
  end
  self.ui.obj_NoAttr:SetActive(isEmpty)
  self.heroSuitDic = {}
  local suitIdList = {}
  for suitId, suitData in pairs(suitDic) do
    table.insert(suitIdList, suitId)
    self.heroSuitDic[suitId] = {
      suitCount = suitData.curCount,
      athDataDic = suitData.suitAthDic
    }
  end
  table.sort(suitIdList, function(a, b)
    local suitDataA = suitDic[a]
    local suitDataB = suitDic[b]
    if suitDataA.curCount == suitDataB.curCount then
      return a < b
    else
      return suitDataA.curCount > suitDataB.curCount
    end
  end)
  self.suitItemPool:HideAll()
  for k, suitId in ipairs(suitIdList) do
    local suitData = suitDic[suitId]
    local suitItem = self.suitItemPool:GetOne()
    suitItem:InitAthSuitMainItem(suitData, self.resLoader, self.__OnClickSuit)
  end
  self.ui.obj_NoSuit:SetActive(#suitIdList == 0)
end

function UIATHMain:__MergeAttr(allAttrDic, isAllAttr, slotAttrTab, curSlotId)
  local valueDic = table.GetDefaulValueTable(0)
  local allAttrIdList = {}
  for k, v in pairs(allAttrDic) do
    table.insert(allAttrIdList, k)
  end
  for k, attrId in ipairs(allAttrIdList) do
    local attrConfig = ConfigData.attribute[attrId]
    if attrConfig.merge_attribute ~= 0 then
      local mergeID = attrConfig.merge_attribute
      if attrConfig.num_type == 2 then
        if isAllAttr then
          valueDic[mergeID] = valueDic[mergeID] + allAttrDic[attrId] * self.heroData:GetAttr(mergeID, true, true, true) // 1000
        else
          valueDic[mergeID] = valueDic[mergeID] + (slotAttrTab[curSlotId][attrId] or 0) * self.heroData:GetAttr(mergeID, true, true, true) // 1000
        end
      elseif isAllAttr then
        valueDic[mergeID] = valueDic[mergeID] + allAttrDic[attrId]
      else
        valueDic[mergeID] = valueDic[mergeID] + (slotAttrTab[curSlotId][attrId] or 0)
      end
    elseif attrConfig.num_type == 2 then
      if 17 < attrId then
        if isAllAttr then
          valueDic[attrId] = allAttrDic[attrId]
        else
          valueDic[attrId] = slotAttrTab[curSlotId][attrId] or 0
        end
      elseif isAllAttr then
        valueDic[attrId] = valueDic[attrId] + allAttrDic[attrId]
      else
        valueDic[attrId] = valueDic[attrId] + (slotAttrTab[curSlotId][attrId] or 0)
      end
    elseif isAllAttr then
      valueDic[attrId] = valueDic[attrId] + allAttrDic[attrId]
    else
      valueDic[attrId] = valueDic[attrId] + (slotAttrTab[curSlotId][attrId] or 0)
    end
  end
  return valueDic
end

function UIATHMain:__RefreshAfficiencyAttr()
  if self.attrValueDic == nil then
    return
  end
  for k, attrId in ipairs(self.attrIdSortList) do
    local value = self.attrValueDic[attrId]
    local isRecommond = self.heroData:IsHeroRecommendAttr(attrId)
    local attrItem = self.attrItemPool.listItem[k]
    attrItem:InitAthMainAtrrItem(attrId, value, isRecommond)
  end
end

function UIATHMain:RefreshAllAthArea()
  for areaId, areaItem in ipairs(self.athAreaPool.listItem) do
    local space = self.athAreaCurSpaceList[areaId]
    local maxSpace = self.athAreaMaxSpaceList[areaId]
    areaItem:RefreshAthAreaItem(self.heroData, self.resLoader, space, maxSpace)
  end
end

function UIATHMain:ShowAthMainMask(show)
  self.ui.img_winMask:SetActive(show)
  if self._showShareBtn then
    self._shareBtn.gameObject:SetActive(not show)
  end
end

function UIATHMain:GetInstalledAthItem(athData)
  local athItem
  local areaId = athData:GetAthAreaType()
  local areaItem = self.athAreaPool.listItem[areaId]
  athItem = areaItem:GetAthTableItemByUid(athData.uid)
  return athItem
end

function UIATHMain:GetCurAthAreaItem(areaId)
  local areaItem = self.athAreaPool.listItem[areaId or self.curAreaId]
  return areaItem
end

function UIATHMain:TryInstallAth(athItem, inAthTable)
  UIManager:ShowWindowAsync(UIWindowTypeID.AthItemDetail, function(window)
    if window == nil then
      return
    end
    local athData = athItem:GetAthItemData()
    window:SetAthItemDetailFunc(self.__InstallAth, self.__UnInstallAth, self.__ReplaceAth)
    window:InitAthItemDetail(self.heroData, athData, nil, inAthTable)
    if inAthTable then
      window:ChangeAthItemParent(athItem, nil)
    else
      window:ChangeAthItemParent(athItem, self.__getAthItemFromList)
    end
  end)
end

function UIATHMain:TryReplaceAth(athItem, replacedAthData)
  UIManager:ShowWindowAsync(UIWindowTypeID.AthItemDetail, function(window)
    if window == nil then
      return
    end
    local athData = athItem:GetAthItemData()
    window:SetAthItemDetailFunc(self.__InstallAth, self.__UnInstallAth, self.__ReplaceAth)
    window:InitAthItemDetail(self.heroData, athData, replacedAthData)
    window:ChangeAthItemParent(athItem, self.__getAthItemFromList)
  end)
end

function UIATHMain:ShowHeroPowerSide(power)
  if power == 0 then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageSide, function(win)
    if win ~= nil then
      win:ShowTips(power, 1, eMessageSideType.efficiency)
    end
  end)
end

function UIATHMain:OnFingerSet(finger)
  self:OnDragAthItem(finger)
end

function UIATHMain:OnFingerUp(finger)
  self:OnDragAthItemEnd(finger)
end

function UIATHMain:OnDragAthItemStart(athItem, isInTable)
  if self._dragItem ~= nil then
    return
  end
  local athData = athItem:GetAthItemData()
  local areaId = athData:GetAthAreaType()
  self:__RefreshAllAreaMask(areaId)
  self:__RefreshAllAreaTogUI(areaId)
  self._dragFromTable = isInTable
  local finger = CS_LeanTouch.Fingers[0]
  self._lastAthPos = athItem:GetAthItemRootPos()
  local newPos = UIManager:Screen2WorldPosition(finger.ScreenPosition, athItem:GetAthItemRoot())
  self._dragOffset = self._lastAthPos - newPos
  athItem:SetAthItemRootParent(self.transform)
  if not isInTable then
    local transparentItem = self:__GetTransparentAthItem(athData:GetAthSize())
    transparentItem:SetAsTransparentAthItem(athItem.transform, athData, self.resLoader)
    self._curTransparentItem = transparentItem
    
    local function callBack()
      if self._curTransparentItem ~= nil then
        self:__ReturnTransparentAthItem(self._curTransparentItem)
        self._curTransparentItem = nil
      end
    end
    
    athItem:SetAthItemRootParentResetFunc(callBack)
  end
  self._dragItem = athItem
end

function UIATHMain:OnDragAthItem(finger)
  if self._dragItem == nil then
    return
  end
  local newPos = UIManager:Screen2WorldPosition(finger.ScreenPosition, self._dragItem:GetAthItemRoot())
  newPos = newPos + self._dragOffset
  self._dragItem:SetAthItemPos(newPos)
end

function UIATHMain:OnDragAthItemEnd(finger)
  if self._dragItem == nil then
    return
  end
  local athData = self._dragItem:GetAthItemData()
  local worldPos = self._dragItem:GetAthItemRoot().position
  if self.athListNode:DragInAthSortList(worldPos) then
    if self._dragFromTable then
      self:UnInstallAth(athData)
      self._dragItem:SetAthItemRootParent(nil, true)
      self._dragItem:Hide()
    else
      self._dragItem:DragEndTweenAthItem(self._lastAthPos)
    end
  else
    local curAreaItem = self:GetCurAthAreaItem(athData:GetAthAreaType())
    local gridId = curAreaItem:GetAthGridIdByScreenPos(worldPos, athData)
    if gridId ~= nil then
      if self._dragFromTable then
        local canMove = curAreaItem.areaGridData:CheckAthInstallable(athData, gridId, athData.uid)
        if canMove and gridId ~= athData.bindInfo.grid then
          self:MoveAth(athData, gridId)
          local anchorPos = curAreaItem:GetAthTableItemPos(athData, gridId)
          self._dragItem:AthMoveTweenWithRootParent(anchorPos)
        else
          self._dragItem:DragEndTweenAthItem(self._lastAthPos)
        end
      else
        local canInstall = curAreaItem.areaGridData:CheckAthInstallable(athData, gridId)
        if canInstall then
          self._dragItem:SetAthItemRootParent(nil, true)
          self:RefillAth(athData, gridId, nil, nil, proto_csmsg_AthRefillOperator.AthRefillOperatorInstall)
        else
          local replacedAthData, oneReplaceMore = curAreaItem.areaGridData:CheckAthReplaceable(athData, gridId, true)
          if replacedAthData ~= nil then
            self._dragItem:SetAthItemRootParent(nil, true)
            self:TryReplaceAth(self._dragItem, replacedAthData)
          elseif curAreaItem.areaGridData:CheckAthAreaSpaceOk(athData) and not oneReplaceMore then
            local athInstallDic, athInstalledDic = curAreaItem.areaGridData:ReSortAthTable(athData)
            if athInstallDic ~= nil then
              local gridPos = athInstallDic[athData.uid]
              self._dragItem:SetAthItemRootParent(nil, true)
              self:RefillAth(athData, gridPos, athInstallDic, athInstalledDic, proto_csmsg_AthRefillOperator.AthRefillOperatorInstall)
            else
              self._dragItem:DragEndTweenAthItem(self._lastAthPos)
            end
          else
            self._dragItem:DragEndTweenAthItem(self._lastAthPos)
          end
        end
      end
    else
      self._dragItem:DragEndTweenAthItem(self._lastAthPos)
    end
  end
  self:__RefreshAllAreaMask(self.curAreaId)
  self:__RefreshAllAreaTogUI(self.curAreaId)
  self._dragItem:OnAthItemDragEnd()
  self._dragItem = nil
end

function UIATHMain:__GetTransparentAthItem(space)
  if self.__transparentAthItemDic == nil then
    self.__transparentAthItemDic = {}
  end
  local athItem = self.__transparentAthItemDic[space]
  if athItem == nil then
    local prefab = self:GetAthItemGameObject(space)
    local go = prefab:Instantiate()
    athItem = UINAthItem.New()
    athItem:Init(go)
    self.__transparentAthItemDic[space] = athItem
  end
  return athItem
end

function UIATHMain:__ReturnTransparentAthItem(athItem)
  if self.__transparentAthItemRoot == nil then
    local go = CS.UnityEngine.GameObject("TransparentAthItemRoot")
    go:SetActive(false)
    self.__transparentAthItemRoot = go.transform
    self.__transparentAthItemRoot:SetParent(self.transform)
  end
  for k, v in pairs(self.__transparentAthItemDic) do
    if v == athItem then
      athItem.transform:SetParent(self.__transparentAthItemRoot)
      break
    end
  end
end

function UIATHMain:__OnClickEfficiency()
  UIManager:ShowWindowAsync(UIWindowTypeID.AthEfficiency, function(window)
    if window == nil then
      return
    end
    window:InitAthAthEfcc(self.heroData, self.resLoader, self.heroResLoader, function(value)
      local newHeroData, reUseBigImgResloader = self.switchHeroFunc(value)
      self:__SelectHero(newHeroData, reUseBigImgResloader)
      return newHeroData, reUseBigImgResloader
    end)
  end)
end

function UIATHMain:__OnClickShowHeroAttr()
  local attrDataList
  local attrOutLineWindow = self._attrOutLineWindow
  if attrOutLineWindow == nil then
    attrOutLineWindow, attrDataList = UIAttrUtil.ShowAttrOutLineWindow(self.heroData, self.ui.logicPreviewNode)
    attrOutLineWindow:Hide()
    self._attrOutLineWindow = attrOutLineWindow
  else
    attrDataList = UIAttrUtil.GetAttrDataListForShow(self.heroData)
  end
  UIAttrUtil.UpdateAttrData(self.heroName, attrDataList, attrOutLineWindow)
  attrOutLineWindow:Show()
end

function UIATHMain:_OnClickDetail()
  PlayerDataCenter.allAthData:SetAthItemAttrShow(not PlayerDataCenter.allAthData:IsAthItemAttrShow())
end

function UIATHMain:_UpdDetailBtn()
  self.ui.img_Select:SetIndex(PlayerDataCenter.allAthData:IsAthItemAttrShow() and 1 or 0)
end

function UIATHMain:__OnClickLeftArrow()
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = self.switchHeroFunc(-1)
    self:__SelectHero(newHeroData, reUseBigImgResloader)
  end
end

function UIATHMain:__OnClickRightArrow()
  if self.switchHeroFunc ~= nil then
    local newHeroData, reUseBigImgResloader = self.switchHeroFunc(1)
    self:__SelectHero(newHeroData, reUseBigImgResloader)
  end
end

function UIATHMain:__ShowAthList(areaId)
  if not self.athListNode.active then
    AudioManager:PlayAudioById(1088)
    self.athListNode:Show()
    self.ui.btn_Deploy.gameObject:SetActive(false)
    self.ui.btn_Dteail.gameObject:SetActive(false)
    UIUtil.SetTopStatus(self, self.__OnHideAthList, nil, AthUtil.ShowATHInfoFunc)
  end
  self.curAreaId = areaId
  self.athListNode:InitAthListNode(self.heroData, self.resLoader, false, self.__OnClickAthItem, areaId, nil, self.__OnSelectListAreaFunc, nil, true)
end

function UIATHMain:__OnHideAthList()
  self.athListNode:Hide()
  self.ui.btn_Deploy.gameObject:SetActive(true)
  self.ui.btn_Dteail.gameObject:SetActive(true)
  self:__OnSelectListArea(nil)
  self:ShowAthMainMask(false)
end

function UIATHMain:__OnClickDeploy()
  self:ShowAthMainMask(true)
  self:__ShowAthList(nil)
end

function UIATHMain:OnSelectAthAreaItem(areaId)
  self:__ShowAthList(areaId)
  self:ShowAthMainMask(true)
  self:__RefreshAllAreaMask(areaId)
end

function UIATHMain:__OnSelectListArea(areaId)
  if areaId == nil then
    if self.curAreaId ~= nil then
      self.ui.areaListTogGroup.allowSwitchOff = true
      local areaItem = self.athAreaPool.listItem[self.curAreaId]
      areaItem:SetAthAreaItemToggleOn(false)
      self.ui.areaListTogGroup.allowSwitchOff = false
    end
    self:__RefreshAllAreaMask()
  else
    local areaItem = self.athAreaPool.listItem[areaId]
    areaItem:SetAthAreaItemToggleOn(true)
  end
  self.athListNode:SetAthListArea(areaId)
  self.curAreaId = areaId
  self:RefreshAllAthInfo(true)
end

function UIATHMain:__RefreshAllAreaMask(areaId)
  for k, areaItem in ipairs(self.athAreaPool.listItem) do
    local show
    if areaId == nil then
      show = false
    else
      show = areaItem.areaId ~= areaId
    end
    areaItem:ShowAthAreaItemMask(show)
  end
end

function UIATHMain:__RefreshAllAreaTogUI(areaId)
  for k, areaItem in ipairs(self.athAreaPool.listItem) do
    local isOn
    if areaId == nil then
      isOn = false
    else
      isOn = areaItem.areaId == areaId
    end
    areaItem:SetAthAreaItemToggleOnUI(isOn)
  end
end

function UIATHMain:__OnClickBack()
  local win = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if win ~= nil and not win.active then
    win:Show()
  end
  self:PlayATHTweenBackwards()
  self:Delete()
end

function UIATHMain:OnClickAthItem(athItem, inAthTable)
  local replacedAthData
  if not inAthTable then
    local athData = athItem:GetAthItemData()
    local curAreaId = athData:GetAthAreaType()
    local athDataList = PlayerDataCenter.allAthData:GetHeroAthList(self.heroData.dataId, curAreaId)
    for k, v in ipairs(athDataList) do
      if v.id == athData.id and v.uid ~= athData.uid then
        replacedAthData = v
        break
      elseif v:IsConflictAthSuit(athData) then
        replacedAthData = v
        break
      end
    end
  end
  if replacedAthData ~= nil then
    self:TryReplaceAth(athItem, replacedAthData)
  else
    self:TryInstallAth(athItem, inAthTable)
  end
end

function UIATHMain:OnClickSuit(suitId)
  self:__OnSelectListArea(nil)
  self:__ShowAthList(nil)
  self.athListNode:SelectAthListSuit(suitId)
end

function UIATHMain:SelectInfoTogItem(infoState)
  self.infoState = infoState
  self.ui.attriPage:SetActive(false)
  self.ui.suitPage:SetActive(false)
  if infoState == athInfoState.BaseAttr then
    self.ui.attriPage:SetActive(true)
    self:__RefreshAfficiencyAttr(false)
  elseif infoState == athInfoState.Suit then
    self.ui.suitPage:SetActive(true)
  end
end

function UIATHMain:InstallAth(athData)
  self:RefillAth(athData, nil, nil, nil, proto_csmsg_AthRefillOperator.AthRefillOperatorInstall)
end

function UIATHMain:RefillAth(athData, gridId, resortAthDic, athInstalledDic, refillOp)
  local signHeroId = athData:GetAthSignHeroId()
  if 0 < signHeroId and signHeroId ~= self.heroData.dataId then
    local heroName = PlayerDataCenter.heroDic[signHeroId]:GetName()
    cs_MessageCommon.ShowMessageTipsWithErrorSound(string.format(ConfigData:GetTipContent(21003), heroName))
    return
  end
  local curAreaId = athData:GetAthAreaType()
  local athDataList = PlayerDataCenter.allAthData:GetHeroAthList(self.heroData.dataId, curAreaId)
  for k, v in ipairs(athDataList) do
    if refillOp == proto_csmsg_AthRefillOperator.AthRefillOperatorInstall then
      if v.id == athData.id then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.arithmetic_RepeatedATH))
        return
      elseif v:IsConflictAthSuit(athData) then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(205))
        return
      end
    end
    if refillOp == proto_csmsg_AthRefillOperator.AthRefillOperatorReplace then
      if v.uid == athData.uid or v.id == athData.id and v.bindInfo.grid ~= gridId then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.arithmetic_RepeatedATH))
        return
      elseif v:IsConflictAthSuit(athData) and v.bindInfo.grid ~= gridId then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(205))
        return
      end
    end
  end
  local curAreaItem = self:GetCurAthAreaItem(curAreaId)
  self._curAreaItem = curAreaItem
  if gridId == nil then
    gridId = curAreaItem.areaGridData:GetAthInstallableGrid(athData)
    if gridId == nil then
      local canInstall = false
      if curAreaItem.areaGridData:CheckAthAreaSpaceOk(athData) then
        local athInstallDic, installedDic = curAreaItem.areaGridData:ReSortAthTable(athData)
        if athInstallDic ~= nil then
          gridId = athInstallDic[athData.uid]
          resortAthDic = athInstallDic
          athInstalledDic = installedDic
          canInstall = true
        end
      end
      if not canInstall then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_CantInstall))
        return
      end
    end
  end
  self.oldHeroPower = self.heroData:GetFightingPower()
  if self.__onInstallComplete == nil then
    self.__onInstallComplete = BindCallback(self, self.OnInstallAthComplete)
  end
  
  local function installFunc()
    self.__insallAthData = athData
    self.__resortAthDic = resortAthDic
    self.__athInstalledDic = athInstalledDic
    local oldMoveDic
    if resortAthDic ~= nil then
      oldMoveDic = {}
      for uid, gridId in pairs(resortAthDic) do
        if uid ~= athData.uid then
          oldMoveDic[uid] = gridId
        end
      end
    end
    self.athNetwork:CS_ATH_AthRefillOp(self.heroData.dataId, curAreaId, athData.uid, gridId, oldMoveDic, refillOp, self.__onInstallComplete)
  end
  
  if athData.bindInfo ~= nil and athData.bindInfo.id ~= self.heroData.id then
    UIManager:ShowWindowAsync(UIWindowTypeID.AthReplaceHero, function(window)
      if window == nil then
        return
      end
      window:InitAthReplaceHero(self.heroData.dataId, athData.bindInfo.id, installFunc, self.resLoader)
    end)
  else
    installFunc()
  end
end

function UIATHMain:OnInstallAthComplete()
  AudioManager:PlayAudioById(1030)
  local curAreaItem = self._curAreaItem
  if self.__resortAthDic == nil then
    curAreaItem:OnInstallAthItem(self.__insallAthData)
  else
    curAreaItem:OnReinstallAllAthTable(self.__resortAthDic, self.__athInstalledDic)
  end
  UIManager:HideWindow(UIWindowTypeID.AthItemDetail)
  local newHeroPower = self.heroData:GetFightingPower()
  self:ShowHeroPowerSide(newHeroPower - self.oldHeroPower)
  self:RefreshAllAthInfo()
end

function UIATHMain:UnInstallAth(athData)
  self.oldHeroPower = self.heroData:GetFightingPower()
  if self.__unInstallAthComplete == nil then
    self.__unInstallAthComplete = BindCallback(self, self.OnUnInstallAthComplete)
  end
  self.__uninsallAthData = athData
  self.__uninstallAthGrid = athData.bindInfo.grid
  self.athNetwork:CS_ATH_AthUninstall(athData.uid, self.__unInstallAthComplete)
end

function UIATHMain:OnUnInstallAthComplete()
  AudioManager:PlayAudioById(1032)
  local curAreaItem = self:GetCurAthAreaItem(self.__uninsallAthData:GetAthAreaType())
  curAreaItem:OnUnInstallAthItem(self.__uninsallAthData.uid, self.__uninstallAthGrid)
  UIManager:HideWindow(UIWindowTypeID.AthItemDetail)
  local newHeroPower = self.heroData:GetFightingPower()
  self:ShowHeroPowerSide(newHeroPower - self.oldHeroPower)
  self:RefreshAllAthInfo()
end

function UIATHMain:ReplaceAth(oldAthData, newAthData)
  local curAreaItem = self:GetCurAthAreaItem(oldAthData:GetAthAreaType())
  local athInstallDic, athInstalledDic = curAreaItem.areaGridData:GetTryReplaceAthDic(newAthData, oldAthData)
  if athInstallDic == nil then
    return
  end
  local replaceGrid
  for k, v in pairs(athInstallDic) do
    if newAthData.uid == k then
      replaceGrid = v
      break
    end
  end
  if replaceGrid == nil then
    error("replaceGrid == nil")
    return
  end
  self:RefillAth(newAthData, replaceGrid, athInstallDic, athInstalledDic, proto_csmsg_AthRefillOperator.AthRefillOperatorReplace)
end

function UIATHMain:MoveAth(athData, newGridPos)
  if self.__OnMoveAthComplete == nil then
    self.__OnMoveAthComplete = BindCallback(self, self.OnMoveAthComplete)
  end
  self.__moveAthData = athData
  self.__moveAthGrid = athData.bindInfo.grid
  self.athNetwork:CS_ATH_Move(athData.uid, newGridPos, self.__OnMoveAthComplete)
end

function UIATHMain:OnMoveAthComplete()
  AudioManager:PlayAudioById(1030)
  local curAreaItem = self:GetCurAthAreaItem(self.__moveAthData:GetAthAreaType())
  curAreaItem.areaGridData:UninstallAthGridData(self.__moveAthData, self.__moveAthGrid)
  curAreaItem.areaGridData:InstallAthGridData(self.__moveAthData)
end

function UIATHMain:OnAthDataUpdate(updateAth, heroSlot)
  local refreshAllInfoOk = false
  for uid, v in pairs(updateAth) do
    local athData = PlayerDataCenter.allAthData.athDic[uid]
    if athData.bindInfo ~= nil and athData.bindInfo.id == self.heroData.dataId then
      refreshAllInfoOk = true
      self:RefreshAllAthInfo()
      break
    end
  end
  if heroSlot[self.heroData.dataId] ~= nil then
    if not refreshAllInfoOk then
      self:RefreshAllAthInfo()
    end
    self:RefreshAllAthArea()
  end
  for k, areaItem in ipairs(self.athAreaPool.listItem) do
    areaItem:RefreshAthAreaItemData(updateAth)
  end
  self:__RefreshBlueDot()
end

function UIATHMain:_OnAthItemDetailShow()
  for k, areaItem in ipairs(self.athAreaPool.listItem) do
    areaItem:RefreshAthAreaItemDataAll()
  end
  self:_UpdDetailBtn()
end

function UIATHMain:OneKeyInstall()
  local slots = {}
  for areaId = 1, ConfigData.game_config.athSlotCount do
    local space = self.athAreaCurSpaceList[areaId]
    local maxSpace = self.athAreaMaxSpaceList[areaId]
    local areaGridData = AthAreaGridData.New(areaId)
    local athInstallDic = AthUtil.OnekeyInstallAthArea(self.heroData, areaId, space, maxSpace, areaGridData)
    if athInstallDic ~= nil and table.count(athInstallDic) > 0 then
      local slot = {slotId = areaId, athGroup = athInstallDic}
      table.insert(slots, slot)
    end
  end
  if table.count(slots) == 0 then
    return
  end
  self.oldHeroPower = self.heroData:GetFightingPower()
  if self._OnOneKeyInstallComplete == nil then
    self._OnOneKeyInstallComplete = BindCallback(self, self.OnOneKeyInstallComplete)
  end
  self.athNetwork:CS_ATH_OneKeyInstall(self.heroData.dataId, slots, self._OnOneKeyInstallComplete)
end

function UIATHMain:OnOneKeyInstallComplete()
  AudioManager:PlayAudioById(1030)
  self:RefreshAllAthInfo()
  self:RefreshAllAthArea()
  local newHeroPower = self.heroData:GetFightingPower()
  self:ShowHeroPowerSide(newHeroPower - self.oldHeroPower)
end

function UIATHMain:OneKeyUninstall()
  local hasAth = false
  for k, areaId in ipairs(oneKeyUninstallSlotList) do
    local athDataList, athDic = PlayerDataCenter.allAthData:GetHeroAthList(self.heroData.dataId, areaId)
    if 0 < #athDataList then
      hasAth = true
      break
    end
  end
  if not hasAth then
    return
  end
  self.oldHeroPower = self.heroData:GetFightingPower()
  if self._OneKeyUninstallCompleteFunc == nil then
    self._OneKeyUninstallCompleteFunc = BindCallback(self, self.OnOneKeyUninstallComplete)
  end
  self.athNetwork:CS_ATH_OneKeyUninstall(self.heroData.dataId, oneKeyUninstallSlotList, self._OneKeyUninstallCompleteFunc)
end

function UIATHMain:OnOneKeyUninstallComplete()
  AudioManager:PlayAudioById(1032)
  self:RefreshAllAthArea()
  local newHeroPower = self.heroData:GetFightingPower()
  self:ShowHeroPowerSide(newHeroPower - self.oldHeroPower)
  self:RefreshAllAthInfo()
end

function UIATHMain:GetAthItemGameObject(space)
  return self.athListNode:GetAthItemGo(space)
end

function UIATHMain:GetAthItemFromListMain(uid)
  return self.athListNode:GetAthItemFromList(uid)
end

function UIATHMain:_OnClickShare()
  UIManager:ShowWindowAsync(UIWindowTypeID.Share, function(win)
    if win == nil then
      return
    end
    win:SetShareBeforeCaptureFunc(function()
      self:_ShareShow(false)
    end):SetShareAfterCaptureFunc(function()
      self:_ShareShow(true)
    end):InitShare(self._shareId)
  end)
end

function UIATHMain:_ShareShow(show)
  self._shareBtn.gameObject:SetActive(show)
  self.ui.btn_Deploy.gameObject:SetActive(show)
  self.ui.btn_LeftArrow.gameObject:SetActive(show)
  self.ui.btn_RightArrow.gameObject:SetActive(show)
  self.ui.btn_Efficiency.gameObject:SetActive(show)
  self.ui.btn_TotalEfficiency.gameObject:SetActive(show)
  self.ui.btn_Dteail.gameObject:SetActive(show)
  self.ui.btn_Install.gameObject:SetActive(show)
  self.ui.btn_Uninstall.gameObject:SetActive(show)
  if show then
    UIUtil.ReShowTopStatus()
    PlayerDataCenter.allAthData:SetAthItemAttrShow(self._lastAtrShow)
    UIManager:ShowWindowOnly(UIWindowTypeID.MessageSide)
  else
    self._lastAtrShow = PlayerDataCenter.allAthData:IsAthItemAttrShow()
    PlayerDataCenter.allAthData:SetAthItemAttrShow(true)
    UIManager:HideWindow(UIWindowTypeID.MessageSide)
    UIUtil.HideTopStatus()
  end
end

function UIATHMain:OnDelete()
  self.athListNode:Delete()
  self._shareBtn:Delete()
  self.suitItemPool:DeleteAll()
  self.attrItemPool:DeleteAll()
  self.athAreaPool:DeleteAll()
  if self._attrOutLineWindow ~= nil then
    self._attrOutLineWindow:Hide()
    self._attrOutLineWindow:OnDelete()
  end
  for k, v in ipairs(self.infoTogItemList) do
    v:Delete()
  end
  if UIManager:GetWindow(UIWindowTypeID.HeroState) ~= nil and self.addAllTouchFunc ~= nil then
    self.addAllTouchFunc()
  end
  UIManager:DeleteWindow(UIWindowTypeID.AthItemDetail)
  UIManager:DeleteWindow(UIWindowTypeID.AthRefactor)
  UIManager:DeleteWindow(UIWindowTypeID.AthItemDetailFloat)
  CS_LeanTouch.OnFingerSet("-", self.__onFingerSet)
  CS_LeanTouch.OnFingerUp("-", self.__onFingerUp)
  CS_Input.multiTouchEnabled = self.__multiTouchEnabledBeforeOpen
  if self._dragItem ~= nil then
    self._dragItem:Delete()
  end
  if self.__transparentAthItemDic ~= nil then
    for k, athItem in pairs(self.__transparentAthItemDic) do
      athItem:Delete()
    end
  end
  MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnAthItemDetailShow, self.__OnAthItemDetailShow)
  PlayerDataCenter.allAthData:SetAthItemAttrShow(false)
  PlayerDataCenter.allAthData:ClearHeroAthStat()
  self.resLoader:Put2Pool()
  self.resLoader = nil
  base.OnDelete(self)
end

return UIATHMain

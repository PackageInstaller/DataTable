local UIAthRefactor = class("UIAthRefactor", UIBaseWindow)
local base = UIBaseWindow
local UINAthScrollList = require("Game.Arithmetic.AthList.Area.UINAthScrollList")
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
local UINAthRefactorDetail = require("Game.Arithmetic.Refactor.UINAthRefactorDetail")
local AthSortEnum = require("Game.Arithmetic.AthList.Sort.AthSortEnum")
local AthUtil = require("Game.Arithmetic.AthUtil")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader

function UIAthRefactor:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  self.resLoader = cs_ResLoader.Create()
  self.athRefactorList = UINAthScrollList.New()
  self.athRefactorList:Init(self.ui.scroll)
  self.athRefactorList:SetAthScrollListGroupGridSize(Vector2.New(5, 2))
  self.athDetailNode = UINAthRefactorDetail.New(self)
  self.athDetailNode:Init(self.ui.aTHDetailItem)
  self.__OnClickAthItemFunc = BindCallback(self, self._OnClickAthItem)
  self.__OnMatExpAddFunc = BindCallback(self, self.__OnMatExpAdd)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
  self._onAthLockPreFunc = BindCallback(self, self._OnAthLockPre)
  MsgCenter:AddListener(eMsgEventId.OnAthLockPre, self._onAthLockPreFunc)
  self.__onAthDataUpdate = BindCallback(self, self._OnAthDataUpdate)
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

function UIAthRefactor:InitAthRefactor(athData, heroData)
  self.athData = athData
  self.heroData = heroData
  self._selectedAthUidDic = {}
  self._seletedAthNum = 0
  self._seletedMatNum = 0
  self.athRefactorList:SetAthScrollListSiftFunc(function(athDataS)
    return athDataS.id == self.athData.id and athDataS.uid ~= self.athData.uid and athDataS.bindInfo == nil
  end)
  self.athRefactorList:SetAthScrollListSortFunc(AthSortEnum.eSortFunc[AthSortEnum.eKindType.Quality])
  self.athRefactorList:SetAthScrollListClickItemWithScroll(false)
  local areaId = athData:GetAthAreaType()
  self.athRefactorList:SetAthScrollListMultSeletedUidDic(self._selectedAthUidDic)
  self.athRefactorList:InitAthScrollList(heroData, areaId, ArthmeticEnum.StrengthenQuality, self.__OnClickAthItemFunc, nil, self.resLoader, true)
  self.athRefactorList:RefreshAthScrollListData()
  self.athRefactorList:RefillAthScrollList()
  self.athMatUpNode = self.athRefactorList:GetAthScrollListMatUpNode()
  self.athMatUpNode:SetRefreshAthSlotAddExpFunc(BindCallback(self, self._RefreshMatAdd))
  self.athMatUpNode:InitAthMatUp(self.__OnMatExpAddFunc, ConfigData.game_config.athRefactorTokenIdList)
  self:_UpdAthMatAddLimit(0)
  self.athDetailNode:InitAthRefactorDetail(athData)
  self:_UpdRefactorState()
  GuideManager:TryTriggerGuide(eGuideCondition.InATHRefactor)
end

function UIAthRefactor:_RefreshMatAdd()
  self:_UpdAthMatAddLimit(self._seletedMatNum)
end

function UIAthRefactor:_ShowAthDetailFloat(athData)
  UIManager:ShowWindowAsync(UIWindowTypeID.AthItemDetailFloat, function(window)
    if window == nil then
      return
    end
    window:InitAthDetailFloat(athData)
  end)
end

function UIAthRefactor:_OnClickAthItem(athItem)
  local athData = athItem:GetAthItemData()
  if athData.lockUnlock then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_CantSelectLockAth))
    self:_ShowAthDetailFloat(athData)
    return
  end
  if self._selectedAthUidDic[athData.uid] == nil then
    local refactorNum = self:GetRefactorNum()
    if refactorNum >= ConfigData.game_config.athRefactorNum then
      return
    end
    self._selectedAthUidDic[athData.uid] = true
    self._seletedAthNum = self._seletedAthNum + 1
    self:_ShowAthDetailFloat(athData)
  else
    self._seletedAthNum = self._seletedAthNum - 1
    self._selectedAthUidDic[athData.uid] = nil
  end
  self:_UpdSelectedAth()
  self.athRefactorList:SetAthScrollListMultSeletedUidDic(self._selectedAthUidDic)
  self.athRefactorList:RefillAthScrollList(nil, nil, true)
  self:_UpdAthMatAddLimit(self._seletedMatNum)
  self:_UpdRefactorState()
end

function UIAthRefactor:_UpdSelectedAth()
  local refactorNum = self:GetRefactorNum()
  local costNum
  if self.athData:GetAthSignHeroId() > 0 then
    costNum = refactorNum * ConfigData.game_config.athRefactorCostRateAfterSign
  else
    costNum = refactorNum
  end
  self._selectedAthUidList = {}
  local athDataList = self.athRefactorList:GetAthScrollListCurAthList()
  for k, v in ipairs(athDataList) do
    if costNum <= #self._selectedAthUidList then
      break
    end
    if self._selectedAthUidDic[v.uid] then
      table.insert(self._selectedAthUidList, v.uid)
    end
  end
end

function UIAthRefactor:__OnMatExpAdd()
  local itemDic = self.athMatUpNode:GetAthMatExpAddItemDic()
  for itemId, num in pairs(itemDic) do
    self._seletedMatNum = num
    break
  end
  self:_UpdSelectedAth()
  self:_UpdAthMatAddLimit(self._seletedMatNum)
  self:_UpdRefactorState()
end

function UIAthRefactor:_UpdAthMatAddLimit(addExp)
  local limitNum
  if self.athData:GetAthSignHeroId() > 0 then
    limitNum = ConfigData.game_config.athRefactorNum * ConfigData.game_config.athRefactorCostRateAfterSign - self._seletedAthNum
  else
    limitNum = ConfigData.game_config.athRefactorNum - self._seletedAthNum
  end
  self.athMatUpNode:SetAthAddExpLimt(limitNum, self._seletedMatNum)
end

function UIAthRefactor:_UpdRefactorState()
  local totalNum = self._seletedMatNum + self._seletedAthNum
  local costNum = totalNum
  local refactorNum = self:GetRefactorNum()
  if self.athData:GetAthSignHeroId() > 0 then
    local remainNum = totalNum % ConfigData.game_config.athRefactorCostRateAfterSign
    costNum = totalNum - remainNum
    self.ui.tex_CostAthNum:SetIndex(1, tostring(refactorNum), remainNum, tostring(ConfigData.game_config.athRefactorCostRateAfterSign))
    if refactorNum >= ConfigData.game_config.athRefactorNum then
      self.ui.tex_CostAthNum:SetIndex(2, tostring(refactorNum))
    end
  else
    self.ui.tex_CostAthNum:SetIndex(0, tostring(totalNum), ConfigData.game_config.athRefactorNum)
  end
  self.athDetailNode:UpdAthRfctDetailConsumeItem(costNum)
  self.athDetailNode:RefreshCanRefactorBtn(refactorNum)
end

function UIAthRefactor:_OnClickClose()
  self:Delete()
end

function UIAthRefactor:GetRefactorNum()
  local refactorNum
  if self.athData:GetAthSignHeroId() > 0 then
    refactorNum = (self._seletedAthNum + self._seletedMatNum) // ConfigData.game_config.athRefactorCostRateAfterSign
  else
    refactorNum = self._seletedAthNum + self._seletedMatNum
  end
  return refactorNum
end

function UIAthRefactor:CanAthRefactor(withTips)
  local allLock = true
  for k, affixElem in ipairs(self.athData.affixList) do
    if not affixElem.lock then
      allLock = false
    end
  end
  if allLock then
    if withTips then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(4003))
    end
    return false
  end
  local refactorNum = self:GetRefactorNum()
  if refactorNum == 0 then
    if withTips then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(4002))
    end
    return false
  end
  for k, itemId in ipairs(ConfigData.game_config.athRefactorConsumeItemId) do
    local consumeNum = ConfigData.game_config.athRefactorConsumeItemNum[k]
    local itemCfg = ConfigData.item[itemId]
    local consumeItemCount = PlayerDataCenter:GetItemCount(itemId)
    if consumeNum > consumeItemCount then
      if withTips then
        local name = LanguageUtil.GetLocaleText(itemCfg.name)
        cs_MessageCommon.ShowMessageTipsWithErrorSound(name .. ConfigData:GetTipContent(TipContent.arithmetic_optimal_ItemInsufficient))
      end
      return false
    end
  end
  return true
end

function UIAthRefactor:SendAthRefactor()
  if not self:CanAthRefactor(true) then
    return
  end
  if self.__OnRefactorComplete == nil then
    self.__OnRefactorComplete = BindCallback(self, self._OnRefactorComplete)
  end
  local refactorNum = self:GetRefactorNum()
  
  local function refactorFunc()
    self.athNetwork:CS_ATH_ReconsitutionExec(self.athData.uid, self._selectedAthUidList, refactorNum, self.__OnRefactorComplete)
  end
  
  if self.athData:GetAthSignHeroId() > 0 then
    local costTotalNum = refactorNum * ConfigData.game_config.athRefactorCostRateAfterSign
    UIManager:ShowWindowAsync(UIWindowTypeID.AthRefactorConfirm, function(win)
      if win == nil then
        return
      end
      win:InitAthRefactorConfirm(self._selectedAthUidList, refactorNum, costTotalNum, refactorFunc)
    end)
    return
  end
  refactorFunc()
end

function UIAthRefactor:_OnRefactorComplete()
  self._seletedAthNum = 0
  self._seletedMatNum = 0
  self._selectedAthUidDic = {}
  self.athRefactorList:SetAthScrollListMultSeletedUidDic(self._selectedAthUidDic)
  self.athRefactorList:RefreshAthScrollListData()
  self.athRefactorList:RefillAthScrollList(nil, nil, true)
  self:_UpdRefactorState()
  self.athMatUpNode:CleanAllAthUpMat()
  self.athMatUpNode:InitAthMatUp(self.__OnMatExpAddFunc, ConfigData.game_config.athRefactorTokenIdList)
  self:_UpdAthMatAddLimit(0)
  AthUtil.ShowAthRefactorSuccess(self.athData, self.heroData)
end

function UIAthRefactor:SendAthAffixLock(affixIdx)
  if self.__OnAffixLockComplete == nil then
    self.__OnAffixLockComplete = BindCallback(self, self._OnAffixLockComplete)
  end
  self._lockAffxIndex = affixIdx
  self.athNetwork:CS_ATH_AffixLockUnlock(self.athData.uid, affixIdx - 1, self.__OnAffixLockComplete)
end

function UIAthRefactor:_OnAffixLockComplete()
  local affixElem = self.athData.affixList[self._lockAffxIndex]
  if affixElem == nil then
    error("Cant get affixElem, index = " .. tostring(self._lockAffxIndex))
    return
  end
  self.athDetailNode:RefreshAthAffixLock(self._lockAffxIndex)
end

function UIAthRefactor:ResetAthRefactor()
  self.athDetailNode:RefreshRfctDetailSubAttr()
end

function UIAthRefactor:_OnAthLockPre(athUid)
  local athData = PlayerDataCenter.allAthData.athDic[athUid]
  if athData:IsAthLock() or self._selectedAthUidDic[athUid] == nil then
    return
  end
  self._selectedAthUidDic[athUid] = nil
  self._seletedAthNum = self._seletedAthNum - 1
  self:_UpdAthMatAddLimit(self._seletedMatNum)
  self.athRefactorList:SetAthScrollListMultSeletedUidDic(self._selectedAthUidDic)
  self:_UpdRefactorState()
end

function UIAthRefactor:_OnAthDataUpdate()
  self.athRefactorList:RefillAthScrollList(nil, nil, true)
end

function UIAthRefactor:OnDelete()
  UIManager:DeleteWindow(UIWindowTypeID.AthRefactorSuccess)
  UIManager:DeleteWindow(UIWindowTypeID.AthRefactorSuccessExtra)
  UIManager:HideWindow(UIWindowTypeID.AthItemDetailFloat)
  MsgCenter:RemoveListener(eMsgEventId.OnAthLockPre, self._onAthLockPreFunc)
  MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
  self.athRefactorList:Delete()
  self.athDetailNode:Delete()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  base.OnDelete(self)
end

return UIAthRefactor

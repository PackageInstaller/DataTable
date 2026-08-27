local UIAthDecompose = class("UIAthDecompose", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINAthList = require("Game.Arithmetic.AthList.UINAthList")
local UINAthDecomposeFilter = require("Game.Arithmetic.Decompose.Filter.UINAthDecomposeFilter")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local cs_MessageCommon = CS.MessageCommon

function UIAthDecompose:OnInit()
  UIUtil.SetTopStatus(self, self.Delete)
  UIUtil.AddButtonListener(self.ui.btn_Decompose, self, self._OnClickDecompose)
  UIUtil.AddButtonListener(self.ui.btn_Reset, self, self.__OnClickReset)
  self.__OnClickAthItemFunc = BindCallback(self, self._OnClickAthItem)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
  self.ui.uINBaseItemWithCount:SetActive(false)
  self.shardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount)
  self.athListNode = UINAthList.New(true)
  self.athListNode:Init(self.ui.aTHListNode)
  self.athListNode:SetAthListSelectAllFunc(BindCallback(self, self._OnSelectAll))
  local filterNode = UINAthDecomposeFilter.New()
  filterNode:Init(self.ui.filterNode)
  filterNode:SetAthDecomposeFilterFunc(BindCallback(self, self._OnFilterChange))
  self._filterNode = filterNode
  self._onAthLockPreFunc = BindCallback(self, self._OnAthLockPre)
  MsgCenter:AddListener(eMsgEventId.OnAthLockPre, self._onAthLockPreFunc)
end

function UIAthDecompose:InitAthDecompose(heroData, resLoader, closeFunc)
  self.closeFunc = closeFunc
  self.athSelectedDic = {}
  self.athListNode.athListArea:SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
  self.athListNode:InitAthListNode(heroData, resLoader, false, self.__OnClickAthItemFunc, nil, nil, nil, true)
  self.athListNode:EnableAthListDecomposeMode()
  self._filterNode:InitAthDecomposeFilter(true)
  self:_RefreshSelectedList()
end

function UIAthDecompose:_RefreshSelectedList()
  local shardItemDic = table.GetDefaulValueTable(0)
  local shardItemIdList = {}
  local curSelectedAthList = {}
  for uid, v in pairs(self.athSelectedDic) do
    local athData = PlayerDataCenter.allAthData.athDic[uid]
    local quality = athData:GetAthQuality()
    local size = athData:GetAthSize()
    local shardQCfg = ConfigData.ath_shard[quality]
    if shardQCfg == nil then
      error("Cant get ath_shard, quality = " .. tostring(quality))
    else
      local shardCfg = shardQCfg[size]
      if shardCfg == nil then
        error(string.format("Cant get ath_shard, quality: %s, size: %s", quality, size))
      else
        for index, itemId in ipairs(shardCfg.shardIdList) do
          local itemNum = shardCfg.shardNumList[index]
          if shardItemDic[itemId] == 0 then
            table.insert(shardItemIdList, itemId)
          end
          shardItemDic[itemId] = shardItemDic[itemId] + itemNum
        end
        table.insert(curSelectedAthList, athData)
      end
    end
  end
  local selectedNum = #curSelectedAthList
  local canDecompose = 0 < selectedNum
  self.ui.btn_Decompose.interactable = canDecompose
  table.sort(shardItemIdList)
  self.shardItemPool:HideAll()
  for k, itemId in ipairs(shardItemIdList) do
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("Can`t find ItemCfg:ID = " .. tostring(itemId))
      goto lbl_111
      return
    end
    local num = shardItemDic[itemId]
    local item = self.shardItemPool:GetOne()
    item:InitItemWithCount(itemCfg, num)
    ::lbl_111::
  end
end

function UIAthDecompose:_OnClickDecompose()
  local hasOrangeAth = false
  local orange2SizeAthNum = 0
  for uid, v in pairs(self.athSelectedDic) do
    local athData = PlayerDataCenter.allAthData.athDic[uid]
    if athData:GetAthQuality() == eItemQualityType.Orange then
      hasOrangeAth = true
      if athData:GetAthSize() >= 2 then
        orange2SizeAthNum = orange2SizeAthNum + 1
      end
    end
  end
  if self.__OnDecomposeCompleteFunc == nil then
    self.__OnDecomposeCompleteFunc = BindCallback(self, self._OnDecomposeComplete)
  end
  
  local function requestFunc()
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    self.athNetwork:CS_ATH_OneKeyDeco(self.athSelectedDic, self.__OnDecomposeCompleteFunc)
  end
  
  if hasOrangeAth then
    local function confimFunc()
      if orange2SizeAthNum >= ConfigData.game_config.athDecomposeOrange2SizeWarnNum then
        local msgWin = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
        
        msgWin:ShowTextBoxWithYesAndNo(string.format(ConfigData:GetTipContent(148), orange2SizeAthNum), requestFunc, nil, true)
      else
        requestFunc()
      end
    end
    
    UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
      if win == nil then
        return
      end
      local msg = ConfigData:GetTipContent(TipContent.Ath_EfficiencyUpContainOrangeAth)
      win:ShowTextBoxWithYesAndNo(msg, confimFunc, nil)
    end)
  else
    requestFunc()
  end
end

function UIAthDecompose:_OnDecomposeComplete(objList)
  if objList.Count ~= 1 then
    error("objList.Count error:" .. tostring(objList.Count))
    return
  end
  local resDic = objList[0]
  local rewardIds = {}
  local rewardNums = {}
  for id, num in pairs(resDic) do
    table.insert(rewardIds, id)
    table.insert(rewardNums, num)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window == nil then
      return
    end
    local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRHeroSnapshoot(self._heroIdSnapShoot)
    window:AddAndTryShowReward(CRData)
  end)
  self:_ResetDeco()
end

function UIAthDecompose:_ResetDeco()
  self._filterNode:InitAthDecomposeFilter(true)
  self:_OnFilterChange(nil, nil)
  self.athSelectedDic = {}
  self.athListNode.athListArea:SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
  self.athListNode:RefillCurAthSortList(true)
  self:_RefreshSelectedList()
end

function UIAthDecompose:_ShowAthDetailFloat(athData)
  UIManager:ShowWindowAsync(UIWindowTypeID.AthItemDetailFloat, function(window)
    if window == nil then
      return
    end
    window:InitAthDetailFloat(athData)
  end)
end

function UIAthDecompose:_OnClickAthItem(athItem)
  local athData = athItem:GetAthItemData()
  if athData:IsAthLock() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_CantSelectLockAth))
    self:_ShowAthDetailFloat(athData)
    return
  end
  if self.athSelectedDic[athData.uid] == nil then
    self.athSelectedDic[athData.uid] = true
    athItem:SetAthItemSelect(true, true)
    self:_ShowAthDetailFloat(athData)
  else
    self.athSelectedDic[athData.uid] = nil
    athItem:SetAthItemSelect(false)
  end
  self.athListNode.athListArea:SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
  self:_RefreshSelectedList()
end

function UIAthDecompose:__OnClickReset()
  self:_ResetDeco()
end

function UIAthDecompose:_OnFilterChange(filterFunc, isClickFilter)
  self.athListNode.athListArea.athScrollList:SetAthScrollListSiftFunc(filterFunc)
  if isClickFilter and not table.IsEmptyTable(self.athSelectedDic) then
    self.athSelectedDic = {}
    self.athListNode.athListArea:SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
    self:_RefreshSelectedList()
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(149))
  end
  self.athListNode:RefillCurAthSortList(true)
end

function UIAthDecompose:_OnSelectAll()
  local athDataList = self.athListNode.athListArea.athScrollList:GetAthScrollListCurAthList()
  for k, athData in ipairs(athDataList) do
    if not athData:IsAthLock() then
      self.athSelectedDic[athData.uid] = true
    end
  end
  self.athListNode.athListArea:SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
  self.athListNode:RefillCurAthSortList(true)
  self:_RefreshSelectedList()
end

function UIAthDecompose:_OnAthLockPre(athUid)
  local athData = PlayerDataCenter.allAthData.athDic[athUid]
  if athData:IsAthLock() or self.athSelectedDic[athUid] == nil then
    return
  end
  self.athSelectedDic[athUid] = nil
  self.athListNode.athListArea:SetAthListAreaMultSeletedUidDic(self.athSelectedDic)
  self:_RefreshSelectedList()
end

function UIAthDecompose:OnDelete()
  if self.closeFunc ~= nil then
    self.closeFunc()
  end
  MsgCenter:RemoveListener(eMsgEventId.OnAthLockPre, self._onAthLockPreFunc)
  self.shardItemPool:DeleteAll()
  UIManager:HideWindow(UIWindowTypeID.AthItemDetailFloat)
  self.athListNode:Delete()
  self._filterNode:Delete()
  base.OnDelete(self)
end

return UIAthDecompose

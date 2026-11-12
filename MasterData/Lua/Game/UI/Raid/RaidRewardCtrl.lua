local RaidRewardCtrl = class("RaidRewardCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local ONE_LINE = 165
local TWO_LINE = 302
RaidRewardCtrl._mapNodeConfig = {
  txtWindowTitle = {sComponentName = "TMP_Text"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  txtWorldClassCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_Name"
  },
  txtWorldClass = {sComponentName = "TMP_Text"},
  txtExpMaxCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_ExpMax"
  },
  txtExpCur = {sComponentName = "TMP_Text"},
  txtExpMax = {sComponentName = "TMP_Text"},
  imgBar = {sComponentName = "Image"},
  txtAllExpCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_AllExp"
  },
  txtAllExp = {sComponentName = "TMP_Text"},
  goAll = {},
  btnReview = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Review"
  },
  txtBtnReview = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_Btn_Review"
  },
  btnAll = {
    nCount = 7,
    sComponentName = "UIButton",
    callback = "OnBtnClick_TipAll"
  },
  goAllItem = {
    nCount = 7,
    sNodeName = "btnAll",
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  txtAllCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_AllResult"
  },
  txtAllRaidReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_Reward"
  },
  srList = {
    sComponentName = "LoopScrollView"
  },
  btnConfirm2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  },
  btnSkip = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Skip"
  },
  txtBtnSkip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_Btn_Skip"
  }
}
RaidRewardCtrl._mapEventConfig = {}

function RaidRewardCtrl:Open(tbReward, mapLevelBefore, mapChangeInfo, aniReward)
  self:RefreshData(tbReward, mapChangeInfo)
  self:RefreshInfo()
  self:RefreshList()
  self:RefreshResult()
  self:PlayInAni(aniReward)
  self:RefreshExp(mapLevelBefore.nLevel, mapLevelBefore.nExp)
  self:PlayExpAni(mapLevelBefore)
end

function RaidRewardCtrl:RefreshData(tbReward, mapChangeInfo)
  self.tbGridHeight = {}
  self.nExp = 0
  self.tbReward = {}
  local tbAfter = {}
  local tbAfterDouble = {}
  for k, v in pairs(tbReward) do
    self.nExp = self.nExp + v.Exp
    if not self.tbReward[k] then
      self.tbReward[k] = {}
    end
    if v.Select ~= nil then
      for _, mapReward in pairs(v.Select) do
        if 0 < mapReward.Id then
          table.insert(self.tbResult, {
            Id = mapReward.Id,
            Tid = mapReward.Tid,
            Qty = mapReward.Qty,
            Rarity = ConfigTable.GetData_Item(mapReward.Tid).Rarity,
            ExtraDrop = 0
          })
        else
          if not tbAfter[mapReward.Tid] then
            tbAfter[mapReward.Tid] = 0
          end
          tbAfter[mapReward.Tid] = tbAfter[mapReward.Tid] + mapReward.Qty
        end
        table.insert(self.tbReward[k], {
          Id = mapReward.Id,
          Tid = mapReward.Tid,
          Qty = mapReward.Qty,
          Rarity = ConfigTable.GetData_Item(mapReward.Tid).Rarity,
          ExtraDrop = 0
        })
      end
    end
    if v.AwardItems ~= nil then
      for _, mapReward in pairs(v.AwardItems) do
        if not tbAfter[mapReward.Tid] then
          tbAfter[mapReward.Tid] = 0
        end
        tbAfter[mapReward.Tid] = tbAfter[mapReward.Tid] + mapReward.Qty
        table.insert(self.tbReward[k], {
          Id = 0,
          Tid = mapReward.Tid,
          Qty = mapReward.Qty,
          Rarity = ConfigTable.GetData_Item(mapReward.Tid).Rarity,
          ExtraDrop = 0
        })
      end
    end
    if v.CustomItems ~= nil then
      for _, mapReward in pairs(v.CustomItems) do
        if not tbAfter[mapReward.Tid] then
          tbAfter[mapReward.Tid] = 0
        end
        tbAfter[mapReward.Tid] = tbAfter[mapReward.Tid] + mapReward.Qty
        table.insert(self.tbReward[k], {
          Id = 0,
          Tid = mapReward.Tid,
          Qty = mapReward.Qty,
          Rarity = ConfigTable.GetData_Item(mapReward.Tid).Rarity,
          ExtraDrop = 0
        })
      end
    end
    if v.DoubleItems ~= nil then
      for _, mapReward in pairs(v.DoubleItems) do
        if not tbAfterDouble[mapReward.Tid] then
          tbAfterDouble[mapReward.Tid] = 0
        end
        tbAfterDouble[mapReward.Tid] = tbAfterDouble[mapReward.Tid] + mapReward.Qty
        table.insert(self.tbReward[k], {
          Id = 0,
          Tid = mapReward.Tid,
          Qty = mapReward.Qty,
          Rarity = ConfigTable.GetData_Item(mapReward.Tid).Rarity,
          ExtraDrop = AllEnum.RewardType.Double
        })
      end
    end
    local nOnceCount = #self.tbReward[k]
    table.insert(self.tbGridHeight, nOnceCount <= 8 and ONE_LINE or TWO_LINE)
  end
  self.tbResult = {}
  for k, v in pairs(tbAfter) do
    table.insert(self.tbResult, {
      Id = 0,
      Tid = k,
      Qty = v,
      Rarity = ConfigTable.GetData_Item(k).Rarity,
      ExtraDrop = 0
    })
  end
  for k, v in pairs(tbAfterDouble) do
    table.insert(self.tbResult, {
      Id = 0,
      Tid = k,
      Qty = v,
      Rarity = ConfigTable.GetData_Item(k).Rarity,
      ExtraDrop = AllEnum.RewardType.Double
    })
  end
  for k, _ in pairs(self.tbReward) do
    table.sort(self.tbReward[k], function(a, b)
      if a.ExtraDrop == b.ExtraDrop then
        if a.Rarity ~= b.Rarity then
          return a.Rarity < b.Rarity
        else
          return a.Tid < b.Tid
        end
      end
      return a.ExtraDrop < b.ExtraDrop
    end)
  end
  table.sort(self.tbResult, function(a, b)
    if a.ExtraDrop == b.ExtraDrop then
      if a.Rarity ~= b.Rarity then
        return a.Rarity < b.Rarity
      else
        return a.Tid < b.Tid
      end
    end
    return a.ExtraDrop < b.ExtraDrop
  end)
end

function RaidRewardCtrl:RefreshInfo()
  NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, ConfigTable.GetUIText("Raid_Title_Doing"))
end

function RaidRewardCtrl:RefreshExp(nWorldClass, nCurExp)
  local mapCfg = ConfigTable.GetData("WorldClass", nWorldClass + 1, true)
  local nFullExp = 0
  if mapCfg then
    nFullExp = mapCfg.Exp
  end
  local bMax = nFullExp == 0
  self._mapNode.txtExpMax.gameObject:SetActive(not bMax)
  self._mapNode.txtExpMaxCn.gameObject:SetActive(bMax)
  NovaAPI.SetTMPText(self._mapNode.txtWorldClass, nWorldClass)
  if not bMax then
    NovaAPI.SetImageFillAmount(self._mapNode.imgBar, nCurExp / nFullExp)
    NovaAPI.SetTMPText(self._mapNode.txtExpCur, nCurExp)
    NovaAPI.SetTMPText(self._mapNode.txtExpMax, "/" .. nFullExp)
  else
    NovaAPI.SetImageFillAmount(self._mapNode.imgBar, 1)
  end
end

function RaidRewardCtrl:RefreshList()
  self._mapNode.srList:InitEx(self.tbGridHeight, self, self.OnGridRefresh)
end

function RaidRewardCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbReward[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  local nOnceCount = #self.tbReward[nIndex]
  local goItem = goGrid.transform:Find("imgBg/btnItem").gameObject
  local imgR1 = goGrid.transform:Find("imgBg/imgR1").gameObject
  local imgR2 = goGrid.transform:Find("imgBg/imgR2").gameObject
  local txtRaidCount = goGrid.transform:Find("imgBg/txtRaidCount"):GetComponent("TMP_Text")
  local txtRaidReward = goGrid.transform:Find("imgBg/txtRaidReward"):GetComponent("TMP_Text")
  local trItem = goGrid.transform:Find("imgBg/trItem")
  imgR1:SetActive(nOnceCount <= 8)
  imgR2:SetActive(8 < nOnceCount)
  NovaAPI.SetTMPText(txtRaidCount, orderedFormat(ConfigTable.GetUIText("Raid_Count"), nIndex))
  NovaAPI.SetTMPText(txtRaidReward, ConfigTable.GetUIText("Raid_Reward"))
  
  local function func_add()
    local goItemObj = instantiate(goItem, trItem)
    goItemObj:SetActive(true)
    local ctrlItem = self:BindCtrlByNode(goItemObj, "Game.UI.TemplateEx.TemplateItemCtrl")
    return ctrlItem
  end
  
  if not self.tbGridObj[nInstanceID] then
    self.tbGridObj[nInstanceID] = {}
    for _ = 1, nOnceCount do
      local ctrlItem = func_add()
      table.insert(self.tbGridObj[nInstanceID], ctrlItem)
    end
  end
  local nAll = 0
  local nBeforeCount = #self.tbGridObj[nInstanceID]
  if nOnceCount > nBeforeCount then
    nAll = nOnceCount
    for _ = nBeforeCount + 1, nOnceCount do
      local ctrlItem = func_add()
      table.insert(self.tbGridObj[nInstanceID], ctrlItem)
    end
  else
    nAll = nBeforeCount
  end
  for i = 1, nAll do
    if mapData[i] then
      self.tbGridObj[nInstanceID][i].gameObject:SetActive(true)
      self.tbGridObj[nInstanceID][i]:SetItem(mapData[i].Tid, nil, mapData[i].Qty, nil, nil, nil, nil, true, nil, nil, mapData[i].ExtraDrop == 1, mapData[i].ExtraDrop == AllEnum.RewardType.Double)
      if mapData[i].ExtraDrop == AllEnum.RewardType.Double then
        local goThisGrid = self.tbGridObj[nInstanceID][i].gameObject
        local imgExtra = goThisGrid.transform:Find("AnimRoot/tc_item_02").transform:GetChild(5):GetChild(8).gameObject
        local imgReengagement = goThisGrid.transform:Find("AnimRoot/tc_item_02").transform:GetChild(5):GetChild(9).gameObject
        imgExtra:SetActive(true)
        imgReengagement:SetActive(false)
      end
    else
      self.tbGridObj[nInstanceID][i].gameObject:SetActive(false)
    end
  end
end

function RaidRewardCtrl:RefreshResult()
  for i = 1, 7 do
    self._mapNode.goAllItem[i].gameObject:SetActive(false)
    if self.tbResult[i] then
      self._mapNode.goAllItem[i]:SetItem(self.tbResult[i].Tid, nil, self.tbResult[i].Qty, nil, nil, nil, nil, true, nil, nil, self.tbResult[i].ExtraDrop == 1, self.tbResult[i].ExtraDrop == AllEnum.RewardType.Double)
      if self.tbResult[i].ExtraDrop == AllEnum.RewardType.Double then
        local goGrid = self._mapNode.goAllItem[i].gameObject
        local imgExtra = goGrid.transform:Find("AnimRoot/tc_item_02").transform:GetChild(5):GetChild(8).gameObject
        local imgReengagement = goGrid.transform:Find("AnimRoot/tc_item_02").transform:GetChild(5):GetChild(9).gameObject
        imgExtra:SetActive(true)
        imgReengagement:SetActive(false)
      end
    end
  end
  self._mapNode.btnReview.gameObject:SetActive(7 < #self.tbResult)
end

function RaidRewardCtrl:PlayInAni(aniReward)
  self.gameObject:SetActive(true)
  self._mapNode.goAll:SetActive(false)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self._mapNode.btnClose.gameObject:SetActive(false)
  self._mapNode.btnConfirm2.gameObject:SetActive(false)
  self._mapNode.btnSkip.gameObject:SetActive(true)
  local nCount = #self.tbReward
  local nTime = 0
  if nCount < 15 then
    nTime = 0.15 * nCount
  elseif 15 <= nCount and nCount < 35 then
    nTime = 0.1 * nCount
  elseif 35 <= nCount then
    nTime = 0.05 * nCount
  end
  self.tweener = self._mapNode.srList:DOVerticalNormalizedPos(0, nTime):SetEase(Ease.OutSine):SetUpdate(true)
  self.tweener2 = DOTween.To(function()
    return 0
  end, function(v)
    NovaAPI.SetTMPText(self._mapNode.txtAllExp, math.floor(v))
  end, self.nExp, nTime):SetEase(Ease.OutSine):SetUpdate(true)
  
  local function func_in()
    self._mapNode.btnClose.gameObject:SetActive(true)
    self._mapNode.btnConfirm2.gameObject:SetActive(true)
    self._mapNode.btnSkip.gameObject:SetActive(false)
    self._mapNode.goAll:SetActive(true)
    aniReward:Play("RaidPanel_in")
    
    local function wait()
      for i = 1, 7 do
        if self.tbResult[i] then
          self._mapNode.goAllItem[i].gameObject:SetActive(true)
          coroutine.yield(CS.UnityEngine.WaitForSeconds(0.04))
        end
      end
    end
    
    cs_coroutine.start(wait)
    NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, ConfigTable.GetUIText("Raid_Title_Complete"))
    self:AddTimer(1, 0.1, function()
      PlayerData.Base:TryOpenWorldClassUpgrade()
      EventManager.Hit("RaidEnableClose")
    end, true, true, true)
  end
  
  self.tweener.onComplete = dotween_callback_handler(self, func_in)
end

function RaidRewardCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function RaidRewardCtrl:PlayExpAni(mapBefore)
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local mapCfg = ConfigTable.GetData("WorldClass", nWorldClass + 1, true)
  local nFullExp = mapCfg and mapCfg.Exp or 0
  local mapAfter = {
    nLevel = nWorldClass,
    nExp = PlayerData.Base:GetWorldExp(),
    nMaxLevel = PlayerData.Base:GetMaxWorldClass(),
    nMaxExp = nFullExp
  }
  local bMaxLv = mapAfter.nLevel == mapAfter.nMaxLevel
  local nAddLevel = mapAfter.nLevel - mapBefore.nLevel
  local nAddCount = 0
  if nAddLevel == 0 then
    nAddCount = 1
  elseif 0 < mapAfter.nExp then
    nAddCount = nAddLevel + 1
  else
    nAddCount = nAddLevel
  end
  local nCount = #self.tbReward
  local nAllTime = 0
  if nCount < 15 then
    nAllTime = 0.15 * nCount
  elseif 15 <= nCount and nCount < 35 then
    nAllTime = 0.1 * nCount
  elseif 35 <= nCount then
    nAllTime = 0.05 * nCount
  end
  local nAniTime = nAllTime / nAddCount
  local nBeforeToMaxTime = nAniTime
  local nBeforeToAfterTime = nAniTime
  local nZeroToAfterTime = nAniTime
  local nMaxExp = mapBefore.nMaxExp
  self.sequence = DOTween.Sequence()
  for i = 1, nAddCount - 1 do
    local nTime = i == 1 and nBeforeToMaxTime or nAniTime
    self.sequence:AppendCallback(function()
      WwiseAudioMgr:PlaySound("ui_common_levelUp")
    end)
    local tweener = NovaAPI.ImageDoFillAmount(self._mapNode.imgBar, 1, nTime, false)
    self.sequence:Append(tweener)
    self.sequence:Join(DOTween.To(function()
      return i == 1 and mapBefore.nExp or 0
    end, function(v)
      NovaAPI.SetTMPText(self._mapNode.txtExpCur, math.floor(v))
    end, nMaxExp, nTime))
    self.sequence:AppendCallback(function()
      NovaAPI.SetImageFillAmount(self._mapNode.imgBar, 0)
      NovaAPI.SetTMPText(self._mapNode.txtWorldClass, mapBefore.nLevel + i)
      local mapAfterCfg = ConfigTable.GetData("WorldClass", mapBefore.nLevel + i + 1, true)
      nMaxExp = mapAfterCfg and mapAfterCfg.Exp or 0
      NovaAPI.SetTMPText(self._mapNode.txtExpMax, "/" .. nMaxExp)
    end)
  end
  if bMaxLv then
    local nTime = 1 < nAddCount and nAniTime or nBeforeToMaxTime
    self.sequence:AppendCallback(function()
      WwiseAudioMgr:PlaySound("ui_common_levelUp")
    end)
    local tweener = NovaAPI.ImageDoFillAmount(self._mapNode.imgBar, 1, nTime, false)
    self.sequence:Append(tweener)
    self.sequence:Join(DOTween.To(function()
      return nAddCount <= 1 and mapBefore.nExp or 0
    end, function(v)
      NovaAPI.SetTMPText(self._mapNode.txtExpCur, math.floor(v))
    end, nMaxExp, nTime))
  elseif mapAfter.nExp > 0 then
    local nTime = 1 < nAddCount and nZeroToAfterTime or nBeforeToAfterTime
    self.sequence:AppendCallback(function()
      WwiseAudioMgr:PlaySound("ui_common_levelUp")
    end)
    local tweener = NovaAPI.ImageDoFillAmount(self._mapNode.imgBar, mapAfter.nExp / mapAfter.nMaxExp, nTime, false)
    self.sequence:Append(tweener)
    self.sequence:Join(DOTween.To(function()
      return nAddCount <= 1 and mapBefore.nExp or 0
    end, function(v)
      NovaAPI.SetTMPText(self._mapNode.txtExpCur, math.floor(v))
    end, mapAfter.nExp, nTime))
  elseif mapAfter.nExp == 0 then
    local nTime = 1 < nAddCount and nAniTime or nBeforeToMaxTime
    self.sequence:AppendCallback(function()
      WwiseAudioMgr:PlaySound("ui_common_levelUp")
    end)
    local tweener = NovaAPI.ImageDoFillAmount(self._mapNode.imgBar, 1, nTime, false)
    self.sequence:Append(tweener)
    self.sequence:Join(DOTween.To(function()
      return nAddCount <= 1 and mapBefore.nExp or 0
    end, function(v)
      NovaAPI.SetTMPText(self._mapNode.txtExpCur, math.floor(v))
    end, nMaxExp, nTime))
    self.sequence:AppendCallback(function()
      NovaAPI.SetImageFillAmount(self._mapNode.imgBar, 0)
    end)
  end
  self.sequence:SetUpdate(true)
  
  local function _cb()
    NovaAPI.SetTMPText(self._mapNode.txtWorldClass, mapAfter.nLevel)
    self:RefreshExp(mapAfter.nLevel, mapAfter.nExp)
  end
  
  self.sequence.onComplete = dotween_callback_handler(self, _cb)
end

function RaidRewardCtrl:Close()
  self.gameObject:SetActive(false)
end

function RaidRewardCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
  self.tbGridObj = {}
end

function RaidRewardCtrl:OnEnable()
end

function RaidRewardCtrl:OnDisable()
  for _, list in pairs(self.tbGridObj) do
    for _, v in ipairs(list) do
      local obj = v.gameObject
      self:UnbindCtrlByNode(v)
      destroy(obj)
    end
  end
  self.tbGridObj = {}
end

function RaidRewardCtrl:OnDestroy()
end

function RaidRewardCtrl:OnBtnClick_Cancel(btn)
  if self.sequence then
    self.sequence:Kill(true)
    self.sequence = nil
  end
  EventManager.Hit("RaidShowPop", false)
end

function RaidRewardCtrl:OnBtnClick_Review(btn)
  local tbList = {}
  for _, v in pairs(self.tbResult) do
    table.insert(tbList, {
      nId = v.Tid,
      nCount = v.Qty,
      bExtraDrop = v.ExtraDrop == 1,
      bDoubleDrop = v.ExtraDrop == AllEnum.RewardType.Double
    })
  end
  local msg = {
    nType = AllEnum.MessageBox.ItemList,
    tbItem = tbList,
    bBlur = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function RaidRewardCtrl:OnBtnClick_TipAll(btn, nIndex)
  UTILS.ClickItemGridWithTips(self.tbResult[nIndex].Tid, btn.transform, false, true, false)
end

function RaidRewardCtrl:OnBtnClick_Skip(btn)
  if self.tweener then
    self.tweener:Kill(true)
    self.tweener = nil
  end
  if self.tweener2 then
    self.tweener2:Kill(true)
    self.tweener2 = nil
  end
  if self.sequence then
    self.sequence:Kill(true)
    self.sequence = nil
  end
end

return RaidRewardCtrl

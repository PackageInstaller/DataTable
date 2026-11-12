local GachaHistotyCtrl = class("GachaHistotyCtrl", BaseCtrl)
GachaHistotyCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Recruit_history"
  },
  TMPDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "GachaHistory_Desc"
  },
  DD_PoolSelect = {
    sComponentName = "TMP_Dropdown",
    callback = "OnDD_SelectPool"
  },
  imgBtnPerv = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_PrevPage"
  },
  imgBtnNext = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NextPage"
  },
  TMPPage = {sComponentName = "TMP_Text"},
  TMPType = {sComponentName = "TMP_Text", nCount = 5},
  TMPName = {
    sNodeName = "TMPHistoryName",
    sComponentName = "TMP_Text",
    nCount = 5
  },
  TMPTag = {sComponentName = "TMP_Text", nCount = 5},
  TMPTime = {sComponentName = "TMP_Text", nCount = 5},
  ImgRare = {sComponentName = "Image", nCount = 5},
  imgSSRBg = {nCount = 5},
  imgUPMark = {nCount = 5},
  TMPUPMarkTitle = {
    sComponentName = "TMP_Text",
    nCount = 5,
    sLanguageId = "Gacha_History_UPMark"
  },
  imgTypeIconChar = {nCount = 5},
  imgTypeIconDisc = {nCount = 5},
  btnCloseScreen = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  btnClose = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  rtGachaHistory = {sComponentName = "Animator"},
  imgDDUp = {},
  imgDDDown = {},
  TMPTypeTitle = {
    sNodeName = "TMPType",
    sComponentName = "TMP_Text",
    sLanguageId = "GachaHistory_Type"
  },
  TMPRareTitle = {
    sNodeName = "TMPRare",
    sComponentName = "TMP_Text",
    sLanguageId = "GachaHistory_Rank"
  },
  TMPNameTitle = {
    sNodeName = "TMPNameHistoryTitle",
    sComponentName = "TMP_Text",
    sLanguageId = "GachaHistory_Name"
  },
  TMPTagTitle = {
    sNodeName = "TMPTag",
    sComponentName = "TMP_Text",
    sLanguageId = "GachaHistory_Tag"
  },
  TMPTimeTitle = {
    sNodeName = "TMPTime",
    sComponentName = "TMP_Text",
    sLanguageId = "GachaHistory_Time"
  },
  imgDown = {sComponentName = "Image"},
  imgPrev = {sComponentName = "Image"},
  rtEmpty = {},
  TMPEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Recruit_history_empty"
  },
  txtBtnGuarantee = {
    sComponentName = "TMP_Text",
    sLanguageId = "GachaHistory_Guarantee"
  },
  txtBtnHistory = {
    sComponentName = "TMP_Text",
    sLanguageId = "GachaHistory_History"
  },
  rtContentHistory = {},
  rtGachaGuarantee = {
    sCtrlName = "Game.UI.GachaEx.GachaGuaranteeCtrl"
  },
  btn_Guarantee = {
    sComponentName = "Button",
    callback = "OnBtnClick_Guarantee"
  },
  btn_History = {
    sComponentName = "Button",
    callback = "OnBtnClick_History"
  }
}
GachaHistotyCtrl._mapEventConfig = {
  DropdownOpenState = "OnEvent_Open"
}

function GachaHistotyCtrl:Awake()
  local tbOpenedPool = PlayerData.Gacha:GetOpenedPool()
  self.tbStrogeId = {}
  for _, nPoolId in ipairs(tbOpenedPool) do
    local mapPoolCfgData = ConfigTable.GetData("Gacha", nPoolId)
    if table.indexof(self.tbStrogeId, mapPoolCfgData.StorageId) < 1 and mapPoolCfgData.StorageId ~= GameEnum.gachaStorageType.BeginnerCardPool then
      table.insert(self.tbStrogeId, mapPoolCfgData.StorageId)
    end
  end
  self._mapNode.DD_PoolSelect:ClearOptions()
  local List_String = CS.System.Collections.Generic.List(CS.System.String)
  local lst = List_String()
  for _, value in pairs(self.tbStrogeId) do
    local str = ""
    local mapGachaStorage = ConfigTable.GetData("GachaStorage", value)
    if mapGachaStorage ~= nil then
      str = mapGachaStorage.Name
    end
    lst:Add(str)
  end
  self._mapNode.DD_PoolSelect:AddOptions(lst)
  self._mapNode.DD_PoolSelect.value = 0
end

function GachaHistotyCtrl:FadeIn()
end

function GachaHistotyCtrl:FadeOut()
end

function GachaHistotyCtrl:OnEnable()
end

function GachaHistotyCtrl:OnDisable()
end

function GachaHistotyCtrl:OnDestroy()
end

function GachaHistotyCtrl:OnRelease()
end

function GachaHistotyCtrl:OpenPanel(nStrogeId, nPoolId)
  self.bInit = false
  self._mapNode.rtContentHistory:SetActive(false)
  self._mapNode.rtGachaGuarantee.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, ConfigTable.GetUIText("GachaHistory_Guarantee"))
  for nIdx, value in ipairs(self.tbStrogeId) do
    if value == nStrogeId then
      self._mapNode.DD_PoolSelect.value = nIdx - 1
      break
    end
  end
  self.gameObject:SetActive(true)
  self:Refresh()
  self._mapNode.rtGachaGuarantee:Refresh(nPoolId)
  self._mapNode.rtGachaHistory:Play("t_window_04_t_in")
  self.bInit = true
end

function GachaHistotyCtrl:Refresh()
  local nIdx = self._mapNode.DD_PoolSelect.value + 1
  self.curPool = self.tbStrogeId[nIdx]
  
  local function GetDataCallback(tbData)
    self.tbAllHistory = tbData
    self.tbPage = {}
    local nPage = 1
    for i = #self.tbAllHistory, 1, -1 do
      for j = #self.tbAllHistory[i].Ids, 1, -1 do
        if self.tbPage[nPage] == nil then
          self.tbPage[nPage] = {}
        end
        if #self.tbPage[nPage] >= 5 then
          nPage = nPage + 1
          self.tbPage[nPage] = {}
        end
        table.insert(self.tbPage[nPage], {
          self.tbAllHistory[i].Ids[j],
          self.tbAllHistory[i].Time,
          self.tbAllHistory[i].Gid
        })
      end
    end
    self.nTotalPage = nPage
    if self.nTotalPage > 0 then
      NovaAPI.SetTMPText(self._mapNode.TMPPage, string.format("%d/%d", 1, self.nTotalPage))
      self.nCurPage = 1
      self:RefreshPage(self.nCurPage)
    else
      self.nCurPage = 0
      NovaAPI.SetTMPText(self._mapNode.TMPPage, string.format("%d/%d", 0, 0))
      self:RefreshPage(0)
    end
    if #self.tbAllHistory > 0 then
      self._mapNode.rtEmpty:SetActive(false)
      NovaAPI.SetImageColor(self._mapNode.imgPrev, Color(1, 1, 1, 1))
      NovaAPI.SetImageColor(self._mapNode.imgDown, Color(1, 1, 1, 1))
    else
      self._mapNode.rtEmpty:SetActive(true)
      NovaAPI.SetImageColor(self._mapNode.imgPrev, Color(1, 1, 1, 0.7))
      NovaAPI.SetImageColor(self._mapNode.imgDown, Color(1, 1, 1, 0.7))
    end
  end
  
  PlayerData.Gacha:GetGachaHistory(self.curPool, GetDataCallback)
end

function GachaHistotyCtrl:RefreshPage(nPage)
  local tbPage = self.tbPage[nPage]
  if tbPage == nil then
    for i = 1, 5 do
      NovaAPI.SetTMPText(self._mapNode.TMPType[i], "")
      NovaAPI.SetTMPText(self._mapNode.TMPName[i], "")
      NovaAPI.SetTMPText(self._mapNode.TMPTag[i], "")
      NovaAPI.SetTMPText(self._mapNode.TMPTime[i], "")
      self._mapNode.imgUPMark[i]:SetActive(false)
      self._mapNode.imgSSRBg[i]:SetActive(false)
      self._mapNode.ImgRare[i].gameObject:SetActive(false)
      self._mapNode.imgTypeIconChar[i].gameObject:SetActive(false)
      self._mapNode.imgTypeIconDisc[i].gameObject:SetActive(false)
    end
    return
  end
  for i = 1, 5 do
    local tbData = tbPage[i]
    if tbData == nil then
      NovaAPI.SetTMPText(self._mapNode.TMPType[i], "")
      NovaAPI.SetTMPText(self._mapNode.TMPName[i], "")
      NovaAPI.SetTMPText(self._mapNode.TMPTag[i], "")
      NovaAPI.SetTMPText(self._mapNode.TMPTime[i], "")
      self._mapNode.ImgRare[i].gameObject:SetActive(false)
      self._mapNode.imgTypeIconChar[i].gameObject:SetActive(false)
      self._mapNode.imgTypeIconDisc[i].gameObject:SetActive(false)
      self._mapNode.imgUPMark[i]:SetActive(false)
      self._mapNode.imgSSRBg[i]:SetActive(false)
    else
      local mapItemCfgData = ConfigTable.GetData_Item(tbData[1])
      if mapItemCfgData == nil then
        NovaAPI.SetTMPText(self._mapNode.TMPType[i], "")
        NovaAPI.SetTMPText(self._mapNode.TMPName[i], "")
        NovaAPI.SetTMPText(self._mapNode.TMPTag[i], "")
        NovaAPI.SetTMPText(self._mapNode.TMPTime[i], "")
        self._mapNode.ImgRare[i].gameObject:SetActive(false)
        self._mapNode.imgTypeIconChar[i].gameObject:SetActive(false)
        self._mapNode.imgTypeIconDisc[i].gameObject:SetActive(false)
        self._mapNode.imgUPMark[i]:SetActive(false)
        self._mapNode.imgSSRBg[i]:SetActive(false)
      else
        NovaAPI.SetTMPText(self._mapNode.TMPType[i], mapItemCfgData.Type == GameEnum.itemType.Char and ConfigTable.GetUIText("RoleCn") or ConfigTable.GetUIText("ItemStye_Outfit"))
        self._mapNode.imgTypeIconChar[i].gameObject:SetActive(mapItemCfgData.Type == GameEnum.itemType.Char)
        self._mapNode.imgTypeIconDisc[i].gameObject:SetActive(mapItemCfgData.Type ~= GameEnum.itemType.Char)
        NovaAPI.SetTMPText(self._mapNode.TMPName[i], mapItemCfgData.Title)
        NovaAPI.SetTMPText(self._mapNode.TMPTime[i], os.date("%Y/%m/%d %H:%M", tbData[2]))
        self._mapNode.ImgRare[i].gameObject:SetActive(true)
        self:SetSprite_FrameColor(self._mapNode.ImgRare[i], mapItemCfgData.Rarity, AllEnum.FrameType_New.Text)
        NovaAPI.SetImageNativeSize(self._mapNode.ImgRare[i])
        local mapGacha = ConfigTable.GetData("Gacha", tbData[3])
        if mapGacha ~= nil then
          NovaAPI.SetTMPText(self._mapNode.TMPTag[i], mapGacha.Name)
        else
          NovaAPI.SetTMPText(self._mapNode.TMPTag[i], tbData[3])
        end
        local mapProbData = PlayerData.Gacha:GetPoolProbData(tbData[3])
        local bUpItem = false
        if mapProbData ~= nil and mapProbData.tbProbUpItem ~= nil then
          for _, mapUpItem in ipairs(mapProbData.tbProbUpItem) do
            if mapUpItem.nGoodsId == tbData[1] then
              bUpItem = true
            end
          end
        end
        self._mapNode.imgUPMark[i]:SetActive(bUpItem)
        self._mapNode.imgSSRBg[i]:SetActive(mapItemCfgData.Rarity == GameEnum.itemRarity.SSR)
      end
    end
  end
end

function GachaHistotyCtrl:OnDD_SelectPool()
  if not self.bInit then
    return
  end
  self:Refresh()
end

function GachaHistotyCtrl:OnEvent_Open(bOpen)
  self._mapNode.imgDDUp:SetActive(bOpen)
  self._mapNode.imgDDDown:SetActive(not bOpen)
  local sSound = bOpen and "ui_common_menu_open" or "ui_common_menu_close"
  CS.WwiseAudioManager.Instance:PlaySound(sSound)
end

function GachaHistotyCtrl:OnBtnClick_NextPage()
  if self.nCurPage >= self.nTotalPage then
    return
  end
  self.nCurPage = self.nCurPage + 1
  NovaAPI.SetTMPText(self._mapNode.TMPPage, string.format("%d/%d", self.nCurPage, self.nTotalPage))
  self:RefreshPage(self.nCurPage)
end

function GachaHistotyCtrl:OnBtnClick_PrevPage()
  if self.nCurPage <= 1 then
    return
  end
  self.nCurPage = self.nCurPage - 1
  NovaAPI.SetTMPText(self._mapNode.TMPPage, string.format("%d/%d", self.nCurPage, self.nTotalPage))
  self:RefreshPage(self.nCurPage)
end

function GachaHistotyCtrl:OnBtnClick_Close()
  local function Close()
    self.gameObject:SetActive(false)
  end
  
  self._mapNode.rtGachaHistory:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, Close, true, true, true)
end

function GachaHistotyCtrl:OnBtnClick_History()
  self._mapNode.rtContentHistory:SetActive(true)
  self._mapNode.rtGachaGuarantee.gameObject:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, ConfigTable.GetUIText("Recruit_history"))
end

function GachaHistotyCtrl:OnBtnClick_Guarantee()
  self._mapNode.rtContentHistory:SetActive(false)
  self._mapNode.rtGachaGuarantee.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, ConfigTable.GetUIText("GachaHistory_Guarantee"))
end

return GachaHistotyCtrl

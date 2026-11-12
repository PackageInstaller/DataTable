local GachaCoverCtrl_CharUp = class("GachaCoverCtrl_CharUp", BaseCtrl)
GachaCoverCtrl_CharUp._mapNodeConfig = {
  root = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Transform"
  },
  imgTimeBg = {},
  imgFirstTenShowBg = {},
  Guarantee = {},
  GuaranteeGet = {},
  imgGuaranteeHeadShow = {},
  imgGuaranteeHeadMask = {},
  imgGuaranteeBg = {},
  TMPCountDown = {sComponentName = "TMP_Text"},
  TMPRemianCount = {sComponentName = "TMP_Text"},
  TMPFirstTenTip = {sComponentName = "TMP_Text"},
  TMPGuaranteeRemianCount = {sComponentName = "TMP_Text"},
  TMPGuaranteeRemainTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "GachaCover_GuaranteeRemainTip"
  },
  TMPFes = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_FesGacha"
  },
  TMPGuaranteeGetTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "GachaCover_GuaranteeGetTip"
  },
  TMPGuaranteeGetOver = {
    sComponentName = "TMP_Text",
    sLanguageId = "GachaCover_GuaranteeGetOverTip"
  },
  btnCharIcon = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ShowCharUpSubDetail"
  },
  itemChar = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnUpCharDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ShowCharUpMainDetail"
  },
  btnGuaranteeCanGet = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GuaranteeGet"
  },
  imgGuaranteeCharHead = {sComponentName = "Image"},
  iconProprety = {sComponentName = "Image"},
  TMPNpcName = {sComponentName = "TMP_Text"},
  TMPRateUp = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_Cover_CharUpTitle"
  },
  btnEntranceGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_EntranceGo"
  },
  txtBtnEntranceGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_Btn_GotoTrial"
  },
  imgFes = {}
}
GachaCoverCtrl_CharUp._mapEventConfig = {}

function GachaCoverCtrl_CharUp:Awake()
end

function GachaCoverCtrl_CharUp:FadeIn()
end

function GachaCoverCtrl_CharUp:FadeOut()
end

function GachaCoverCtrl_CharUp:OnEnable()
  local btnDetail1, btnDetail2, btnDetail3, btnDetail4
  
  local function func_MarkAllNode(trRoot)
    local nChildCount = trRoot.childCount - 1
    for i = 0, nChildCount do
      local trChild = trRoot:GetChild(i)
      if trChild.name == "btnDetail1" then
        btnDetail1 = trChild
      end
      if trChild.name == "btnDetail2" then
        btnDetail2 = trChild
      end
      if trChild.name == "btnDetail3" then
        btnDetail3 = trChild
      end
      if trChild.name == "btnDetail4" then
        btnDetail4 = trChild
      end
      if trChild.childCount > 0 then
        func_MarkAllNode(trChild)
      end
    end
  end
  
  func_MarkAllNode(self._mapNode.root)
  
  local function callback1()
    EventManager.Hit("GachaPoolDetail", 1)
  end
  
  local function callback2()
    EventManager.Hit("GachaPoolDetail", 2)
  end
  
  local function callback3()
    EventManager.Hit("GachaPoolDetail", 3)
  end
  
  local function callback4()
    EventManager.Hit("GachaPoolDetail", 4)
  end
  
  if btnDetail1 ~= nil then
    local btn = btnDetail1:GetComponent("UIButton")
    if btn ~= nil then
      btn.onClick:AddListener(callback1)
    end
  end
  if btnDetail2 ~= nil then
    local btn = btnDetail2:GetComponent("UIButton")
    if btn ~= nil then
      btn.onClick:AddListener(callback2)
    end
  end
  if btnDetail3 ~= nil then
    local btn = btnDetail3:GetComponent("UIButton")
    if btn ~= nil then
      btn.onClick:AddListener(callback3)
    end
  end
  if btnDetail4 ~= nil then
    local btn = btnDetail4:GetComponent("UIButton")
    if btn ~= nil then
      btn.onClick:AddListener(callback4)
    end
  end
  self.tbMainCharId = {}
  self.tbSubCharId = {}
end

function GachaCoverCtrl_CharUp:OnDisable()
end

function GachaCoverCtrl_CharUp:OnDestroy()
end

function GachaCoverCtrl_CharUp:OnRelease()
end

function GachaCoverCtrl_CharUp:PlayInAnim()
  local anim = self.gameObject.transform:GetComponent("Animator")
  anim:SetTrigger("tIn")
end

function GachaCoverCtrl_CharUp:SetCover(nId)
  self.nId = nId
  local nAupMissing = PlayerData.Gacha:GetAupMissTimesById(nId)
  local bFirstTenReward = PlayerData.Gacha:GetRecvFirstTenReward(nId)
  local mapGachaData = ConfigTable.GetData("Gacha", nId)
  if mapGachaData ~= nil then
    self._mapNode.imgFes:SetActive(mapGachaData.GachaType == 8 or mapGachaData.GachaType == 9)
    local nStorage = mapGachaData.StorageId
    local mapStorage = ConfigTable.GetData("GachaStorage", nStorage)
    local nRewardCount = 0
    if mapStorage ~= nil then
      local nMaxMissing = mapStorage.AUpGuaranteeTimes
      local nSum = nMaxMissing - nAupMissing
      local text = orderedFormat(ConfigTable.GetUIText("GachaCover_RemainCount"), nSum)
      local mapReward = decodeJson(mapStorage.GiveItems)
      if mapReward ~= nil then
        for _, nCount in pairs(mapReward) do
          nRewardCount = tonumber(nCount) or 0
        end
      end
      NovaAPI.SetTMPText(self._mapNode.TMPRemianCount, text)
    end
    if bFirstTenReward then
      self._mapNode.imgFirstTenShowBg:SetActive(true)
      local text = orderedFormat(ConfigTable.GetUIText("GachaCover_OneRewardTip"), nRewardCount)
      NovaAPI.SetTMPText(self._mapNode.TMPFirstTenTip, text)
    else
      self._mapNode.imgFirstTenShowBg:SetActive(true)
      local text = orderedFormat(ConfigTable.GetUIText("GachaCover_FirstTenTip"), nRewardCount * 10 * mapGachaData.FirstTenShow, mapGachaData.FirstTenShow)
      NovaAPI.SetTMPText(self._mapNode.TMPFirstTenTip, text)
    end
    self:RefreshGuaranteeReward()
    local sTimeStr = mapGachaData.EndTime
    if sTimeStr ~= "" then
      self._mapNode.imgTimeBg:SetActive(true)
      local nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(sTimeStr)
      local curTime = CS.ClientManager.Instance.serverTimeStamp
      local remainTime = nEndTime - curTime
      if 86400 <= remainTime then
        local day = math.floor(remainTime / 86400)
        local hour = math.floor((remainTime - day * 86400) / 3600)
        if hour == 0 then
          day = day - 1
          hour = 24
        end
        sTimeStr = orderedFormat(ConfigTable.GetUIText("Energy_LeftTime_Day"), day, hour)
      elseif 3600 <= remainTime then
        local hour = math.floor(remainTime / 3600)
        local min = math.floor((remainTime - hour * 3600) / 60)
        if min == 0 then
          hour = hour - 1
          min = 60
        end
        sTimeStr = orderedFormat(ConfigTable.GetUIText("Energy_LeftTime_Hour"), hour, min)
      else
        sTimeStr = ConfigTable.GetUIText("Energy_LeftTime_LessThenHour")
      end
      local text = orderedFormat(ConfigTable.GetUIText("GachaCover_TimeCountDown"), sTimeStr)
      NovaAPI.SetTMPText(self._mapNode.TMPCountDown, text)
    else
      self._mapNode.imgTimeBg:SetActive(false)
    end
    local mapPkgData = ConfigTable.Get("GachaPkg")
    if mapPkgData ~= nil then
      ForEachTableLine(mapPkgData, function(mapData)
        if mapData.PkgId == mapGachaData.ATypeUpPkg then
          table.insert(self.tbMainCharId, mapData.GoodsId)
        elseif mapData.PkgId == mapGachaData.BTypeUpPkg then
          table.insert(self.tbSubCharId, mapData.GoodsId)
        end
      end)
    end
    for i = 1, 2 do
      self._mapNode.itemChar[i]:SetItem(self.tbSubCharId[i])
    end
    local nUpChar = self.tbMainCharId[1]
    if nUpChar ~= nil then
      local mapCfgData_Char = ConfigTable.GetData_Character(nUpChar)
      local mapCfgData_Item = ConfigTable.GetData_Item(nUpChar)
      if mapCfgData_Item ~= nil then
        local sTitle = orderedFormat(ConfigTable.GetUIText("Gacha_Cover_UpItemTitle") or "", mapCfgData_Item.Title)
        NovaAPI.SetTMPText(self._mapNode.TMPNpcName, sTitle)
      end
      if mapCfgData_Char ~= nil then
        self:SetAtlasSprite(self._mapNode.iconProprety, "12_rare", AllEnum.Star_Element[mapCfgData_Char.EET].icon)
      end
      return
    end
  end
end

function GachaCoverCtrl_CharUp:EnableCover()
end

function GachaCoverCtrl_CharUp:DisableCover()
end

function GachaCoverCtrl_CharUp:RefreshGuaranteeReward()
  self._mapNode.imgGuaranteeBg:SetActive(false)
  self._mapNode.Guarantee:SetActive(false)
  self._mapNode.GuaranteeGet:SetActive(false)
  self._mapNode.imgGuaranteeHeadShow:SetActive(false)
  self._mapNode.imgGuaranteeHeadMask:SetActive(false)
  self._mapNode.btnGuaranteeCanGet.gameObject:SetActive(false)
  local bGuaranteeReward = PlayerData.Gacha:GetRecvGuaranteeReward(self.nId)
  local nGachaTotalTimes = PlayerData.Gacha:GetGachaTotalTimes(self.nId)
  local mapGachaData = ConfigTable.GetData("Gacha", self.nId)
  if mapGachaData == nil or mapGachaData.GuaranteeTid == 0 then
    return
  end
  local mapCfg = ConfigTable.GetData_Item(mapGachaData.GuaranteeTid)
  if mapCfg == nil then
    return
  end
  if mapCfg.Type == GameEnum.itemType.Disc then
    self:SetPngSprite(self._mapNode.imgGuaranteeCharHead, mapCfg.Icon .. AllEnum.OutfitIconSurfix.Item)
  elseif mapCfg.Type == GameEnum.itemType.Char then
    local mapCfgData_Char = ConfigTable.GetData_Character(mapGachaData.GuaranteeTid)
    local mapCfgData_Skin = ConfigTable.GetData_CharacterSkin(mapCfgData_Char.DefaultSkinId)
    self:SetPngSprite(self._mapNode.imgGuaranteeCharHead, mapCfgData_Skin.Icon, AllEnum.CharHeadIconSurfix.S)
  elseif mapCfg.Type == GameEnum.itemType.CharacterSkin then
    local mapCfgData_Skin = ConfigTable.GetData_CharacterSkin(mapGachaData.GuaranteeTid)
    self:SetPngSprite(self._mapNode.imgGuaranteeCharHead, mapCfgData_Skin.Icon, AllEnum.CharHeadIconSurfix.S)
  end
  self._mapNode.imgGuaranteeBg:SetActive(true)
  if bGuaranteeReward then
    self._mapNode.GuaranteeGet:SetActive(true)
    self._mapNode.imgGuaranteeHeadMask:SetActive(true)
  elseif nGachaTotalTimes >= mapGachaData.GuaranteeTimes then
    self._mapNode.btnGuaranteeCanGet.gameObject:SetActive(true)
    self._mapNode.imgGuaranteeHeadShow:SetActive(true)
  else
    self._mapNode.Guarantee:SetActive(true)
    local text = orderedFormat(ConfigTable.GetUIText("GachaCover_GuaranteeRemainCount"), mapGachaData.GuaranteeTimes - nGachaTotalTimes)
    NovaAPI.SetTMPText(self._mapNode.TMPGuaranteeRemianCount, text)
  end
end

function GachaCoverCtrl_CharUp:OnBtnClick_ShowCharUpMainDetail()
  if #self.tbMainCharId < 1 then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.CharBgTrialPanel, PanelId.CharInfoTrial, self.tbMainCharId[1], self.tbMainCharId, true)
end

function GachaCoverCtrl_CharUp:OnBtnClick_ShowCharUpSubDetail(btn, nIdx)
  if self.tbSubCharId[nIdx] == nil then
    return
  end
  local nDetailCharId = self.tbSubCharId[nIdx]
  EventManager.Hit(EventId.OpenPanel, PanelId.CharBgTrialPanel, PanelId.CharInfoTrial, nDetailCharId)
end

function GachaCoverCtrl_CharUp:OnBtnClick_GuaranteeGet()
  local function GachaCallback(mapData)
    self:RefreshGuaranteeReward()
    
    UTILS.OpenReceiveByChangeInfo(mapData)
  end
  
  PlayerData.Gacha:SendGachaGuaranteeRewardReq(self.nId, GachaCallback)
end

function GachaCoverCtrl_CharUp:OnBtnClick_EntranceGo()
  EventManager.Hit("OnBtnClickGachaCoverEntranceGo")
end

return GachaCoverCtrl_CharUp

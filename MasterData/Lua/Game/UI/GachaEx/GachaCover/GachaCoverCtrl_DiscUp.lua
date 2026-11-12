local GachaCoverCtrl_DiscUp = class("GachaCoverCtrl_DiscUp", BaseCtrl)
GachaCoverCtrl_DiscUp._mapNodeConfig = {
  root = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Transform"
  },
  imgTimeBg = {},
  TMPFes = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_FesGacha"
  },
  TMPCountDown = {sComponentName = "TMP_Text"},
  TMPRemianCount = {sComponentName = "TMP_Text"},
  btnUpDiscDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ShowDiscUpMainDetail"
  },
  imgOutfit = {sComponentName = "Image", nCount = 3},
  iconProprety = {sComponentName = "Image"},
  TMPNpcName = {sComponentName = "TMP_Text"},
  TMPRateUp = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_Cover_DiscUpTitle"
  },
  imgFes = {}
}
GachaCoverCtrl_DiscUp._mapEventConfig = {}

function GachaCoverCtrl_DiscUp:Awake()
end

function GachaCoverCtrl_DiscUp:FadeIn()
end

function GachaCoverCtrl_DiscUp:FadeOut()
end

function GachaCoverCtrl_DiscUp:OnEnable()
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
  self.tbMainDiscId = {}
  self.tbSubDiscId = {}
end

function GachaCoverCtrl_DiscUp:OnDisable()
end

function GachaCoverCtrl_DiscUp:OnDestroy()
end

function GachaCoverCtrl_DiscUp:OnRelease()
end

function GachaCoverCtrl_DiscUp:PlayInAnim()
  local anim = self.gameObject.transform:GetComponent("Animator")
  anim:SetTrigger("tIn")
end

function GachaCoverCtrl_DiscUp:SetCover(nId)
  local nAupMissing = PlayerData.Gacha:GetAupMissTimesById(nId)
  local mapGachaData = ConfigTable.GetData("Gacha", nId)
  if mapGachaData ~= nil then
    self._mapNode.imgFes:SetActive(mapGachaData.GachaType == 8 or mapGachaData.GachaType == 9)
    local nStorage = mapGachaData.StorageId
    local mapStorage = ConfigTable.GetData("GachaStorage", nStorage)
    if mapStorage ~= nil then
      local nMaxMissing = mapStorage.AUpGuaranteeTimes
      local nSum = nMaxMissing - nAupMissing
      local text = orderedFormat(ConfigTable.GetUIText("GachaCover_DiscRemainCount"), nSum)
      NovaAPI.SetTMPText(self._mapNode.TMPRemianCount, text)
    end
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
          table.insert(self.tbMainDiscId, mapData.GoodsId)
        elseif mapData.PkgId == mapGachaData.BTypeUpPkg then
          table.insert(self.tbSubDiscId, mapData.GoodsId)
        end
      end)
    end
    if self.tbMainDiscId[1] ~= nil then
      local cfgDataItem = ConfigTable.GetData_Item(self.tbMainDiscId[1])
      local cfgDataDisc = ConfigTable.GetData("Disc", self.tbMainDiscId[1])
      if cfgDataItem ~= nil and cfgDataDisc ~= nil then
        self:SetPngSprite(self._mapNode.imgOutfit[2], cfgDataItem.Icon .. AllEnum.OutfitIconSurfix.Item)
        local imgProperty = self._mapNode.imgOutfit[2].transform:Find("imgProperty"):GetComponent("Image")
        local sName = AllEnum.ElementIconType.Icon .. cfgDataDisc.EET
        self:SetAtlasSprite(imgProperty, "12_rare", sName)
        local imgStar = self._mapNode.imgOutfit[2].transform:Find("imgRare"):GetComponent("Image")
        self:SetSprite_FrameColor(imgStar, 1, AllEnum.FrameType_New.Text)
        local sTitle = orderedFormat(ConfigTable.GetUIText("Gacha_Cover_UpItemTitle") or "", cfgDataItem.Title)
        NovaAPI.SetTMPText(self._mapNode.TMPNpcName, sTitle)
        self:SetAtlasSprite(self._mapNode.iconProprety, "12_rare", AllEnum.Star_Element[cfgDataDisc.EET].icon)
      end
    end
    if self.tbSubDiscId[1] ~= nil then
      local cfgDataItem = ConfigTable.GetData_Item(self.tbSubDiscId[1])
      local cfgDataDisc = ConfigTable.GetData("Disc", self.tbSubDiscId[1])
      if cfgDataItem ~= nil and cfgDataDisc ~= nil then
        self:SetPngSprite(self._mapNode.imgOutfit[1], cfgDataItem.Icon .. AllEnum.OutfitIconSurfix.Item)
        local imgProperty = self._mapNode.imgOutfit[1].transform:Find("imgProperty"):GetComponent("Image")
        local sName = AllEnum.ElementIconType.Icon .. cfgDataDisc.EET
        self:SetAtlasSprite(imgProperty, "12_rare", sName)
        local imgStar = self._mapNode.imgOutfit[1].transform:Find("imgRare"):GetComponent("Image")
        self:SetSprite_FrameColor(imgStar, 2, AllEnum.FrameType_New.Text)
      end
    end
    if self.tbSubDiscId[2] ~= nil then
      local cfgDataItem = ConfigTable.GetData_Item(self.tbSubDiscId[2])
      local cfgDataDisc = ConfigTable.GetData("Disc", self.tbSubDiscId[2])
      if cfgDataItem ~= nil and cfgDataDisc ~= nil then
        self:SetPngSprite(self._mapNode.imgOutfit[3], cfgDataItem.Icon .. AllEnum.OutfitIconSurfix.Item)
        local imgProperty = self._mapNode.imgOutfit[3].transform:Find("imgProperty"):GetComponent("Image")
        local sName = AllEnum.ElementIconType.Icon .. cfgDataDisc.EET
        self:SetAtlasSprite(imgProperty, "12_rare", sName)
        local imgStar = self._mapNode.imgOutfit[3].transform:Find("imgRare"):GetComponent("Image")
        self:SetSprite_FrameColor(imgStar, 2, AllEnum.FrameType_New.Text)
      end
    end
  end
end

function GachaCoverCtrl_DiscUp:EnableCover()
end

function GachaCoverCtrl_DiscUp:DisableCover()
end

function GachaCoverCtrl_DiscUp:OnBtnClick_ShowDiscUpMainDetail()
  if #self.tbMainDiscId < 1 then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.DiscSample, self.tbMainDiscId[1])
end

return GachaCoverCtrl_DiscUp

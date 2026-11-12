local GachaCtrl = class("GachaCtrl", BaseCtrl)
local LocalData = require("GameCore.Data.LocalData")
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local newDayTime = UTILS.GetDayRefreshTimeOffset()
local WwiseManger = CS.WwiseAudioManager
local sRootPath = Settings.AB_ROOT_PATH
local coverScript = {
  [GameEnum.gachaStorageType.CharacterCardPool] = "Game.UI.GachaEx.GachaCover.GachaCoverCtrl_PermanentCharUp",
  [GameEnum.gachaStorageType.DiscCardPool] = "Game.UI.GachaEx.GachaCover.GachaCoverCtrl_PermanentDiscUp",
  [GameEnum.gachaStorageType.CharacterUpCardPool] = "Game.UI.GachaEx.GachaCover.GachaCoverCtrl_CharUp",
  [GameEnum.gachaStorageType.DiscUpCardPool] = "Game.UI.GachaEx.GachaCover.GachaCoverCtrl_DiscUp",
  [GameEnum.gachaStorageType.BeginnerCardPool] = "Game.UI.GachaEx.GachaCover.GachaCoverCtrl_NewBie",
  [GameEnum.gachaStorageType.CharacterCardRewardPool] = "Game.UI.GachaEx.GachaCover.GachaCoverCtrl_PermanentCharReward"
}
GachaCtrl._mapNodeConfig = {
  coverRoot = {
    sNodeName = "----BGRoot----",
    sComponentName = "Transform"
  },
  PoolContent = {sComponentName = "Transform"},
  PoolTabTemplete = {},
  btn_GachaOne = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_One"
  },
  btn_GachaTen = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Ten"
  },
  txtBtnpoolDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Recruit_info"
  },
  txtBtnpoolHistory = {
    sComponentName = "TMP_Text",
    sLanguageId = "GachaHistory_Guarantee"
  },
  txtBtnshop = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Tog_Exchange"
  },
  txt_NewBieJump = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieRecord"
  },
  txt_NewBieCount = {sComponentName = "TMP_Text"},
  TMP_gachaNewBieTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieSummonTitle"
  },
  TMP_gachaNewBieCost = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieSummonCost"
  },
  TMP_gachaOneTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Recruit_one"
  },
  TMP_gachaTenTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Recruit_ten"
  },
  TMP_GachaTimes = {sComponentName = "TMP_Text"},
  imgItemOne = {sComponentName = "Image"},
  imgItemTen = {sComponentName = "Image"},
  imgNewBieItemTen = {sComponentName = "Image"},
  TMP_gachaOneCost = {sComponentName = "TMP_Text"},
  TMP_gachaTenCost = {sComponentName = "TMP_Text"},
  imgBtnTip = {sComponentName = "Image"},
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  btn_poolDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GachaDetail"
  },
  btn_poolHistory = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GachaHistory"
  },
  btn_shop = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_shop"
  },
  btn_NewBieJump = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NewBieJump"
  },
  btn_NewBieJumpRecord = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NewBieJumpRecord"
  },
  rootAnim = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  GachaOpenDoor = {},
  GachaShow = {
    sCtrlName = "Game.UI.GachaEx.GachaShowCtrl"
  },
  GachaShowResult = {
    sCtrlName = "Game.UI.GachaEx.GachaShowResultCtrl"
  },
  GachaInfo = {
    sNodeName = "----PoolInfo---- ",
    sCtrlName = "Game.UI.GachaEx.GachaInfoCtrl"
  },
  GachaHistory = {
    sNodeName = "----GachaHistory----",
    sCtrlName = "Game.UI.GachaEx.GachaHistotyCtrl"
  },
  GachaProb = {
    sNodeName = "----ProbInfo----",
    sCtrlName = "Game.UI.GachaEx.GachaProbInfoCtrl"
  },
  GachaNewBieShowRecord = {
    sNodeName = "GachaNewBieShowRecord",
    sCtrlName = "Game.UI.GachaEx.GachaNewBieShowRecordCtrl"
  },
  GachaNewBieShowResult = {
    sNodeName = "GachaNewBieShowResult",
    sCtrlName = "Game.UI.GachaEx.GachaNewBieShowResultCtrl"
  },
  GachaNewBieSaveRecord = {
    sNodeName = "GachaNewBieSaveRecord",
    sCtrlName = "Game.UI.GachaEx.GachaNewBieSaveRecordCtrl"
  },
  GachaNewBieReplaceResult = {
    sNodeName = "GachaNewBieReplaceResult",
    sCtrlName = "Game.UI.GachaEx.GachaNewBieReplaceResultCtrl"
  },
  GachaNewBieObtainResult = {
    sNodeName = "GachaNewBieObtainResult",
    sCtrlName = "Game.UI.GachaEx.GachaNewBieObtainResultCtrl"
  }
}
GachaCtrl._mapEventConfig = {
  GachaPoolDetail = "OnEvent_GachaPoolDetail",
  GachaOpenPoolInfo = "OnBtnClick_GachaDetail",
  GachaOpenProbInfo = "OnBtnClick_ProbDetail",
  GachaNewbieSpin = "OnEvent_GachaNewbieSpin",
  GachaNewbieRecord = "OnEvent_GachaNewbieRecord",
  GachaNewbieObtainRecord = "OnEvent_GachaNewbieObtainRecord",
  GachaNewbieSaveRecord = "OnEvent_GachaNewbieSaveRecord",
  GachaNewbieReplaceRecord = "OnEvent_GachaNewbieReplaceRecord",
  GachaNewbieReplaceRecordOver = "OnEvent_GachaNewbieReplaceRecordOver",
  GachaNewbieObtainRecordOver = "OnEvent_GachaNewbieObtainRecordOver",
  GachaProcessStart = "OnEvent_GachaProcessStart",
  GachaNeedRefresh = "OnEvent_GachaNeedRefresh",
  OnBtnClickGachaCoverEntranceGo = "OnEvent_GachaCoverEntranceGo",
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  [EventId.UIBackConfirm] = "OnEvent_Back"
}

function GachaCtrl:Awake()
  self.bGachaProcess = false
  self.nMaxCoverCount = 6
  if CS.ClientManager.Instance:GetMemoryType() then
    self.nMaxCoverCount = 2
  end
end

function GachaCtrl:FadeIn()
end

function GachaCtrl:FadeOut()
end

function GachaCtrl:OnEnable()
  self.tbLoadedCover = {}
  self._mapMaxAcquireReward = {}
  
  local function forEachAcquireReward(mapData)
    if self._mapMaxAcquireReward[mapData.itemStype] == nil then
      self._mapMaxAcquireReward[mapData.itemStype] = {}
    end
    if self._mapMaxAcquireReward[mapData.itemStype][mapData.itemRarity] == nil then
      self._mapMaxAcquireReward[mapData.itemStype][mapData.itemRarity] = mapData.AcquireTimes
    end
    if mapData.AcquireTimes > self._mapMaxAcquireReward[mapData.itemStype][mapData.itemRarity] then
      self._mapMaxAcquireReward[mapData.itemStype][mapData.itemRarity] = mapData.AcquireTimes
    end
  end
  
  ForEachTableLine(DataTable.AcquireReward, forEachAcquireReward)
  self.nTopBarId = self._mapNode.TopBar.gameObject:GetInstanceID()
  self.curPoolId = 0
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.curPoolId = tbParam[1]
  end
  local bOpen = true
  if self._panel.nCurPool ~= nil and self._panel.nCurPool ~= 0 then
    self.curPoolId = self._panel.nCurPool
    self._panel.nCurPool = 0
    bOpen = false
  end
  self.mapCover = {}
  
  local function callback()
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      
      self:RefreshAll(bOpen)
    end
    
    cs_coroutine.start(wait)
    EventManager.Hit("Guide_GachaOpen")
  end
  
  local function newbie_callback()
    PlayerData.Gacha:GetGachaInfomation(callback)
  end
  
  PlayerData.Gacha:GetGachaNewbieInfomation(newbie_callback)
  self._mapNode.GachaNewBieShowRecord.gameObject:SetActive(false)
  self._mapNode.GachaNewBieShowResult.gameObject:SetActive(false)
  self._mapNode.GachaNewBieSaveRecord.gameObject:SetActive(false)
  self._mapNode.GachaNewBieReplaceResult.gameObject:SetActive(false)
  self._mapNode.GachaNewBieObtainResult.gameObject:SetActive(false)
end

function GachaCtrl:OnDisable()
  for _, nPoolId in ipairs(self.tbLoadedCover) do
    self:UnloadCoverInternal(nPoolId)
  end
  self.tbLoadedCover = {}
  self._panel.nCurPool = self.curPoolId
  self.mapCover = nil
  self.mapTab = nil
  delChildren(self._mapNode.coverRoot)
  delChildren(self._mapNode.PoolContent)
  CS.WwiseAudioManager.Instance:PostEvent("ui_recuit_cover_all_stop")
end

function GachaCtrl:OnDestroy()
end

function GachaCtrl:OnRelease()
end

function GachaCtrl:RefreshAll(bOpen)
  if #self.tbLoadedCover > 0 then
    for _, nPoolId in ipairs(self.tbLoadedCover) do
      self:UnloadCoverInternal(nPoolId)
    end
    self.tbLoadedCover = {}
  end
  self.tbOpenedPool = PlayerData.Gacha:GetOpenedPool()
  self:RefreshTab()
  if type(self.curPoolId) ~= "number" or 0 >= self.curPoolId or table.indexof(self.tbOpenedPool, self.curPoolId) < 1 then
    self.curPoolId = self.tbOpenedPool[1]
  end
  self:LoadCover(self.curPoolId)
  self:SetTabSelect(self.curPoolId, true)
  self:RefreshInfo()
  EventManager.Hit(EventId.SetTransition)
  
  local function wait()
    if self.mapCover[self.curPoolId] ~= nil then
      self.mapCover[self.curPoolId].gameObject:SetActive(true)
      local gachaData = ConfigTable.GetData("Gacha", self.curPoolId)
      if gachaData ~= nil then
        CS.WwiseAudioManager.Instance:PostEvent(gachaData.Voice)
      end
    end
    self._mapNode.rootAnim:Play("GachaPanel_in")
    if self.mapCover[self.curPoolId] then
      self.mapCover[self.curPoolId]:PlayInAnim()
      self.mapCover[self.curPoolId]:EnableCover()
    end
  end
  
  if bOpen == true then
    self:AddTimer(1, 0.3, wait, true, true, true)
  else
    wait()
  end
end

function GachaCtrl:RefreshTab()
  self.mapTab = {}
  delChildren(self._mapNode.PoolContent)
  if #self.tbOpenedPool < 1 then
    printError("没有开启的卡池")
    return
  end
  
  local function comp(a, b)
    local mapGachaA = ConfigTable.GetData("Gacha", a)
    local mapGachaB = ConfigTable.GetData("Gacha", b)
    return mapGachaA.Sort < mapGachaB.Sort
  end
  
  table.sort(self.tbOpenedPool, comp)
  for _, nGachaId in ipairs(self.tbOpenedPool) do
    local mapGacha = ConfigTable.GetData("Gacha", nGachaId)
    local goTab = instantiate(self._mapNode.PoolTabTemplete, self._mapNode.PoolContent)
    goTab.transform.localScale = Vector3.one
    self.mapTab[nGachaId] = goTab
    local compBtn = goTab:GetComponent("UIButton")
    local func_Handler = ui_handler(self, self.OnBtnClick_Tab, compBtn, nGachaId)
    compBtn.onClick:AddListener(func_Handler)
    local imgIconTab = goTab.transform:Find("AnimRoot/imgTab"):GetComponent("Image")
    self:SetPngSprite(imgIconTab, mapGacha.Icon)
    goTab.transform:Find("AnimRoot/imgChoose").gameObject:SetActive(false)
    local goRedDot = goTab.transform:Find("AnimRoot/goPoolTabRedDot").gameObject
    RedDotManager.RegisterNode(RedDotDefine.Gacha_List, nGachaId, goRedDot)
  end
end

function GachaCtrl:RefreshInfo()
  if self.curPoolId == nil or self.curPoolId == 0 then
    return
  end
  local mapGacha = ConfigTable.GetData("Gacha", self.curPoolId)
  if mapGacha == nil then
    return
  end
  self.isNewBie = mapGacha.StorageId == GameEnum.gachaStorageType.BeginnerCardPool
  self._mapNode.btn_NewBieJump.gameObject:SetActive(self.isNewBie)
  self._mapNode.btn_NewBieJumpRecord.gameObject:SetActive(self.isNewBie)
  self._mapNode.btn_GachaOne.gameObject:SetActive(not self.isNewBie)
  self._mapNode.btn_GachaTen.gameObject:SetActive(not self.isNewBie)
  self._mapNode.btn_poolHistory.gameObject:SetActive(not self.isNewBie)
  self._mapNode.btn_shop.gameObject:SetActive(not self.isNewBie)
  self._mapNode.TMP_GachaTimes.gameObject:SetActive(not self.isNewBie)
  if self.isNewBie then
    local newbie = ConfigTable.GetData("GachaNewbie", self.curPoolId)
    local newbieData = PlayerData.Gacha:GetGachaNewbieData(self.curPoolId)
    local c = 0
    if newbieData ~= nil then
      c = #newbieData.Cards
    end
    if newbie ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txt_NewBieCount, tostring(c) .. "/" .. tostring(newbie.SaveCount))
    end
  end
  self:RefreshCoin(mapGacha)
  self:RefreshCover()
  self._mapNode.GachaInfo:Refresh(self.curPoolId)
  self._mapNode.GachaProb:Refresh(self.curPoolId)
  self:RefreshRemainGachaTimes(self.curPoolId)
end

function GachaCtrl:RefreshRemainGachaTimes(curPoolId)
  local LimitTimes = ConfigTable.GetData("Gacha", curPoolId).LimitTimes
  if LimitTimes == nil or 999 < LimitTimes then
    self._mapNode.TMP_GachaTimes.gameObject:SetActive(false)
    return
  end
  local nGachaTotalTimes = math.min(PlayerData.Gacha:GetGachaCountById(curPoolId), LimitTimes)
  local str = orderedFormat(ConfigTable.GetUIText("Gacha_GachaTimeLimit"), nGachaTotalTimes, LimitTimes)
  NovaAPI.SetTMPText(self._mapNode.TMP_GachaTimes, str)
end

function GachaCtrl:IsRemain_Ten(curPoolId)
  local LimitTimes = ConfigTable.GetData("Gacha", curPoolId).LimitTimes
  local nGachaTotalTimes = PlayerData.Gacha:GetGachaCountById(curPoolId)
  if LimitTimes == nil then
    return true
  end
  return 10 <= LimitTimes - nGachaTotalTimes
end

function GachaCtrl:IsRemain_One(curPoolId)
  local LimitTimes = ConfigTable.GetData("Gacha", curPoolId).LimitTimes
  local nGachaTotalTimes = PlayerData.Gacha:GetGachaCountById(curPoolId)
  if LimitTimes == nil then
    return true
  end
  return 1 <= LimitTimes - nGachaTotalTimes
end

function GachaCtrl:RefreshCoin(mapGacha)
  if mapGacha == nil then
    return
  end
  local mapGachaStorage = ConfigTable.GetData("GachaStorage", mapGacha.StorageId)
  if mapGachaStorage == nil then
    return
  end
  if self.isNewBie then
    return
  end
  local rapidjson = require("rapidjson")
  if type(mapGachaStorage.OncePreferred) == "string" then
    local tbOne = rapidjson.decode(mapGachaStorage.OncePreferred)
    if tbOne ~= nil then
      mapGachaStorage.OncePreferred = tbOne
    else
      mapGachaStorage.OncePreferred = {}
      printError("单抽消耗配置错误：" .. self.curPoolId)
      return
    end
  end
  if type(mapGachaStorage.TenTimesPreferred) == "string" then
    local tbTen = rapidjson.decode(mapGachaStorage.TenTimesPreferred)
    if tbTen ~= nil then
      mapGachaStorage.TenTimesPreferred = tbTen
    else
      mapGachaStorage.TenTimesPreferred = {}
      printError("十连消耗配置错误：" .. self.curPoolId)
      return
    end
  end
  local bShowSpecialOne = false
  if mapGacha.SpecificTid > 0 then
    local nCurCount = PlayerData.Item:GetItemCountByID(mapGacha.SpecificTid)
    if nCurCount >= mapGachaStorage.DefaultQty then
      bShowSpecialOne = true
    end
  end
  if bShowSpecialOne then
    NovaAPI.SetTMPText(self._mapNode.TMP_gachaOneCost, mapGachaStorage.DefaultQty)
    local mapItemCfgData = ConfigTable.GetData_Item(mapGacha.SpecificTid)
    if mapItemCfgData ~= nil then
      self:SetPngSprite(self._mapNode.imgItemOne, mapItemCfgData.Icon2)
    end
    NovaAPI.SetImageNativeSize(self._mapNode.imgItemOne)
  elseif #mapGachaStorage.OncePreferred > 0 then
    for nIdx, mapCost in ipairs(mapGachaStorage.OncePreferred) do
      local f = pairs(mapCost)
      local sTid, nCount = f(mapCost)
      local nTid = tonumber(sTid)
      local nCurCount = PlayerData.Item:GetItemCountByID(nTid)
      if nCount <= nCurCount then
        NovaAPI.SetTMPText(self._mapNode.TMP_gachaOneCost, nCount)
        local mapItemCfgData = ConfigTable.GetData_Item(nTid)
        self:SetPngSprite(self._mapNode.imgItemOne, mapItemCfgData.Icon2)
        NovaAPI.SetImageNativeSize(self._mapNode.imgItemOne)
        break
      end
      if nIdx == #mapGachaStorage.OncePreferred then
        NovaAPI.SetTMPText(self._mapNode.TMP_gachaOneCost, mapGachaStorage.DefaultQty)
        local mapItemCfgData = ConfigTable.GetData_Item(mapGachaStorage.DefaultId)
        self:SetPngSprite(self._mapNode.imgItemOne, mapItemCfgData.Icon2)
        NovaAPI.SetImageNativeSize(self._mapNode.imgItemOne)
      end
    end
  else
    NovaAPI.SetTMPText(self._mapNode.TMP_gachaOneCost, mapGachaStorage.DefaultQty)
    local mapItemCfgData = ConfigTable.GetData_Item(mapGachaStorage.DefaultId)
    if mapItemCfgData ~= nil then
      self:SetPngSprite(self._mapNode.imgItemOne, mapItemCfgData.Icon2)
      NovaAPI.SetImageNativeSize(self._mapNode.imgItemOne)
    end
  end
  local bShowSpecialTen = false
  if mapGacha.SpecificTid > 0 then
    local nCurCount = PlayerData.Item:GetItemCountByID(mapGacha.SpecificTid)
    if nCurCount >= 10 * mapGachaStorage.DefaultQty then
      bShowSpecialTen = true
    end
  end
  if bShowSpecialTen then
    NovaAPI.SetTMPText(self._mapNode.TMP_gachaTenCost, 10 * mapGachaStorage.DefaultQty)
    local mapItemCfgData = ConfigTable.GetData_Item(mapGacha.SpecificTid)
    if mapItemCfgData ~= nil then
      self:SetPngSprite(self._mapNode.imgItemTen, mapItemCfgData.Icon2)
    end
    NovaAPI.SetImageNativeSize(self._mapNode.imgItemTen)
  elseif #mapGachaStorage.TenTimesPreferred > 0 then
    for nIdx, mapCost in ipairs(mapGachaStorage.TenTimesPreferred) do
      local f = pairs(mapCost)
      local sTid, nCount = f(mapCost)
      local nTid = tonumber(sTid)
      local nCurCount = PlayerData.Item:GetItemCountByID(nTid)
      if nCount <= nCurCount then
        NovaAPI.SetTMPText(self._mapNode.TMP_gachaTenCost, nCount)
        local mapItemCfgData = ConfigTable.GetData_Item(nTid)
        self:SetPngSprite(self._mapNode.imgItemTen, mapItemCfgData.Icon2)
        NovaAPI.SetImageNativeSize(self._mapNode.imgItemTen)
        break
      end
      if nIdx == #mapGachaStorage.TenTimesPreferred then
        NovaAPI.SetTMPText(self._mapNode.TMP_gachaTenCost, mapGachaStorage.DefaultQty * 10)
        local mapItemCfgData = ConfigTable.GetData_Item(mapGachaStorage.DefaultId)
        self:SetPngSprite(self._mapNode.imgItemTen, mapItemCfgData.Icon2)
        NovaAPI.SetImageNativeSize(self._mapNode.imgItemTen)
      end
    end
  else
    NovaAPI.SetTMPText(self._mapNode.TMP_gachaTenCost, mapGachaStorage.DefaultQty * 10)
    local mapItemCfgData = ConfigTable.GetData_Item(mapGachaStorage.DefaultId)
    self:SetPngSprite(self._mapNode.imgItemTen, mapItemCfgData.Icon2)
    NovaAPI.SetImageNativeSize(self._mapNode.imgItemTen)
  end
end

function GachaCtrl:RefreshCover()
  for nPoolId, mapCoverCtrl in pairs(self.mapCover) do
    mapCoverCtrl:SetCover(nPoolId)
  end
end

function GachaCtrl:LoadCover(nCurPool)
  self.mapCover = {}
  self:LoadCoverInternal(nCurPool)
  table.insert(self.tbLoadedCover, 1, nCurPool)
  if not CS.ClientManager.Instance:GetMemoryType() then
    for _, nPoolId in ipairs(self.tbOpenedPool) do
      if #self.tbLoadedCover < self.nMaxCoverCount and nPoolId ~= nCurPool then
        self:LoadCoverInternal(nPoolId)
        table.insert(self.tbLoadedCover, nPoolId)
      end
    end
  end
end

function GachaCtrl:LoadCoverInternal(nPoolId)
  local mapGacha = ConfigTable.GetData("Gacha", nPoolId)
  if mapGacha ~= nil then
    local nCoverId = UTILS.GenerateManageredResourceId(self._panel._nPanelId, nPoolId)
    local fullPath = string.format(sRootPath .. "UI_GachaCover/%s/%s.prefab", mapGacha.Image, mapGacha.Image)
    local coverPrefab = GameResourceLoader.LoadAsset(ResType.Any, fullPath, typeof(Object), "UI", nCoverId)
    local goCover = instantiate(coverPrefab, self._mapNode.coverRoot)
    goCover:SetActive(false)
    local sScript = "Game.UI.GachaEx.GachaCoverCtrl"
    if coverScript[mapGacha.StorageId] ~= nil then
      sScript = coverScript[mapGacha.StorageId]
    end
    local goCtrl = self:BindCtrlByNode(goCover, sScript)
    self.mapCover[nPoolId] = goCtrl
    self.mapCover[nPoolId]:SetCover(nPoolId)
  end
end

function GachaCtrl:UnloadCoverInternal(nPoolId)
  local goCtrl = self.mapCover[nPoolId]
  local tempGo = goCtrl.gameObject
  self:UnbindCtrlByNode(goCtrl)
  destroy(tempGo)
  self.mapCover[nPoolId] = nil
  local nCoverId = UTILS.GenerateManageredResourceId(self._panel._nPanelId, nPoolId)
  GameResourceLoader.UnloadAsset(nCoverId)
end

function GachaCtrl:SetTabSelect(nGachaId, bSelect)
  if nGachaId == nil then
    return
  end
  local gachaData = ConfigTable.GetData("Gacha", nGachaId)
  local mapStorage = ConfigTable.GetData("GachaType", gachaData.GachaType)
  if bSelect then
    local tbCoin = clone(mapStorage.CoinItem)
    if gachaData.SpecificTid > 0 then
      table.insert(tbCoin, gachaData.SpecificTid)
    end
    self._mapNode.TopBar:CreateCoin(tbCoin)
    self.tbCurTabCoin = tbCoin
  end
  local go = self.mapTab[nGachaId]
  if go ~= nil then
    go.transform:Find("AnimRoot/imgChoose").gameObject:SetActive(bSelect)
  end
  self._mapNode.btn_NewBieJump.gameObject:SetActive(gachaData.StorageId == GameEnum.gachaStorageType.BeginnerCardPool)
  self._mapNode.btn_shop.gameObject:SetActive(gachaData.StorageId == GameEnum.gachaStorageType.BeginnerCardPool)
end

function GachaCtrl:SetCoverOpen(nGachaId)
  if nGachaId == nil then
    return
  end
  local curGo = self.mapCover[self.curPoolId].gameObject
  if curGo ~= nil then
    curGo:SetActive(false)
  end
  local nextGo = self.mapCover[nGachaId]
  if nextGo == nil then
    if #self.tbLoadedCover >= self.nMaxCoverCount then
      local removedId = table.remove(self.tbLoadedCover, #self.tbLoadedCover)
      self:UnloadCoverInternal(removedId)
    end
    self:LoadCoverInternal(nGachaId)
    table.insert(self.tbLoadedCover, 1, nGachaId)
    nextGo = self.mapCover[nGachaId]
  else
    table.removebyvalue(self.tbLoadedCover, nGachaId, true)
    table.insert(self.tbLoadedCover, 1, nGachaId)
  end
  if nextGo ~= nil then
    nextGo.gameObject:SetActive(true)
    local gachaData = ConfigTable.GetData("Gacha", nGachaId)
    if gachaData ~= nil then
      CS.WwiseAudioManager.Instance:PostEvent(gachaData.Voice)
    end
  end
end

function GachaCtrl:GachaOneExchangeCoin(mapGacha)
  local function ConfirmPanel(sTip, confirmCallback, againKey)
    if againKey ~= nil then
      local TipsTime = LocalData.GetPlayerLocalData(againKey)
      
      local _tipDay = 0
      if TipsTime ~= nil then
        _tipDay = tonumber(TipsTime)
      end
      local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
      local fixedTimeStamp = curTimeStamp - newDayTime * 3600
      local nYear = tonumber(os.date("!%Y", fixedTimeStamp))
      local nMonth = tonumber(os.date("!%m", fixedTimeStamp))
      local nDay = tonumber(os.date("!%d", fixedTimeStamp))
      local nowD = nYear * 366 + nMonth * 31 + nDay
      if nowD == _tipDay then
        confirmCallback()
        return
      end
    end
    local isSelectAgain = false
    
    local function func_confirm()
      if againKey ~= nil and isSelectAgain then
        local _curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
        local _fixedTimeStamp = _curTimeStamp - newDayTime * 3600
        local _nYear = tonumber(os.date("!%Y", _fixedTimeStamp))
        local _nMonth = tonumber(os.date("!%m", _fixedTimeStamp))
        local _nDay = tonumber(os.date("!%d", _fixedTimeStamp))
        local _nowD = _nYear * 366 + _nMonth * 31 + _nDay
        LocalData.SetPlayerLocalData(againKey, tostring(_nowD))
      end
      confirmCallback()
    end
    
    local function againCallback(isSelect)
      isSelectAgain = isSelect
    end
    
    local function cancelCallback()
    end
    
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = sTip,
      callbackConfirmAfterClose = func_confirm,
      callbackCancel = cancelCallback,
      callbackAgain = againKey ~= nil and againCallback or nil,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
  
  local function GachaCallback(mapData)
    self:GetGachaItem(mapData, mapGacha.StorageId)
    self:RefreshCoin(mapGacha)
  end
  
  local mapGachaStorage = ConfigTable.GetData("GachaStorage", mapGacha.StorageId)
  if mapGachaStorage == nil then
    return
  end
  local bSpecial = false
  local nCurSpecificCountCount = PlayerData.Item:GetItemCountByID(mapGacha.SpecificTid)
  if mapGacha.SpecificTid > 0 and nCurSpecificCountCount >= mapGachaStorage.DefaultQty then
    bSpecial = true
  end
  local nDefaultCount = PlayerData.Item:GetItemCountByID(mapGachaStorage.DefaultId)
  if nDefaultCount >= mapGachaStorage.DefaultQty or bSpecial then
    PlayerData.Gacha:SendGachaReq(self.curPoolId, 1, GachaCallback)
  elseif 0 < mapGachaStorage.CostId then
    local nCostCount = PlayerData.Item:GetItemCountByID(mapGachaStorage.CostId)
    
    local function confirmCallback()
      if nCostCount >= mapGachaStorage.CostQty * (mapGachaStorage.DefaultQty - nDefaultCount - nCurSpecificCountCount) then
        PlayerData.Gacha:SendGachaReq(self.curPoolId, 1, GachaCallback)
      elseif mapGachaStorage.CostId == AllEnum.CoinItemId.Jade then
        local nNeedCount = mapGachaStorage.CostQty * (mapGachaStorage.DefaultQty - nDefaultCount - nCurSpecificCountCount)
        local nJadeCount = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.Jade)
        nNeedCount = nNeedCount - nJadeCount
        local mapCostCfgData = ConfigTable.GetData_Item(AllEnum.CoinItemId.STONE)
        local mapJadeCfgData = ConfigTable.GetData_Item(AllEnum.CoinItemId.Jade)
        local sTips1 = orderedFormat(ConfigTable.GetUIText("Recruit_ExchangeGemZero"), mapJadeCfgData.Id, nNeedCount, mapCostCfgData.Id)
        
        local function confirmCallbackStone()
          local nCurStoneCount = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.STONE)
          nCurStoneCount = nCurStoneCount + PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.FREESTONE)
          if nCurStoneCount >= nNeedCount then
            PlayerData.Coin:SendGemConvertReqReq(nNeedCount, nil)
          else
            local sTips2 = orderedFormat(ConfigTable.GetUIText("Recruit_Charge") or "", mapCostCfgData.Id)
            
            local function confirmCallbackExchange()
              EventManager.Hit(EventId.OpenPanel, PanelId.Mall, AllEnum.MallToggle.Gem)
            end
            
            ConfirmPanel(sTips2, confirmCallbackExchange)
          end
        end
        
        ConfirmPanel(sTips1, confirmCallbackStone)
      else
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("NotEnoughItem"))
      end
    end
    
    local nNeedCount = mapGachaStorage.CostQty * (mapGachaStorage.DefaultQty - nDefaultCount)
    local mapCostCfgData = ConfigTable.GetData_Item(mapGachaStorage.CostId)
    local mapDefaultCfgData = ConfigTable.GetData_Item(mapGachaStorage.DefaultId)
    local sTips
    if 0 < nDefaultCount then
      if 0 < nCurSpecificCountCount then
        local nNeed = mapGachaStorage.CostQty * (mapGachaStorage.DefaultQty - nCurSpecificCountCount - nDefaultCount)
        sTips = orderedFormat(ConfigTable.GetUIText("Recruit_ExchangeGem2"), nDefaultCount, mapDefaultCfgData.Id, nCurSpecificCountCount, mapGacha.SpecificTid, nNeed, mapCostCfgData.Id, mapGachaStorage.DefaultQty - nCurSpecificCountCount - nDefaultCount, mapDefaultCfgData.Id)
      else
        sTips = orderedFormat(ConfigTable.GetUIText("Recruit_ExchangeGem"), nDefaultCount, mapDefaultCfgData.Id, nNeedCount, mapCostCfgData.Id, mapGachaStorage.DefaultQty - nDefaultCount, mapDefaultCfgData.Id)
      end
    elseif 0 < nCurSpecificCountCount then
      local nNeed = mapGachaStorage.CostQty * (mapGachaStorage.DefaultQty - nCurSpecificCountCount)
      sTips = orderedFormat(ConfigTable.GetUIText("Recruit_ExchangeGem"), nCurSpecificCountCount, mapGacha.SpecificTid, nNeed, mapCostCfgData.Id, mapGachaStorage.DefaultQty - nCurSpecificCountCount, mapDefaultCfgData.Id)
    else
      sTips = orderedFormat(ConfigTable.GetUIText("Recruit_Exchange"), nNeedCount, mapCostCfgData.Id, mapGachaStorage.DefaultQty - nDefaultCount, mapDefaultCfgData.Id)
    end
    ConfirmPanel(sTips, confirmCallback, "GachaShowTicketExchange")
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("NotEnoughItem"))
  end
end

function GachaCtrl:GachaTenExchangeCoin(mapGacha)
  local function ConfirmPanel(sTip, confirmCallback, againKey)
    if againKey ~= nil then
      local TipsTime = LocalData.GetPlayerLocalData(againKey)
      
      local _tipDay = 0
      if TipsTime ~= nil then
        _tipDay = tonumber(TipsTime)
      end
      local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
      local fixedTimeStamp = curTimeStamp - newDayTime * 3600
      local nYear = tonumber(os.date("!%Y", fixedTimeStamp))
      local nMonth = tonumber(os.date("!%m", fixedTimeStamp))
      local nDay = tonumber(os.date("!%d", fixedTimeStamp))
      local nowD = nYear * 366 + nMonth * 31 + nDay
      if nowD == _tipDay then
        confirmCallback()
        return
      end
    end
    local isSelectAgain = false
    
    local function func_confirm()
      if againKey ~= nil and isSelectAgain then
        local _curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
        local _fixedTimeStamp = _curTimeStamp - newDayTime * 3600
        local _nYear = tonumber(os.date("!%Y", _fixedTimeStamp))
        local _nMonth = tonumber(os.date("!%m", _fixedTimeStamp))
        local _nDay = tonumber(os.date("!%d", _fixedTimeStamp))
        local _nowD = _nYear * 366 + _nMonth * 31 + _nDay
        LocalData.SetPlayerLocalData(againKey, tostring(_nowD))
      end
      confirmCallback()
    end
    
    local function againCallback(isSelect)
      isSelectAgain = isSelect
    end
    
    local function cancelCallback()
    end
    
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = sTip,
      callbackConfirmAfterClose = func_confirm,
      callbackCancel = cancelCallback,
      callbackAgain = againKey ~= nil and againCallback or nil,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
  
  local bGetFirstTenReward = PlayerData.Gacha:GetRecvFirstTenReward(self.curPoolId)
  
  local function GachaCallback(mapData)
    self:GetGachaItem(mapData, mapGacha.StorageId, bGetFirstTenReward)
    self:RefreshCoin(mapGacha)
  end
  
  local mapGachaStorage = ConfigTable.GetData("GachaStorage", mapGacha.StorageId)
  if mapGachaStorage == nil then
    return
  end
  local bSpecial = false
  local nSpecificCount = 0
  local nSpecificGachaCount = 0
  local nDefaultCount = PlayerData.Item:GetItemCountByID(mapGachaStorage.DefaultId)
  if 0 < mapGacha.SpecificTid then
    nSpecificCount = PlayerData.Item:GetItemCountByID(mapGacha.SpecificTid)
    if nSpecificCount >= 10 * mapGachaStorage.DefaultQty then
      bSpecial = true
    elseif 0 < nSpecificCount and 10 <= math.floor((nDefaultCount + nSpecificCount) / mapGachaStorage.DefaultQty) then
      bSpecial = true
    end
  end
  if nDefaultCount >= mapGachaStorage.DefaultQty * 10 or bSpecial then
    PlayerData.Gacha:SendGachaReq(self.curPoolId, 2, GachaCallback)
  elseif 0 < mapGachaStorage.CostId then
    local nCostCount = PlayerData.Item:GetItemCountByID(mapGachaStorage.CostId)
    
    local function confirmCallback()
      if nCostCount >= mapGachaStorage.CostQty * (mapGachaStorage.DefaultQty * 10 - nSpecificCount - nDefaultCount) then
        PlayerData.Gacha:SendGachaReq(self.curPoolId, 2, GachaCallback)
      elseif mapGachaStorage.CostId == AllEnum.CoinItemId.Jade then
        local nNeedCount = mapGachaStorage.CostQty * (mapGachaStorage.DefaultQty * 10 - nSpecificCount - nDefaultCount)
        local nJadeCount = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.Jade)
        nNeedCount = nNeedCount - nJadeCount
        local mapCostCfgData = ConfigTable.GetData_Item(AllEnum.CoinItemId.STONE)
        local mapJadeCfgData = ConfigTable.GetData_Item(AllEnum.CoinItemId.Jade)
        local sTips1 = orderedFormat(ConfigTable.GetUIText("Recruit_ExchangeGemZero"), mapJadeCfgData.Id, nNeedCount, mapCostCfgData.Id)
        
        local function confirmCallbackStone()
          local nCurStoneCount = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.STONE)
          nCurStoneCount = nCurStoneCount + PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.FREESTONE)
          if nCurStoneCount >= nNeedCount then
            PlayerData.Coin:SendGemConvertReqReq(nNeedCount, nil)
          else
            local sTips2 = orderedFormat(ConfigTable.GetUIText("Recruit_Charge") or "", mapCostCfgData.Id)
            
            local function confirmCallbackExchange()
              EventManager.Hit(EventId.OpenPanel, PanelId.Mall, AllEnum.MallToggle.Gem)
            end
            
            ConfirmPanel(sTips2, confirmCallbackExchange)
          end
        end
        
        ConfirmPanel(sTips1, confirmCallbackStone)
      else
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("NotEnoughItem"))
      end
    end
    
    local nNeedCount = mapGachaStorage.CostQty * (mapGachaStorage.DefaultQty * 10 - nSpecificCount - nDefaultCount)
    local mapCostCfgData = ConfigTable.GetData_Item(mapGachaStorage.CostId)
    local mapDefaultCfgData = ConfigTable.GetData_Item(mapGachaStorage.DefaultId)
    local sTips
    if 0 < nDefaultCount and 0 < nSpecificCount then
      sTips = orderedFormat(ConfigTable.GetUIText("Recruit_ExchangeGem2"), nDefaultCount, mapDefaultCfgData.Id, nSpecificCount, mapGacha.SpecificTid, nNeedCount, mapCostCfgData.Id, mapGachaStorage.DefaultQty * 10 - nSpecificCount - nDefaultCount, mapDefaultCfgData.Id)
    elseif 0 < nDefaultCount then
      sTips = orderedFormat(ConfigTable.GetUIText("Recruit_ExchangeGem"), nDefaultCount, mapDefaultCfgData.Id, nNeedCount, mapCostCfgData.Id, mapGachaStorage.DefaultQty * 10 - nSpecificCount - nDefaultCount, mapDefaultCfgData.Id)
    elseif 0 < nSpecificCount then
      sTips = orderedFormat(ConfigTable.GetUIText("Recruit_ExchangeGem"), nSpecificCount, mapGacha.SpecificTid, nNeedCount, mapCostCfgData.Id, mapGachaStorage.DefaultQty * 10 - nSpecificCount - nDefaultCount, mapDefaultCfgData.Id)
    else
      sTips = orderedFormat(ConfigTable.GetUIText("Recruit_Exchange"), nNeedCount, mapCostCfgData.Id, mapGachaStorage.DefaultQty * 10 - nSpecificCount - nDefaultCount, mapDefaultCfgData.Id)
    end
    ConfirmPanel(sTips, confirmCallback, "GachaShowTicketExchange")
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("NotEnoughItem"))
  end
end

function GachaCtrl:OnBtnClick_Tab(goBtn, nGachaId)
  CS.WwiseAudioManager.Instance:PostEvent("ui_recuit_cover_all_stop")
  if self.curPoolId == nGachaId then
    return
  end
  self:SetTabSelect(self.curPoolId, false)
  self:SetTabSelect(nGachaId, true)
  self:SetCoverOpen(nGachaId)
  self.curPoolId = nGachaId
  self:RefreshInfo()
  self.mapCover[self.curPoolId]:PlayInAnim()
end

function GachaCtrl:OnBtnClick_One()
  if not self:IsRemain_One(self.curPoolId) then
    local sTip = ConfigTable.GetUIText("Gacha_GachaTimeLimitTips")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  if self.bGachaProcess then
    return
  end
  CS.WwiseAudioManager.Instance:PostEvent("ui_recuit_cover_all_stop")
  
  local function GachaCallback(mapData)
    local mapGacha = ConfigTable.GetData("Gacha", self.curPoolId)
    if mapGacha == nil then
      return
    end
    self:RefreshCoin(mapGacha)
    self:GetGachaItem(mapData, mapGacha.StorageId)
  end
  
  if self.curPoolId == nil or self.curPoolId == 0 then
    return
  end
  local mapGacha = ConfigTable.GetData("Gacha", self.curPoolId)
  if mapGacha == nil then
    return
  end
  local mapGachaStorage = ConfigTable.GetData("GachaStorage", mapGacha.StorageId)
  if mapGachaStorage == nil then
    return
  end
  local rapidjson = require("rapidjson")
  if type(mapGachaStorage.OncePreferred) == "string" then
    local tbOne = rapidjson.decode(mapGachaStorage.OncePreferred)
    if tbOne ~= nil then
      mapGachaStorage.OncePreferred = tbOne
    else
      mapGachaStorage.OncePreferred = {}
      printError("单抽消耗配置错误：" .. self.curPoolId)
      return
    end
  end
  local bSpecialOne = false
  if 0 < mapGacha.SpecificTid then
    local nCurCount = PlayerData.Item:GetItemCountByID(mapGacha.SpecificTid)
    local nSpecialCount = math.floor(nCurCount / mapGachaStorage.DefaultQty)
    if 1 <= nSpecialCount then
      bSpecialOne = true
    end
  end
  if bSpecialOne then
    PlayerData.Gacha:SendGachaReq(self.curPoolId, 1, GachaCallback)
  elseif 0 < #mapGachaStorage.OncePreferred then
    for nIdx, mapCost in ipairs(mapGachaStorage.OncePreferred) do
      local f = pairs(mapCost)
      local sTid, nCount = f(mapCost)
      local nTid = tonumber(sTid)
      local nCurCount = PlayerData.Item:GetItemCountByID(nTid)
      if nCount <= nCurCount then
        PlayerData.Gacha:SendGachaReq(self.curPoolId, 1, GachaCallback)
        break
      end
      if nIdx == #mapGachaStorage.OncePreferred then
        self:GachaOneExchangeCoin(mapGacha)
      end
    end
  else
    self:GachaOneExchangeCoin(mapGacha)
  end
end

function GachaCtrl:OnBtnClick_Ten()
  if not self:IsRemain_Ten(self.curPoolId) then
    local sTip = ConfigTable.GetUIText("Gacha_GachaTimeLimitTips")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  if self.bGachaProcess then
    return
  end
  if self.curPoolId == nil or self.curPoolId == 0 then
    return
  end
  local bGetFirstTenReward = PlayerData.Gacha:GetRecvFirstTenReward(self.curPoolId)
  local mapGacha = ConfigTable.GetData("Gacha", self.curPoolId)
  if mapGacha == nil then
    return
  end
  CS.WwiseAudioManager.Instance:PostEvent("ui_recuit_cover_all_stop")
  
  local function GachaCallback(mapData)
    local mapGacha = ConfigTable.GetData("Gacha", self.curPoolId)
    if mapGacha == nil then
      return
    end
    self:RefreshCoin(mapGacha)
    self:GetGachaItem(mapData, mapGacha.StorageId, bGetFirstTenReward)
  end
  
  local mapGachaStorage = ConfigTable.GetData("GachaStorage", mapGacha.StorageId)
  if mapGachaStorage == nil then
    return
  end
  local rapidjson = require("rapidjson")
  if type(mapGachaStorage.TenTimesPreferred) == "string" then
    local tbTen = rapidjson.decode(mapGachaStorage.TenTimesPreferred)
    if tbTen ~= nil then
      mapGachaStorage.TenTimesPreferred = tbTen
    else
      mapGachaStorage.TenTimesPreferred = {}
      printError("十连消耗配置错误：" .. self.curPoolId)
      return
    end
  end
  local nSpecialCount = 0
  local nDefaultCurCount = PlayerData.Item:GetItemCountByID(mapGachaStorage.DefaultId)
  local nDefaultGachaCount = math.floor(nDefaultCurCount / mapGachaStorage.DefaultQty)
  local nCurSpecificCount = PlayerData.Item:GetItemCountByID(mapGacha.SpecificTid)
  if 0 < mapGacha.SpecificTid then
    nSpecialCount = math.floor(nCurSpecificCount / mapGachaStorage.DefaultQty)
  end
  
  local function specialGachaHint(Tid1, Tid2, nCount1, nCount2, againKey)
    local function confirmCallback()
      PlayerData.Gacha:SendGachaReq(self.curPoolId, 2, GachaCallback)
    end
    
    if againKey ~= nil then
      local TipsTime = LocalData.GetPlayerLocalData(againKey)
      local _tipDay = 0
      if TipsTime ~= nil then
        _tipDay = tonumber(TipsTime)
      end
      local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
      local fixedTimeStamp = curTimeStamp - newDayTime * 3600
      local nYear = tonumber(os.date("!%Y", fixedTimeStamp))
      local nMonth = tonumber(os.date("!%m", fixedTimeStamp))
      local nDay = tonumber(os.date("!%d", fixedTimeStamp))
      local nowD = nYear * 366 + nMonth * 31 + nDay
      if nowD == _tipDay then
        confirmCallback()
        return
      end
    end
    local isSelectAgain = false
    
    local function func_confirm()
      if againKey ~= nil and isSelectAgain then
        local _curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
        local _fixedTimeStamp = _curTimeStamp - newDayTime * 3600
        local _nYear = tonumber(os.date("!%Y", _fixedTimeStamp))
        local _nMonth = tonumber(os.date("!%m", _fixedTimeStamp))
        local _nDay = tonumber(os.date("!%d", _fixedTimeStamp))
        local _nowD = _nYear * 366 + _nMonth * 31 + _nDay
        LocalData.SetPlayerLocalData(againKey, tostring(_nowD))
      end
      confirmCallback()
    end
    
    local function againCallback(isSelect)
      isSelectAgain = isSelect
    end
    
    local function cancelCallback()
    end
    
    local sTips = orderedFormat(ConfigTable.GetUIText("Recruit_ComboDrawTicket"), nCount1, Tid1, nCount2, Tid2)
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = sTips,
      callbackConfirmAfterClose = func_confirm,
      callbackCancel = cancelCallback,
      callbackAgain = againKey ~= nil and againCallback or nil,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
  
  if 10 <= nSpecialCount then
    PlayerData.Gacha:SendGachaReq(self.curPoolId, 2, GachaCallback)
  elseif 0 < nCurSpecificCount and math.floor((nDefaultCurCount + nCurSpecificCount) / mapGachaStorage.DefaultQty) >= 10 then
    local nCostSpecific = nCurSpecificCount
    local nCostDefault = 10 * mapGachaStorage.DefaultQty - nCurSpecificCount
    specialGachaHint(mapGacha.SpecificTid, mapGachaStorage.DefaultId, nCostSpecific, nCostDefault, "RecruitComboDrawTicketHint")
  elseif #mapGachaStorage.TenTimesPreferred > 0 then
    for nIdx, mapCost in ipairs(mapGachaStorage.TenTimesPreferred) do
      local f = pairs(mapCost)
      local sTid, nCount = f(mapCost)
      local nTid = tonumber(sTid)
      local nCurCount = PlayerData.Item:GetItemCountByID(nTid)
      if nCount <= nCurCount then
        PlayerData.Gacha:SendGachaReq(self.curPoolId, 2, GachaCallback)
        break
      end
      if nIdx == #mapGachaStorage.TenTimesPreferred then
        self:GachaTenExchangeCoin(mapGacha)
      end
    end
  else
    self:GachaTenExchangeCoin(mapGacha)
  end
end

function GachaCtrl:OnBtnClick_GachaDetail()
  self._mapNode.GachaProb.gameObject:SetActive(false)
  self._mapNode.GachaInfo:OpenInfo()
end

function GachaCtrl:OnBtnClick_ProbDetail()
  self._mapNode.GachaInfo.gameObject:SetActive(false)
  self._mapNode.GachaProb:OpenInfo()
end

function GachaCtrl:OnBtnClick_GachaHistory()
  local mapGacha = ConfigTable.GetData("Gacha", self.curPoolId)
  if mapGacha ~= nil then
    local function GetDataCallback(tbData)
      self._mapNode.GachaHistory:OpenPanel(mapGacha.StorageId, self.curPoolId)
    end
    
    PlayerData.Gacha:GetGachaHistory(mapGacha.StorageId, GetDataCallback)
  end
end

function GachaCtrl:OnBtnClick_shop()
  EventManager.Hit(EventId.OpenPanel, PanelId.Mall, AllEnum.MallToggle.Shop)
end

function GachaCtrl:OnEvent_GachaPoolDetail(nIdx)
end

function GachaCtrl:GetGachaItem(mapData, nStorageId, bGetFirstTenReward)
  local tbReward = {}
  local mapRewardItem = {}
  local rare = 3
  local tbGiveItems = {}
  local nStorage = 0
  local mapGachaData = ConfigTable.GetData("Gacha", self.curPoolId)
  if mapGachaData ~= nil then
    nStorage = mapGachaData.StorageId
    local mapStorage = ConfigTable.GetData("GachaStorage", nStorage)
    if mapStorage ~= nil then
      local sGiveItem = mapStorage.GiveItems
      local mapDecodeItems = decodeJson(sGiveItem)
      for nTid, nCount in pairs(mapDecodeItems) do
        table.insert(tbGiveItems, {
          Tid = tonumber(nTid),
          Qty = tonumber(nCount)
        })
      end
    end
  end
  local mapChangeInfo = UTILS.DecodeChangeInfo(mapData.Change)
  local tbAcquire = mapChangeInfo["proto.Acquire"]
  if tbAcquire ~= nil then
    tbAcquire = tbAcquire[1]
  end
  if tbAcquire == nil then
    tbAcquire = {}
  end
  
  local function GetRewardItem(nIdx, nTid)
    local ret = {}
    local nNumber = 0
    if tbAcquire.List ~= nil then
      for _, mapAcq in ipairs(tbAcquire.List) do
        if mapAcq.Tid == nTid then
          nNumber = mapAcq.Begin
        end
      end
    end
    for i = 1, nIdx do
      if mapData.Cards[i].Card.Tid == nTid then
        nNumber = nNumber + 1
      end
    end
    local mapItemCfgData = ConfigTable.GetData_Item(nTid)
    if mapItemCfgData == nil then
      return ret
    end
    local mapByStype = self._mapMaxAcquireReward[mapItemCfgData.Stype]
    local nMaxCount = mapByStype[mapItemCfgData.Rarity] or 1
    nNumber = math.min(nMaxCount, nNumber)
    local nId = mapItemCfgData.Stype * 1000 + mapItemCfgData.Rarity * 100 + nNumber
    local mapCfg = ConfigTable.GetData("AcquireReward", nId)
    if not mapCfg or mapCfg.ItemNum == 0 then
      return ret
    end
    table.insert(ret, {
      Tid = mapCfg.ItemId,
      Qty = mapCfg.ItemNum
    })
    return ret
  end
  
  for nIdx, v in ipairs(mapData.Cards) do
    local tbAcReward = GetRewardItem(nIdx, v.Card.Tid)
    for _, mapReward in ipairs(tbAcReward) do
      table.insert(v.Rewards, mapReward)
    end
    table.insert(tbReward, {
      id = v.Card.Tid,
      count = v.Card.Qty,
      rewardItem = v.Rewards,
      bNew = v.Card.bNew,
      exItem = tbGiveItems
    })
    local mapItem = ConfigTable.GetData_Item(v.Card.Tid)
    if mapItem ~= nil then
      if rare > mapItem.Rarity then
        rare = mapItem.Rarity
      end
      if mapItem.Stype == GameEnum.itemStype.Char then
        PlayerData.Talent:UpdateCharTalentRedDot(v.Card.Tid)
      end
    end
    if v.Rewards ~= nil and #v.Rewards > 0 then
      for _, mapItem in ipairs(v.Rewards) do
        if mapRewardItem[mapItem.Tid] == nil then
          mapRewardItem[mapItem.Tid] = 0
        end
        mapRewardItem[mapItem.Tid] = mapRewardItem[mapItem.Tid] + mapItem.Qty
      end
    end
  end
  
  local function OnGachaDragOpenDoor()
    WwiseManger.Instance:PostEvent("music_recruit_rarity_3s")
  end
  
  local function OnShowFinish()
    EventManager.Remove("GaChaShowVideoEnd", self, OnShowFinish)
    EventManager.Remove("GachaDragOpenDoor", self, OnGachaDragOpenDoor)
    self.bGachaProcess = false
    if nStorage == GameEnum.gachaStorageType.DiscCardPool or nStorage == GameEnum.gachaStorageType.DiscUpCardPool then
      WwiseManger.Instance:SetState("recruit_rarity", "diskR")
    else
      WwiseManger.Instance:SetState("recruit_rarity", "R")
    end
    self:RefreshCover()
    self:RefreshRemainGachaTimes(self.curPoolId)
    self._mapNode.GachaShow:ShowResults(tbReward, tbGiveItems)
    PlayerData.SideBanner:TryOpenSideBanner()
  end
  
  local function OnShowItemEnd()
    EventManager.Remove("GachaShowItemEnd", self, OnShowItemEnd)
    if #mapData.Cards < 10 then
      CS.WwiseAudioManager.Instance:SetState("recruit_rarity", "None")
      PlayerData.Item:TryOpenFragmentsOverflow(function()
        PlayerData.Phone:CheckNewChat()
      end)
      return
    end
    self._mapNode.GachaShowResult.gameObject:SetActive(true)
    for _, mapItem in ipairs(tbGiveItems) do
      mapItem.Qty = mapItem.Qty * #tbReward
      if bGetFirstTenReward ~= nil and not bGetFirstTenReward and mapGachaData ~= nil then
        local nTimes = mapGachaData.FirstTenShow == 0 and 1 or mapGachaData.FirstTenShow
        mapItem.Qty = mapItem.Qty * nTimes
      end
    end
    self._mapNode.GachaShowResult:ShowResult(tbReward, mapRewardItem, tbGiveItems)
  end
  
  EventManager.Add("GachaDragOpenDoor", self, OnGachaDragOpenDoor)
  EventManager.Add("GaChaShowVideoEnd", self, OnShowFinish)
  EventManager.Add("GachaShowItemEnd", self, OnShowItemEnd)
  if not self:CheckGachaVideoRes() then
    OnShowFinish()
  else
    WwiseManger.Instance:SetState("recruit_rarity", "transition")
    if nStorage == GameEnum.gachaStorageType.DiscCardPool or nStorage == GameEnum.gachaStorageType.DiscUpCardPool then
      local sup = math.random(0, 2) > 1
      NovaAPI.PlayGachaDisc(self._mapNode.GachaOpenDoor, #mapData.Cards, rare, sup)
    else
      local sup = math.random(0, 100)
      local nType = 3
      if sup <= 5 then
        nType = 0
      elseif sup <= 10 then
        nType = 2
      elseif sup <= 55 then
        nType = 1
      else
        nType = 3
      end
      NovaAPI.PlayGachaOpenDoor(self._mapNode.GachaOpenDoor, rare, nType)
    end
  end
end

function GachaCtrl:CheckGachaVideoRes()
  local ProVideoManager = CS.ProVideoManager
  local File = CS.System.IO.File
  local path = ProVideoManager.GetVideoResourcePath("Gacha_001.mp4")
  if not File.Exists(path) then
    return false
  end
  path = ProVideoManager.GetVideoResourcePath("Gacha_002_loop.mp4")
  if not File.Exists(path) then
    return false
  end
  path = ProVideoManager.GetVideoResourcePath("Gacha_003.mp4")
  if not File.Exists(path) then
    return false
  end
  path = ProVideoManager.GetVideoResourcePath("Gacha_003_r.mp4")
  if not File.Exists(path) then
    return false
  end
  path = ProVideoManager.GetVideoResourcePath("Gacha_003_r_1.mp4")
  if not File.Exists(path) then
    return false
  end
  path = ProVideoManager.GetVideoResourcePath("Gacha_car_001.mp4")
  if not File.Exists(path) then
    return false
  end
  path = ProVideoManager.GetVideoResourcePath("Gacha_car_001_r.mp4")
  if not File.Exists(path) then
    return false
  end
  path = ProVideoManager.GetVideoResourcePath("gacha_disc.mp4")
  if not File.Exists(path) then
    return false
  end
  path = ProVideoManager.GetVideoResourcePath("gacha_disc_10_g.mp4")
  if not File.Exists(path) then
    return false
  end
  path = ProVideoManager.GetVideoResourcePath("gacha_disc_10_r.mp4")
  if not File.Exists(path) then
    return false
  end
  path = ProVideoManager.GetVideoResourcePath("gacha_disc_10_r_1.mp4")
  if not File.Exists(path) then
    return false
  end
  path = ProVideoManager.GetVideoResourcePath("gacha_disc_g.mp4")
  if not File.Exists(path) then
    return false
  end
  path = ProVideoManager.GetVideoResourcePath("gacha_disc_r.mp4")
  if not File.Exists(path) then
    return false
  end
  return true
end

function GachaCtrl:OnEvent_GachaProcessStart(bStart)
  self.bGachaProcess = bStart
end

function GachaCtrl:OnEvent_GachaNeedRefresh()
  self:RefreshAll()
end

function GachaCtrl:GetGachaNewbieItem(mapData)
  local tbReward = {}
  local rare = 3
  
  local function CheckNew(nTid)
    local mapItemCfgData = ConfigTable.GetData_Item(nTid)
    if mapItemCfgData == nil then
      return false
    end
    if mapItemCfgData.Type == GameEnum.itemType.Char then
      local mapChar = PlayerData.Char:GetCharDataByTid(nTid)
      return mapChar == nil
    elseif mapItemCfgData.Type == GameEnum.itemType.Disc then
      local mapDisc = PlayerData.Disc:GetDiscById(nTid)
      return mapDisc == nil
    else
      return false
    end
  end
  
  local curItem = {}
  for _, v in ipairs(mapData.Cards) do
    local mapItem = ConfigTable.GetData_Item(v)
    local bForceJump = mapItem == nil or mapItem.Rarity ~= GameEnum.itemRarity.SSR
    table.insert(tbReward, {
      id = v,
      count = 1,
      rewardItem = {},
      bForceJump = bForceJump,
      bNew = CheckNew(v) and 1 > table.indexof(curItem, v),
      exItem = {}
    })
    local mapItem = ConfigTable.GetData_Item(v)
    if mapItem ~= nil and rare > mapItem.Rarity then
      rare = mapItem.Rarity
    end
    table.insert(curItem, v)
  end
  
  local function OnGachaDragOpenDoor()
    WwiseManger.Instance:PostEvent("music_recruit_rarity_3s")
  end
  
  local function OnShowFinish()
    EventManager.Remove("GaChaShowVideoEnd", self, OnShowFinish)
    EventManager.Remove("GachaDragOpenDoor", self, OnGachaDragOpenDoor)
    self.bGachaProcess = false
    self:RefreshCover()
    self._mapNode.GachaShow:ShowResults(tbReward, {})
    PlayerData.SideBanner:TryOpenSideBanner()
  end
  
  local function OnShowItemEnd()
    EventManager.Remove("GachaShowItemEnd", self, OnShowItemEnd)
    WwiseManger.Instance:SetState("recruit_rarity", "R")
    if #mapData.Cards < 10 then
      CS.WwiseAudioManager.Instance:SetState("recruit_rarity", "None")
      PlayerData.Item:TryOpenFragmentsOverflow(function()
        PlayerData.Phone:CheckNewChat()
      end)
      return
    end
    self._mapNode.GachaNewBieShowResult.gameObject:SetActive(true)
    self._mapNode.GachaNewBieShowResult:ShowResult(tbReward, self.curPoolId)
  end
  
  EventManager.Add("GachaDragOpenDoor", self, OnGachaDragOpenDoor)
  EventManager.Add("GaChaShowVideoEnd", self, OnShowFinish)
  EventManager.Add("GachaShowItemEnd", self, OnShowItemEnd)
  if not self:CheckGachaVideoRes() then
    OnShowFinish()
  else
    WwiseManger.Instance:SetState("recruit_rarity", "transition")
    local sup = math.random(0, 100)
    local nType = 3
    if sup <= 5 then
      nType = 0
    elseif sup <= 10 then
      nType = 2
    elseif sup <= 55 then
      nType = 1
    else
      nType = 3
    end
    NovaAPI.PlayGachaOpenDoor(self._mapNode.GachaOpenDoor, rare, nType)
  end
end

function GachaCtrl:OnEvent_GachaNewbieSpin()
  self:OnBtnClick_NewBieJump()
end

function GachaCtrl:OnEvent_GachaNewbieRecord()
  self:OnBtnClick_NewBieJumpRecord()
end

function GachaCtrl:OnEvent_GachaNewbieObtainRecord(idx, items)
  self._mapNode.GachaNewBieObtainResult:SetItems(self.curPoolId, idx, items)
  self._mapNode.GachaNewBieObtainResult.gameObject:SetActive(true)
end

function GachaCtrl:OnEvent_GachaNewbieSaveRecord()
  local newbie = ConfigTable.GetData("GachaNewbie", self.curPoolId)
  if newbie == nil then
    return
  end
  local newbieData = PlayerData.Gacha:GetGachaNewbieData(self.curPoolId)
  if newbieData == nil then
    return
  end
  if #newbieData.Temp == 0 then
    return
  end
  if #newbieData.Cards < newbie.SaveCount then
    local function GachaCallback(mapData)
      self:RefreshInfo()
      
      self._mapNode.GachaNewBieShowResult:RefreshInfo()
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Gacha_NewBieSaveTip"))
    end
    
    PlayerData.Gacha:SendGachaNewbieSaveReq(self.curPoolId, 0, GachaCallback)
    return
  end
  self._mapNode.GachaNewBieSaveRecord:SetItems(self.curPoolId)
  self._mapNode.GachaNewBieSaveRecord.gameObject:SetActive(true)
end

function GachaCtrl:OnEvent_GachaNewbieReplaceRecord(idx)
  self._mapNode.GachaNewBieReplaceResult:SetItems(self.curPoolId, idx)
  self._mapNode.GachaNewBieReplaceResult.gameObject:SetActive(true)
end

function GachaCtrl:OnEvent_GachaNewbieReplaceRecordOver()
  self:RefreshInfo()
  self._mapNode.GachaNewBieShowResult:RefreshInfo()
  self._mapNode.GachaNewBieReplaceResult.gameObject:SetActive(false)
  self._mapNode.GachaNewBieSaveRecord.gameObject:SetActive(false)
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Gacha_NewBieSaveTip"))
end

function GachaCtrl:OnEvent_GachaNewbieObtainRecordOver(changes, items, tbNew)
  local tbReward = {}
  local mapRewardItem = {}
  local rare = 3
  local tbGiveItems = {}
  if tbNew == nil then
    tbNew = {}
  end
  local mapGachaData = ConfigTable.GetData("Gacha", self.curPoolId)
  if mapGachaData ~= nil then
    local nStorage = mapGachaData.StorageId
    local mapStorage = ConfigTable.GetData("GachaStorage", nStorage)
    if mapStorage ~= nil then
      local sGiveItem = mapStorage.GiveItems
      local mapDecodeItems = decodeJson(sGiveItem)
      for nTid, nCount in pairs(mapDecodeItems) do
        table.insert(tbGiveItems, {
          Tid = tonumber(nTid),
          Qty = tonumber(nCount)
        })
      end
    end
  end
  local mapChangeInfo = UTILS.DecodeChangeInfo(changes)
  local tbAcquire = mapChangeInfo["proto.Acquire"]
  if tbAcquire ~= nil then
    tbAcquire = tbAcquire[1]
  end
  if tbAcquire == nil then
    tbAcquire = {}
  end
  
  local function GetRewardItem(nIdx, nTid)
    local ret = {}
    local nNumber = 0
    if tbAcquire.List ~= nil then
      for _, mapAcq in ipairs(tbAcquire.List) do
        if mapAcq.Tid == nTid then
          nNumber = mapAcq.Begin
        end
      end
    end
    for i = 1, nIdx do
      if items[i] == nTid then
        nNumber = nNumber + 1
      end
    end
    local mapItemCfgData = ConfigTable.GetData_Item(nTid)
    if mapItemCfgData == nil then
      return ret
    end
    local mapByStype = self._mapMaxAcquireReward[mapItemCfgData.Stype]
    local nMaxCount = mapByStype[mapItemCfgData.Rarity] or 1
    nNumber = math.min(nMaxCount, nNumber)
    local nId = mapItemCfgData.Stype * 1000 + mapItemCfgData.Rarity * 100 + nNumber
    local mapCfg = ConfigTable.GetData("AcquireReward", nId)
    if not mapCfg or mapCfg.ItemNum == 0 then
      return ret
    end
    table.insert(ret, {
      Tid = mapCfg.ItemId,
      Qty = mapCfg.ItemNum
    })
    return ret
  end
  
  for nIdx, v in ipairs(items) do
    local tbAcReward = GetRewardItem(nIdx, v)
    local rewards = {}
    for _, mapReward in ipairs(tbAcReward) do
      table.insert(rewards, mapReward)
    end
    table.insert(tbReward, {
      id = v,
      count = 1,
      rewardItem = rewards,
      bNew = tbNew[nIdx] or false,
      exItem = tbGiveItems
    })
    local mapItem = ConfigTable.GetData_Item(v)
    if mapItem ~= nil and rare > mapItem.Rarity then
      rare = mapItem.Rarity
    end
    if rewards ~= nil and 0 < #rewards then
      for _, mapItem in ipairs(rewards) do
        if mapRewardItem[mapItem.Tid] == nil then
          mapRewardItem[mapItem.Tid] = 0
        end
        mapRewardItem[mapItem.Tid] = mapRewardItem[mapItem.Tid] + mapItem.Qty
      end
    end
  end
  
  local function OnShowItemEnd()
    EventManager.Remove("GachaShowItemEnd", self, OnShowItemEnd)
    if #items < 10 then
      CS.WwiseAudioManager.Instance:SetState("recruit_rarity", "None")
      PlayerData.Item:TryOpenFragmentsOverflow(function()
        PlayerData.Phone:CheckNewChat()
      end)
      return
    end
    self._mapNode.GachaShowResult.gameObject:SetActive(true)
    for _, mapItem in ipairs(tbGiveItems) do
      mapItem.Qty = mapItem.Qty * #tbReward
    end
    self._mapNode.GachaShowResult:ShowResult(tbReward, mapRewardItem, tbGiveItems)
    self:RefreshAll()
  end
  
  EventManager.Add("GachaShowItemEnd", self, OnShowItemEnd)
  self._mapNode.GachaNewBieObtainResult.gameObject:SetActive(false)
  self._mapNode.GachaNewBieShowRecord.gameObject:SetActive(false)
  self._mapNode.GachaNewBieShowResult.gameObject:SetActive(false)
  self:RefreshCover()
  self._mapNode.GachaShow:ShowResults(tbReward, tbGiveItems)
  PlayerData.SideBanner:TryOpenSideBanner()
end

function GachaCtrl:OnEvent_GachaCoverEntranceGo()
  if self.bGachaProcess then
    return
  end
  local bOpen = PlayerData.Gacha:CheckPoolOpen(self.curPoolId)
  if not bOpen then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_End_Notice"))
    return
  end
  local gachaData = ConfigTable.GetData("Gacha", self.curPoolId)
  if gachaData ~= nil then
    local nTrailId = gachaData.TrailId
    if 0 < nTrailId then
      do
        local function callback()
          local mapTrialCfgData = ConfigTable.GetData("TrialControl", gachaData.TrailId)
          
          if mapTrialCfgData ~= nil then
            local nIdx = table.indexof(mapTrialCfgData.Gachas, self.curPoolId)
            if 0 < nIdx then
              PlayerData.Trial:SetTrialAct(nTrailId)
              PlayerData.Trial:SetSelectTrialGroup(mapTrialCfgData.GroupIds[nIdx])
              EventManager.Hit(EventId.OpenPanel, PanelId.TrialLevelSelect)
            end
          end
        end
        
        PlayerData.Activity:SendActivityDetailMsg(callback)
      end
    end
  end
end

function GachaCtrl:OnBtnClick_NewBieJump()
  if self.bGachaProcess then
    return
  end
  
  local function GachaCallback(mapData)
    self:GetGachaNewbieItem(mapData)
    self:RefreshInfo()
    self:RefreshCover()
    self._mapNode.GachaNewBieShowResult:RefreshInfo()
  end
  
  local newbieData = PlayerData.Gacha:GetGachaNewbieData(self.curPoolId)
  if newbieData == nil then
    return
  end
  local newbie = ConfigTable.GetData("GachaNewbie", self.curPoolId)
  if newbie == nil then
    return
  end
  if newbieData.Times < newbie.SpinCount then
    PlayerData.Gacha:SendGachaNewbieReq(self.curPoolId, GachaCallback)
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Gacha_NewBieSummonLimit"))
  end
end

function GachaCtrl:OnBtnClick_NewBieJumpRecord()
  local newbieData = PlayerData.Gacha:GetGachaNewbieData(self.curPoolId)
  if newbieData ~= nil then
    if #newbieData.Cards == 0 and #newbieData.Temp == 0 then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Gacha_NewBieNoRecordTip"))
    else
      self._mapNode.GachaNewBieShowRecord:SetPoolId(self.curPoolId)
      self._mapNode.GachaNewBieShowRecord.gameObject:SetActive(true)
    end
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Gacha_NewBieNoRecordTip"))
  end
end

function GachaCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId or self.bGachaProcess then
    return
  end
  EventManager.Hit(EventId.CloesCurPanel)
end

function GachaCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId or self.bGachaProcess then
    return
  end
  PanelManager.Home()
end

return GachaCtrl

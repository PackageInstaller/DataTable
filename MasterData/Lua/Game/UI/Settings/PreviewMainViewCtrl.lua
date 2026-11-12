local PreviewMainViewCtrl = class("PreviewMainViewCtrl", BaseCtrl)
local PlayerBoardData = PlayerData.Board
local PlayerVoiceData = PlayerData.Voice
local AvgData = PlayerData.Avg
local LocalData = require("GameCore.Data.LocalData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local TimerManager = require("GameCore.Timer.TimerManager")
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
PreviewMainViewCtrl._mapNodeConfig = {
  btnSkipCGAnim = {sComponentName = "Button"},
  rawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  imgOutfit = {sComponentName = "Image"},
  HideRoot = {},
  txtName = {sComponentName = "TMP_Text"},
  imgEnergyIcon = {sComponentName = "Image"},
  txtEnergyCount = {sComponentName = "TMP_Text"},
  btnAddEnergy = {sComponentName = "UIButton"},
  goCoin = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateCoinCtrl"
  },
  imgBtn1 = {},
  btnAdd1 = {sComponentName = "UIButton"},
  imgBtn2 = {},
  btnAdd2 = {sComponentName = "UIButton"},
  imgExp = {sComponentName = "Image"},
  txtRank = {sComponentName = "TMP_Text"},
  txtRankEn = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_RANK"
  },
  btnWorldClass = {sComponentName = "UIButton"},
  btnActivity = {sComponentName = "UIButton"},
  txtActivity1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Activity"
  },
  btnBattlePass = {sComponentName = "UIButton"},
  txtBattlePass = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_BattlePass"
  },
  btnMall = {sComponentName = "UIButton"},
  txtMall = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Mall"
  },
  btnNotice = {sComponentName = "UIButton"},
  btnMail = {sComponentName = "UIButton"},
  btnFriend = {sComponentName = "UIButton"},
  btnDepot = {sComponentName = "UIButton"},
  goEnergyTip = {},
  tmpEnergy = {sComponentName = "TMP_Text"},
  imgTime = {nCount = 3},
  goActivityBanner = {},
  goActBannerList = {
    sComponentName = "RectTransform"
  },
  btnActBanner = {
    sNodeName = "goActBannerList",
    sComponentName = "UIButton"
  },
  eventActBannerDrag = {
    sNodeName = "goActBannerList",
    sComponentName = "UIDrag"
  },
  activityBannerItem = {
    nCount = 3,
    sComponentName = "RectTransform"
  },
  imgActBanner = {nCount = 3, sComponentName = "Image"},
  goBannerDot = {
    sComponentName = "RectTransform"
  },
  imgPointBg = {nCount = 8},
  btnSwitchActor2D = {sComponentName = "UIButton"},
  btnHideAllUI = {sComponentName = "UIButton", nCount = 2},
  btnMenu = {sComponentName = "UIButton"},
  btnBoardChange = {sComponentName = "UIButton"},
  btnBoardNext = {sComponentName = "UIButton"},
  btnTask = {sComponentName = "UIButton"},
  txtTask1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Task"
  },
  btnPhone = {sComponentName = "UIButton"},
  txtPhone1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Phone"
  },
  btnDispatch = {sComponentName = "UIButton"},
  txtDispatch1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Dispatch"
  },
  btnRecruit = {sComponentName = "UIButton"},
  txtRecruit1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Recruit"
  },
  btnRole = {sComponentName = "UIButton"},
  txtRole1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Role"
  },
  btnDisc = {sComponentName = "UIButton"},
  txtDisc1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Disc"
  },
  btnShop = {sComponentName = "UIButton"},
  txtShop1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Shop"
  },
  btnMap = {sComponentName = "UIButton"},
  txtGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_Go"
  },
  txtMainline1 = {sComponentName = "TMP_Text", sLanguageId = "Mainline"},
  goStarTowerHint = {},
  tmpStarTowerHint = {sComponentName = "TMP_Text"},
  btnStarTowerHint = {
    sNodeName = "goStarTowerHint",
    sComponentName = "UIButton"
  },
  goStoryHint = {},
  tmpStoryHint = {sComponentName = "TMP_Text"},
  btnStoryHint = {
    sNodeName = "goStoryHint",
    sComponentName = "UIButton"
  }
}
PreviewMainViewCtrl._mapEventConfig = {}

function PreviewMainViewCtrl:Refresh()
  self:RefreshPlayerInfo()
  self:RefreshWorldClass()
  self:RefreshResources()
  self:RefreshEnergy()
  self:RefreshActor2D()
  self:RefreshComFuncState()
  self:SetBanner()
end

function PreviewMainViewCtrl:RefreshPlayerInfo()
  local sName = PlayerData.Base:GetPlayerNickName()
  NovaAPI.SetTMPText(self._mapNode.txtName, sName)
end

function PreviewMainViewCtrl:RefreshWorldClass()
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local nCurExp = PlayerData.Base:GetWorldExp()
  local mapCfg = ConfigTable.GetData("WorldClass", nWorldClass + 1, true)
  local nFullExp = 0
  if mapCfg then
    nFullExp = mapCfg.Exp
  end
  NovaAPI.SetTMPText(self._mapNode.txtRank, nWorldClass)
  NovaAPI.SetImageFillAmount(self._mapNode.imgExp, nFullExp == 0 and 1 or nCurExp / nFullExp)
  local nMaxEnergy = ConfigTable.GetConfigNumber("EnergyMaxLimit")
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  NovaAPI.SetTMPText(self._mapNode.txtEnergyCount, nCurEnergy .. "/" .. nMaxEnergy)
end

function PreviewMainViewCtrl:RefreshResources()
  for nCoinId, index in pairs(self.tbRes) do
    if nCoinId == AllEnum.CoinItemId.FREESTONE then
      self._mapNode.goCoin[index]:SetCoin(nCoinId, PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.FREESTONE) + PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.STONE), true, 999999)
    else
      self._mapNode.goCoin[index]:SetCoin(nCoinId, PlayerData.Coin:GetCoinCount(nCoinId), true, 999999)
    end
  end
end

function PreviewMainViewCtrl:RefreshEnergy()
  local nMaxEnergy = ConfigTable.GetConfigNumber("EnergyMaxLimit")
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  NovaAPI.SetTMPText(self._mapNode.txtEnergyCount, nCurEnergy .. "/" .. nMaxEnergy)
  self:SetSprite_Coin(self._mapNode.imgEnergyIcon, AllEnum.CoinItemId.Energy)
end

function PreviewMainViewCtrl:RefreshActor2D()
  self._mapNode.imgOutfit.gameObject:SetActive(false)
  self._mapNode.rawImgActor2D.gameObject:SetActive(false)
  local curBoardData = PlayerBoardData:GetCurBoardData()
  if nil == curBoardData then
    curBoardData = PlayerBoardData:GetTempBoardData()
  end
  local nCGAnimTime = 0
  if nil ~= curBoardData then
    if curBoardData:GetType() == GameEnum.handbookType.SKIN then
      self._mapNode.rawImgActor2D.gameObject:SetActive(true)
      local charId = curBoardData:GetCharId()
      local skinId = curBoardData:GetSkinId()
      local bSuc, nType, nAnimLen = Actor2DManager.SetActor2D(PanelId.MainView, self._mapNode.rawImgActor2D, charId, skinId)
      local nTargetType = PlayerData.Board:GetBoardPanelL2DType()
      local bChange = false
      if nTargetType ~= 0 and nTargetType ~= nType and (nTargetType == AllEnum.Actor2DType.FullScreen and curBoardData:CheckFavorCG() or nTargetType == AllEnum.Actor2DType.Normal) then
        bChange = true
      end
      if bChange then
        bSuc, nType, nAnimLen = Actor2DManager.SwitchActor2DType()
      end
      local nBoardPanelId = PlayerBoardData:GetBoardPanelSelectId()
      if nil ~= nBoardPanelId and 0 ~= nBoardPanelId and nType == AllEnum.Actor2DType.Normal and nBoardPanelId == curBoardData:GetId() then
        Actor2DManager.PlayActor2DAnim("Actor2D_left_middle")
      end
      self.nActorShowType = nType
      nCGAnimTime = nAnimLen or 0
    elseif curBoardData:GetType() == GameEnum.handbookType.OUTFIT then
      self.nActorShowType = 0
      self._mapNode.imgOutfit.gameObject:SetActive(true)
      self:SetPngSprite(self._mapNode.imgOutfit, curBoardData:GetDiscBg())
      NovaAPI.SetImageNativeSize(self._mapNode.imgOutfit)
    end
  end
  Actor2DManager.SkipCGAnim()
  PlayerBoardData:SetBoardPanelSelectId(0)
end

function PreviewMainViewCtrl:SetBanner()
  self.tbBannerList = {}
  self:AddActivityBanner()
  self:AddOtherBanner()
  self:AddGachaBanner()
  if nil == self.tbBannerList or nil == next(self.tbBannerList) then
    self._mapNode.goActivityBanner.gameObject:SetActive(false)
  else
    self._mapNode.goActivityBanner:SetActive(true)
    for _, v in ipairs(self._mapNode.imgPointBg) do
      v.gameObject:SetActive(false)
    end
    for k, v in ipairs(self.tbBannerList) do
      if nil ~= self._mapNode.imgPointBg[k] then
        self._mapNode.imgPointBg[k]:SetActive(true)
        self._mapNode.imgPointBg[k].transform:Find("imgPoint").gameObject:SetActive(false)
      end
    end
    self.nActBannerIdx = 1
    self.nLastActBannerIdx = 1
    self:RefreshActivityBanner()
  end
  self:StartActBannerTimer()
  self._mapNode.eventActBannerDrag.enabled = #self.tbBannerList > 1
end

function PreviewMainViewCtrl:AddActivityBanner()
  local tb_activityBanner = PlayerData.Activity:GetActivityBannerList()
  for _, value in pairs(tb_activityBanner) do
    table.insert(self.tbBannerList, {
      nType = GameEnum.bannerType.Activity,
      actData = value,
      nFuncType = GameEnum.OpenFuncType.Activity
    })
  end
end

function PreviewMainViewCtrl:AddOtherBanner()
  local function forEachMap(mapLineData)
    if mapLineData.BannerType == GameEnum.bannerType.OpenFunc then
      local funcNum = tonumber(mapLineData.Param1)
      
      if funcNum == nil then
        return
      end
      local bUnlock = PlayerData.Base:CheckFunctionUnlock(funcNum, false)
      if bUnlock then
        local jumpToNum = tonumber(mapLineData.Param2)
        if jumpToNum == nil then
          return
        end
        table.insert(self.tbBannerList, {
          nType = GameEnum.bannerType.OpenFunc,
          sBanner = mapLineData.bannerName,
          nJumpTo = jumpToNum,
          nFuncType = funcNum
        })
      end
    end
  end
  
  ForEachTableLine(DataTable.Banner, forEachMap)
end

function PreviewMainViewCtrl:AddGachaBanner()
  local tbOpenedPool = PlayerData.Gacha:GetOpenedPool()
  for _, nPoolId in ipairs(tbOpenedPool) do
    local mapPoolCfgData = ConfigTable.GetData("Gacha", nPoolId)
    if mapPoolCfgData ~= nil and mapPoolCfgData.BannerRes ~= nil and mapPoolCfgData.BannerRes ~= "" then
      table.insert(self.tbBannerList, {
        nType = GameEnum.bannerType.Gacha,
        sBanner = mapPoolCfgData.BannerRes,
        nJumpTo = nPoolId,
        nFuncType = GameEnum.OpenFuncType.Gacha
      })
    end
  end
end

function PreviewMainViewCtrl:RefreshActivityBanner()
  local lastIndex = self.nActBannerIdx - 1 <= 0 and #self.tbBannerList or self.nActBannerIdx - 1
  local nextIndex = self.nActBannerIdx + 1 > #self.tbBannerList and 1 or self.nActBannerIdx + 1
  local tbCurBannerList = {}
  table.insert(tbCurBannerList, self.tbBannerList[lastIndex])
  table.insert(tbCurBannerList, self.tbBannerList[self.nActBannerIdx])
  table.insert(tbCurBannerList, self.tbBannerList[nextIndex])
  for k, v in ipairs(self._mapNode.imgActBanner) do
    local bannerData = tbCurBannerList[k]
    if bannerData.nType == GameEnum.bannerType.Activity then
      if nil ~= bannerData.actData then
        self:SetPngSprite(v, "Icon/Banner/" .. bannerData.actData:GetBannerPng())
      end
    elseif bannerData.nType == GameEnum.bannerType.OpenFunc then
      self:SetPngSprite(v, "Icon/Banner/" .. bannerData.sBanner)
    elseif bannerData.nType == GameEnum.bannerType.Gacha then
      self:SetPngSprite(v, "Icon/Banner/" .. bannerData.sBanner)
    end
  end
  self._mapNode.imgPointBg[self.nLastActBannerIdx].transform:Find("imgPoint").gameObject:SetActive(false)
  self.nLastActBannerIdx = self.nActBannerIdx
  self._mapNode.imgPointBg[self.nActBannerIdx].transform:Find("imgPoint").gameObject:SetActive(true)
end

function PreviewMainViewCtrl:StartActBannerTimer()
  if nil == self.actBannerTimer and #self.tbBannerList > 1 then
    self.actBannerTimer = self:AddTimer(0, self.nBannerInterval, "PlayActBannerAnim", true, true, false)
  end
end

function PreviewMainViewCtrl:ResetActBannerTimer()
  if nil ~= self.actBannerTimer then
    TimerManager.Remove(self.actBannerTimer, false)
  end
  self.actBannerTimer = nil
end

function PreviewMainViewCtrl:PlayActBannerAnim()
  for k, v in ipairs(self._mapNode.activityBannerItem) do
    v:DOAnchorPosX(self.tbBannerInitPos[k].x - self.nBannerWidth, 0.5):SetUpdate(true)
  end
  self.actBannerRefreshTimer = self:AddTimer(1, 0.5, "BannerTweenerEnd", true, true, true)
end

function PreviewMainViewCtrl:BannerTweenerEnd()
  for k, v in ipairs(self._mapNode.activityBannerItem) do
    v.anchoredPosition = self.tbBannerInitPos[k]
  end
  self.nActBannerIdx = self.nActBannerIdx + 1
  if self.nActBannerIdx > #self.tbBannerList then
    self.nActBannerIdx = 1
  end
  self:RefreshActivityBanner()
end

function PreviewMainViewCtrl:InitData()
  self.tbRes = {
    [AllEnum.CoinItemId.Jade] = 1,
    [AllEnum.CoinItemId.FREESTONE] = 2
  }
  self.bannerList = {}
end

function PreviewMainViewCtrl:LoadCharacterIndex()
  local localData = LocalData.GetPlayerLocalData("MainMenuUICharIndex")
  self.nCurCharIdx = tonumber(localData) or 1
end

function PreviewMainViewCtrl:ResetTimer()
  if nil ~= self.actBannerTimer then
    self.actBannerTimer:Cancel(false)
    self.actBannerTimer = nil
  end
  if nil ~= self.actBannerRefreshTimer then
    self.actBannerRefreshTimer:Cancel(false)
    self.actBannerRefreshTimer = nil
  end
end

function PreviewMainViewCtrl:RefreshComFuncState()
  local nState = ConfigTable.GetConfigNumber("IsShowComBtn")
  local bActive = nState == 1
  self._mapNode.btnBattlePass.gameObject:SetActive(bActive)
  self._mapNode.btnMall.gameObject:SetActive(bActive)
  self._mapNode.imgBtn2.gameObject:SetActive(bActive)
  self._mapNode.btnAdd2.gameObject:SetActive(bActive)
end

function PreviewMainViewCtrl:Awake()
  self.bNewDay = false
  self.resourcesList = nil
  self.bannerList = nil
  self.tbCharId = nil
  self.nCurCharIdx = nil
  self.nActorShowType = nil
  self.bNeedCheckState = true
  self.nDragStartPosX = nil
  self.nDragThreshold = PlayerBoardData:GetBoardDragThreshold()
  self.nCurBubbleIndex = 0
  self.tbBubbleList = {}
  self.tbBannerInitPos = {}
  for _, v in ipairs(self._mapNode.activityBannerItem) do
    self.nBannerWidth = v.sizeDelta.x
    table.insert(self.tbBannerInitPos, v.anchoredPosition)
  end
  self:GetAtlasSprite("06_btn", "btn_agent_tab_1")
  self:InitData()
end

function PreviewMainViewCtrl:OnEnable()
  self.tbCharId = PlayerData.Char:GetCharIdList()
  self:LoadCharacterIndex()
  self._mapNode.eventActBannerDrag:SetStrictDrag(true)
  self.nBannerInterval = ConfigTable.GetConfigNumber("Activity_Banner_Interval_Time")
  for k, v in ipairs(self._mapNode.activityBannerItem) do
    v.anchoredPosition = self.tbBannerInitPos[k]
  end
end

function PreviewMainViewCtrl:OnDisable()
  self.tbCharId = nil
  self.nCurCharIdx = nil
  self:ResetTimer()
  Actor2DManager.UnsetActor2D()
end

function PreviewMainViewCtrl:OnDestroy()
end

return PreviewMainViewCtrl

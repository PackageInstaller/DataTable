local GameCameraStackManager = CS.GameCameraStackManager.Instance
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local TimerManager = require("GameCore.Timer.TimerManager")
local StarTowerShopCtrl = class("StarTowerShopCtrl", BaseCtrl)
local _, GrayColor = ColorUtility.TryParseHtmlString("#94aac0")
StarTowerShopCtrl._mapNodeConfig = {
  t_fullscreen_blur_blue = {},
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  rawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  btnActor = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Actor"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  srGoodsList = {
    sComponentName = "LoopScrollView"
  },
  srBgList = {
    sComponentName = "LoopScrollView"
  },
  trGoodsList = {
    sNodeName = "srGoodsList",
    sComponentName = "Transform"
  },
  ButtonBack = {
    sComponentName = "NaviButton",
    callback = "OnBtn_CloseShop"
  },
  btnBag = {
    sComponentName = "NaviButton",
    callback = "OnBtn_Depot"
  },
  goBuyPanel = {},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_TitleBuy"
  },
  txtPriceCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_UnitPrice"
  },
  aniBuyPanel = {
    sNodeName = "goBuyPanelAnimRoot",
    sComponentName = "Animator"
  },
  txtGoodsName = {sComponentName = "TMP_Text"},
  imgGoodsTalentBg = {sComponentName = "Image"},
  txtDesc = {sComponentName = "TMP_Text"},
  imgBuyDiscount = {},
  txtBuyDiscount = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_Discount"
  },
  imgGoodsIcon = {sComponentName = "Image"},
  imgGoodsCharIcon = {sComponentName = "Image"},
  imgCharEdgeGoods = {},
  imgTickets = {sComponentName = "Image"},
  goBubble = {},
  txtBuy = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "FixedRoguelike_ShopBuy"
  },
  txtCurResume = {sComponentName = "TMP_Text"},
  goOrigin = {},
  txtOrigin = {sComponentName = "TMP_Text"},
  ButtonClose = {
    sComponentName = "UIButton",
    callback = "OnBtn_CloseBuy"
  },
  ButtonConfirm = {
    sComponentName = "NaviButton",
    callback = "OnBtn_Confirm",
    sAction = "Confirm"
  },
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtn_CloseBuy"
  },
  sv = {
    sComponentName = "GamepadScroll"
  },
  TMPLink = {
    sNodeName = "txtDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  },
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtn_CloseBuy"
  },
  imgCoin = {sComponentName = "Image"},
  txtCoinCount = {sComponentName = "TMP_Text"},
  RollButton = {},
  goRollCoin = {},
  btnRoll = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Roll"
  },
  imgRollBtn = {sComponentName = "Image"},
  imgRollCostIcon = {sComponentName = "Image"},
  txtRollCostCount = {sComponentName = "TMP_Text"},
  txtRemainRoll = {sComponentName = "TMP_Text"},
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  goNoteHint = {},
  TMPNoteHintTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "STShop_OutfitNoteHintTitle"
  },
  TMPOutfitSkillInfoTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "STShop_OutfitSkillInfoTitle"
  },
  TMPNoteHintCount = {sComponentName = "TMP_Text"},
  animOutfitSkillBg = {
    sComponentName = "Animator",
    sNodeName = "imgOutfitSkillBg"
  },
  imgIconNoteHint = {sComponentName = "Image"},
  imgOutfitSkillBg = {},
  lstOutfitSkillInfo = {
    sComponentName = "LoopScrollView"
  }
}
StarTowerShopCtrl._mapEventConfig = {
  OpenFixedRoguelikeShopBuyPanel = "OnEvent_OpenBuy",
  GamepadUIChange = "OnEvent_GamepadUIChange",
  StarTowerShoopSelectGoods = "OnEvent_SelectGoods",
  GamepadUIReopen = "OnEvent_Reopen",
  RefreshStarTowerCoin = "OnEvent_RefreshCoin",
  StarTowerAutoShopExecute = "OnEvent_AutoShopExecute",
  StarTowerAutoShopComplete = "OnEvent_AutoShopComplete",
  StarTowerAutoDecisionStateChanged = "OnEvent_AutoDecisionStateChanged",
  [EventId.ShowBubbleVoiceText] = "OnEvent_ShowBubbleVoiceText"
}

function StarTowerShopCtrl:Refresh()
  self._mapNode.RollButton:SetActive(self.mapRoll and self.mapRoll.CanReRoll)
  local nCount = #self.tbGoods
  if nCount < 5 then
    nCount = 5
  end
  self._mapNode.srGoodsList:Init(nCount, self, self.OnGridRefresh)
  local nBgCount = math.ceil(nCount / 4)
  self._mapNode.srBgList:Init(nBgCount, self, self.OnGridRefresh_Bg)
  NovaAPI.SetScrollRectVertical(self._mapNode.srBgList, false)
  self:SelectGoods()
  self:RefreshCoin()
  self:RefreshActionBar()
end

function StarTowerShopCtrl:RefreshActionBar()
  local tbConfig = {}
  if self.mapRoll and self.mapRoll.CanReRoll then
    tbConfig = {
      {
        sAction = "Roll",
        sLang = "ActionBar_Reroll"
      },
      {
        sAction = "Depot",
        sLang = "ActionBar_Depot"
      },
      {
        sAction = "Back",
        sLang = "ActionBar_Back"
      },
      {
        sAction = "Confirm",
        sLang = "ActionBar_Check"
      }
    }
  else
    tbConfig = {
      {
        sAction = "Depot",
        sLang = "ActionBar_Depot"
      },
      {
        sAction = "Back",
        sLang = "ActionBar_Back"
      },
      {
        sAction = "Confirm",
        sLang = "ActionBar_Check"
      }
    }
  end
  self._mapNode.ActionBar:InitActionBar(tbConfig)
end

function StarTowerShopCtrl:RefreshCoin()
  NovaAPI.SetTMPText(self._mapNode.txtCoinCount, self:ThousandsNumber(self.nCoin))
  if not self.mapRoll or not self.mapRoll.CanReRoll then
    return
  end
  local bAble = self.mapRoll.ReRollTimes > 0
  NovaAPI.SetImageColor(self._mapNode.imgRollBtn, bAble and Blue_Normal or GrayColor)
  NovaAPI.SetTMPText(self._mapNode.txtRemainRoll, orderedFormat(ConfigTable.GetUIText("StarTower_Select_RemainRoll"), self.mapRoll.ReRollTimes))
  self:SetSprite_Coin(self._mapNode.imgRollCostIcon, AllEnum.CoinItemId.FixedRogCurrency)
  NovaAPI.SetTMPText(self._mapNode.txtRollCostCount, self.mapRoll.ReRollPrice)
  NovaAPI.SetTMPColor(self._mapNode.txtRollCostCount, self.nCoin < self.mapRoll.ReRollPrice and Red_Unable or Blue_Normal)
  self._mapNode.goRollCoin:SetActive(bAble)
  local white = Color(1, 1, 1)
  local gray = Color(1, 1, 1, 0.6)
  local trRoot = self._mapNode.btnRoll.gameObject:GetComponent("Transform"):Find("AnimRoot")
  if trRoot then
    local Xbox = trRoot:Find("Xbox")
    if Xbox then
      local icon = Xbox:Find("imgAction")
      if icon then
        NovaAPI.SetImageColor(icon:GetComponent("Image"), bAble and white or gray)
      end
    end
    local PS = trRoot:Find("PS")
    if PS then
      local icon = PS:Find("imgAction")
      if icon then
        NovaAPI.SetImageColor(icon:GetComponent("Image"), bAble and white or gray)
      end
    end
  end
end

function StarTowerShopCtrl:PlayEnterShopNPCVoice()
  PlayerData.Voice:StopCharVoice()
  local mapCurCfg = ConfigTable.GetData("StarTower", self.nStarTowerId)
  if nil == mapCurCfg then
    return
  end
  local nFloorNum = 0
  for i = 1, #mapCurCfg.FloorNum do
    nFloorNum = nFloorNum + mapCurCfg.FloorNum[i]
  end
  if self.nCurLevel == nFloorNum then
    self.nCurVoiceId = PlayerData.Voice:PlayCharVoice("final", self.nNPCId, nil, true)
    return
  end
  local sVoiceKey = ""
  local tbPool = {"greet_npc"}
  if mapCurCfg.GroupId == 1 then
    table.insert(tbPool, "Tower_typeA")
  elseif mapCurCfg.GroupId == 2 then
    table.insert(tbPool, "Tower_typeB")
  elseif mapCurCfg.GroupId == 3 then
    table.insert(tbPool, "Tower_typeC")
  end
  if nil ~= self.tbGoods then
    for p, v in pairs(self.tbGoods) do
      if 0 < v.nDiscount then
        table.insert(tbPool, "onsale")
        break
      end
    end
  end
  sVoiceKey = tbPool[math.random(1, #tbPool)]
  if sVoiceKey ~= "" then
    self.nCurVoiceId = PlayerData.Voice:PlayCharVoice(sVoiceKey, self.nNPCId, nil, true)
  end
end

function StarTowerShopCtrl:OnGridRefresh_Bg(goGrid, gridIndex)
end

function StarTowerShopCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapGoods = self.tbGoods[nIndex]
  if not self.mapGoodCtrl then
    self.mapGoodCtrl = {}
  end
  if self.mapGoodCtrl[goGrid] == nil then
    self.mapGoodCtrl[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.StarTower.StarTowerShop.StarTowerShopGridCtrl")
  end
  self.mapGoodCtrl[goGrid]:RefreshGrid(mapGoods, self.nCoin)
end

function StarTowerShopCtrl:Clear()
  self.tbGoods = nil
  self.tbGoodsList = nil
  self.tbBuyGridList = nil
  self.mapSelectGoods = nil
end

function StarTowerShopCtrl:OpenBuyPanel(bOpen, mapGoods, bUnable, bQuit)
  self.mapSelectGoods = mapGoods
  if not bOpen then
    if bQuit then
      self._mapNode.t_fullscreen_blur_blue:SetActive(false)
      self._mapNode.goBuyPanel:SetActive(false)
      GamepadUIManager.DisableGamepadUI("BuyPanel")
    else
      self._mapNode.aniBuyPanel:Play("t_window_04_t_out")
      self._mapNode.aniBlur:SetTrigger("tOut")
      self._mapNode.animOutfitSkillBg:Play("imgOutfitSkillBg_out")
      self:AddTimer(1, 0.2, function()
        self._mapNode.t_fullscreen_blur_blue:SetActive(false)
        self._mapNode.goBuyPanel:SetActive(false)
        GamepadUIManager.DisableGamepadUI("BuyPanel")
        self:SelectGoods()
      end, true, true, true)
      EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
    end
    return
  end
  GamepadUIManager.EnableGamepadUI("BuyPanel", self.tbGoodsGamepadUINode)
  WwiseAudioMgr:PlaySound("ui_roguelike_shop_scan")
  self._mapNode.t_fullscreen_blur_blue:SetActive(true)
  self._mapNode.goBuyPanel:SetActive(true)
  self._mapNode.aniBuyPanel:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  local mapGoodCfgData = ConfigTable.GetData("StarTowerShopGoods", mapGoods.Idx)
  if mapGoodCfgData == nil then
    printError("StarTowerShopGoods Missing" .. mapGoods.Idx)
    return
  end
  local nItemTid
  if mapGoods.nType == 2 then
    nItemTid = mapGoods.nGoodsId
  else
    nItemTid = mapGoodCfgData.ShowItem
  end
  local mapItem = ConfigTable.GetData_Item(nItemTid)
  if mapItem == nil then
    return
  end
  self:SetPngSprite(self._mapNode.imgTickets, ConfigTable.GetData_Item(AllEnum.CoinItemId.FixedRogCurrency).Icon)
  self:SetPngSprite(self._mapNode.imgGoodsIcon, mapItem.Icon)
  local sPath = AllEnum.FrameType_New.Item .. AllEnum.FrameColor_New[mapItem.Rarity]
  self._mapNode.imgGoodsTalentBg.gameObject:SetActive(false)
  if mapGoods.nCharId ~= nil and mapGoods.nCharId > 0 then
    local nCharSkinId = PlayerData.Char:GetCharSkinId(mapGoods.nCharId)
    self:SetPngSprite(self._mapNode.imgGoodsCharIcon, ConfigTable.GetData_CharacterSkin(nCharSkinId).Icon, AllEnum.CharHeadIconSurfix.S)
    self._mapNode.imgGoodsCharIcon.gameObject:SetActive(true)
    self._mapNode.imgCharEdgeGoods.gameObject:SetActive(true)
  else
    self._mapNode.imgGoodsCharIcon.gameObject:SetActive(false)
    self._mapNode.imgCharEdgeGoods.gameObject:SetActive(false)
  end
  NovaAPI.SetTMPText(self._mapNode.txtDesc, mapItem.Desc)
  NovaAPI.SetTMPText(self._mapNode.txtGoodsName, mapItem.Title)
  NovaAPI.SetTMPText(self._mapNode.txtCurResume, 0 < mapGoods.nDiscount and mapGoods.nDiscount or mapGoods.Price)
  self.mapBuy = {
    nSid = mapGoods.nSid,
    sName = mapItem.Title,
    sValue = "",
    sDesc = mapItem.Desc
  }
  self._mapNode.imgBuyDiscount:SetActive(0 < mapGoods.nDiscount)
  self._mapNode.goOrigin:SetActive(0 < mapGoods.nDiscount)
  if 0 < mapGoods.nDiscount then
    NovaAPI.SetTMPText(self._mapNode.txtOrigin, mapGoods.Price)
  end
  if mapGoods.nType == 2 then
    self:SetNoteInfo(mapGoods.nGoodsId)
  else
    self._mapNode.imgOutfitSkillBg:SetActive(false)
    self._mapNode.goNoteHint:SetActive(false)
  end
end

function StarTowerShopCtrl:OpenShop(tbGoodsList, nCoin)
  if tbGoodsList == nil then
    printError("商品数据为空")
    return
  end
  self._mapNode.safeAreaRoot:SetActive(true)
  self._mapNode.RollButton:SetActive(false)
  WwiseAudioMgr:PlaySound("ui_roguelike_shopPanel_enter")
  WwiseAudioMgr:PlaySound("ui_roguelike_shop_window")
  self.tbGoods = self:SortGoods(tbGoodsList)
  self.nCoin = nCoin
  self:Refresh()
end

function StarTowerShopCtrl:SortGoods(tbGoodsList)
  local tbTypeSort = {
    [1] = 1,
    [2] = 2,
    [3] = 4,
    [4] = 3
  }
  
  local function func_sort(a, b)
    if tbTypeSort[a.nType] ~= tbTypeSort[b.nType] then
      return tbTypeSort[a.nType] < tbTypeSort[b.nType]
    elseif a.nDiscount ~= b.nDiscount then
      return a.nDiscount > b.nDiscount
    else
      return a.nSid < b.nSid
    end
  end
  
  table.sort(tbGoodsList, func_sort)
  return tbGoodsList
end

function StarTowerShopCtrl:OpenPanel()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    local tbGoodsList = tbParam[1]
    self.nCoin = tbParam[2]
    self.BuyCallback = tbParam[3]
    self.nCaseId = tbParam[4]
    self.mapRoll = tbParam[5]
    self.tbOutfitId = tbParam[6]
    self.mapNoteCount = tbParam[7]
    self.nStarTowerId = tbParam[8]
    self.nCurLevel = tbParam[9]
    self.autoStartCallback = tbParam[10]
    self.bAutoShop = type(self.autoStartCallback) == "function"
    self:OpenShop(tbGoodsList, self.nCoin)
  end
  CS.GameCameraStackManager.Instance:CloseMainCamera(0.1)
  local bUseL2D = LocalSettingData.mapData.UseLive2D
  self._mapNode.rawImgActor2D.transform.localScale = bUseL2D == true and Vector3.one or Vector3.zero
  self._mapNode.trActor2D_PNG.localScale = bUseL2D == true and Vector3.zero or Vector3.one
  if bUseL2D == true then
    Actor2DManager.SetBoardNPC2D(self:GetPanelId(), self._mapNode.rawImgActor2D, self.nNPCId)
  else
    Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.trActor2D_PNG, self:GetPanelId(), self.nNPCId)
  end
  self:PlayEnterShopNPCVoice()
  if self.bAutoShop then
    local callback = self.autoStartCallback
    self.autoStartCallback = nil
    callback()
  end
end

function StarTowerShopCtrl:OnEvent_AvgVoiceEnd(nDuration)
end

function StarTowerShopCtrl:OnEvent_ShowBubbleVoiceText(nCharId, nId)
  local mapVoDirectoryData = ConfigTable.GetData("VoDirectory", nId)
  if mapVoDirectoryData == nil then
    printError("VoDirectory未找到数据id:" .. nId)
    return
  end
  BubbleVoiceManager.PlayFixedBubbleAnim(self._mapNode.goBubble, mapVoDirectoryData.voResource)
end

function StarTowerShopCtrl:Awake()
  self.mapGoodCtrl = nil
  self:Clear()
  self._mapNode.safeAreaRoot:SetActive(false)
  self:SetSprite_Coin(self._mapNode.imgCoin, AllEnum.CoinItemId.FixedRogCurrency)
  self.nNPCId = 9133
  self.nCurVoiceId = 0
  self.tbShopGamepadUINode = {
    [1] = {
      mapNode = self._mapNode.btnBag,
      sComponentName = "NaviButton"
    },
    [2] = {
      mapNode = self._mapNode.ButtonBack,
      sComponentName = "NaviButton"
    },
    [3] = {
      mapNode = self._mapNode.btnRoll,
      sComponentName = "NaviButton"
    }
  }
  self.tbGoodsGamepadUINode = {
    [1] = {
      mapNode = self._mapNode.btnShortcutClose,
      sComponentName = "NaviButton"
    },
    [2] = {
      mapNode = self._mapNode.ButtonConfirm,
      sComponentName = "NaviButton",
      sAction = "Confirm",
      sActionIconType = "Dark"
    },
    [3] = {
      mapNode = self._mapNode.sv,
      sComponentName = "GamepadScroll",
      sAction = "Scroll"
    }
  }
end

function StarTowerShopCtrl:OnEnable()
  NovaAPI.SetL2DTimeState(true)
  PanelManager.InputDisable()
  EventManager.Hit("StarTowerSetButtonEnable", false, false)
  self:AddTimer(1, 0.1, "OpenPanel", true, true, true)
  GamepadUIManager.EnableGamepadUI("StarTowerShopCtrl", self.tbShopGamepadUINode)
  PlayerData.Voice:StartBoardFreeTimer(self.nNPCId)
  EventManager.Add(EventId.AvgVoiceEnd, self, self.OnEvent_AvgVoiceEnd)
end

function StarTowerShopCtrl:OnDisable()
  self._timerAutoShopClose = nil
  self._autoShopCloseCallback = nil
  if self.mapGoodCtrl then
    for nInstanceId, objCtrl in pairs(self.mapGoodCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.mapGoodCtrl[nInstanceId] = nil
    end
    self.mapGoodCtrl = {}
  end
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  Actor2DManager.UnsetBoardNPC2D()
  BubbleVoiceManager.StopBubbleAnim()
  PlayerData.Voice:ClearTimer()
  EventManager.Remove(EventId.AvgVoiceEnd, self, self.OnEvent_AvgVoiceEnd)
end

function StarTowerShopCtrl:OnDestroy()
  self.mapGoodCtrl = nil
  self:Clear()
end

function StarTowerShopCtrl:OnBtn_CloseShop()
  PanelManager.InputEnable()
  NovaAPI.SetL2DTimeState(false)
  EventManager.Hit("StarTowerSetButtonEnable", true, true)
  GamepadUIManager.DisableGamepadUI("StarTowerShopCtrl")
  self:Clear()
  EventManager.Hit("CloseFRShopPanel")
  EventManager.Hit("ReplayShopRoomBGM")
  EventManager.Hit(EventId.ClosePanel, PanelId.StarTowerShop)
  PlayerData.Voice:StopCharVoice()
  local tbPool = {
    "leave",
    "posterchat_npc"
  }
  if 0 < #tbPool then
    PlayerData.Voice:PlayCharVoice(tbPool[math.random(1, #tbPool)], self.nNPCId, nil, true)
  end
end

function StarTowerShopCtrl:OnEvent_OpenBuy(mapGoods, bUnable)
  self:OpenBuyPanel(true, mapGoods, bUnable)
end

function StarTowerShopCtrl:OnEvent_CloseStarTowerDepot()
  if self.bOpenDepot then
    self.bOpenDepot = false
    CS.GameCameraStackManager.Instance:CloseMainCamera(0.1)
    self.gameObject:SetActive(true)
    self:SelectGoods()
  end
end

function StarTowerShopCtrl:OnBtn_CloseBuy()
  self:OpenBuyPanel(false)
end

function StarTowerShopCtrl:OnBtn_Confirm()
  if self.mapSelectGoods ~= nil and self.mapSelectGoods.nType == 2 then
    local nNoteId = self.mapSelectGoods.nGoodsId
    local nCurCount = self.mapNoteCount[nNoteId] == nil and 0 or self.mapNoteCount[nNoteId]
    local nMaxCount = ConfigTable.GetConfigNumber("DiscSubNoteSkillMaxLevel")
    if nCurCount >= nMaxCount then
      local sNoteName = ""
      local mapNoteCfg = ConfigTable.GetData("SubNoteSkill", nNoteId)
      if mapNoteCfg ~= nil then
        sNoteName = mapNoteCfg.Name
      end
      EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("StarTower_Shop_Note_Max"), sNoteName))
      return
    end
  end
  
  local function callback(nCoin)
    self:OpenBuyPanel(false, nil, nil, true)
    for _, mapGoods in pairs(self.tbGoods) do
      if mapGoods.nSid == self.mapBuy.nSid then
        mapGoods.bSoldOut = true
      end
    end
    self.nCoin = nCoin
    self:Refresh()
    self.nCurVoiceId = PlayerData.Voice:PlayCharVoice("thank_npc", self.nNPCId, nil, true)
  end
  
  if self.BuyCallback ~= nil and type(self.BuyCallback) == "function" then
    if type(self.nCaseId) == "table" then
      printError("星塔商店购买时，caseId 变成table了，他的内容是：")
      
      local function printTableHelper(t, indent)
        indent = indent or 0
        for k, v in pairs(t) do
          local formatting = string.rep(" ", indent) .. tostring(k) .. ": "
          if type(v) == "table" then
            printError(formatting)
            printTableHelper(v, indent + 4)
          else
            printError(formatting .. tostring(v))
          end
        end
      end
      
      printTableHelper(self.nCaseId, 0)
    end
    self.BuyCallback(self.nCaseId, self.mapBuy.nSid, callback)
  end
end

function StarTowerShopCtrl:OnBtn_UnableConfirm()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("FIXEDROGUE_00"))
end

function StarTowerShopCtrl:OnBtn_Depot()
  self.bOpenDepot = true
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  self.gameObject:SetActive(false)
  EventManager.Hit(EventId.StarTowerDepot, AllEnum.StarTowerDepotTog.Potential)
end

function StarTowerShopCtrl:OnBtnClick_Roll()
  if self.mapRoll.ReRollTimes <= 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_ReRoll_NotEnoughCount"))
    return
  end
  if self.nCoin < self.mapRoll.ReRollPrice then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_ReRoll_NotEnoughCoin"))
    return
  end
  
  local function callback(nCoin, tbGoodsList, mapRoll)
    self.nCoin = nCoin
    self.tbGoods = self:SortGoods(tbGoodsList)
    self.mapRoll = mapRoll
    self:Refresh()
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      bPositive = true,
      sContent = ConfigTable.GetUIText("StarTower_Shop_ReRollSuccess")
    })
  end
  
  if self.BuyCallback ~= nil and type(self.BuyCallback) == "function" then
    self.BuyCallback(self.nCaseId, nil, callback, true)
  end
end

function StarTowerShopCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

function StarTowerShopCtrl:OnBtnClick_Actor(btn)
  self.nCurVoiceId = PlayerData.Voice:PlayBoardNPCClickVoice(self.nNPCId)
end

function StarTowerShopCtrl:OnEvent_SelectGoods(nIndex)
  self.nSelectIdx = nIndex
end

function StarTowerShopCtrl:OnEvent_AutoShopExecute(nSid, bReRoll)
  if not self.bAutoShop or self.BuyCallback == nil then
    return
  end
  if bReRoll then
    local function rerollCallback(nCoin, tbGoodsList, mapRoll)
      self.nCoin = nCoin
      
      self.tbGoods = self:SortGoods(tbGoodsList)
      self.mapRoll = mapRoll
      self:Refresh()
    end
    
    self.BuyCallback(self.nCaseId, nil, rerollCallback, true, true)
    return
  end
  
  local function buyCallback(nCoin)
    for _, mapGoods in ipairs(self.tbGoods) do
      if mapGoods.nSid == nSid then
        mapGoods.bSoldOut = true
        break
      end
    end
    self.nCoin = nCoin
    self:Refresh()
  end
  
  self.BuyCallback(self.nCaseId, nSid, buyCallback, false, true)
end

function StarTowerShopCtrl:OnEvent_AutoShopComplete(completeCallback)
  if self.bAutoShop then
    self._autoShopCloseCallback = completeCallback
    if self._timerAutoShopClose ~= nil then
      return
    end
    self._timerAutoShopClose = self:AddTimer(1, 1, function()
      self._timerAutoShopClose = nil
      local callback = self._autoShopCloseCallback
      self._autoShopCloseCallback = nil
      if not self.bAutoShop then
        return
      end
      self.bAutoShop = false
      self:OnBtn_CloseShop()
      if type(callback) == "function" then
        callback()
      end
    end, true, true, true)
  end
end

function StarTowerShopCtrl:OnEvent_AutoDecisionStateChanged(mapState)
  if type(mapState) ~= "table" then
    return
  end
  self.bAutoShop = mapState.bEnabled == true and mapState.bPaused ~= true
  if not self.bAutoShop then
    TimerManager.Remove(self._timerAutoShopClose, false)
    self._timerAutoShopClose = nil
    self._autoShopCloseCallback = nil
  end
end

function StarTowerShopCtrl:OnEvent_RefreshCoin(nCoin)
  self.nCoin = nCoin
  self:Refresh()
end

function StarTowerShopCtrl:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  if sName ~= "StarTowerShopCtrl" then
    return
  end
  local bNeedSelect = nBeforeType == AllEnum.GamepadUIType.Other and nAfterType ~= AllEnum.GamepadUIType.Mouse or nBeforeType == AllEnum.GamepadUIType.Mouse and nAfterType ~= AllEnum.GamepadUIType.Other
  if bNeedSelect then
    self:SelectGoods()
  else
    GamepadUIManager.ClearSelectedUI()
  end
end

function StarTowerShopCtrl:OnEvent_Reopen(sName)
  if sName == "StarTowerShopCtrl" then
    if self.bOpenDepot then
      self:OnEvent_CloseStarTowerDepot()
    else
      self:SelectGoods()
    end
  end
end

function StarTowerShopCtrl:SelectGoods()
  local nShowIndex = self._mapNode.srGoodsList:GetFirsetGridIndex()
  if not self.nSelectIdx then
    self.nSelectIdx = nShowIndex
  end
  local goSelect = self._mapNode.trGoodsList:Find("ViewPort/Content/" .. self.nSelectIdx)
  if goSelect then
    GamepadUIManager.SetSelectedUI(goSelect:Find("ButtonBuy").gameObject)
    self.mapGoodCtrl[goSelect.gameObject]:SetSelect(true)
  else
    goSelect = self._mapNode.trGoodsList:Find("ViewPort/Content/" .. nShowIndex)
    if goSelect then
      GamepadUIManager.SetSelectedUI(goSelect:Find("ButtonBuy").gameObject)
      self.mapGoodCtrl[goSelect.gameObject]:SetSelect(true)
    end
  end
end

function StarTowerShopCtrl:SetNoteInfo(nNoteId)
  local nCurCount = self.mapNoteCount[nNoteId] == nil and 0 or self.mapNoteCount[nNoteId]
  local tbOutfitId = {}
  for i = 1, 3 do
    if self.tbOutfitId[i] ~= 0 then
      table.insert(tbOutfitId, self.tbOutfitId[i])
    end
  end
  local tbSkill = PlayerData.Disc:GetDiscSkillByNote(tbOutfitId, self.mapNoteCount, nNoteId)
  local bShowInfo = false
  local nMaxNote = 0
  self.tbShowInfo = {}
  for _, mapData in ipairs(tbSkill) do
    local tbNoteInfo = {}
    local bCurrShow = false
    for nTid, nCount in pairs(mapData.tbNote) do
      table.insert(tbNoteInfo, {nTid, nCount})
      if nTid == nNoteId then
        nMaxNote = math.max(nMaxNote, nCount)
        local nMaxLayerNoteNeed = mapData.nMaxLayerNoteNeed
        if nCurCount < nMaxLayerNoteNeed then
          bCurrShow = true
          bShowInfo = true
        end
      end
    end
    
    local function sort(a, b)
      if a[1] == nNoteId or b[1] == nNoteId then
        return a[1] == nNoteId
      end
      return a[1] > b[1]
    end
    
    if bCurrShow then
      table.sort(tbNoteInfo, sort)
      table.insert(self.tbShowInfo, {
        nId = mapData.nId,
        tbNote = tbNoteInfo,
        nCurrentLevel = mapData.nCurLevel
      })
    end
  end
  if bShowInfo == true then
    self._mapNode.goNoteHint:SetActive(true)
    local sCount = ""
    if nCurCount >= nMaxNote then
      sCount = orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Change_3"), nCurCount, nMaxNote)
    else
      sCount = orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Change_2"), nCurCount, nMaxNote)
    end
    NovaAPI.SetTMPText(self._mapNode.TMPNoteHintCount, sCount)
    local mapNote = ConfigTable.GetData("SubNoteSkill", nNoteId)
    if mapNote ~= nil then
      self:SetPngSprite(self._mapNode.imgIconNoteHint, mapNote.Icon .. AllEnum.DiscSkillIconSurfix.Small)
    end
  else
    self._mapNode.goNoteHint:SetActive(false)
  end
  if 0 < #self.tbShowInfo then
    self._mapNode.imgOutfitSkillBg:SetActive(true)
    self._mapNode.lstOutfitSkillInfo:Init(#self.tbShowInfo, self, self.OnDiscSkillInfoGridRefresh)
  else
    self._mapNode.imgOutfitSkillBg:SetActive(false)
  end
end

function StarTowerShopCtrl:OnDiscSkillInfoGridRefresh(goGrid, nIdx)
  local mapSkill = self.tbShowInfo[nIdx + 1]
  local tbNoteCount = {}
  local tbNoteCountMask = {}
  local tbimgIconCount = {}
  local tbimgIconCountMask = {}
  local TMPSkillTitle = goGrid.transform:Find("btnGrid/AnimRoot/TMPSkillTitle"):GetComponent("TMP_Text")
  local TMPSkillTitleMask = goGrid.transform:Find("btnGrid/AnimRoot/goDeactiveMask/TMPSkillTitleMask"):GetComponent("TMP_Text")
  local imgIcon = goGrid.transform:Find("btnGrid/AnimRoot/imgIconBg/imgIcon"):GetComponent("Image")
  local imgIconBg = goGrid.transform:Find("btnGrid/AnimRoot/imgIconBg"):GetComponent("Image")
  local imgIconBgMask = goGrid.transform:Find("btnGrid/AnimRoot/goDeactiveMask/imgIconBgMask"):GetComponent("Image")
  local goDeactiveMask = goGrid.transform:Find("btnGrid/AnimRoot/goDeactiveMask").gameObject
  tbNoteCount[1] = goGrid.transform:Find("btnGrid/AnimRoot/TMPNoteCount1"):GetComponent("TMP_Text")
  tbNoteCount[2] = goGrid.transform:Find("btnGrid/AnimRoot/TMPNoteCount2"):GetComponent("TMP_Text")
  tbNoteCount[3] = goGrid.transform:Find("btnGrid/AnimRoot/TMPNoteCount3"):GetComponent("TMP_Text")
  tbNoteCountMask[1] = goGrid.transform:Find("btnGrid/AnimRoot/goDeactiveMask/TMPNoteCountMask1"):GetComponent("TMP_Text")
  tbNoteCountMask[2] = goGrid.transform:Find("btnGrid/AnimRoot/goDeactiveMask/TMPNoteCountMask2"):GetComponent("TMP_Text")
  tbNoteCountMask[3] = goGrid.transform:Find("btnGrid/AnimRoot/goDeactiveMask/TMPNoteCountMask3"):GetComponent("TMP_Text")
  tbimgIconCount[1] = goGrid.transform:Find("btnGrid/AnimRoot/TMPNoteCount1/imgIconCount1"):GetComponent("Image")
  tbimgIconCount[2] = goGrid.transform:Find("btnGrid/AnimRoot/TMPNoteCount2/imgIconCount2"):GetComponent("Image")
  tbimgIconCount[3] = goGrid.transform:Find("btnGrid/AnimRoot/TMPNoteCount3/imgIconCount3"):GetComponent("Image")
  tbimgIconCountMask[1] = goGrid.transform:Find("btnGrid/AnimRoot/goDeactiveMask/TMPNoteCountMask1/imgIconCountMask1"):GetComponent("Image")
  tbimgIconCountMask[2] = goGrid.transform:Find("btnGrid/AnimRoot/goDeactiveMask/TMPNoteCountMask2/imgIconCountMask2"):GetComponent("Image")
  tbimgIconCountMask[3] = goGrid.transform:Find("btnGrid/AnimRoot/goDeactiveMask/TMPNoteCountMask3/imgIconCountMask3"):GetComponent("Image")
  local mapSkillCfg = ConfigTable.GetData("SecondarySkill", mapSkill.nId)
  if mapSkillCfg == nil then
    goGrid:SetActive(false)
    return
  else
    goGrid:SetActive(true)
  end
  NovaAPI.SetTMPText(TMPSkillTitle, mapSkillCfg.Name)
  NovaAPI.SetTMPText(TMPSkillTitleMask, mapSkillCfg.Name)
  self:SetPngSprite(imgIcon, mapSkillCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
  self:SetPngSprite(imgIconBg, mapSkillCfg.IconBg .. AllEnum.DiscSkillIconSurfix.Small)
  self:SetPngSprite(imgIconBgMask, mapSkillCfg.IconBg .. AllEnum.DiscSkillIconSurfix.Small)
  local bMask = false
  for i = 1, 3 do
    if mapSkill.tbNote[i] ~= nil then
      tbNoteCount[i].gameObject:SetActive(true)
      tbNoteCountMask[i].gameObject:SetActive(true)
      tbimgIconCount[i].gameObject:SetActive(true)
      tbimgIconCountMask[i].gameObject:SetActive(true)
      local mapNote = ConfigTable.GetData("SubNoteSkill", mapSkill.tbNote[i][1])
      if mapNote ~= nil then
        local sNoteIconPath = mapNote.Icon .. AllEnum.DiscSkillIconSurfix.Small
        self:SetPngSprite(tbimgIconCount[i], sNoteIconPath)
        self:SetPngSprite(tbimgIconCountMask[i], sNoteIconPath)
      end
      local nCurCount = self.mapNoteCount[mapSkill.tbNote[i][1]] == nil and 0 or self.mapNoteCount[mapSkill.tbNote[i][1]]
      local sCount = ""
      local sMaskCount = nCurCount .. "/" .. mapSkill.tbNote[i][2]
      if nCurCount >= mapSkill.tbNote[i][2] then
        sCount = orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Change_4"), nCurCount, mapSkill.tbNote[i][2])
      else
        sCount = orderedFormat(ConfigTable.GetUIText("StarTower_Depot_Note_Change_5"), nCurCount, mapSkill.tbNote[i][2])
        if 1 > mapSkill.nCurrentLevel then
          bMask = true
        end
      end
      NovaAPI.SetTMPText(tbNoteCount[i], sCount)
      NovaAPI.SetTMPText(tbNoteCountMask[i], sMaskCount)
    else
      tbNoteCount[i].gameObject:SetActive(false)
      tbNoteCountMask[i].gameObject:SetActive(false)
      tbimgIconCount[i].gameObject:SetActive(false)
      tbimgIconCountMask[i].gameObject:SetActive(false)
    end
  end
  goDeactiveMask:SetActive(bMask)
end

return StarTowerShopCtrl

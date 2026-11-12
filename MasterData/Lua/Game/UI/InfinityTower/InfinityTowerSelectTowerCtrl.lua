local InfinityTowerSelectTowerCtrl = class("InfinityTowerSelectTowerCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local Path = require("path")
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
local typeof = _ENV.typeof
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
local tabItemIndex = {
  [1] = {
    "diffListView_in",
    "diffListView_out",
    "InfinitylvList_out"
  },
  [2] = {
    "diffListView_in_white",
    "diffListView_out_white",
    "InfinitylvList_out_white"
  },
  [3] = {
    "diffListView_in",
    "diffListView_out",
    "InfinitylvList_out"
  },
  [4] = {
    "diffListView_in",
    "diffListView_out",
    "InfinitylvList_out"
  },
  [5] = {
    "diffListView_in",
    "diffListView_out",
    "InfinitylvList_out"
  },
  [6] = {
    "diffListView_in_white",
    "diffListView_out_white",
    "InfinitylvList_out_white"
  },
  [7] = {
    "diffListView_in_white",
    "diffListView_out_white",
    "InfinitylvList_out_white"
  }
}
local rabbitRightId = 917302
local rabbitLeftId = 917402
local tabNPCTowerId = {
  [1] = rabbitRightId,
  [2] = rabbitLeftId,
  [3] = rabbitRightId,
  [4] = rabbitRightId,
  [5] = rabbitRightId,
  [6] = rabbitLeftId,
  [7] = rabbitLeftId
}
InfinityTowerSelectTowerCtrl._mapNodeConfig = {
  ImgBG = {sNodeName = "----BG----", sComponentName = "Image"},
  towerList = {},
  itemCtrl = {
    sNodeName = "item_",
    sCtrlName = "Game.UI.InfinityTower.InfinityTowerSelectTowerItem",
    nCount = 7
  },
  btnBountyLevel = {
    sComponentName = "UIButton",
    callback = "OnClickBountyLevel"
  },
  btnRedDotBounty = {
    sNodeName = "redDotBounty",
    sComponentName = "UIButton",
    callback = "OnClickDotBounty"
  },
  btn_texBounty = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Bounty_Level"
  },
  btn_texBountyLevel = {sComponentName = "TMP_Text"},
  redDotBounty = {},
  btnPlot = {
    sComponentName = "UIButton",
    callback = "OnClickPlot"
  },
  btn_texPlot = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Plot_Entry"
  },
  redDotPlot = {},
  diffListView = {},
  dlv_Diff_Select = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Difficulty_Select"
  },
  diffList = {
    sComponentName = "LoopScrollView"
  },
  tex_WeekTips = {sComponentName = "TMP_Text"},
  lvList = {},
  lvListInfo = {
    sNodeName = "lvList",
    sCtrlName = "Game.UI.InfinityTower.InfinityTowerLvList"
  },
  bgLvList = {},
  tv = {},
  goEnemyInfo = {
    sCtrlName = "Game.UI.MainlineEx.MainlineMonsterInfoCtrl"
  },
  bottomBg = {},
  bottom_Daily = {
    sCtrlName = "Game.UI.InfinityTower.InfinityTowerRollMsg"
  },
  bottom_Breakout = {
    sCtrlName = "Game.UI.InfinityTower.InfinityTowerRollMsg"
  },
  bottom_News = {
    nCount = 3,
    sCtrlName = "Game.UI.InfinityTower.InfinityTowerRollMsg"
  },
  bottomList = {
    sComponentName = "RectTransform"
  },
  goBountyView = {
    sCtrlName = "Game.UI.InfinityTower.InfinityTowerBounty"
  },
  goPlot_blur = {},
  goPlot_MaskClose = {
    sComponentName = "UIButton",
    callback = "OnClickClosePlot"
  },
  goPlotView = {
    sCtrlName = "Game.UI.InfinityTower.InfinityTowerPlot"
  },
  TopBarPanel = {
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  light = {},
  color = {},
  trRoot_L = {
    sNodeName = "----Actor2DLeft302----",
    sComponentName = "Transform"
  },
  trRoot_R = {
    sNodeName = "----Actor2DRight402----",
    sComponentName = "Transform"
  },
  Actor2DLeft = {
    sNodeName = "rawImg_L_302",
    sComponentName = "RawImage"
  },
  Actor2DPngL = {sNodeName = "png_L_302", sComponentName = "Transform"},
  Actor2DRight = {
    sNodeName = "rawImg_R_402",
    sComponentName = "RawImage"
  },
  Actor2DPngR = {sNodeName = "png_R_402", sComponentName = "Transform"},
  goBubbleRootLeft = {
    sNodeName = "----fixed_bubble302----"
  },
  goBubbleRootLeftCanvas = {
    sNodeName = "----fixed_bubble302----",
    sComponentName = "Canvas"
  },
  goBubbleRootRight = {
    sNodeName = "----fixed_bubble402----"
  },
  goBubbleRootRightCanvas = {
    sNodeName = "----fixed_bubble402----",
    sComponentName = "Canvas"
  },
  btnActor = {
    sComponentName = "Button",
    callback = "OnBtnClick_Actor"
  }
}
InfinityTowerSelectTowerCtrl._mapEventConfig = {
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  Infinity_Select_Tower = "OnEvent_InfinitySelectTower",
  Get_InfinityTower_InfoReq = "OnEvent_GetInfinityTowerInfoReq",
  Guide_DisableScrollView = "OnEvent_DisableScrollView",
  [EventId.ShowBubbleVoiceText] = "OnEvent_ShowBubbleVoiceText"
}
InfinityTowerSelectTowerCtrl._mapRedDotConfig = {
  [RedDotDefine.Map_InfinityTowerDaily] = {
    sNodeName = "redDotBounty"
  },
  [RedDotDefine.Map_InfinityTowerPlot] = {sNodeName = "redDotPlot"}
}

function InfinityTowerSelectTowerCtrl:Awake()
  self.AnimPanel = self.gameObject:GetComponent("Animator")
  self.npcHFCcounter = ConfigTable.GetConfigNumber("NpcHFCcounter")
  self.npcHFCtimer = ConfigTable.GetConfigNumber("NpcHFCtimer")
  self.npcHangtimer = ConfigTable.GetConfigNumber("NpcHangtimer")
  self.UseLive2D = LocalSettingData.mapData.UseLive2D
  self._mapNode.towerList:SetActive(false)
  self.pageType = PlayerData.InfinityTower:GetPageState()
  self.mapDiffGrid = {}
  if not PlayerData.InfinityTower:GetInitInfoState() then
    PlayerData.InfinityTower:GetITInfoReq()
  end
end

function InfinityTowerSelectTowerCtrl:FadeIn()
  if self.pageType == 1 and self._panel.openTowerId == nil then
    EventManager.Hit(EventId.SetTransition)
    
    local function waitCallback()
      self.AnimPanel:Play("InfinityTowerList_in")
    end
    
    self:AddTimer(1, 0.5, waitCallback, true, true, true, nil)
  end
end

function InfinityTowerSelectTowerCtrl:FadeOut()
end

function InfinityTowerSelectTowerCtrl:OnEnable()
  if self._panel.openTowerId == nil then
    if self.pageType == 3 and self.selectTowerId == nil then
      self.pageType = 1
    end
    if self.pageType <= 2 then
      self:LoadBG(0)
    else
      self:LoadBG(self.selectTowerId)
    end
    self:InitBottomRollMsg()
    if PlayerData.InfinityTower:GetInitInfoState() then
      self:OnInitPanelInfo()
    end
  else
    self:InitBottomRollMsg()
    if not PlayerData.InfinityTower:GetInitInfoState() then
      self.pageType = 2
      self.selectTowerId = self._panel.openTowerId
      self._panel.openTowerId = nil
    else
      self:OnEvent_InfinitySelectTower(self._panel.openTowerId, true, false)
      self._panel.openTowerId = nil
      self._mapNode.bgLvList:SetActive(false)
    end
  end
  self:AddTimer(1, 0.2, function()
    self:LoadRabbit()
  end, true, true, true, nil)
  local sortingOrder = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
  NovaAPI.SetCanvasSortingName(self._mapNode.goBubbleRootLeftCanvas, self._panel._sSortingLayerName)
  NovaAPI.SetCanvasSortingName(self._mapNode.goBubbleRootRightCanvas, self._panel._sSortingLayerName)
  NovaAPI.SetCanvasSortingOrder(self._mapNode.goBubbleRootLeftCanvas, sortingOrder + 2)
  NovaAPI.SetCanvasSortingOrder(self._mapNode.goBubbleRootRightCanvas, sortingOrder + 2)
end

function InfinityTowerSelectTowerCtrl:OnInitPanelInfo()
  self:InitTower()
  if self.pageType == 1 then
    self._mapNode.towerList:SetActive(true)
    self._mapNode.diffListView:SetActive(false)
    self._mapNode.lvList:SetActive(false)
    self._mapNode.tv:SetActive(false)
    self._mapNode.bgLvList:SetActive(false)
    self._mapNode.bottomBg:SetActive(true)
    self:AddTimer(1, 1, function()
      if PlayerData.Guide:CheckInGuideGroup(18) then
        EventManager.Hit("InfinityTowerPanelOpenFinish", self.pageType)
      end
    end, true, true, true)
  elseif self.pageType == 2 then
    self._mapNode.bgLvList:SetActive(false)
    self:OnEvent_InfinitySelectTower(self.selectTowerId, true, false)
  elseif self.pageType == 3 then
    self._mapNode.towerList:SetActive(false)
    self._mapNode.diffListView:SetActive(false)
    self._mapNode.lvList:SetActive(true)
    self._mapNode.tv:SetActive(true)
    self._mapNode.bgLvList:SetActive(true)
    self._mapNode.bottomBg:SetActive(false)
    local diffSort = PlayerData.InfinityTower:GetSelectLvSortId()
    self:InfinitySelectTower(self.selectTowerId, diffSort)
    self:AddTimer(1, 0.2, function()
      if PlayerData.Guide:CheckInGuideGroup(18) then
        EventManager.Hit("InfinityTowerPanelOpenFinish", self.pageType)
      end
    end, true, true, true)
  end
end

function InfinityTowerSelectTowerCtrl:OnEvent_GetInfinityTowerInfoReq()
  self:OnInitPanelInfo()
end

function InfinityTowerSelectTowerCtrl:OnEvent_EntryInfinityTowerMap()
  BubbleVoiceManager.StopBubbleAnim()
  BubbleVoiceManager.StopBubbleAnim_EX()
  PlayerData.Voice:StopCharVoice()
  PlayerData.Voice:ClearTimer()
  self.pageType = 1
  PlayerData.InfinityTower:SetPageState(1)
end

function InfinityTowerSelectTowerCtrl:OnDisable()
  self:UnbindAllGrids()
  self:UnLoadRabbit()
  if self.bottomListTweener ~= nil then
    self.bottomListTweener:Kill()
  end
  self.AutoCloseBubbleTimer = nil
  if self.twinTimer ~= nil then
    self.twinTimer:Cancel()
  end
  PlayerData.Voice:ClearTimer()
  BubbleVoiceManager.StopBubbleAnim()
  BubbleVoiceManager.StopBubbleAnim_EX()
  PlayerData.Voice:ClearTimer()
end

function InfinityTowerSelectTowerCtrl:OnDestroy()
end

function InfinityTowerSelectTowerCtrl:OnRelease()
end

function InfinityTowerSelectTowerCtrl:LoadBG(towerId)
  local sFullPath = ""
  if self.pageType == 3 and towerId == 0 then
    return
  end
  if self.pageType <= 2 then
    sFullPath = string.format("Image/UIBG/%s", "bg_infinitytower_pk_08")
  else
    local towerData = ConfigTable.GetData("InfinityTower", towerId)
    sFullPath = string.format("Image/UIBG/%s", towerData.Bg)
  end
  if self._mapNode and self._mapNode.ImgBG then
    self:SetPngSprite(self._mapNode.ImgBG, sFullPath)
  end
end

function InfinityTowerSelectTowerCtrl:InitTower()
  for i = 1, 7 do
    self._mapNode.itemCtrl[i]:InitTowerMsg(i)
  end
  NovaAPI.SetTMPText(self._mapNode.btn_texBountyLevel, tostring(PlayerData.InfinityTower.BountyLevel))
end

function InfinityTowerSelectTowerCtrl:InitBottomRollMsg()
  self._mapNode.bottom_Daily:InitRoll(GameEnum.InfinityTowerMsgType.Daily, 1)
  self._mapNode.bottom_Breakout:InitRoll(GameEnum.InfinityTowerMsgType.Breakout, 1)
  for i = 1, 3 do
    self._mapNode.bottom_News[i]:InitRoll(GameEnum.InfinityTowerMsgType.News, i)
  end
  self._mapNode.bottomList.anchoredPosition = Vector2(Settings.DESIGN_SCREEN_RESOLUTION_WIDTH, 25)
  self:RefreshBottomMsg()
end

function InfinityTowerSelectTowerCtrl:RefreshBottomMsg()
  if self.bottomListTweener ~= nil then
    self.bottomListTweener:Kill()
  end
  PlayerData.InfinityTower:RandomBottomMsg()
  self._mapNode.bottom_Daily:SetMsg()
  self._mapNode.bottom_Breakout:SetMsg()
  for i = 1, 3 do
    self._mapNode.bottom_News[i]:SetMsg()
  end
  
  local function waitCall()
    if self._mapNode.bottomList and type(self._mapNode.bottomList) ~= "number" then
      self._mapNode.bottomList.gameObject:SetActive(true)
      self._mapNode.bottomList.anchoredPosition = Vector2(Settings.DESIGN_SCREEN_RESOLUTION_WIDTH, 25)
      local tmpWidth = self._mapNode.bottomList.rect.width + Settings.DESIGN_SCREEN_RESOLUTION_WIDTH * 0.5 + 100
      local moveDis = tmpWidth + Settings.DESIGN_SCREEN_RESOLUTION_WIDTH
      local tmpTime = math.ceil(moveDis / 250)
      self.bottomListTweener = Sequence()
      self.bottomListTweener:Append(self._mapNode.bottomList:DOLocalMoveX(-tmpWidth, tmpTime))
      self.bottomListTweener:OnComplete(function()
        self._mapNode.bottomList.gameObject:SetActive(false)
        self:RefreshBottomMsg()
      end)
      self.bottomListTweener:SetUpdate(true)
    end
  end
  
  self:AddTimer(1, 1.5, waitCall, true, true, true, nil)
end

function InfinityTowerSelectTowerCtrl:OnEvent_InfinitySelectTower(towerId, isPlayAniViewIn, isNPCVoice)
  BubbleVoiceManager.StopBubbleAnim()
  BubbleVoiceManager.StopBubbleAnim_EX()
  PlayerData.Voice:StopCharVoice()
  self.pageType = 2
  PlayerData.InfinityTower:SetPageState(2)
  if isPlayAniViewIn then
    self._mapNode.diffList.gameObject:SetActive(false)
  end
  self._mapNode.diffListView:SetActive(true)
  self.selectTowerId = towerId
  local towerData = ConfigTable.GetData("InfinityTower", towerId)
  local texKey = towerData.OpenDayDesc
  NovaAPI.SetTMPText(self._mapNode.tex_WeekTips, ConfigTable.GetUIText(texKey))
  local count = PlayerData.InfinityTower:GetTowerDiffCount(towerId)
  if isPlayAniViewIn then
    local function waitShowItem()
      self._mapNode.diffList.gameObject:SetActive(true)
      
      self._mapNode.diffList:SetAnim(0.1)
      self._mapNode.diffList:Init(count, self, self.InitDiffList)
    end
    
    self:AddTimer(1, 0.65, waitShowItem, true, true, true, nil)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.75)
  else
    self._mapNode.diffList:SetAnim(0.1)
    self._mapNode.diffList:Init(count, self, self.InitDiffList)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
  end
  
  local function waitCallback()
    self._mapNode.towerList:SetActive(false)
  end
  
  self:AddTimer(1, 0.3, waitCallback, true, true, true, nil)
  if isPlayAniViewIn then
    local sAnim = tabItemIndex[towerId][1]
    local nAnimLen = NovaAPI.GetAnimClipLength(self.AnimPanel, {sAnim})
    self.AnimPanel:Play(sAnim)
    self:AddTimer(1, nAnimLen, function()
      if PlayerData.Guide:CheckInGuideGroup(18) then
        EventManager.Hit("InfinityTowerPanelOpenFinish", self.pageType)
      end
    end, true, true, true)
  else
    self.AnimPanel:Play(tabItemIndex[towerId][3])
  end
  if isNPCVoice then
    if self.twinTimer ~= nil then
      self.twinTimer:Cancel()
    end
    self:PlayOneNpcVoiceGreen()
  end
end

function InfinityTowerSelectTowerCtrl:InitDiffList(goGrid, gridIndex)
  if self.mapDiffGrid[goGrid] == nil then
    self.mapDiffGrid[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.InfinityTower.InfinityTowerDifficultyItem")
  end
  local nIdx = gridIndex + 1
  self.mapDiffGrid[goGrid]:InitDiffList(self.selectTowerId, nIdx, self)
end

function InfinityTowerSelectTowerCtrl:InfinitySelectTower(towerId, diffSort)
  BubbleVoiceManager.StopBubbleAnim()
  BubbleVoiceManager.StopBubbleAnim_EX()
  PlayerData.Voice:StopCharVoice()
  self.pageType = 3
  PlayerData.Voice:ClearTimer()
  PlayerData.InfinityTower:SetPageState(3)
  self:SetLightActive(false)
  self:LoadBG(towerId)
  self._mapNode.towerList:SetActive(false)
  self._mapNode.diffListView:SetActive(false)
  self._mapNode.lvList:SetActive(true)
  self._mapNode.tv:SetActive(true)
  self._mapNode.bgLvList:SetActive(true)
  self._mapNode.bottomBg:SetActive(false)
  self.selectTowerId = towerId
  PlayerData.InfinityTower:SetSelectLvSortId(diffSort)
  self._mapNode.lvListInfo:InitLvList(towerId, diffSort, self)
  self.AnimPanel:Play("InfinityTowerlvList_in")
end

function InfinityTowerSelectTowerCtrl:UnbindAllGrids()
  for go, ctrl in ipairs(self.mapDiffGrid) do
    self:UnbindCtrlByNode(ctrl)
  end
  self.mapDiffGrid = {}
end

function InfinityTowerSelectTowerCtrl:InitSelectLvMsg(towerId, floor)
end

function InfinityTowerSelectTowerCtrl:ShowAffixItem(tabAffixId)
  local childCount = self._mapNode.affixSCRoot.childCount
  for i = 1, childCount do
    self._mapNode.affixSCRoot:GetChild(i - 1).gameObject:SetActive(false)
  end
  local tmpCount = 3
  if 3 < #tabAffixId then
    tmpCount = #tmpCount
  end
  local index = 1
  for i = 1, tmpCount do
    local obj
    if index + 1 > self._mapNode.affixSCRoot.childCount then
      obj = instantiate(self._mapNode.affix_ItemList, self._mapNode.affixSCRoot)
    else
      obj = self._mapNode.affixSCRoot:GetChild(index).gameObject
    end
    local affixId = 0
    if tabAffixId[i] ~= nil then
      affixId = tabAffixId[i]
    end
    self:ShowAffixItemMsg(obj, affixId)
    index = index + 1
  end
end

function InfinityTowerSelectTowerCtrl:ShowAffixItemMsg(obj, affixId)
  local affix_texItem = obj.transform:Find("affix_texItem"):GetComponent("TMP_Text")
  local tmp_Affix = obj.transform:Find("tmp_Affix").gameObject
  if affixId == 0 then
    affix_texItem.gameObject:SetActive(false)
    tmp_Affix:SetActive(true)
  else
    affix_texItem.gameObject:SetActive(true)
    tmp_Affix:SetActive(false)
    local dataAffix = ConfigTable.GetData("InfinityTowerAffix", affixId)
    local sDesc = orderedFormat(ConfigTable.GetUIText("InfinityTowerAffix_Desc"), dataAffix.Name, dataAffix.Desc)
    NovaAPI.SetTMPText(affix_texItem, UTILS.ParseParamDesc(sDesc, dataAffix))
  end
  obj:SetActive(true)
end

function InfinityTowerSelectTowerCtrl:RefreshMonsterGrid(goGrid, gridIndex)
  local index = gridIndex + 1
  local mapMonster = self.tbMonster[index]
  if mapMonster == nil then
    return
  end
  local imgIcon = goGrid.transform:Find("btnGrid/AnimRoot/tc_head_01/--Basic--/imgIcon"):GetComponent("Image")
  local goSelect = goGrid.transform:Find("btnGrid/AnimRoot/tc_head_01/--Common--").gameObject
  local goBoss = goGrid.transform:Find("btnGrid/AnimRoot/tc_head_01/--Monster--/goBoss").gameObject
  local goElite = goGrid.transform:Find("btnGrid/AnimRoot/tc_head_01/--Monster--/goElite").gameObject
  local btn = goGrid.transform:Find("btnGrid"):GetComponent("UIButton")
  local nMonsterId = mapMonster.PreviewMonsterListId
  btn.onClick:RemoveAllListeners()
  local minLevel = self.tbMonster[index].MinLv
  local maxLevel = self.tbMonster[index].MaxLv
  local _strLv = ""
  if minLevel == maxLevel then
    _strLv = minLevel
  else
    _strLv = maxLevel
  end
  
  local function clickCb()
    local mapData = {nTid = nMonsterId, strLv = _strLv}
    EventManager.Hit(EventId.OpenPanel, PanelId.MonsterTips, btn.gameObject, mapData)
  end
  
  btn.onClick:AddListener(clickCb)
  local cfgDataMonster = ConfigTable.GetData("PreviewMonsterList", nMonsterId)
  if nil ~= cfgDataMonster then
    self:SetPngSprite(imgIcon, cfgDataMonster.Icon)
    goSelect:SetActive(false)
    goBoss:SetActive(cfgDataMonster.EpicLv == GameEnum.monsterEpicType.LORD)
    goElite:SetActive(cfgDataMonster.EpicLv == GameEnum.monsterEpicType.LEADER or cfgDataMonster.EpicLv == GameEnum.monsterEpicType.ELITE)
  end
end

function InfinityTowerSelectTowerCtrl:OnClickBountyLevel()
  self._mapNode.goBountyView:InitView()
end

function InfinityTowerSelectTowerCtrl:OnClickDotBounty()
  if PlayerData.InfinityTower.isHaveDailyReward then
    PlayerData.InfinityTower:ITDailyRewardReq()
  end
end

function InfinityTowerSelectTowerCtrl:OnClickPlot()
  self._mapNode.goPlot_blur:SetActive(true)
  self._mapNode.goPlotView:OpenPlotView()
end

function InfinityTowerSelectTowerCtrl:OnClickClosePlot()
  self._mapNode.goPlot_blur:SetActive(false)
  self._mapNode.goPlotView:OnBtnClick_Close()
end

function InfinityTowerSelectTowerCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PlayerData.InfinityTower:SetPageState(1)
  PanelManager.Home()
end

function InfinityTowerSelectTowerCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  BubbleVoiceManager.StopBubbleAnim()
  BubbleVoiceManager.StopBubbleAnim_EX()
  PlayerData.Voice:StopCharVoice()
  if self.pageType == 3 then
    self.pageType = 2
    PlayerData.InfinityTower:SetPageState(2)
    self:SetLightActive(true)
    self:OnEvent_InfinitySelectTower(self.selectTowerId, false, true)
    self:LoadBG(0)
    self._mapNode.lvList:SetActive(false)
    self._mapNode.tv:SetActive(false)
    self._mapNode.bgLvList:SetActive(false)
    self._mapNode.bottomBg:SetActive(true)
  elseif self.pageType == 2 then
    self.pageType = 1
    PlayerData.Voice:ClearTimer()
    PlayerData.InfinityTower:SetPageState(1)
    self._mapNode.towerList:SetActive(true)
    
    local function waitCallback()
      self._mapNode.diffListView:SetActive(false)
    end
    
    self:AddTimer(1, 0.3, waitCallback, true, true, true, nil)
    self:InitTower()
    self.AnimPanel:Play(tabItemIndex[self.selectTowerId][2])
  else
    EventManager.Hit(EventId.CloesCurPanel)
    PlayerData.InfinityTower:SetPageState(1)
  end
end

function InfinityTowerSelectTowerCtrl:SetLightActive(isActive)
  self._mapNode.light:SetActive(isActive)
  self._mapNode.color:SetActive(isActive)
  self._mapNode.trRoot_L.localScale = isActive == true and Vector3.one or Vector3.zero
  self._mapNode.trRoot_R.localScale = isActive == true and Vector3.one or Vector3.zero
end

function InfinityTowerSelectTowerCtrl:LoadRabbit()
  self._mapNode.Actor2DLeft.transform.localScale = self.UseLive2D == true and Vector3.one or Vector3.zero
  self._mapNode.Actor2DRight.transform.localScale = self.UseLive2D == true and Vector3.one or Vector3.zero
  self._mapNode.Actor2DPngL.localScale = self.UseLive2D == true and Vector3.zero or Vector3.one
  self._mapNode.Actor2DPngR.localScale = self.UseLive2D == true and Vector3.zero or Vector3.one
  if self.UseLive2D == true then
    Actor2DManager.SetBoardNPC2D(self:GetPanelId(), self._mapNode.Actor2DLeft, rabbitLeftId, nil, nil, 1)
    Actor2DManager.SetBoardNPC2D(self:GetPanelId(), self._mapNode.Actor2DRight, rabbitRightId, nil, nil, 2)
  else
    Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.Actor2DPngL, self:GetPanelId(), rabbitLeftId)
    Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.Actor2DPngR, self:GetPanelId(), rabbitRightId)
  end
  if self.pageType == 1 then
    self:PlayTwoNpcVoice()
  elseif self.pageType == 2 then
    self:PlayOneNpcVoiceGreen()
  end
end

function InfinityTowerSelectTowerCtrl:UnLoadRabbit()
  Actor2DManager.UnsetBoardNPC2D(1)
  Actor2DManager.UnsetBoardNPC2D(2)
end

function InfinityTowerSelectTowerCtrl:OnEvent_DisableScrollView(bDisable)
  NovaAPI.SetScrollRectVertical(self._mapNode.diffList, not bDisable)
end

function InfinityTowerSelectTowerCtrl:PlayOneNpcVoiceGreen()
  local npcId = rabbitLeftId
  if self.pageType == 2 then
    npcId = tabNPCTowerId[self.selectTowerId]
    PlayerData.Voice:StartBoardFreeTimer(npcId)
  end
  local isFirst, sKey = PlayerData.InfinityTower:GetNPCVoiceKey(npcId)
  if isFirst then
    PlayerData.Voice:PlayCharVoice(sKey, npcId, nil, true)
  else
    local tab = {"greet_npc", sKey}
    if PlayerData.InfinityTower.isLevelClear then
      tab = {"clear"}
      PlayerData.InfinityTower.isLevelClear = false
    end
    PlayerData.Voice:PlayCharVoice(tab, npcId, nil, true)
  end
end

function InfinityTowerSelectTowerCtrl:PlayTwoNpcVoice()
  local key = PlayerData.Voice:PlayCharVoice("twin_greet", rabbitLeftId, nil, true)
end

function InfinityTowerSelectTowerCtrl:OnEvent_ShowBubbleVoiceText(nNpcId, nId)
  local mapVoDirectoryData = ConfigTable.GetData("VoDirectory", nId)
  if mapVoDirectoryData == nil then
    printError("VoDirectory未找到数据id:" .. nId)
    return
  end
  if self.pageType == 1 then
    BubbleVoiceManager.PlayFixedBubbleAnim(self._mapNode.goBubbleRootLeft, mapVoDirectoryData.voResource, 1)
    BubbleVoiceManager.PlayFixedBubbleAnim_EX(self._mapNode.goBubbleRootRight, mapVoDirectoryData.voResource)
  elseif self.pageType == 2 then
    if nNpcId == rabbitLeftId then
      BubbleVoiceManager.PlayFixedBubbleAnim(self._mapNode.goBubbleRootLeft, mapVoDirectoryData.voResource, 1)
    else
      BubbleVoiceManager.PlayFixedBubbleAnim(self._mapNode.goBubbleRootRight, mapVoDirectoryData.voResource, 2)
    end
  end
end

function InfinityTowerSelectTowerCtrl:OnBtnClick_Actor()
  if self.pageType == 3 then
    return
  elseif self.pageType == 2 then
    local npcId = tabNPCTowerId[self.selectTowerId]
    PlayerData.Voice:PlayBoardNPCClickVoice(npcId)
  elseif self.pageType == 1 then
    self:PlayTwoNpcVoice()
  end
end

return InfinityTowerSelectTowerCtrl

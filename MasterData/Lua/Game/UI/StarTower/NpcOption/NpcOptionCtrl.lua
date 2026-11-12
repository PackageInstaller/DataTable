local NpcOptionCtrl = class("NpcOptionCtrl", BaseCtrl)
local Path = require("path")
local Offset = CS.Actor2DOffsetData
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
local ResType = GameResourceLoader.ResType
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
NpcOptionCtrl._mapNodeConfig = {
  goBlur = {sNodeName = "blurBg"},
  imgMask = {},
  goContent = {
    sNodeName = "----SafeAreaRoot----"
  },
  TMPChoose = {nCount = 4, sComponentName = "TMP_Text"},
  TMPChooseDisable = {nCount = 4, sComponentName = "TMP_Text"},
  TMPFuncDisable = {nCount = 4, sComponentName = "TMP_Text"},
  TMPFunc = {nCount = 4, sComponentName = "TMP_Text"},
  TMP_Title = {sComponentName = "TMP_Text"},
  imgBgDisable = {nCount = 4},
  imgIconLeave = {nCount = 4},
  imgIconEnable = {nCount = 4},
  rtChoice = {nCount = 4, sNodeName = "rtChoose"},
  btnChoose = {
    nCount = 4,
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Select"
  },
  Select = {nCount = 4},
  imgBody = {sComponentName = "Image"},
  imgFace = {sComponentName = "Image"},
  imgFunc = {nCount = 4},
  rtCharacter = {},
  rtPanel = {},
  rtSelect = {},
  canvasSelect = {
    sNodeName = "rtSelectOption",
    sComponentName = "Canvas"
  },
  rtTitle = {sComponentName = "Canvas"},
  rtTalk = {},
  imgTalkNameBg = {sComponentName = "Image"},
  rubyTmp_Talk = {
    sComponentName = "RubyTextMeshProUGUI"
  },
  txtName_Talk = {sComponentName = "TMP_Text"},
  btnTalk = {
    sComponentName = "Button",
    callback = "OnBtnClick_Talk"
  },
  btnShortcutTalk = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Talk"
  },
  animWaiting = {
    sNodeName = "goWaitingAnim",
    sComponentName = "Animator"
  },
  sv_Dialog_1L = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Talk"
  },
  ainPanel = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  TMPShowTitle = {sComponentName = "TMP_Text"},
  ButtonBack = {
    sComponentName = "NaviButton",
    callback = "OnBtn_Close"
  },
  btnBag = {
    sComponentName = "NaviButton",
    callback = "OnBtn_Depot"
  },
  BtnBg = {},
  imgCoinBg = {},
  imgCoin = {sComponentName = "Image"},
  txtCoinCount = {sComponentName = "TMP_Text"},
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  goAllNoteList = {
    sNodeName = "goNoteListBtn"
  },
  btnNoteDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NoteDetail"
  },
  goNoteListBtn = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NoteDetail"
  },
  imgNote = {sComponentName = "Image", nCount = 9},
  imgOutfitSkillBg = {},
  TMPOutfitSkillInfoTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "STShop_OutfitSkillInfoTitle"
  },
  lstOutfitSkillInfo = {
    sComponentName = "LoopScrollView"
  },
  animOutfitSkillBg = {
    sNodeName = "imgOutfitSkillBg",
    sComponentName = "Animator"
  }
}
NpcOptionCtrl._mapEventConfig = {
  RefreshStarTowerCoin = "OnEvent_SetCoin",
  GamepadUIChange = "OnEvent_GamepadUIChange",
  GamepadUIReopen = "OnEvent_Reopen",
  StarTowerAutoSelectEvent = "OnEvent_AutoSelectEvent",
  StarTowerAutoDisplayEvent = "OnEvent_AutoDisplayEvent"
}
NpcOptionCtrl._mapRedDotConfig = {}

function NpcOptionCtrl:Awake()
  self.PanelOffset = Vector3.zero
  self.tbGamepadUINode = self:GetGamepadUINode()
  self.nCoin = 0
  self._nAutoDisplaySerial = 0
  self:SetSprite_Coin(self._mapNode.imgCoin, AllEnum.CoinItemId.FixedRogCurrency)
  NovaAPI.SetTMPText(self._mapNode.txtCoinCount, self.nCoin)
end

function NpcOptionCtrl:FadeIn()
end

function NpcOptionCtrl:FadeOut()
end

function NpcOptionCtrl:OnEnable()
  self.bShowNote = false
  self._mapNode.goAllNoteList.gameObject:SetActive(false)
  self._mapNode.imgOutfitSkillBg:SetActive(false)
  self.nSelectIdx = 0
  self.nNoteEventId = 0
  self._mapNode.rtPanel.transform.localPosition = self.PanelOffset
  PanelManager.InputDisable()
  EventManager.Hit("StarTowerSetButtonEnable", false, false)
  GamepadUIManager.EnableGamepadUI("NpcOptionCtrl", self.tbGamepadUINode)
  local canvas = self.gameObject:GetComponent("Canvas")
  local nInitSortingOrder = NovaAPI.GetCanvasSortingOrder(canvas)
  NovaAPI.SetCanvasSortingOrder(self._mapNode.canvasSelect, nInitSortingOrder + 10)
  local nId = CS.UnityEngine.SortingLayer.NameToID(AllEnum.SortingLayerName.UI)
  NovaAPI.SetCanvasSortingId(self._mapNode.canvasSelect, nId)
  NovaAPI.SetCanvasSortingId(self._mapNode.rtTitle, nId)
  NovaAPI.SetCanvasSortingOrder(self._mapNode.rtTitle, nInitSortingOrder + 10)
  local tbParams = self:GetPanelParam()
  if type(tbParams) == "table" then
    self.nType = tbParams[1]
    local nEventId = tbParams[2]
    local tbNpcOption = tbParams[3]
    local nNpcSkinId = tbParams[4]
    self.callback = tbParams[5]
    self.bUnabledIdx = tbParams[6]
    local tableEventId = tbParams[7]
    local nTalkId = tbParams[8]
    self.nEventAction = tbParams[9]
    self.bOnlyTalk = tbParams[10]
    self.bSweep = tbParams[11]
    self.nCoin = tbParams[12]
    self.nStarTowerId = tbParams[13]
    self.tbNote = tbParams[14]
    self.tbDisc = tbParams[15]
    self.mapAutoDisplay = tbParams[16]
    NovaAPI.SetTMPText(self._mapNode.txtCoinCount, self:ThousandsNumber(self.nCoin))
    self._mapNode.imgMask.gameObject:SetActive(false)
    self._mapNode.goContent.gameObject:SetActive(false)
    self._mapNode.goBlur.gameObject:SetActive(true)
    canvas.enabled = false
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      NovaAPI.UIEffectSnapShotCapture(self._mapNode.goSnapShot)
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      canvas.enabled = true
      self._mapNode.imgMask.gameObject:SetActive(true)
      self._mapNode.goContent.gameObject:SetActive(true)
      if self.bOnlyTalk then
        self:RefreshTalkOnly(nNpcSkinId, nTalkId)
      elseif self.nType == 1 then
        self:Refresh(nEventId, tableEventId, tbNpcOption, self.bUnabledIdx, nNpcSkinId, nTalkId, self.nEventAction)
      else
        self:RefreshHighDanger(nEventId, nNpcSkinId, nTalkId)
      end
      self:SetAutoDisplay(self.mapAutoDisplay)
    end
    
    cs_coroutine.start(wait)
  end
  self.handler = {}
  for k, v in ipairs(self._mapNode.btnChoose) do
    self.handler[k] = ui_handler(self, self.OnBtnSelect_Select, v, k)
    v.onSelect:AddListener(self.handler[k])
  end
end

function NpcOptionCtrl:Refresh(nCaseId, nEventId, tbNpcOption, tbUnselect, nNpcSkinId, nTalkId, nActionId)
  local mapTalkData
  if 0 < nTalkId then
    mapTalkData = ConfigTable.GetData("StarTowerTalk", nTalkId)
  end
  for i = 1, 4 do
    self._mapNode.imgFunc[i]:SetActive(true)
  end
  local sFace = "002"
  if mapTalkData ~= nil then
    sFace = mapTalkData.Face
    local _b, _color = ColorUtility.TryParseHtmlString(mapTalkData.Color)
    NovaAPI.SetImageColor(self._mapNode.imgTalkNameBg, _color)
    NovaAPI.SetTMPText(self._mapNode.txtName_Talk, mapTalkData.Name)
    NovaAPI.SetText_RubyTMP(self._mapNode.rubyTmp_Talk, mapTalkData.Content)
    self._mapNode.ainPanel:Play("NpcOptionTalk_in")
    WwiseAudioMgr:WwiseVoice_PlayInAVG(mapTalkData.Voice)
    WwiseAudioMgr:PlaySound("ui_roguelike_event_enter")
    self._mapNode.BtnBg:SetActive(false)
    self:SetCoinActive(false)
    self:SelectTalk()
  else
    if self.nType == 1 then
      self._mapNode.ainPanel:Play("NpcOptionSelect_in")
    else
      self._mapNode.ainPanel:Play("NpcOptionSelectRed_in")
    end
    WwiseAudioMgr:PlaySound("ui_roguelike_event_dialog")
    self._mapNode.BtnBg:SetActive(true)
    self:SetCoinActive(true)
  end
  self.nNoteEventId = nEventId
  self.nEventId = nCaseId
  if tbNpcOption == nil then
    printError("Npc事件为空")
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      EventManager.Hit(EventId.ClosePanel, PanelId.NpcOptionPanel)
    end
    
    cs_coroutine.start(wait)
    return
  end
  local tbBtnObj = {}
  local bFirst = true
  local mapEventAction
  self._mapNode.TMPShowTitle:SetText("")
  if nActionId ~= 0 then
    mapEventAction = ConfigTable.GetData("StarTowerEventAction", nActionId)
    if mapEventAction ~= nil then
      self._mapNode.TMPShowTitle:SetText(mapEventAction.Desc)
    end
  end
  for i = 1, 4 do
    self._mapNode.TMPChoose[i]:SetText("")
    self._mapNode.TMPChooseDisable[i]:SetText("")
    if tbNpcOption[i] ~= nil then
      local mapResultCfgData = ConfigTable.GetData("EventOptions", tbNpcOption[i])
      if mapResultCfgData == nil then
        printError("ResultCfgData Missing:" .. tbNpcOption[i])
        self._mapNode.rtChoice[i]:SetActive(false)
      else
        if mapEventAction ~= nil then
          local nOptionActionId = tbNpcOption[i] * 10000 + mapEventAction.Group
          local mapOptionAction = ConfigTable.GetData("StarTowerEventOptionAction", nOptionActionId)
          if mapOptionAction ~= nil then
            self._mapNode.TMPChoose[i]:SetText(mapOptionAction.Desc)
            self._mapNode.TMPChooseDisable[i]:SetText(mapOptionAction.Desc)
          end
        end
        self._mapNode.TMPFunc[i]:SetText(mapResultCfgData.Desc)
        self._mapNode.TMPFuncDisable[i]:SetText(mapResultCfgData.Desc)
        if 0 < table.indexof(tbUnselect, i - 1) then
          self._mapNode.imgBgDisable[i]:SetActive(true)
          self._mapNode.btnChoose[i].interactable = false
        else
          self._mapNode.imgBgDisable[i]:SetActive(false)
          self._mapNode.btnChoose[i].interactable = true
          if bFirst then
            bFirst = false
            self.nSelectIdx = i
          end
          table.insert(tbBtnObj, self._mapNode.btnChoose[i])
        end
        self._mapNode.imgIconLeave[i]:SetActive(mapResultCfgData.IgnoreInterActive)
        self._mapNode.imgIconEnable[i]:SetActive(not mapResultCfgData.IgnoreInterActive)
        self._mapNode.rtChoice[i]:SetActive(true)
        self._mapNode.Select[i]:SetActive(false)
      end
    else
      self._mapNode.rtChoice[i]:SetActive(false)
    end
  end
  GamepadUIManager.SetNavigation(tbBtnObj, false)
  if mapTalkData == nil then
    self:SelectChoose()
  end
  
  local function GetName(sPortrait, Face)
    local sFileFullName = Path.basename(sPortrait)
    local sFileExtName = Path.extension(sPortrait)
    local sFileName = string.gsub(sFileFullName, sFileExtName, "")
    sFileName = string.gsub(sFileName, "_a", "")
    local sBodyName = string.format("%s_%s", sFileName, "001")
    local sFaceName = string.format("%s_%s", sFileName, Face)
    return sBodyName, sFaceName
  end
  
  local function GetSprite(sPortrait, sName)
    local _sPath = string.format("%s/atlas_png/a/%s.png", Path.dirname(sPortrait), sName)
    return self:LoadAsset(_sPath, typeof(Sprite))
  end
  
  local mapSkinData = ConfigTable.GetData("NPCSkin", nNpcSkinId)
  if mapSkinData == nil then
    return
  end
  local sAssetPath = mapSkinData.Portrait
  local sBodyName, sFaceName = GetName(sAssetPath, sFace)
  NovaAPI.SetImageSpriteAsset(self._mapNode.imgBody, GetSprite(sAssetPath, sBodyName))
  NovaAPI.SetImageSpriteAsset(self._mapNode.imgFace, GetSprite(sAssetPath, sFaceName))
  local Actor2DManager = require("Game.Actor2D.Actor2DManager")
  local offsetAsset = self:LoadOffset(mapSkinData.Offset)
  local mapOffset = Actor2DManager.GetMapPanelConfig(PanelId.NpcOptionPanel)
  local finalReuse = mapOffset.nReuse
  local s, x, y = offsetAsset:GetOffsetData(finalReuse, 1, true, 0, 0)
  local v3Pos = Vector3(x * 100, y * 100, 0)
  local v3Scale = Vector3(s, s, 1)
  self._mapNode.rtCharacter.transform.localPosition = v3Pos
  self._mapNode.rtCharacter.transform.localScale = v3Scale
  if mapEventAction ~= nil then
    self._mapNode.TMP_Title.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.TMP_Title, mapEventAction.Desc)
  else
    self._mapNode.TMP_Title.gameObject:SetActive(false)
  end
end

function NpcOptionCtrl:RefreshHighDanger(nEventId, nNpcSkinId, nTalkId)
  self.nEventId = nEventId
  self.nSelectIdx = 1
  local mapTalkData = ConfigTable.GetData("StarTowerTalk", nTalkId)
  local sFace = "002"
  if mapTalkData ~= nil then
    sFace = mapTalkData.Face
    local _b, _color = ColorUtility.TryParseHtmlString(mapTalkData.Color)
    NovaAPI.SetImageColor(self._mapNode.imgTalkNameBg, _color)
    NovaAPI.SetTMPText(self._mapNode.txtName_Talk, mapTalkData.Name)
    NovaAPI.SetText_RubyTMP(self._mapNode.rubyTmp_Talk, mapTalkData.Content)
    self._mapNode.ainPanel:Play("NpcOptionTalk_in")
    WwiseAudioMgr:PlaySound("ui_roguelike_event_enter")
    self._mapNode.BtnBg:SetActive(false)
    self:SetCoinActive(false)
    self:SelectTalk()
  else
    if self.nType == 1 then
      self._mapNode.ainPanel:Play("NpcOptionSelect_in")
    else
      self._mapNode.ainPanel:Play("NpcOptionSelectRed_in")
    end
    WwiseAudioMgr:PlaySound("ui_roguelike_event_dialog")
    self._mapNode.BtnBg:SetActive(true)
    self:SetCoinActive(true)
    self:SelectChoose()
  end
  for i = 1, 4 do
    self._mapNode.imgFunc[i]:SetActive(false)
  end
  self._mapNode.rtChoice[1]:SetActive(true)
  self._mapNode.rtChoice[2]:SetActive(true)
  self._mapNode.rtChoice[3]:SetActive(false)
  self._mapNode.rtChoice[4]:SetActive(false)
  self._mapNode.TMPChoose[1]:SetText(ConfigTable.GetUIText("StarTower_Npc_EnterHighDanger"))
  self._mapNode.imgBgDisable[1]:SetActive(false)
  self._mapNode.imgIconLeave[1]:SetActive(false)
  self._mapNode.imgIconEnable[1]:SetActive(true)
  self._mapNode.TMPChoose[2]:SetText(ConfigTable.GetUIText("StarTower_Npc_Leave"))
  self._mapNode.imgBgDisable[2]:SetActive(false)
  self._mapNode.imgIconLeave[2]:SetActive(true)
  self._mapNode.imgIconEnable[2]:SetActive(false)
  for i = 1, 4 do
    self._mapNode.Select[i]:SetActive(false)
  end
  GamepadUIManager.SetNavigation({
    self._mapNode.btnChoose[1],
    self._mapNode.btnChoose[2]
  }, false)
  
  local function GetName(sPortrait, Face)
    local sFileFullName = Path.basename(sPortrait)
    local sFileExtName = Path.extension(sPortrait)
    local sFileName = string.gsub(sFileFullName, sFileExtName, "")
    sFileName = string.gsub(sFileName, "_a", "")
    local sBodyName = string.format("%s_%s", sFileName, "001")
    local sFaceName = string.format("%s_%s", sFileName, Face)
    return sBodyName, sFaceName
  end
  
  local function GetSprite(sPortrait, sName)
    local _sPath = string.format("%s/atlas_png/a/%s.png", Path.dirname(sPortrait), sName)
    return self:LoadAsset(_sPath, typeof(Sprite))
  end
  
  local mapSkinData = ConfigTable.GetData("NPCSkin", nNpcSkinId)
  if mapSkinData == nil then
    return
  end
  local sAssetPath = mapSkinData.Portrait
  local sBodyName, sFaceName = GetName(sAssetPath, sFace)
  NovaAPI.SetImageSpriteAsset(self._mapNode.imgBody, GetSprite(sAssetPath, sBodyName))
  NovaAPI.SetImageSpriteAsset(self._mapNode.imgFace, GetSprite(sAssetPath, sFaceName))
  local Actor2DManager = require("Game.Actor2D.Actor2DManager")
  local offsetAsset = self:LoadOffset(mapSkinData.Offset)
  local mapOffset = Actor2DManager.GetMapPanelConfig(PanelId.NpcOptionPanel)
  local finalReuse = mapOffset.nReuse
  local s, x, y = offsetAsset:GetOffsetData(finalReuse, 1, true, 0, 0)
  local v3Pos = Vector3(x * 100, y * 100, 0)
  local v3Scale = Vector3(s, s, 1)
  self._mapNode.rtCharacter.transform.localPosition = v3Pos
  self._mapNode.rtCharacter.transform.localScale = v3Scale
  self._mapNode.TMP_Title.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.TMP_Title, ConfigTable.GetUIText("StarTower_Npc_EnterHighDangerTitle"))
  WwiseAudioMgr:PlaySound("ui_roguelike_event_enter")
end

function NpcOptionCtrl:RefreshTalkOnly(nNpcSkinId, nTalkId)
  local mapTalkData = ConfigTable.GetData("StarTowerTalk", nTalkId)
  local sFace = "002"
  if mapTalkData ~= nil then
    sFace = mapTalkData.Face
    local _b, _color = ColorUtility.TryParseHtmlString(mapTalkData.Color)
    NovaAPI.SetImageColor(self._mapNode.imgTalkNameBg, _color)
    NovaAPI.SetTMPText(self._mapNode.txtName_Talk, mapTalkData.Name)
    NovaAPI.SetText_RubyTMP(self._mapNode.rubyTmp_Talk, mapTalkData.Content)
    self._mapNode.ainPanel:Play("NpcOptionTalk_in")
    WwiseAudioMgr:WwiseVoice_PlayInAVG(mapTalkData.Voice)
    self._mapNode.BtnBg:SetActive(false)
    self:SetCoinActive(false)
    self:SelectTalk()
  else
    local function wait()
      printError("NPC Talk Data Missing:" .. nTalkId)
      
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      EventManager.Hit(EventId.ClosePanel, PanelId.NpcOptionPanel)
    end
    
    cs_coroutine.start(wait)
  end
  
  local function GetName(sPortrait, Face)
    local sFileFullName = Path.basename(sPortrait)
    local sFileExtName = Path.extension(sPortrait)
    local sFileName = string.gsub(sFileFullName, sFileExtName, "")
    sFileName = string.gsub(sFileName, "_a", "")
    local sBodyName = string.format("%s_%s", sFileName, "001")
    local sFaceName = string.format("%s_%s", sFileName, Face)
    return sBodyName, sFaceName
  end
  
  local function GetSprite(sPortrait, sName)
    local _sPath = string.format("%s/atlas_png/a/%s.png", Path.dirname(sPortrait), sName)
    return self:LoadAsset(_sPath, typeof(Sprite))
  end
  
  local mapSkinData = ConfigTable.GetData("NPCSkin", nNpcSkinId)
  if mapSkinData == nil then
    return
  end
  local sAssetPath = mapSkinData.Portrait
  local sBodyName, sFaceName = GetName(sAssetPath, sFace)
  NovaAPI.SetImageSpriteAsset(self._mapNode.imgBody, GetSprite(sAssetPath, sBodyName))
  NovaAPI.SetImageSpriteAsset(self._mapNode.imgFace, GetSprite(sAssetPath, sFaceName))
  local Actor2DManager = require("Game.Actor2D.Actor2DManager")
  local offsetAsset = self:LoadOffset(mapSkinData.Offset)
  local mapOffset = Actor2DManager.GetMapPanelConfig(PanelId.NpcOptionPanel)
  local finalReuse = mapOffset.nReuse
  local s, x, y = offsetAsset:GetOffsetData(finalReuse, 1, true, 0, 0)
  local v3Pos = Vector3(x * 100, y * 100, 0)
  local v3Scale = Vector3(s, s, 1)
  self._mapNode.rtCharacter.transform.localPosition = v3Pos
  self._mapNode.rtCharacter.transform.localScale = v3Scale
  WwiseAudioMgr:PlaySound("ui_roguelike_event_enter")
end

function NpcOptionCtrl:RefreshNoteList()
  self.bShowNote = true
  self._mapNode.goAllNoteList:SetActive(true)
  self.tbShowNote = {}
  local mapCfg = ConfigTable.GetData("StarTower", self.nStarTowerId)
  if mapCfg ~= nil then
    local nDropGroup = mapCfg.SubNoteSkillDropGroupId
    local tbNoteDrop = CacheTable.GetData("_SubNoteSkillDropGroup", nDropGroup)
    if tbNoteDrop ~= nil then
      for _, v in ipairs(tbNoteDrop) do
        table.insert(self.tbShowNote, v.SubNoteSkillId)
      end
    end
  end
  table.sort(self.tbShowNote, function(a, b)
    return a < b
  end)
  self.mapNoteNeed = {}
  if self.tbDisc ~= nil then
    for nIndex, nDiscId in ipairs(self.tbDisc) do
      if 3 < nIndex then
        break
      end
      local mapDiscData = PlayerData.Disc:GetDiscById(nDiscId)
      if mapDiscData ~= nil then
        local tbNeedNote = mapDiscData.tbSkillNeedNote
        for _, mapNeedNote in ipairs(tbNeedNote) do
          if self.mapNoteNeed[mapNeedNote.nId] == nil then
            self.mapNoteNeed[mapNeedNote.nId] = 0
          end
          self.mapNoteNeed[mapNeedNote.nId] = self.mapNoteNeed[mapNeedNote.nId] + mapNeedNote.nCount
        end
      end
    end
  end
  for k, v in ipairs(self._mapNode.imgNote) do
    local nNoteId = self.tbShowNote[k]
    v.gameObject:SetActive(nNoteId ~= nil)
    if nNoteId ~= nil then
      local mapNoteCfg = ConfigTable.GetData("SubNoteSkill", nNoteId)
      if nil ~= mapNoteCfg then
        local sIconPath = mapNoteCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small
        local nNoteNeed = self.mapNoteNeed[nNoteId]
        if nNoteNeed ~= nil and 0 < nNoteNeed then
          sIconPath = mapNoteCfg.Icon .. AllEnum.DiscSkillIconSurfix.S_Light
        end
        self:SetPngSprite(v, sIconPath)
      end
      local tmpCount = v.gameObject.transform:Find("txtNoteCount"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(tmpCount, self.tbNote[nNoteId] or 0)
    end
  end
  local tbOutFitId = {}
  for i = 1, 3 do
    if self.tbDisc[i] ~= nil then
      table.insert(tbOutFitId, self.tbDisc[i])
    end
  end
  self.tbShowInfo = {}
  local mapSkillId = {}
  for _, nNoteId in pairs(self.tbShowNote) do
    local tbSkill = PlayerData.Disc:GetDiscSkillByNoteCurrentLevel(tbOutFitId, self.tbNote, nNoteId)
    if tbSkill ~= nil then
      for k, mapData in pairs(tbSkill) do
        if mapSkillId[mapData.nId] ~= true then
          local mapSkillCfg = ConfigTable.GetData("SecondarySkill", mapData.nId)
          if mapSkillCfg ~= nil then
            local tbGroup = CacheTable.GetData("_SecondarySkill", mapSkillCfg.GroupId)
            local nMaxLevel = tbGroup ~= nil and #tbGroup or 1
            local nCurrentLevel = mapSkillCfg.Level or 1
            if nMaxLevel > nCurrentLevel then
              local tbNoteInfo = {}
              for nTid, nCount in pairs(mapData.tbNote) do
                table.insert(tbNoteInfo, {nTid, nCount})
              end
              table.insert(self.tbShowInfo, {
                nId = mapData.nId,
                tbNote = tbNoteInfo,
                nCurrentLevel = mapData.nCurLevel
              })
              mapSkillId[mapData.nId] = true
            end
          end
        end
      end
    end
  end
  if 0 < #self.tbShowInfo then
    self._mapNode.imgOutfitSkillBg:SetActive(true)
    self._mapNode.lstOutfitSkillInfo:Init(#self.tbShowInfo, self, self.OnDiscSkillInfoGridRefresh)
  else
    self._mapNode.imgOutfitSkillBg:SetActive(false)
  end
end

function NpcOptionCtrl:OnDiscSkillInfoGridRefresh(goGrid, nIdx)
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
      local nCurCount = self.tbNote[mapSkill.tbNote[i][1]] == nil and 0 or self.tbNote[mapSkill.tbNote[i][1]]
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

function NpcOptionCtrl:SetCoinActive(bActive)
  self._mapNode.imgCoinBg:SetActive(bActive)
end

function NpcOptionCtrl:OnDisable()
  for k, v in ipairs(self._mapNode.btnChoose) do
    v.onSelect:RemoveListener(self.handler[k])
  end
end

function NpcOptionCtrl:OnDestroy()
  EventManager.Hit("StarTowerSetButtonEnable", true, true)
end

function NpcOptionCtrl:OnRelease()
end

function NpcOptionCtrl:ClosePanel(bOnlyTalk, nSelectIdx, nEventId, bAuto)
  local function callback()
    GamepadUIManager.DisableGamepadUI("NpcOptionCtrl")
    
    PanelManager.InputEnable()
    if self.callback ~= nil and not bOnlyTalk then
      self.callback(nSelectIdx, nEventId, false, bAuto == true)
    end
    EventManager.Hit(EventId.ClosePanel, PanelId.NpcOptionPanel)
  end
  
  self._mapNode.animOutfitSkillBg:Play("imgOutfitSkillBg_out")
  if bOnlyTalk then
    self._mapNode.ainPanel:Play("NpcOptionTalk_out")
    EventManager.Hit(EventId.TemporaryBlockInput, 0.4, callback)
  else
    if self.nType == 1 then
      self._mapNode.ainPanel:Play("NpcOptionSelect_out")
    else
      self._mapNode.ainPanel:Play("NpcOptionSelectRed_out")
    end
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5, callback)
  end
end

function NpcOptionCtrl:OnBtn_Close()
  local function callback()
    GamepadUIManager.DisableGamepadUI("NpcOptionCtrl")
    
    PanelManager.InputEnable()
    if self.bSweep and self.callback ~= nil then
      self.callback(-1, -1, true)
    end
    EventManager.Hit(EventId.ClosePanel, PanelId.NpcOptionPanel)
  end
  
  self._mapNode.animOutfitSkillBg:Play("imgOutfitSkillBg_out")
  if self.nType == 1 then
    self._mapNode.ainPanel:Play("NpcOptionSelect_out")
  else
    self._mapNode.ainPanel:Play("NpcOptionSelectRed_out")
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5, callback)
end

function NpcOptionCtrl:OnBtn_Depot()
  self.bOpenDepot = true
  self.gameObject:SetActive(false)
  local nTog = self.bShowNote and AllEnum.StarTowerDepotTog.DiscSkill or AllEnum.StarTowerDepotTog.Potential
  EventManager.Hit(EventId.StarTowerDepot, nTog)
end

function NpcOptionCtrl:OnBtnClick_Select(btn)
  local nIdx = table.indexof(self._mapNode.btnChoose, btn)
  if table.indexof(self.bUnabledIdx, nIdx - 1) > 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_NPCOption_IllegalOption"))
    return
  end
  self:ClosePanel(false, nIdx, self.nEventId)
end

function NpcOptionCtrl:PreviewAutoSelect(nIndex)
  local btnChoose = self._mapNode.btnChoose[nIndex]
  if btnChoose == nil or not btnChoose.interactable then
    return false
  end
  local nReadyDelay = 0
  if self.bSelectTalk then
    nReadyDelay = self:OnBtnClick_Talk() or 0
  end
  for k, selectNode in ipairs(self._mapNode.Select) do
    selectNode:SetActive(k == nIndex)
  end
  self.nSelectIdx = nIndex
  GamepadUIManager.SetSelectedUI(btnChoose.gameObject)
  return true, nReadyDelay
end

function NpcOptionCtrl:SetAutoDisplay(mapAutoDisplay)
  if type(mapAutoDisplay) ~= "table" then
    return
  end
  self.mapAutoDisplay = mapAutoDisplay
  self._nAutoDisplaySerial = self._nAutoDisplaySerial + 1
  self:StartAutoDisplay(self._nAutoDisplaySerial)
end

function NpcOptionCtrl:StartAutoDisplay(nSerial)
  local mapAutoDisplay = self.mapAutoDisplay
  
  local function IsAutoDisplayEnabled()
    if nSerial ~= self._nAutoDisplaySerial then
      return false
    end
    return type(mapAutoDisplay.isEnabledCallback) ~= "function" or mapAutoDisplay.isEnabledCallback()
  end
  
  local function PreviewAndReady()
    if not IsAutoDisplayEnabled() then
      return
    end
    local bPreviewSuccess, nReadyDelay = self:PreviewAutoSelect(mapAutoDisplay.nTargetIndex)
    if not bPreviewSuccess or type(mapAutoDisplay.readyCallback) ~= "function" then
      return
    end
    
    local function Ready()
      if IsAutoDisplayEnabled() then
        mapAutoDisplay.readyCallback()
      end
    end
    
    if 0 < nReadyDelay then
      self:AddTimer(1, nReadyDelay, Ready, true, true, true)
    else
      Ready()
    end
  end
  
  if not self.bSelectTalk then
    PreviewAndReady()
    return
  end
  self:AddTimer(1, 2, function()
    if not IsAutoDisplayEnabled() then
      return
    end
    local nAnimLen = self.bSelectTalk and (self:OnBtnClick_Talk() or 0) or 0
    if 0 < nAnimLen then
      self:AddTimer(1, nAnimLen, PreviewAndReady, true, true, true)
    else
      PreviewAndReady()
    end
  end, true, true, true)
end

function NpcOptionCtrl:OnEvent_AutoDisplayEvent(nEventId, mapAutoDisplay)
  if self.bOnlyTalk or self.nEventId ~= nEventId then
    return
  end
  self:SetAutoDisplay(mapAutoDisplay)
end

function NpcOptionCtrl:OnEvent_AutoSelectEvent(nEventId, nIndex)
  if self.nEventId ~= nEventId or not self:PreviewAutoSelect(nIndex) then
    return
  end
  self:ClosePanel(false, nIndex, nEventId, true)
end

function NpcOptionCtrl:OnBtnSelect_Select(btn, nIndex)
  if self.nSelectIdx == nIndex then
    return
  end
  for k, v in ipairs(self._mapNode.Select) do
    if k == nIndex then
      if GamepadUIManager.GetCurUIType() ~= AllEnum.GamepadUIType.Other and GamepadUIManager.GetCurUIType() ~= AllEnum.GamepadUIType.Mouse then
        v:SetActive(true)
      else
        v:SetActive(false)
      end
    elseif k == self.nSelectIdx then
      v:SetActive(false)
    end
  end
  self.nSelectIdx = nIndex
end

function NpcOptionCtrl:OnBtnClick_NoteDetail()
  EventManager.Hit(EventId.OpenPanel, PanelId.NoteSkillInfo, self.tbNote)
end

function NpcOptionCtrl:OnBtnClick_Talk(btn)
  self.bSelectTalk = false
  if self.bOnlyTalk then
    self:ClosePanel(true)
    return
  end
  local nAnimLen = 0
  if self.nType == 1 then
    self._mapNode.ainPanel:Play("NpcOptionSelect_in")
    nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.ainPanel, {
      "NpcOptionSelect_in"
    })
  else
    self._mapNode.ainPanel:Play("NpcOptionSelectRed_in")
    nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.ainPanel, {
      "NpcOptionSelectRed_in"
    })
  end
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
  if self.nEventAction ~= 0 then
    local mapEventAction = ConfigTable.GetData("StarTowerEventAction", self.nEventAction)
    if mapEventAction ~= nil and mapEventAction.TrigVoice ~= "" then
      WwiseAudioMgr:WwiseVoice_PlayInAVG(mapEventAction.TrigVoice)
    end
  end
  WwiseAudioMgr:PlaySound("ui_roguelike_event_dialog")
  self._mapNode.BtnBg:SetActive(true)
  local mapEventCfg = ConfigTable.GetData("StarTowerEvent", self.nNoteEventId)
  if mapEventCfg ~= nil and mapEventCfg.EventResType == GameEnum.towerEventResType.SubNoteSkill then
    self:RefreshNoteList()
  end
  self:SetCoinActive(true)
  self:SelectChoose()
  return nAnimLen
end

function NpcOptionCtrl:LoadOffset(sPath)
  return self:LoadAsset(sPath, typeof(Offset))
end

function NpcOptionCtrl:OnEvent_SetCoin(nCount)
  if nCount then
    if nCount > self.nCoin then
      local twCoin = DOTween.To(function()
        return self.nCoin
      end, function(v)
        NovaAPI.SetTMPText(self._mapNode.txtCoinCount, self:ThousandsNumber(math.floor(v)))
      end, nCount, 1)
      
      local function _cb()
        self.nCoin = nCount
      end
      
      twCoin.onComplete = dotween_callback_handler(self, _cb)
    else
      NovaAPI.SetTMPText(self._mapNode.txtCoinCount, self:ThousandsNumber(nCount))
      self.nCoin = nCount
    end
  end
end

function NpcOptionCtrl:OnEvent_CloseStarTowerDepot()
  if self.bOpenDepot then
    self.bOpenDepot = false
    local nSelect = self.nSelectIdx ~= 0 and self.nSelectIdx or 1
    GamepadUIManager.SetSelectedUI(self._mapNode.btnChoose[nSelect].gameObject)
    self.gameObject:SetActive(true)
    if self.nType == 1 then
      self._mapNode.ainPanel:Play("NpcOptionSelect_in")
    else
      self._mapNode.ainPanel:Play("NpcOptionSelectRed_in")
    end
    WwiseAudioMgr:PlaySound("ui_roguelike_event_dialog")
    self._mapNode.BtnBg:SetActive(true)
    self:SetCoinActive(true)
    self:SelectChoose()
  end
end

function NpcOptionCtrl:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  if sName ~= "NpcOptionCtrl" then
    return
  end
  local bNeedSelect = nBeforeType == AllEnum.GamepadUIType.Other and nAfterType ~= AllEnum.GamepadUIType.Mouse or nBeforeType == AllEnum.GamepadUIType.Mouse and nAfterType ~= AllEnum.GamepadUIType.Other
  if bNeedSelect then
    if self.bSelectTalk then
      GamepadUIManager.SetSelectedUI(self._mapNode.btnShortcutTalk.gameObject)
    else
      for k, v in ipairs(self._mapNode.btnChoose) do
        if k == self.nSelectIdx then
          self._mapNode.Select[k]:SetActive(true)
          GamepadUIManager.SetSelectedUI(self._mapNode.btnChoose[self.nSelectIdx].gameObject)
        end
      end
    end
  else
    for k, v in ipairs(self._mapNode.btnChoose) do
      self._mapNode.Select[k]:SetActive(false)
    end
  end
end

function NpcOptionCtrl:OnEvent_Reopen(sName)
  if sName ~= "NpcOptionCtrl" then
    return
  end
  self:OnEvent_CloseStarTowerDepot()
end

function NpcOptionCtrl:SelectTalk()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    
    self._mapNode.animWaiting:SetTrigger("tManual")
  end
  
  cs_coroutine.start(wait)
  local tbConfig = {
    {
      sAction = "Confirm",
      sLang = "ActionBar_NextDialogue"
    }
  }
  self._mapNode.ActionBar:InitActionBar(tbConfig)
  self.bSelectTalk = true
  GamepadUIManager.SetSelectedUI(self._mapNode.btnShortcutTalk.gameObject)
end

function NpcOptionCtrl:SelectChoose()
  local tbConfig = {
    {
      sAction = "Confirm",
      sLang = "ActionBar_Confirm"
    },
    {
      sAction = "Depot",
      sLang = "ActionBar_Depot"
    },
    {
      sAction = "Back",
      sLang = "ActionBar_Back"
    }
  }
  self._mapNode.ActionBar:InitActionBar(tbConfig)
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType ~= AllEnum.GamepadUIType.Other and nUIType ~= AllEnum.GamepadUIType.Mouse then
    if self.nSelectIdx ~= 0 then
      self._mapNode.Select[self.nSelectIdx]:SetActive(true)
      GamepadUIManager.SetSelectedUI(self._mapNode.btnChoose[self.nSelectIdx].gameObject)
    end
  else
    for k, v in ipairs(self._mapNode.btnChoose) do
      self._mapNode.Select[k]:SetActive(false)
    end
  end
end

return NpcOptionCtrl

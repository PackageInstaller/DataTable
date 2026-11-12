local DiscSkillActiveCtrl = class("DiscSkillActiveCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local WwiseManger = CS.WwiseAudioManager.Instance
DiscSkillActiveCtrl._mapNodeConfig = {
  blurBg = {},
  contentRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  btnBg = {
    sComponentName = "Button",
    callback = "OnBtnClick_BtnBg"
  },
  btnShortcutBg = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_BtnBg",
    sAction = "Confirm"
  },
  cgSkillList = {
    sNodeName = "goSkillList",
    sComponentName = "CanvasGroup"
  },
  btnDepot = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Depot"
  },
  txtTitle = {sComponentName = "TMP_Text"},
  goAllNoteList = {},
  imgNote = {sComponentName = "Image", nCount = 9},
  goNoteList = {},
  noteListSv = {sComponentName = "ScrollRect"},
  goNoteItem = {},
  noteContent = {
    sComponentName = "RectTransform"
  },
  btnNoteList = {
    sComponentName = "Button",
    callback = "OnBtnClick_BtnBg"
  },
  goSkillList = {},
  skillListSv = {sComponentName = "ScrollRect"},
  goSkillItem = {},
  skillContent = {
    sComponentName = "RectTransform"
  },
  btnSkillList = {
    sComponentName = "Button",
    callback = "OnBtnClick_BtnBg"
  },
  goSkillCard = {},
  goNoteCardItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateDiscSkillCardCtrl"
  },
  ScrollView = {
    sComponentName = "GamepadScroll"
  },
  imgIconBgEffect = {sComponentName = "Image"},
  imgIconEffect = {sComponentName = "Image"},
  imgCornerBgEffect = {sComponentName = "Image"},
  txtTips = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  },
  txtClickPre = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Click_Pre"
  },
  txtClickSuf = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Click_Suf"
  },
  Tips = {
    sCtrlName = "Game.UI.StarTower.DiscTips.StarTowerTipsCtrl"
  }
}
DiscSkillActiveCtrl._mapEventConfig = {
  StarTowerShowDiscSkill = "OnEvent_ShowDiscSkillActive",
  OpenNoteDepot = "OnEvent_OpenNoteDepot",
  GamepadUIReopen = "OnEvent_Reopen",
  StarTowerDiscTips = "OnEvent_StarTowerDiscTips",
  StarTowerAutoAdvanceDiscSkill = "OnEvent_AutoAdvance"
}
DiscSkillActiveCtrl._mapRedDotConfig = {}
local panel_stage_note = 1
local panel_stage_skill = 2
local panel_stage_skill_upgrade = 3
local AUTO_ADVANCE_DELAY = 2

function DiscSkillActiveCtrl:InitNoteSkillList()
  for k, v in ipairs(self._mapNode.imgNote) do
    v.gameObject:SetActive(self._panel.tbShowNote[k] ~= nil)
    if self._panel.tbShowNote[k] ~= nil then
      local mapNoteCfg = ConfigTable.GetData("SubNoteSkill", self._panel.tbShowNote[k])
      if nil ~= mapNoteCfg then
        local sIconPath = mapNoteCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small
        local nNoteNeed = self._panel.mapNoteNeed[mapNoteCfg.Id]
        if nNoteNeed ~= nil and 0 < nNoteNeed then
          sIconPath = mapNoteCfg.Icon .. AllEnum.DiscSkillIconSurfix.S_Light
        end
        self:SetPngSprite(v, sIconPath)
      end
    end
  end
end

function DiscSkillActiveCtrl:ShowNoteList(tbParam, callback)
  self._mapNode.Tips.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtTitle, ConfigTable.GetUIText("StarTower_Disc_Skill_Active_1"))
  self._panel:SetTop(self.canvas)
  local bCloseCamera = false
  if not self.bOpen then
    PanelManager.InputDisable()
    bCloseCamera = true
    GamepadUIManager.EnableGamepadUI("DiscSkillActiveCtrl", self.tbGamepadUINode)
  end
  self.bOpen = true
  EventManager.Hit("StarTowerSetButtonEnable", false, false)
  self.callback = callback
  self._mapNode.blurBg.gameObject:SetActive(true)
  self._mapNode.btnBg.gameObject:SetActive(true)
  self._mapNode.contentRoot.gameObject:SetActive(false)
  EventManager.Hit(EventId.BlockInput, true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit(EventId.BlockInput, false)
    if bCloseCamera then
      CS.GameCameraStackManager.Instance:CloseMainCamera(0.1)
    end
    self._mapNode.contentRoot.gameObject:SetActive(true)
    self._mapNode.goNoteList.gameObject:SetActive(true)
    self._mapNode.goSkillList.gameObject:SetActive(false)
    self._mapNode.goSkillCard.gameObject:SetActive(false)
    self.nPanelStage = panel_stage_note
    self:RefreshAllNoteList(tbParam.tbNoteChange)
    self:RefreshNoteSkill(tbParam.tbNoteChange)
    NovaAPI.SetVerticalNormalizedPosition(self._mapNode.noteListSv, 1)
    NovaAPI.SetVerticalNormalizedPosition(self._mapNode.skillListSv, 1)
    WwiseManger:PlaySound("ui_roguelike_phonograph_mus")
  end
  
  cs_coroutine.start(wait)
end

function DiscSkillActiveCtrl:RefreshAllNoteList(tbNoteChange)
  for k, v in ipairs(self._mapNode.imgNote) do
    local nNoteId = self._panel.tbShowNote[k]
    v.gameObject:SetActive(nNoteId ~= nil)
    if nNoteId ~= nil then
      local tmpCount = v.gameObject.transform:Find("txtNoteCount"):GetComponent("TMP_Text")
      local imgArrow = v.gameObject.transform:Find("imgArrow")
      NovaAPI.SetTMPText(tmpCount, self.tbNoteList[nNoteId] or 0)
      imgArrow.gameObject:SetActive(tbNoteChange[nNoteId] ~= nil)
    end
  end
end

function DiscSkillActiveCtrl:RefreshNoteSkill(tbNoteChange)
  local tbNoteSkill = {}
  for nId, v in pairs(tbNoteChange) do
    table.insert(tbNoteSkill, {
      nNoteId = nId,
      nCount = v.nCount,
      bLucky = v.bLucky
    })
  end
  table.sort(tbNoteSkill, function(a, b)
    return a.nNoteId < b.nNoteId
  end)
  for _, v in ipairs(self.tbNoteSkillItemCtrl) do
    v.gameObject:SetActive(false)
  end
  local tbCtrl = {}
  for k, v in ipairs(tbNoteSkill) do
    local objCtrl = self.tbNoteSkillItemCtrl[k]
    if objCtrl == nil then
      local objItem = instantiate(self._mapNode.goNoteItem, self._mapNode.noteContent)
      objCtrl = self:BindCtrlByNode(objItem, "Game.UI.StarTower.DiscTips.DiscNoteSkillItemCtrl")
      table.insert(self.tbNoteSkillItemCtrl, objCtrl)
    end
    objCtrl.gameObject:SetActive(false)
    local nCurLevel = self.tbNoteList[v.nNoteId] or 0
    objCtrl:SetSkillItem(v.nNoteId, nCurLevel, nCurLevel - v.nCount, v.bLucky)
    table.insert(tbCtrl, objCtrl)
  end
  local nIndex = 1
  if 0 < #tbCtrl then
    EventManager.Hit(EventId.BlockInput, true)
    self:AddTimer(#tbCtrl, 0.08, function()
      local objCtrl = tbCtrl[nIndex]
      nIndex = nIndex + 1
      if objCtrl ~= nil then
        objCtrl.gameObject:SetActive(true)
      end
      if nIndex > #tbCtrl then
        EventManager.Hit(EventId.BlockInput, false)
        self._mapNode.txtTips[1].gameObject:SetActive(true)
        self._mapNode.txtTips[2].gameObject:SetActive(true)
        EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_OpenDiscSkillActive")
        self:TryAutoAdvance()
      end
    end, true, true, true)
  else
    EventManager.Hit(EventId.BlockInput, false)
    self:TryAutoAdvance()
  end
  self._mapNode.txtTips[1].gameObject:SetActive(false)
  self._mapNode.txtTips[2].gameObject:SetActive(false)
end

function DiscSkillActiveCtrl:RefreshDiscSkill(tbSkillList)
  WwiseManger:PlaySound("ui_roguelike_phonograph_mus")
  self._mapNode.goNoteList.gameObject:SetActive(false)
  self._mapNode.goSkillList.gameObject:SetActive(true)
  self._mapNode.goSkillCard.gameObject:SetActive(false)
  local tbCtrl = {}
  if tbSkillList ~= nil then
    for _, v in ipairs(self.tbSkillItemCtrl) do
      v.gameObject:SetActive(false)
    end
    for k, v in ipairs(tbSkillList) do
      local objCtrl = self.tbSkillItemCtrl[k]
      if objCtrl == nil then
        local objItem = instantiate(self._mapNode.goSkillItem, self._mapNode.skillContent)
        objCtrl = self:BindCtrlByNode(objItem, "Game.UI.StarTower.DiscTips.DiscSkillItemCtrl")
        table.insert(self.tbSkillItemCtrl, objCtrl)
      end
      objCtrl.gameObject:SetActive(false)
      objCtrl:SetSkillItem(v.nSkillId, v.tbChangeNote, self.tbNoteList, v.bActive)
      table.insert(tbCtrl, objCtrl)
    end
  end
  local nIndex = 1
  if 0 < #tbCtrl then
    EventManager.Hit(EventId.BlockInput, true)
    self:AddTimer(#tbCtrl, 0.08, function()
      local objCtrl = tbCtrl[nIndex]
      nIndex = nIndex + 1
      if objCtrl ~= nil then
        objCtrl.gameObject:SetActive(true)
        objCtrl:PlayAnim()
      end
      if nIndex > #tbCtrl then
        EventManager.Hit(EventId.BlockInput, false)
        self._mapNode.txtTips[1].gameObject:SetActive(true)
        self._mapNode.txtTips[2].gameObject:SetActive(true)
        self:TryAutoAdvance()
      end
    end, true, true, true)
    self._mapNode.txtTips[1].gameObject:SetActive(false)
    self._mapNode.txtTips[2].gameObject:SetActive(false)
  else
    self:TryAutoAdvance()
  end
end

function DiscSkillActiveCtrl:ShowDiscUpgradeCard()
  self._mapNode.txtTips[1].gameObject:SetActive(false)
  self._mapNode.txtTips[2].gameObject:SetActive(false)
  self._mapNode.animRoot:Play("DiscSkillActive_Card", 0, 0)
  local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
    "DiscSkillActive_Card"
  })
  self:AddTimer(1, nAnimLen, function()
    self._mapNode.txtTips[1].gameObject:SetActive(true)
    self._mapNode.txtTips[2].gameObject:SetActive(true)
    self:TryAutoAdvance()
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
  WwiseManger:PlaySound("ui_roguelike_outfit_select")
  NovaAPI.SetTMPText(self._mapNode.txtTitle, ConfigTable.GetUIText("StarTower_Disc_Skill_Active_2"))
  self._mapNode.goSkillCard.gameObject:SetActive(true)
  self._mapNode.goNoteList.gameObject:SetActive(false)
  self._mapNode.goSkillList.gameObject:SetActive(false)
  local mapData = table.remove(self.tbSkillActive, 1)
  if mapData ~= nil then
    self.nSkillId = mapData.nSkillId
    self._mapNode.goNoteCardItem:Refresh(mapData.nDiscId, nil, self.nSkillId)
    self._mapNode.goNoteCardItem:ChangeWordRaycast(true)
    NovaAPI.SetComponentEnable(self._mapNode.ScrollView, true)
    local mapSkillCfg = ConfigTable.GetData("SecondarySkill", self.nSkillId)
    if mapSkillCfg ~= nil then
      self:SetPngSprite(self._mapNode.imgIconEffect, mapSkillCfg.Icon)
      self:SetPngSprite(self._mapNode.imgIconBgEffect, mapSkillCfg.IconBg)
    end
  end
end

function DiscSkillActiveCtrl:HidePanel()
  self.bOpen = false
  self._bAutoAdvance = false
  self._bAutoAdvanceScheduled = false
  GamepadUIManager.DisableGamepadUI("DiscSkillActiveCtrl")
  EventManager.Hit("StarTowerSetButtonEnable", true, true)
  PanelManager.InputEnable()
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  self._mapNode.btnBg.gameObject:SetActive(false)
  NovaAPI.SetCanvasSortingOrder(self.canvas, self.nInitSortingOrder)
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  if nil ~= self.callback then
    self.callback()
  end
end

function DiscSkillActiveCtrl:ReopenPanel()
  EventManager.Hit("StarTowerSetButtonEnable", false, false)
  self._mapNode.blurBg.gameObject:SetActive(true)
  self._mapNode.btnBg.gameObject:SetActive(true)
  EventManager.Hit(EventId.BlockInput, true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit(EventId.BlockInput, false)
    CS.GameCameraStackManager.Instance:CloseMainCamera(0.1)
    self._mapNode.contentRoot.gameObject:SetActive(true)
  end
  
  cs_coroutine.start(wait)
end

function DiscSkillActiveCtrl:Awake()
  self.nType = 0
  self.bOpen = false
  self.tbNoteSkillItemCtrl = {}
  self.tbSkillItemCtrl = {}
  self.canvas = self.gameObject:GetComponent("Canvas")
  self.nInitSortingOrder = NovaAPI.GetCanvasSortingOrder(self.canvas)
  self._mapNode.blurBg.gameObject:SetActive(false)
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.btnBg.gameObject:SetActive(false)
  self._mapNode.goSkillItem.gameObject:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function DiscSkillActiveCtrl:OnEnable()
  self.nPanelStage = 0
  self:InitNoteSkillList()
end

function DiscSkillActiveCtrl:OnDisable()
  for _, v in ipairs(self.tbNoteSkillItemCtrl) do
    self:UnbindCtrlByNode(v)
  end
  self.tbNoteSkillItemCtrl = {}
  for _, v in ipairs(self.tbSkillItemCtrl) do
    self:UnbindCtrlByNode(v)
  end
  self.tbSkillItemCtrl = {}
end

function DiscSkillActiveCtrl:TryAutoAdvance()
  if not self._bAutoAdvance or self._bAutoAdvanceScheduled or not self.bOpen then
    return
  end
  if self._isAutoEnabledCallback ~= nil and not self._isAutoEnabledCallback() then
    self._bAutoAdvance = false
    return
  end
  self._bAutoAdvanceScheduled = true
  local nSerial = self._nAutoAdvanceSerial or 0
  self:AddTimer(1, AUTO_ADVANCE_DELAY, function()
    self._bAutoAdvanceScheduled = false
    if nSerial == (self._nAutoAdvanceSerial or 0) and self._bAutoAdvance and self.bOpen and (self._isAutoEnabledCallback == nil or self._isAutoEnabledCallback()) then
      self:OnBtnClick_BtnBg()
    end
  end, true, true, true)
end

function DiscSkillActiveCtrl:OnEvent_AutoAdvance(callback, isAutoEnabledCallback)
  if not self.bOpen or self.callback ~= callback then
    return
  end
  self._bAutoAdvance = true
  self._isAutoEnabledCallback = isAutoEnabledCallback
end

function DiscSkillActiveCtrl:OnBtnClick_BtnBg()
  self._nAutoAdvanceSerial = (self._nAutoAdvanceSerial or 0) + 1
  self._bAutoAdvanceScheduled = false
  if self.nPanelStage == panel_stage_note then
    if self.tbParam.tbSkill ~= nil and next(self.tbParam.tbSkill) ~= nil then
      self.nPanelStage = panel_stage_skill
      self:RefreshDiscSkill(self.tbParam.tbSkill)
      return
    else
      self.nPanelStage = 0
    end
  elseif self.nPanelStage == panel_stage_skill then
    if 0 < #self.tbSkillActive then
      self.nPanelStage = panel_stage_skill_upgrade
      self:ShowDiscUpgradeCard()
      return
    else
      self.nPanelStage = 0
    end
  elseif self.nPanelStage == panel_stage_skill_upgrade then
    if #self.tbSkillActive == 0 then
      self.nPanelStage = 0
    else
      self:ShowDiscUpgradeCard()
      return
    end
  end
  if self.nPanelStage == 0 then
    self:HidePanel()
  end
end

function DiscSkillActiveCtrl:OnBtnClick_Depot()
  self.bDepotOpen = true
  EventManager.Hit("StarTowerSetButtonEnable", false, false)
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  self._mapNode.btnBg.gameObject:SetActive(false)
  EventManager.Hit(EventId.StarTowerDepot, AllEnum.StarTowerDepotTog.DiscSkill)
end

function DiscSkillActiveCtrl:OnEvent_ShowDiscSkillActive(tbParam, tbNoteList, callback)
  self.tbParam = tbParam
  self.tbNoteList = tbNoteList
  self.tbSkillActive = tbParam.tbDiscSkillAct
  self:ShowNoteList(tbParam, callback)
end

function DiscSkillActiveCtrl:OnEvent_StarTowerDiscTips(tbTips)
  self._mapNode.Tips.gameObject:SetActive(true)
  self._mapNode.Tips:StartShowTips(tbTips)
end

function DiscSkillActiveCtrl:OnEvent_OpenNoteDepot()
  if self._mapNode.contentRoot.gameObject.activeSelf == false then
    return
  end
  self.bDepotOpen = true
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  self._mapNode.btnBg.gameObject:SetActive(false)
end

function DiscSkillActiveCtrl:OnEvent_Reopen(sName)
  if sName ~= "DiscSkillActiveCtrl" then
    return
  end
  if self.bDepotOpen then
    self.bDepotOpen = false
    self:ReopenPanel()
  end
end

return DiscSkillActiveCtrl

local TutorialDiscSkillActiveCtrl = class("TutorialDiscSkillActiveCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local WwiseManger = CS.WwiseAudioManager.Instance
TutorialDiscSkillActiveCtrl._mapNodeConfig = {
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
  goNoteItem = {},
  noteContent = {
    sComponentName = "RectTransform"
  },
  btnNoteList = {
    sComponentName = "Button",
    callback = "OnBtnClick_BtnBg"
  },
  goSkillList = {},
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
TutorialDiscSkillActiveCtrl._mapEventConfig = {
  StarTowerShowDiscSkill = "OnEvent_ShowDiscSkillActive",
  OpenNoteDepot = "OnEvent_OpenNoteDepot",
  GamepadUIReopen = "OnEvent_Reopen",
  StarTowerDiscTips = "OnEvent_StarTowerDiscTips"
}
TutorialDiscSkillActiveCtrl._mapRedDotConfig = {}
local panel_stage_note = 1
local panel_stage_skill = 2
local panel_stage_skill_upgrade = 3

function TutorialDiscSkillActiveCtrl:InitNoteSkillList(tbNoteList)
  if self.tbShowNote == nil then
    self.tbShowNote = {}
    for id, _ in pairs(tbNoteList) do
      table.insert(self.tbShowNote, id)
    end
    table.sort(self.tbShowNote, function(a, b)
      return a < b
    end)
    for k, v in ipairs(self._mapNode.imgNote) do
      v.gameObject:SetActive(self.tbShowNote[k] ~= nil)
      if self.tbShowNote[k] ~= nil then
        local mapNoteCfg = ConfigTable.GetData("SubNoteSkill", self.tbShowNote[k])
        if nil ~= mapNoteCfg then
          self:SetPngSprite(v, mapNoteCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
        end
      end
    end
  end
end

function TutorialDiscSkillActiveCtrl:ShowNoteList(tbParam, callback)
  self._mapNode.Tips.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtTitle, ConfigTable.GetUIText("StarTower_Disc_Skill_Active_1"))
  self._panel:SetTop(self.canvas)
  local bCloseCamera = false
  if not self.bOpen then
    PanelManager.InputDisable()
    bCloseCamera = true
    GamepadUIManager.EnableGamepadUI("TutorialDiscSkillActiveCtrl", self.tbGamepadUINode)
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
    WwiseManger:PlaySound("ui_roguelike_phonograph_mus")
  end
  
  cs_coroutine.start(wait)
end

function TutorialDiscSkillActiveCtrl:RefreshAllNoteList(tbNoteChange)
  for k, v in ipairs(self._mapNode.imgNote) do
    local nNoteId = self.tbShowNote[k]
    v.gameObject:SetActive(nNoteId ~= nil)
    if nNoteId ~= nil then
      local tmpCount = v.gameObject.transform:Find("txtNoteCount"):GetComponent("TMP_Text")
      local imgArrow = v.gameObject.transform:Find("imgArrow")
      NovaAPI.SetTMPText(tmpCount, self.tbNoteList[nNoteId] or 0)
      imgArrow.gameObject:SetActive(tbNoteChange[nNoteId] ~= nil)
    end
  end
end

function TutorialDiscSkillActiveCtrl:RefreshNoteSkill(tbNoteChange)
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
        EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_OpenDiscSkillActive_Tutorial")
      end
    end, true, true, true)
  else
    EventManager.Hit(EventId.BlockInput, false)
  end
  self._mapNode.txtTips[1].gameObject:SetActive(false)
  self._mapNode.txtTips[2].gameObject:SetActive(false)
end

function TutorialDiscSkillActiveCtrl:RefreshDiscSkill(tbSkillList)
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
      objCtrl:SetSkillItem(v.nSkillId, v.tbChangeNote, self.tbNoteList)
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
      end
    end, true, true, true)
    self._mapNode.txtTips[1].gameObject:SetActive(false)
    self._mapNode.txtTips[2].gameObject:SetActive(false)
  end
end

function TutorialDiscSkillActiveCtrl:ShowDiscUpgradeCard()
  self._mapNode.txtTips[1].gameObject:SetActive(false)
  self._mapNode.txtTips[2].gameObject:SetActive(false)
  self._mapNode.animRoot:Play("DiscSkillActive_Card", 0, 0)
  local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
    "DiscSkillActive_Card"
  })
  self:AddTimer(1, nAnimLen, function()
    self._mapNode.txtTips[1].gameObject:SetActive(true)
    self._mapNode.txtTips[2].gameObject:SetActive(true)
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
    local mapSkillCfg = ConfigTable.GetData("SecondarySkill", self.nSkillId)
    if mapSkillCfg ~= nil then
      self:SetPngSprite(self._mapNode.imgIconEffect, mapSkillCfg.Icon)
      self:SetPngSprite(self._mapNode.imgIconBgEffect, mapSkillCfg.IconBg)
      EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_OpenStarTowerDepot_Tutorial")
    end
  end
end

function TutorialDiscSkillActiveCtrl:HidePanel()
  self.bOpen = false
  GamepadUIManager.DisableGamepadUI("TutorialDiscSkillActiveCtrl")
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
  CS.AdventureModuleHelper.ResumeLogic()
  PanelManager.InputEnable()
end

function TutorialDiscSkillActiveCtrl:ReopenPanel()
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

function TutorialDiscSkillActiveCtrl:Awake()
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
  self._mapNode.btnDepot.gameObject:SetActive(false)
end

function TutorialDiscSkillActiveCtrl:OnEnable()
  self.nPanelStage = 0
end

function TutorialDiscSkillActiveCtrl:OnDisable()
  for _, v in ipairs(self.tbNoteSkillItemCtrl) do
    self:UnbindCtrlByNode(v)
  end
  self.tbNoteSkillItemCtrl = {}
  for _, v in ipairs(self.tbSkillItemCtrl) do
    self:UnbindCtrlByNode(v)
  end
  self.tbSkillItemCtrl = {}
end

function TutorialDiscSkillActiveCtrl:OnBtnClick_BtnBg()
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

function TutorialDiscSkillActiveCtrl:OnBtnClick_Depot()
  self.bDepotOpen = true
  EventManager.Hit("StarTowerSetButtonEnable", false, false)
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  self._mapNode.btnBg.gameObject:SetActive(false)
  EventManager.Hit(EventId.StarTowerDepot, AllEnum.StarTowerDepotTog.DiscSkill)
end

function TutorialDiscSkillActiveCtrl:OnEvent_ShowDiscSkillActive(tbParam, tbNoteList, callback)
  CS.AdventureModuleHelper.PauseLogic()
  PanelManager.InputDisable()
  self:InitNoteSkillList(tbNoteList)
  self.tbParam = tbParam
  self.tbNoteList = tbNoteList
  self.tbSkillActive = tbParam.tbDiscSkillAct
  self:ShowNoteList(tbParam, callback)
end

function TutorialDiscSkillActiveCtrl:OnEvent_StarTowerDiscTips(tbTips)
  self._mapNode.Tips.gameObject:SetActive(true)
  self._mapNode.Tips:StartShowTips(tbTips)
end

function TutorialDiscSkillActiveCtrl:OnEvent_OpenNoteDepot()
  if self._mapNode.contentRoot.gameObject.activeSelf == false then
    return
  end
  self.bDepotOpen = true
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  self._mapNode.btnBg.gameObject:SetActive(false)
end

function TutorialDiscSkillActiveCtrl:OnEvent_Reopen(sName)
  if sName ~= "TutorialDiscSkillActiveCtrl" then
    return
  end
  if self.bDepotOpen then
    self.bDepotOpen = false
    self:ReopenPanel()
  end
end

return TutorialDiscSkillActiveCtrl

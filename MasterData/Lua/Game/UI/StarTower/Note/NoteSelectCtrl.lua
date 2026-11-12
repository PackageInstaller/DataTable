local NoteSelectCtrl = class("NoteSelectCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
NoteSelectCtrl._mapNodeConfig = {
  blurBg = {},
  contentRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  btnDepot = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Depot"
  },
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Note_Select_Title"
  },
  btnNote = {
    sComponentName = "NaviButton",
    nCount = 3,
    callback = "OnBtnClick_Note"
  },
  rtBtnNote = {
    sNodeName = "btnNote",
    sComponentName = "RectTransform",
    nCount = 3
  },
  noteCardItem = {
    nCount = 3,
    sNodeName = "btnNote",
    sCtrlName = "Game.UI.StarTower.Note.NoteCardItemCtrl"
  },
  btnConfirm = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Confirm",
    sAction = "Confirm"
  },
  txtBtnConfirm = {
    nCount = 3,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Note_Select_Confirm"
  },
  rtBtnConfirm = {
    sNodeName = "btnConfirm",
    sComponentName = "RectTransform"
  }
}
NoteSelectCtrl._mapEventConfig = {
  StarTowerSelectNote = "OnEvent_StarTowerSelectNote",
  GamepadUIChange = "OnEvent_GamepadUIChange",
  OpenNoteDepot = "OnEvent_OpenNoteDepot",
  GamepadUIReopen = "OnEvent_Reopen"
}
NoteSelectCtrl._mapRedDotConfig = {}
local card_item_pos = {
  [1] = {3},
  [2] = {-352, 352},
  [3] = {
    -552,
    3,
    557
  }
}

function NoteSelectCtrl:Refresh(nEventId, tbNoteList, mapNoteSelect)
  self._mapNode.btnConfirm.gameObject:SetActive(false)
  if mapNoteSelect == nil or #mapNoteSelect == 0 then
    printError("音符选择列表为空！！！")
    return
  end
  self.nEventId = nEventId
  self.nSelectIdx = 0
  self:RefreshNoteSelect(mapNoteSelect)
end

function NoteSelectCtrl:RefreshNoteSelect(mapNoteSelect)
  self.tbNoteSelect = mapNoteSelect
  local tbBtnObj = {}
  local posCfg = card_item_pos[#mapNoteSelect]
  for k, v in ipairs(self._mapNode.noteCardItem) do
    self._mapNode.btnNote[k].gameObject:SetActive(self.tbNoteSelect[k] ~= nil)
    if self.tbNoteSelect[k] ~= nil then
      local posY = self._mapNode.rtBtnNote[k].anchoredPosition.y
      self._mapNode.rtBtnNote[k].anchoredPosition = Vector2(posCfg[k], posY)
      v:SetNoteCardItem(self.tbNoteSelect[k].Idx, self.tbNoteSelect[k].List, self.tbShowNote)
      table.insert(tbBtnObj, self._mapNode.btnNote[k])
    end
  end
  self:ResetSelect(tbBtnObj)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
  WwiseAudioMgr:PlaySound("ui_roguelike_phonograph_pop")
end

function NoteSelectCtrl:RefreshNoteList(tbNoteList)
  self.tbNoteList = clone(tbNoteList)
  for k, v in ipairs(self._mapNode.goNoteItem) do
    local nNoteId = self.tbShowNote[k]
    local nCount = self.tbNoteList[nNoteId] or 0
    v:Init(nCount)
  end
end

function NoteSelectCtrl:ResetNoteFx()
  for k, v in ipairs(self._mapNode.goNoteItem) do
    v:ResetNoteFx()
  end
end

function NoteSelectCtrl:SelectComplete(nEventId, tbNoteList, mapNoteSelect)
  if nEventId == nil or nEventId == 0 then
    EventManager.Hit(EventId.BlockInput, true)
    EventManager.Hit("StarTowerSetButtonEnable", true, false)
    for _, v in ipairs(self._mapNode.noteCardItem) do
      v:PlayAnim("NoteCard_out")
    end
    local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
      "NoteSelect_out"
    })
    self._mapNode.animRoot:Play("NoteSelect_out")
    self:AddTimer(1, nAnimLen, function()
      EventManager.Hit(EventId.BlockInput, false)
      self:HidePanel()
      if nil ~= self.callback then
        self.callback(-1, nEventId)
      end
    end, true, true, true, nil)
  else
    EventManager.Hit(EventId.BlockInput, true)
    local nAnimLen = 0
    for _, v in ipairs(self._mapNode.noteCardItem) do
      nAnimLen = v:PlayAnim("NoteCard_out")
    end
    self:AddTimer(1, nAnimLen, function()
      EventManager.Hit(EventId.BlockInput, false)
      self:Refresh(nEventId, tbNoteList, mapNoteSelect)
    end, true, true, true, nil)
  end
end

function NoteSelectCtrl:MoveConfirmButton(btnCard)
  local rtBtn = btnCard:GetComponent("RectTransform")
  self._mapNode.rtBtnConfirm.anchoredPosition = Vector2(rtBtn.anchoredPosition.x, self.btnConfirmPosY)
  if self._mapNode.btnConfirm.gameObject.activeSelf == false then
    self._mapNode.btnConfirm.gameObject:SetActive(true)
  else
    local animCtrl = self._mapNode.btnConfirm.transform:Find("AnimRoot"):GetComponent("Animator")
    animCtrl:Play("btnConfirm_in", 0, 0)
  end
end

function NoteSelectCtrl:ReopenPanel()
  EventManager.Hit("StarTowerSetButtonEnable", false, false)
  EventManager.Hit("SetStarTowerNoteTop", true)
  self._mapNode.blurBg.gameObject:SetActive(true)
  local nSelect = self.nSelectIdx ~= 0 and self.nSelectIdx or 1
  GamepadUIManager.SetSelectedUI(self._mapNode.btnNote[nSelect].gameObject)
  EventManager.Hit(EventId.BlockInput, true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit(EventId.BlockInput, false)
    CS.GameCameraStackManager.Instance:CloseMainCamera(0.1)
    self._mapNode.contentRoot.gameObject:SetActive(true)
    if self.nSelectIdx == 0 and GamepadUIManager.GetCurUIType() ~= AllEnum.GamepadUIType.Other then
      self.nSelectIdx = 1
      self:MoveConfirmButton(self._mapNode.btnNote[self.nSelectIdx])
    end
    if self.nSelectIdx ~= 0 then
      local cardItem = self._mapNode.noteCardItem[self.nSelectIdx]
      cardItem:PlayAnim("NoteCard_select")
    end
  end
  
  cs_coroutine.start(wait)
end

function NoteSelectCtrl:HidePanel()
  self.bOpen = false
  PanelManager.InputEnable()
  EventManager.Hit("StarTowerSetButtonEnable", true, true)
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  NovaAPI.SetCanvasSortingOrder(self.canvas, self.nInitSortingOrder)
  EventManager.Hit("SetStarTowerNoteTop", false)
  GamepadUIManager.DisableGamepadUI("NoteSelectCtrl")
end

function NoteSelectCtrl:Awake()
  self.bOpen = false
  self.canvas = self.gameObject:GetComponent("Canvas")
  self.nInitSortingOrder = NovaAPI.GetCanvasSortingOrder(self.canvas)
  self.btnConfirmPosY = self._mapNode.rtBtnConfirm.anchoredPosition.y
  self.tbShowNote = {}
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function NoteSelectCtrl:OnEnable()
  self.handler = {}
  for k, v in ipairs(self._mapNode.btnNote) do
    self.handler[k] = ui_handler(self, self.OnBtnClick_Note, v, k)
    v.onSelect:AddListener(self.handler[k])
  end
end

function NoteSelectCtrl:OnDisable()
  for k, v in ipairs(self._mapNode.btnNote) do
    v.onSelect:RemoveListener(self.handler[k])
  end
end

function NoteSelectCtrl:OnBtnClick_Depot()
  EventManager.Hit("StarTowerSetButtonEnable", false, false)
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
  EventManager.Hit(EventId.StarTowerDepot, AllEnum.StarTowerDepotTog.Note)
end

function NoteSelectCtrl:OnBtnClick_Confirm()
  if self.nSelectIdx ~= 0 and self.callback ~= nil then
    local cardItem = self._mapNode.noteCardItem[self.nSelectIdx]
    local nAnimLen = cardItem:PlayAnim("NoteCard_give")
    self:AddTimer(1, nAnimLen, function()
      local function completeFunc(nEventId, tbNoteList, mapNoteSelect)
        EventManager.Hit(EventId.BlockInput, false)
        
        self:SelectComplete(nEventId, tbNoteList, mapNoteSelect)
      end
      
      self.callback(self.nSelectIdx, self.nEventId, completeFunc)
    end, true, true, true, nil)
    EventManager.Hit(EventId.BlockInput, true)
    self._mapNode.btnConfirm.gameObject:SetActive(false)
    WwiseAudioMgr:PlaySound("ui_roguelike_phonograph_confirm")
  end
end

function NoteSelectCtrl:OnBtnClick_Note(btn, nIndex)
  if nil == self.tbNoteSelect[nIndex] or nIndex == self.nSelectIdx then
    return
  end
  WwiseAudioMgr:PlaySound("ui_roguelike_xintiao_slide")
  self:MoveConfirmButton(btn)
  if self.nSelectIdx ~= 0 then
    local lastItem = self._mapNode.noteCardItem[self.nSelectIdx]
    lastItem:PlayAnim("NoteCard_unselect")
  end
  local cardItem = self._mapNode.noteCardItem[nIndex]
  cardItem:PlayAnim("NoteCard_select")
  self.nSelectIdx = nIndex
end

function NoteSelectCtrl:OnEvent_RefreshNoteCount(tbNoteList)
  if self._mapNode.contentRoot.gameObject.activeSelf == false or self.tbNoteList == nil then
    return
  end
  local tbChange = {}
  for k, v in pairs(tbNoteList) do
    if v ~= self.tbNoteList[k] then
      tbChange[k] = v - self.tbNoteList[k]
    end
  end
  for k, v in ipairs(self._mapNode.goNoteItem) do
    local nNoteId = self.tbShowNote[k]
    local nCount = tbChange[nNoteId] or 0
    if 0 < nCount then
      v:PlayChangeAnim()
    end
  end
  if next(tbChange) ~= nil then
    self._mapNode.animNoteLine:Play("Noteline_burst", 0, 0)
  end
end

function NoteSelectCtrl:OnEvent_StarTowerSelectNote(nEventId, tbNoteList, mapNoteSelect, callback)
  self._panel:SetTop(self.canvas)
  local bCloseCamera = false
  if not self.bOpen then
    PanelManager.InputDisable()
    bCloseCamera = true
    GamepadUIManager.EnableGamepadUI("NoteSelectCtrl", self.tbGamepadUINode)
  end
  self.bOpen = true
  EventManager.Hit("StarTowerSetButtonEnable", false, false)
  EventManager.Hit("SetStarTowerNoteTop", true)
  self.nSelectIdx = 0
  self.tbNoteSelect = {}
  self.callback = callback
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(true)
  EventManager.Hit(EventId.BlockInput, true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit(EventId.BlockInput, false)
    if bCloseCamera then
      CS.GameCameraStackManager.Instance:CloseMainCamera(0.1)
    end
    self._mapNode.contentRoot.gameObject:SetActive(true)
    self._mapNode.animRoot:Play("NoteSelect_in")
    self:Refresh(nEventId, tbNoteList, mapNoteSelect)
  end
  
  cs_coroutine.start(wait)
end

function NoteSelectCtrl:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  if sName ~= "NoteSelectCtrl" then
    return
  end
  if nBeforeType == AllEnum.GamepadUIType.Other or nBeforeType == AllEnum.GamepadUIType.Mouse then
    local nSelect = self.nSelectIdx ~= 0 and self.nSelectIdx or 1
    GamepadUIManager.SetSelectedUI(self._mapNode.btnNote[nSelect].gameObject)
  end
end

function NoteSelectCtrl:OnEvent_Reopen(sName)
  if sName ~= "NoteSelectCtrl" then
    return
  end
  self:ReopenPanel()
end

function NoteSelectCtrl:ResetSelect(tbUI)
  GamepadUIManager.SetNavigation(tbUI)
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType ~= AllEnum.GamepadUIType.Other then
    local animTime = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
      "NoteSelect_in"
    })
    self:AddTimer(1, animTime, function()
      self.nSelectIdx = 1
      self:MoveConfirmButton(self._mapNode.btnNote[self.nSelectIdx])
      self._mapNode.noteCardItem[self.nSelectIdx]:PlayAnim("NoteCard_select")
      GamepadUIManager.SetSelectedUI(self._mapNode.btnNote[self.nSelectIdx].gameObject)
    end, true, true, true)
  end
end

function NoteSelectCtrl:OnEvent_OpenNoteDepot()
  if self._mapNode.contentRoot.gameObject.activeSelf == false then
    return
  end
  self.bNoteDepotOpen = true
  CS.GameCameraStackManager.Instance:OpenMainCamera()
  self._mapNode.contentRoot.gameObject:SetActive(false)
  self._mapNode.blurBg.gameObject:SetActive(false)
end

return NoteSelectCtrl

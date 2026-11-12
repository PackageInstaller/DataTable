local Actor2DEditorCtrl = class("Actor2DEditorCtrl", BaseCtrl)
local PanelDefine = require("GameCore.UI.PanelDefine")
local AvgPreset = require("Game.UI.Avg.AvgPreset")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local ListString = CS.System.Collections.Generic.List(CS.System.String)
local Directory = CS.System.IO.Directory
local SearchOption = CS.System.IO.SearchOption
local Actor2DOffsetData = CS.Actor2DOffsetData
local EventTrigger = CS.UnityEngine.EventSystems.EventTrigger
local EventTriggerType = CS.UnityEngine.EventSystems.EventTriggerType
local ConfigActor2DEditor = CS.ConfigActor2DEditor
local typeof = _ENV.typeof
Actor2DEditorCtrl._mapNodeConfig = {
  trUIInsRoot = {
    sNodeName = "-- ui in root --",
    sComponentName = "Transform"
  },
  eventTriggerEditPos = {
    sNodeName = "et_pos",
    sComponentName = "EventTrigger"
  },
  imgEditPos = {sNodeName = "et_pos", sComponentName = "Image"},
  sldScale = {
    sNodeName = "sld_scale",
    sComponentName = "Slider",
    callback = "OnValueChanged_SliderScale"
  },
  inputScale = {
    sNodeName = "input_scale",
    sComponentName = "InputField_onEndEdit",
    callback = "OnEditEnd_InputScale"
  },
  togEditEmoji = {
    sNodeName = "tog_edit_emoji",
    sComponentName = "Toggle",
    callback = "OnTog_EditEmoji"
  },
  togMirrorEmoji = {
    sNodeName = "tog_mirror_emoji",
    sComponentName = "Toggle",
    callback = "OnTog_MirrorEmoji"
  },
  ddSelectChannel = {
    sNodeName = "dd_select_game_channel",
    sComponentName = "Dropdown",
    callback = "OnDD_SelectChannel"
  },
  ddSelectPngLive2D = {
    sNodeName = "dd_select_png_live2d",
    sComponentName = "Dropdown",
    callback = "OnDD_SelectPngLive2D"
  },
  ddSelectPanel = {
    sNodeName = "dd_select_panel",
    sComponentName = "Dropdown",
    callback = "OnDD_SelectPanel"
  },
  ddSelectActor = {
    sNodeName = "dd_char",
    sComponentName = "Dropdown",
    callback = "OnDD_SelectActor"
  },
  ddSelectPose = {
    sNodeName = "dd_pose",
    sComponentName = "Dropdown",
    callback = "OnDD_SelectPose"
  },
  ddSelectEmoji = {
    sNodeName = "ddEmoji",
    sComponentName = "Dropdown",
    callback = "OnDD_SelectEmoji"
  },
  ddSelectFullOrHalf = {
    sNodeName = "dd_full_half",
    sComponentName = "Dropdown",
    callback = "OnDD_SelectFullOrHalf"
  },
  ddSelectAvgCharHeadFrame = {
    sNodeName = "dd_select_avg_char_head_frame",
    sComponentName = "Dropdown",
    callback = "OnDD_SelectAvgCharFrame"
  },
  btnReset = {
    sNodeName = "btn_reset",
    sComponentName = "Button",
    callback = "OnBtnClick_Reset"
  },
  btnRefresh = {
    sNodeName = "btn_refresh",
    sComponentName = "Button",
    callback = "OnBtnClick_Refresh"
  },
  btnSave = {
    sNodeName = "btn_save",
    sComponentName = "Button",
    callback = "OnBtnClick_Save"
  }
}
Actor2DEditorCtrl._mapEventConfig = {}
local tbPanelPreference = {}
local ECharType = {
  Char = 0,
  AvgChar = 1,
  Npc = 2,
  CharNpc = 3
}

function Actor2DEditorCtrl:Awake()
  local tr = GameObject.Find("==== UI ROOT ====/----Actor2D_OffScreen_Renderer----/----Renderer----/1").transform
  self.trRendererActorOffset = tr:Find("animator/panel_offset/free_drag/actor_offset")
  self.trActorOffset = nil
  self.trEmojiOffset = nil
  local goFPSCounter = GameObject.Find("==== UI ROOT ====/---- UI OVERLAY ----/_FPSCounter")
  goFPSCounter:SetActive(false)
  self:CacheActor2DEditorConfig()
  self.tbAllPose = {}
  for _, sPose in ipairs(AvgPreset.CharPose_0) do
    table.insert(self.tbAllPose, sPose)
  end
  for _, sPose in ipairs(AvgPreset.CharPose_1) do
    table.insert(self.tbAllPose, sPose)
  end
  self.nAvgCharHeadMirrorFactor = 1
end

function Actor2DEditorCtrl:OnEnable()
  self.tbCallback = {}
  self._mapNode.ddSelectPngLive2D.gameObject:SetActive(false)
  local nIndex = 0
  nIndex = nIndex + 1
  self.tbCallback[nIndex] = ui_handler(self, self.OnBeginDrag, self._mapNode.eventTriggerEditPos)
  local entryBegin = EventTrigger.Entry()
  entryBegin.eventID = EventTriggerType.BeginDrag
  entryBegin.callback:AddListener(self.tbCallback[nIndex])
  self._mapNode.eventTriggerEditPos.triggers:Add(entryBegin)
  nIndex = nIndex + 1
  self.tbCallback[nIndex] = ui_handler(self, self.OnDrag, self._mapNode.eventTriggerEditPos)
  local entryDrag = EventTrigger.Entry()
  entryDrag.eventID = EventTriggerType.Drag
  entryDrag.callback:AddListener(self.tbCallback[nIndex])
  self._mapNode.eventTriggerEditPos.triggers:Add(entryDrag)
  nIndex = nIndex + 1
  self.tbCallback[nIndex] = ui_handler(self, self.OnEndDrag, self._mapNode.eventTriggerEditPos)
  local entryEnd = EventTrigger.Entry()
  entryEnd.eventID = EventTriggerType.EndDrag
  entryEnd.callback:AddListener(self.tbCallback[nIndex])
  self._mapNode.eventTriggerEditPos.triggers:Add(entryEnd)
  self:SetUIList()
  self:OnDD_SelectPanel(self._mapNode.ddSelectPanel)
  self:SetPoseList()
  self:SetEmojiList()
  self:SetEditable(false)
end

function Actor2DEditorCtrl:OnDisable()
  local nIndex = 0
  nIndex = nIndex + 1
  local cb_begindrag = self.tbCallback[nIndex]
  nIndex = nIndex + 1
  local cb_drag = self.tbCallback[nIndex]
  nIndex = nIndex + 1
  local cb_enddrag = self.tbCallback[nIndex]
  local nCount = self._mapNode.eventTriggerEditPos.triggers.Count - 1
  for i = nCount, 0, -1 do
    local entry = self._mapNode.eventTriggerEditPos.triggers[i]
    if entry.eventID == EventTriggerType.BeginDrag then
      entry.callback:RemoveListener(cb_begindrag)
    elseif entry.eventID == EventTriggerType.Drag then
      entry.callback:RemoveListener(cb_drag)
    elseif entry.eventID == EventTriggerType.EndDrag then
      entry.callback:RemoveListener(cb_enddrag)
    end
    self._mapNode.eventTriggerEditPos.triggers:Remove(entry)
  end
  self.tbCallback = nil
end

function Actor2DEditorCtrl:CacheActor2DEditorConfig()
  local assetConfig = GameResourceLoader.LoadAsset(ResType.Any, "Assets/AssetBundles/UI/CommonEx/Preference/Actor2DEditor.asset", typeof(ConfigActor2DEditor))
  local nLen = assetConfig.arrData.Length - 1
  for i = 0, nLen do
    local data = assetConfig.arrData[i]
    local nPanelId = assetConfig:GetPanelId(i)
    local nReusePanelId = assetConfig:GetReusePanelId(i)
    local _nCharType = assetConfig:GetCharType(i)
    table.insert(tbPanelPreference, {
      nId = nPanelId,
      nReuse = nReusePanelId,
      nCharType = _nCharType,
      bInUI = data.InUI,
      bFull = data.CanEditFull,
      bEmoji = data.CanEditEmoji,
      bPose = data.CanEditPose,
      sName = data.UIName,
      nSpIdx = data.PrefabIndex,
      sNodePath = data.NodePath
    })
  end
end

function Actor2DEditorCtrl:SetUIList()
  local listUIName = ListString()
  for i, v in ipairs(tbPanelPreference) do
    listUIName:Add(v.sName)
  end
  NovaAPI.ClearDropDownOptions(self._mapNode.ddSelectPanel)
  NovaAPI.DropDownAddOptions(self._mapNode.ddSelectPanel, listUIName)
  NovaAPI.SetDropDownValue(self._mapNode.ddSelectPanel, 0)
end

function Actor2DEditorCtrl:SetActorList(mapPreference)
  local listActor2D = ListString()
  
  local function func_CollectChar(sPath)
    local tbActorIdFolders = Directory.GetDirectories(self:GetABRootPath() .. sPath, "*.*", SearchOption.TopDirectoryOnly)
    local nCount = tbActorIdFolders.Length - 1
    for i = 0, nCount do
      local tb = string.split(tbActorIdFolders[i], "/")
      local sFolderName = tb[#tb]
      listActor2D:Add(sFolderName)
    end
  end
  
  if mapPreference.nCharType == ECharType.Char then
    func_CollectChar("Actor2D/Character/")
  elseif mapPreference.nCharType == ECharType.AvgChar then
    func_CollectChar("Actor2D/CharacterAvg/")
  elseif mapPreference.nCharType == ECharType.Npc then
    func_CollectChar("Actor2D/NPC/")
  elseif mapPreference.nCharType == ECharType.CharNpc then
    func_CollectChar("Actor2D/Character/")
    func_CollectChar("Actor2D/NPC/")
  end
  NovaAPI.ClearDropDownOptions(self._mapNode.ddSelectActor)
  NovaAPI.DropDownAddOptions(self._mapNode.ddSelectActor, listActor2D)
  NovaAPI.SetDropDownValue(self._mapNode.ddSelectActor, 0)
end

function Actor2DEditorCtrl:SetPoseList()
  local nAllCount = #self.tbAllPose
  local listPose = ListString()
  for i = 1, nAllCount do
    listPose:Add(self.tbAllPose[i])
  end
  NovaAPI.ClearDropDownOptions(self._mapNode.ddSelectPose)
  NovaAPI.DropDownAddOptions(self._mapNode.ddSelectPose, listPose)
  NovaAPI.SetDropDownValue(self._mapNode.ddSelectPose, 0)
end

function Actor2DEditorCtrl:SetEmojiList()
  self.tbEmojiPrefabPath = {}
  local tbCharEmoji = AvgPreset.CharEmoji
  local nAllCount = #tbCharEmoji
  local listEmoji = ListString()
  for i = 3, nAllCount do
    local mapEmoji = tbCharEmoji[i]
    listEmoji:Add(mapEmoji[2])
    table.insert(self.tbEmojiPrefabPath, mapEmoji[3])
  end
  NovaAPI.ClearDropDownOptions(self._mapNode.ddSelectEmoji)
  NovaAPI.DropDownAddOptions(self._mapNode.ddSelectEmoji, listEmoji)
  NovaAPI.SetDropDownValue(self._mapNode.ddSelectEmoji, 0)
end

function Actor2DEditorCtrl:SetEditable(bCanEdit, bPreferSetEmoji)
  NovaAPI.SetImageRaycastTarget(self._mapNode.imgEditPos, bCanEdit == true)
  NovaAPI.SetSliderInteractable(self._mapNode.sldScale, bCanEdit == true)
  NovaAPI.SetInputFieldInteractable(self._mapNode.inputScale, bCanEdit == true)
  if bPreferSetEmoji == nil then
    NovaAPI.SetToggleInteractable(self._mapNode.togEditEmoji, bCanEdit == true)
    NovaAPI.SetToggleInteractable(self._mapNode.togMirrorEmoji, bCanEdit == true)
  else
    NovaAPI.SetToggleInteractable(self._mapNode.togEditEmoji, bCanEdit == true and bPreferSetEmoji == true)
    NovaAPI.SetToggleInteractable(self._mapNode.togMirrorEmoji, bCanEdit == true and bPreferSetEmoji == true)
  end
end

function Actor2DEditorCtrl:GetABRootPath()
  local nSelectedChannel = NovaAPI.GetDropDownValue(self._mapNode.ddSelectChannel)
  local sABRootPath = "Assets/AssetBundles"
  if nSelectedChannel == 0 then
    sABRootPath = sABRootPath .. "/"
  elseif nSelectedChannel == 1 then
    sABRootPath = sABRootPath .. "_cen/"
  end
  return sABRootPath
end

function Actor2DEditorCtrl:GetCharEmojiIndex(sEmoji)
  for i, v in ipairs(AvgPreset.CharEmoji) do
    if v[3] == sEmoji then
      return v[1]
    end
  end
  return 0
end

function Actor2DEditorCtrl:IsAvgCharInTalkFrameBg(sPose, sAvgCharId)
  if sAvgCharId ~= "avg3_100" and sAvgCharId ~= "avg3_101" then
    return false
  end
  local nCount = 2
  local nAllCount = #self.tbAllPose
  local bMatch = false
  for i = 1, nCount do
    if self.tbAllPose[nAllCount] == sPose then
      bMatch = true
      break
    end
    nAllCount = nAllCount - 1
  end
  return bMatch
end

function Actor2DEditorCtrl:GetAvgCharHeadFrameIndex(nValue)
  local nIdx = nValue
  if nIdx == 2 then
    nIdx = 3
  end
  return nIdx
end

function Actor2DEditorCtrl:ClearAll()
  Actor2DManager.UnsetActor2D_ForActor2DEditor()
  if self.trEmojiOffset ~= nil then
    delChildren(self.trEmojiOffset)
    self.trEmojiOffset = nil
  end
  delChildren(self._mapNode.trUIInsRoot.gameObject)
  self:SetEditable(false)
  self.Offset = nil
  self.nCurPanelId = 0
  self.nReusePanelId = 0
  self.bInUI = false
  self._mapNode.ddSelectPngLive2D.gameObject:SetActive(NovaAPI.GetDropDownValue(self._mapNode.ddSelectPanel) == 2 and NovaAPI.GetDropDownValue(self._mapNode.ddSelectFullOrHalf) == 1)
  self._mapNode.ddSelectAvgCharHeadFrame.gameObject:SetActive(NovaAPI.GetDropDownValue(self._mapNode.ddSelectPanel) == 0)
  self.nAvgCharHeadMirrorFactor = 1
end

function Actor2DEditorCtrl:CreatePanelTempIns(nIndex)
  self:ClearAll()
  local mapPreference = tbPanelPreference[nIndex]
  if mapPreference == nil then
    return
  end
  local nSpIdx = mapPreference.nSpIdx or 1
  local panel = require(PanelDefine[mapPreference.nId])
  local sPanelPrefabPath = Settings.AB_ROOT_PATH .. "UI/" .. panel._tbDefine[nSpIdx].sPrefabPath
  local objPrefab = GameResourceLoader.LoadAsset(ResType.Any, sPanelPrefabPath, typeof(Object))
  local goIns = instantiate(objPrefab, self._mapNode.trUIInsRoot)
  goIns.transform.localScale = Vector3.one
  local rt = goIns:GetComponent("RectTransform")
  rt.anchoredPosition = Vector2.zero
  rt.pivot = Vector2(0.5, 0.5)
  rt.anchorMin = Vector2.zero
  rt.anchorMax = Vector2.one
  local sTargetPath = mapPreference.sNodePath
  local bEditAvgHeadFrame = false
  if mapPreference.nId == PanelId.AvgST then
    bEditAvgHeadFrame = NovaAPI.GetDropDownValue(self._mapNode.ddSelectAvgCharHeadFrame) > 0
    goIns.transform:Find("----Full_Rect----/--char_head_frame--").gameObject:SetActive(bEditAvgHeadFrame)
    NovaAPI.SetImageSprite(goIns.transform:Find("----Full_Rect----/BG"):GetComponent("Image"), "Assets/AssetBundles/ImageAvg/AvgBg/city_street_daylight.png")
    if bEditAvgHeadFrame == true then
      local sIndex = tostring(NovaAPI.GetDropDownValue(self._mapNode.ddSelectAvgCharHeadFrame))
      goIns.transform:Find(string.format("----Full_Rect----/--char_head_frame--/rtFrame_%s", sIndex)).gameObject:SetActive(true)
      sTargetPath = string.format("----Full_Rect----/--char_head_frame--/rtFrame_%s/rtFrameOffset/rtFramePos/goCharMask/rtCharOffset_%s/----Actor2D_PNG----", sIndex, sIndex)
      NovaAPI.SetToggleIsOn(self._mapNode.togEditEmoji, false)
      local nValue = NovaAPI.GetDropDownValue(self._mapNode.ddSelectAvgCharHeadFrame)
      if nValue == 1 or nValue == 5 then
        self.nAvgCharHeadMirrorFactor = -1
      end
    end
  end
  local trRawImg = goIns.transform:Find(sTargetPath)
  trRawImg.gameObject:SetActive(true)
  local rawImg = trRawImg:GetComponent("RawImage")
  local goEmojiRoot = GameObject("trEmojiOffset")
  self.trEmojiOffset = goEmojiRoot.transform
  self.trEmojiOffset:SetParent(trRawImg.parent)
  self.trEmojiOffset.localPosition = Vector3.zero
  self.trEmojiOffset.localScale = Vector3.one
  self:SetEditable(0 >= mapPreference.nReuse, mapPreference.bEmoji == true and bEditAvgHeadFrame == false)
  self.nCurPanelId = mapPreference.nId
  self.nCharType = mapPreference.nCharType
  self.nReusePanelId = mapPreference.nReuse
  self.bInUI = mapPreference.bInUI
  self:ProcFadeInUI(goIns)
  return trRawImg, rawImg
end

function Actor2DEditorCtrl:ProcFadeInUI(goIns)
  if self.nCurPanelId == PanelId.MainView then
    goIns.transform:Find("----SafeAreaRoot----"):GetComponent("Animator"):SetTrigger("tLogin")
  elseif self.nCurPanelId == PanelId.CharUpPanel then
    goIns.transform:Find("----SafeAreaRoot----/----FunctionPanel----/--NodeInfo--/advancePreviewInfo").gameObject:SetActive(false)
  end
end

function Actor2DEditorCtrl:OnDD_SelectChannel(dd)
  self:ClearAll()
  self:SetActorList()
end

function Actor2DEditorCtrl:OnDD_SelectPngLive2D(dd)
  self:ClearAll()
end

function Actor2DEditorCtrl:OnDD_SelectPanel(dd)
  self:ClearAll()
  local nValue = NovaAPI.GetDropDownValue(dd)
  local mapPreference = tbPanelPreference[nValue + 1]
  self:SetActorList(mapPreference)
  NovaAPI.SetDropDownValue(self._mapNode.ddSelectFullOrHalf, 0)
  NovaAPI.SetDDInteractable(self._mapNode.ddSelectFullOrHalf, mapPreference.bFull == true)
  NovaAPI.SetDropDownValue(self._mapNode.ddSelectEmoji, 0)
  NovaAPI.SetDDInteractable(self._mapNode.ddSelectEmoji, mapPreference.bEmoji == true)
  NovaAPI.SetToggleIsOn(self._mapNode.togEditEmoji, false)
  NovaAPI.SetToggleIsOn(self._mapNode.togMirrorEmoji, false)
  NovaAPI.SetDropDownValue(self._mapNode.ddSelectPose, 0)
  NovaAPI.SetDDInteractable(self._mapNode.ddSelectPose, mapPreference.bPose == true)
end

function Actor2DEditorCtrl:OnDD_SelectActor(dd)
  self:ClearAll()
  NovaAPI.SetDropDownValue(self._mapNode.ddSelectFullOrHalf, 0)
  NovaAPI.SetDropDownValue(self._mapNode.ddSelectEmoji, 0)
  NovaAPI.SetDropDownValue(self._mapNode.ddSelectPose, 0)
end

function Actor2DEditorCtrl:OnDD_SelectPose(dd)
  self:ClearAll()
end

function Actor2DEditorCtrl:OnDD_SelectEmoji(dd)
  self:ClearAll()
end

function Actor2DEditorCtrl:OnDD_SelectFullOrHalf(dd)
  self:ClearAll()
end

function Actor2DEditorCtrl:OnDD_SelectAvgCharFrame(dd)
  self:ClearAll()
end

local v2BeginDragPos, v3CurOffsetPos, v3DragPos
local nFactor = 100

function Actor2DEditorCtrl:OnBeginDrag(eventTrigger, eventData)
  v2BeginDragPos = eventData.position
  v3CurOffsetPos = self.trActorOffset.localPosition
  if NovaAPI.GetDDInteractable(self._mapNode.ddSelectEmoji) == true and NovaAPI.GetToggleIsOn(self._mapNode.togEditEmoji) == true then
    v3CurOffsetPos = self.trEmojiOffset.localPosition
  end
  nFactor = self.bInUI == true and 1 or 100
end

function Actor2DEditorCtrl:OnDrag(eventTrigger, eventData)
  local v2Del = eventData.position - v2BeginDragPos
  if CS.InputManager.Instance:GetKey(CS.UnityEngine.InputSystem.Key.LeftShift) == true then
    v2Del.y = 0
  end
  if CS.InputManager.Instance:GetKey(CS.UnityEngine.InputSystem.Key.LeftAlt) == true then
    v2Del.x = 0
  end
  if NovaAPI.GetDDInteractable(self._mapNode.ddSelectEmoji) == true and NovaAPI.GetToggleIsOn(self._mapNode.togEditEmoji) == true then
    v3DragPos = Vector3(v3CurOffsetPos.x + v2Del.x, v3CurOffsetPos.y + v2Del.y, 0)
    self.trEmojiOffset.localPosition = v3DragPos
  else
    if self.nCurPanelId == PanelId.AvgST then
      v3DragPos = Vector3(v3CurOffsetPos.x + v2Del.x * self.nAvgCharHeadMirrorFactor, v3CurOffsetPos.y + v2Del.y, 0)
    else
      v3DragPos = Vector3(v3CurOffsetPos.x + v2Del.x / nFactor, v3CurOffsetPos.y + v2Del.y / nFactor, 0)
    end
    self.trActorOffset.localPosition = v3DragPos
  end
end

function Actor2DEditorCtrl:OnEndDrag(eventTrigger, eventData)
  v2BeginDragPos = nil
  v3CurOffsetPos = nil
  v3DragPos = nil
end

function Actor2DEditorCtrl:OnEditEnd_InputScale()
  local nS = tonumber(NovaAPI.GetInputFieldText(self._mapNode.inputScale))
  NovaAPI.SetSliderValue(self._mapNode.sldScale, nS)
  if NovaAPI.GetToggleIsOn(self._mapNode.togEditEmoji) == true then
    local nFactor = 1
    if NovaAPI.GetToggleIsOn(self._mapNode.togMirrorEmoji) == true then
      nFactor = -1
    end
    self.trEmojiOffset.localScale = Vector3(nS * nFactor, nS, 1)
  else
    self.trActorOffset.localScale = Vector3(nS * self.nAvgCharHeadMirrorFactor, nS, 1)
  end
end

function Actor2DEditorCtrl:OnValueChanged_SliderScale()
  local nS = NovaAPI.GetSliderValue(self._mapNode.sldScale)
  NovaAPI.SetInputFieldText(self._mapNode.inputScale, tostring(nS))
  if NovaAPI.GetToggleIsOn(self._mapNode.togEditEmoji) == true then
    local nFactor = 1
    if NovaAPI.GetToggleIsOn(self._mapNode.togMirrorEmoji) == true then
      nFactor = -1
    end
    self.trEmojiOffset.localScale = Vector3(nS * nFactor, nS, 1)
  else
    self.trActorOffset.localScale = Vector3(nS * self.nAvgCharHeadMirrorFactor, nS, 1)
  end
end

function Actor2DEditorCtrl:OnTog_EditEmoji()
  if NovaAPI.GetToggleIsOn(self._mapNode.togEditEmoji) == true then
    if self.trEmojiOffset ~= nil and self.trEmojiOffset:IsNull() == false then
      NovaAPI.SetSliderValue(self._mapNode.sldScale, self.trEmojiOffset.localScale.y)
      NovaAPI.SetInputFieldText(self._mapNode.inputScale, tostring(self.trEmojiOffset.localScale.y))
    end
  elseif self.trActorOffset ~= nil and self.trActorOffset:IsNull() == false then
    NovaAPI.SetSliderValue(self._mapNode.sldScale, self.trActorOffset.localScale.y)
    NovaAPI.SetInputFieldText(self._mapNode.inputScale, tostring(self.trActorOffset.localScale.y))
  end
end

function Actor2DEditorCtrl:OnTog_MirrorEmoji()
  if self.trEmojiOffset ~= nil and self.trEmojiOffset:IsNull() == false then
    local v3Scale = self.trEmojiOffset.localScale
    self.trEmojiOffset.localScale = Vector3(v3Scale.x * -1, v3Scale.y, 1)
  end
end

function Actor2DEditorCtrl:OnBtnClick_Reset()
  if self.Offset == nil or self.nReusePanelId > 0 then
    return
  end
  NovaAPI.SetToggleIsOn(self._mapNode.togMirrorEmoji, false)
  self.trActorOffset.localPosition = Vector3.zero
  self.trActorOffset.localScale = Vector3.one
  self.trEmojiOffset.localPosition = Vector3.zero
  self.trEmojiOffset.localScale = Vector3.one
  NovaAPI.SetSliderValue(self._mapNode.sldScale, 1)
  NovaAPI.SetInputFieldText(self._mapNode.inputScale, "1")
  local sId = NovaAPI.GetCurDDOptionsText(self._mapNode.ddSelectActor)
  local sPose = "a"
  if NovaAPI.GetDDInteractable(self._mapNode.ddSelectPose) == true then
    sPose = NovaAPI.GetCurDDOptionsText(self._mapNode.ddSelectPose)
  end
  if self:IsAvgCharInTalkFrameBg(sPose, sId) == true then
    self.trActorOffset.localPosition = Vector3(0, 540, 0)
    self.trActorOffset.localScale = Vector3.one
  end
end

function Actor2DEditorCtrl:OnBtnClick_Refresh()
  local trRawImg, rawImg = self:CreatePanelTempIns(NovaAPI.GetDropDownValue(self._mapNode.ddSelectPanel) + 1)
  if self.nCurPanelId == PanelId.AvgST then
    self.trActorOffset = trRawImg:GetChild(0):GetChild(0)
    if 0 < NovaAPI.GetDropDownValue(self._mapNode.ddSelectAvgCharHeadFrame) then
      self.trActorOffset = trRawImg.parent
    end
  else
    self.trActorOffset = self.bInUI == true and trRawImg:GetChild(0):GetChild(0) or self.trRendererActorOffset
  end
  local sId = NovaAPI.GetCurDDOptionsText(self._mapNode.ddSelectActor)
  local bFull = NovaAPI.GetDropDownValue(self._mapNode.ddSelectFullOrHalf) == 1
  local bL2D = NovaAPI.GetDropDownValue(self._mapNode.ddSelectPngLive2D) == 1 and self._mapNode.ddSelectPngLive2D.gameObject.activeSelf == true
  local sPose = "a"
  local sFolder = ""
  local bIsNpc = false
  if self.nCharType == ECharType.Char then
    sFolder = "Actor2D/Character/"
  elseif self.nCharType == ECharType.AvgChar then
    sPose = NovaAPI.GetCurDDOptionsText(self._mapNode.ddSelectPose)
    sFolder = "Actor2D/CharacterAvg/"
  elseif self.nCharType == ECharType.Npc then
    sFolder = "Actor2D/NPC/"
    bIsNpc = true
  elseif self.nCharType == ECharType.CharNpc then
    sFolder = "Actor2D/Character/"
  end
  local sAssetPath = string.format("%s%s%s/%s.asset", self:GetABRootPath(), sFolder, sId, sId)
  self.Offset = CS.UnityEditor.AssetDatabase.LoadAssetAtPath(sAssetPath, typeof(Actor2DOffsetData))
  if self.Offset == nil and self.nCharType == ECharType.CharNpc then
    sFolder = "Actor2D/NPC/"
    sAssetPath = string.format("%s%s%s/%s.asset", self:GetABRootPath(), sFolder, sId, sId)
    self.Offset = CS.UnityEditor.AssetDatabase.LoadAssetAtPath(sAssetPath, typeof(Actor2DOffsetData))
    bIsNpc = true
  end
  CS.UnityEditor.Selection.activeObject = self.Offset
  local nX, nY, nL2DX, nL2DY = 0, 0, 0, 0
  local nPanelId = self.nCurPanelId
  if 0 < self.nReusePanelId then
    nPanelId = self.nReusePanelId
  end
  local s, x, y = self.Offset:GetOffsetData(nPanelId, indexOfPose(sPose), bFull ~= true, nX, nY)
  local l2ds, l2dx, l2dy = self.Offset:GetL2DData(nL2DX, nL2DY)
  if l2ds <= 0 then
    l2dx, l2dy, l2ds = 0, 0, 1
  end
  if self.nCurPanelId == PanelId.AvgST then
    if self:IsAvgCharInTalkFrameBg(sPose, sId) == true then
      s, x, y = 1, 0, 540
      NovaAPI.SetToggleIsOn(self._mapNode.togEditEmoji, true)
      NovaAPI.SetToggleInteractable(self._mapNode.togEditEmoji, false)
    end
    Actor2DManager.SetActor2D_PNG_ForActor2DEditor(self.nCurPanelId, trRawImg, sId, self:GetABRootPath() .. sFolder .. sId, s, x, y, sPose)
    if 0 < NovaAPI.GetDropDownValue(self._mapNode.ddSelectAvgCharHeadFrame) then
      local nFrameIndex = self:GetAvgCharHeadFrameIndex(NovaAPI.GetDropDownValue(self._mapNode.ddSelectAvgCharHeadFrame))
      local _nAvgCharHeadFrameX, _nAvgCharHeadFrameY = 0, 0
      local nAvgCharHeadFrameS, nAvgCharHeadFrameX, nAvgCharHeadFrameY = self.Offset:Get_AvgCharHeadFrameData(nPanelId, indexOfPose(sPose), nFrameIndex, _nAvgCharHeadFrameX, _nAvgCharHeadFrameY)
      self.trActorOffset.localPosition = Vector3(nAvgCharHeadFrameX, nAvgCharHeadFrameY, 0)
      self.trActorOffset.localScale = Vector3(nAvgCharHeadFrameS, math.abs(nAvgCharHeadFrameS), 1)
    end
  elseif self.bInUI == true then
    Actor2DManager.SetActor2D_PNG_ForActor2DEditor(self.nCurPanelId, trRawImg, sId, self:GetABRootPath() .. sFolder .. sId, s, 100 * x, 100 * y)
  else
    local trL2D = Actor2DManager.SetActor2D_ForActor2DEditor(self.nCurPanelId, rawImg, sId, bFull, self:GetABRootPath() .. sFolder, s, x, y, bL2D, l2dx, l2dy, l2ds, bIsNpc == true)
    if trL2D ~= nil then
      self.trActorOffset = trL2D
    end
  end
  NovaAPI.SetSliderValue(self._mapNode.sldScale, self.trActorOffset.localScale.y)
  NovaAPI.SetInputFieldText(self._mapNode.inputScale, tostring(self.trActorOffset.localScale.y))
  if NovaAPI.GetDDInteractable(self._mapNode.ddSelectEmoji) == true then
    local nValue = NovaAPI.GetDropDownValue(self._mapNode.ddSelectEmoji)
    local sEmojiPrefabName = self.tbEmojiPrefabPath[nValue + 1]
    local objEmojiPrefab = CS.UnityEditor.AssetDatabase.LoadAssetAtPath(Settings.AB_ROOT_PATH .. "UI/Avg/AnimEmoji/" .. sEmojiPrefabName .. ".prefab", typeof(Object))
    local goEmojiIns = instantiate(objEmojiPrefab, self.trEmojiOffset)
    local anim = goEmojiIns:GetComponent("Animator")
    anim:SetTrigger("tEditor")
    local _nX, _nY = 0, 0
    local _s, _x, _y = self.Offset:GetEmojiData(self.nCurPanelId, indexOfPose(sPose), self:GetCharEmojiIndex(sEmojiPrefabName), _nX, _nY)
    if self:IsAvgCharInTalkFrameBg(sPose, sId) == true then
      _y = _y + 540
    end
    NovaAPI.SetToggleIsOn(self._mapNode.togMirrorEmoji, _s < 0)
    self.trEmojiOffset.localPosition = Vector3(_x, _y, 0)
    self.trEmojiOffset.localScale = Vector3(_s, math.abs(_s), 1)
    if NovaAPI.GetToggleIsOn(self._mapNode.togEditEmoji) == true then
      NovaAPI.SetSliderValue(self._mapNode.sldScale, self.trEmojiOffset.localScale.y)
      NovaAPI.SetInputFieldText(self._mapNode.inputScale, tostring(self.trEmojiOffset.localScale.y))
    end
  end
end

function Actor2DEditorCtrl:OnBtnClick_Save()
  if self.Offset == nil or self.nReusePanelId > 0 then
    return
  end
  local sId = NovaAPI.GetCurDDOptionsText(self._mapNode.ddSelectActor)
  local sPose = "a"
  if NovaAPI.GetDDInteractable(self._mapNode.ddSelectPose) == true then
    sPose = NovaAPI.GetCurDDOptionsText(self._mapNode.ddSelectPose)
  end
  local v3Pos = self.trActorOffset.localPosition
  local v3Scale = self.trActorOffset.localScale
  if self._mapNode.ddSelectPngLive2D.gameObject.activeSelf == true and NovaAPI.GetDropDownValue(self._mapNode.ddSelectPngLive2D) == 1 then
    self.Offset:SetL2DData(v3Pos.x, v3Pos.y, v3Scale.x)
  elseif self.nCurPanelId == PanelId.AvgST and 0 < NovaAPI.GetDropDownValue(self._mapNode.ddSelectAvgCharHeadFrame) then
    local nFrameIndex = self:GetAvgCharHeadFrameIndex(NovaAPI.GetDropDownValue(self._mapNode.ddSelectAvgCharHeadFrame))
    self.Offset:Set_AvgCharHeadFrameData(self.nCurPanelId, indexOfPose(sPose), nFrameIndex, v3Pos.x, v3Pos.y, v3Scale.x)
  else
    local x, y, s = v3Pos.x, v3Pos.y, v3Scale.x
    if self:IsAvgCharInTalkFrameBg(sPose, sId) == true and self.nCurPanelId == PanelId.AvgST then
      y = y - 540
    end
    if self.bInUI == true and self.nCurPanelId ~= PanelId.AvgST then
      x = x / 100
      y = y / 100
    end
    self.Offset:SetOffsetData(self.nCurPanelId, indexOfPose(sPose), NovaAPI.GetDropDownValue(self._mapNode.ddSelectFullOrHalf) == 0, x, y, s)
  end
  if NovaAPI.GetDDInteractable(self._mapNode.ddSelectEmoji) == true then
    local v3EmojiPos = self.trEmojiOffset.localPosition
    local v3EmojiScale = self.trEmojiOffset.localScale
    local nValue = NovaAPI.GetDropDownValue(self._mapNode.ddSelectEmoji)
    local sEmojiPrefabName = self.tbEmojiPrefabPath[nValue + 1]
    local y = v3EmojiPos.y
    if self:IsAvgCharInTalkFrameBg(sPose, sId) == true and self.nCurPanelId == PanelId.AvgST then
      y = y - 540
    end
    self.Offset:SetEmojiData(self.nCurPanelId, indexOfPose(sPose), self:GetCharEmojiIndex(sEmojiPrefabName), v3EmojiPos.x, y, v3EmojiScale.x)
  end
  CS.UnityEditor.EditorUtility.SetDirty(self.Offset)
  CS.UnityEditor.AssetDatabase.SaveAssets()
  CS.UnityEditor.AssetDatabase.Refresh()
end

return Actor2DEditorCtrl

local GuideCtrl = class("GuideCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local TimerManager = require("GameCore.Timer.TimerManager")
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local SDKManager = CS.SDKManager.Instance
GuideCtrl._mapNodeConfig = {
  GuideUIHelp = {sComponentName = "GameObject"},
  btnHide = {sComponentName = "GameObject"},
  btnTempRect = {
    sNodeName = "btnTemp",
    sComponentName = "RectTransform"
  },
  btnTemp = {sComponentName = "UIButton"},
  typeMask = {sComponentName = "GameObject"},
  imgLeft = {
    sComponentName = "RectTransform"
  },
  imgRight = {
    sComponentName = "RectTransform"
  },
  imgTop = {
    sComponentName = "RectTransform"
  },
  imgBottom = {
    sComponentName = "RectTransform"
  },
  imgMiddle = {
    sComponentName = "RectTransform"
  },
  ani_Middle = {sNodeName = "imgMiddle", sComponentName = "Animator"},
  imgHand = {
    sComponentName = "RectTransform"
  },
  imgHand1 = {sComponentName = "Canvas"},
  obj_texBgCanvas = {sNodeName = "obj_texBg", sComponentName = "Canvas"},
  obj_texBg = {
    sComponentName = "RectTransform"
  },
  imgHead = {sComponentName = "Image"},
  texDesc = {sComponentName = "TMP_Text"},
  texDescNoneHead = {sComponentName = "TMP_Text"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "FinishCurrentStep"
  },
  btnCount = {
    sComponentName = "UIButton",
    callback = "OnClickCount"
  },
  btnJump = {
    sComponentName = "UIButton",
    callback = "OnClickJump"
  },
  txtJump = {sComponentName = "TMP_Text", sLanguageId = "Guide_Jump"},
  canvasBtnClose = {sNodeName = "btnClose", sComponentName = "Canvas"},
  btnShortcutClose = {
    sComponentName = "NaviButton",
    sAction = "Confirm",
    callback = "FinishCurrentStep"
  },
  blur = {},
  aniBlur = {sNodeName = "blur", sComponentName = "Animator"},
  EditorDebug = {sComponentName = "GameObject"},
  InputFieldDebug = {sComponentName = "InputField"},
  InputFieldStep = {sComponentName = "InputField"},
  InputFieldPassive = {sComponentName = "InputField"},
  btnEditorDebug = {
    sComponentName = "UIButton",
    callback = "DebugEditorStep"
  },
  btnEditorClear = {
    sComponentName = "UIButton",
    callback = "DebugEditorClear"
  }
}
GuideCtrl._mapEventConfig = {
  Event_ActiveGuidePanel = "ActiveGuidePanelEvent",
  Event_DeActiveGuidePanel = "DeActiveGuidePanelEvent",
  Event_ActiveHide = "ActiveHide",
  NewDay_Clear_Guide = "NewDayClearGuide",
  StoryDialog_DialogEnd = "OnEvent_StoryDialog_DialogEnd",
  GM_SkipCurrentGuide = "OnGMSkipCurrentGuide"
}
local clickCount = 0
local maxClickCount = 15
local maxWaitTimeEnd = false
local maxWaitTime = 20

function GuideCtrl:Awake()
  self.isDebugTest = false
  maxClickCount = ConfigTable.GetConfigNumber("GuideMaxClickCount")
  maxWaitTime = ConfigTable.GetConfigNumber("GuideMaxWaitTime")
  self.GuideUIHelpCS = self._mapNode.GuideUIHelp:GetComponent("GuideUIHelp")
  self.doGuideData = nil
  self.addClickCb = nil
  self.waitStep = nil
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function GuideCtrl:OnEnable()
  NovaAPI.SetCanvasOverrideSorting(self._mapNode.imgHand1, true)
  NovaAPI.SetCanvasSortingName(self._mapNode.imgHand1, AllEnum.SortingLayerName.UI_Top)
  NovaAPI.SetCanvasOverrideSorting(self._mapNode.obj_texBgCanvas, true)
  NovaAPI.SetCanvasSortingName(self._mapNode.obj_texBgCanvas, AllEnum.SortingLayerName.UI_Top)
  NovaAPI.SetCanvasSortingOrder(self._mapNode.canvasBtnClose, self._nSortingOrder + 15)
  self._mapNode.EditorDebug:SetActive(false)
  self._mapNode.typeMask:SetActive(false)
  self._mapNode.btnClose.gameObject:SetActive(false)
  self._mapNode.btnCount.gameObject:SetActive(false)
end

function GuideCtrl:ActiveGuidePanelEvent()
  self._mapNode.btnHide:SetActive(true)
  self.gameObject:SetActive(true)
  self:DoCurrentStepGuide()
end

function GuideCtrl:DeActiveGuidePanelEvent()
  self._mapNode.btnHide:SetActive(false)
  self.gameObject:SetActive(false)
end

function GuideCtrl:ActiveHide(isShow)
  self._mapNode.btnHide:SetActive(isShow)
end

function GuideCtrl:DoCurrentStepGuide()
  local gGroupData = ConfigTable.GetData("GuideGroup", PlayerData.Guide.runGroupId)
  if gGroupData == nil then
    traceback("无效的引导组id" .. tostring(PlayerData.Guide.runGroupId))
    return
  end
  if self.isDebugTest then
    package.loaded["Game.UI.Guide.GuideGruop." .. gGroupData.ScriptPath] = nil
  end
  local luaClass = require("Game.UI.Guide.GuideGruop." .. gGroupData.ScriptPath)
  if luaClass == nil then
    return
  end
  self.curGuide = luaClass
  if type(luaClass.GetSteps) == "function" then
    local GuideStepRunner = require("Game.UI.Guide.GuideStepRunner")
    GuideStepRunner.Start(self, luaClass)
    return
  end
  if type(self.curGuide.Init) == "function" then
    self.curGuide:Init(self, PlayerData.Guide.runStepId)
  end
end

function GuideCtrl:PlayTypeMask(msg)
  self._mapNode.btnShortcutClose.gameObject:SetActive(GamepadUIManager.GetInputState())
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.EnableGamepadUI("GuideCtrl", self.tbGamepadUINode)
  end
  self.tmpSort = nil
  local nSort = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
  if msg.tmpSort then
    self.tmpSort = nSort
    NovaAPI.SetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"), msg.tmpSort + 100)
    NovaAPI.SetCanvasSortingOrder(self._mapNode.imgHand1, msg.tmpSort + 115)
    NovaAPI.SetCanvasSortingOrder(self._mapNode.obj_texBgCanvas, msg.tmpSort + 115)
  else
    NovaAPI.SetCanvasSortingOrder(self._mapNode.imgHand1, nSort + 15)
    NovaAPI.SetCanvasSortingOrder(self._mapNode.obj_texBgCanvas, nSort + 15)
  end
  self.pre = self.gameObject.transform.localScale.x
  self._mapNode.typeMask:SetActive(false)
  self._mapNode.btnClose.gameObject:SetActive(false)
  self._mapNode.btnCount.gameObject:SetActive(false)
  self._mapNode.btnJump.gameObject:SetActive(false)
  self._mapNode.btnTempRect.gameObject:SetActive(false)
  clickCount = 0
  maxWaitTimeEnd = false
  self.doMsg = msg
  self._mapNode.btnHide:SetActive(true)
  self.gameObject:SetActive(true)
  self._mapNode.imgHand.gameObject:SetActive(false)
  self._mapNode.typeMask:SetActive(true)
  local tempRoot = GameObject.Find("---- UI ----").transform
  if msg.isUITop then
    tempRoot = GameObject.Find("---- UI TOP ----").transform
  end
  
  local function wait()
    maxWaitTimeEnd = true
    if clickCount > maxClickCount then
      local nSort = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
      NovaAPI.SetCanvasSortingOrder(self._mapNode.btnJump.gameObject:GetComponent("Canvas"), nSort + 16)
      NovaAPI.SetCanvasSortingName(self._mapNode.btnJump.gameObject:GetComponent("Canvas"), AllEnum.SortingLayerName.UI_Top)
      self._mapNode.btnJump.gameObject:SetActive(true)
    end
  end
  
  self.waitStep = TimerManager.Add(1, maxWaitTime, self, wait, true, true, true, nil)
  local objTemp = tempRoot:Find(msg.BindIcon)
  if msg.Child then
    objTemp = objTemp.transform:GetChild(msg.Child).gameObject
  end
  local closeObj
  if msg.CloseObj then
    closeObj = tempRoot:Find(msg.CloseObj)
    if closeObj then
      closeObj.gameObject:SetActive(false)
    end
  end
  local deActiveBtnObj
  if msg.DeActiveBtn then
    deActiveBtnObj = tempRoot:Find(msg.DeActiveBtn):GetComponent("UIButton")
    if deActiveBtnObj then
      deActiveBtnObj.enabled = false
    end
  end
  if objTemp == nil then
    printError("没有找到引导的图标 === " .. msg.BindIcon)
    local bSkipCompleteOnMiss = true
    if bSkipCompleteOnMiss then
      return
    end
    if self.curGuide ~= nil and type(self.curGuide.SendGuideStep) == "function" then
      self.curGuide:SendGuideStep(-1)
    end
    self:ClearCurGuide(true)
    return
  else
    self.objGuild = objTemp:GetComponent("RectTransform")
  end
  if msg.ScrollView then
    self.objScrollView = tempRoot:Find(msg.ScrollView):GetComponent("ScrollRect")
    NovaAPI.SetComponentEnable(self.objScrollView, false)
  end
  local sizeX = 0
  local sizeY = 0
  if not msg.Size then
    local objRect = self.objGuild.gameObject:GetComponent("RectTransform")
    sizeX = objRect.rect.width + 10
    sizeY = objRect.rect.height + 10
    if msg.AutoDeviationCenter then
      msg.Deviation[1] = sizeX / 2 + msg.Deviation[1]
      msg.Deviation[2] = -sizeY / 2 + msg.Deviation[2]
    elseif msg.AutoDeviationBottom then
      msg.Deviation[2] = -sizeY / 2 + msg.Deviation[2]
    elseif msg.AutoDeviationTop then
      msg.Deviation[2] = sizeY / 2 + msg.Deviation[2]
    end
  else
    sizeX = msg.Size[1]
    sizeY = msg.Size[2]
  end
  self._mapNode.imgMiddle.gameObject:SetActive(msg.isNoMiddle == nil)
  local sizeXPre = sizeX * self.pre
  local sizeYPre = sizeY * self.pre
  local offsetXPre = msg.Deviation[1] * self.pre
  local offsetYPre = msg.Deviation[2] * self.pre
  local objGuildPos = self.objGuild.position
  self._mapNode.imgLeft.position = Vector3(objGuildPos.x + offsetXPre - sizeXPre / 2 - self._mapNode.imgLeft.sizeDelta.x / 2 * self.pre, 0, 0)
  self._mapNode.imgRight.position = Vector3(objGuildPos.x + offsetXPre + sizeXPre / 2 + self._mapNode.imgRight.sizeDelta.x / 2 * self.pre, 0, 0)
  self._mapNode.imgLeft.localPosition = Vector3(self._mapNode.imgLeft.localPosition.x + 3, 0, 0)
  self._mapNode.imgRight.localPosition = Vector3(self._mapNode.imgRight.localPosition.x - 3, 0, 0)
  self._mapNode.imgTop.sizeDelta = Vector2(sizeX - 6, 1500)
  self._mapNode.imgTop.position = Vector3(objGuildPos.x + offsetXPre, objGuildPos.y + offsetYPre + sizeYPre / 2 + self._mapNode.imgTop.sizeDelta.y / 2 * self.pre, 0)
  self._mapNode.imgBottom.sizeDelta = Vector2(sizeX - 6, 1500)
  self._mapNode.imgBottom.position = Vector3(objGuildPos.x + offsetXPre, objGuildPos.y + offsetYPre - sizeYPre / 2 - self._mapNode.imgBottom.sizeDelta.y / 2 * self.pre, 0)
  self._mapNode.imgTop.localPosition = Vector3(self._mapNode.imgTop.localPosition.x, self._mapNode.imgTop.localPosition.y - 3, 0)
  self._mapNode.imgBottom.localPosition = Vector3(self._mapNode.imgBottom.localPosition.x, self._mapNode.imgBottom.localPosition.y + 3, 0)
  self._mapNode.imgMiddle.sizeDelta = Vector2(sizeX, sizeY)
  self._mapNode.imgMiddle.position = objGuildPos + Vector3(offsetXPre, offsetYPre, 0)
  if msg.Type == GameEnum.guidetype.ForcedClick then
    self.GuideUIHelpCS:AddCanvas(self.objGuild.gameObject)
    NovaAPI.SetCanvasSortingOrder(self._mapNode.btnCount.gameObject:GetComponent("Canvas"), nSort + 8)
    self._mapNode.btnCount.gameObject:SetActive(true)
    if msg.CallB then
      self._mapNode.btnTempRect.gameObject:SetActive(true)
      
      function self.addClickCb()
        if closeObj then
          closeObj.gameObject:SetActive(true)
        end
        if deActiveBtnObj then
          deActiveBtnObj.enabled = true
        end
        msg.CallB()
        self:FinishCurrentStep()
      end
      
      self._mapNode.btnTemp.onClick:AddListener(self.addClickCb)
      self._mapNode.btnTempRect.sizeDelta = Vector2(sizeX, sizeY)
      self._mapNode.btnTempRect.position = objGuildPos + Vector3(offsetXPre, offsetYPre, 0)
      local objBtnTempCanvase = self._mapNode.btnTempRect.gameObject:GetComponent("Canvas")
      NovaAPI.SetCanvasSortingOrder(objBtnTempCanvase, nSort + 16)
      NovaAPI.SetCanvasSortingName(objBtnTempCanvase, AllEnum.SortingLayerName.UI_Top)
    else
      function self.addClickCb()
        if closeObj then
          closeObj.gameObject:SetActive(true)
        end
        self:FinishCurrentStep()
      end
      
      self.objGuild:GetComponent("Button").onClick:AddListener(self.addClickCb)
    end
    self._mapNode.imgHand.gameObject:SetActive(true)
    local offsetHandXPre = msg.HandDeviation[1] * self.pre
    local offsetHandYPre = msg.HandDeviation[2] * self.pre
    self._mapNode.imgHand.position = objGuildPos + Vector3(offsetHandXPre, offsetHandYPre, 0)
    local _handRotation = 0
    if msg.HandRotation then
      _handRotation = msg.HandRotation
    end
    self._mapNode.imgHand.localRotation = Quaternion.Euler(0, 0, _handRotation)
    self._mapNode.ani_Middle:Play("GuidePanelHandMiddle_inLoop")
    WwiseAudioMgr:PlaySound("ui_common_guide_hint")
  else
    self._mapNode.ani_Middle:Play("GuidePanelHandMiddle_in")
    WwiseAudioMgr:PlaySound("ui_common_guide_hint")
  end
  if msg.Type == GameEnum.guidetype.Introductory then
    self._mapNode.btnClose.gameObject:SetActive(true)
    if msg.isShowHand then
      self._mapNode.imgHand.gameObject:SetActive(true)
      local offsetHandXPre = msg.HandDeviation[1] * self.pre
      local offsetHandYPre = msg.HandDeviation[2] * self.pre
      self._mapNode.imgHand.position = objGuildPos + Vector3(offsetHandXPre, offsetHandYPre, 0)
      local _handRotation = 0
      if msg.HandRotation then
        _handRotation = msg.HandRotation
      end
      self._mapNode.imgHand.localRotation = Quaternion.Euler(0, 0, _handRotation)
    end
  end
  if msg.Desc then
    self._mapNode.obj_texBg.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.texDesc, ConfigTable.GetUIText(msg.Desc))
    NovaAPI.SetTMPText(self._mapNode.texDescNoneHead, ConfigTable.GetUIText(msg.Desc))
    local offsetTexXPre = msg.DescDeviation[1] * self.pre
    local offsetTexYPre = msg.DescDeviation[2] * self.pre
    self._mapNode.obj_texBg.position = objGuildPos + Vector3(offsetTexXPre, offsetTexYPre, 0)
    self._mapNode.texDesc.gameObject:SetActive(msg.Head)
    self._mapNode.texDescNoneHead.gameObject:SetActive(not msg.Head)
    if msg.Head then
      self._mapNode.imgHead.gameObject:SetActive(true)
      self:SetPngSprite(self._mapNode.imgHead, msg.Head .. AllEnum.CharHeadIconSurfix.GD)
    else
      self._mapNode.imgHead.gameObject:SetActive(false)
    end
  else
    self._mapNode.obj_texBg.gameObject:SetActive(false)
  end
end

function GuideCtrl:ShowTypePopPicture(DicId)
  self._mapNode.btnHide:SetActive(false)
  if DicId ~= nil then
    EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, DicId, true)
  end
end

function GuideCtrl:PlayAvg(AvgId)
  self:ActiveHide(false)
  self._mapNode.blur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit("StoryDialog_DialogStart", AvgId)
  end
  
  cs_coroutine.start(wait)
end

function GuideCtrl:FinishCurrentStep()
  if self._fnStepClick ~= nil then
    local fnClick = self._fnStepClick
    fnClick()
    return
  end
  self:QuitGamepadUI()
  if self.objGuild then
    if self.doMsg.Type == GameEnum.guidetype.ForcedClick then
      self.GuideUIHelpCS:RemoveCanvas(self.objGuild.gameObject)
      if self.doMsg.CallB then
        self._mapNode.btnTempRect.gameObject:SetActive(false)
        self._mapNode.btnTemp.onClick:RemoveListener(self.addClickCb)
      else
        self.objGuild:GetComponent("Button").onClick:RemoveListener(self.addClickCb)
      end
    end
    self.objGuild = nil
    WwiseAudioMgr:PlaySound("ui_common_guide_hint_stop")
  end
  if self.objScrollView then
    NovaAPI.SetComponentEnable(self.objScrollView, true)
    self.objScrollView = nil
  end
  if self.tmpSort then
    NovaAPI.SetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"), self.tmpSort)
  end
  self._mapNode.typeMask:SetActive(false)
  self._mapNode.btnHide:SetActive(false)
  self._mapNode.btnTemp.gameObject:SetActive(false)
  self._mapNode.btnClose.gameObject:SetActive(false)
  self._mapNode.btnCount.gameObject:SetActive(false)
  self._mapNode.btnJump.gameObject:SetActive(false)
  self.doMsg = nil
  if self.waitStep then
    TimerManager.Remove(self.waitStep)
    self.waitStep = nil
  end
  if self.isDebugStep then
    return
  end
  self.curGuide:FinishCurrentStep()
end

function GuideCtrl:OnClickCount()
  clickCount = clickCount + 1
  if clickCount > maxClickCount and maxWaitTimeEnd and self._mapNode.btnJump.gameObject.activeSelf == false then
    local nSort = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
    NovaAPI.SetCanvasSortingOrder(self._mapNode.btnJump.gameObject:GetComponent("Canvas"), nSort + 16)
    NovaAPI.SetCanvasSortingName(self._mapNode.btnJump.gameObject:GetComponent("Canvas"), AllEnum.SortingLayerName.UI_Top)
    self._mapNode.btnJump.gameObject:SetActive(true)
  end
end

function GuideCtrl:OnGMSkipCurrentGuide()
  if self._objStepRunner ~= nil then
    self._objStepRunner:Stop("jump", true)
    return
  end
  if self.curGuide ~= nil and type(self.curGuide.SendGuideStep) == "function" then
    self.curGuide:SendGuideStep(-1)
  elseif PlayerData.Guide.isProcessing then
    self:SendGuideStep(PlayerData.Guide.runGroupId, -1)
  end
  if self.objGuild then
    if self.doMsg ~= nil and self.doMsg.Type == GameEnum.guidetype.ForcedClick and self.objGuild.gameObject ~= nil then
      self.GuideUIHelpCS:RemoveCanvas(self.objGuild.gameObject)
      self.objGuild:GetComponent("Button").onClick:RemoveListener(self.addClickCb)
    end
    self.objGuild = nil
    WwiseAudioMgr:PlaySound("ui_common_guide_hint_stop")
  end
  self.doMsg = nil
  self:ClearCurGuide(true)
  EventManager.Hit(EventId.AvgBubbleExit)
end

function GuideCtrl:OnClickJump()
  if self._objStepRunner ~= nil then
    self._objStepRunner:AskSkip()
    return
  end
  
  local function confirmCallback()
    self:OnGMSkipCurrentGuide()
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Guide_Jump_Tips"),
    callbackConfirm = confirmCallback,
    bBlur = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function GuideCtrl:SendGuideStep(groupId, stepId, type, season)
  if self.isDebugTest then
    return
  end
  PlayerData.Guide:SetPlayerLearnReq(groupId, stepId, type, season)
end

function GuideCtrl:ClearCurGuide(isCheak)
  if self._objStepRunner ~= nil then
    self._objStepRunner:Stop("cancel", false)
    return
  end
  self:QuitGamepadUI()
  self._mapNode.typeMask:SetActive(false)
  self._mapNode.btnHide:SetActive(false)
  self._mapNode.btnClose.gameObject:SetActive(false)
  self._mapNode.btnCount.gameObject:SetActive(false)
  self._mapNode.btnJump.gameObject:SetActive(false)
  self.curGuide:Clear()
  self.curGuide = nil
  self.gameObject:SetActive(false)
  if self.waitStep then
    TimerManager.Remove(self.waitStep)
    self.waitStep = nil
  end
  if self.isDebugStep then
    isCheak = false
  end
  PlayerData.Guide:FinishCurrentGroup(isCheak)
end

function GuideCtrl:NewDayClearGuide()
  if self._objStepRunner ~= nil then
    local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
    DormGuideAdapter.ClearPending()
    self._objStepRunner:Stop("newday", false)
    return
  end
  if PlayerData.Guide:GetGuideState() then
    if self.objGuild then
      if self.doMsg.Type == GameEnum.guidetype.ForcedClick then
        self.GuideUIHelpCS:RemoveCanvas(self.objGuild.gameObject)
        self.objGuild:GetComponent("Button").onClick:RemoveListener(self.addClickCb)
      end
      self.objGuild = nil
    end
    self.doMsg = nil
    self:ClearCurGuide(false)
  end
end

function GuideCtrl:OnDisable()
end

function GuideCtrl:OnDestroy()
  self.doGuideData = nil
end

function GuideCtrl:QuitGamepadUI()
  self._mapNode.btnShortcutClose.gameObject:SetActive(false)
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.DisableGamepadUI("GuideCtrl")
  end
end

function GuideCtrl:OnEvent_StoryDialog_DialogEnd()
  if self._mapNode.blur.activeSelf == false then
    return
  end
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, function()
    self._mapNode.blur:SetActive(false)
  end, true, true, true)
end

function GuideCtrl:DebugEditorStep()
  if self.curGuide ~= nil then
    self:ClearCurGuide(false)
  end
  self.isDebugTest = true
  if NovaAPI.GetInputFieldText(self._mapNode.InputFieldPassive) ~= "" then
    local tmpMsg = NovaAPI.GetInputFieldText(self._mapNode.InputFieldPassive)
    for i, v in pairs(PlayerData.Guide._guidePassiveTableData) do
      if v.PassiveMsg == tmpMsg then
        PlayerData.Guide.runGroupId = v.Id
        PlayerData.Guide.runStepId = 0
        PlayerData.Guide.isProcessing = true
        self:ActiveGuidePanelEvent()
      end
    end
    return
  end
  if NovaAPI.GetInputFieldText(self._mapNode.InputFieldStep) == "" then
    PlayerData.Guide.runGroupId = tonumber(NovaAPI.GetInputFieldText(self._mapNode.InputFieldDebug))
    PlayerData.Guide.runStepId = 0
    PlayerData.Guide.isProcessing = true
    self:ActiveGuidePanelEvent()
  else
    self.isDebugStep = true
    self.curGuide = nil
    local debugG = tonumber(NovaAPI.GetInputFieldText(self._mapNode.InputFieldDebug))
    local debugS = tonumber(NovaAPI.GetInputFieldText(self._mapNode.InputFieldStep))
    local gGroupData = ConfigTable.GetData("GuideGroup", debugG)
    package.loaded["Game.UI.Guide.GuideGruop." .. gGroupData.ScriptPath] = nil
    local luaClass = require("Game.UI.Guide.GuideGruop." .. gGroupData.ScriptPath)
    if luaClass == nil then
      return
    end
    self.curGuide = luaClass
    self.curGuide.parent = self
    self.curGuide:BindEvent()
    PlayerData.Guide.isProcessing = true
    local funName = "Step_" .. debugS
    local func = handler(self.curGuide, self.curGuide[funName])
    func()
    if self.curGuide.waitAinEnd then
      self:PlayTypeMask(self.curGuide.msg)
    end
  end
end

function GuideCtrl:DebugEditorClear()
  if self.curGuide ~= nil then
    self:ClearCurGuide(false)
  end
end

function GuideCtrl:UserEventUpload(strEventName, parme1, parme2)
end

function GuideCtrl:PlayTypeMask_505(msg)
  self._mapNode.btnShortcutClose.gameObject:SetActive(GamepadUIManager.GetInputState())
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.EnableGamepadUI("GuideCtrl", self.tbGamepadUINode)
  end
  self.tmpSort = nil
  local nSort = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
  if msg.tmpSort then
    self.tmpSort = nSort
    NovaAPI.SetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"), msg.tmpSort + 100)
    NovaAPI.SetCanvasSortingOrder(self._mapNode.imgHand1, msg.tmpSort + 115)
    NovaAPI.SetCanvasSortingOrder(self._mapNode.obj_texBgCanvas, msg.tmpSort + 115)
  else
    NovaAPI.SetCanvasSortingOrder(self._mapNode.imgHand1, nSort + 15)
    NovaAPI.SetCanvasSortingOrder(self._mapNode.obj_texBgCanvas, nSort + 15)
  end
  self.pre = self.gameObject.transform.localScale.x
  self._mapNode.typeMask:SetActive(false)
  self._mapNode.btnClose.gameObject:SetActive(false)
  self._mapNode.btnCount.gameObject:SetActive(false)
  self._mapNode.btnJump.gameObject:SetActive(false)
  self._mapNode.btnTempRect.gameObject:SetActive(false)
  clickCount = 0
  maxWaitTimeEnd = false
  self.doMsg = msg
  self._mapNode.btnHide:SetActive(true)
  self.gameObject:SetActive(true)
  self._mapNode.imgHand.gameObject:SetActive(false)
  self._mapNode.typeMask:SetActive(true)
  local tempRoot = GameObject.Find("---- UI ----").transform
  if msg.isUITop then
    tempRoot = GameObject.Find("---- UI TOP ----").transform
  end
  
  local function wait()
    maxWaitTimeEnd = true
    if clickCount > maxClickCount then
      local nSort = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
      NovaAPI.SetCanvasSortingOrder(self._mapNode.btnJump.gameObject:GetComponent("Canvas"), nSort + 16)
      NovaAPI.SetCanvasSortingName(self._mapNode.btnJump.gameObject:GetComponent("Canvas"), AllEnum.SortingLayerName.UI_Top)
      self._mapNode.btnJump.gameObject:SetActive(true)
    end
  end
  
  self.waitStep = TimerManager.Add(1, maxWaitTime, self, wait, true, true, true, nil)
  local objTemp = tempRoot:Find(msg.BindIcon)
  if msg.Child then
    objTemp = objTemp.transform:GetChild(msg.Child).gameObject
  end
  local closeObj
  if msg.CloseObj then
    closeObj = tempRoot:Find(msg.CloseObj)
    if closeObj then
      closeObj.gameObject:SetActive(false)
    end
  end
  local deActiveBtnObj
  if msg.DeActiveBtn then
    deActiveBtnObj = tempRoot:Find(msg.DeActiveBtn):GetComponent("UIButton")
    if deActiveBtnObj then
      deActiveBtnObj.enabled = false
    end
  end
  if objTemp == nil then
    self:SendGuideStep(PlayerData.Guide.runGroupId, -1)
    self:ClearCurGuide(true)
    printError("没有找打引导的图标 === " .. msg.BindIcon)
    return
  else
    self.objGuild = objTemp:GetComponent("RectTransform")
  end
  if msg.ScrollView then
    self.objScrollView = tempRoot:Find(msg.ScrollView):GetComponent("ScrollRect")
    NovaAPI.SetComponentEnable(self.objScrollView, false)
  end
  local sizeX = 0
  local sizeY = 0
  if not msg.Size then
    local objRect = self.objGuild.gameObject:GetComponent("RectTransform")
    sizeX = objRect.rect.width + 10
    sizeY = objRect.rect.height + 10
    if msg.AutoDeviationCenter then
      msg.Deviation[1] = sizeX / 2 + msg.Deviation[1]
      msg.Deviation[2] = -sizeY / 2 + msg.Deviation[2]
    elseif msg.AutoDeviationBottom then
      msg.Deviation[2] = -sizeY / 2 + msg.Deviation[2]
    elseif msg.AutoDeviationTop then
      msg.Deviation[2] = sizeY / 2 + msg.Deviation[2]
    end
  else
    sizeX = msg.Size[1]
    sizeY = msg.Size[2]
  end
  self._mapNode.imgMiddle.gameObject:SetActive(msg.isNoMiddle == nil)
  local sizeXPre = sizeX * self.pre
  local sizeYPre = sizeY * self.pre
  local offsetXPre = msg.Deviation[1] * self.pre
  local offsetYPre = msg.Deviation[2] * self.pre
  local objGuildPos = self.objGuild.position
  self._mapNode.imgLeft.position = Vector3(objGuildPos.x + offsetXPre - sizeXPre / 2 - self._mapNode.imgLeft.sizeDelta.x / 2 * self.pre, 0, 0)
  self._mapNode.imgRight.position = Vector3(objGuildPos.x + offsetXPre + sizeXPre / 2 + self._mapNode.imgRight.sizeDelta.x / 2 * self.pre, 0, 0)
  self._mapNode.imgLeft.localPosition = Vector3(self._mapNode.imgLeft.localPosition.x + 3, 0, 0)
  self._mapNode.imgRight.localPosition = Vector3(self._mapNode.imgRight.localPosition.x - 3, 0, 0)
  self._mapNode.imgTop.sizeDelta = Vector2(sizeX - 6, 1500)
  self._mapNode.imgTop.position = Vector3(objGuildPos.x + offsetXPre, objGuildPos.y + offsetYPre + sizeYPre / 2 + self._mapNode.imgTop.sizeDelta.y / 2 * self.pre, 0)
  self._mapNode.imgBottom.sizeDelta = Vector2(sizeX - 6, 1500)
  self._mapNode.imgBottom.position = Vector3(objGuildPos.x + offsetXPre, objGuildPos.y + offsetYPre - sizeYPre / 2 - self._mapNode.imgBottom.sizeDelta.y / 2 * self.pre, 0)
  self._mapNode.imgTop.localPosition = Vector3(self._mapNode.imgTop.localPosition.x, self._mapNode.imgTop.localPosition.y - 3, 0)
  self._mapNode.imgBottom.localPosition = Vector3(self._mapNode.imgBottom.localPosition.x, self._mapNode.imgBottom.localPosition.y + 3, 0)
  self._mapNode.imgMiddle.sizeDelta = Vector2(sizeX, sizeY)
  self._mapNode.imgMiddle.position = objGuildPos + Vector3(offsetXPre, offsetYPre, 0)
  self.GuideUIHelpCS:AddCanvas(self.objGuild.gameObject)
  NovaAPI.SetCanvasSortingOrder(self._mapNode.btnCount.gameObject:GetComponent("Canvas"), nSort + 8)
  self._mapNode.btnCount.gameObject:SetActive(true)
  self._mapNode.imgHand.gameObject:SetActive(true)
  local offsetHandXPre = msg.HandDeviation[1] * self.pre
  local offsetHandYPre = msg.HandDeviation[2] * self.pre
  self._mapNode.imgHand.position = objGuildPos + Vector3(offsetHandXPre, offsetHandYPre, 0)
  local _handRotation = 0
  if msg.HandRotation then
    _handRotation = msg.HandRotation
  end
  self._mapNode.imgHand.localRotation = Quaternion.Euler(0, 0, _handRotation)
  self._mapNode.ani_Middle:Play("GuidePanelHandMiddle_inLoop")
  WwiseAudioMgr:PlaySound("ui_common_guide_hint")
  if msg.Desc then
    self._mapNode.obj_texBg.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.texDesc, ConfigTable.GetUIText(msg.Desc))
    NovaAPI.SetTMPText(self._mapNode.texDescNoneHead, ConfigTable.GetUIText(msg.Desc))
    local offsetTexXPre = msg.DescDeviation[1] * self.pre
    local offsetTexYPre = msg.DescDeviation[2] * self.pre
    self._mapNode.obj_texBg.position = objGuildPos + Vector3(offsetTexXPre, offsetTexYPre, 0)
    self._mapNode.texDesc.gameObject:SetActive(msg.Head)
    self._mapNode.texDescNoneHead.gameObject:SetActive(not msg.Head)
    if msg.Head then
      self._mapNode.imgHead.gameObject:SetActive(true)
      self:SetPngSprite(self._mapNode.imgHead, msg.Head .. AllEnum.CharHeadIconSurfix.GD)
    else
      self._mapNode.imgHead.gameObject:SetActive(false)
    end
  else
    self._mapNode.obj_texBg.gameObject:SetActive(false)
  end
end

function GuideCtrl:FinishRunnerGroup(bCheck)
  self:QuitGamepadUI()
  self._fnStepClick = nil
  self._mapNode.typeMask:SetActive(false)
  self._mapNode.btnHide:SetActive(false)
  self._mapNode.btnTempRect.gameObject:SetActive(false)
  self._mapNode.btnClose.gameObject:SetActive(false)
  self._mapNode.btnCount.gameObject:SetActive(false)
  self._mapNode.btnJump.gameObject:SetActive(false)
  self.curGuide = nil
  self.gameObject:SetActive(false)
  if self.waitStep then
    TimerManager.Remove(self.waitStep)
    self.waitStep = nil
  end
  if self.isDebugStep then
    bCheck = false
  end
  PlayerData.Guide:FinishCurrentGroup(bCheck)
end

function GuideCtrl:ApplyRunnerPolicy(mapPolicy)
  local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
  local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
  
  function DormGuideUI._objParentBarrier(bOn)
    if self._mapNode == nil or self._mapNode.btnHide == nil then
      return
    end
    self._mapNode.btnHide:SetActive(bOn == true)
    if bOn == true then
      self.gameObject:SetActive(true)
    end
  end
  
  DormGuideAdapter.ApplyPolicy(mapPolicy)
end

function GuideCtrl:IsRunnerBudgetFrozen()
  local PanelManager = require("GameCore.UI.PanelManager")
  local tbPanel = {
    PanelId.DictionaryEntry,
    PanelId.CharFavourLevelUp,
    PanelId.ReceivePropsTips,
    PanelId.ReceivePropsNPC,
    PanelId.ReceiveAutoTrans,
    PanelId.ReceiveSpecialReward
  }
  for _, nPanelId in ipairs(tbPanel) do
    if PanelManager.CheckPanelOpen(nPanelId) then
      return true
    end
  end
  return false
end

function GuideCtrl:SetRunnerSkipVisible(bVisible)
  local go = self._mapNode.btnJump.gameObject
  if bVisible then
    local nSort = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
    NovaAPI.SetCanvasSortingOrder(go:GetComponent("Canvas"), nSort + 17)
    NovaAPI.SetCanvasSortingName(go:GetComponent("Canvas"), AllEnum.SortingLayerName.UI_Top)
    self.gameObject:SetActive(true)
  end
  go:SetActive(bVisible == true)
end

function GuideCtrl:PlayStepMask(trTarget, mapMask, fnClick)
  self:ReleaseStepVisual(true)
  if trTarget == nil then
    return
  end
  self._fnStepClick = fnClick
  self.pre = self.gameObject.transform.localScale.x
  local nSort = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
  NovaAPI.SetCanvasSortingOrder(self._mapNode.imgHand1, nSort + 15)
  NovaAPI.SetCanvasSortingOrder(self._mapNode.obj_texBgCanvas, nSort + 15)
  self._mapNode.btnClose.gameObject:SetActive(false)
  self._mapNode.btnCount.gameObject:SetActive(false)
  self._mapNode.btnJump.gameObject:SetActive(false)
  self._mapNode.btnShortcutClose.gameObject:SetActive(false)
  self.gameObject:SetActive(true)
  self._mapNode.btnHide:SetActive(true)
  self._mapNode.typeMask:SetActive(true)
  self._mapNode.imgHand.gameObject:SetActive(false)
  self.objGuild = trTarget:GetComponent("RectTransform")
  if self.objGuild == nil and trTarget.gameObject ~= nil then
    self.objGuild = trTarget.gameObject:GetComponent("RectTransform")
  end
  if self.objGuild == nil then
    self._fnStepClick = nil
    self._mapNode.typeMask:SetActive(false)
    return
  end
  local sizeX = mapMask.Size ~= nil and mapMask.Size[1] or self.objGuild.rect.width + 10
  local sizeY = mapMask.Size ~= nil and mapMask.Size[2] or self.objGuild.rect.height + 10
  local nDevX = mapMask.Deviation ~= nil and mapMask.Deviation[1] or 0
  local nDevY = mapMask.Deviation ~= nil and mapMask.Deviation[2] or 0
  local sizeXPre = sizeX * self.pre
  local sizeYPre = sizeY * self.pre
  local offsetXPre = nDevX * self.pre
  local offsetYPre = nDevY * self.pre
  local objGuildPos = self.objGuild.position
  self._mapNode.imgMiddle.gameObject:SetActive(true)
  self._mapNode.imgLeft.position = Vector3(objGuildPos.x + offsetXPre - sizeXPre / 2 - self._mapNode.imgLeft.sizeDelta.x / 2 * self.pre, 0, 0)
  self._mapNode.imgRight.position = Vector3(objGuildPos.x + offsetXPre + sizeXPre / 2 + self._mapNode.imgRight.sizeDelta.x / 2 * self.pre, 0, 0)
  self._mapNode.imgLeft.localPosition = Vector3(self._mapNode.imgLeft.localPosition.x + 3, 0, 0)
  self._mapNode.imgRight.localPosition = Vector3(self._mapNode.imgRight.localPosition.x - 3, 0, 0)
  self._mapNode.imgTop.sizeDelta = Vector2(sizeX - 6, 1500)
  self._mapNode.imgTop.position = Vector3(objGuildPos.x + offsetXPre, objGuildPos.y + offsetYPre + sizeYPre / 2 + self._mapNode.imgTop.sizeDelta.y / 2 * self.pre, 0)
  self._mapNode.imgBottom.sizeDelta = Vector2(sizeX - 6, 1500)
  self._mapNode.imgBottom.position = Vector3(objGuildPos.x + offsetXPre, objGuildPos.y + offsetYPre - sizeYPre / 2 - self._mapNode.imgBottom.sizeDelta.y / 2 * self.pre, 0)
  self._mapNode.imgTop.localPosition = Vector3(self._mapNode.imgTop.localPosition.x, self._mapNode.imgTop.localPosition.y - 3, 0)
  self._mapNode.imgBottom.localPosition = Vector3(self._mapNode.imgBottom.localPosition.x, self._mapNode.imgBottom.localPosition.y + 3, 0)
  self._mapNode.imgMiddle.sizeDelta = Vector2(sizeX, sizeY)
  self._mapNode.imgMiddle.position = objGuildPos + Vector3(offsetXPre, offsetYPre, 0)
  self.GuideUIHelpCS:AddCanvas(self.objGuild.gameObject)
  self._mapNode.btnTempRect.gameObject:SetActive(true)
  self._mapNode.btnTempRect.sizeDelta = Vector2(sizeX, sizeY)
  self._mapNode.btnTempRect.position = objGuildPos + Vector3(offsetXPre, offsetYPre, 0)
  local objBtnTempCanvase = self._mapNode.btnTempRect.gameObject:GetComponent("Canvas")
  NovaAPI.SetCanvasSortingOrder(objBtnTempCanvase, nSort + 16)
  NovaAPI.SetCanvasSortingName(objBtnTempCanvase, AllEnum.SortingLayerName.UI_Top)
  
  function self.addClickCb()
    if self._fnStepClick ~= nil then
      local fn = self._fnStepClick
      fn()
    end
  end
  
  self._mapNode.btnTemp.onClick:AddListener(self.addClickCb)
  self._mapNode.imgHand.gameObject:SetActive(true)
  local nHandX = mapMask.HandDeviation ~= nil and mapMask.HandDeviation[1] or 0
  local nHandY = mapMask.HandDeviation ~= nil and mapMask.HandDeviation[2] or 0
  self._mapNode.imgHand.position = objGuildPos + Vector3(nHandX * self.pre, nHandY * self.pre, 0)
  self._mapNode.imgHand.localRotation = Quaternion.Euler(0, 0, mapMask.HandRotation or 0)
  self._mapNode.ani_Middle:Play("GuidePanelHandMiddle_inLoop")
  WwiseAudioMgr:PlaySound("ui_common_guide_hint")
  if mapMask.Desc then
    self._mapNode.obj_texBg.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.texDesc, ConfigTable.GetUIText(mapMask.Desc))
    NovaAPI.SetTMPText(self._mapNode.texDescNoneHead, ConfigTable.GetUIText(mapMask.Desc))
    local nTexX = mapMask.DescDeviation ~= nil and mapMask.DescDeviation[1] or 0
    local nTexY = mapMask.DescDeviation ~= nil and mapMask.DescDeviation[2] or 0
    self._mapNode.obj_texBg.position = objGuildPos + Vector3(nTexX * self.pre, nTexY * self.pre, 0)
    self._mapNode.texDesc.gameObject:SetActive(mapMask.Head ~= nil)
    self._mapNode.texDescNoneHead.gameObject:SetActive(mapMask.Head == nil)
    if mapMask.Head then
      self._mapNode.imgHead.gameObject:SetActive(true)
      self:SetPngSprite(self._mapNode.imgHead, mapMask.Head .. AllEnum.CharHeadIconSurfix.GD)
    else
      self._mapNode.imgHead.gameObject:SetActive(false)
    end
  else
    self._mapNode.obj_texBg.gameObject:SetActive(false)
  end
  return true
end

function GuideCtrl:ReleaseStepVisual(bKeepBarrier)
  self._fnStepClick = nil
  if self.objGuild ~= nil and self.GuideUIHelpCS ~= nil then
    self.GuideUIHelpCS:RemoveCanvas(self.objGuild.gameObject)
    self.objGuild = nil
  end
  if self.addClickCb ~= nil and self._mapNode.btnTemp ~= nil then
    self._mapNode.btnTemp.onClick:RemoveListener(self.addClickCb)
    self.addClickCb = nil
  end
  self._mapNode.typeMask:SetActive(false)
  self._mapNode.btnTempRect.gameObject:SetActive(false)
  self._mapNode.imgHand.gameObject:SetActive(false)
  self._mapNode.obj_texBg.gameObject:SetActive(false)
  WwiseAudioMgr:PlaySound("ui_common_guide_hint_stop")
  if not bKeepBarrier then
    self._mapNode.btnHide:SetActive(false)
  end
end

function GuideCtrl:InvokeRunnerTarget(trTarget)
  if trTarget == nil then
    return {sState = "rejected"}
  end
  local btn = trTarget:GetComponent("UIButton")
  if btn == nil or btn.onClick == nil then
    return {sState = "rejected"}
  end
  btn.onClick:Invoke()
  return {sState = "accepted"}
end

function GuideCtrl:PlayRunnerAvg(mapPresent, fnEnd)
  if mapPresent == nil or mapPresent.sAvgId == nil or mapPresent.sAvgId == "" then
    printError("[DormGuide] BBAVG 未配置，不能播放靠近提示")
    return false
  end
  self:CancelRunnerPresent()
  self._fnRunnerPresentEnd = fnEnd
  self._bRunnerPresentCancel = false
  self._bRunnerPresentDone = false
  self._sRunnerPresent = "avg"
  EventManager.Add(EventId.AvgBubbleExit, self, self._OnRunnerAvgExit)
  self:ActiveHide(false)
  EventManager.Hit(EventId.AvgBubbleShow, mapPresent.sAvgId, mapPresent.sAvgGroup or "1")
  return true
end

function GuideCtrl:_OnRunnerAvgExit()
  if self._sRunnerPresent ~= "avg" then
    return
  end
  EventManager.Remove(EventId.AvgBubbleExit, self, self._OnRunnerAvgExit)
  local bNatural = self._bRunnerPresentCancel ~= true
  self._bRunnerPresentDone = true
  self._sRunnerPresent = nil
  local fn = self._fnRunnerPresentEnd
  self._fnRunnerPresentEnd = nil
  if bNatural and fn ~= nil then
    fn(true)
  end
end

function GuideCtrl:PlayRunnerDict(mapPresent, fnEnd)
  if mapPresent == nil or mapPresent.nDictId == nil then
    return false
  end
  if ConfigTable.GetData("DictionaryEntry", mapPresent.nDictId, true) == nil then
    printError("[DormGuide] 字典不存在 " .. tostring(mapPresent.nDictId))
    return false
  end
  self:CancelRunnerPresent()
  self._fnRunnerPresentEnd = fnEnd
  self._bRunnerPresentCancel = false
  self._bRunnerPresentDone = false
  self._sRunnerPresent = "dict"
  self._nRunnerDictId = mapPresent.nDictId
  self:ActiveHide(false)
  EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, mapPresent.nDictId, true, function()
    if self._bRunnerPresentCancel or self._bRunnerPresentDone or self._sRunnerPresent ~= "dict" then
      return
    end
    if self._nRunnerDictId ~= mapPresent.nDictId or self._fnRunnerPresentEnd ~= fnEnd then
      return
    end
    self._bRunnerPresentDone = true
    self._sRunnerPresent = nil
    local fn = self._fnRunnerPresentEnd
    self._fnRunnerPresentEnd = nil
    if fn ~= nil then
      fn(true)
    end
  end)
  return true
end

function GuideCtrl:CancelRunnerPresent()
  if self._sRunnerPresent == "avg" then
    self._bRunnerPresentCancel = true
    EventManager.Remove(EventId.AvgBubbleExit, self, self._OnRunnerAvgExit)
    self._sRunnerPresent = nil
    self._fnRunnerPresentEnd = nil
    return
  end
  if self._sRunnerPresent == "dict" then
    self._bRunnerPresentCancel = true
    self._sRunnerPresent = nil
    self._fnRunnerPresentEnd = nil
  end
end

function GuideCtrl:OpenRunnerSkip(nGroup, nStep, nConfirm, fnConfirm, fnCancel)
  self._nSkipGroup = nGroup
  self._nSkipStep = nStep
  self._nSkipConfirm = nConfirm
  
  local function confirmCallback()
    if self._nSkipGroup ~= nGroup or self._nSkipStep ~= nStep or self._nSkipConfirm ~= nConfirm then
      return
    end
    self._nSkipGroup = nil
    if fnConfirm ~= nil then
      fnConfirm()
    end
  end
  
  local function cancelCallback()
    if self._nSkipGroup ~= nGroup or self._nSkipStep ~= nStep or self._nSkipConfirm ~= nConfirm then
      return
    end
    self._nSkipGroup = nil
    if fnCancel ~= nil then
      fnCancel()
    end
  end
  
  EventManager.Hit(EventId.OpenMessageBox, {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Guide_Jump_Tips"),
    callbackConfirm = confirmCallback,
    callbackCancel = cancelCallback,
    bBlur = false
  })
end

function GuideCtrl:CloseRunnerSkip()
  self._nSkipGroup = nil
  self._nSkipStep = nil
  self._nSkipConfirm = nil
end

return GuideCtrl

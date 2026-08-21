_class("UIN20AVGStory", UIController)
UIN20AVGStory = UIN20AVGStory

function UIN20AVGStory:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
  self.passSectionIds = {}
  self.selectedOptionIds = {}
  self.nextNodeId = 0
  self.onDialogEndCallback = nil
  self.colorInfluenceBG = {
    Color(0, 0, 0, 0.5),
    Color(0, 0, 0, 0)
  }
end

function UIN20AVGStory:OnShow(uiParams)
  local nodeId = uiParams[1]
  self:NodeId(nodeId)
  self._revertBGM = uiParams[4] ~= false
  self._debugMode = uiParams[5]
  self._ignoreBreak = uiParams[6]
  self._uiCanvasRect = self:GetUIComponent("RectTransform", "UICanvas")
  self._rootGameObject = self:GetGameObject("StoryRoot")
  self._dialogRootGameObject = self:GetGameObject("DialogRoot")
  self._maskTemplate = self:GetGameObject("MaskTemplate")
  self._maskTemplate:SetActive(false)
  self._maskHorizontalTemplate = self:GetGameObject("MaskHorizontalTemplate")
  self._maskHorizontalTemplate:SetActive(false)
  self._spineSliceMaskTemplate = self:GetGameObject("SpineSliceMaskTemplate")
  self._spineSliceMaskTemplate:SetActive(false)
  self._spineSliceHorizontalMaskTemplate = self:GetGameObject("SpineSliceHorizontalMaskTemplate")
  self._spineSliceHorizontalMaskTemplate:SetActive(false)
  self._spineCircleMaskTemplate = self:GetGameObject("SpineCircleMaskTemplate")
  self._spineCircleMaskTemplate:SetActive(false)
  self._topBlackSide = self:GetGameObject("Top")
  self._topBlackSide:SetActive(false)
  self._bottomBlackSide = self:GetGameObject("Bottom")
  self._bottomBlackSide:SetActive(false)
  self._leftBlackSide = self:GetGameObject("Left")
  self._leftBlackSide:SetActive(false)
  self._rightBlackSide = self:GetGameObject("Right")
  self._rightBlackSide:SetActive(false)
  local poolLeader = self:GetUIComponent("UISelectObjectPath", "leader")
  self.leader = poolLeader:SpawnObject("UIN20AVGActor")
  self.goAuto = self:GetGameObject("goAuto")
  self.imgAuto = self:GetUIComponent("Image", "btnAuto")
  self.btnReview = self:GetGameObject("btnReview")
  self.goShowHideUI = self:GetGameObject("goShowHideUI")
  self.btnNext = self:GetGameObject("btnNext")
  self.btnNextImg = self:GetUIComponent("Image", "btnNext")
  self.btnGraph = self:GetGameObject("btnGraph")
  self.btnExit = self:GetGameObject("btnExit")
  self.goOptions = self:GetGameObject("goOptions")
  self:ShowHideOption(false)
  self.poolOptions = self:GetUIComponent("UISelectObjectPath", "options")
  self.poolInfluence = self:GetUIComponent("UISelectObjectPath", "influence")
  self.ui = self:GetGameObject("ui")
  self.imgShowUI = self:GetGameObject("imgShowUI")
  self.imgShowUI:SetActive(false)
  self._uiAtlas = self:GetAsset("UIStory.spriteatlas", LoadType.SpriteAtlas)
  self.txtDebug = self:GetUIComponent("UILocalizationText", "txtDebug")
  if IsUnityEditor() then
    self.txtDebug.gameObject:SetActive(true)
  else
    self.txtDebug.gameObject:SetActive(false)
  end
  self:AttachEvent(GameEventType.AVGOnDialogEnd, self.AVGOnDialogEnd)
  self:AttachEvent(GameEventType.AVGShowOption, self.AVGShowOption)
  self.fsm = StateMachineManager:GetInstance():CreateStateMachine("StateAVGStory", StateAVGStory)
  self.fsm:SetData(self)
  self.fsm:Init(StateAVGStory.Init)
  self:FlushData()
end

function UIN20AVGStory:OnHide()
  self:DetachEvent(GameEventType.AVGOnDialogEnd, self.AVGOnDialogEnd)
  self:DetachEvent(GameEventType.AVGShowOption, self.AVGShowOption)
  self._storyManager:Destroy()
  self._storyManager = nil
  self.fsm:SetData(nil)
  StateMachineManager:GetInstance():DestroyStateMachine(self.fsm.Id)
  self.fsm = nil
end

function UIN20AVGStory:InitStoryManager()
  local node = self.data:GetNodeById(self.nodeId)
  if not node then
    AVGLog("no node. nodeId", self.nodeId)
    return
  end
  local storyId = node.storyId
  self._storyManager = StoryManager:New(self, storyId, self._revertBGM, self._ignoreBreak)
  self._entityInfo = nil
  self._storyManager:Init(self._debugMode, self._entityInfo)
  self.data:StoryManager(self._storyManager)
end

function UIN20AVGStory:FlushData()
  local hp, strategies = self:CalcCurData()
  self.leader:Flush(0, hp)
end

function UIN20AVGStory:PlayAnimHP(hpDelta)
  self.leader:PlayAnim(hpDelta)
  if hpDelta < 0 then
    UIWidgetHelper.PlayAnimation(self, "anim_effRedDown", "uieff_UIN20_Favorability_downan", 2000)
  end
end

function UIN20AVGStory:NodeId(nodeId)
  if nodeId then
    self.nodeId = nodeId
  else
    return self.nodeId
  end
end

function UIN20AVGStory:NextNodeId(nextNodeId)
  if nextNodeId then
    if nextNodeId ~= 0 then
      self.nextNodeId = nextNodeId
    end
  else
    return self.nextNodeId
  end
end

function UIN20AVGStory:PassSectionId(sectionSign)
  if sectionSign then
    return self.passSectionIds[sectionSign]
  else
    return self.passSectionIds
  end
end

function UIN20AVGStory:SetPassSectionId(sectionSign, b)
  if b then
    self.passSectionIds[sectionSign] = true
  else
    self.passSectionIds[sectionSign] = nil
  end
  if IsUnityEditor() then
    local signStr = ""
    for sign, b in pairs(self.passSectionIds) do
      if b then
        signStr = signStr .. sign .. ";"
      end
    end
    AVGLog("------------passSectionIds changed------------", signStr)
  end
end

function UIN20AVGStory:ClearPassSectionIds()
  self.passSectionIds = {}
  self:FlushData()
end

function UIN20AVGStory:SelectedOptionId(optionId)
  if optionId then
    return self.selectedOptionIds[optionId]
  else
    return self.selectedOptionIds
  end
end

function UIN20AVGStory:SetSelectedOptionId(optionId, b)
  if b then
    self.selectedOptionIds[optionId] = true
  else
    self.selectedOptionIds[optionId] = nil
  end
end

function UIN20AVGStory:ClearSelectedOptionIds()
  self.selectedOptionIds = {}
end

function UIN20AVGStory:CalcCurData()
  local nodeId = self:NodeId()
  local node = self.data:GetNodeById(nodeId)
  local hp, strategies = node:StartData()
  local node = self.data:GetNodeById(nodeId)
  local passSectionIds = self:PassSectionId()
  if passSectionIds then
    for sign, b in pairs(passSectionIds) do
      if b then
        local tNumbers = N20AVGData.Sign2Numbers(sign)
        local storyId = tNumbers[1]
        local paragraphId = tNumbers[2]
        local sectionIdx = tNumbers[3]
        local paragraph = node:GetParagraphByParagraphId(paragraphId)
        local dialog = paragraph:GetDialogBySectionIdx(sectionIdx)
        local vc = dialog:ValueChange()
        if vc then
          for index, value in ipairs(vc) do
            if index == 1 then
              hp = hp + value
            else
              local indexPartner = index - 1
              if strategies and strategies[indexPartner] then
                strategies[indexPartner] = strategies[indexPartner] + value
              end
            end
          end
        end
      end
    end
  end
  local minHP, maxHP = self.data.actorLeader.min, self.data.actorLeader.max
  hp = Mathf.Clamp(hp, minHP, maxHP)
  for index, _ in ipairs(strategies) do
    local partner = self.data.actorPartners[index]
    local minStrategy, maxStrategy = partner.min, partner.max
    strategies[index] = Mathf.Clamp(strategies[index], minStrategy, maxStrategy)
  end
  return hp, strategies
end

function UIN20AVGStory:OnUpdate(deltaTimeMS)
  if self.fsm then
    self.fsm:OnUpdate(deltaTimeMS)
  end
end

function UIN20AVGStory:UpdateDriveByState(deltaTimeMS)
  if not self._storyManager then
    return
  end
  self._storyManager:Update(deltaTimeMS)
  if self._storyManager:IsEnd() then
    self:_EndStory()
    return
  end
end

function UIN20AVGStory:_EndStory()
  GameGlobal.UIStateManager():SetBlackSideVisible(true)
  self.fsm:ChangeState(StateAVGStory.BECheck, self._storyManager._auto or false)
end

function UIN20AVGStory:SetBlackSideSize(width, height)
  self._topBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(0, height)
  self._bottomBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(0, height)
  self._topBlackSide:SetActive(0 < height)
  self._bottomBlackSide:SetActive(0 < height)
  self._leftBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(width, 0)
  self._rightBlackSide:GetComponent("RectTransform").sizeDelta = Vector2(width, 0)
  self._leftBlackSide:SetActive(0 < width)
  self._rightBlackSide:SetActive(0 < width)
end

function UIN20AVGStory:GetCanvasSize()
  return self._uiCanvasRect.sizeDelta.x, self._uiCanvasRect.sizeDelta.y
end

function UIN20AVGStory:AVGOnDialogEnd()
  self.fsm:ChangeState(StateAVGStory.BECheck, self._storyManager._auto or false)
end

function UIN20AVGStory:SetAVGOnDialogEnd(onDialogEndCallback)
  self.onDialogEndCallback = onDialogEndCallback
end

function UIN20AVGStory:AVGShowOption()
  self.fsm:ChangeState(StateAVGStory.Option)
end

function UIN20AVGStory:ShowHideOption(isShow)
  self.goOptions:SetActive(isShow)
  self.btnNextImg.raycastTarget = not isShow
end

function UIN20AVGStory:IsAuto()
  local isAuto = self._storyManager._auto
  return isAuto
end

function UIN20AVGStory:PlayFromBegain(nodeId)
  if self._storyManager._storyEntityList then
    for index, storyEntity in ipairs(self._storyManager._storyEntityList) do
      local go = storyEntity._gameObject
      UnityEngine.GameObject.Destroy(go)
    end
  end
  self._storyManager:Destroy()
  self:NodeId(nodeId)
  self.fsm:ChangeState(StateAVGStory.Init)
end

function UIN20AVGStory:bgOnClick(go)
  Log.fatal("### bgOnClick")
end

function UIN20AVGStory:btnAutoOnClick(go)
  if self:IsAuto() then
    self.fsm:ChangeState(StateAVGStory.Play)
  else
    self.fsm:ChangeState(StateAVGStory.Auto)
  end
end

function UIN20AVGStory:btnReviewOnClick(go)
  self:ShowDialog("UIN20AVGReview")
end

function UIN20AVGStory:btnShowHideUIOnClick(go)
  self._storyManager:HideUI(true)
  self.ui:SetActive(false)
  self.imgShowUI:SetActive(true)
end

function UIN20AVGStory:imgShowUIOnClick(go)
  self._storyManager:HideUI(false)
  self.ui:SetActive(true)
  self.imgShowUI:SetActive(false)
end

function UIN20AVGStory:btnNextOnClick(go)
  self.fsm:ChangeState(StateAVGStory.Next)
end

function UIN20AVGStory:btnGraphOnClick(go)
  self:ShowDialog("UIN20AVGGraph", true)
end

function UIN20AVGStory:btnExitOnClick(go)
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_avg_n20_exit_plot_hint"), function()
    self:SwitchState(UIStateType.UIN20AVGMain)
  end)
end

StateAVGStory = {
  Init = 0,
  Play = 1,
  Auto = 2,
  Next = 3,
  Option = 4,
  BECheck = 5,
  Over = 6
}

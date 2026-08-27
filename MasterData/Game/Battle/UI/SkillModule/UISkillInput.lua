local UISkillInput = class("UISkillInput", UIBaseNode)
local base = UIBaseNode
local csInputUtility = CS.InputUtility
local cs_MessageCommon = CS.MessageCommon
local CS_CanvasGroup = CS.UnityEngine.CanvasGroup

function UISkillInput:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_cancle, self, self.__onClick)
  self.cancleButton = self.ui.btn_cancle
  self.onButtonImageChanged = BindCallback(self, self.__onButtonImageChanged)
  self.defaultTip = self.ui.text_messageTips.text
  
  function self.__UltStartAction()
    self:UpdateInputStateUI(true)
  end
  
  function self.__UltEndAction()
    self:UpdateInputStateUI(false)
  end
  
  function self._MonStageShowStartFunc()
    self:UpdateInputStateUI(true)
  end
  
  function self._MonStageShowEndFunc()
    self:UpdateInputStateUI(false)
  end
  
  MsgCenter:AddListener(eMsgEventId.OnMonsterStageShowStart, self._MonStageShowStartFunc)
  MsgCenter:AddListener(eMsgEventId.OnMonsterStageShowEnd, self._MonStageShowEndFunc)
end

function UISkillInput:OnShow()
  self.ui.messageTips:SetActive(true)
  self.ui.img_cancle.color = self.ui.img_cancle_normalColor
  self.transform:SetAsLastSibling()
  self.detectedButtonChangedTimerId = TimerManager:StartTimer(0.1, self.onButtonImageChanged, self, false, false, true)
  self:__CheckBuffListSetAbleToPointer(false)
  self:UpdateInputStateUI(true)
end

function UISkillInput:__CheckBuffListSetAbleToPointer(able)
  local stateInfoWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWindow == nil then
    return
  end
  local buffListNode = stateInfoWindow.buffList
  if buffListNode == nil then
    return
  end
  buffListNode:SetBuffListAbleToPointer(able)
end

function UISkillInput:__onButtonImageChanged()
  if csInputUtility.OverUIValidTag(TagConsts.ValidTarget) then
    self.ui.img_cancle.color = self.ui.img_cancle_HighlightColor
  else
    self.ui.img_cancle.color = self.ui.img_cancle_normalColor
  end
end

function UISkillInput:OnHide()
  self:__CheckBuffListSetAbleToPointer(true)
  self.ui.img_cancle.color = self.ui.img_cancle_normalColor
  TimerManager:StopTimer(self.detectedButtonChangedTimerId)
  self.ui.messageTips:SetActive(false)
  self:UpdateInputStateUI(false)
  self:__ClearSkillInputCtrlData()
end

function UISkillInput:InjectCancleInputAction(cancleFunc)
  self.cancleFunc = cancleFunc
end

function UISkillInput:RefreshUITip(tipText)
  if string.IsNullOrEmpty(tipText) then
    tipText = self.defaultTip
  end
  self.ui.text_messageTips.text = tipText
end

function UISkillInput:__ClearSkillInputCtrlData()
  if LuaSkillCtrl.battleCtrl == nil then
    return
  end
  local inputCtrl = LuaSkillCtrl.battleCtrl.PlayerController.battleSkillInputController
  if inputCtrl ~= nil then
    inputCtrl.lastRoleTile = nil
  end
end

function UISkillInput:__onClick()
  if self.cancleFunc ~= nil then
    self.cancleFunc()
  end
end

function UISkillInput:InvokeCancleInputAction()
  if self.cancleFunc ~= nil then
    self.cancleFunc()
  end
end

function UISkillInput:ShowUnavailableMentionTips(castTip)
  if string.IsNullOrEmpty(castTip) then
    castTip = ConfigData:GetTipContent(TipContent.SkillSelectUnavailableTips)
  end
  cs_MessageCommon.ShowMessageTips(castTip)
end

function UISkillInput:UpdateInputStateUI(isInInput)
  local skillModuleWin = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if skillModuleWin ~= nil then
    skillModuleWin:SetSkillInputState(isInInput)
  end
  
  local function windowHideCollectAct(windowId)
    local win = UIManager:GetWindow(windowId)
    if win == nil then
      return
    end
    if win.active then
      table.insert(self.hideList, windowId)
    end
  end
  
  local function windowActiveCtrlAct(windowId)
    local win = UIManager:GetWindow(windowId)
    if win == nil then
      return
    end
    local canvasGroup = win.ui.canvasGroup
    if canvasGroup ~= nil then
      if win.active and isInInput then
        canvasGroup.alpha = 0
        win.active = false
      elseif not win.active and not isInInput then
        canvasGroup.alpha = 1
        win.active = true
      end
    end
  end
  
  if isInInput then
    self.hideList = {}
    windowHideCollectAct(UIWindowTypeID.Battle)
    windowHideCollectAct(UIWindowTypeID.DungeonStateInfo)
    windowHideCollectAct(UIWindowTypeID.BattleDPS)
    windowHideCollectAct(UIWindowTypeID.BattleCrazyMode)
  end
  if self.hideList ~= nil then
    for i, winId in ipairs(self.hideList) do
      windowActiveCtrlAct(winId)
    end
  end
end

function UISkillInput:OnDelete()
  base.OnDelete(self)
  MsgCenter:RemoveListener(eMsgEventId.OnMonsterStageShowStart, self._MonStageShowStartFunc)
  MsgCenter:RemoveListener(eMsgEventId.OnMonsterStageShowEnd, self._MonStageShowEndFunc)
  TimerManager:StopTimer(self.detectedButtonChangedTimer)
end

return UISkillInput

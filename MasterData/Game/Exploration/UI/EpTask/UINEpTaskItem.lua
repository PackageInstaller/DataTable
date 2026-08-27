local UINEpTaskItem = class("UINEpTaskItem", UIBaseNode)
local base = UIBaseNode
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease

function UINEpTaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_itemClick, self, self._OnItemClick)
  self:_ShowCompleteUI(false)
end

function UINEpTaskItem:SetTaskClickCallback(clickCallback)
  self._onClickCallback = clickCallback
end

function UINEpTaskItem:RefreshItemUI(taskData)
  self:_InitCompleteTweenUI()
  self.taskData = taskData
  self.ui.tex_QuestContent.text = LanguageUtil.GetLocaleText(taskData:GetTaskFirstStepIntro())
  self:RefreshProcessUI()
end

function UINEpTaskItem:RefreshProcessUI()
  if self.taskData == nil then
    return
  end
  local schedule, aim = self.taskData:GetTaskProcess()
  if schedule == nil or aim == nil then
    self.ui.tex_Count.text = ""
    self.ui.img_Bar.fillAmount = 0
    return
  end
  if schedule <= aim then
    self.ui.tex_Count.text = tostring(schedule) .. "/" .. tostring(aim)
    self.ui.img_Bar.fillAmount = schedule / aim
  end
end

function UINEpTaskItem:ShowComplete()
  self:_InitCompleteTweenUI()
  if self.completeSeq ~= nil then
    self.completeSeq:Kill()
  end
  local completeSeq = cs_DoTween.Sequence()
  completeSeq:SetAutoKill(false)
  completeSeq:SetLink(self.gameObject)
  self:_ShowCompleteUI(true)
  completeSeq:InsertCallback(0, function()
    self._hasCompleteTween = true
  end)
  completeSeq:Append(self.ui.tran_complete:DOSizeDelta(Vector2.New(536.991, 80), 1):SetEase(cs_Ease.OutQuart))
  completeSeq:Join(self.ui.fade_complete:DOFade(1, 0.7):SetEase(cs_Ease.OutQuad))
  completeSeq:OnComplete(function()
    self._hasCompleteTween = false
    self.ui.fx_Exploration:SetActive(true)
  end)
  self.completeSeq = completeSeq
end

function UINEpTaskItem:HideComplete()
  if self.hideSeq ~= nil then
    self.hideSeq:Kill()
  end
  local hideSeq = cs_DoTween.Sequence()
  hideSeq:SetAutoKill(false)
  hideSeq:SetLink(self.gameObject)
  hideSeq:InsertCallback(0, function()
    self._hasCompleteTween = true
  end)
  hideSeq:Append(self.ui.tran_complete:DOSizeDelta(Vector2.New(10, 80), 1):SetEase(cs_Ease.OutQuart))
  hideSeq:Join(self.ui.fade_complete:DOFade(0.2, 0.7):SetEase(cs_Ease.OutQuad))
  hideSeq:OnComplete(function()
    self._hasCompleteTween = false
    self:Hide()
  end)
  self.hideSeq = hideSeq
end

function UINEpTaskItem:_InitCompleteTweenUI()
  self.ui.fade_complete.alpha = 0.2
  self.ui.tran_complete.sizeDelta = Vector2.New(10, 80)
  self:_ShowCompleteUI(false)
end

function UINEpTaskItem:_ShowCompleteUI(Active)
  self.ui.tran_complete.gameObject:SetActive(Active)
  self.ui.obj_normal:SetActive(not Active)
end

function UINEpTaskItem:_OnItemClick()
  if self._hasCompleteTween then
    return
  end
  if self._onClickCallback ~= nil then
    self._onClickCallback()
  end
end

function UINEpTaskItem:ClearTask(isComplete)
  self.ui.fx_Exploration:SetActive(false)
  if isComplete then
    self:HideComplete()
  else
    self:Hide()
  end
  self.taskData = nil
end

function UINEpTaskItem:GetTaskId()
  if self.taskData ~= nil then
    return self.taskData.id
  end
  return 0
end

function UINEpTaskItem:OnDelete()
  self.ui.tran_complete:DOKill()
  self.ui.fade_complete:DOKill()
  base.OnDelete(self)
end

return UINEpTaskItem

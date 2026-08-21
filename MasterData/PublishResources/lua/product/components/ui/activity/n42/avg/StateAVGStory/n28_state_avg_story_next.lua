_class("N28StateAVGStoryNext", N28StateAVGStoryBase)
N28StateAVGStoryNext = N28StateAVGStoryNext

function N28StateAVGStoryNext:OnEnter(TT, ...)
  self:Init()
  self.uiDialog = table.unpack({
    ...
  })
  self._storyManager = self.data:StoryManager()
  if self.data.notRemindJump then
    self:JumpTo()
  else
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_avg_n28_jump_2_next_story"), function()
      self:JumpTo()
    end, nil, function()
      self:ChangeState(N28StateAVGStory.Play)
    end, nil, nil, nil, nil, function()
      self.data.notRemindJump = true
    end)
  end
end

function N28StateAVGStoryNext:OnExit(TT)
end

function N28StateAVGStoryNext:JumpTo()
  local lastParagraphId, lastSectionIdx = self:GetLast()
  local curParagraphId = self._storyManager:GetCurParagraphID()
  local curSectionIdx = self._storyManager:GetCurSectionIndex()
  if curParagraphId == lastParagraphId and lastSectionIdx <= curSectionIdx then
    self:ChangeState(N28StateAVGStory.Play)
    return
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28AVGJumpDialog)
  self:ShowJumpAnim(function()
    self._storyManager:JumpTo(lastParagraphId, lastSectionIdx)
    self:ChangeState(N28StateAVGStory.Play)
    self.ui:ShowHideJumpBtn(false)
  end)
end

function N28StateAVGStoryNext:GetNext()
  local storyId = self._storyManager:GetCurStoryID()
  local node = self.data:GetNodeByStoryId(storyId)
  local curParagraphId = self._storyManager:GetCurParagraphID()
  local curSectionIdx = self._storyManager:GetCurSectionIndex()
  for _, paragraph in ipairs(node.paragraphs) do
    if curParagraphId <= paragraph.id then
      for _, dialog in ipairs(paragraph.dialogs) do
        if curSectionIdx < dialog.sectionIdx then
          local visibleOptions = dialog:GetVisibleOptions()
          local showEvidenceEvent = dialog:HaveShowEvienceEvent()
          if visibleOptions and table.count(visibleOptions) > 0 then
            return paragraph.id, dialog.sectionIdx
          end
          if showEvidenceEvent then
            return paragraph.id, dialog.sectionIdx
          end
        end
      end
    end
  end
end

function N28StateAVGStoryNext:GetLast()
  local storyId = self._storyManager:GetCurStoryID()
  local node = self.data:GetNodeByStoryId(storyId)
  local lenParagraph = table.count(node.paragraphs)
  local lastParagraph = node.paragraphs[lenParagraph]
  local lenDialog = table.count(lastParagraph.dialogs)
  local lastDialog = lastParagraph.dialogs[lenDialog]
  local lastParagraphId, lastSectionIdx = lastParagraph.id, lastDialog.sectionIdx
  return lastParagraphId, lastSectionIdx
end

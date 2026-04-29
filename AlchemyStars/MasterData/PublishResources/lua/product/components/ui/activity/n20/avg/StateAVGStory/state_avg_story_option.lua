_class("StateAVGStoryOption", StateAVGStoryBase)
StateAVGStoryOption = StateAVGStoryOption

function StateAVGStoryOption:OnEnter(TT, ...)
  self:Init()
  self.poolOptions = self.ui.poolOptions
  self.poolInfluence = self.ui.poolInfluence
  self:ShowHideOption(true)
  self:ShowHideButtonAuto(false)
  self:ShowHideButtonShowHideUI(false)
  self:ShowHideButtonNext(false)
  self.storyManager = self.data:StoryManager()
  local storyId = self.storyManager:GetCurStoryID()
  local paragraphId = self.storyManager:GetCurParagraphID()
  local sectionIdx = self.storyManager:GetCurSectionIndex()
  self:FlushOptions(storyId, paragraphId, sectionIdx)
end

function StateAVGStoryOption:OnExit(TT)
  self:ShowHideOption(false)
  self:ShowHideButtonAuto(true)
  self:ShowHideButtonShowHideUI(true)
  self:ShowHideButtonNext(true)
end

function StateAVGStoryOption:FlushOptions(storyId, paragraphId, sectionIdx)
  local node = self.data:GetNodeByStoryId(storyId)
  local paragraph = node:GetParagraphByParagraphId(paragraphId)
  local dialog = paragraph:GetDialogBySectionIdx(sectionIdx)
  local options = dialog:GetVisibleOptions()
  if not options or table.count(options) <= 0 then
    AVGLog("Not exist visible options. [storyId = " .. storyId .. "] [paragraphId = " .. paragraphId .. "] [sectionIdx=" .. sectionIdx .. "]")
    self.fsm:ChangeState(StateAVGStory.Play)
    return
  end
  local len = table.count(options)
  self.poolOptions:SpawnObjects("UIN20AVGStoryOption", len)
  local uis = self.poolOptions:GetAllSpawnList()
  for i, option in ipairs(options) do
    local ui = uis[i]
    ui:Flush(option, function()
      GameGlobal.TaskManager():StartTask(function(TT)
        AudioHelperController.PlayRequestedUISound(CriAudioIDConst.SoundStoryClick)
        local key = "StateAVGStoryOptionChooseOption"
        GameGlobal.UIStateManager():Lock(key)
        local com = self.data:GetComponentAVG()
        local res = AsyncRequestRes:New()
        local ret = com:HandleManualChoose(TT, res, option.id)
        if N20AVGData.CheckCode(res) then
          local nextParagraphId = option:NextParagraphId()
          self.storyManager:SetNextParagraphID(nextParagraphId)
          self:NextNodeId(option.nextNodeId)
          self:DialogEnd(option.paragraphId, option.sectionIdx)
          local playerName = GameGlobal.GetModule(RoleModule):GetName()
          self.storyManager:AddDialogRecord(playerName, option:Content(), 1, true)
          self.ui:SetSelectedOptionId(option.id, true)
          self.fsm:ChangeState(StateAVGStory.Play)
        else
          Log.fatal("### HandleManualChoose failed. ", option.storyId, option.paragraphId, option.sectionIdx, option.index)
        end
        GameGlobal.UIStateManager():UnLock(key)
      end, self)
    end, uis)
  end
  self:FlushInfluence(options)
end

function StateAVGStoryOption:FlushInfluence(options)
  self.influence = self.poolInfluence:SpawnObject("UIN20AVGStoryInfluence")
  self.influence:Flush(options)
end

function StateAVGStoryOption:DialogEnd(paragraphId, sectionIdx)
  local storyEntity = self:GetStoryDialogEntity(paragraphId, sectionIdx)
  if storyEntity then
    storyEntity:_DialogEnd()
  end
end

function StateAVGStoryOption:GetStoryDialogEntity(paragraphId, sectionIdx)
  local node = self.data:CurNode()
  local paragraph = node:GetParagraphByParagraphId(paragraphId)
  local dialog = paragraph:GetDialogBySectionIdx(sectionIdx)
  local entityId = dialog.refEntityId
  local storyEntity = self.storyManager._storyEntityList[entityId]
  return storyEntity
end

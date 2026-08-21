_class("AVGStoryNode", Object)
AVGStoryNode = AVGStoryNode

function AVGStoryNode:Constructor()
  self.id = 0
  self.defaultNextId = -1
  self.endId = 0
  self.storyId = 0
  self.pos = Vector2.zero
  self.title = ""
  self.desc = ""
  self.cg = ""
  self.canPlayCg = ""
  self.cgNode = ""
  self.canplayCgNode = ""
  self.cgCanPlay = ""
  self.paragraphs = {}
  self.hideVisibleCondition = nil
  self.hideStartArchive = {}
  self.state = nil
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
end

function AVGStoryNode:Init(cfgSectionExcel, cfgOptionExcel)
  local storyManager = self.data:StoryManager()
  self.paragraphs = {}
  local cfgStory = storyManager._storyConfig
  local cfgParagraphs = cfgStory.Paragraphs
  for paragraphId, cfgParagraph in ipairs(cfgParagraphs) do
    local paragraph = AVGStoryParagraph:New()
    table.insert(self.paragraphs, paragraph)
    paragraph.id = paragraphId
    local cfgSections = cfgParagraph.Sections
    for sectionIdx, cfgSection in ipairs(cfgSections) do
      for elementIdx, cfgSectionElement in ipairs(cfgSection) do
        if cfgSectionElement.DialogContentStr then
          local dialog = AVGStoryDialog:New()
          table.insert(paragraph.dialogs, dialog)
          dialog.sectionIdx = sectionIdx
          dialog.refEntityId = cfgSectionElement.RefEntityID
          local cfgvSectionExcel = self:GetCfgvSectionExcel(cfgSectionExcel, self.storyId, paragraphId, sectionIdx)
          if cfgvSectionExcel then
            dialog.id = cfgvSectionExcel.ID
            dialog.beCondition = AVGCondition:New(cfgvSectionExcel.BECondition)
            dialog.beId = cfgvSectionExcel.BE
            dialog.valueChange = cfgvSectionExcel.ValueChange
          end
          local cfgOptions = cfgSectionElement.Options
          if cfgOptions then
            for optionIdx, cfgOption in ipairs(cfgOptions) do
              local option = AVGStoryOption:New()
              table.insert(dialog.options, option)
              option.storyId = self.storyId
              option.paragraphId = paragraphId
              option.sectionIdx = sectionIdx
              option.index = optionIdx
              option.content = StringTable.Get(cfgOption.Content)
              option.nextParagraphId = cfgOption.NextParagraphID
              local cfgvOptionExcel = self:GetCfgvOptionExcel(cfgOptionExcel, self.storyId, paragraphId, sectionIdx, optionIdx)
              if cfgvOptionExcel then
                option.id = cfgvOptionExcel.ID
                local influenceValue = cfgvOptionExcel.InfluenceValue
                if influenceValue then
                  for i, influence in ipairs(influenceValue) do
                    if i == 1 then
                      option.influenceLeader = influence
                    else
                      option.influencePartners[i - 1] = influence
                    end
                  end
                end
                local influence = cfgvOptionExcel.Influence
                if influence then
                  option.influence = StringTable.Get(influence)
                end
                local keyUnlockConditionDesc = cfgvOptionExcel.UnlockConditionDesc
                if string.isnullorempty(keyUnlockConditionDesc) then
                  option.unlockConditionDesc = ""
                else
                  option.unlockConditionDesc = StringTable.Get(keyUnlockConditionDesc)
                end
                option.unlockCondition = AVGCondition:New(cfgvOptionExcel.UnlockCondition, true)
                option.visibleCondition = AVGCondition:New(cfgvOptionExcel.ShowCondition, true)
                option.nextNodeId = cfgvOptionExcel.NextNodeId or 0
              end
            end
          end
        end
      end
    end
  end
  local hp, strategies, evidence = self:StartData()
  self.cacheUserEvidences = evidence
end

function AVGStoryNode:GetCfgvSectionExcel(cfgSectionExcel, storyId, paragraphId, sectionIdx)
  if cfgSectionExcel then
    for key, cfgv in pairs(cfgSectionExcel) do
      local sign = cfgv.SectionSign
      if sign[1] == storyId and sign[2] == paragraphId and sign[3] == sectionIdx then
        return cfgv
      end
    end
  end
end

function AVGStoryNode:GetCfgvOptionExcel(cfgOptionExcel, storyId, paragraphId, sectionIdx, optionIdx)
  if cfgOptionExcel then
    for key, cfgv in pairs(cfgOptionExcel) do
      local sign = cfgv.OptionSign
      if sign[1] == storyId and sign[2] == paragraphId and sign[3] == sectionIdx and sign[4] == optionIdx then
        return cfgv
      end
    end
  end
end

function AVGStoryNode:IsEnd()
  return self.endId > 0
end

function AVGStoryNode:IsHide()
  if self.hideVisibleCondition then
    return true
  end
  return false
end

function AVGStoryNode:IsHideNew()
  if self:IsHide() and self:IsSatisfyVisible() then
    local serverNodeInfo = self.data:GetServerNodeDataByNodeId(self.id)
    if serverNodeInfo then
      return serverNodeInfo.new_mark
    else
      return true
    end
  end
  return false
end

function AVGStoryNode:IsSatisfyVisible()
  if self:IsHide() then
    return self.hideVisibleCondition:IsSatisfy()
  end
  return true
end

function AVGStoryNode:GetHideStartArchive()
  local hp = 0
  local strategies = {}
  if self.hideStartArchive then
    for index, value in ipairs(self.hideStartArchive) do
      if index == 1 then
        hp = value
      else
        table.insert(strategies, value)
      end
    end
  end
  return hp, strategies
end

function AVGStoryNode:ChangeEvidence(eid, isAdd)
  if isAdd then
    table.insert(self.cacheUserEvidences, eid)
  else
    table.removev(self.cacheUserEvidences, eid)
  end
end

function AVGStoryNode:GetEvidenceData()
  return self.cacheUserEvidences
end

function AVGStoryNode:StartData()
  local hp, strategies = 0, {}
  if self:IsHide() then
    for i, value in ipairs(self.hideStartArchive) do
      if i == 1 then
        hp = value
      else
        table.insert(strategies, value)
      end
    end
  else
    local fstNodeId = self.data:FirstNodeId()
    if fstNodeId == self.id then
      hp = self.data.actorLeader.default
      for index, partner in ipairs(self.data.actorPartners) do
        table.insert(strategies, partner.default)
      end
    else
      local serNodeData = self.data:GetServerNodeDataByNodeId(self.id)
      if serNodeData then
        hp = serNodeData.end_formation_info.leader_hp
        strategies = serNodeData.end_formation_info.teammate_affinity
      end
    end
  end
  local strategiesCopy = {}
  for index, value in ipairs(strategies) do
    strategiesCopy[index] = value
  end
  return hp, strategiesCopy
end

function AVGStoryNode:GetSaveTimestamp()
  if self.data:FirstNodeId() == self.id then
    return 0
  end
  if self:IsHide() then
    return 0
  end
  local serverNodeInfo = self.data:GetServerNodeDataByNodeId(self.id)
  if serverNodeInfo then
    return serverNodeInfo.update_time
  else
    return 0
  end
end

function AVGStoryNode:IsComplete()
  local info = self.data:GetComponentInfoAVG()
  if table.icontains(info.conplated_node_ids, self.id) then
    return true
  end
end

function AVGStoryNode:State()
  return self.state
end

function AVGStoryNode:GetParagraphByParagraphId(paragraphId)
  for index, paragraph in ipairs(self.paragraphs) do
    if paragraph.id == paragraphId then
      return paragraph
    end
  end
end

local AVGStoryNodeState = {
  CantPlay = 0,
  CanPlay = 1,
  Complete = 2
}
_enum("AVGStoryNodeState", AVGStoryNodeState)
_class("AVGStoryParagraph", Object)
AVGStoryParagraph = AVGStoryParagraph

function AVGStoryParagraph:Constructor()
  self.id = 0
  self.dialogs = {}
end

function AVGStoryParagraph:GetDialogBySectionIdx(sectionIdx)
  for index, dialog in ipairs(self.dialogs) do
    if dialog.sectionIdx == sectionIdx then
      return dialog
    end
  end
end

_class("AVGStoryDialog", Object)
AVGStoryDialog = AVGStoryDialog

function AVGStoryDialog:Constructor()
  self.id = 0
  self.sectionIdx = 0
  self.refEntityId = 0
  self.options = {}
  self.beCondition = nil
  self.beId = 0
  self.valueChange = {}
end

function AVGStoryDialog:ValueChange()
  return self.valueChange
end

function AVGStoryDialog:HasValueChange()
  local vc = self:ValueChange()
  if vc then
    for _, value in ipairs(vc) do
      if value ~= 0 then
        return true
      end
    end
  end
  return false
end

function AVGStoryDialog:IsSatisfyBE()
  if self.beCondition then
    return self.beCondition:IsSatisfy()
  end
  return false
end

function AVGStoryDialog:GetVisibleOptions()
  local options = {}
  for index, option in ipairs(self.options) do
    if option:IsSatisfyVisible() then
      table.insert(options, option)
    end
  end
  return options
end

_class("AVGStoryOption", Object)
AVGStoryOption = AVGStoryOption

function AVGStoryOption:Constructor()
  self.id = 0
  self.storyId = 0
  self.paragraphId = 0
  self.sectionIdx = 0
  self.index = 0
  self.content = ""
  self.nextParagraphId = 0
  self.influenceLeader = 0
  self.influencePartners = {}
  self.influence = ""
  self.unlockConditionDesc = ""
  self.unlockCondition = nil
  self.visibleCondition = nil
  self.nextNodeId = 0
  local mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = mCampaign:GetN20AVGData()
end

function AVGStoryOption:Content()
  return self.content
end

function AVGStoryOption:NextParagraphId()
  return self.nextParagraphId
end

function AVGStoryOption:IsSelected()
  if self.data:IsSelectedOption(self.id) then
    return true
  end
end

function AVGStoryOption:IsInfluential()
  local inf = self:IsInfluentialLeader() or self:IsInfluentialPartners()
  return inf
end

function AVGStoryOption:IsInfluentialLeader()
  return self.influenceLeader ~= 0
end

function AVGStoryOption:IsInfluentialPartners()
  if self.influencePartners then
    for index, influence in ipairs(self.influencePartners) do
      if self:IsInfluentialPartner(index) then
        return true
      end
    end
  end
  return false
end

function AVGStoryOption:IsInfluentialPartner(index)
  return self.influencePartners[index] ~= 0
end

function AVGStoryOption:IsSatisfyUnlock()
  if self.unlockCondition then
    return self.unlockCondition:IsSatisfy()
  end
  return true
end

function AVGStoryOption:IsSatisfyVisible()
  if self.visibleCondition then
    return self.visibleCondition:IsSatisfy()
  end
  return true
end

_class("AVGStoryLine", Object)
AVGStoryLine = AVGStoryLine

function AVGStoryLine:Constructor()
  self.sNodeId = 0
  self.eNodeId = 0
  self.posS = Vector2.zero
  self.posE = Vector2.zero
  self.posLs = {}
end

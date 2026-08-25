local AwakerStoryMainComp, Super = System.NewComponent("AwakerStoryMainComp", AwakerBasePageComp)

function AwakerStoryMainComp:ctor(uiNode, awakerModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Story_MainResource(uiNode)
  self.awakerModel = awakerModel
  self.compObjBinder = {
    [CommonDefine.AwakerPage.Story] = nil,
    [CommonDefine.AwakerPage.StoryDetail] = nil,
    [CommonDefine.AwakerPage.VoiceDetail] = nil
  }
end

function AwakerStoryMainComp:OnBind(binder)
  self.binder = binder
  self.storyModel = binder:createModel(AwakerStoryModel, self.awakerModel)
  binder:BindToText(self.ui.Text_Awaker_Name, function()
    local tid = self.awakerModel.selectAwakerId
    local name = self.awakerModel:GetAwakerTitle(tid)
    return name
  end)
  binder:BindToImage(self.ui.Image_Awaker_Career_Icon, function()
    local tid = self.awakerModel.selectAwakerId
    local config = self.awakerModel:GetAwakerConfig(tid)
    if not config then
      return ""
    end
    local iconPath = self.awakerModel:GetSchoolIcon(config.School)
    return iconPath
  end)
  binder:BindComponent(AwakerStoryEntryComp(self.ui.UI_Awaker_PanelStory_Main, self.awakerModel, self.storyModel))
  local storyComp = binder:BindComponent(AwakerStoryDetailComp(self.ui.UI_Awaker_Item_Story, self.awakerModel, self.storyModel))
  local voiceComp = binder:BindComponent(AwakerVoiceDetailComp(self.ui.UI_Awaker_Item_Voice, self.awakerModel, self.storyModel))
  binder:BindToRaw(function(_, page, oldPage)
    if page == CommonDefine.AwakerPage.Story then
      self.ui.UI_Awaker_PanelStory_Main:SetActive(true)
    elseif page == CommonDefine.AwakerPage.StoryDetail then
      self.ui.UI_Awaker_Item_Story:SetActive(true)
      if not self.storyModel.storyShowList[1] then
        self.storyModel:SetCurSelectVoiceId(0)
      else
        local tid = self.storyModel.storyShowList[1].tid
        self.storyModel:SetCurSelectVoiceId(tid)
        AwakerDataUtils.ReadStory(self.awakerModel.selectAwakerId, {tid})
      end
    elseif page == CommonDefine.AwakerPage.VoiceDetail then
      self.ui.UI_Awaker_Item_Voice:SetActive(true)
      voiceComp:Init()
      AudioManager.Instance:PostSoundEvent("Stop_VO_Chr_All")
      self.awakerModel:SetCurAwakerVoice("", "")
    end
    if oldPage == CommonDefine.AwakerPage.Story then
    elseif oldPage == CommonDefine.AwakerPage.StoryDetail then
      storyComp:RemoveRedPoints()
    elseif oldPage == CommonDefine.AwakerPage.VoiceDetail then
      voiceComp:RemoveRedPoints()
      self.storyModel:SetVoiceSelectTab(nil)
      AudioManager.Instance:PostSoundEvent("Stop_VO_Chr_All")
      self.storyModel:SetCurPlayingVoiceName("")
      AwakerFaceManager.Instance:SwitchFace(self.awakerModel.selectAwakerId, nil)
    end
  end, function()
    return self.awakerModel.page
  end)
end

function AwakerStoryMainComp:GetOpenAnim()
  return "UI_Awaker_Panel_PanelStory_Main_Open", nil
end

function AwakerStoryMainComp:GetCloseAnim()
  return "UI_Awaker_Panel_PanelStory_Main_Close", nil
end

function AwakerStoryMainComp:GetEnterDetailAnim()
  if self.awakerModel.page == CommonDefine.AwakerPage.StoryDetail then
    return "UI_Awaker_Panel_PanelStory_Main_Close,UI_Awaker_Panel_Item_Story_Open"
  end
  return "UI_Awaker_Panel_PanelStory_Main_Close,UI_Awaker_Panel_Item_Voice_Open"
end

function AwakerStoryMainComp:GetExitDetailAnim()
  if self.awakerModel.oldPage == CommonDefine.AwakerPage.StoryDetail then
    return "UI_Awaker_Panel_Item_Story_Close,UI_Awaker_Panel_PanelStory_Main_Open"
  end
  return "UI_Awaker_Panel_Item_Voice_Close,UI_Awaker_Panel_PanelStory_Main_Open"
end

return AwakerStoryMainComp

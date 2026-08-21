_class("UIN29DetectivePersonController", UIController)
UIN29DetectivePersonController = UIN29DetectivePersonController

function UIN29DetectivePersonController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign.New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N29, ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE)
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._comp = self._localProcess:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE)
  self._info = self._localProcess:GetComponentInfo(ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE)
  self._curDetectiveInfo = self._info.cur_info
  self._clueList = self._curDetectiveInfo.clue_list
  self._psdId = self._curDetectiveInfo.pstid
end

function UIN29DetectivePersonController:OnShow(uiParams)
  self._Id = uiParams[1]
  self._StageId = uiParams[2]
  self:InitWidget()
  self:InitData()
  self:_Judge()
  if self._Id == 1 then
    self:CheckGuide()
  end
end

function UIN29DetectivePersonController:_Judge()
  local cfg_stage = Cfg.cfg_component_detective_stage[self._StageId]
  if UIN29DetectiveHelper.Judge(cfg_stage.ClueList, self._clueList) then
    self:ShowDialog("UIStoryController", cfg_stage.IntroPlot, function()
      self:IntroStoryEnd()
    end)
  end
end

function UIN29DetectivePersonController:CheckTime()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = svrTimeModule and math.floor(svrTimeModule:GetServerTime() * 0.001) or 0
  local closeTime = self._info.m_close_time
  local isOpen
  if curTime < closeTime then
    isOpen = true
  else
    isOpen = false
  end
  if not isOpen then
    ToastManager.ShowToast(StringTable.Get("str_n24_specialtask_close"))
    self:SwitchState(UIStateType.UIActivityN29MainController)
  end
  return isOpen
end

function UIN29DetectivePersonController:IntroStoryEnd()
  local cfg_stage = Cfg.cfg_component_detective_stage[self._StageId]
  local storyID = cfg_stage.BeforeReasoningPlot
  local db = UIN29DetectiveLocalDb:New()
  self._black:SetActive(true)
  CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeStoryController .. "DirectIn", function()
    db:GameIdReasoning(UIN29DetectiveLocalDb.Game_Continue_Reasoning)
    self:ShowDialog("UIStoryController", storyID, function()
      self:ReasoningPlotEnd()
    end)
    CutsceneManager.ExcuteCutsceneOut()
  end)
end

function UIN29DetectivePersonController:ReasoningPlotEnd()
  self:ShowDialog("UIN29DetectiveReasoningPopController", self._StageId)
end

function UIN29DetectivePersonController:InitWidget()
  local btns = self:GetUIComponent("UISelectObjectPath", "backBtn")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._chat = self:GetUIComponent("UILocalizationText", "chat")
  self._spine = self:GetUIComponent("SpineLoader", "Spine")
  self._spinePos = self:GetUIComponent("RectTransform", "Spine")
  self._delogPos = self:GetUIComponent("RectTransform", "delog")
  self._BG = self:GetUIComponent("RawImageLoader", "BG")
  self._clueBag = self:GetGameObject("ClueBag")
  self._top = self:GetGameObject("top")
  self._center = self:GetGameObject("center")
  self._rightMid = self:GetGameObject("rightMid")
  self._backBtnObj = self:GetGameObject("backBtn")
  self._tips = self:GetGameObject("Tips")
  self._black = self:GetGameObject("Black")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:SwitchState(UIStateType.UIActivityN29DetectiveMapController)
  end, nil, nil, true, nil)
  self._black:SetActive(false)
end

function UIN29DetectivePersonController:InitData(TT)
  local cfg_detail = Cfg.cfg_n29_detective_talk_pet_detail[self._Id]
  self._normalFace = cfg_detail.NormalFace
  self.RandomChat = cfg_detail.RandomChat
  self.random = math.random(1, 3)
  local Spine = cfg_detail.Spine
  local bg = cfg_detail.BG
  self.NoTalkChat = cfg_detail.NoTalkChat
  self._BG:LoadImage(bg)
  self._spine:LoadSpine(Spine)
  self._spineSke = self._spine.CurrentSkeleton
  if not self._spineSke then
    self._spineSke = self._spine.CurrentMultiSkeleton
  end
  self._spine:SetAnimation(0, self._normalFace, true)
  self._spineSke:Update(0)
  self:LoadPosition()
  self:LoadTalk(TT)
end

function UIN29DetectivePersonController:LoadPosition()
  local cfg_detail = Cfg.cfg_n29_detective_talk_pet_detail[self._Id]
  local ChatPos = cfg_detail.ChatPos
  local PersonPos = cfg_detail.PersonPos
  local PersonSize = cfg_detail.SpineSize
  self._delogPos.anchoredPosition = Vector2(ChatPos[1], ChatPos[2])
  self._spinePos.anchoredPosition = Vector2(PersonPos[1], PersonPos[2])
  self._spinePos.localScale = Vector3(PersonSize, PersonSize, PersonSize)
end

function UIN29DetectivePersonController:LoadTalk(TT)
  local cfg_waypoint = Cfg.cfg_component_detective_waypoint[self._Id]
  local cfg_talk = Cfg.cfg_component_detective_talk
  local talkIds = cfg_waypoint.WaypointContent
  local list = self:GetList(talkIds)
  local count = #list
  if count ~= 0 then
    self._content:SpawnObjects("UIN29DetectiveTalkItem", count)
    self._allWidgets = self._content:GetAllSpawnList()
    for index, item in pairs(self._allWidgets) do
      local talkItem = self._allWidgets[index]
      if index == 1 then
        self.fistTalkItem = talkItem
      end
      talkItem:SetData(list[index], self._clueList, self._psdId, function(StoryID, ClueId)
        self:PlayStory(StoryID, ClueId)
      end, function()
        self:RightShow()
      end, function()
        self:WrongShow()
      end, function()
        return self:CheckTime()
      end)
    end
    self._chat:SetText(StringTable.Get(self.RandomChat[self.random]))
  else
    self._chat:SetText(StringTable.Get(self.NoTalkChat))
    self._tips:SetActive(true)
  end
  self:PlayEnterAnim(TT)
  self._anim:Play("uieff_UIN29DetectivePersonController_chat_in")
end

function UIN29DetectivePersonController:PlayEnterAnim(TT)
  self:Lock("UIN29DetectivePersonController")
  self._anim:Play("uieff_UIN29DetectivePersonController_in")
  YIELD(TT, 300)
  self:UnLock("UIN29DetectivePersonController")
end

function UIN29DetectivePersonController:GetList(talkIds)
  local cfg_stage = Cfg.cfg_component_detective_stage[self._StageId]
  local ClueList = cfg_stage.ClueList
  local list = {}
  local locklist = {}
  local unlocklist = {}
  for index, value in ipairs(talkIds) do
    local id = Cfg.cfg_component_detective_talk[value].ClueId
    if UIN29DetectiveHelper.IsInList(id, ClueList) then
      table.insert(list, value)
    end
  end
  for index, value in ipairs(list) do
    if UIN29DetectiveHelper.IsLock(value, self._clueList) then
      table.insert(locklist, value)
    else
      table.insert(unlocklist, value)
    end
  end
  table.sort(locklist)
  table.sort(unlocklist)
  for index, value in ipairs(locklist) do
    table.insert(unlocklist, value)
  end
  return unlocklist
end

function UIN29DetectivePersonController:RightShow()
  self._anim:Play("uieff_UIN29DetectivePersonController_chat_in")
  local cfg_detail = Cfg.cfg_n29_detective_talk_pet_detail[self._Id]
  local chat = cfg_detail.Rightchat
  local face = cfg_detail.RightFace
  if chat then
    self._chat:SetText(StringTable.Get(chat))
  end
  self:ChangeFace(face)
end

function UIN29DetectivePersonController:WrongShow()
  self._anim:Play("uieff_UIN29DetectivePersonController_chat_in")
  local cfg_detail = Cfg.cfg_n29_detective_talk_pet_detail[self._Id]
  local chat = cfg_detail.Wrongchat
  local face = cfg_detail.WrongFace
  if chat then
    self._chat:SetText(StringTable.Get(chat))
  end
  self:ChangeFace(face)
end

function UIN29DetectivePersonController:ChangeFace(face)
  local spineSkeleton = self._spine.CurrentSkeleton
  spineSkeleton = spineSkeleton or self._spine.CurrentMultiSkeleton
  if spineSkeleton then
    spineSkeleton.AnimationState:SetAnimation(0, face, false)
  end
end

function UIN29DetectivePersonController:PlayStory(StoryID, TalkId)
  if TalkId then
    self:SubmitClue(TalkId)
  end
  self:ShowDialog("UIStoryController", StoryID, function()
    self:StoryEnd(TalkId)
  end)
end

function UIN29DetectivePersonController:SubmitClue(TalkId)
  GameGlobal.TaskManager():StartTask(self.SubmitClueTask, self, TalkId)
end

function UIN29DetectivePersonController:SubmitClueTask(TT, TalkId)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local info = SubmitClueInfo:New()
  info.type = 0
  info.id = TalkId
  local list = {}
  table.insert(list, info)
  self._comp:HandleSubmitItem(TT, res, self._StageId, list, {}, {})
  if res:GetSucc() then
    Log.fatal("成功")
    YIELD(TT, 1000)
    self:RefreshData()
  else
    Log.fatal("请求失败", res:GetResult())
  end
end

function UIN29DetectivePersonController:RefreshData()
  self._curDetectiveInfo = self._info.cur_info
  self._clueList = self._curDetectiveInfo.clue_list
  self._psdId = self._curDetectiveInfo.pstid
  self:LoadTalk()
  self:ChangeFace(self._normalFace)
end

function UIN29DetectivePersonController:StoryEnd(TalkId)
  local cfg_talk = Cfg.cfg_component_detective_talk[TalkId]
  local ClueId = cfg_talk.ClueId
  if ClueId then
    self:ShowAllUI()
    self:ShowDialog("UIN29DetectiveCluePopController", ClueId, UIN29DetectiveType.Person, function()
      self:_Judge()
    end)
  end
end

function UIN29DetectivePersonController:HideAllUI()
  self._clueBag:SetActive(false)
  self._top:SetActive(false)
  self._center:SetActive(false)
  self._rightMid:SetActive(false)
  self._backBtnObj:SetActive(false)
end

function UIN29DetectivePersonController:ShowAllUI()
  self._clueBag:SetActive(true)
  self._top:SetActive(true)
  self._center:SetActive(true)
  self._rightMid:SetActive(true)
  self._backBtnObj:SetActive(true)
end

function UIN29DetectivePersonController:ClueBagOnClick()
  self:ShowDialog("UIActivityN29DetectiveBagController", true, self._curDetectiveInfo, true)
end

function UIN29DetectivePersonController:OnHide()
end

function UIN29DetectivePersonController:GetFirstItemForGuide()
  if not self.fistTalkItem then
    return
  end
  return self.fistTalkItem:GetItemBtnGo()
end

function UIN29DetectivePersonController:CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN29DetectivePersonController)
end

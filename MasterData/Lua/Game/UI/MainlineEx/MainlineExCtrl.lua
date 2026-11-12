local BaseCtrl = require("GameCore.UI.BaseCtrl")
local MainlineExCtrl = class("MainlineExCtrl", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
local AvgData = PlayerData.Avg
local typeof = _ENV.typeof
MainlineExCtrl._mapNodeConfig = {
  goChapterLine = {
    sNodeName = "goChapterLine",
    sComponentName = "GameObject"
  },
  txtTitle = {
    sNodeName = "txtChapterTitle",
    sComponentName = "TMP_Text"
  },
  txtChapter = {sNodeName = "txtChapter", sComponentName = "TMP_Text"},
  btnClue = {
    sNodeName = "btnClue",
    sComponentName = "UIButton",
    callback = "OnBtn_ClickOpenClue"
  },
  imgCharHead = {
    sNodeName = "imgCharHead",
    sComponentName = "Image"
  },
  txtCharName = {
    sNodeName = "txtCharName",
    sComponentName = "TMP_Text"
  },
  txtPersonalityPercent1 = {
    sNodeName = "txtPersonalityPercent1",
    sComponentName = "TMP_Text"
  },
  txtPersonalityPercent2 = {
    sNodeName = "txtPersonalityPercent2",
    sComponentName = "TMP_Text"
  },
  txtPersonalityPercent3 = {
    sNodeName = "txtPersonalityPercent3",
    sComponentName = "TMP_Text"
  },
  gogoPersonality = {
    sNodeName = "goPersonality",
    sComponentName = "GameObject"
  },
  ctlgoMainLineAvgRoot = {
    sNodeName = "goMainLineAvgRoot",
    sCtrlName = "Game.UI.MainlineEx.MainlineAvgInfoExCtrl"
  },
  ctlgoEnemyInfo = {
    sNodeName = "goEnemyInfo",
    sCtrlName = "Game.UI.MainlineEx.MainlineMonsterInfoCtrl"
  },
  got_fullscreen_blur_01 = {
    sNodeName = "t_fullscreen_blur_01",
    sComponentName = "GameObject"
  },
  btnsnapshot = {
    sNodeName = "snapshot_main",
    sComponentName = "Button",
    callback = "OnBtn_ClickCloseLevelInfoPanel"
  },
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  ctrlClue = {
    sNodeName = "goClue",
    sCtrlName = "Game.UI.MainlineEx.StoryClueCtrl"
  },
  aniBg = {sNodeName = "----Bg----", sComponentName = "Animator"},
  aniSafeRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  txtChapterTimeStamp = {sComponentName = "TMP_Text"},
  goChapterComplete = {},
  redDotClue = {},
  txtPersonality1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Personality_Instinct"
  },
  txtPersonality2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Personality_Analyze"
  },
  txtPersonality3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Personality_Chaos"
  },
  txtBtnClue = {sComponentName = "TMP_Text", sLanguageId = "Story_Clue"}
}
MainlineExCtrl._mapEventConfig = {
  [EventId.ChoseMainlineStory] = "OnEvent_ChooseMainlineStory",
  SelectMainlineBattle = "OnEvent_SelectMainlineBattle",
  Story_Done = "OnEvent_Story_Done",
  [EventId.UIBackConfirm] = "OnEvent_UIBackConfirm",
  [EventId.UIHomeConfirm] = "OnEvent_BackHome",
  Story_RewardClosed = "OnEvent_Story_RewardClosed"
}
MainlineExCtrl._mapRedDotConfig = {
  [RedDotDefine.MainStoryClue] = {sNodeName = "redDotClue"}
}

function MainlineExCtrl:Awake()
  local tbParam = self:GetPanelParam()
  self.curChapter = tbParam[1]
  self.fromPanel = tbParam[2] ~= nil and tbParam[2] or 0
  self._mapNode.btnClue.gameObject:SetActive(false)
  self.canvase = self.gameObject:GetComponent("Canvas")
end

function MainlineExCtrl:OnEnable()
  self:RefreshPanel()
end

function MainlineExCtrl:OnDisable()
  if self.curChapterCtrl ~= nil then
    self:UnbindCtrlByNode(self.curChapterCtrl)
    self.curChapterCtrl = nil
    destroy(self.curChapterObj)
    self.curChapterObj = nil
  end
end

function MainlineExCtrl:RefreshPanel()
  local config = ConfigTable.GetData("StoryChapter", self.curChapter)
  NovaAPI.SetTMPText(self._mapNode.txtTitle, config.Desc)
  NovaAPI.SetTMPText(self._mapNode.txtChapter, config.Name)
  NovaAPI.SetTMPText(self._mapNode.txtChapterTimeStamp, config.ChapterYear)
  self:RefreshChapterLine()
  self:RefreshPersonality()
  self:CheckClueReddot()
end

function MainlineExCtrl:RefreshChapterLine()
  if self.curChapterCtrl ~= nil then
    self.curChapterCtrl:Refresh(self.canvase)
    return
  end
  if self.curChapterObj ~= nil then
    self.curChapterCtrl = self:BindCtrlByNode(self.curChapterObj, "Game.UI.MainlineEx.ChapterLineCtrl")
    return
  end
  local sPrefabFolder = "UI/MainlineEx/goChapter_%d.prefab"
  local sPrefabPath = string.format(sPrefabFolder, self.curChapter)
  local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.goChapterLine.transform)
  if goObj ~= nil then
    self.curChapterObj = goObj
    self.curChapterCtrl = self:BindCtrlByNode(goObj, "Game.UI.MainlineEx.ChapterLineCtrl")
    self.curChapterCtrl:Refresh(self.canvase)
  end
end

function MainlineExCtrl:RefreshPersonality()
  local tbPersonality, sTitle, sFace, tbPData, nTotalCount, sHead = AvgData:CalcPersonality(1)
  NovaAPI.SetPersonalityRing(self._mapNode.gogoPersonality, tbPersonality)
  NovaAPI.SetTMPText(self._mapNode.txtPersonalityPercent1, math.floor(tbPersonality[1] * 100) .. "%")
  NovaAPI.SetTMPText(self._mapNode.txtPersonalityPercent2, math.floor(tbPersonality[2] * 100) .. "%")
  NovaAPI.SetTMPText(self._mapNode.txtPersonalityPercent3, math.floor(tbPersonality[3] * 100) .. "%")
  NovaAPI.SetTMPText(self._mapNode.txtCharName, sTitle)
  local sIcon = "Icon/PlayerHead/" .. sHead
  self:SetPngSprite(self._mapNode.imgCharHead, sIcon)
end

function MainlineExCtrl:PlayAnimOut()
  self._mapNode.aniBg:Play("MainlineEx_bg_out")
  self._mapNode.aniSafeRoot:Play("MainlineEx_out")
  local time1 = NovaAPI.GetAnimClipLength(self._mapNode.aniBg, {
    "MainlineEx_bg_out"
  })
  local time2 = NovaAPI.GetAnimClipLength(self._mapNode.aniSafeRoot, {
    "MainlineEx_out"
  })
  local time = math.min(time1, time2)
  self:AddTimer(1, time, function()
    if self.fromPanel ~= 0 and self.fromPanel ~= PanelId.StoryChapter then
      EventManager.Hit(EventId.OpenPanel, PanelId.StoryChapter, self.fromPanel)
    end
    EventManager.Hit(EventId.ClosePanel, PanelId.MainlineEx)
  end)
end

function MainlineExCtrl:OnBtn_ClickOpenClue()
  self._mapNode.ctrlClue:RefreshPanel()
end

function MainlineExCtrl:OnBtn_ClickCloseLevelInfoPanel()
  self._mapNode.ctlgoMainLineAvgRoot.gameObject:SetActive(false)
  self._mapNode.goChapterComplete:SetActive(false)
  self._mapNode.got_fullscreen_blur_01:SetActive(false)
  self.bAllCompleted = self.curChapterCtrl:IsAllStoryCompleted()
  if self.bAllCompleted then
    AvgData:SetNewLockChapterIndex(self.curChapter)
    if self.fromPanel ~= 0 and self.fromPanel ~= PanelId.StoryChapter then
      EventManager.Hit(EventId.OpenPanel, PanelId.StoryChapter, self.fromPanel)
    else
      EventManager.Hit(EventId.ClosePanel, PanelId.MainlineEx)
    end
  end
end

function MainlineExCtrl:OnEvent_ChooseMainlineStory(avgId, bNewestStory)
  self.avgId = avgId
  self._mapNode.ctlgoMainLineAvgRoot.gameObject:SetActive(true)
  self._mapNode.ctlgoMainLineAvgRoot:OpenLevelInfo(avgId, bNewestStory)
  self._mapNode.got_fullscreen_blur_01:SetActive(true)
  NovaAPI.UIEffectSnapShotCapture(self._mapNode.btnsnapshot.gameObject)
end

function MainlineExCtrl:OnEvent_SelectMainlineBattle(bConfirm)
  self._mapNode.got_fullscreen_blur_01:SetActive(false)
  
  local function OpenPanel()
    EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.Story, 0, self.avgId)
  end
  
  if bConfirm then
    local storyCfgData = PlayerData.Avg:GetStoryCfgData(self.avgId)
    if storyCfgData ~= nil then
      local nBattleType = storyCfgData.EnterMethod
      if nBattleType == GameEnum.EnterMethod.JumpFormation or nBattleType == GameEnum.EnterMethod.JumpFormationPause then
        PlayerData.Avg:SendMsg_STORY_ENTER(self.avgId, 0)
        return
      end
    end
    EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
  end
end

function MainlineExCtrl:OnEvent_Story_Done(bHasReward)
  self:RefreshPanel()
  if bHasReward and self.curChapterCtrl ~= nil then
    self.curChapterCtrl:ForbidClick()
  end
end

function MainlineExCtrl:OnEvent_UIBackConfirm(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  self:PlayAnimOut()
end

function MainlineExCtrl:OnEvent_BackHome(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PanelManager.Home()
end

function MainlineExCtrl:OnEvent_Story_RewardClosed()
  if self.curChapterCtrl ~= nil then
    self.bAllCompleted = self.curChapterCtrl:IsAllStoryCompleted()
    if self.bAllCompleted then
      AvgData:SetNewLockChapterIndex(self.curChapter)
      self._mapNode.got_fullscreen_blur_01:SetActive(true)
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self._mapNode.goChapterComplete:SetActive(true)
      end
      
      cs_coroutine.start(wait)
      self:AddTimer(1, 2.5, function()
        if self.fromPanel ~= 0 and self.fromPanel ~= PanelId.StoryChapter then
          EventManager.Hit(EventId.OpenPanel, PanelId.StoryChapter, self.fromPanel)
        else
          EventManager.Hit(EventId.ClosePanel, PanelId.MainlineEx)
        end
      end, true, true, true)
    end
  end
end

function MainlineExCtrl:CheckClueReddot()
  local function forEachLine_Ev(evConfig)
    local bUnlock = AvgData:IsEvidenceUnlock(evConfig.EvId)
    
    if not bUnlock then
      return
    end
    local tbEvStory = AvgData.tbEvData[evConfig.EvId]
    if tbEvStory == nil then
      return
    end
    local bUsed = true
    for i, v in ipairs(tbEvStory) do
      local nStoryId = AvgData.CFG_Story[v]
      if not AvgData:IsStoryReaded(nStoryId) then
        bUsed = false
        break
      end
    end
    RedDotManager.SetValid(RedDotDefine.MianStoryClue_Use, evConfig.Id, not bUsed)
  end
  
  ForEachTableLine(DataTable.StoryEvidence, forEachLine_Ev)
end

return MainlineExCtrl

local BaseCtrl = require("GameCore.UI.BaseCtrl")
local StoryChapterCtrl = class("StoryChapterCtrl", BaseCtrl)
local LocalData = require("GameCore.Data.LocalData")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local RapidJson = require("rapidjson")
StoryChapterCtrl._mapNodeConfig = {
  animBg = {sNodeName = "----Bg----", sComponentName = "Animator"},
  animTopBar = {sNodeName = "goBack", sComponentName = "Animator"},
  animChapterList = {
    sNodeName = "----Root_List----",
    sComponentName = "Animator"
  },
  animBtnShowStoryLineList = {
    sNodeName = "btnShowStoryLineList",
    sComponentName = "Animator"
  },
  animMoWang = {
    sNodeName = "----Root_MoWang----",
    sComponentName = "Animator"
  },
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  txtTitle_Show = {sComponentName = "TMP_Text"},
  txtTitle2_Show = {sComponentName = "TMP_Text"},
  imgStoryIcon = {sComponentName = "Image"},
  TabRedDot = {},
  btnShowStoryLineList = {
    sComponentName = "UIButton",
    callback = "OnBtn_ShowStoryLineList"
  },
  btnHideStoryLineList = {
    sComponentName = "UIButton",
    callback = "OnBtn_HideStoryLineList"
  },
  loopsvChapterList = {
    sNodeName = "svChapterList",
    sComponentName = "LoopScrollView"
  },
  loopsvStoryLineList = {
    sNodeName = "svStoryLineList",
    sComponentName = "LoopScrollView"
  },
  btnArrow = {
    sComponentName = "UIButton",
    callback = "OnBtn_HideStoryLineList"
  },
  rtActor2D = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  txtName = {sNodeName = "txtName", sComponentName = "TMP_Text"},
  goPersonality = {
    sNodeName = "goPersonality",
    sComponentName = "GameObject"
  },
  txtBtnChangeInfo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Change_Role_Character"
  },
  btnChangeInfo = {
    sNodeName = "btnChangeInfo",
    sComponentName = "UIButton",
    callback = "OnBtn_ChangeInfo"
  }
}
StoryChapterCtrl._mapEventConfig = {
  [EventId.UIBackConfirm] = "OnEvent_UIBackConfirm",
  [EventId.UIHomeConfirm] = "OnEvent_BackHome"
}
StoryChapterCtrl._mapRedDotConfig = {
  [RedDotDefine.Map_MainLine_Entrance] = {sNodeName = "TabRedDot"}
}

function StoryChapterCtrl:OnEnable()
  self:ParseData()
  self.nStoryLineId_From = 0
  self.nStoryLineId_To = 0
  self.bStoryLine_NeedPlayUnlockAnim = false
  self.bStoryLine_NeedPlaySwitchAnim = false
  self.nChapterId_From = 0
  self.nChapterId_To = 0
  self.bChapter_NeedPlayUnlockAnim = false
  self.nCurLineId = 0
  self.nCurChapterId = 0
  self.goLineSel = nil
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    local nSpecifyChapterId = tbParam[1] or 0
    if type(nSpecifyChapterId) == "number" and 0 < nSpecifyChapterId then
      local bUnlock, sTxt = PlayerData.Avg:IsStoryChapterUnlock(nSpecifyChapterId)
      if bUnlock == true then
        self.nChapterId_From = nSpecifyChapterId
        local cfgdata = ConfigTable.GetData("StoryChapter", nSpecifyChapterId)
        self.nStoryLineId_From = cfgdata.StoryLineId
      else
        printLog("specified chapter hasn't unlocked, chapter id:" .. tostring(nSpecifyChapterId))
      end
    end
  end
  self:SetMoWang()
  self:CheckJustRead()
  self:CheckLatest()
  self:FallbackToDefault()
  self.bPlayEnterChapter = false
  self.bPlayChapterIn = true
  self.nChapterIn = 0.333
  self.nCurLineId = self.nStoryLineId_From
  self:SetBtn_IconTitle(self.nCurLineId)
  self._mapNode.loopsvStoryLineList:Init(#self.tbLine, self, self.OnGrid_StoryLine, self.OnBtn_StoryLine)
  for i, v in ipairs(self.tbLine) do
    if v.nLineId == self.nStoryLineId_From then
      self._mapNode.loopsvStoryLineList:SetScrollGridPos(i - 1, 0, -1)
      break
    end
  end
  self.tbChapter = self:GetChapters(self.nCurLineId)
  self._mapNode.loopsvChapterList:Init(#self.tbChapter, self, self.OnGrid_Chapter, self.OnBtn_Chapter)
  local nHeadIdx = table.indexof(self.tbChapter, self.nChapterId_From)
  local nLocateChapterDuration = (nHeadIdx - 1) * 0.1
  
  local function PlayAnim_RootIn()
    self:PlayRootAnim(true)
  end
  
  local function PlayAnim_LocateChapter()
    self.bPlayChapterIn = false
    self.nChapterIn = 0
    self._mapNode.loopsvChapterList:SetScrollGridPos(nHeadIdx - 1, nLocateChapterDuration, -1)
  end
  
  local function PlayAnim_UnlockBtn()
    self._mapNode.animBtnShowStoryLineList:Play("StoryChapter_LineBtn_Unlock")
    WwiseAudioMgr:PlaySound("ui_mainline_ago_appear")
    self:SetBtn_IconTitle(self.nStoryLineId_To, true)
  end
  
  local function PlayAnim_MoveRight()
    self:OnBtn_ShowStoryLineList()
  end
  
  local function PlayAnim_ScrollToLine()
    for i, v in ipairs(self.tbLine) do
      if v.nLineId == self.nStoryLineId_To then
        self._mapNode.loopsvStoryLineList:SetScrollGridPos(i - 1, 0.2, 0)
        break
      end
    end
  end
  
  local function PlayAnim_UnlockNewLine()
    for i, v in ipairs(self.tbLine) do
      if v.nLineId == self.nStoryLineId_To then
        local goLineGridBtn = self._mapNode.loopsvStoryLineList.transform:Find("Viewport/Content/" .. tostring(i - 1)).gameObject
        self:OnGrid_StoryLine(goLineGridBtn, true)
        break
      end
    end
  end
  
  local function PlayAnim_ClickLine()
    for i, v in ipairs(self.tbLine) do
      if v.nLineId == self.nStoryLineId_To then
        local goLineGridBtn = self._mapNode.loopsvStoryLineList.transform:Find("Viewport/Content/" .. tostring(i - 1)).gameObject
        self:OnBtn_StoryLine(goLineGridBtn)
        break
      end
    end
  end
  
  local function PlayAnim_Locate_To_Chapter()
    self.bPlayChapterIn = false
    self.nChapterIn = 0
    local nIdx = table.indexof(self.tbChapter, self.nChapterId_To)
    self._mapNode.loopsvChapterList:SetScrollGridPos(nIdx - 1, 0.2, -1)
  end
  
  local function PlayAnim_Unlock_To_Chapter()
    local nIdx = table.indexof(self.tbChapter, self.nChapterId_To)
    local goChapterGridBtn = self._mapNode.loopsvChapterList.transform:Find("Viewport/Content/" .. tostring(nIdx - 1)).gameObject
    self:OnGrid_Chapter(goChapterGridBtn, true)
  end
  
  local function AnimDone()
    self.nChapterIn = 0
  end
  
  local nAnimDuration = 0
  local seq = DOTween.Sequence()
  seq:AppendInterval(0.1)
  seq:AppendCallback(PlayAnim_RootIn)
  if self.nChapterIn < 0.4 then
    seq:AppendInterval(0.4)
    nAnimDuration = 0.5
  else
    seq:AppendInterval(self.nChapterIn)
    nAnimDuration = self.nChapterIn + 0.1
  end
  seq:AppendCallback(PlayAnim_LocateChapter)
  seq:AppendInterval(nLocateChapterDuration)
  nAnimDuration = nAnimDuration + nLocateChapterDuration
  if self.bStoryLine_NeedPlayUnlockAnim == true then
    if self.nStoryLineId_From == 1 and self.nStoryLineId_To == 2 then
      seq:AppendCallback(PlayAnim_UnlockBtn)
      seq:AppendInterval(2)
      nAnimDuration = nAnimDuration + 2
    end
    seq:AppendCallback(PlayAnim_MoveRight)
    seq:AppendInterval(0.5)
    seq:AppendCallback(PlayAnim_ScrollToLine)
    seq:AppendInterval(0.2)
    seq:AppendCallback(PlayAnim_UnlockNewLine)
    seq:AppendInterval(1)
    seq:AppendCallback(PlayAnim_ClickLine)
    seq:AppendInterval(0.7)
    seq:AppendCallback(PlayAnim_Locate_To_Chapter)
    seq:AppendInterval(0.2)
    seq:AppendCallback(PlayAnim_Unlock_To_Chapter)
    seq:AppendInterval(1.3)
    nAnimDuration = nAnimDuration + 0.5 + 0.2 + 1 + 0.7 + 0.2 + 1.3
  elseif self.bStoryLine_NeedPlaySwitchAnim == true then
    seq:AppendCallback(PlayAnim_MoveRight)
    seq:AppendInterval(0.5)
    seq:AppendCallback(PlayAnim_ScrollToLine)
    seq:AppendInterval(0.2)
    seq:AppendCallback(PlayAnim_ClickLine)
    seq:AppendInterval(0.7)
    seq:AppendCallback(PlayAnim_Locate_To_Chapter)
    seq:AppendInterval(0.2)
    seq:AppendCallback(PlayAnim_Unlock_To_Chapter)
    seq:AppendInterval(1.3)
    nAnimDuration = nAnimDuration + 0.5 + 0.2 + 0.7 + 0.2 + 1.3
  elseif self.bChapter_NeedPlayUnlockAnim == true then
    seq:AppendCallback(PlayAnim_Locate_To_Chapter)
    seq:AppendInterval(0.2)
    seq:AppendCallback(PlayAnim_Unlock_To_Chapter)
    seq:AppendInterval(1.3)
    nAnimDuration = nAnimDuration + 0.2 + 1.3
  end
  seq:AppendCallback(AnimDone)
  seq:SetUpdate(true)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimDuration)
end

function StoryChapterCtrl:OnDisable()
  self.nStoryLineId_From = 0
  self.nStoryLineId_To = 0
  self.bStoryLine_NeedPlayUnlockAnim = false
  self.bStoryLine_NeedPlaySwitchAnim = false
  self.nChapterId_From = 0
  self.nChapterId_To = 0
  self.bChapter_NeedPlayUnlockAnim = false
  self.nCurLineId = 0
  self.nCurChapterId = 0
  self.goLineSel = nil
  self.bPlayEnterChapter = false
  delChildren(self._mapNode.loopsvChapterList.transform:Find("Viewport/Content"))
  delChildren(self._mapNode.loopsvStoryLineList.transform:Find("Viewport/Content"))
  self._panel._tbParam = nil
end

function StoryChapterCtrl:ParseData()
  self.tbLine = {}
  self.mapChapter = {}
  self.tbUnlockAnimPlayedChapter = {}
  self:LoadLocalData()
  
  local function foreach_Line(cfg)
    table.insert(self.tbLine, {
      nLineId = cfg.Id,
      nSort = cfg.SortIndex,
      tbChapterId = {},
      bVisible = cfg.Visible,
      bIsUnlock = false
    })
  end
  
  local function foreach_Chapter(cfg)
    if PlayerData.Avg:IsStoryChapterShow(cfg.Id) == true then
      local bUnlock, sTxt = PlayerData.Avg:IsStoryChapterUnlock(cfg.Id)
      self.mapChapter[cfg.Id] = {
        nHeadStoryId = 0,
        bHeadRead = false,
        tbPrevStoryId = cfg.PrevStories,
        bIsUnlock = bUnlock,
        sUnlockTips = sTxt
      }
      for i, v in ipairs(self.tbLine) do
        if v.nLineId == cfg.StoryLineId and 0 >= table.indexof(v.tbChapterId, cfg.Id) then
          table.insert(v.tbChapterId, cfg.Id)
          break
        end
      end
    end
  end
  
  local function foreach_Story(cfg)
    local tb = cfg.ParentStoryId
    if tb == nil or type(tb) == "table" and #tb == 0 then
      local n = self.mapChapter[cfg.Chapter].nHeadStoryId
      if n == 0 or 0 < n and n > cfg.Id then
        self.mapChapter[cfg.Chapter].nHeadStoryId = cfg.Id
        self.mapChapter[cfg.Chapter].bHeadRead = PlayerData.Avg:IsStoryReaded(cfg.Id)
        if cfg.Chapter == 1 then
          self.mapChapter[cfg.Chapter].bHeadRead = true
        end
      end
    end
  end
  
  ForEachTableLine(DataTable.StoryLine, foreach_Line)
  ForEachTableLine(DataTable.StoryChapter, foreach_Chapter)
  ForEachTableLine(DataTable.Story, foreach_Story)
  table.sort(self.tbLine, function(a, b)
    if a.nSort == b.nSort then
      return a.nLineId < b.nLineId
    else
      return a.nSort < b.nSort
    end
  end)
  local tbChapterId_HasNoStory = {}
  for k, v in pairs(self.mapChapter) do
    if v.nHeadStoryId == 0 then
      table.insert(tbChapterId_HasNoStory, k)
    end
  end
  for i, v in ipairs(tbChapterId_HasNoStory) do
    self.mapChapter[v] = nil
  end
  for i, v in ipairs(self.tbLine) do
    for ii, vv in ipairs(tbChapterId_HasNoStory) do
      local nIdx = table.indexof(v.tbChapterId, vv)
      if 0 < nIdx then
        table.remove(v.tbChapterId, nIdx)
      end
    end
  end
  local n = #self.tbLine
  for i = n, 1, -1 do
    local data = self.tbLine[i]
    if 0 >= #data.tbChapterId then
      table.remove(self.tbLine, i)
    else
      table.sort(data.tbChapterId)
      local nChapterId = data.tbChapterId[1]
      self.tbLine[i].bIsUnlock = self.mapChapter[nChapterId].bIsUnlock
      if data.bVisible == false and data.bIsUnlock == false then
        table.remove(self.tbLine, i)
      end
    end
  end
end

function StoryChapterCtrl:SetMoWang()
  local charId = AdjustMainRoleAvgCharId()
  local spBody, spFace, v3OffsetPos, v3OffsetScale, spBlackBody = self:GetAvgPortrait(charId, "a", "002")
  local trans = self._mapNode.rtActor2D
  local trPanelOffset = trans:GetChild(0)
  local trOffset = trPanelOffset:GetChild(0)
  trOffset.localScale = v3OffsetScale
  local imgBody = trOffset:GetChild(0):GetComponent("Image")
  local imgFace = trOffset:GetChild(1):GetComponent("Image")
  NovaAPI.SetImageSpriteAsset(imgBody, spBody)
  NovaAPI.SetImageSpriteAsset(imgFace, spFace)
  NovaAPI.SetImageNativeSize(imgBody)
  NovaAPI.SetImageNativeSize(imgFace)
  local tbPersonality, sTitle = PlayerData.Avg:CalcPersonality(1)
  NovaAPI.SetPersonalityRing(self._mapNode.goPersonality, tbPersonality)
  NovaAPI.SetTMPText(self._mapNode.txtName, sTitle)
end

function StoryChapterCtrl:CheckJustRead()
  if self.nChapterId_From ~= 0 then
    return
  end
  local nStoryId = PlayerData.Avg.nJustReadStoryId
  if nStoryId <= 0 then
    return
  end
  local cfg = ConfigTable.GetData("Story", nStoryId)
  if cfg == nil then
    return
  end
  local sAvgLuaName = cfg.StoryId
  self.nChapterId_From = cfg.Chapter
  cfg = ConfigTable.GetData("StoryChapter", self.nChapterId_From)
  self.nStoryLineId_From = cfg.StoryLineId
  self.bChapter_NeedPlayUnlockAnim = false
  local nNextChapterId = self.nChapterId_From + 1
  local data = self.mapChapter[nNextChapterId]
  if type(data) == "table" and 0 < table.indexof(data.tbPrevStoryId, sAvgLuaName) and data.bIsUnlock == true and data.bHeadRead == false and self:UnlockAnimHasPlayed(nNextChapterId) == false then
    self.bChapter_NeedPlayUnlockAnim = true
  end
  self:Check_StoryLine_NeedPlayUnlockAnim(nNextChapterId)
end

function StoryChapterCtrl:CheckLatest()
  if self.nChapterId_From ~= 0 then
    return
  end
  self.bChapter_NeedPlayUnlockAnim = false
  local tb = {}
  for k, v in pairs(self.mapChapter) do
    table.insert(tb, k)
  end
  table.sort(tb)
  local nNewUnlockChapterId = 0
  local n = #tb
  for i = n, 1, -1 do
    local nChapterId = tb[i]
    local data = self.mapChapter[nChapterId]
    if data.bIsUnlock == true then
      self.nChapterId_From = nChapterId
      if data.bHeadRead == false and self:UnlockAnimHasPlayed(nChapterId) == false then
        self.bChapter_NeedPlayUnlockAnim = true
        self.nChapterId_From = tb[i - 1]
        nNewUnlockChapterId = nChapterId
      end
      break
    end
  end
  local cfg = ConfigTable.GetData("StoryChapter", self.nChapterId_From)
  self.nStoryLineId_From = cfg.StoryLineId
  self:Check_StoryLine_NeedPlayUnlockAnim(nNewUnlockChapterId)
end

function StoryChapterCtrl:Check_StoryLine_NeedPlayUnlockAnim(nNextChapterId)
  self.nChapterId_To = 0
  self.nStoryLineId_To = 0
  self.bStoryLine_NeedPlayUnlockAnim = false
  self.bStoryLine_NeedPlaySwitchAnim = false
  if self.bChapter_NeedPlayUnlockAnim == true and 0 < nNextChapterId then
    self.nChapterId_To = nNextChapterId
    cfg = ConfigTable.GetData("StoryChapter", nNextChapterId)
    if cfg ~= nil then
      for i, v in ipairs(self.tbLine) do
        if v.nLineId == cfg.StoryLineId then
          if v.tbChapterId[1] == nNextChapterId then
            self.nStoryLineId_To = v.nLineId
            self.bStoryLine_NeedPlayUnlockAnim = true
            break
          end
          if cfg.StoryLineId ~= self.nStoryLineId_From then
            self.nStoryLineId_To = v.nLineId
            self.bStoryLine_NeedPlaySwitchAnim = true
          end
          break
        end
      end
    end
  end
end

function StoryChapterCtrl:FallbackToDefault()
  if self.nChapterId_From ~= 0 then
    return
  end
  self.nStoryLineId_From = 1
  self.nStoryLineId_To = 0
  self.bStoryLine_NeedPlayUnlockAnim = false
  self.bStoryLine_NeedPlaySwitchAnim = false
  self.nChapterId_From = 1
  self.nChapterId_To = 0
  self.bChapter_NeedPlayUnlockAnim = false
end

function StoryChapterCtrl:LoadLocalData()
  local sJson = LocalData.GetPlayerLocalData("UnlockAnimPlayedChapter")
  local tb = decodeJson(sJson)
  if type(tb) == "table" then
    self.tbUnlockAnimPlayedChapter = tb
    if table.indexof(self.tbUnlockAnimPlayedChapter, "1") <= 0 then
      table.insert(self.tbUnlockAnimPlayedChapter, "1")
    end
  end
end

function StoryChapterCtrl:MarkAndSaveLocalData(nChapterId)
  if type(self.tbUnlockAnimPlayedChapter) == "table" then
    local sId = tostring(nChapterId)
    if table.indexof(self.tbUnlockAnimPlayedChapter, sId) <= 0 then
      table.insert(self.tbUnlockAnimPlayedChapter, sId)
      local sJson = RapidJson.encode(self.tbUnlockAnimPlayedChapter)
      LocalData.SetPlayerLocalData("UnlockAnimPlayedChapter", sJson)
    end
  end
end

function StoryChapterCtrl:UnlockAnimHasPlayed(nChapterId)
  if type(self.tbUnlockAnimPlayedChapter) == "table" and table.indexof(self.tbUnlockAnimPlayedChapter, tostring(nChapterId)) > 0 then
    return true
  end
  return false
end

function StoryChapterCtrl:GetChapters(nLineId)
  for i, v in ipairs(self.tbLine) do
    if v.nLineId == nLineId then
      return v.tbChapterId
    end
  end
end

function StoryChapterCtrl:PlayRootAnim(bIn)
  local sAnimName = ""
  if bIn == true then
    sAnimName = "StoryChapter_Bg_MoveIn"
  else
    sAnimName = "StoryChapter_Bg_MoveOut"
  end
  self._mapNode.animBg:Play(sAnimName)
  if bIn == true then
    sAnimName = "tc_top_back_01_t_in"
  else
    sAnimName = "tc_top_back_01_t_out"
  end
  self._mapNode.animTopBar:Play(sAnimName)
  if bIn == true then
    sAnimName = "StoryChapterList_MoveIn"
  else
    sAnimName = "StoryChapterList_MoveOut"
  end
  self._mapNode.animChapterList:Play(sAnimName)
  if bIn == true then
    sAnimName = "StoryChapterMW_MoveIn"
  else
    sAnimName = "StoryChapterMW_MoveOut"
  end
  self._mapNode.animMoWang:Play(sAnimName)
  if bIn == true then
    sAnimName = "StoryChapter_LineBtn_In"
  else
    sAnimName = "StoryChapter_LineBtn_Out"
  end
  self._mapNode.animBtnShowStoryLineList:Play(sAnimName)
end

function StoryChapterCtrl:SetBtn_IconTitle(nLineId, bForceVisible)
  if bForceVisible == true then
    self._mapNode.btnShowStoryLineList.transform.localScale = Vector3.one
  else
    local b = false
    if #self.tbLine > 1 then
      b = true
      if self.bStoryLine_NeedPlayUnlockAnim == true and self.nStoryLineId_From == 1 and self.nStoryLineId_To == 2 then
        b = false
      end
    end
    self._mapNode.btnShowStoryLineList.transform.localScale = b == true and Vector3.one or Vector3.zero
  end
  local cfg = ConfigTable.GetData("StoryLine", nLineId)
  local sRemovedMain = string.gsub(cfg.TitleMain, "\n", "")
  local sRemovedSub = string.gsub(cfg.TitleSub, "\n", "")
  sRemovedMain = string.gsub(sRemovedMain, "\r", "")
  sRemovedSub = string.gsub(sRemovedSub, "\r", "")
  NovaAPI.SetTMPText(self._mapNode.txtTitle_Show, sRemovedMain)
  NovaAPI.SetTMPText(self._mapNode.txtTitle2_Show, sRemovedSub)
  self:SetPngSprite(self._mapNode.imgStoryIcon, cfg.Icon)
end

function StoryChapterCtrl:OnGrid_StoryLine(go, bPlayUnlockAnim)
  local nIndex = tonumber(go.name) + 1
  local data = self.tbLine[nIndex]
  local cfg = ConfigTable.GetData("StoryLine", data.nLineId)
  local tr = go.transform:Find("scale_on_click")
  local goSel = tr:Find("imgDb_Sel").gameObject
  local trOff = tr:Find("imgDb_off")
  local trOn = tr:Find("imgDb_on")
  NovaAPI.SetTMPText(trOff:Find("tmpTabTitle_off"):GetComponent("TMP_Text"), "???")
  NovaAPI.SetTMPText(trOn:Find("tmpTabTitle_on"):GetComponent("TMP_Text"), cfg.TitleMain)
  NovaAPI.SetTMPText(trOn:Find("tmpTabTitle_on/tmpTabTitle2_on"):GetComponent("TMP_Text"), cfg.TitleSub)
  self:SetPngSprite(trOn:Find("imgStoryIcon_on"):GetComponent("Image"), cfg.Icon)
  goSel:SetActive(self.nCurLineId == data.nLineId)
  if self.nCurLineId == data.nLineId then
    self.goLineSel = goSel
  end
  local goRedDot = trOn:Find("tmpTabTitle_on/redDotTab").gameObject
  RedDotManager.RegisterNode(RedDotDefine.Map_MainLine_StoryLine, data.nLineId, goRedDot)
  if bPlayUnlockAnim == true and data.nLineId == self.nStoryLineId_To then
    WwiseAudioMgr:PlaySound("ui_mainline_ago_unlock")
    go:GetComponent("Animator"):Play("StoryChapter_Line_unlock")
  elseif data.bIsUnlock == true and data.nLineId == self.nStoryLineId_To and self.nChapterId_To == data.tbChapterId[1] then
    go:GetComponent("Animator"):Play("StoryChapter_Line_off")
  else
    go:GetComponent("Animator"):Play("StoryChapter_Line_on")
  end
end

function StoryChapterCtrl:OnBtn_StoryLine(go)
  WwiseAudioMgr:PlaySound("ui_mainline_ago_point")
  local nIndex = tonumber(go.name) + 1
  local data = self.tbLine[nIndex]
  if self.nCurLineId == data.nLineId then
    return
  end
  if IsNull(self.goLineSel) == false then
    self.goLineSel:SetActive(false)
  end
  self.goLineSel = go.transform:Find("scale_on_click/imgDb_Sel").gameObject
  self.goLineSel:SetActive(true)
  self.nCurLineId = data.nLineId
  self.tbChapter = self:GetChapters(self.nCurLineId)
  self.bPlayChapterIn = true
  self.nChapterIn = 0.333
  self._mapNode.loopsvChapterList:Init(#self.tbChapter, self, self.OnGrid_Chapter, self.OnBtn_Chapter)
  self:SetBtn_IconTitle(self.nCurLineId, true)
end

function StoryChapterCtrl:OnGrid_Chapter(go, bPlayUnlockAnim)
  local nIndex = tonumber(go.name) + 1
  local nChapterId = self.tbChapter[nIndex]
  local data = self.mapChapter[nChapterId]
  local cfg = ConfigTable.GetData("StoryChapter", nChapterId)
  local goA = go.transform:Find("btn").gameObject
  local goB = go.transform:Find("Branch").gameObject
  goA:SetActive(cfg.Type == GameEnum.chapterType.Mainline)
  goB:SetActive(cfg.Type == GameEnum.chapterType.Branchline)
  local tr = goA.transform:Find("AnimRoot")
  if cfg.Type == GameEnum.chapterType.Branchline then
    tr = goB.transform:Find("AnimRoot")
  end
  self:SetPngSprite(tr:Find("imgBg"):GetComponent("Image"), cfg.ChapterIcon)
  NovaAPI.SetTMPText(tr:Find("imgTitle1/txtChapterIndex"):GetComponent("TMP_Text"), cfg.Name)
  NovaAPI.SetTMPText(tr:Find("txtIndex"):GetComponent("TMP_Text"), cfg.Index)
  NovaAPI.SetTMPText(tr:Find("goUnlock/txtTitle"):GetComponent("TMP_Text"), cfg.Desc)
  local sTxt = ConfigTable.GetUIText("Chapter_Not_Unlock")
  if data.bIsUnlock == true then
    local nStoryId = PlayerData.Avg:GetRecentStoryId(nChapterId)
    cfg = ConfigTable.GetData("Story", nStoryId)
    sTxt = cfg.Index .. " " .. cfg.Title
  end
  NovaAPI.SetTMPText(tr:Find("goUnlock/txtIndexTitle"):GetComponent("TMP_Text"), sTxt)
  NovaAPI.SetTMPText(tr:Find("goLock/txtLock"):GetComponent("TMP_Text"), data.sUnlockTips or "")
  local goRedDot = tr:Find("ChapterRedDot").gameObject
  RedDotManager.RegisterNode(RedDotDefine.Map_MainLine_Chapter, {
    self.nCurLineId,
    nChapterId
  }, goRedDot)
  local bIsOn = data.bIsUnlock == true and nChapterId ~= self.nChapterId_To
  tr:Find("goLock").gameObject:SetActive(bIsOn == false)
  local anim = tr:GetComponent("Animator")
  if self.bPlayChapterIn == true then
    if (nIndex - 1) * 0.1 + 0.333 > self.nChapterIn then
      self.nChapterIn = (nIndex - 1) * 0.1 + 0.333
    end
    anim:Play("StoryChapter_CH_in2")
    self._mapNode.loopsvChapterList:PlayAnim(anim, "StoryChapter_CH_in", (nIndex - 1) * 0.1)
  elseif bPlayUnlockAnim == true and nChapterId == self.nChapterId_To then
    self:MarkAndSaveLocalData(nChapterId)
    WwiseAudioMgr:PlaySound("ui_mainline_ago_unlock_2")
    anim:Play("StoryChapter_CH_unlock")
  elseif self.bPlayEnterChapter == true then
    if nChapterId == self.nCurChapterId then
      anim:Play("StoryChapter_CH_setout")
    else
      anim:Play("StoryChapter_CH_unsetout")
    end
  else
    anim:Play("StoryChapter_CH_refresh")
  end
end

function StoryChapterCtrl:OnBtn_Chapter(go)
  WwiseAudioMgr:PlaySound("ui_mainline_chapter_click")
  local nIndex = tonumber(go.name) + 1
  local nChapterId = self.tbChapter[nIndex]
  local cfg = ConfigTable.GetData("StoryChapter", nChapterId)
  if self.mapChapter[nChapterId].bIsUnlock == false then
    EventManager.Hit(EventId.OpenMessageBox, self.mapChapter[nChapterId].sUnlockTips)
    return
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 1)
  self.nCurChapterId = nChapterId
  
  local function Play_ChapterAnim()
    self.bPlayEnterChapter = true
    self._mapNode.loopsvChapterList:Init(#self.tbChapter, self, self.OnGrid_Chapter, self.OnBtn_Chapter, true)
    self._mapNode.animMoWang:Play("StoryChapterMW_MoveOut")
  end
  
  local function OpenPanel()
    local nPanelId = cfg.StoryPanelId
    if nPanelId == 0 then
      nPanelId = PanelId.MainlineEx
    end
    EventManager.Hit(EventId.OpenPanel, nPanelId, self.nCurChapterId)
  end
  
  if type(self._panel._tbParam) ~= "table" then
    self._panel._tbParam = {}
  end
  self._panel._tbParam[1] = self.nCurChapterId
  local seq = DOTween.Sequence()
  seq:AppendInterval(0.1)
  seq:AppendCallback(Play_ChapterAnim)
  seq:AppendInterval(0.3)
  seq:AppendCallback(OpenPanel)
  seq:SetUpdate(true)
end

function StoryChapterCtrl:OnBtn_ShowStoryLineList()
  WwiseAudioMgr:PlaySound("ui_mainline_ago_point")
  self._mapNode.animBtnShowStoryLineList:Play("StoryChapter_LineBtn_Out")
  self._mapNode.animChapterList:Play("StoryChapterList_MoveRight")
  self._mapNode.animMoWang:Play("StoryChapterMW_MoveOut")
  WwiseAudioMgr:PlaySound("ui_mainline_ago")
end

function StoryChapterCtrl:OnBtn_HideStoryLineList()
  WwiseAudioMgr:PlaySound("ui_mainline_ago_out")
  self.bPlayChapterIn = false
  self.nChapterIn = 0
  self._mapNode.animBtnShowStoryLineList:Play("StoryChapter_LineBtn_In")
  self._mapNode.animChapterList:Play("StoryChapterList_MoveLeft")
  self._mapNode.animMoWang:Play("StoryChapterMW_MoveIn")
end

function StoryChapterCtrl:OnBtn_ChangeInfo()
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
  EventManager.Hit(EventId.OpenPanel, PanelId.ChangeGender)
end

function StoryChapterCtrl:OnEvent_UIBackConfirm(nPanelId)
  if nPanelId == PanelId.StoryChapter then
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
    EventManager.Hit(EventId.ClosePanel, nPanelId)
  end
end

function StoryChapterCtrl:OnEvent_BackHome(nPanelId)
  if nPanelId == PanelId.StoryChapter then
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
    PanelManager.Home()
  end
end

return StoryChapterCtrl

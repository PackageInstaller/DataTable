local FriendIdCardCtrl = class("FriendIdCardCtrl", BaseCtrl)
local LocalData = require("GameCore.Data.LocalData")
FriendIdCardCtrl._mapNodeConfig = {
  goBlur = {},
  RectCard = {},
  imgSaveBtn = {},
  goTip = {},
  btnCloseCard = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseIdCard"
  },
  btnSaveCard = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenAskPermission"
  },
  txtTicketTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Ticket_Title"
  },
  txtNameCard = {sComponentName = "TMP_Text"},
  txtUidCard = {sComponentName = "TMP_Text"},
  txtUidTitle = {sComponentName = "TMP_Text", sLanguageId = "Friend_UID"},
  txtTitleTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_TitleTag"
  },
  txtTitleCard = {sComponentName = "TMP_Text"},
  txtProfileCard = {sComponentName = "TMP_Text"},
  imgPlayerHeadCard = {sComponentName = "Image"},
  txtRankCard = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_RANK"
  },
  txtWorldClassCard = {sComponentName = "TMP_Text"},
  goHonorTitleCard = {
    nCount = 3,
    sCtrlName = "Game.UI.FriendEx.HonorTitleCtrl"
  },
  txtMainline = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainLine_Progress"
  },
  txtMainlineProgress = {sComponentName = "TMP_Text"},
  txtAchievement = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Card_Achievement"
  },
  txtAchievementCount = {sComponentName = "TMP_Text"},
  txtDisc = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Card_Disc"
  },
  txtDiscCount = {sComponentName = "TMP_Text"},
  txtChar = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Card_Char"
  },
  txtCharCount = {sComponentName = "TMP_Text"},
  txtCardCloseTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Close_Tip"
  },
  txtCardCloseTipShadow = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Close_Tip"
  },
  txtSaveCard = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Save_Card_Button"
  }
}

function FriendIdCardCtrl:OnInit()
  self._mapNode.goTip:SetActive(false)
  self._mapNode.imgSaveBtn:SetActive(false)
  self._mapNode.RectCard:SetActive(false)
  self._mapNode.goBlur:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goBlur:SetActive(true)
    
    local function innerWait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      self.gameObject.transform.parent.parent:GetComponent("Animator"):Play("FriendPanel_IdCard_in", -1, 0)
      self:Refresh()
    end
    
    cs_coroutine.start(innerWait)
  end
  
  cs_coroutine.start(wait)
end

function FriendIdCardCtrl:Refresh()
  self._mapNode.RectCard:SetActive(true)
  local bGP = CS.ClientManager.Instance.isAndroidOnPC
  if not bGP then
    self._mapNode.imgSaveBtn:SetActive(true)
  else
    self._mapNode.imgSaveBtn:SetActive(false)
  end
  self._mapNode.goTip:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtNameCard, PlayerData.Base:GetPlayerNickName())
  NovaAPI.SetTMPText(self._mapNode.txtUidCard, PlayerData.Base:GetPlayerId())
  self:RefreshTitle()
  self:RefreshHead()
  self:RefreshHonorTitle()
  NovaAPI.SetTMPText(self._mapNode.txtProfileCard, PlayerData.Base:GetPlayerSignature())
  NovaAPI.SetTMPText(self._mapNode.txtWorldClassCard, PlayerData.Base:GetWorldClass())
  self:RefreshMainlineProgress()
  NovaAPI.SetTMPText(self._mapNode.txtAchievementCount, PlayerData.Achievement:GetAchievementAllTypeCount().nCompleted)
  local tbDisc = PlayerData.Disc:GetDiscIdList()
  NovaAPI.SetTMPText(self._mapNode.txtDiscCount, #tbDisc)
  local tbChar = PlayerData.Char:GetCharIdList()
  NovaAPI.SetTMPText(self._mapNode.txtCharCount, #tbChar)
end

function FriendIdCardCtrl:RefreshTitle()
  local nPre, nSuf = PlayerData.Base:GetPlayerTitle()
  if nPre == 0 or nSuf == 0 then
    NovaAPI.SetTMPText(self._mapNode.txtTitleCard, "")
    return
  end
  local sTitle = orderedFormat(ConfigTable.GetUIText("FriendPanel_PlayerTitle") or "", ConfigTable.GetData("Title", nPre).Desc, ConfigTable.GetData("Title", nSuf).Desc)
  NovaAPI.SetTMPText(self._mapNode.txtTitleCard, sTitle)
end

function FriendIdCardCtrl:RefreshHead()
  local nHeadId = PlayerData.Base:GetPlayerHeadId()
  local mapCfg = ConfigTable.GetData("PlayerHead", nHeadId)
  if mapCfg ~= nil then
    self:SetPngSprite(self._mapNode.imgPlayerHeadCard, mapCfg.Icon)
  end
end

function FriendIdCardCtrl:RefreshHonorTitle()
  local tbOwnHonorData = PlayerData.Base:GetPlayerHonorTitleList() or {}
  local tbCurHonorTitle = PlayerData.Base:GetPlayerHonorTitle()
  for i = 1, 3 do
    if tbCurHonorTitle[i] ~= nil and tbCurHonorTitle[i].Id ~= 0 and tbCurHonorTitle[i] ~= nil then
      local honorData = ConfigTable.GetData("Honor", tbCurHonorTitle[i].Id)
      local level
      if honorData.Type == GameEnum.honorType.Character then
        local affinityData = PlayerData.Char:GetCharAffinityData(honorData.Params[1])
        level = affinityData.Level
      elseif honorData.Type == GameEnum.honorType.Levels then
        for k, v in pairs(tbOwnHonorData) do
          if v.Id == honorData.Id then
            level = v.Lv or 1
            break
          end
        end
      elseif honorData.Type == GameEnum.honorType.Dorm then
        level = PlayerData.PlayerDormData:GetHonorTitleLevel()
      end
      self._mapNode.goHonorTitleCard[i]:SetHonotTitle(honorData.Id, i == 1, level)
    end
    self._mapNode.goHonorTitleCard[i].gameObject:SetActive(tbCurHonorTitle[i] ~= nil and tbCurHonorTitle[i].Id ~= 0)
  end
end

function FriendIdCardCtrl:RefreshMainlineProgress()
  local curStoryId = PlayerData.Avg:GetLastestStoryId()
  local storyConfig = ConfigTable.GetData_Story(curStoryId)
  local nChapter = storyConfig.Chapter
  local mapChapterData = ConfigTable.GetData("StoryChapter", nChapter)
  local nChapterIndex = 1
  if mapChapterData ~= nil then
    nChapterIndex = mapChapterData.Index
  end
  local title = nChapterIndex .. "-" .. storyConfig.Index
  NovaAPI.SetTMPText(self._mapNode.txtMainlineProgress, title)
end

function FriendIdCardCtrl:SaveIdCard()
  local compCapture = self.gameObject:GetComponent("UICapture")
  if compCapture ~= nil then
    local function await(bRes)
      local sTip
      
      if bRes == true then
        local curPlatform = CS.ClientManager.Instance.Platform
        if curPlatform == "ios" or curPlatform == "android" then
          sTip = ConfigTable.GetUIText("Friend_Save_Card_Mobile")
        else
          sTip = ConfigTable.GetUIText("Friend_Save_Card_Pc")
        end
      else
        sTip = ConfigTable.GetUIText("Friend_Card_Save_Failed")
      end
      EventManager.Hit(EventId.OpenMessageBox, sTip)
    end
    
    compCapture:CaptureUIRect(await)
  end
end

function FriendIdCardCtrl:OnBtnClick_CloseIdCard()
  self.gameObject:SetActive(false)
end

function FriendIdCardCtrl:OnBtnClick_OpenAskPermission()
  local bSavePermission = LocalData.GetPlayerLocalData("SavePermission" .. tostring(PlayerData.Base:GetPlayerId()))
  if bSavePermission == true then
    self:SaveIdCard()
    return
  end
  
  local function confirmCallback()
    self:SaveIdCard()
  end
  
  local function againCallback(isSelect)
    if isSelect == true then
      LocalData.SetPlayerLocalData("SavePermission" .. tostring(PlayerData.Base:GetPlayerId()), true)
    end
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Friend_Save_Card_Permission_Tips"),
    callbackConfirm = confirmCallback,
    callbackAgain = againCallback,
    sAgain = ConfigTable.GetUIText("SavePermission_Tips_NeverAgain"),
    bBlur = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

return FriendIdCardCtrl

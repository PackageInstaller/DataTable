local FriendInfoCtrl = class("FriendInfoCtrl", BaseCtrl)
FriendInfoCtrl._mapNodeConfig = {
  btnPortrait = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangePortrait"
  },
  btnIdCard = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ShowIdCard"
  },
  btnHead = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeHead"
  },
  imgPlayerHead = {sComponentName = "Image"},
  txtWorldClass = {sComponentName = "TMP_Text"},
  txtRankCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_RANK"
  },
  txtName = {sComponentName = "TMP_Text"},
  btnName = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeName"
  },
  txtTitle = {sComponentName = "TMP_Text"},
  btnTitle = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeTitle"
  },
  txtUIDCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_UIDInfo"
  },
  txtUID = {sComponentName = "TMP_Text"},
  btnCopyUID = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CopyUID"
  },
  txtSign = {sComponentName = "TMP_Text"},
  txtBtnSign = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_Sign"
  },
  btnSign = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeSign"
  },
  txtTitleChar = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_CoreMember"
  },
  btnChar = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Char"
  },
  goChar = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplateCharCtrl"
  },
  imgEmpty = {nCount = 3},
  btnHonorTitle = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeHonorTitle"
  },
  btnChangeHonorTitle = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeHonorTitle"
  },
  goHonorTitle = {
    nCount = 3,
    sCtrlName = "Game.UI.FriendEx.HonorTitleCtrl"
  },
  imgHonorTitleBg = {nCount = 3},
  redDotTitle = {},
  redDotHead = {},
  HonorTitleReddot = {},
  IdCard = {
    sNodeName = "--IdCard--",
    sCtrlName = "Game.UI.FriendEx.FriendIdCardCtrl"
  }
}
FriendInfoCtrl._mapEventConfig = {
  FriendRefreshHead = "RefreshHead",
  FriendRefreshName = "RefreshName",
  FriendRefreshTitle = "RefreshTitle",
  FriendRefreshSign = "RefreshSign",
  FriendRefreshMember = "RefreshMember",
  FriendRefreshActor = "RefreshActor",
  HonorTitle_Change = "RefreshHonorTitle"
}
FriendInfoCtrl._mapRedDotConfig = {
  [RedDotDefine.Friend_Info_Title] = {
    sNodeName = "redDotTitle"
  },
  [RedDotDefine.Friend_Info_Head] = {sNodeName = "redDotHead"},
  [RedDotDefine.Friend_Honor_Title] = {
    sNodeName = "HonorTitleReddot"
  }
}

function FriendInfoCtrl:Refresh()
  self:RefreshName()
  self:RefreshHead()
  self:RefreshTitle()
  self:RefreshSign()
  self:RefreshMember()
  self:RefreshOther()
  self:RefreshActor()
  self:RefreshHonorTitle()
end

function FriendInfoCtrl:RefreshName()
  local sName = PlayerData.Base:GetPlayerNickName()
  local nHashtag = PlayerData.Base:GetPlayerHashtag()
  NovaAPI.SetTMPText(self._mapNode.txtName, sName)
  NovaAPI.SetTMPText(self._mapNode.txtUID, PlayerData.Base:GetPlayerId())
end

function FriendInfoCtrl:RefreshHead()
  local nHeadId = PlayerData.Base:GetPlayerHeadId()
  local mapCfg = ConfigTable.GetData("PlayerHead", nHeadId)
  if mapCfg ~= nil then
    self:SetPngSprite(self._mapNode.imgPlayerHead, mapCfg.Icon)
  end
end

function FriendInfoCtrl:RefreshTitle()
  local nPre, nSuf = PlayerData.Base:GetPlayerTitle()
  if nPre == 0 or nSuf == 0 then
    NovaAPI.SetTMPText(self._mapNode.txtTitle, "")
    return
  end
  local sTitle = orderedFormat(ConfigTable.GetUIText("FriendPanel_PlayerTitle") or "", ConfigTable.GetData("Title", nPre).Desc, ConfigTable.GetData("Title", nSuf).Desc)
  NovaAPI.SetTMPText(self._mapNode.txtTitle, sTitle)
end

function FriendInfoCtrl:RefreshSign()
  NovaAPI.SetTMPText(self._mapNode.txtSign, PlayerData.Base:GetPlayerSignature())
end

function FriendInfoCtrl:RefreshMember()
  local tbChar = PlayerData.Base:GetPlayerCoreTeam()
  for i = 1, 3 do
    self._mapNode.imgEmpty[i]:SetActive(tbChar[i] == 0)
    self._mapNode.goChar[i].gameObject:SetActive(tbChar[i] ~= 0)
    if tbChar[i] ~= 0 then
      self._mapNode.goChar[i]:SetChar(tbChar[i])
    end
  end
end

function FriendInfoCtrl:RefreshOther()
  NovaAPI.SetTMPText(self._mapNode.txtWorldClass, PlayerData.Base:GetWorldClass())
end

function FriendInfoCtrl:RefreshActor()
  local nSkinId = PlayerData.Base:GetPlayerShowSkin()
  local nCharId = ConfigTable.GetData_CharacterSkin(nSkinId).CharId
  EventManager.Hit("FriendRefreshActor2D", nCharId, nSkinId)
end

function FriendInfoCtrl:RefreshHonorTitle()
  local tbCurHonorTitle = PlayerData.Base:GetPlayerHonorTitle()
  local tbOwnHonorData = PlayerData.Base:GetPlayerHonorTitleList() or {}
  for i = 1, 3 do
    if tbCurHonorTitle[i] ~= nil and tbCurHonorTitle[i].Id ~= 0 and tbCurHonorTitle[i] ~= nil then
      local honorData = ConfigTable.GetData("Honor", tbCurHonorTitle[i].Id)
      local level
      if honorData.Type == GameEnum.honorType.Character then
        local affinityData = PlayerData.Char:GetCharAffinityData(honorData.Params[1])
        if affinityData ~= nil then
          level = affinityData.Level
        else
          printError("不存在角色" .. honorData.Params[1])
        end
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
      self._mapNode.goHonorTitle[i]:SetHonotTitle(honorData.Id, i == 1, level)
    end
    self._mapNode.goHonorTitle[i].gameObject:SetActive(tbCurHonorTitle[i] ~= nil and tbCurHonorTitle[i].Id ~= 0)
    self._mapNode.imgHonorTitleBg[i].gameObject:SetActive(tbCurHonorTitle[i] == nil or tbCurHonorTitle[i].Id == 0)
  end
end

function FriendInfoCtrl:Awake()
end

function FriendInfoCtrl:OnEnable()
  self._mapNode.IdCard.gameObject:SetActive(false)
end

function FriendInfoCtrl:OnDisable()
end

function FriendInfoCtrl:OnDestroy()
end

function FriendInfoCtrl:OnBtnClick_CopyUID()
  CS.UnityEngine.GUIUtility.systemCopyBuffer = PlayerData.Base:GetPlayerId()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_UIDCopied_Tip"))
end

function FriendInfoCtrl:OnBtnClick_ShowIdCard()
  local function dataCompleteCallback()
    self._mapNode.IdCard.gameObject:SetActive(true)
    
    self._mapNode.IdCard:OnInit()
  end
  
  PlayerData.Achievement:SendAchievementInfoReq(dataCompleteCallback)
end

function FriendInfoCtrl:OnBtnClick_ChangeHead(btn)
  local function callback()
    EventManager.Hit("FriendChangeHead")
  end
  
  PlayerData.HeadData:SendGetHeadListMsg(callback)
end

function FriendInfoCtrl:OnBtnClick_ChangeName(btn)
  local bOpen = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.NickNameReset, true)
  if not bOpen then
    return
  end
  local bCD = PlayerData.Base:CheckRenameCD()
  if bCD then
    return
  end
  EventManager.Hit("FriendChangeName")
end

function FriendInfoCtrl:OnBtnClick_ChangeTitle(btn)
  EventManager.Hit("FriendChangeTitle")
end

function FriendInfoCtrl:OnBtnClick_ChangePortrait(btn)
  EventManager.Hit("FriendChangePortrait")
end

function FriendInfoCtrl:OnBtnClick_ChangeSign(btn)
  EventManager.Hit("FriendChangeSignature")
end

function FriendInfoCtrl:OnBtnClick_Char(btn, nIndex)
  EventManager.Hit("FriendChangeMember")
end

function FriendInfoCtrl:OnBtnClick_ChangeHonorTitle()
  EventManager.Hit("FriendChangeHonorTitle")
end

return FriendInfoCtrl

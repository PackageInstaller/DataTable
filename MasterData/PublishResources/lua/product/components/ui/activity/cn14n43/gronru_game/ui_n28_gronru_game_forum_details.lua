_class("UIN28GronruGameForumDetails", UIController)
UIN28GronruGameForumDetails = UIN28GronruGameForumDetails

function UIN28GronruGameForumDetails:Constructor()
end

function UIN28GronruGameForumDetails:LoadDataOnEnter(TT, res, uiParams)
  self._cfg = uiParams[1]
end

function UIN28GronruGameForumDetails:OnShow(uiParams)
  self._uiAgree = self:GetUIComponent("Image", "uiAgree")
  self._uiDisagreee = self:GetUIComponent("Image", "uiDisagreee")
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self._txtPublisher = self:GetUIComponent("UILocalizationText", "txtPublisher")
  self._imgIcon = self:GetUIComponent("Image", "imgIcon")
  self._txtTimeTotal = self:GetUIComponent("UILocalizationText", "txtTimeTotal")
  self._txtTimePublish = self:GetUIComponent("UILocalizationText", "txtTimePublish")
  self._txtContentTitle = self:GetUIComponent("UILocalizationText", "txtContentTitle")
  self._txtContentDesc = self:GetUIComponent("UILocalizationText", "txtContentDesc")
  self._animation = self:GetUIComponent("Animation", "animation")
  if self._cfg == nil then
    self:FlushNews()
  else
    self:FlushForum()
  end
end

function UIN28GronruGameForumDetails:OnHide()
end

function UIN28GronruGameForumDetails:BtnCloseOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BounceFolder)
  self:StartTask(function(TT)
    self:Lock("UIN28GronruGameForumDetails:BtnCloseOnClick")
    self._animation:Play("UIN28GronruGameForumDetails_out")
    YIELD(TT, 167)
    self:UnLock("UIN28GronruGameForumDetails:BtnCloseOnClick")
    self:CloseDialog()
  end)
end

function UIN28GronruGameForumDetails:FlushNews()
  self._uiAgree.gameObject:SetActive(false)
  self._uiDisagreee.gameObject:SetActive(false)
end

function UIN28GronruGameForumDetails:FlushForum()
  self._uiAgree.gameObject:SetActive(self._cfg.CommentType == UIN28GronruPlatformType.Forum_Comment_Agree)
  self._uiDisagreee.gameObject:SetActive(self._cfg.CommentType == UIN28GronruPlatformType.Forum_Comment_Disagree)
  if self._cfg.CommentType == UIN28GronruPlatformType.Forum_Comment_Agree then
    self._txtTitle:SetText(StringTable.Get("str_n28_gronru_uiaf_agree"))
  else
    self._txtTitle:SetText(StringTable.Get("str_n28_gronru_uiaf_disagreee"))
  end
  local value = StringTable.Get(self._cfg.Publisher)
  self._txtPublisher:SetText(StringTable.Get("str_n28_gronru_uia_forum_publisher") .. value)
  local atlas = self:CallUIMethod("UIN28GronruPlatform", "GetSpriteAtlas")
  self._imgIcon.sprite = atlas:GetSprite(self._cfg.Head)
  local value = StringTable.Get(self._cfg.GameDuration)
  self._txtTimeTotal:SetText(StringTable.Get("str_n28_gronru_uia_game_time_hour", value))
  self._txtTimePublish:SetText(StringTable.Get(self._cfg.TimePublish))
  self._txtContentTitle.gameObject:SetActive(false)
  self._txtContentDesc:SetText(StringTable.Get(self._cfg.Desc))
end

_class("UIActivityIntroController", UIController)
UIActivityIntroController = UIActivityIntroController

function UIActivityIntroController:Constructor()
end

function UIActivityIntroController:OnShow(uiParams)
  self._param = uiParams[1] or "nil"
  self._cfg = Cfg.cfg_activityintro[self._param]
  if self._cfg == nil then
    Log.fatal("###[UIActivityIntroController] self._cfg is nil. param --> ", self._param)
  end
  self:InitWidget()
  self:_OnValue()
end

function UIActivityIntroController:InitWidget()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._titleBg = self:GetUIComponent("RectTransform", "TitleBg")
  self._titleBgImg = self:GetUIComponent("Image", "TitleBg")
  self._subTitle = self:GetUIComponent("UILocalizationText", "SubTitle")
  self._content = self:GetUIComponent("UILocalizationText", "Content")
  self._animation = self:GetUIComponent("Animation", "uianim")
  self._bg = self:GetUIComponent("RawImageLoader", "Bg")
  self._btnImgGo = self:GetGameObject("ConfirmBtn")
  self._btnImgNormal = self:GetUIComponent("RawImageLoader", "ConfirmBtn1")
  self._btnImgClick = self:GetUIComponent("RawImageLoader", "ConfirmBtn2")
  self._btnImgNormalGo = self:GetGameObject("ConfirmBtn1")
  self._btnImgClickGo = self:GetGameObject("ConfirmBtn2")
end

function UIActivityIntroController:_OnValue()
  self._bg:LoadImage(self._cfg.BG)
  self._btnImgNormal:LoadImage(self._cfg.BtnNormal)
  self._btnImgClick:LoadImage(self._cfg.BtnClick)
  self._title:SetText(StringTable.Get(self._cfg.Title))
  self._subTitle:SetText(StringTable.Get(self._cfg.SubTitle))
  self._content:SetText(StringTable.Get(self._cfg.Intro))
  if self._cfg.TitlePosOffset then
    local titleGroup = self:GetUIComponent("RectTransform", "TitleGroup")
    titleGroup.anchoredPosition = Vector2(self._cfg.TitlePosOffset[1], self._cfg.TitlePosOffset[2])
  end
  self._titleBg.gameObject:SetActive(false)
  if self._cfg.TitleTextBgAtlas and self._cfg.TitleTextBgInfo then
    local atlas = self:GetAsset(self._cfg.TitleTextBgAtlas[1], LoadType.SpriteAtlas)
    local spriteId = self._cfg.TitleTextBgAtlas[2]
    self._titleBgImg.sprite = atlas:GetSprite(spriteId)
    local width = self._title.preferredWidth + self._cfg.TitleTextBgInfo[1]
    local height = self._cfg.TitleTextBgInfo[2]
    self._titleBg.sizeDelta = Vector2(width, height)
    self._titleBg.gameObject:SetActive(true)
  end
  if self._cfg.BgPosOffset then
    self._bg.gameObject:GetComponent("RectTransform").anchoredPosition = Vector2(self._cfg.BgPosOffset[1], self._cfg.BgPosOffset[2])
  end
  if self._cfg.ConfirmBtnInfo then
    self._btnImgNormalGo:GetComponent("RectTransform").anchoredPosition = Vector2(self._cfg.ConfirmBtnInfo[1], self._cfg.ConfirmBtnInfo[2])
    self._btnImgClickGo:GetComponent("RectTransform").anchoredPosition = Vector2(self._cfg.ConfirmBtnInfo[1], self._cfg.ConfirmBtnInfo[2])
    self._btnImgNormalGo:GetComponent("RectTransform").sizeDelta = Vector2(self._cfg.ConfirmBtnInfo[3], self._cfg.ConfirmBtnInfo[4])
    self._btnImgClickGo:GetComponent("RectTransform").sizeDelta = Vector2(self._cfg.ConfirmBtnInfo[3], self._cfg.ConfirmBtnInfo[4])
  end
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnImgGo), UIEvent.Press, function(go)
    self._btnImgClickGo:SetActive(true)
    self._btnImgNormalGo:SetActive(false)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnImgGo), UIEvent.Release, function(go)
    self._btnImgNormalGo:SetActive(true)
    self._btnImgClickGo:SetActive(false)
  end)
  if self._cfg and not string.isnullorempty(self._cfg.ShowAnim) then
    self._animation:Play(self._cfg.ShowAnim)
  end
end

function UIActivityIntroController:ConfirmBtnOnClick(go)
  self:Lock("UIActivityIntroController:OnHide")
  if self._cfg and not string.isnullorempty(self._cfg.HideAnim) then
    self._animation:Play(self._cfg.HideAnim)
  end
  self:StartTask(function(TT)
    YIELD(TT, 600)
    self:UnLock("UIActivityIntroController:OnHide")
    self:CloseDialog()
  end, self)
end

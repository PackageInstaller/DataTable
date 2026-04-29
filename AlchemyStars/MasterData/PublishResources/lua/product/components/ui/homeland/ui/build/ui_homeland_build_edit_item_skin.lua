_class("UIHomelandBuildEditItemSkin", UICustomWidget)
UIHomelandBuildEditItemSkin = UIHomelandBuildEditItemSkin

function UIHomelandBuildEditItemSkin:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.mUIHomeland = self.mHomeland:GetUIModule()
  self.homelandClient = self.mUIHomeland:GetClient()
  self.homeBuildManager = self.homelandClient:BuildManager()
  self.beginPos = Vector2.zero
end

function UIHomelandBuildEditItemSkin:OnShow()
  self.bg = self:GetGameObject("bg")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtLiveable = self:GetUIComponent("UILocalizationText", "txtLiveable")
  self.using = self:GetGameObject("using")
  self.using:SetActive(false)
  local etl = UICustomUIEventListener.Get(self.bg)
  self:AddUICustomEventListener(etl, UIEvent.Click, function(go)
    if self.using.activeSelf then
      return
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandBuildChangeSkin, self.id)
  end)
  self:AttachEvent(GameEventType.HomelandBuildChangeSkin, self.OnChangeSkin)
end

function UIHomelandBuildEditItemSkin:OnHide()
  self.imgIcon:DestoryLastImage()
  self:DetachEvent(GameEventType.HomelandBuildChangeSkin, self.OnChangeSkin)
end

function UIHomelandBuildEditItemSkin:Flush(cfg, curSkinID)
  self.id = cfg.ID
  self.using:SetActive(self.id == curSkinID)
  self.imgIcon:LoadImage(cfg.SkinIcon)
  self.txtLiveable:SetText("+" .. cfg.LivableValue)
end

function UIHomelandBuildEditItemSkin:OnChangeSkin(id)
  self.using:SetActive(self.id == id)
end

_class("UIHomelandBuildEditTab1", UICustomWidget)
UIHomelandBuildEditTab1 = UIHomelandBuildEditTab1

function UIHomelandBuildEditTab1:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.mUIHomeland = self.mHomeland:GetUIModule()
  self.homelandClient = self.mUIHomeland:GetClient()
  self.homeBuildManager = self.homelandClient:BuildManager()
  self.normalSprite = "n17_layout_btn01"
  self.selectedSprite = "n17_layout_btn02"
end

function UIHomelandBuildEditTab1:OnShow()
  self.imgTab = self:GetUIComponent("Image", "imgTab")
  self.imgIcon = self:GetUIComponent("Image", "imgIcon")
  self.txtFilter = self:GetUIComponent("UILocalizationText", "txtFilter")
  self.new = self:GetGameObject("new")
  self.new:SetActive(false)
  self.atlas = self:GetAsset("UIHomelandBuildInfo.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.HomelandBuildFilterTab1, self.ShowHideFilter)
end

function UIHomelandBuildEditTab1:OnHide()
  self:DetachEvent(GameEventType.HomelandBuildFilterTab1, self.ShowHideFilter)
end

function UIHomelandBuildEditTab1:Flush(id)
  self.id = id
  local filter = UIHomelandBuildEdit.GetBuildFilterById(id)
  self.txtFilter:SetText(filter.name)
  self.imgIcon.sprite = self.atlas:GetSprite(filter.icon)
  if self.id == UIHomelandBuildEdit.ChangeSkinFilterID then
    self.normalSprite = "n17_layout_btn08"
    self.selectedSprite = "n17_layout_btn09"
  end
end

function UIHomelandBuildEditTab1:SetNew(new)
  if new then
    self.new:SetActive(true)
  else
    self.new:SetActive(false)
  end
end

function UIHomelandBuildEditTab1:ShowHideFilter(showId)
  if self.id == showId then
    self.imgTab.sprite = self.atlas:GetSprite(self.selectedSprite)
  else
    self.imgTab.sprite = self.atlas:GetSprite(self.normalSprite)
  end
end

function UIHomelandBuildEditTab1:imgTabOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandBuildFilterTab1, self.id)
end

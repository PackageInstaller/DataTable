_class("UIHomelandBackpackTab", UICustomWidget)
UIHomelandBackpackTab = UIHomelandBackpackTab

function UIHomelandBackpackTab:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.data = self.mHomeland:GetHomelandBackpackData()
  self.dictFilterIcon = {
    [1] = "n17_pack_icon02",
    [2] = "n17_pack_icon03",
    [3] = "n17_pack_icon04",
    [4] = "n17_pack_icon05",
    [5] = "n17_pack_icon06"
  }
end

function UIHomelandBackpackTab:OnShow()
  self.imgTab = self:GetUIComponent("Image", "imgTab")
  self.imgIcon = self:GetUIComponent("Image", "imgIcon")
  self.txtFilter = self:GetUIComponent("UILocalizationText", "txtFilter")
  self.red = self:GetGameObject("red")
  self.red:SetActive(false)
  self.atlas = self:GetAsset("UIHomelandBackpack.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.HomelandBackpackFoldFilter, self.FoldFilter)
end

function UIHomelandBackpackTab:OnHide()
  self:DetachEvent(GameEventType.HomelandBackpackFoldFilter, self.FoldFilter)
end

function UIHomelandBackpackTab:Init(id)
  self.id = id
  local f = self.data:GetFilterById(id)
  self.txtFilter:SetText(f.name)
  self.imgIcon.sprite = self.atlas:GetSprite(self.dictFilterIcon[f.id])
end

function UIHomelandBackpackTab:FlushRed(isShow)
  if isShow then
    self.red:SetActive(true)
  else
    self.red:SetActive(false)
  end
end

function UIHomelandBackpackTab:FoldFilter(id)
  if id == self.id then
    self.imgTab.sprite = self.atlas:GetSprite("n17_pack_btn02")
  else
    self.imgTab.sprite = self.atlas:GetSprite("n17_pack_btn03")
  end
  self._isSelected = self.id == id
end

function UIHomelandBackpackTab:imgTabOnClick(go)
  if not self._isSelected then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandBackpackFoldFilter, self.id)
  end
end

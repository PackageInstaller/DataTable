_class("UIXiaoLinJiaReviewItem", UICustomWidget)
UIXiaoLinJiaReviewItem = UIXiaoLinJiaReviewItem

function UIXiaoLinJiaReviewItem:OnShow()
  self.atlas = self:RootUIOwner():GetAsset("XiaoLinJia.spriteatlas", LoadType.SpriteAtlas)
  self.txtContent = self:GetUIComponent("UILocalizationText", "txtContent")
  self.icon = self:GetUIComponent("Image", "icon")
  self.txtBG = self:GetUIComponent("Image", "txtBG")
  self.img1Obj = self:GetGameObject("img1")
  self.img2Obj = self:GetGameObject("img2")
end

function UIXiaoLinJiaReviewItem:OnHide()
end

function UIXiaoLinJiaReviewItem:Flush(speakerIdx, icon, content)
  if speakerIdx == 1 then
    self.img1Obj:SetActive(false)
    self.img2Obj:SetActive(true)
    self.txtBG.sprite = self.atlas:GetSprite("n36_xljmqd_record-01")
    self.txtContent.color = Color(1, 1, 1, 1)
  else
    self.img1Obj:SetActive(true)
    self.img2Obj:SetActive(false)
    self.txtBG.sprite = self.atlas:GetSprite("n36_xljmqd_record-02")
    self.txtContent.color = Color(0.4392156862745098, 0.7803921568627451, 0.17647058823529413, 1)
  end
  self.icon.sprite = self.atlas:GetSprite(icon)
  local content = self:_DoEscape(StringTable.Get(content))
  self.txtContent:SetText(content)
end

function UIXiaoLinJiaReviewItem:_DoEscape(strContent)
  strContent = string.gsub(strContent, "$$", "$")
  local name = GameGlobal.GetModule(RoleModule):GetName()
  if string.isnullorempty(name) then
    name = StringTable.Get("str_guide_moren_name")
  end
  strContent = string.gsub(strContent, "PlayerName", name)
  return strContent
end

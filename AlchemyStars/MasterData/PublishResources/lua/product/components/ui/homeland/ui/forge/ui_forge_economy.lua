_class("UIForgeEconomy", UICustomWidget)
UIForgeEconomy = UIForgeEconomy

function UIForgeEconomy:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.data = self.mHomeland:GetForgeData()
  self.mRole = GameGlobal.GetModule(RoleModule)
end

function UIForgeEconomy:OnShow()
  self.goIcon = self:GetGameObject("imgIcon")
  self.imgIcon = self:GetUIComponent("Image", "imgIcon")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self:AttachEvent(GameEventType.ItemCountChanged, self.Flush)
  self:Flush()
end

function UIForgeEconomy:OnHide()
  self:DetachEvent(GameEventType.ItemCountChanged, self.Flush)
end

function UIForgeEconomy:Flush()
  self.costID, _ = self.data:GetForgeAccItem()
  local count = self.mRole:GetAssetCount(self.costID)
  self.txtCount:SetText(count)
  local topCfg = Cfg.cfg_top_tips[self.costID]
  if not topCfg then
    Log.exception("cfg_top_tips中缺少配置:", self.costID)
  end
  local atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self.imgIcon.sprite = atlas:GetSprite(topCfg.Icon)
end

function UIForgeEconomy:imgIconOnClick(go)
  self:ShowDialog("UIHomeTopTips", self.costID, self.goIcon, "UIForge")
end

function UIForgeEconomy:bgOnClick(go)
  self:imgIconOnClick()
end

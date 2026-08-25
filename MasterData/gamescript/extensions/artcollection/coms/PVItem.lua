local PVItem, Super = NewViewComponent("PVItem")

function PVItem:ctor(uiNode, view, cfgId)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Item_PV_SubItemResource(uiNode)
  self.cfgId = cfgId
  if self.ui.Image_Bg then
    self:SetActive(self.ui.Image_Bg, false)
  end
end

function PVItem:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:InitLockState()
  self:AddViewComponentOnce(self.ui.UI_Collection_Item_Video, CGItem, self.cfgId)
end

function PVItem:InitLockState()
  local unlock = ArtCollectionController.Instance:IsUnlock(self.cfgId)
  local cfg = DT.CollectionHall[self.cfgId]
  local str = LT.Text(cfg.Title)
  if unlock then
    if cfg.VersionName ~= nil then
      local versionStr = tostring(cfg.VersionName)
      local matched = string.match(versionStr, "^%d+%.?%d*%.?%d*$")
      if nil ~= matched then
        if string.find(versionStr, ".", 1, true) then
          self:SetText(self.ui.Text_Version, versionStr)
        else
          local resultVersion = tonumber(versionStr)
          if nil ~= resultVersion then
            self:SetText(self.ui.Text_Version, string.format("%0.1f", resultVersion))
          end
        end
      end
    end
  else
    str = StrUtils.Fix2ConfuseText(str)
  end
  self:SetText(self.ui.Text_Name, str)
end

function PVItem:RegisterEvents()
end

return PVItem

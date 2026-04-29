_class("UIActiveTaskMissionReward", UICustomWidget)
UIActiveTaskMissionReward = UIActiveTaskMissionReward

function UIActiveTaskMissionReward:Constructor()
  self.mRole = GameGlobal.GetModule(RoleModule)
  self.colorTxtCount = Color.white
end

function UIActiveTaskMissionReward:OnShow()
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.colorTxtCount = self.txtCount.color
  self.atlas = self:GetAsset("UIHomelandBuildInfo.spriteatlas", LoadType.SpriteAtlas)
end

function UIActiveTaskMissionReward:OnHide()
end

function UIActiveTaskMissionReward:Flush(roleAsset, funcClick)
  self.roleAsset = roleAsset
  local icon = ""
  local count = 0
  if roleAsset.exp then
    icon = ""
    count = roleAsset.count
  else
    local cfg = Cfg.cfg_item[roleAsset.assetid]
    icon = cfg.Icon
    count = roleAsset.count
  end
  self.imgIcon:LoadImage(icon)
  self.txtCount:SetText(self:FormatCount(count))
  self.funcClick = funcClick
end

function UIActiveTaskMissionReward:FormatCount(count)
  if not count or count == "" then
    return ""
  end
  if 999999 < count then
    local c = math.floor(count * 1.0E-4)
    return StringTable.Get("str_homeland_backpack_n_w", c)
  elseif 99999 < count then
    local c = math.floor(count * 0.001) * 0.1
    return StringTable.Get("str_homeland_backpack_n_w", c)
  end
  return tostring(count)
end

function UIActiveTaskMissionReward:TxtCountRedIfNotEnough(cost)
  local c = self.mRole:GetAssetCount(self.roleAsset.assetid) or 0
  if cost <= c then
    self.txtCount.color = self.colorTxtCount
  else
    self.txtCount.color = Color.red
  end
end

function UIActiveTaskMissionReward:BtnOnClick(go)
  if self.funcClick then
    self.funcClick(self.roleAsset.assetid, go.transform.position)
  end
end

function UIActiveTaskMissionReward:ClearTextCount()
  self.txtCount:SetText("")
end

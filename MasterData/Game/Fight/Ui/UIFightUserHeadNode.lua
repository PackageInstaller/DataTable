local UIFightUserHeadNode = class("UIFightUserHeadNode", UIBaseNode)

function UIFightUserHeadNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIFightUserHeadNode:Init(root, resLoader)
  UIBaseNode.Init(self, root)
  self.resLoader = resLoader
end

function UIFightUserHeadNode:RefreshUserHead(avatarId)
  if avatarId == nil or avatarId == 0 then
    return
  end
  local cfg = ConfigData.portrait[avatarId]
  if cfg == nil or cfg.icon == nil then
    error("can't read portraitCfg with id:" .. tostring(avatarId))
    return
  end
  local icon = cfg.icon
  if not string.IsNullOrEmpty(icon) then
    self.ui.img_UserHead.sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
  end
end

function UIFightUserHeadNode:RefreshUserHeadFrame(avatarFrameId)
  if avatarFrameId == nil or avatarFrameId == 0 then
    return
  end
  local cfg = ConfigData.portrait_frame[avatarFrameId]
  if cfg == nil or cfg.icon == nil then
    error("can't read portrait_frameCfg with id:" .. tostring(avatarFrameId))
    return
  end
  local icon = cfg.icon
  if not string.IsNullOrEmpty(icon) then
    self.ui.img_Frame.sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
  end
end

return UIFightUserHeadNode

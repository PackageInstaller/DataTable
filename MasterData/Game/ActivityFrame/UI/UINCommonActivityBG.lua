local UINCommonActivityBG = class("UINCommonActivityBG", UIBaseNode)
local base = UIBaseNode

function UINCommonActivityBG:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCommonActivityBG:InitActivityBG(frameId, resloader)
  local cfg = ConfigData.activity_head[frameId]
  if cfg == nil then
    return
  end
  local color = Color.New(cfg.head_bar_color[1] / 255, cfg.head_bar_color[2] / 255, cfg.head_bar_color[3] / 255)
  self.ui.Line_below.color = color
  self.ui.Line_top1.color = color
  self.ui.Line_top2.color = color
  resloader:LoadABAssetAsync(PathConsts:GetActivityPath(cfg.head_pic_path), function(texture)
    if IsNull(self.transform) then
      return
    end
    if texture == nil then
      return
    end
    self.ui.titleIMG.texture = texture
  end)
end

return UINCommonActivityBG

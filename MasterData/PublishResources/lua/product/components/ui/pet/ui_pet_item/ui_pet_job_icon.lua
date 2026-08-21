_class("UIPetJobIcon", UICustomWidget)
UIPetJobIcon = UIPetJobIcon

function UIPetJobIcon:SetData(pet, type, fromMaze)
  if not pet then
    return
  end
  local prof = pet:GetProf()
  self:_SetImage(type, prof)
  if type == 2 and fromMaze then
    local root = self:GetUIComponent("RectTransform", "root")
    if root ~= nil then
      root.anchoredPosition = Vector2(0, -10)
    end
  end
end

function UIPetJobIcon:_SetImage(type, prof)
  local job2Img = {
    [1] = {
      [2001] = "epg_gqxq_icon08",
      [2002] = "epg_gqxq_icon06",
      [2003] = "epg_gqxq_icon07",
      [2004] = "epg_gqxq_icon09"
    },
    [2] = {
      [2001] = "epg_gqxq_icon03",
      [2002] = "epg_gqxq_icon01",
      [2003] = "epg_gqxq_icon02",
      [2004] = "epg_gqxq_icon04"
    }
  }
  local info = {
    atlasName = "UIPetJobIcon.spriteatlas",
    spriteName = job2Img[type][prof]
  }
  UIStyleHelper.FitStyle_Widget(info, self, "_icon")
end

function UIPetJobIcon:_SetText(prof)
end

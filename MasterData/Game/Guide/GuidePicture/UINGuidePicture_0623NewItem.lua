local UINGuidePicture_0623NewItem = class("UINGuidePicture_0623NewItem", UIBaseNode)
local UINGuidePicture_0623NewDesItem = require("Game.Guide.GuidePicture.UINGuidePicture_0623NewDesItem")

function UINGuidePicture_0623NewItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.desItemPool = UIItemPool.New(UINGuidePicture_0623NewDesItem, self.ui.obj_tex_Des)
  self.ui.obj_tex_Des:SetActive(false)
end

function UINGuidePicture_0623NewItem:InitPictureItemBase(deslist, index, title)
  self.index = index
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(title)
  if deslist == nil then
    self.desItemPool:HideAll()
    return
  end
  self.desItemPool:HideAll()
  for order, desCfg in ipairs(deslist) do
    local desItem = self.desItemPool:GetOne()
    desItem:InitGPNewDesItem(desCfg)
  end
end

function UINGuidePicture_0623NewItem:InitPictureItem(deslist, index, title, resPath, resloader)
  self:InitPictureItemBase(deslist, index, title)
  resloader:LoadABAssetAsync(resPath, function(picture)
    if IsNull(picture) then
      return
    end
    if self.index ~= index then
      return
    end
    self.ui.img_Pic.texture = picture
  end)
end

function UINGuidePicture_0623NewItem:PlayGuideVedio(vedioPath, moivePlayer)
  if moivePlayer == nil then
    return
  end
  moivePlayer:SetVideoRender(self.ui.img_Pic)
  moivePlayer:PlayVideo(vedioPath, nil, 1, true)
end

return UINGuidePicture_0623NewItem

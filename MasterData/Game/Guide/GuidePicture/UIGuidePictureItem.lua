local UIGuidePictureItem = class("UIGuidePictureItem", UIBaseNode)

function UIGuidePictureItem:OnInit()
  self.img_Pic = self.transform:FindComponent("Img_Pic", eUnityComponentID.RawImage)
end

function UIGuidePictureItem:InitPictureItem(index, resPath, resloader)
  self.index = index
  resloader:LoadABAssetAsync(resPath, function(picture)
    if IsNull(picture) then
      return
    end
    if self.index ~= index then
      return
    end
    self.img_Pic.texture = picture
  end)
end

return UIGuidePictureItem

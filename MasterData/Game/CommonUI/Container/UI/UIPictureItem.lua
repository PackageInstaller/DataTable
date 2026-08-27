local UIPictureItem = class("UIPictureItem", UIBaseNode)

function UIPictureItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.img_Pic = self.ui.advItem
  UIUtil.AddButtonListener(self.ui.button, self, self.OnClick)
  self.__OnOpenUrl = BindCallback(self, self.OnOpenUrl)
end

function UIPictureItem:InitPictureItem(index, resPath, resloader, url)
  self.url = url
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

function UIPictureItem:OnClick()
  CS.MessageCommon.ShowMessageBox(ConfigData:GetTipContent(TipContent.bannerJumpMention), ConfigData:GetTipContent(TipContent.commonConfirm), ConfigData:GetTipContent(TipContent.commonCancle), self.__OnOpenUrl, nil)
end

function UIPictureItem:OnOpenUrl()
  CS.UnityEngine.Application.OpenURL(self.url)
end

return UIPictureItem

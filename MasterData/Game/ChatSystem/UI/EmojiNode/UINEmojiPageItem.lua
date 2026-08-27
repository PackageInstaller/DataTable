local UINEmojiPageItem = class("UINEmojiPageItem", UIBaseNode)
local base = UIBaseNode

function UINEmojiPageItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_EmojiPageItem, self, self.OnClickEmojiPageItem)
end

function UINEmojiPageItem:InitEmojiPageItem(pageId, onClickEmojiPageItemCallBack, resloader, isSeleting)
  self.pageId = pageId
  self.onClickEmojiPageItemCallBack = onClickEmojiPageItemCallBack
  local pageCfg = ConfigData.new_chat_emoticon_series[pageId]
  if pageCfg == nil then
    error("show chatSystem emoji page fail, pageCfg == nil!")
    return
  end
  self.ui.img_Sprite.sprite = AtlasUtil.GetSpriteFromAtlas(UIAtlasConsts.Atlas_ChatSystem, pageCfg.series_icon, resloader)
  self.ui.obj_Selected:SetActive(isSeleting)
end

function UINEmojiPageItem:OnClickEmojiPageItem()
  if self.onClickEmojiPageItemCallBack ~= nil then
    self.onClickEmojiPageItemCallBack(self.pageId)
  end
end

return UINEmojiPageItem

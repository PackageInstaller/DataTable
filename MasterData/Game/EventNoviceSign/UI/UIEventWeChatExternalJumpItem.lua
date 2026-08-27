local base = UIBaseNode
local UIEventWeChatExternalJumpItem = class("UIEventWeChatExternalJumpItem", base)

function UIEventWeChatExternalJumpItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__onClickHrefClick = BindCallback(self, self.OnClickHrefClick)
end

function UIEventWeChatExternalJumpItem:InitUIEventWeChatExternalJumpItem(isShow, qqGroupNumerStr, jumpLinkStr, buriedPointId)
  self.gameObject:SetActive(isShow)
  self.buriedPointId = buriedPointId
  if isShow then
    self.ui.tex_qqGroupNumber.text = qqGroupNumerStr
    self.ui.tex_join.text = jumpLinkStr
    self.ui.tex_join.onHrefClick:AddListener(self.__onClickHrefClick)
  end
end

function UIEventWeChatExternalJumpItem:OnClickHrefClick(herfStr, showStr)
  PlayerClickCollectManager:BtnClickNumCollect(self.buriedPointId)
  UIUtil.OpenHerfURL(herfStr)
end

function UIEventWeChatExternalJumpItem:OnDelete()
  if self.ui ~= nil and not IsNull(self.ui.tex_join) then
    self.ui.tex_join.onHrefClick:RemoveListener(self.__onClickHrefClick)
  end
  self.__onClickHrefClick = nil
end

return UIEventWeChatExternalJumpItem

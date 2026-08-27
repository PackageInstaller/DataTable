local UINUserInfoBottomItem = class("UINUserInfoBottomItem", UIBaseNode)
local base = UIBaseNode

function UINUserInfoBottomItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._RefreshValue = BindCallback(self, self.RefreshValue)
end

function UINUserInfoBottomItem:InitUserInfoBottomItem(index, getvalueFunc, msgId, userInfoData)
  self.getvalueFunc = getvalueFunc
  self.userInfoData = userInfoData
  self.ui.tex_Tile:SetIndex(index - 1)
  self.ui.tex_Content.text = getvalueFunc(userInfoData)
  if self.msgId == nil and msgId ~= nil then
    self.msgId = msgId
    MsgCenter:AddListener(msgId, self._RefreshValue)
  elseif self.msgId ~= nil and self.msgId ~= msgId then
    MsgCenter:RemoveListener(self.msgId, self._RefreshValue)
    self.msgId = msgId
    if msgId ~= nil then
      MsgCenter:AddListener(msgId, self._RefreshValue)
    end
  end
end

function UINUserInfoBottomItem:RefreshValue()
  self.ui.tex_Content.text = self.getvalueFunc(self.userInfoData)
end

function UINUserInfoBottomItem:OnDelete()
  if self.msgId then
    MsgCenter:RemoveListener(self.msgId, self._RefreshValue)
  end
  base.OnDelete(self)
end

return UINUserInfoBottomItem

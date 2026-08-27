local base = UIBaseNode
local UINWarChessNoticeRewardTip = class("UINWarChessNoticeRewardTip", base)

function UINWarChessNoticeRewardTip:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWarChessNoticeRewardTip:RefreshWCRewardNotice(itemId, curNum, addNum, isLimitFull)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("can't get item with id:" .. tostring(itemId))
    return
  end
  local resName = itemCfg.icon
  local itemName = LanguageUtil.GetLocaleText(itemCfg.name)
  self.ui.img_Icon.sprite = CRH:GetSprite(resName)
  self.ui.tex_Name.text = itemName
  if curNum ~= nil then
    self.ui.tex_Current.gameObject:SetActive(true)
    self.ui.tex_Current.text = tostring(curNum - addNum)
  else
    self.ui.tex_Current.gameObject:SetActive(false)
  end
  self.ui.tex_Plus.text = "+" .. tostring(addNum)
  self.ui.tex_limit.gameObject:SetActive(isLimitFull)
end

return UINWarChessNoticeRewardTip

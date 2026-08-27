local UINFlappyGiftItem = class("UINFlappyGiftItem", UIBaseNode)
local base = UIBaseNode
local AwardPanelTitleTextIndex = 1

function UINFlappyGiftItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Item, self, self.__OnClick)
end

function UINFlappyGiftItem:InjectAwardData(fbConfig, showAwardDataFunc, awardIndex)
  self.awardData = fbConfig.progress_award_data[awardIndex]
  self.__showAwardDataFunc = showAwardDataFunc
  self.fbConfig = fbConfig
end

function UINFlappyGiftItem:__OnClick()
  if self.__showAwardDataFunc ~= nil then
    self.__showAwardDataFunc(self.awardData, self.fbConfig, AwardPanelTitleTextIndex, self.ui.awardPanelRoot)
  end
end

function UINFlappyGiftItem:UpdatePosAndTips(progress, percent, totalWidth)
  local pos = self.ui.rectTrans.anchoredPosition
  pos.x = totalWidth * percent / 100
  self.ui.rectTrans.anchoredPosition = pos
  self.ui.tex_Rate:SetIndex(0, tostring(percent))
  if percent <= progress // 100 then
    self.ui.obj_isPicked:SetActive(true)
  end
end

function UINFlappyGiftItem:OnDelete()
  base.OnDelete(self)
end

return UINFlappyGiftItem

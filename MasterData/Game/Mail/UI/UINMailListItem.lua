local UINMailListItem = class("UINMailListItem", UIBaseNode)
local base = UIBaseNode
local MailEnum = require("Game.Mail.MailEnum")

function UINMailListItem:OnInit()
  self.onClickCallback = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_mailItem, self, self.OnCkilck)
end

function UINMailListItem:SetCallback(onClickCallback)
  self.onClickCallback = onClickCallback
end

function UINMailListItem:InitMailItem(mailData)
  self.mailData = mailData
  self:SetSelect(mailData.isSelected)
  self.ui.tex_Tile.text = mailData:GetTitle()
  local time = mailData:GetTimeBeforeExpired()
  if 86400 < time then
    local num = math.ceil(time // 86400)
    self.ui.tex_Time:SetIndex(0, tostring(num))
  elseif time == 0 and mailData.isTreasure then
    local ymd, hm = mailData:GetTime()
    self.ui.tex_Time:SetIndex(2, ymd, hm)
  else
    self.ui.tex_Time:SetIndex(1)
  end
  local mailState = mailData:GetState()
  if mailState == MailEnum.eMailDetailType.None then
    self.ui.img_IsRead:SetIndex(0)
    self.ui.canvasGroup.alpha = 1
  else
    self.ui.img_IsRead:SetIndex(1)
    self.ui.canvasGroup.alpha = self.mailData.isSelected and 1 or 0.35
  end
  local isTreasure = mailData:GetIsTreasure()
  self.ui.img_Collect:SetActive(isTreasure)
  local isHaveAtt, attDic, isPicked = mailData:IsHaveAtt()
  self.ui.img_HasReward.gameObject:SetActive(isHaveAtt)
  if isHaveAtt then
    if isPicked then
      self.ui.img_HasReward:SetIndex(1)
    else
      self.ui.img_HasReward:SetIndex(0)
    end
  end
end

function UINMailListItem:OnCkilck(isFirstOpen)
  if self.onClickCallback ~= nil then
    self.onClickCallback(self.mailData)
  end
  self.mailData.isSelected = true
  self:SetSelect(true)
  if not isFirstOpen then
    AudioManager:PlayAudioById(1056)
  end
end

function UINMailListItem:SetSelect(bool)
  if bool then
    self.ui.img_Select:SetIndex(1)
    self.ui.tex_Tile.color = self.ui.color_balck
    self.ui.canvasGroup.alpha = 1
  else
    self.ui.img_Select:SetIndex(0)
    self.ui.tex_Tile.color = self.ui.color_white
    self.ui.canvasGroup.alpha = 0.35
  end
  local rewardColor = bool and Color.New(0, 0, 0, 0.3) or Color.New(1, 1, 1, 0.3)
  self.ui.img_HasReward.image.color = rewardColor
end

function UINMailListItem:OnDelete()
  base.OnDelete(self)
end

return UINMailListItem

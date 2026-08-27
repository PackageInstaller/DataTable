local UIHeroLevelUpSuccess = class("UIHeroLevelUpSuccess", UIBaseWindow)
local base = UIBaseWindow
local athSlots = {
  17,
  18,
  19,
  20
}
local athSlotListId = {
  [17] = 1,
  [18] = 2,
  [19] = 3,
  [20] = 4
}
local UINHeroLevelUpAttrItem = require("Game.Hero.NewUI.UpgradeStar.UINStarUpAttrItem")

function UIHeroLevelUpSuccess:OnInit()
  UIUtil.Push2BackStack(self, self.OnBtnCloseClicked)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  self.ui.attriItem:SetActive(false)
end

function UIHeroLevelUpSuccess:InitHeroLevelData(lastHeroData, heroData)
  self.ui.tex_Title:SetIndex(0)
  self.ui.uiAdapter:AdaptBgUI()
  self.ui.tex_OldLevel:SetIndex(0, tostring(lastHeroData.level))
  self.ui.tex_NewLevel:SetIndex(0, tostring(heroData.level))
  local changeList = heroData:GetDifferAttrWhenRankUp(nil, heroData.level, lastHeroData.rank, lastHeroData.level)
  if #changeList < 0 then
    self.ui.attriNode.gameObject:SetActive(false)
  else
    self.ui.attriNode.gameObject:SetActive(true)
    table.sort(changeList, function(a, b)
      if a.property == b.property then
        return a.attrId < b.attrId
      else
        return a.property < b.property
      end
    end)
    for index, data in ipairs(changeList) do
      local item = UINHeroLevelUpAttrItem.New()
      local go = self.ui.attriItem:Instantiate()
      go:SetActive(true)
      item:Init(go)
      item:InitAttrItem(data.oldAttr, data.newAttr, data.attrId)
    end
  end
  AudioManager:PlayAudioById(1023)
  self:__DisplayAthSlotInfo(lastHeroData, heroData)
end

function UIHeroLevelUpSuccess:FriendShipLevelUp(lastLevel, newLevel)
  AudioManager:PlayAudioById(1074)
  self.ui.tex_Title:SetIndex(1)
  self.ui.uiAdapter:AdaptBgUI()
  self.ui.tex_OldLevel:SetIndex(0, tostring(lastLevel))
  self.ui.tex_NewLevel:SetIndex(0, tostring(newLevel))
  self.ui.attriNode.gameObject:SetActive(false)
end

function UIHeroLevelUpSuccess:AthAffixLevelUp(fromLv, toLv, fromValue, toValue, attrId)
  self.ui.tex_Title:SetIndex(2)
  self.ui.uiAdapter:AdaptBgUI()
  self.ui.tex_OldLevel:SetIndex(0, tostring(fromLv))
  self.ui.tex_NewLevel:SetIndex(0, tostring(toLv))
  self.ui.attriNode.gameObject:SetActive(true)
  local item = UINHeroLevelUpAttrItem.New()
  local go = self.ui.attriItem:Instantiate()
  go:SetActive(true)
  item:Init(go)
  item:InitAttrItem(fromValue, toValue, attrId)
end

function UIHeroLevelUpSuccess:__DisplayAthSlotInfo(lastHeroData, heroData)
  local oldSlotList = lastHeroData.athslotList
  local slotList = heroData:GetAthSlotList()
  for _, id in ipairs(athSlots) do
    if oldSlotList[athSlotListId[id]] ~= slotList[athSlotListId[id]] then
      local item = UINHeroLevelUpAttrItem.New()
      local go = self.ui.attriItem:Instantiate()
      go:SetActive(true)
      item:Init(go)
      item:InitAttrItem(id, lastHeroData.athslotList[athSlotListId[id]], athSlotListId[id])
    end
  end
end

function UIHeroLevelUpSuccess:SetLevelUpBackClickAction(clickAction)
  self.__clickAction = clickAction
end

function UIHeroLevelUpSuccess:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIHeroLevelUpSuccess:OnBtnCloseClicked()
  if self.__clickAction ~= nil then
    local bindfunc = self.__clickAction
    self.__clickAction = nil
    bindfunc()
  end
  self:Delete()
end

function UIHeroLevelUpSuccess:OnDelete()
  base.OnDelete(self)
end

return UIHeroLevelUpSuccess

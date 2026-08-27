local UINSpecWeaponLockCondItem = class("UINSpecWeaponLockCondItem", UIBaseNode)
local base = UIBaseNode
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local titleMapping = {
  [CheckerTypeId.HeroLevel] = 0,
  [CheckerTypeId.MinHeroStar] = 1,
  [CheckerTypeId.FrienshipLevel] = 2
}

function UINSpecWeaponLockCondItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._starList = {}
  table.insert(self._starList, self.ui.star)
end

function UINSpecWeaponLockCondItem:InitLockCond(condId, condPara1, condPara2)
  local index = titleMapping[condId]
  if index == nil then
    if isGameDev then
      error("condition title nil " .. tostring(condId))
    end
    return
  end
  self.ui.tex_Title:SetIndex(index)
  local condValMapping = {
    [CheckerTypeId.HeroLevel] = self.__SetLv,
    [CheckerTypeId.MinHeroStar] = self.__SetStar,
    [CheckerTypeId.FrienshipLevel] = self.__SetLv
  }
  local func = condValMapping[condId]
  if func == nil then
    if isGameDev then
      error("condition func nil " .. tostring(condId))
    end
    return
  end
  func(self, condPara1, condPara2)
end

function UINSpecWeaponLockCondItem:SetLockCondColor(color)
  self.ui.img_root.color = color
end

function UINSpecWeaponLockCondItem:__SetStar(condPara1, condPara2)
  self.ui.text_Level.gameObject:SetActive(false)
  self.ui.starsGroup:SetActive(true)
  for i, v in ipairs(self._starList) do
    v:SetActive(false)
  end
  local count = condPara2 // 2
  local hasHalf = condPara2 % 2
  for i, v in ipairs(self._starList) do
    if i <= count then
      v:SetActive(true)
    else
      v:SetActive(false)
    end
  end
  for i = #self._starList + 1, count do
    local star = self.ui.star:Instantiate(self.ui.star.transform.parent)
    star:SetActive(true)
    table.insert(self._starList, star)
  end
  self.ui.half_Star:SetActive(0 < hasHalf)
  self.ui.half_Star.transform:SetAsLastSibling()
end

function UINSpecWeaponLockCondItem:__SetLv(condPara1, condPara2)
  self.ui.starsGroup:SetActive(false)
  self.ui.text_Level.gameObject:SetActive(true)
  self.ui.text_Level.text = "LV." .. tostring(condPara2)
end

return UINSpecWeaponLockCondItem

local base = require("Game.CommonUI.FloatWin.UINFloatUINode")
local UINChristmas22TechLv = class("UINChristmas22TechLv", base)

function UINChristmas22TechLv:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_icon, self, self.OnClickItemIntro)
  UIUtil.AddButtonListener(self.ui.btn_Clear, self, self.OnClickLv)
  UIUtil.AddButtonListener(self.ui.btn_lock, self, self.OnClickLv)
end

function UINChristmas22TechLv:SetChristmas22LogicDesType(desType)
  self._desType = desType
end

function UINChristmas22TechLv:InitChristmas22TechLv(techData, callback)
  self._techData = techData
  self._callback = callback
  self.ui.tex_BuffName.text = self._techData:GetAWTechName()
  self:RefreshChristmas22TechLv()
end

function UINChristmas22TechLv:RefreshChristmas22TechLv()
  self._costId = nil
  self._costNum = nil
  self:__RefreshDes()
  self.ui.tex_lv:SetIndex(0, tostring(self._techData:GetCurLevel()), tostring(self._techData:GetMaxLevel()))
  if self._techData:IsMaxLvel() then
    self.ui.cost:SetActive(false)
    self.ui.btn_Clear.gameObject:SetActive(false)
    self.ui.lock:SetActive(false)
    return
  end
  if not self._techData:GetIsUnlock() then
    self.ui.cost:SetActive(false)
    self.ui.btn_Clear.gameObject:SetActive(false)
    self.ui.lock:SetActive(true)
    local condition, para1, para2 = self._techData:GetAWTechUnlockParam(1)
    self.ui.tex_Lock.text = CheckCondition.GetUnlockInfoLua(condition, para1, para2)
    return
  end
  local condition, para1, para2 = self._techData:GetAWTechUnlockParam(self._techData:GetCurLevel() + 1)
  local isUnlock = CheckCondition.CheckLua(condition, para1, para2)
  if not isUnlock then
    self.ui.cost:SetActive(false)
    self.ui.btn_Clear.gameObject:SetActive(false)
    self.ui.lock:SetActive(true)
    self.ui.tex_Lock.text = CheckCondition.GetUnlockInfoLua(condition, para1, para2)
    return
  end
  self.ui.lock:SetActive(false)
  self.ui.cost:SetActive(true)
  self.ui.btn_Clear.gameObject:SetActive(not self._techData:IsMaxLvel())
  self.ui.tex_level:SetIndex(0 < self._techData:GetCurLevel() and 1 or 0)
  local costDic = self._techData:GetLevelCost(self._techData:GetCurLevel() + 1)
  for k, v in pairs(costDic) do
    self._costId = k
    self._costNum = v
    break
  end
  if self._costId ~= nil then
    local hasCount = PlayerDataCenter:GetItemCount(self._costId)
    self.ui.icon.sprite = CRH:GetSpriteByItemId(self._costId, true)
    self.ui.tex_Cost.text = tostring(self._costNum)
    self.ui.tex_Cost.color = hasCount >= self._costNum and Color.white or Color.red
  end
end

function UINChristmas22TechLv:HideChristmas22TechBtnState()
  self.ui.lock:SetActive(false)
  self.ui.cost:SetActive(false)
  self.ui.btn_Clear.gameObject:SetActive(false)
end

function UINChristmas22TechLv:__RefreshDes()
  self.ui.tex_Des.text = self._techData:GetTechDescription(nil, self._desType)
end

function UINChristmas22TechLv:OnClickLv()
  if self._callback ~= nil then
    self._callback(self._techData)
  end
end

function UINChristmas22TechLv:OnClickItemIntro()
  if self._costId == nil then
    return
  end
  local itemCfg = ConfigData.item[self._costId]
  if itemCfg == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win ~= nil then
      win:InitCommonItemDetail(itemCfg)
    end
  end)
end

return UINChristmas22TechLv

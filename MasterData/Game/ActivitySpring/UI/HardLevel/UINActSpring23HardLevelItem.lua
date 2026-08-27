local UINActSpring23HardLevelItem = class("UINActSpring23HardLevelItem", UIBaseNode)
local base = UINActSpring23HardLevelItem

function UINActSpring23HardLevelItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.item, self, self.OnClickChallenge)
end

function UINActSpring23HardLevelItem:InitSpring23ChallengeItem(springData, dungeonId, index, callback)
  self._springData = springData
  self._dungeonCfg = ConfigData.battle_dungeon[dungeonId]
  self._callback = callback
  if self._dungeonCfg == nil then
    error("Cant get battle_dungeon cfg, dungeonId = " .. tostring(dungeonId))
    return
  end
  self.ui.tex_QuestName.text = LanguageUtil.GetLocaleText(self._dungeonCfg.name)
  self.ui.tex_LockDes.text = CheckCondition.GetUnlockInfoLua(self._dungeonCfg.pre_condition, self._dungeonCfg.pre_para1, self._dungeonCfg.pre_para2)
  self.ui.tex_Num.text = tostring(index)
  self:__Refresh()
end

function UINActSpring23HardLevelItem:__Refresh()
  local isUnlock = CheckCondition.CheckLua(self._dungeonCfg.pre_condition, self._dungeonCfg.pre_para1, self._dungeonCfg.pre_para2)
  if not isUnlock then
    self.ui.text_Time:SetIndex(1)
    self.ui.obj_Lock:SetActive(true)
    return
  end
  local finishiTime = self._springData:GetSpringChallengeRecord(self._dungeonCfg.id)
  self.ui.obj_Lock:SetActive(false)
  if (finishiTime or 0) == 0 then
    self.ui.text_Time:SetIndex(1)
  elseif finishiTime >= CommonUtil.UInt32Max then
    self.ui.text_Time:SetIndex(2)
  else
    finishiTime = finishiTime / BattleUtil.LogicFrameCount
    local min = math.floor(finishiTime / 60)
    local sec = finishiTime % 60
    self.ui.text_Time:SetIndex(0, string.format("%02d", min), string.format("%.03f", sec))
  end
end

function UINActSpring23HardLevelItem:GetSpringChallengeDungeonId()
  return self._dungeonCfg.id
end

function UINActSpring23HardLevelItem:OnClickChallenge()
  local unlock = CheckCondition.CheckLua(self._dungeonCfg.pre_condition, self._dungeonCfg.pre_para1, self._dungeonCfg.pre_para2)
  if unlock and self._callback ~= nil then
    self._callback(self._dungeonCfg.id)
  end
end

return UINActSpring23HardLevelItem

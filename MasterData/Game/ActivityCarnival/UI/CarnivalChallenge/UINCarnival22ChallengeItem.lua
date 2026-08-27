local UINCarnival22ChallengeItem = class("UINCarnival22ChallengeItem", UIBaseNode)
local base = UIBaseNode
local BattleUtil = require("Game.Battle.BattleUtil")

function UINCarnival22ChallengeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.challengeItem, self, self.OnClickSelect)
end

function UINCarnival22ChallengeItem:InitCarnivalChallegeItem(carnivalData, dungeonId, clickCallback)
  self._carnivalData = carnivalData
  self._dungeonCfg = ConfigData.battle_dungeon[dungeonId]
  self._clickCallback = clickCallback
  self.ui.selected:SetActive(false)
  self.ui.tex_CNDifficulty.text = LanguageUtil.GetLocaleText(self._dungeonCfg.name)
  self.ui.tex_LockPre.text = CheckCondition.GetUnlockInfoLua(self._dungeonCfg.pre_condition, self._dungeonCfg.pre_para1, self._dungeonCfg.pre_para2)
  self:UpdateCarnivalChallenge()
end

function UINCarnival22ChallengeItem:SetCarnivalChallengeBg(texture)
  self.ui.bottom.texture = texture
end

function UINCarnival22ChallengeItem:UpdateCarnivalChallenge()
  local isUnlock = CheckCondition.CheckLua(self._dungeonCfg.pre_condition, self._dungeonCfg.pre_para1, self._dungeonCfg.pre_para2)
  if not isUnlock then
    self.ui.time:SetActive(false)
    self.ui.lock:SetActive(true)
    return
  end
  local finishiTime = self._carnivalData:GetCarnivalChallengeRecord(self._dungeonCfg.id)
  self.ui.time:SetActive(true)
  self.ui.lock:SetActive(false)
  if (finishiTime or 0) == 0 then
    self.ui.img_ClearTimeBg.color = self.ui.color_gray
    self.ui.tex_TimeLeft:SetIndex(1)
  elseif finishiTime == 4294967295 then
    self.ui.img_ClearTimeBg.color = self.ui.color_gray
    self.ui.tex_TimeLeft:SetIndex(2)
  else
    finishiTime = finishiTime / BattleUtil.LogicFrameCount
    self.ui.img_ClearTimeBg.color = self.ui.color_highlight
    local min = math.floor(finishiTime / 60)
    local sec = finishiTime % 60
    self.ui.tex_TimeLeft:SetIndex(0, string.format("%02d", min), string.format("%.03f", sec))
  end
end

function UINCarnival22ChallengeItem:SetCarnivalChallengeSelect(dungeonId)
  self.ui.selected:SetActive(dungeonId == self._dungeonCfg.id)
end

function UINCarnival22ChallengeItem:OnClickSelect()
  local unlock = CheckCondition.CheckLua(self._dungeonCfg.pre_condition, self._dungeonCfg.pre_para1, self._dungeonCfg.pre_para2)
  if unlock and self._clickCallback ~= nil then
    self._clickCallback(self._dungeonCfg.id)
  end
end

return UINCarnival22ChallengeItem

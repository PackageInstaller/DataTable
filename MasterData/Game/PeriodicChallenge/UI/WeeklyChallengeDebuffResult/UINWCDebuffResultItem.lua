local UINWCDebuffResultItem = class("UINWCDebuffResultItem", UIBaseNode)
local base = UIBaseNode
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UINWCDebuffResultItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.btn_debuffResultItem.onPressDown:AddListener(BindCallback(self, self.__OnPressDown))
  self.ui.btn_debuffResultItem.onPressUp:AddListener(BindCallback(self, self.__OnPressUp))
end

function UINWCDebuffResultItem:InitResultItem(resultItemData)
  local scoreId = resultItemData.id
  local cfg = ConfigData.weekly_challenge_score[scoreId]
  if cfg == nil then
    error("weekly_challenge_score cfg is nill id:" .. tostring(scoreId))
    return
  end
  self.ui.tex_title.text = LanguageUtil.GetLocaleText(cfg.title)
  self.ui.tex_point.text = tostring(resultItemData.score)
  if cfg.check_type == 2 or cfg.check_type == 3 then
    self.ui.tex_Count.gameObject:SetActive(false)
    self.resultItemDescribe = string.format(LanguageUtil.GetLocaleText(cfg.intro), tostring(cfg.check_value))
  elseif cfg.id == 18 then
    self.ui.tex_Count.gameObject:SetActive(true)
    self.ui.tex_Count.text = GetPreciseDecimalStr(resultItemData.param / 100, 0) .. "%"
    local bossMonsterName
    if ExplorationManager.epCtrl ~= nil then
      local bossRoomData = ExplorationManager.epCtrl:GetCurrentRoomData()
      if bossRoomData ~= nil and bossRoomData.mode == 5 then
        for _, dynMonster in pairs(bossRoomData.monsterList) do
          if 0 < dynMonster:GetBossBloodNum() then
            bossMonsterName = dynMonster:GetName()
            break
          end
        end
      end
    end
    if bossMonsterName ~= nil then
      self.resultItemDescribe = string.format(LanguageUtil.GetLocaleText(cfg.intro), tostring(bossMonsterName))
    else
      warn("can't get boss name")
      self.resultItemDescribe = string.format(LanguageUtil.GetLocaleText(cfg.intro), "BOSS")
    end
  elseif cfg.id == 19 then
    local time = math.floor(resultItemData.param / 15)
    local timeStr = tostring(time)
    self.ui.tex_Count.gameObject:SetActive(true)
    self.ui.tex_Count.text = tostring(timeStr)
    self.resultItemDescribe = string.format(LanguageUtil.GetLocaleText(cfg.intro), timeStr)
  else
    self.ui.tex_Count.gameObject:SetActive(true)
    self.ui.tex_Count.text = resultItemData.score // cfg.unit_score
    self.resultItemDescribe = LanguageUtil.GetLocaleText(cfg.intro)
  end
end

function UINWCDebuffResultItem:InitWinChallengeScoreResultItem(resultItemData)
  local scoreId = resultItemData.id
  local cfg = ConfigData.activity_winter_challenge_score[scoreId]
  if cfg == nil then
    error("Cant get activity_winter_challenge_score, scoreId:" .. tostring(scoreId))
    return
  end
  self.ui.tex_title.text = LanguageUtil.GetLocaleText(cfg.title)
  self.ui.tex_point.text = tostring(resultItemData.score)
  self.ui.tex_Count.gameObject:SetActive(true)
  if cfg.id == 2 then
    self.ui.tex_Count.text = GetPreciseDecimalStr(resultItemData.param / 100, 0) .. "%"
    self.resultItemDescribe = LanguageUtil.GetLocaleText(cfg.intro)
  elseif cfg.id == 3 then
    local time = BattleUtil.FrameToTime(resultItemData.param)
    local timeStr = tostring(time)
    self.ui.tex_Count.text = tostring(timeStr)
    self.resultItemDescribe = string.format(LanguageUtil.GetLocaleText(cfg.intro), timeStr)
  else
    self.ui.tex_Count.text = resultItemData.score // cfg.unit_score
    self.resultItemDescribe = LanguageUtil.GetLocaleText(cfg.intro)
  end
end

function UINWCDebuffResultItem:InitWarchessSeasonResultItem(cfg, resultItemData)
  self.ui.tex_title.text = LanguageUtil.GetLocaleText(cfg.title)
  local value = resultItemData ~= nil and resultItemData.value or 0
  local count = resultItemData ~= nil and resultItemData.count or 0
  self.ui.tex_point.text = tostring(value)
  self.resultItemDescribe = LanguageUtil.GetLocaleText(cfg.intro)
  if cfg.show_type == 2 then
    self.ui.tex_Count.text = BattleUtil.FrameToTimeString(count, true)
  elseif cfg.show_type == 1 then
    self.ui.tex_Count.text = tostring(count / 10) .. "%"
  else
    self.ui.tex_Count.text = tostring(count)
  end
end

function UINWCDebuffResultItem:__OnPressDown()
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(self.ui.tex_title.text, self.resultItemDescribe)
  win:FloatTo(self.transform, HAType.autoCenter, VAType.up)
end

function UINWCDebuffResultItem:__OnPressUp()
  UIManager:HideWindow(UIWindowTypeID.FloatingFrame)
end

function UINWCDebuffResultItem:OnDelete()
  base.OnDelete(self)
end

return UINWCDebuffResultItem

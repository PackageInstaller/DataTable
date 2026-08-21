_class("UISeasonMazeBossAtkTip", UIController)
UISeasonMazeBossAtkTip = UISeasonMazeBossAtkTip

function UISeasonMazeBossAtkTip:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeBossAtkTip:OnShow(uiParams)
  self:InitWidget()
  local levelId = uiParams[1]
  local duration = uiParams[2]
  local isTheLast = uiParams[3]
  local monsterIDs = UICommonHelper:GetInstance():GetOptimalEnemys(levelId)
  local monsterID = monsterIDs[1]
  local cfg = Cfg.cfg_monster[monsterID]
  local cfgClass = Cfg.cfg_monster_class[cfg.ClassID]
  local name = StringTable.Get(cfgClass.Name)
  self.bossName:SetText(name)
  self.bossName1:SetText(name)
  self.bossName2:SetText(name)
  self.bossName3:SetText(name)
  self.bossName4:SetText(name)
  local title = "str_season_maze_normal_boss_title"
  if isTheLast then
    title = "str_season_maze_last_boss_title"
  end
  self.title:SetText(StringTable.Get(title))
  if duration then
    self:StartTask(function(TT)
      YIELD(TT, duration)
      if self.view then
        self:CloseDialog()
      end
    end)
  end
end

function UISeasonMazeBossAtkTip:InitWidget()
  self.bossName = self:GetUIComponent("UILocalizationText", "BossName")
  self.bossName1 = self:GetUIComponent("UILocalizationText", "BossName1")
  self.bossName2 = self:GetUIComponent("UILocalizationText", "BossName2")
  self.bossName3 = self:GetUIComponent("UILocalizationText", "BossName3")
  self.bossName4 = self:GetUIComponent("UILocalizationText", "BossName4")
  self.title = self:GetUIComponent("UILocalizationText", "title")
end

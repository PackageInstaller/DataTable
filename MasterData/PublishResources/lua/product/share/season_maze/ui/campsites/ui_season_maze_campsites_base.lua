_class("UISeasonMaze_Campsites_Base", UIController)
UISeasonMaze_Campsites_Base = UISeasonMaze_Campsites_Base

function UISeasonMaze_Campsites_Base:OnShow(uiParams)
  self._seasonMazeObj = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj()
  self._com = self._seasonMazeObj:GetMazeComponent()
  self._comCfgID = self._com:GetComponentCfgId()
  self._cfg_global = Cfg.cfg_component_season_maze_global[self._comCfgID]
  self._uiSeasonMazeModule = GameGlobal.GetUIModule(SeasonMazeModule)
  self:OnShowUI(uiParams)
end

function UISeasonMaze_Campsites_Base:OnShowUI(uiParams)
end

function UISeasonMaze_Campsites_Base:GetSeasonMazeCfg(hardLevel)
  local cfgs = Cfg.cfg_component_season_maze({
    ComponentID = self._comCfgID
  })
  if cfgs and table.count(cfgs) > 0 then
    for _, v in pairs(cfgs) do
      if v.Hard == hardLevel then
        return v
      end
    end
  end
  return nil
end

function UISeasonMaze_Campsites_Base:CalcResetCost(resetCount, cfgParam)
  local x = resetCount or 0
  local cfg_reset = cfgParam
  local a = cfg_reset[1]
  local b = cfg_reset[2]
  local c = cfg_reset[3]
  if not (a and b) or not c then
    Log.error("###[UISeasonMaze_Campsites_Base] self._cfg_global.PetParam is nil !")
  end
  local baseCost = a * x ^ 2 + b * x + c
  local shopParam = 1
  local comInfo = self._com:GetComponentInfo()
  local priceAttr = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Goods_Price_Percent)
  local currentHard = comInfo.hard
  local seasonMazeCfg = self:GetSeasonMazeCfg(currentHard)
  if seasonMazeCfg then
    local bossInfos = comInfo.boss_info
    local bossCount = table.count(bossInfos)
    for i = 0, bossCount - 1 do
      local bossInfo = bossInfos[i]
      if bossInfo.do_cnt ~= -1 then
        shopParam = (seasonMazeCfg.ShopIndex[i + 1] + priceAttr) / 1000
        break
      end
    end
  end
  local cost = baseCost * shopParam
  cost = lmathext.round(cost)
  return cost
end

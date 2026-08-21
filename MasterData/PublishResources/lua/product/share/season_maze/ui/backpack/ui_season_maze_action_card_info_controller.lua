_class("UISeasonMazeActionCardInfoController", UIController)
UISeasonMazeActionCardInfoController = UISeasonMazeActionCardInfoController

function UISeasonMazeActionCardInfoController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeActionCardInfoController:OnShow(uiParams)
  self:InitWidget()
  self.cfgid = uiParams[1]
  self._cfg = Cfg.cfg_component_season_maze_hand[self.cfgid]
  self.item = self.relicPool:SpawnObject("UISeasonMazeCardItem")
  self.item:SetData(1, self.cfgid, function(cfg)
  end, function(cfg)
  end)
  self:InitUI()
end

function UISeasonMazeActionCardInfoController:InitWidget()
  self.colorDown = self:GetUIComponent("Image", "colorDown")
  self.desc = self:GetUIComponent("UILocalizationText", "desc")
  self.relicPool = self:GetUIComponent("UISelectObjectPath", "relicPool")
  self.customRoot = self:GetGameObject("CustomRoot")
  self.customSuitTitile = self:GetUIComponent("UILocalizationText", "CustomSuitTitile")
  self.customSuitTips = self:GetUIComponent("UILocalizationText", "CustomSuitTips")
  self.lessUseCountRoot = self:GetUIComponent("Image", "LessUseCountRoot")
  self.lessUseCountText = self:GetUIComponent("UILocalizationText", "LessUseCountText")
  self.desc2 = self:GetUIComponent("UILocalizationText", "desc2")
  self.desc3 = self:GetUIComponent("UILocalizationText", "desc3")
  self.icon2 = self:GetUIComponent("Image", "Icon2")
  self.t1 = self:GetGameObject("t1")
  self.t2 = self:GetGameObject("t2")
  self.t3 = self:GetGameObject("t3")
  self._atlas = self:GetAsset("SeasonMaze.spriteatlas", LoadType.SpriteAtlas)
end

function UISeasonMazeActionCardInfoController:InitUI()
  if self._cfg.BagCardDes1 == nil then
    self.t1:SetActive(false)
  else
    self.desc:SetText(StringTable.Get(self._cfg.BagCardDes1))
  end
  if self._cfg.BagCardDes2 == nil then
    self.t2:SetActive(false)
  else
    self.desc2:SetText(StringTable.Get(self._cfg.BagCardDes2))
    if self._cfg.EffectIDs ~= nil then
      local id = self._cfg.EffectIDs[1]
      if id then
        local effectCfg = Cfg.cfg_component_season_maze_effect[id]
        if effectCfg and effectCfg.EffectList then
          local effectList = effectCfg.EffectList[1]
          local resType = effectList[1]
          local attType = effectList[2]
          if resType == SeasonMazeEffectType.SMET_Pro then
            local cfg = Cfg.cfg_season_maze_attribute[attType]
            if cfg then
              local spriteName = cfg.CardIcon
              self.icon2.sprite = self._atlas:GetSprite(spriteName)
            end
          else
            local spriteName = self._cfg.CardIcon
            self.icon2.sprite = self._atlas:GetSprite(spriteName)
          end
        end
      end
    end
  end
  if self._cfg.BagCardDes3 == nil then
    self.t3:SetActive(false)
  else
    self.desc3:SetText(StringTable.Get(self._cfg.BagCardDes3))
  end
end

function UISeasonMazeActionCardInfoController:Bg1OnClick()
  self:CloseDialog()
end

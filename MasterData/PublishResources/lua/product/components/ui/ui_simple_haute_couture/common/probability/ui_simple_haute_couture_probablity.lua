_class("UISimpleHauteCoutureProbability", UIController)
UISimpleHauteCoutureProbability = UISimpleHauteCoutureProbability

function UISimpleHauteCoutureProbability:Constructor()
end

function UISimpleHauteCoutureProbability:OnShow(uiParams)
  self.altas = self:GetAsset("UISimpleHauteCoutureFei.spriteatlas", LoadType.SpriteAtlas)
  self._campaign = uiParams[1]
  self._randomLotteryComponent = self._campaign:GetComponent(ECampaignPetSkinComponentID.RANDOMLOTTERY)
  self._cfgProbablity = self._randomLotteryComponent:GetProbablityCfg()
  self._cfgMain = self._randomLotteryComponent:GetCfgMain()
  self:_GetComponents()
  self:_InitComponents()
end

function UISimpleHauteCoutureProbability:_GetComponents()
  self._bigList = self:GetUIComponent("UISelectObjectPath", "BigList")
  self._smallList = self:GetUIComponent("UISelectObjectPath", "SmallList")
  self._info1 = self:GetUIComponent("UILocalizationText", "info1")
  self._title0 = self:GetUIComponent("UILocalizationText", "title0")
  self._title1 = self:GetUIComponent("UILocalizationText", "title1")
  self._title2 = self:GetUIComponent("UILocalizationText", "title2")
  local itemInfo = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self._selectInfo = itemInfo:SpawnObject("UISelectInfo")
end

function UISimpleHauteCoutureProbability:_InitComponents()
  self._info1:SetText(StringTable.Get(self._cfgMain.ProbablityTxt))
  self._title0:SetText(StringTable.Get(self._cfgMain.ProbablityTitle0))
  self._title1:SetText(StringTable.Get(self._cfgMain.ProbablityTitle1))
  self._title2:SetText(StringTable.Get(self._cfgMain.ProbablityTitle2))
  if not self._cfgProbablity then
    Log.exception("cfg_junior_skin_draw_probablity 请配置概率！")
    return
  end
  table.sort(self._cfgProbablity, function(a, b)
    return a.Sort < b.Sort
  end)
  local bigCfgs = {}
  local smallCfgs = {}
  for _, cfg in pairs(self._cfgProbablity) do
    if cfg.IsBigRewards then
      table.insert(bigCfgs, cfg)
    else
      table.insert(smallCfgs, cfg)
    end
  end
  local bigItems = self._bigList:SpawnObjects("UISimpleHauteCoutureProbabiltyItem", table.count(bigCfgs))
  local smallItems = self._smallList:SpawnObjects("UISimpleHauteCoutureProbabiltyItem", table.count(smallCfgs))
  local index = 1
  for _, item in pairs(bigItems) do
    item:SetData(bigCfgs[index], true, function(id, pos)
      self:ItemClick(id, pos)
    end)
    index = index + 1
  end
  index = 1
  for _, item in pairs(smallItems) do
    item:SetData(smallCfgs[index], false, function(id, pos)
      self:ItemClick(id, pos)
    end)
    index = index + 1
  end
end

function UISimpleHauteCoutureProbability:MaskOnClick()
  self:CloseDialog()
end

function UISimpleHauteCoutureProbability:CloseOnClick()
  self:CloseDialog()
end

function UISimpleHauteCoutureProbability:ItemClick(id, pos)
  if self._selectInfo then
    self._selectInfo:SetData(id, pos)
  end
end

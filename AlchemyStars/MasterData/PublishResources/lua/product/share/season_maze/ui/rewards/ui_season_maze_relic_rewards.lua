_class("UISeasonMazeRelicRewards", UIController)
UISeasonMazeRelicRewards = UISeasonMazeRelicRewards

function UISeasonMazeRelicRewards:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeRelicRewards:OnShow(uiParams)
  self._relicIDList = {}
  if uiParams then
    self._relicIDList = uiParams[1]
    self._callBack = uiParams[2]
  end
  self:InitWidget()
  self:InitUI()
end

function UISeasonMazeRelicRewards:OnHide()
end

function UISeasonMazeRelicRewards:InitWidget()
  self.cardPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self.DetailPopRoot = self:GetGameObject("DetailPop")
  self.DetailPopRoot:SetActive(false)
  self.PopTitleText = self:GetUIComponent("UILocalizationText", "PopTitleText")
  self.PoDetailTex = self:GetUIComponent("UILocalizedTMP", "PoDetailTex")
  self.SuitDetail = self:GetGameObject("SuitDetail")
  self.EffectDetail = self:GetGameObject("EffectDetail")
  self.EffectDetail2 = self:GetGameObject("EffectDetail2")
  self.PopTitle2Text = self:GetUIComponent("UILocalizationText", "PopTitle2Text")
  self.PoDetai2lTex = self:GetUIComponent("UILocalizedTMP", "PoDetai2lTex")
  self.PopTitle3Text = self:GetUIComponent("UILocalizationText", "PopTitle3Text")
  self.PoDetai3lTex = self:GetUIComponent("UILocalizedTMP", "PoDetai3lTex")
  self.DetailTipsRootRectTf = self:GetUIComponent("RectTransform", "DetailTipsRoot")
end

function UISeasonMazeRelicRewards:InitUI()
  self.totalCount = 4
  self.seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self.uiSeasonMazeModule = self.seasonMazeModule:UIModule()
  self._seasonMazeObj = self.seasonMazeModule:CurSeasonObj()
  self._component = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._componentInfo = self._component:GetComponentInfo()
  self._comCfgID = self._component:GetComponentCfgId()
  self._cfg_global = Cfg.cfg_component_season_maze_global[self._comCfgID]
  local ranRelic = self._relicIDList
  local relics = {}
  self.mazeRelics = self.uiSeasonMazeModule:GetSeasonMazeRelics()
  for key, value in pairs(self.mazeRelics) do
    relics[#relics + 1] = key
  end
  self._bagItemInfo = self:Relic_SortItems(relics)
  self._randItemInfo = self:Relic_SortItems(ranRelic)
  self.defaultIndex = 1
  self.totalCount = #ranRelic
  self._relicArea = UIWidgetHelper.SpawnObjects(self, "Content", "UIseasonMazeRewardRelicItem", self.totalCount)
  for i = 1, #self._relicArea do
    local item = self._relicArea[i]
    if item then
      item:SetData(self._randItemInfo[i], function(selectIndex)
        self.defaultIndex = selectIndex
        for j = 1, #self._relicArea do
          local otherItem = self._relicArea[j]
          if j ~= selectIndex then
            otherItem:UnSelectItem()
          end
        end
      end, i, function(index)
        self:RefreshDetilUI(index)
      end)
      if i == 1 then
        item:SelectItem()
      end
    end
  end
end

function UISeasonMazeRelicRewards:Relic_SortItems(items)
  return items
end

function UISeasonMazeRelicRewards:ClosePopBtnOnClick(go)
  self.DetailPopRoot:SetActive(false)
end

function UISeasonMazeRelicRewards:RefreshDetilUI(index)
  local pos = self.DetailTipsRootRectTf.anchoredPosition
  pos.x = 258
  self.DetailTipsRootRectTf.anchoredPosition = pos
  self.DetailPopRoot:SetActive(true)
  local curitem = self._relicArea[index]
  local itemCfgid = self._randItemInfo[index]
  local itemcfg = Cfg.cfg_item_relic[itemCfgid]
  if itemcfg == nil then
    Log.fatal("[error] maze --> _cfg == nil ! id --> " .. itemCfgid)
    self.DetailPopRoot:SetActive(false)
    return
  end
  if itemcfg.DetailPopTips ~= nil then
    self:RefreshEffect(itemcfg.DetailPopTips)
  else
    self.EffectDetail:SetActive(false)
    self.EffectDetail2:SetActive(false)
  end
  if itemcfg.SuiteID == nil or itemcfg.SuiteID == 0 then
    self.SuitDetail:SetActive(false)
  else
    self.SuitDetail:SetActive(true)
    self:RefreshSuit(itemcfg.SuiteID)
  end
end

function UISeasonMazeRelicRewards:RefreshEffect(effects)
  if #effects == 1 then
    local hrefID = effects[1]
    local cfgv = Cfg.cfg_season_maze_relic_href_desc[hrefID]
    if not cfgv then
      return
    end
    local name = StringTable.Get(cfgv.Name)
    local desc = StringTable.Get(cfgv.Desc)
    self.EffectDetail:SetActive(true)
    self.EffectDetail2:SetActive(false)
    self.PopTitle2Text:SetText(name)
    self.PoDetai2lTex:SetText(desc)
  elseif #effects == 2 then
    local hrefID1 = effects[1]
    local cfgv = Cfg.cfg_season_maze_relic_href_desc[hrefID1]
    if not cfgv then
      return
    end
    local name1 = StringTable.Get(cfgv.Name)
    local desc1 = StringTable.Get(cfgv.Desc)
    self.EffectDetail:SetActive(true)
    self.PopTitle2Text:SetText(name1)
    self.PoDetai2lTex:SetText(desc1)
    local hrefID2 = effects[2]
    local cfgv2 = Cfg.cfg_season_maze_relic_href_desc[hrefID2]
    if not cfgv2 then
      return
    end
    local name2 = StringTable.Get(cfgv2.Name)
    local desc2 = StringTable.Get(cfgv2.Desc)
    self.EffectDetail2:SetActive(true)
    self.PopTitle3Text:SetText(name2)
    self.PoDetai3lTex:SetText(desc2)
  elseif 2 < #effects then
    Log.fatal("[error] maze 效果数量大于2显示不下")
  end
end

function UISeasonMazeRelicRewards:RefreshSuit(suiteID)
  local curSuitCount = 0
  local suite_cfg = Cfg.cfg_component_season_maze_suit[suiteID]
  if suite_cfg == nil then
    self.SuitDetail:SetActive(false)
    return
  end
  local suits = suite_cfg.RelicList
  local suitEffect = suite_cfg.SuitEffect
  for i = 1, #suits do
    local id = suits[i]
    if table.icontains(self._bagItemInfo, id) then
      curSuitCount = curSuitCount + 1
    end
  end
  if not table.icontains(self._randItemInfo, id) then
  end
  local suitPercent = "" .. curSuitCount .. "/" .. #suits
  self.PopTitleText:SetText(StringTable.Get(suite_cfg.Name) .. "(" .. suitPercent .. ")")
  local tips = ""
  for j = 1, #suite_cfg.Words do
    local tip = suite_cfg.Words[j]
    local singleEff = suitEffect[j]
    if curSuitCount >= singleEff[1] then
      tips = tips .. "<color=#de8800>" .. StringTable.Get(tip) .. "</color>" .. "\n"
    else
      tips = tips .. "<color=#1c1c1c>" .. StringTable.Get(tip) .. "</color>" .. "\n"
    end
  end
  self.PoDetailTex:SetText(tips)
end

function UISeasonMazeRelicRewards:AnimClose()
  self:CloseDialog()
end

function UISeasonMazeRelicRewards:CloseBtnOnClick(go)
  self:AnimClose()
  if self._callBack then
    self._callBack()
  end
end

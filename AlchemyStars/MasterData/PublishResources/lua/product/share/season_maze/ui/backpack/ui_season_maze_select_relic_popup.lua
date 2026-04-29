_class("UISeasonMazeSelectRelicPopUp", UIController)
UISeasonMazeSelectRelicPopUp = UISeasonMazeSelectRelicPopUp

function UISeasonMazeSelectRelicPopUp:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeSelectRelicPopUp:OnShow(uiParams)
  self:InitWidget()
  self:InitUI()
end

function UISeasonMazeSelectRelicPopUp:OnHide()
end

function UISeasonMazeSelectRelicPopUp:InitWidget()
  self.anim = self:GetUIComponent("Animation", "_anim")
  self.cardPool = self:GetUIComponent("UISelectObjectPath", "CardPool")
  self.titleText = self:GetUIComponent("UILocalizationText", "TitleText")
  self.skipBtnText = self:GetUIComponent("UILocalizationText", "SkipBtnText")
  self.reExtractBtnText = self:GetUIComponent("UILocalizationText", "ReExtractBtnText")
  self.reExtractBtnTextRectTf = self:GetUIComponent("RectTransform", "ReExtractBtnText")
  self.curMoneyText = self:GetUIComponent("UILocalizationText", "CurMoneyText")
  self.checkGetBtn = self:GetUIComponent("Image", "CheckGetBtn")
  self.checkGetBtnText = self:GetUIComponent("UILocalizationText", "CheckGetBtnText")
  self.reExtractBtn = self:GetUIComponent("Image", "ReExtractBtn")
  self.skipBtn = self:GetUIComponent("Image", "SkipBtn")
  self.quickPop = self:GetGameObject("QuickPop")
  self.tipsText1 = self:GetUIComponent("UILocalizationText", "TipsText1")
  self.tipsText2 = self:GetUIComponent("UILocalizationText", "TipsText2")
  self.tipsText3 = self:GetUIComponent("UILocalizationText", "TipsText3")
  self.tipsTextRoot = self:GetGameObject("TipsTextRoot")
  self.guideImg = self:GetUIComponent("Image", "GuideImg")
  self.skipAddMoneyBtnText = self:GetUIComponent("UILocalizationText", "SkipAddMoneyBtnText")
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
  self.FreeTextObj = self:GetGameObject("FreeText")
  self.FreeTextObj:SetActive(false)
  self.FreeImgObj = self:GetGameObject("FreeImg")
  self.FreeImgObj:SetActive(false)
  local topTips = self:GetUIComponent("UISelectObjectPath", "topTips")
  self._toptipsInfo = topTips:SpawnObject("UITopTipsContextSMaze")
  self._type2topID = {
    [SeasonMazeTopIconType.Money] = 9001002,
    [SeasonMazeTopIconType.MoneyAdd] = 9001003,
    [SeasonMazeTopIconType.Ms] = 9001001
  }
  self.TopToonAnchorObj = self:GetGameObject("TopToonAnchor")
  self:AttachEvent(GameEventType.OnSeasonMazeShowRewardsFinish, self.OnSeasonMazeShowRewardsFinish)
end

function UISeasonMazeSelectRelicPopUp:InitUI()
  self.selectRelicEff = {}
  self.totalCount = 4
  self._module = GameGlobal.GetModule(MazeModule)
  if self._module == nil then
    Log.fatal("[error] maze --> module == nil !")
  end
  self._cfg = Cfg.cfg_item({})
  if self._cfg == nil then
    Log.fatal("[error] maze --> _cfg == nil !")
  end
  self.seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self.uiSeasonMazeModule = self.seasonMazeModule:UIModule()
  self._seasonMazeObj = self.seasonMazeModule:CurSeasonObj()
  self._component = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._componentInfo = self._component:GetComponentInfo()
  self._comCfgID = self._component:GetComponentCfgId()
  self._cfg_global = Cfg.cfg_component_season_maze_global[self._comCfgID]
  local ranRelicInfo = self._componentInfo.relic_random
  if ranRelicInfo == nil then
    Log.fatal("[error] maze --> ranRelic == nil !")
    return
  end
  local ranRelic = ranRelicInfo.ids
  local resetNuM = ranRelicInfo.reset_cnt
  local curMoney = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  self.curMoneyText:SetText("" .. curMoney)
  self.skipAddMoneyBtnText:SetText("+" .. self._cfg_global.RelicSkip)
  self.a_redraw = self._cfg_global.RelicParam[1]
  self.b_redraw = self._cfg_global.RelicParam[2]
  self.c_redraw = self._cfg_global.RelicParam[3]
  self:RefreshReDrawText()
  local relics = {}
  self.mazeRelics = self.uiSeasonMazeModule:GetSeasonMazeRelics()
  for key, value in pairs(self.mazeRelics) do
    relics[#relics + 1] = key
  end
  self._bagItemInfo = self:Relic_SortItems(relics)
  self._randItemInfo = self:Relic_SortItems(ranRelic)
  self.defaultIndex = 1
  self.totalCount = #ranRelic
  self._relicArea = UIWidgetHelper.SpawnObjects(self, "CardPool", "UIseasonMazeSelectRelicItem", self.totalCount)
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

function UISeasonMazeSelectRelicPopUp:Relic_SortItems(items)
  return items
end

function UISeasonMazeSelectRelicPopUp:GetSeasonMazeCfg(hardLevel)
  local cfgs = Cfg.cfg_component_season_maze({
    ComponentID = self.cmptId
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

function UISeasonMazeSelectRelicPopUp:RefreshReDrawText()
  local curMoney = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  local ranRelicInfo = self._componentInfo.relic_random
  local resetNuM = ranRelicInfo.reset_cnt
  local rerollNum = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Free_Reroll_Num)
  local priceAttr = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Goods_Price_Percent)
  if priceAttr == nil then
    priceAttr = 0
  end
  local redrawCost = 6
  if resetNuM < rerollNum then
    resetNuM = resetNuM - rerollNum + 1
    redrawCost = self:CalcResetCost(resetNuM, self._cfg_global.RelicParam)
    if redrawCost == 0 then
      redrawCost = 6
    end
    self.reExtractBtnText:SetText("-" .. redrawCost)
    self.FreeTextObj:SetActive(true)
    self.FreeImgObj:SetActive(true)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.reExtractBtnTextRectTf)
    return
  else
    self.FreeTextObj:SetActive(false)
    self.FreeImgObj:SetActive(false)
    resetNuM = resetNuM - rerollNum + 1
    redrawCost = self:CalcResetCost(resetNuM, self._cfg_global.RelicParam)
  end
  if curMoney < redrawCost then
    self.reExtractBtnText:SetText("<color=#FF0000>-" .. redrawCost .. "</color>")
  else
    self.reExtractBtnText:SetText("-" .. redrawCost)
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.reExtractBtnTextRectTf)
end

function UISeasonMazeSelectRelicPopUp:CalcResetCost(resetCount, cfgParam)
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
  local comInfo = self._component:GetComponentInfo()
  local priceAttr = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Goods_Price_Percent)
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

function UISeasonMazeSelectRelicPopUp:BgOnClick(go)
end

function UISeasonMazeSelectRelicPopUp:CardBagBtnOnClick(go)
  self:ShowDialog("UISeasonMazeBackPackController", 2)
end

function UISeasonMazeSelectRelicPopUp:SkipBtnOnClick(go)
  self:_Skip()
end

function UISeasonMazeSelectRelicPopUp:ReExtractBtnOnClick(go)
  local ranRelicInfo = self._componentInfo.relic_random
  local curMoney = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  local rerollNum = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Free_Reroll_Num)
  local resetNuM = ranRelicInfo.reset_cnt
  local redrawCost = self.a_redraw * resetNuM * resetNuM + self.b_redraw * resetNuM + self.c_redraw
  if rerollNum > resetNuM then
    redrawCost = 0
  else
    resetNuM = resetNuM - rerollNum
    redrawCost = self.a_redraw * resetNuM * resetNuM + self.b_redraw * resetNuM + self.c_redraw
  end
  if curMoney > redrawCost then
    self:_Redraw()
  else
    ToastManager.ShowToast(StringTable.Get("str_season_maze_select_relic_unenough_money"))
  end
end

function UISeasonMazeSelectRelicPopUp:CheckGetBtnOnClick(go)
  self:_Select()
end

function UISeasonMazeSelectRelicPopUp:CancleRedrawBtnOnClick(go)
end

function UISeasonMazeSelectRelicPopUp:QuickRedrawBtnOnClick(go)
end

function UISeasonMazeSelectRelicPopUp:ClosePopBtnOnClick(go)
  self.DetailPopRoot:SetActive(false)
end

function UISeasonMazeSelectRelicPopUp:_Select()
  self:StartTask(self._ReqSelectRelic, self, self.defaultIndex - 1)
end

function UISeasonMazeSelectRelicPopUp:_ReqSelectRelic(TT, idx)
  if GameGlobal.GetModule(SeasonMazeModule) == nil or GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj() == nil then
    Log.error("圣物选择失败, 没有赛季秘境数据")
    self:AnimClose()
    return
  end
  local cpt = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj():GetMazeComponent()
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local relicID = cpt:GetComponentInfo().relic_random.ids[idx + 1]
  local response = cpt:HandleSeasonMazeChooseRelic(TT, res, idx, 0)
  if res:GetSucc() then
    Log.info("选择圣物成功:", idx)
    local reward = {}
    if relicID and 0 < relicID then
      local relicEft = SeasonMazeEffect:New()
      relicEft.type = SeasonMazeEffectType.SMET_Relic
      relicEft.id = relicID
      relicEft.value_min = 1
      relicEft.value_max = 1
      table.insert(reward, relicEft)
    end
    if response.reward and 0 < #response.reward then
      table.appendArray(reward, response.reward)
    end
    local ranRelicInfo = self._componentInfo.relic_random
    if 1 <= #ranRelicInfo.group_num then
      YIELD(TT)
      for j = 1, #self._relicArea do
        local otherItem = self._relicArea[j]
        otherItem:UnSelectItem()
        if j == 1 then
          otherItem:SelectItem()
        end
      end
      self._componentInfo = self._component:GetComponentInfo()
      local ranRelicInfo = self._componentInfo.relic_random
      self:RefreshUI(ranRelicInfo)
      
      function self._waitGetRewardsFinishCb()
        SMazeAdaptor.OnRelicObtained(reward, SMazeRelicReason.ChooseRelic)
      end
      
      local showRewards = {}
      for index, value in ipairs(response.reward) do
        local reward = value
        if reward.type == SeasonMazeEffectType.SMET_Relic then
          table.insert(showRewards, reward)
        end
      end
      SeasonMazeTool:GetInstance():ShowUIGetRewards(showRewards)
    else
      function self._waitGetRewardsFinishCb()
        SMazeAdaptor.OnRelicObtained(reward, SMazeRelicReason.ChooseRelicLastTime)
        
        self:AnimClose()
      end
      
      do
        local showRewards = {}
        for index, value in ipairs(response.reward) do
          local reward = value
          if reward.type == SeasonMazeEffectType.SMET_Relic then
            table.insert(showRewards, reward)
          end
        end
        SeasonMazeTool:GetInstance():ShowUIGetRewards(showRewards)
      end
    end
  else
    Log.error("圣物选择失败:", res:GetResult())
  end
end

function UISeasonMazeSelectRelicPopUp:_Skip()
  self:StartTask(self._ReqSkipRelic, self, self.defaultIndex - 1)
end

function UISeasonMazeSelectRelicPopUp:_ReqSkipRelic(TT, idx)
  if GameGlobal.GetModule(SeasonMazeModule) == nil or GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj() == nil then
    Log.error("圣物跳过失败, 没有赛季秘境数据")
    self:AnimClose()
    return
  end
  local cpt = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj():GetMazeComponent()
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  cpt:HandleSeasonMazeChooseRelic(TT, res, idx, 2)
  if res:GetSucc() then
    Log.info("跳过圣物成功:", idx)
    ToastManager.ShowToast(StringTable.Get("str_season_maze_select_relic_skip_add_money"))
    local ranRelicInfo = self._componentInfo.relic_random
    if #ranRelicInfo.group_num >= 1 then
      YIELD(TT)
      self._componentInfo = self._component:GetComponentInfo()
      local ranRelicInfo = self._componentInfo.relic_random
      self:RefreshUI(ranRelicInfo)
    else
      SMazeAdaptor.OnRelicObtained({}, SMazeRelicReason.ChooseRelicLastTime)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, SeasonMazeAttrType.SMAT_Gold)
      self:AnimClose()
    end
  else
    Log.error("圣物跳过失败:", res:GetResult())
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeSelectRelicPopUp:_Redraw()
  self:StartTask(self._ReqRedrawRelic, self, self.defaultIndex - 1)
end

function UISeasonMazeSelectRelicPopUp:_ReqRedrawRelic(TT, idx)
  if GameGlobal.GetModule(SeasonMazeModule) == nil or GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj() == nil then
    Log.error("圣物重抽失败, 没有赛季秘境数据")
    self:AnimClose()
    return
  end
  local cpt = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj():GetMazeComponent()
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local ranRelicInfo = cpt:HandleSeasonMazeChooseRelic(TT, res, idx, 1)
  if res:GetSucc() then
    Log.info("重抽成功:", idx)
    YIELD(TT)
    for j = 1, #self._relicArea do
      local otherItem = self._relicArea[j]
      otherItem:UnSelectItem()
      if j == 1 then
        otherItem:SelectItem()
      end
    end
    self:RefreshUI(ranRelicInfo.relic_random)
  else
    Log.error("圣物重抽失败:", res:GetResult())
  end
end

function UISeasonMazeSelectRelicPopUp:RefreshUI(ranRelicInfo)
  local ranRelic = ranRelicInfo.ids
  local resetNuM = ranRelicInfo.reset_cnt
  self._randItemInfo = self:Relic_SortItems(ranRelic)
  self.defaultIndex = 1
  self.totalCount = #ranRelic
  self._relicArea = UIWidgetHelper.SpawnObjects(self, "CardPool", "UIseasonMazeSelectRelicItem", self.totalCount)
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
  local curMoney = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
  self.curMoneyText:SetText("" .. curMoney)
  local resetNuM = ranRelicInfo.reset_cnt
  self:RefreshReDrawText()
end

function UISeasonMazeSelectRelicPopUp:RefreshDetilUI(index)
  local pos = self.DetailTipsRootRectTf.anchoredPosition
  if index == 1 then
    pos.x = -304
  elseif index == 2 then
    pos.x = 87
  elseif index == 3 then
    pos.x = 522
  elseif index == 4 then
    pos.x = 717
  end
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

function UISeasonMazeSelectRelicPopUp:RefreshEffect(effects)
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

function UISeasonMazeSelectRelicPopUp:RefreshSuit(suiteID)
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

function UISeasonMazeSelectRelicPopUp:AnimClose()
  self.anim:Play("uieffanim_UISeasonMazeSelectRelicPopUp_out")
  local timerEvent = GameGlobal.Timer():AddEventTimes(200, TimerTriggerCount.Once, function()
    self:CloseDialog()
  end)
end

function UISeasonMazeSelectRelicPopUp:MoneyBgOnClick(go)
  local topid = self._type2topID[SeasonMazeTopIconType.Money]
  self._toptipsInfo:SetData(topid, self.TopToonAnchorObj)
end

function UISeasonMazeSelectRelicPopUp:OnSeasonMazeShowRewardsFinish(flag)
  if self._waitGetRewardsFinishCb then
    self._waitGetRewardsFinishCb()
    self._waitGetRewardsFinishCb = nil
  end
end

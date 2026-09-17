local this = class("heroLevelUpArea", G_UIModuleBase)
local wordsTpl = L_GameTpl:getWordsTpl()
local _heroLevelTpl = L_GameTpl:getHeroLevelTpl()
local ratio = L_GameConstTpl:getData("HERO_LEVELUP_GOLD", L_Const.GameTplType.int) / 10000
local commonItemTpl = L_GameTpl:getCommonItemTpl()
local PROPID = {
  400000,
  400001,
  400002,
  400003
}
local PROPIDColor = {
  CS.UnityEngine.Color(0.6274509803921569, 0.6823529411764706, 0.7176470588235294),
  CS.UnityEngine.Color(0.22745098039215686, 0.7019607843137254, 1.0),
  CS.UnityEngine.Color(0.5058823529411764, 0.35294117647058826, 0.9490196078431372),
  CS.UnityEngine.Color(1.0, 0.6980392156862745, 0.11764705882352941)
}
local changeAnimationName = {
  Change0 = "Change0",
  Change1 = "Change1",
  Change2 = "Change2"
}
local moduleName = "heroLevelUpArea"
local checkPageName = "pageHeroLevelUpgrade"
local AreaName = "AreaHeroLevelUp"

function this.bind()
  return {
    maxLv = "",
    gold = true,
    goldNum = "",
    expPropItem = {
      moduleName = "modulePages/cellSubmitItem"
    },
    unlockDesText = "",
    unlockDesNodeActive = false,
    btnAreaActive = true,
    expBpActive = true,
    toggle_isCleanAll = false
  }
end

function this.methods()
  return {
    onClick_reset = function(self)
      local tempExpAll = self:getExpAll()
      if tempExpAll <= 0 then
        L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_common_reset"))
      end
      local showAnim = false
      local currentLv = self.lv
      self:onClickReset()
      if currentLv ~= self.lv then
        showAnim = true
        self:playAnimation(changeAnimationName.Change0, self.lv, currentLv)
      end
    end,
    onClick_max = function(self)
      self:PlayVoice()
      local lv = self:getCurrentLv()
      if lv >= self.maxLv then
        L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_herolevelup_levelmax"))
        return
      end
      local tempExpAll = 0
      for _, module in ipairs(self.modules.expPropItem) do
        local itemId = module.bind.itemId
        local exp = commonItemTpl:getUseFunction(commonItemTpl:getTplById(itemId))[1]
        tempExpAll = tempExpAll + C_BagMgr:getItemNumByItemId(itemId) * exp
      end
      local maxLv = 0
      for i = self.maxLv, lv + 1, -1 do
        local heroExpAll = self:getHeroExpAll(i)
        if tempExpAll >= heroExpAll then
          maxLv = i
          break
        end
      end
      if maxLv <= 0 then
        L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_herolevelup_lackitem"))
        return
      end
      self:autoSetItemToTargetLevel(maxLv)
    end,
    onClick_lvUp = function(self)
      self:onLevelUpClicked()
    end
  }
end

function this:PlayVoice()
  if self.bInVoiceCD then
    return
  end
  self.bInVoiceCD = true
  local hero = self.parent:getHero()
  local configId = L_HeroStore:getHeroConfigId(hero)
  L_AudioUtil.playSound("Play_VO_System_" .. configId .. "_MaterialChoose")
  self:newOrResetTimer("voiceCD", function()
    self.bInVoiceCD = false
  end, L_GameTpl:getGameConstTpl():getData("CHARACTER_MATERIALCHOOSE_VOICE_CD", L_Const.GameTplType.int))
end

function this:onLevelUpClicked()
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.HeroUpgrade))
    return
  end
  local selectedInfo = self:getSelectedInfo()
  if #selectedInfo <= 0 then
    L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_hero_chooseLevelItem"))
    return
  end
  local goldAmount = L_PlayerStore:getCurrencyNum(L_Const.currencyType.gold)
  if not goldAmount or goldAmount < self.goldNum then
    L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_common_lackGold"))
    return
  end
  local heroId = self.parent:getHeroId()
  local data = {hero_id = heroId, items = selectedInfo}
  self:setExpBp()
  self.bind.toggle_isCleanAll = false
  local hero = self.parent:getHero()
  local heroLv = L_HeroStore:getHeroLevel(hero)
  local lv = self:getCurrentLv()
  local heroRank = L_HeroStore:getHeroRank(hero)
  L_HeroStore:setIsPlayLevelAnim(true)
  if self.bInRequest then
    return
  end
  self.bInRequest = true
  AzurWorld.heroMgr:ReqUpgradeHero(heroId, selectedInfo, function(errorCode, sData)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      local timeScale = 0.6
      if 10 <= lv - heroLv then
        timeScale = 1.2
        C_AudioManager.Play("Play_SFX_System_UI_CHAR_Level_Upgrade_FX_Long")
        self:playAnimation(changeAnimationName.Change1, lv, heroLv)
      else
        C_AudioManager.Play("Play_SFX_System_UI_CHAR_Level_Upgrade_FX_Short")
        self:playAnimation(changeAnimationName.Change2, lv, heroLv)
      end
      Timer.once(timeScale, function()
        L_HeroStore:setIsPlayLevelAnim(false)
        self:setExpBp()
        AzurWorld.heroMgr:DispatchSyncHeroServerData(L_HeroStore:getHeroGuid(hero))
        self.bInRequest = false
        if lv > heroLv then
          L_UI:open("pageHeroLevelUpgrade", {
            heroId = heroId,
            oldLevel = heroLv,
            newLevel = lv,
            heroRank = heroRank
          })
        end
      end, self)
      if lv > heroLv then
        local configId = L_HeroStore:getHeroConfigId(hero)
        L_HeroVoiceManager:playHeroVoiceByUnitrule("LevelBreak", false, 0, false, configId)
      end
    else
      L_HeroStore:setIsPlayLevelAnim(false)
      self.bInRequest = false
    end
  end)
end

function this:playAnimation(animName, targetLevel, oldLevel)
  if animName == changeAnimationName.Change0 then
    if oldLevel < targetLevel then
      C_AudioManager.Play("Play_SFX_System_UI_CHAR_Level_Up_FX")
    end
    if targetLevel < oldLevel then
      C_AudioManager.Play("Play_SFX_System_UI_CHAR_Level_Down_FX")
    end
  end
  if self.animatorHandler then
    self.animatorHandler(animName, targetLevel, oldLevel)
  end
end

function this:onOpenExp()
  self:setExpBp()
  self.isHideGamepadBottom = false
  local pageName = self:getModulePageName()
  CS.Lens.Gameplay.UI.UIPageAreaStateMachine.instance:PushArea(pageName, AreaName)
  C_UIMgr.gamepadConfigMap:UpdateVirtualCursorVisibility()
end

function this:onCloseExpBtn()
  self.isHideGamepadBottom = true
  local pageName = self:getModulePageName()
  CS.Lens.Gameplay.UI.UIPageAreaStateMachine.instance:ReplaceArea(pageName, "Default")
  C_UIMgr.gamepadConfigMap:UpdateVirtualCursorVisibility()
  self:onClickReset()
end

function this:onClickReset()
  self:setExpBp()
  self:onItemNumChange()
end

function this:getSelectedInfo()
  local tempExp = {}
  for _, module in ipairs(self.modules.expPropItem) do
    local num = module.selectNum
    if num and 0 < num then
      table.insert(tempExp, {
        item_id = module.bind.itemId,
        item_num = num
      })
    end
  end
  return tempExp
end

function this:open()
  self.bInVoiceCD = false
  L_ShortCutManager:registerShortCut(moduleName, C_InputManager_KeyType.EGamepadUI_Square, function()
    if self.currentSelectedCell then
      self.currentSelectedCell:onRemoveClick()
    end
  end)
  L_UI:addListener(L_UI.pageEvent.showed, self.onPageShow, self)
  L_UI:addListener(L_UI.pageEvent.hided, self.onPageHide, self)
end

function this:close()
  L_ShortCutManager:removeShortCut(moduleName)
  L_UI:removeListener(L_UI.pageEvent.showed, self.onPageShow, self)
  L_UI:removeListener(L_UI.pageEvent.hided, self.onPageHide, self)
end

function this:refreshHeroProperty(isShowAnim)
  local hero = self.parent:getHero()
  local configId = L_HeroStore:getHeroConfigId(hero)
  local rank = L_HeroStore:getHeroRank(hero)
  local curLv = L_HeroStore:getHeroLevel(hero)
  self.maxLv = _heroLevelTpl:getMaxLvByCondition()
  local tempLv, tempExp, tempExpAll = self:getPreviewHeroInfo(self.maxLv)
  self.lv = tempLv
  self.parent:setHeroInfo({
    lv = tempLv,
    exp = tempExp,
    addExp = tempExpAll,
    rank = rank,
    isShowAnim = isShowAnim
  })
  local heroExpAll = self:getHeroExpAll(self.maxLv)
  if tempExpAll > heroExpAll then
    self.goldNum = tempExpAll * ratio
  else
    self.goldNum = tempExpAll * ratio
  end
  self.bind.goldNum = tostring(math.modf(self.goldNum))
  if L_PlayerStore:getCurrencyNum(L_Const.currencyType.gold) < self.goldNum then
    self.bind.goldNum = L_GameUtil.fillColor(math.modf(self.goldNum), L_Const.colorHtml.red001)
  end
  local isLock = curLv >= self.maxLv
  self.bind.unlockDesText = ""
  self.bind.unlockDesNodeActive = false
  self.bind.btnAreaActive = not isLock
  self.bind.expBpActive = not isLock
  if _heroLevelTpl:getMaxLv() == curLv and isLock then
    self.bind.unlockDesNodeActive = false
    self.bind.btnAreaActive = false
    self.bind.expBpActive = false
  else
    local condition = _heroLevelTpl:getCondition(_heroLevelTpl:getTplById(curLv + 1))
    local contitionDesc = L_ConditionManager:getSingleDesc(condition)
    self.bind.unlockDesText = L_WordsTpl:getValue("ui_hero_level_max") or L_WordsTpl:getValue("ui_moduleUpgrade", {
      [0] = contitionDesc
    })
  end
  self:refreshGamepadBottomKey()
end

function this:setExpBp()
  self.bind.expPropItem:clear()
  local clickHandle = handler(self, self.onCellItemClick)
  local removeClickHandle = handler(self, self.onCellItemRemoveClick)
  local selectHandle = handler(self, self.onCellSelect)
  local deSelectHandle = handler(self, self.onCellDeSelect)
  local data = {}
  for i = 1, #PROPID do
    local item = L_ItemManager:parseCommonItem(PROPID[i])
    if item.num > 99999 then
      item.num = 99999
    end
    local itemTpl = commonItemTpl:getTplById(PROPID[i])
    table.insert(data, {
      itemType = L_Const.resType.commonItem,
      itemShowType = L_Const.submitItemShowType.select,
      itemId = PROPID[i],
      itemNum = item.num,
      activeMask = item.num == 0,
      quality = commonItemTpl:getRarity(itemTpl),
      pressWorking = item.num > 0,
      clickCallback = clickHandle,
      clickRemoveCallback = removeClickHandle,
      selectCallback = selectHandle,
      deSelectCallback = deSelectHandle,
      disableCellIconContent = true
    })
  end
  self.bind.expPropItem:insert_array(data)
end

function this:getCurrentLv()
  return self.lv
end

function this:getHeroLv()
  local hero = self.parent:getHero()
  return L_HeroStore:getHeroLevel(hero)
end

function this:getMaxLv()
  return self.maxLv
end

function this:getExpAll()
  local tempExpAll = 0
  for _, module in ipairs(self.modules.expPropItem) do
    local exp = commonItemTpl:getUseFunction(commonItemTpl:getTplById(module.bind.itemId))[1]
    tempExpAll = tempExpAll + module:getSelectNum() * exp
  end
  return tempExpAll
end

function this:getHeroExpAll(maxLv)
  local hero = self.parent:getHero()
  local heroExpAll = 0 - L_HeroStore:getHeroExp(hero)
  for i = L_HeroStore:getHeroLevel(hero), maxLv - 1 do
    heroExpAll = heroExpAll + _heroLevelTpl:getExp(_heroLevelTpl:getTplById(i))
  end
  return heroExpAll
end

function this:getPreviewHeroInfo(maxLv)
  local tempExpAll = self:getExpAll()
  local hero = self.parent:getHero()
  local tempExp = tempExpAll + L_HeroStore:getHeroExp(hero)
  local tempLv = L_HeroStore:getHeroLevel(hero)
  for i = tempLv, maxLv - 1 do
    if tempExp - _heroLevelTpl:getExp(_heroLevelTpl:getTplById(i)) < 0 then
      break
    end
    tempLv = i + 1
    tempExp = tempExp - _heroLevelTpl:getExp(_heroLevelTpl:getTplById(i))
  end
  return tempLv, tempExp, tempExpAll
end

function this:autoSetItemToTargetLevel(targetLv, reduce)
  local maxLv = self:getMaxLv()
  if maxLv <= targetLv - 1 then
    return true
  end
  local tempExpAll = 0
  local data = {}
  local curItemData = {}
  for _, module in ipairs(self.modules.expPropItem) do
    local itemId = module.bind.itemId
    local exp = commonItemTpl:getUseFunction(commonItemTpl:getTplById(itemId))[1]
    tempExpAll = tempExpAll + C_BagMgr:getItemNumByItemId(itemId) * exp
    data[exp] = C_BagMgr:getItemNumByItemId(itemId)
    curItemData[exp] = module:getSelectNum()
  end
  local heroExpAll = self:getHeroExpAll(targetLv)
  local exp = tempExpAll >= heroExpAll and heroExpAll or 0
  if tempExpAll < heroExpAll then
    L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_herolevelup_lackitem"))
    return true
  end
  local newItemData = L_HeroManager:autoLvUp(data, exp)
  if reduce and table.same(curItemData, newItemData) then
    for i, v in pairs(newItemData) do
      if 0 < v then
        newItemData[i] = newItemData[i] - 1
        break
      end
    end
  end
  self.isReduce = targetLv < self.lv
  for k, v in pairs(newItemData) do
    for _, module in ipairs(self.modules.expPropItem) do
      local itemId = module.bind.itemId
      local itemExp = commonItemTpl:getUseFunction(commonItemTpl:getTplById(itemId))[1]
      if itemExp == k then
        module:setSelect(0 < v, v)
      end
    end
  end
  self.isReduce = false
  self:onItemNumChange()
end

function this:setAnimatorHander(animatorHandler)
  self.animatorHandler = animatorHandler
end

function this:onCellItemClick(cell)
  if cell.bind.itemNum == 0 then
    local notShowAccess = self:GetSourceLuaPageOptions("failure_jump")
    L_ItemTplManager:showInfoTip(cell.bind.itemType, cell.bind.itemId, nil, nil, notShowAccess)
    return
  end
  if tonumber(self:getCurrentLv()) >= tonumber(self:getMaxLv()) and not self.isReduce then
    L_HeroManager:heroHintInfo(5)
    return
  end
  if cell:getSelectNum() >= cell.bind.itemNum then
    L_HeroManager:heroHintInfo(3)
    return
  end
  cell:setSelect(true, cell:getSelectNum() + 1)
  self:onItemNumChange()
  self:PlayVoice()
end

function this:onCellItemRemoveClick(cell)
  if not cell.select then
    return
  end
  if not cell.selectNum or cell.selectNum <= 0 then
    cell:setSelect(false, 0)
    return
  end
  cell:setSelect(cell.selectNum > 1, cell.selectNum - 1)
  self:onItemNumChange()
end

function this:onItemNumChange()
  self.bind.toggle_isCleanAll = self:getExpAll() > 0
  local lastLv = self.lv
  self:refreshHeroProperty(true)
  if lastLv ~= self.lv then
    self:playAnimation(changeAnimationName.Change0, self.lv, lastLv)
  end
end

function this:onCellSelect(cell)
  self.currentSelectedCell = cell
  self:refreshGamepadBottomKey()
end

function this:onCellDeSelect(cell)
  if self.currentSelectedCell == cell then
    self.currentSelectedCell = nil
  end
end

function this:refreshGamepadBottomKey()
  if self.checkPageIsShow then
    return
  end
  local args
  if not self.isHideGamepadBottom then
    args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
    args.isLuaEvent = true
    args.luaTable = {moduleOrPageName = moduleName}
    if self.bindComponents.UINavigationBinding then
      self.bindComponents.UINavigationBinding.navigationEnabled = self.bind.expBpActive
    end
    if self.bind.expBpActive then
      if self.currentSelectedCell and self.currentSelectedCell:getSelectNum() > 0 then
        args.luaTable.changeGroupName = "Select_Normal"
      else
        args.luaTable.changeGroupName = "Select_NoRemove"
      end
    else
      args.luaTable.changeGroupName = "NoSelect"
    end
  end
  C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
end

function this:onPageShow(pageName)
  if checkPageName ~= pageName then
    return
  end
  self.checkPageIsShow = true
end

function this:onPageHide(pageName)
  if checkPageName ~= pageName then
    return
  end
  self.checkPageIsShow = false
  self:refreshGamepadBottomKey()
end

return this

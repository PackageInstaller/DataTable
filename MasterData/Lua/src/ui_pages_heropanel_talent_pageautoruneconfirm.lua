local this = class("pageAutoRuneConfirm", G_UIPageBase)
local talentRuneTpl = L_GameTpl:getTalentRuneTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local qualityBgPath = "Assets/ResourcesAssets/UI/Atlas/CommonItem/tex_common_bg_quality_light_0%s.png"

function this.bind()
  return {
    module_commonTipLarge = L_Const.ModuleInfo.ModuleCommonTip,
    moduleCurrency = {
      moduleName = "modulePages/moduleCurrency"
    },
    sortingOrder_page = nil,
    runeList = {
      moduleName = "pages/HeroPanel/talent/cellAutoRune"
    },
    equipBtn = L_Const.ModuleInfo.ModuleBtn,
    attributList = {
      moduleName = "pages/heroPanel/hero/heroProperty"
    },
    skillList = {
      moduleName = "pages/heroPanel/talent/cellSkillAddItem"
    },
    runeCoinList = {
      moduleName = "pages/HeroPanel/talent/cellTalentRuneCoin"
    },
    attributListActive = true,
    skillListActive = true,
    active_extraItem = false,
    img_extraItemIcon = "",
    img_extraBgQuality = "",
    txt_num = ""
  }
end

function this.methods()
  return {
    module_commonTipLarge = {
      onClick_close = function(self)
        if self._params.cancelCallback then
          self._params.cancelCallback()
        end
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        if self._params.cancelCallback then
          self._params.cancelCallback()
        end
        L_UI:close(self.pageName)
      end,
      onClick_confirm = function(self)
      end
    },
    onClick_extraItem = function(self)
      local extra = self.extraCost
      if extra ~= nil then
        L_ItemTplManager:showInfoTip(extra.itemType, extra.itemId)
      end
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.selectedIndex = 1
  self:refreshPage(options)
  self.onEvent_itemRefreshHandle = handler(self, self.onEvent_ItemRefresh)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self.onEvent_itemRefreshHandle)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshAttr, self.onEvent_ItemRefresh, self)
end

function this:close()
  this.super.close(self)
  if self._params.pageClosedCallback then
    self._params.pageClosedCallback()
  end
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self.onEvent_itemRefreshHandle)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshAttr, self.onEvent_ItemRefresh, self)
  self.onEvent_itemRefreshHandle = nil
end

function this:onEvent_ItemRefresh()
  if self._params ~= nil then
    self:refreshPage(self._params)
  end
end

function this:refreshPage(params)
  self._params = params or {}
  self.modules.module_commonTipLarge:initModule(params)
  if not math.isEmpty(params.overrideSortingOrder) then
    self.bind.sortingOrder_page = params.overrideSortingOrder
  end
  local data = {}
  self.runeData = {}
  self.slotList = self._params.slotIds
  self.runeList = self._params.runes
  for _, runeId in ipairs(self._params.runes) do
    table.insert(self.runeData, {
      runeId = runeId,
      heroGuid = self._params.heroGuid,
      isEquiped = false
    })
    table.insert(data, {runeId = runeId})
  end
  self.bind.runeList:clear()
  self.bind.runeList:insert_array(data)
  self:initEquipBtn()
  self:initTalentRuneList()
  self:refreshDetail()
  local tpl_sys = L_GameTpl:getSystemUnlockTpl():getTplById(L_SystemConst.enum.heroTalent)
  self.modules.moduleCurrency:refreshRes(tpl_sys)
end

function this:onClickRune(runeId)
  for k, v in ipairs(self.runeData) do
    if v.runeId == runeId then
      self.selectedIndex = k
      break
    end
  end
  self:refreshDetail()
end

function this:refreshDetail()
  self:initAttributeList()
  self:initSkillList()
  self:refreshDetailLayout()
end

function this:initAttributeList()
  local attributes = {}
  local runeIds = {}
  for _, v in ipairs(self.runeData) do
    table.insert(runeIds, v.runeId)
  end
  L_HeroManager:addRuneAttributes(runeIds, attributes)
  local data = {}
  for k, v in pairs(attributes) do
    local name = battleInfoTpl:getName(battleInfoTpl:getTplById(k))
    if not string.isEmpty(L_Const.attrBaseName[k]) then
      name = L_WordsTpl:getValue(L_Const.attrBaseName[k])
    end
    table.insert(data, {
      active_icon = true,
      icon = battleInfoTpl:getIcon(battleInfoTpl:getTplById(k)),
      nextAttr = battleInfoTpl:getShowTxtComma(k, v),
      name = name,
      id = k
    })
  end
  table.sort(data, function(a, b)
    return a.id < b.id
  end)
  for i, v in ipairs(data) do
    v.toggle_state = i % 2 ~= 0
  end
  self.bind.attributList:clear()
  self.bind.attributList:insert_array(data)
  self.bind.attributListActive = 0 < #data
end

function this:initSkillList()
  local skillData = {}
  local heroGuid = self._params.heroGuid
  local hero = L_HeroStore:getHero(heroGuid)
  local skillList = L_HeroManager:getHeroSystemSkillList(hero)
  for _, v in ipairs(self.runeData) do
    local runeId = v.runeId
    local runeTpl = talentRuneTpl:getTplById(runeId)
    local skills = talentRuneTpl:getRuneSkill(runeTpl)
    for _, skill in ipairs(skills) do
      local slot = skill[1] + 1
      if not skillData[slot] then
        skillData[slot] = {
          skillId = skillList[slot].skillId,
          addLevel = skill[2],
          heroGuid = heroGuid,
          slot = slot
        }
      else
        skillData[slot].addLevel = skill[2] + skillData[slot].addLevel
      end
    end
  end
  local data = {}
  for _, skill in pairs(skillData) do
    table.insert(data, skill)
  end
  table.sort(data, function(a, b)
    return a.slot < b.slot
  end)
  self.bind.skillList:clear()
  self.bind.skillList:insert_array(data)
  self.bind.skillListActive = 0 < #data
end

function this:initEquipBtn()
  local needCost = 0
  local needGrantList = {}
  local slotIdList = {}
  for _, rune in ipairs(self.runeData) do
    if not rune.isEquiped then
      local runeTpl = talentRuneTpl:getTplById(rune.runeId)
      local cost = talentRuneTpl:getEquipRuneThroughCoin(runeTpl)
      needCost = needCost + cost
      table.insert(needGrantList, rune.runeId)
      slotIdList[rune.runeId] = rune.slotId
    end
  end
  self.isNeedCompose = true
  local store = C_RuneStore.GetStore()
  local isHadList, canGrantList, _ = store:OnGetCheckAllCanGrantList(needGrantList, false, false)
  if isHadList then
    local hadCount = 0
    local targetCount = canGrantList.Count
    for i = 0, targetCount - 1 do
      local talentRuneId = canGrantList[i]
      if 0 < talentRuneId then
        hadCount = hadCount + 1
      end
    end
    self.isNeedCompose = hadCount ~= #needGrantList
  end
  local btnTxtName = self.isNeedCompose and L_WordsTpl:getValue("ui_character_rune_material_complete") or L_WordsTpl:getValue("ui_hero_rune_quick_equip")
  local params = {
    txtName = btnTxtName,
    callback = handler(self, self.dealEquipBtn)
  }
  self.needCost = needCost
  self.modules.equipBtn:setData(params)
end

function this:initTalentRuneList()
  local tab = {}
  local runeData = self.runeData
  local runeCoinList = self.bind.runeCoinList
  local extraCost
  for i = 1, #runeData do
    local rune = runeData[i]
    local runeTpl = talentRuneTpl:getTplById(rune.runeId)
    local costs = talentRuneTpl:getEquipRuneCoin(runeTpl)
    local extra = talentRuneTpl:getExtraCost(runeTpl)[1]
    if extra ~= nil then
      if extraCost == nil then
        extraCost = {
          itemType = extra[1],
          itemId = extra[2],
          itemNum = extra[3]
        }
      else
        extraCost.itemNum = extra[3] + extraCost.itemNum
      end
    end
    if costs then
      for j = 1, #costs do
        local cost = costs[j]
        local costId, costValue = cost[1], cost[2]
        local entry = tab[costId]
        if entry then
          entry.cost = entry.cost + costValue
        else
          tab[costId] = {cost = costValue}
        end
      end
    end
  end
  self.talentRuneTab = {}
  self.isCanEquip = true
  local index = 0
  for id, data in next, tab, nil do
    index = index + 1
    self.talentRuneTab[index] = {
      id = id,
      type = L_Const.resType.currency,
      num = data.cost,
      isLack = data.cost > L_ItemTplManager:getItemNum(L_Const.resType.currency, id) and self.isCanEquip
    }
    if data.cost > L_ItemTplManager:getItemNum(L_Const.resType.currency, id) and self.isCanEquip then
      self.isCanEquip = false
    end
  end
  table.insert(self.talentRuneTab, {
    id = L_Const.currencyType.gold,
    type = L_Const.resType.currency,
    num = self.needCost,
    iconLocalScale = C_Vector3(0.92, 0.92, 1),
    isLack = L_ItemTplManager:getItemNum(L_Const.resType.currency, L_Const.currencyType.gold) < self.needCost
  })
  runeCoinList:clear()
  runeCoinList:insert_array(self.talentRuneTab)
  if extraCost ~= nil and extraCost.itemNum ~= 0 then
    self.bind.active_extraItem = true
    local extraItemConfig = L_ItemTplManager:getItemConfig(extraCost.itemType, extraCost.itemId)
    self.bind.img_extraItemIcon = extraItemConfig.icon
    self.bind.img_extraBgQuality = string.format(qualityBgPath, extraItemConfig.quality + 1)
    local have = L_ItemTplManager:getItemNum(extraCost.itemType, extraCost.itemId)
    local numTxt = string.format("%s/%s", have, extraCost.itemNum)
    if have >= extraCost.itemNum then
      self.bind.txt_num = L_GameUtil.fillColor(numTxt, L_Const.colorHtml.white002)
    else
      self.bind.txt_num = L_GameUtil.fillColor(numTxt, L_Const.colorHtml.red005)
    end
  else
    self.bind.active_extraItem = false
  end
  self.extraCost = extraCost
end

function this:dealEquipBtn()
  if self.isNeedCompose then
    local option = {
      runeIds = self.runeList,
      slotIds = self.slotList,
      heroGuid = self._params.heroGuid
    }
    L_UI:open("pageHeroTalentAutoFill", option)
    return
  end
  local listMaterial = {}
  local slotList = self.slotList
  for i = 1, #self.runeList do
    local runeId = self.runeList[i]
    local listItem = L_RuneStore:getMaterialByRuneId(runeId)
    table.fill(listMaterial, listItem)
  end
  AzurWorld.heroMgr:ReqHeroRuneEquip(self._params.heroGuid, slotList, listMaterial, false, function(errCode, rspData)
    if errCode == L_Const.errorCode.ErrCodeSucc then
      L_AudioUtil.playSound("Play_SFX_System_UI_StarGift_Equip")
    end
  end)
  L_UI:close(self.pageName)
end

function this:refreshDetailLayout()
  if not self.isBind then
    return
  end
  local isSkillActive = self.bind.skillListActive
  local skillPaddingLeft = 134
  local twicePaddingLeft = 0
  if isSkillActive then
    self.bindComponents.detailLayout.padding.left = twicePaddingLeft
  else
    self.bindComponents.detailLayout.padding.left = skillPaddingLeft
  end
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.rectDetail)
end

function this:escHandle()
  if self._params.closeCallbackTemp then
    self._params.closeCallbackTemp()
  end
  if self._params.cancelCallback then
    self._params.cancelCallback()
  end
  L_UI:close(self.pageName)
end

return this

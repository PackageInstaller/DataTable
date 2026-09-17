local this = class("moduleTalentContent", G_UIModuleBase)
local talentRuneTpl = L_GameTpl:getTalentRuneTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local talentRankTpl = L_GameTpl:getTalentRankTpl()
local _talentRuneComposeTpl = L_GameTpl:getTalentRuneComposeTpl()
local qualityBgPath = "Assets/ResourcesAssets/UI/Atlas/CommonItem/tex_common_bg_quality_light_0%s.png"
local composeType = {
  normalCompose = 0,
  materialCompose = 1,
  forbidCompose = 2
}
local CurrencyNumType = {Two = 2, Three = 3}

function this.bind()
  return {
    runeNameText = "",
    attributeList = {
      moduleName = "pages/HeroPanel/hero/heroProperty"
    },
    skillDesList = {
      moduleName = "pages/HeroPanel/talent/cellSkillAddItem"
    },
    coinList2 = {
      moduleName = "pages/HeroPanel/talent/cellTalentRuneCoin"
    },
    coinList3 = {
      moduleName = "pages/HeroPanel/talent/cellTalentRuneCoin"
    },
    equipBtn = L_Const.ModuleInfo.ModuleBtn,
    active_coinGroup2 = false,
    active_coinGroup3 = false,
    active_lineGroup2 = false,
    active_lineGroup3 = false,
    equipBtnInteractable = true,
    jumpBtnActive = true,
    active_extraItem = false,
    active_txtNum = false,
    active_extraCost = false,
    img_extraItemIcon = "",
    img_extraBgQuality = "",
    txt_num = ""
  }
end

function this.methods()
  return {
    onClick_closeBtn = function(self)
      L_UI:close("pageHeroTalentInfo")
    end,
    onClick_showInfo = function(self)
      L_UI:open("pageRuneCompose", {
        canEquip = self.options.canEquip,
        currentRank = self.options.currentRank,
        heroGuid = self.options.heroGuid,
        isEquiped = self.options.isEquiped,
        runeId = self.options.runeId,
        slotId = self.options.slotId,
        itemId = self.itemId
      })
    end,
    onClick_extraCost = function(self)
      local extra = self.extraCost
      if table.isEmpty(extra) then
        return
      end
      local notShowAccess = self:GetSourceLuaPageOptions("notShowAccess")
      L_ItemTplManager:showInfoTip(extra.itemType, extra.itemId, nil, nil, notShowAccess)
    end
  }
end

function this:open()
  this.super.open(self)
  self.onEvent_itemRefreshHandle = handler(self, self.onEvent_ItemRefresh)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self.onEvent_itemRefreshHandle)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshAttr, self.onEvent_ItemRefresh, self)
end

function this:close()
  this.super.close(self)
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self.onEvent_itemRefreshHandle)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshAttr, self.onEvent_ItemRefresh, self)
  self.onEvent_itemRefreshHandle = nil
end

function this:onEvent_ItemRefresh()
  if self.options ~= nil then
    self:initPage(self.options)
  end
end

function this:initPage(options)
  self.options = options
  local runeTpl = talentRuneTpl:getTplById(self.options.runeId)
  self.itemId = talentRuneTpl:getRuneItem(runeTpl)
  local item = L_ItemTplManager:getCommonItem(self.itemId)
  self.bind.runeNameText = item.name
  self.needCost = talentRuneTpl:getEquipRuneThroughCoin(runeTpl)
  self.needRuneCosts = talentRuneTpl:getEquipRuneCoin(runeTpl)
  local extraCost = talentRuneTpl:getExtraCost(runeTpl)
  local txtName = ""
  local talentBtnName = L_WordsTpl:getValue("ui_hero_rune_equip")
  self.bLeafNode = _talentRuneComposeTpl:getIsLeafNode(self.itemId)
  self.CoinData = {}
  self.allCostMaterial = {}
  if table.isEmpty(extraCost) then
    self.extraCost = nil
  else
    self.extraCost = {
      itemType = extraCost[1][1],
      itemId = extraCost[1][2],
      itemNum = extraCost[1][3]
    }
  end
  self:initExtraCost()
  if self.options.isEquiped then
    self.isLackRune = false
    self.isLackGold = false
    self.isLackRuneCoin = false
    self.isLackExtra = false
  else
    self.isLackRune = C_BagMgr:getItemNumByItemId(self.itemId) <= 0
    self.isLackGold = self.needCost > L_PlayerStore:getCurrencyNum(L_Const.currencyType.gold)
    self.isLackRuneCoin = true
    for _, v in pairs(self.needRuneCosts) do
      local hadRuneCoin = v[2] > L_PlayerStore:getCurrencyNum(v[1])
      if hadRuneCoin == false then
        self.isLackRuneCoin = false
        break
      end
    end
    if table.isEmpty(self.extraCost) then
      self.isLackExtra = false
    else
      self.isLackExtra = self.extraCost.itemNum > L_ItemTplManager:getItemNum(self.extraCost.itemType, self.extraCost.itemId)
    end
  end
  for _, v in pairs(self.needRuneCosts) do
    table.insert(self.CoinData, {
      id = v[1],
      type = L_Const.resType.currency,
      num = v[2],
      isLack = v[2] > L_PlayerStore:getCurrencyNum(v[1])
    })
  end
  table.insert(self.CoinData, {
    id = L_Const.currencyType.gold,
    type = L_Const.resType.currency,
    num = self.needCost,
    isLack = self.needCost > L_PlayerStore:getCurrencyNum(L_Const.currencyType.gold)
  })
  if self.options.isEquiped then
    self.bind.active_extraItem = true
    self.bind.active_txtNum = true
    txtName = L_WordsTpl:getValue("ui_talent_detail_rune_state1")
  else
    self.bind.active_extraItem = true
    self.bind.active_txtNum = true
    if not self.isLackRune and not self.isLackGold and not self.isLackRuneCoin and not self.isLackExtra then
      self.composeType = composeType.normalCompose
      txtName = talentBtnName
    else
      self.bCanCompose = L_RuneStore:checkIsCanMaterialByRuneId(self.options.runeId)
      local isCanGetAll = self.bCanCompose
      if isCanGetAll then
        self.composeType = composeType.materialCompose
        txtName = L_WordsTpl:getValue("ui_character_rune_material_complete")
      else
        self.composeType = composeType.forbidCompose
        txtName = L_GameUtil.fillColor(talentBtnName, "#C0C0C0")
      end
    end
  end
  local attributes = talentRuneTpl:getRuneAttribute(runeTpl)
  local runeSkills = talentRuneTpl:getRuneSkill(runeTpl)
  self:initAttributeList(attributes)
  self:initRuneSkillList(runeSkills)
  local params = {
    txtName = txtName,
    callback = function()
      self:dealClickEquipBtn()
    end
  }
  self.modules.equipBtn:setData(params)
  local isGroup2 = #self.needRuneCosts + 1 == CurrencyNumType.Two
  if isGroup2 then
    self.bind.coinList2:clear()
    self.bind.coinList2:insert_array(self.CoinData)
    self.bind.active_coinGroup2 = true
    self.bind.active_coinGroup3 = false
    self.bind.active_lineGroup2 = true
    self.bind.active_lineGroup3 = false
  else
    self.bind.coinList3:clear()
    self.bind.coinList3:insert_array(self.CoinData)
    self.bind.active_coinGroup2 = false
    self.bind.active_coinGroup3 = true
    self.bind.active_lineGroup2 = false
    self.bind.active_lineGroup3 = true
  end
  self.bind.equipBtnInteractable = options.canEquip
  self.bind.jumpBtnActive = options.canEquip
end

function this:initExtraCost()
  if table.isEmpty(self.extraCost) then
    self.bind.active_extraCost = false
    return
  end
  self.bind.active_extraCost = true
  local extraType = self.extraCost.itemType
  local extraId = self.extraCost.itemId
  local extraNum = self.extraCost.itemNum
  local extraItemConfig = L_ItemTplManager:getItemConfig(extraType, extraId)
  self.bind.img_extraItemIcon = extraItemConfig.icon
  self.bind.img_extraBgQuality = string.format(qualityBgPath, extraItemConfig.quality + 1)
  local have = L_ItemTplManager:getItemNum(extraType, extraId)
  local numTxt = string.format("%s/%s", have, extraNum)
  if extraNum <= have then
    local colorStr = L_GameUtil.fillColor(numTxt, L_Const.colorHtml.white002)
    local numContent = L_WordsTpl:getValueParam("ui_hero_rune_extra_consumption", colorStr)
    self.bind.txt_num = numContent
  else
    local colorStr = L_GameUtil.fillColor(numTxt, L_Const.colorHtml.red005)
    local numContent = L_WordsTpl:getValueParam("ui_hero_rune_extra_consumption", colorStr)
    self.bind.txt_num = numContent
  end
end

function this:dealClickEquipBtn()
  if self.isBreak then
    return
  end
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.HeroRuneEquip))
    return
  end
  if self.composeType == composeType.normalCompose then
    local listMaterial = L_RuneStore:getMaterialByRuneId(self.options.runeId)
    AzurWorld.heroMgr:ReqHeroRuneEquip(self.options.heroGuid, {
      self.options.slotId
    }, listMaterial, false, function(errCode, rspData)
      if L_UI:checkPageOpen("pageHeroTalentInfo") then
        L_UI:close("pageHeroTalentInfo")
      end
      Timer.once(2, function()
        self.isBreak = false
      end)
      L_AudioUtil.playSound("Play_SFX_System_UI_StarGift_Equip")
    end)
    return
  elseif self.composeType == composeType.materialCompose then
    local option = {
      runeIds = {
        self.options.runeId
      },
      slotIds = {
        self.options.slotId
      },
      heroGuid = self.options.heroGuid
    }
    L_UI:open("pageHeroTalentAutoFill", option)
    return
  elseif self.composeType == composeType.forbidCompose then
    if self.isLackRune and (self.bLeafNode or self.bCanCompose == false) then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_hero_rune_lack_equip"))
      return
    end
    if self.isLackGold or self.isLackRuneCoin then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("residual_code_moduletalentcontent_01"))
      if self.isLackGold then
        L_ItemTplManager:showInfoTip(self.CoinData[#self.CoinData].type, self.CoinData[#self.CoinData].id)
        return
      end
      if self.isLackRuneCoin then
        local runeCoinTmp = {}
        for _, v in pairs(self.CoinData) do
          if v.isLack then
            table.insert(runeCoinTmp, {
              id = v.id,
              type = v.type
            })
          end
        end
        table.sort(runeCoinTmp, function(a, b)
          if a.id > b.id then
            return b
          end
        end)
        L_ItemTplManager:showInfoTip(runeCoinTmp[1].type, runeCoinTmp[1].id)
      end
      return
    end
    if self.isLackExtra then
      L_ItemTplManager:showInfoTip(self.extraCost.itemType, self.extraCost.itemId)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_hero_rune_extra_item_not_enough"))
      return
    end
  end
end

function this:initAttributeList(attributes)
  local propertyData = {}
  for i, v in pairs(attributes) do
    local strName = battleInfoTpl:getName(battleInfoTpl:getTplById(i))
    table.insert(propertyData, {
      active_icon = true,
      icon = battleInfoTpl:getIcon(battleInfoTpl:getTplById(i)),
      nextAttr = battleInfoTpl:getShowTxtComma(i, v),
      name = string.isEmpty(strName) and battleInfoTpl:getName(battleInfoTpl:getTplById(i)) or strName,
      id = i
    })
  end
  table.sort(propertyData, function(a, b)
    return a.id < b.id
  end)
  for i, v in ipairs(propertyData) do
    v.toggle_state = i % 2 == 0
  end
  self.bind.attributeList:clear()
  self.bind.attributeList:insert_array(propertyData)
end

function this:initRuneSkillList(runeSkills)
  self.bind.skillDesList:clear()
  local hero = L_HeroStore:getHero(self.options.heroGuid)
  local heroConfigId = L_HeroStore:getHeroConfigId(hero)
  local sysSkills = L_HeroManager:getHeroSystemSkillList(hero)
  local skillData = {}
  for _, skill in ipairs(runeSkills) do
    local level = self:getSlotLevel(heroConfigId, self.options.currentRank, skill[1])
    table.insert(skillData, {
      canEquip = self.options.canEquip,
      skillId = sysSkills[skill[1] + 1].skillId,
      currentLevel = level,
      addLevel = skill[2],
      heroGuid = self.options.heroGuid
    })
  end
  self.bind.skillDesList:insert_array(skillData)
end

function this:getSlotLevel(heroConifgId, currentRank, slot)
  local level = 1
  for rank = 1, currentRank - 1 do
    local rankTpl = talentRankTpl:getHeroRankTpl(heroConifgId, rank)
    local rankBreakItems = talentRankTpl:getRankBreakthroughItem(rankTpl)
    for k, runeId in ipairs(rankBreakItems) do
      local runeTpl = talentRuneTpl:getTplById(runeId)
      local runeSkills = talentRuneTpl:getRuneSkill(runeTpl)
      for _, skill in ipairs(runeSkills) do
        if skill[1] == slot then
          level = level + skill[2]
        end
      end
    end
  end
  return level
end

return this

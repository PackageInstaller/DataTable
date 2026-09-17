local this = class("cellSettleExp", G_UIModuleBase)
local _heroLevelTpl = L_GameTpl:getHeroLevelTpl()
local _petLevelTpl = L_GameTpl:getPetLevelTpl()
local talentRankTpl = L_GameTpl:getTalentRankTpl()
local _heroFavorabilityExpTpl = L_GameTpl:getHeroFavorabilityExpTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    img_hero = nil,
    txt_hero_level = "",
    txt_hero_levelFX = "",
    txt_hero_exp = "",
    fill_amount_hero_exp = 0,
    go_pet = false,
    img_pet = nil,
    txt_pet_level = "",
    txt_pet_exp = "",
    fill_amount_pet_exp = 0,
    alpha_canvasGroup = 0,
    go_favorAbility = false
  }
end

function this.methods()
  return {}
end

function this:open(options)
  this.super.open(self, options)
  self.doTweenMap = {}
end

function this:close(options)
  this.super.close(self, options)
  L_PhotoManager:clearPhotoEntity(self)
  self:closeDOTween()
  L_TimerManager:clearTimer(self)
end

function this:playShowAni()
  self.bind.alpha_canvasGroup = 0
  local delayTime = self.bind.index * 0.066
  L_TimerManager:newOrResetTimer(self, "initAni", function()
    self.bind.alpha_canvasGroup = 1
    self.bindComponents.ani_cellSettleExp:Stop()
    self.bindComponents.ani_cellSettleExp:Play("anim_pagereward_cell_in")
    self:initCell()
  end, delayTime)
end

function this:initCell()
  local heroServerData = L_HeroStore:getHero(self.bind.heroId)
  local heroConfig = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroServerData))
  self.bind.img_hero = heroConfig.icon
  if self.bind.heroId == L_HeroStore:getDefaultHeroGuid() then
    L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.img_head, L_PlayerStore:getPlayerModHeadImgName())
  else
    L_PhotoManager:clearPhotoEntity(self)
  end
  local startData = L_BattleStore:getHeroCacheData()
  if not startData then
    return
  end
  local serverDataStart = startData.heros[self.bind.heroId]
  self:setHeroExpFill(L_HeroStore:getHeroLevel(serverDataStart), L_HeroStore:getHeroExp(serverDataStart))
  self.bind.txt_hero_exp = ""
  L_TimerManager:newOrResetTimer(self, "heroExpFX", function()
    self:playHeroExpFX()
  end, 0.66)
  self.bind.go_pet = not math.isEmpty(L_HeroStore:getHeroPetGuid(heroServerData))
  if not math.isEmpty(L_HeroStore:getHeroPetGuid(heroServerData)) then
    self:initPet()
  end
end

function this:playHeroExpFX()
  local startData = L_BattleStore:getHeroCacheData()
  if not startData then
    return
  end
  local serverDataStart = startData.heros[self.bind.heroId]
  local serverDataEnd = L_HeroStore:getHero(self.bind.heroId)
  local levelStart = L_HeroStore:getHeroLevel(serverDataStart)
  local levelEnd = L_HeroStore:getHeroLevel(serverDataEnd)
  local expSumStart = _heroLevelTpl:getExpSumToCurLevel(levelStart) + L_HeroStore:getHeroExp(serverDataStart)
  local expSumEnd = _heroLevelTpl:getExpSumToCurLevel(levelEnd) + L_HeroStore:getHeroExp(serverDataEnd)
  local time_stage1 = 0
  if levelStart < levelEnd then
    local exp_tmp = _heroLevelTpl:getExp(_heroLevelTpl:getTplById(levelStart))
    local expSum_tmp = _heroLevelTpl:getExpSumToCurLevel(levelStart + 1)
    time_stage1 = 0.66 * ((expSum_tmp - expSumStart) / exp_tmp)
    self:createFXDOTween("heroExpStage1", time_stage1, expSumStart, expSum_tmp, Tweening.Ease.InOutCubic, function()
      if levelEnd > levelStart + 1 then
        self.bindComponents.ani_content:Stop()
        self.bindComponents.ani_content:Play("anim_pagereward_exp_levelup2")
      end
    end)
    if levelEnd > levelStart + 1 then
      time_stage1 = time_stage1 + 0.198
    end
  end
  local time_stage2 = 0
  if 2 <= levelEnd - levelStart then
    for i = levelStart + 1, levelEnd - 2 do
      local name = string.concat("heroExpStage2_", i)
      local startExpSum = _heroLevelTpl:getExpSumToCurLevel(i)
      local endExpSum = _heroLevelTpl:getExpSumToCurLevel(i + 1)
      L_TimerManager:newOrResetTimer(self, name, function()
        self:createFXDOTween(name, 0.165, startExpSum, endExpSum, Tweening.Ease.InOutSine, function()
          self.bindComponents.ani_content:Stop()
          self.bindComponents.ani_content:Play("anim_pagereward_exp_levelup2")
        end)
      end, time_stage1 + time_stage2)
      time_stage2 = time_stage2 + 0.165 + 0.198
    end
    local name = string.concat("heroExpStage2_", levelEnd - 1)
    local startExpSum = _heroLevelTpl:getExpSumToCurLevel(levelEnd - 1)
    local endExpSum = _heroLevelTpl:getExpSumToCurLevel(levelEnd)
    L_TimerManager:newOrResetTimer(self, name, function()
      self:createFXDOTween(name, 0.165, startExpSum, endExpSum, Tweening.Ease.InOutSine)
    end, time_stage1 + time_stage2)
    time_stage2 = time_stage2 + 0.165
  end
  local time_stage3 = 0
  if levelStart < levelEnd then
    L_TimerManager:newOrResetTimer(self, "heroExpStage3_ani", function()
      self.bindComponents.ani_content:Stop()
      self.bindComponents.ani_content:Play("anim_pagereward_exp_levelup")
    end, time_stage1 + time_stage2 + time_stage3)
    time_stage3 = time_stage3 + 1.815
  end
  L_TimerManager:newOrResetTimer(self, "heroExpStage3_doTween", function()
    local expSumStart_tmp = levelEnd > levelStart and _heroLevelTpl:getExpSumToCurLevel(levelEnd) or expSumStart
    self:createFXDOTween("heroExpStage3_doTween", 0.66, expSumStart_tmp, expSumEnd, Tweening.Ease.OutQuart, function()
      self.parent:delayClosePage()
    end)
    self:playHeroFavorAbilityFX()
  end, time_stage1 + time_stage2 + time_stage3)
end

function this:playHeroFavorAbilityFX()
  if self.bind.heroId == L_HeroStore:getDefaultHeroGuid() then
    return
  end
  local reward = L_BattleStore:getParseBattleReward()
  local favorAbility = reward[L_Const.resType.currency][L_Const.currencyType.favorabilityDailyByFight]
  if not table.isEmpty(favorAbility) then
    self.bind.go_favorAbility = true
    local serverData = L_HeroStore:getHero(self.bind.heroId)
    local curLevel = L_HeroStore:getHeroFavorAbilityLevel(serverData)
    local isFavorabilityMax = curLevel >= _heroFavorabilityExpTpl:getMaxFavorabilityLevel()
    if isFavorabilityMax then
      self.bindComponents.ani_favorability:Play("anim_pagereward_facorabilitymax")
    else
      self.bindComponents.ani_favorability:Play("anim_pagereward_facorability")
    end
  end
end

function this:initPet()
  local petId = L_HeroStore:getHeroPetGuid(L_HeroStore:getHero(self.bind.heroId))
  local petServerData = L_PetStore:getPetItem(petId)
  local configData = L_ItemTplManager:getPetItem(petServerData.id, petServerData:isSpecialPet())
  self.bind.img_pet = configData.icon
  local startData = L_BattleStore:getHeroCacheData()
  local serverDataStart = startData.pets[petId]
  self:setPetExpFill(serverDataStart.lv, serverDataStart.exp)
  self.bind.txt_pet_exp = ""
  L_TimerManager:newOrResetTimer(self, "petExpFX", function()
    self:playPetExpFX()
  end, 0.66)
end

function this:playPetExpFX()
  local startData = L_BattleStore:getHeroCacheData()
  local petId = L_HeroStore:getHeroPetGuid(L_HeroStore:getHero(self.bind.heroId))
  local serverDataStart = startData.pets[petId]
  local serverDataEnd = L_PetStore:getPetItem(petId)
  local expSumStart = _petLevelTpl:getExpSumToCurLevel(serverDataStart.lv) + serverDataStart.exp
  local expSumEnd = _petLevelTpl:getExpSumToCurLevel(serverDataEnd.lv) + serverDataEnd.exp
  local petExp = expSumEnd - expSumStart
  
  local function getter()
    return expSumStart
  end
  
  local function setter(r)
    local level, exp = _petLevelTpl:getLevelAndExpByExpSum(r)
    self:setPetExpFill(level, exp)
    local addNum = math.ceil(petExp - (expSumEnd - r))
    self.bind.txt_pet_exp = math.isEmpty(addNum) and "" or tostring(addNum)
  end
  
  self.doTweenPet = DOTween.To(getter, setter, expSumEnd, 0.66)
  self.doTweenPet:SetEase(Tweening.Ease.OutQuart)
end

function this:createFXDOTween(name, time, startValue, endValue, curveType, endDo)
  local startData = L_BattleStore:getHeroCacheData()
  local serverDataStart = startData.heros[self.bind.heroId]
  local serverDataEnd = L_HeroStore:getHero(self.bind.heroId)
  local levelStart = L_HeroStore:getHeroLevel(serverDataStart)
  local levelEnd = L_HeroStore:getHeroLevel(serverDataEnd)
  local expSumStart = _heroLevelTpl:getExpSumToCurLevel(levelStart) + L_HeroStore:getHeroExp(serverDataStart)
  local expSumEnd = _heroLevelTpl:getExpSumToCurLevel(levelEnd) + L_HeroStore:getHeroExp(serverDataEnd)
  local expAdd = expSumEnd - expSumStart
  
  local function getter()
    return startValue
  end
  
  local function setter(r)
    local level, exp = _heroLevelTpl:getLevelAndExpByExpSum(r)
    self:setHeroExpFill(level, exp)
    local addNum = math.ceil(expAdd - (expSumEnd - r))
    self.bind.txt_hero_exp = math.isEmpty(addNum) and "" or tostring(addNum)
  end
  
  self.doTweenMap[name] = DOTween.To(getter, setter, endValue, time)
  self.doTweenMap[name].onComplete = endDo
  self.doTweenMap[name]:SetEase(curveType)
end

function this:setHeroExpFill(level, exp)
  local serverData = L_HeroStore:getHero(self.bind.heroId)
  local tpl_rank = talentRankTpl:getHeroRankTpl(L_HeroStore:getHeroConfigId(serverData), L_HeroStore:getHeroRank(serverData))
  local levelLimit = talentRankTpl:getRankLevelLimit(tpl_rank)
  level = math.clamp(level, 1, levelLimit)
  local isMaxLevel = levelLimit == level
  local tpl_heroLevel = _heroLevelTpl:getTplById(level)
  local maxExp = _heroLevelTpl:getExp(tpl_heroLevel)
  self.bind.fill_amount_hero_exp = isMaxLevel and 1 or exp / maxExp
  local levelStr = tostring(level)
  self.bind.txt_hero_level = levelStr
  self.bind.txt_hero_levelFX = "Lv." .. levelStr
end

function this:setPetExpFill(level, exp)
  local tpl_heroLevel = _petLevelTpl:getTplById(level)
  local maxExp = _petLevelTpl:getExp(tpl_heroLevel)
  self.bind.fill_amount_pet_exp = exp / maxExp
  self.bind.txt_pet_level = tostring(level)
end

function this:closeDOTween()
  for i, v in pairs(self.doTweenMap) do
    if L_CommonUtil.isValid(v) then
      v:Kill()
      v = nil
    end
  end
end

return this

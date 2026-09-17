local this = class("heroPreviewProperty", G_UIModuleBase)
local _heroLevelTpl = L_GameTpl:getHeroLevelTpl()
local talentRankTpl = L_GameTpl:getTalentRankTpl()
local battleInfoTpl = L_GameTpl:getBattleInfoTpl()
local heroTpl = L_GameTpl:getHeroTpl()
local changeAnimationName = {
  Change0 = "Change0",
  Change1 = "Change1",
  Change2 = "Change2"
}

function this.bind()
  return {
    currentLv = "",
    shadowCurrentLv = "",
    exp = "0",
    curLvExp = "0",
    lvSlider = 0,
    rankIcon = "",
    propertyListLayoutActive = false,
    propertyLayoutActive = false,
    heroPropertyItem = {
      moduleName = "pages/Pet/cellAttrItem"
    },
    propertyList = {
      moduleName = "pages/Pet/cellAttrItem"
    },
    breakSkillList = {
      moduleName = "pages/HeroPanel/hero/cellBreakSkill"
    },
    dotActive = true,
    limitMaxTipsActive = false,
    txt_limitMaxLabel = "",
    maxTipsActive = false,
    maxLabelActive = false,
    expAreaActive = true
  }
end

function this.methods()
  return {}
end

function this:setHeroInfo(data)
  local attId = battleInfoTpl:getShowTypeLvUpAttrs()
  local lv = data.lv
  local exp = data.exp
  local addExp = data.addExp
  local rank = data.rank
  local isShowBreakSkill = data.isShowBreakSkill
  local isShowAnim = data.isShowAnim
  self.showListBg = true
  self.bind.maxTipsActive = false
  self.bind.maxLabelActive = false
  self.bind.expAreaActive = true
  if isShowBreakSkill == nil then
    isShowBreakSkill = false
  end
  self.bind.propertyLayoutActive = isShowBreakSkill
  self.bind.propertyListLayoutActive = not isShowBreakSkill
  self.bind.advancedLevelActive = isShowBreakSkill
  self:setBreakSkillList(isShowBreakSkill)
  local hero = self.parent:getHero()
  local heroId = self.parent:getHeroId()
  local heroLevel = L_HeroStore:getHeroLevel(hero)
  local heroRank = L_HeroStore:getHeroRank(hero)
  local limitMaxLv = _heroLevelTpl:getMaxLvByCondition()
  local maxLv = _heroLevelTpl:getMaxLv()
  local property = {}
  local heroConfigAtt = L_AttributeManager:parseHeroConfigAtt(heroId, lv)
  local beforeRunes = L_HeroStore:getHeroRuneIds(hero)
  local afterRunes = {}
  if rank == heroRank then
    afterRunes = L_HeroStore:getHeroRuneIds(hero)
  end
  local heroStarConfigAtt = L_HeroManager:getHeroStarGiftByHeroIdAndRank(L_HeroStore:getHeroConfigId(hero), rank, afterRunes)
  local mergeAttr = L_AttributeManager:mergeAttDic(heroConfigAtt, heroStarConfigAtt)
  local baseAtt = {}
  for _, v in pairs(attId) do
    local _, value = L_AttributeManager:getHeroAttValue(mergeAttr, v)
    property[v] = value
    baseAtt[v] = true
  end
  for i, v in pairs(heroStarConfigAtt) do
    local group, value = L_AttributeManager:getHeroAttValue(mergeAttr, i)
    if not baseAtt[group] then
      property[group] = value
    end
  end
  local propertyHeroLv = {}
  heroConfigAtt = L_AttributeManager:parseHeroConfigAtt(heroId, heroLevel)
  heroStarConfigAtt = L_HeroManager:getHeroStarGiftByHeroIdAndRank(L_HeroStore:getHeroConfigId(hero), heroRank, beforeRunes)
  mergeAttr = L_AttributeManager:mergeAttDic(heroConfigAtt, heroStarConfigAtt)
  for _, v in pairs(attId) do
    local _, value = L_AttributeManager:getHeroAttValue(mergeAttr, v)
    propertyHeroLv[v] = value
  end
  for i, _ in pairs(mergeAttr) do
    local group, value = L_AttributeManager:getHeroAttValue(mergeAttr, i)
    if not baseAtt[group] then
      propertyHeroLv[group] = value
    end
  end
  local expStr = tostring(exp)
  local curLvStr = self:lvChange(lv)
  self.plainLevelText = curLvStr
  if lv >= maxLv then
    self.bind.lvSlider = 0
    expStr = tostring(0)
    expStr = L_GameUtil.fillColor(expStr, L_Const.colorHtml.grey003)
    self.bind.curLvExp = tostring(_heroLevelTpl:getExp(_heroLevelTpl:getTplById(lv)))
  elseif lv >= limitMaxLv then
    self.bind.lvSlider = 1
    expStr = tostring(0)
    expStr = L_GameUtil.fillColor(expStr, L_Const.colorHtml.grey003)
    self.bind.curLvExp = tostring(_heroLevelTpl:getExp(_heroLevelTpl:getTplById(lv)))
  else
    self.bind.curLvExp = tostring(_heroLevelTpl:getExp(_heroLevelTpl:getTplById(lv)))
    self.bind.lvSlider = self:sliderChange(exp / _heroLevelTpl:getExp(_heroLevelTpl:getTplById(lv)))
  end
  if addExp <= 0 then
    expStr = L_GameUtil.fillColor(expStr, L_Const.colorHtml.grey003)
  end
  if lv > heroLevel then
    curLvStr = L_GameUtil.fillColor(curLvStr, L_Const.colorHtml.blue001)
  end
  self.bind.exp = expStr
  self.curLvStr = curLvStr
  if not isShowAnim then
    self.bind.currentLv = curLvStr
  end
  self.bind.heroPropertyItem:clear()
  self.bind.propertyList:clear()
  local propertyData = {}
  local previewAttId = {}
  for i, v in ipairs(attId) do
    table.insert(previewAttId, v)
  end
  if rank ~= heroRank then
    for i, v in pairs(property) do
      if not baseAtt[i] then
        table.insert(previewAttId, i)
      end
    end
  end
  for _, v in ipairs(previewAttId) do
    local currentProperty = property[v] or 0
    local currentPropertyHeroLv = propertyHeroLv[v] or 0
    local addNum = currentProperty - currentPropertyHeroLv
    local tpl = battleInfoTpl:getTplById(v)
    local value = battleInfoTpl:getShowTxtComma(v, currentPropertyHeroLv)
    local addValueText = value
    local showAddBg = false
    if 0 < addNum then
      showAddBg = true
      addValueText = battleInfoTpl:getShowTxtComma(v, currentProperty)
    else
    end
    if rank == heroRank then
      local item = {
        attrIcon = battleInfoTpl:getIcon(tpl),
        value = value,
        name = battleInfoTpl:getName(tpl),
        currentValue = currentPropertyHeroLv,
        addValue = addNum,
        showId = v,
        addValueText = addValueText,
        showAddBg = showAddBg
      }
      table.insert(propertyData, item)
    end
  end
  if isShowBreakSkill then
    self.bind.heroPropertyItem:insert_array(propertyData)
  else
    self.bind.propertyList:insert_array(propertyData)
  end
  local rankCfg = talentRankTpl:getMaxTpl(L_HeroStore:getHeroConfigId(hero))
  local maxRank = talentRankTpl:getRank(rankCfg)
  self.bind.dotActive = true
  self.bind.maxTipsActive = heroLevel >= maxLv
  self.bind.maxLabelActive = lv >= maxLv
  self.bind.limitMaxTipsActive = heroLevel >= limitMaxLv and heroLevel < maxLv
  if self.bind.limitMaxTipsActive then
    self.bind.txt_limitMaxLabel = L_WordsTpl:getValue("ui_text_hero_level_up_limit", {
      [0] = L_GameUtil.fillColor(_heroLevelTpl:getStarLvCondition(lv), "#FFA200")
    })
    self.parent.parent.bindComponents.switchAnimator:SetBool("LvLimit", true)
  else
    self.parent.parent.bindComponents.switchAnimator:SetBool("LvLimit", false)
  end
  self.bind.expAreaActive = not self.bind.maxLabelActive and not self.bind.limitMaxTipsActive
  if heroLevel >= maxLv and heroRank >= maxRank then
    self.bind.lvSlider = self:sliderChange(1)
  end
end

function this:setBreakSkillList(isShowBreakSkill)
  self.bind.breakSkillList:clear()
  if not isShowBreakSkill then
    return
  end
  local hero = self.parent:getHero()
  local heroRank = L_HeroStore:getHeroRank(hero)
  local rankLv = talentRankTpl:getHeroRankTpls(L_HeroStore:getHeroConfigId(hero))
  local maxLv = rankLv[L_HeroStore:getHeroRank(hero)].rankLevelLimit
  local heroLevel = L_HeroStore:getHeroLevel(hero)
  if maxLv < heroRank + 1 then
    return
  end
  local lv = L_HeroManager:lvChange(heroLevel)
  self.bind.currentLimit = "Lv." .. lv .. "/" .. L_HeroManager:lvChange(rankLv[heroRank].rankLevelLimit)
  self.bind.advanceLimit = "Lv." .. lv .. "/" .. L_HeroManager:lvChange(rankLv[heroRank + 1].rankLevelLimit)
  local rankTpl = rankLv[heroRank + 1]
  if not rankTpl then
    return
  end
  local breakListData = {}
  for _, skillId in ipairs(rankTpl.skill) do
    table.insert(breakListData, {
      skillId = skillId,
      bgActive = self.showListBg
    })
    self.showListBg = not self.showListBg
  end
  self.bind.breakSkillList:insert_array(breakListData)
  local posYMap = {
    -22,
    0,
    17
  }
  local y = 0
  if posYMap[#breakListData + 1] ~= nil then
    y = posYMap[#breakListData + 1]
  end
  self.bind.advancedLevelAnchorPos = C_Vector2(0, y)
end

function this:lvChange(lv)
  return string.format("%02d", lv)
end

function this:sliderChange(value)
  return value
end

function this:getChangeAnimator()
  return self.bindComponents.changeAnimator
end

function this:getChangeAnimatorHandler()
  return handler(self, self.onChangeAnimatorHandler)
end

function this:close()
  self:destoryLevelUpEffect()
end

function this:destoryLevelUpEffect()
  if L_CommonUtil.isValid(self.levelUpEffect) then
    C_GameObject.DestroyImmediate(self.levelUpEffect.gameObject)
    self.levelUpEffect = nil
  end
  if self.disposeEffectTimer ~= nil then
    Timer.remove(self.disposeEffectTimer)
    self.disposeEffectTimer = nil
  end
end

function this:playLevelUpEffect()
  self:destoryLevelUpEffect()
  local effectPath = "Effect/Battle/Common/pre_common_level_up.prefab"
  local heroActor = C_PageHeroPipelineBridge.GetCurrentHero().m_actor
  if heroActor ~= nil and L_CommonUtil.isValid(heroActor) then
    L_ResPool:asyncGameObject(effectPath, function(id, go)
      self.levelUpEffect = go
      local EffectMaterialHelperCom = go.transform:GetComponentInChildren(typeof(CS.EffectMaterialHelper))
      if EffectMaterialHelperCom then
        EffectMaterialHelperCom.characterRoot = heroActor
      end
      local ImmuneBuffHelperCom = go.transform:GetComponentInChildren(typeof(CS.ImmuneBuffHelper))
      if ImmuneBuffHelperCom then
        ImmuneBuffHelperCom.characterRoot = heroActor
      end
      local levelUpTrans = self.levelUpEffect.transform
      levelUpTrans:SetParent(heroActor.transform)
      local hero = self.parent:getHero()
      local heroConfigId = L_HeroStore:getHeroConfigId(hero)
      local heroGuid = L_HeroStore:getHeroGuid(hero)
      local clothingId = AzurWorld.heroMgr:GetUsingClothingId(heroGuid, heroConfigId)
      local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
      local clothingData = heroClothingTpl:getTplById(clothingId)
      local p = clothingData.levelUpParam
      local pos = {
        x = p[1],
        y = p[2],
        z = p[3]
      }
      L_CommonUtil.setObjActive(go, false)
      L_CommonUtil.setObjActive(go, true)
      L_Vector3.setLocalPos(levelUpTrans, L_Vector3.new(pos.x, pos.y, pos.z))
      L_Vector3.setLocalRot(levelUpTrans, L_Vector3.zero)
      self.disposeEffectTimer = Timer.once(0.9, function()
        self:destoryLevelUpEffect()
      end, self)
    end)
  end
end

function this:onChangeAnimatorHandler(aniName, targetLevel, beforeLevel)
  if changeAnimationName[aniName] then
    self.bindComponents.changeAnimator:SetTrigger(aniName)
  end
  local hero = self.parent:getHero()
  local heroLevel = L_HeroStore:getHeroLevel(hero)
  targetLevel = targetLevel or heroLevel
  beforeLevel = beforeLevel or heroLevel
  if aniName == changeAnimationName.Change0 then
    self.bind.shadowCurrentLv = self.plainLevelText
    FrameScheduler.add(function()
      self.bind.currentLv = L_GameUtil.fillColor(self.curLvStr, L_Const.colorHtml.grey001)
    end, 1)
  end
  if aniName == changeAnimationName.Change1 then
    self.bind.currentLv = self.curLvStr
    
    local function getter()
      return beforeLevel
    end
    
    local function setter(v)
      self.bind.shadowCurrentLv = tostring(math.ceil(v))
    end
    
    self._doTween = DOTween.To(getter, setter, targetLevel - 1, 0.6)
    self._doTween:SetEase(Tweening.Ease.OutQuad)
    Timer.once(0.63, function()
      self.bind.shadowCurrentLv = tostring(targetLevel)
    end, self)
    Timer.once(0.5, function()
      self:playLevelUpAnim()
    end, self)
    Timer.once(0.757, function()
      self:playLevelUpEffect()
    end, self)
  end
  if aniName == changeAnimationName.Change2 then
    self.bind.currentLv = self.curLvStr
    self.bind.shadowCurrentLv = self.plainLevelText
    Timer.once(0.1, function()
      self:playLevelUpAnim()
    end, self)
    Timer.once(0.361, function()
      self:playLevelUpEffect()
    end, self)
  end
end

function this:playLevelUpAnim()
  for i = 1, #self.bind.propertyList do
    local propertyCell = self.bind.propertyList:getItemCls(i)
    if propertyCell then
      propertyCell:playLevelUpAni(i)
    end
  end
end

function this:resetShadowLv()
  self.bind.shadowCurrentLv = ""
end

return this

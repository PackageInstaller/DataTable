local UINHeroTalentDetailNode = class("UINHeroTalentDetailNode", UIBaseNode)
local base = UIBaseNode
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")
local UINHeroTalentNodeDetailEffect = require("Game.HeroTalent.UI.UINHeroTalentNodeDetailEffect")
local UINHeroTalentNodeDetailCost = require("Game.HeroTalent.UI.UINHeroTalentNodeDetailCost")
local UINHeroTalentNodeDetailCondition = require("Game.HeroTalent.UI.UINHeroTalentNodeDetailCondition")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINHeroTalentBranch = require("Game.HeroTalent.UI.UINHeroTalentBranch")
local attrIdOffset = ConfigData.buildinConfig.AttrIdOffset

function UINHeroTalentDetailNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Upgrade, self, self.OnClickTalentLvUp)
  self._effectPool = UIItemPool.New(UINHeroTalentNodeDetailEffect, self.ui.attItem)
  self.ui.attItem:SetActive(false)
  self._costPool = UIItemPool.New(UINHeroTalentNodeDetailCost, self.ui.consumeItem)
  self.ui.consumeItem:SetActive(false)
  self._condition = UIItemPool.New(UINHeroTalentNodeDetailCondition, self.ui.conditionItem)
  self.ui.conditionItem:SetActive(false)
  self._rewardPool = UIItemPool.New(UINBaseItemWithCount, self.ui.rewardItem)
  self.ui.rewardItem:SetActive(false)
  self._branchPool = UIItemPool.New(UINHeroTalentBranch, self.ui.tog_Item)
  self.ui.tog_Item:SetActive(false)
  self.__OnClickBranchSelectListenCallback = BindCallback(self, self.__OnClickBranchSelectListen)
  self.defaultBtnColor = self.ui.img_Upgrade.color
end

function UINHeroTalentDetailNode:BindLvUpClickCallback(lvUpClickFunc)
  self._lvUpClickFunc = lvUpClickFunc
end

function UINHeroTalentDetailNode:BindBranchCallback(branchClickFunc)
  self._branchClickFunc = branchClickFunc
end

function UINHeroTalentDetailNode:UpdateHeroTalentDetailNode(talentNode)
  self._talentNode = talentNode
  self.ui.tex_TalentName.text = LanguageUtil.GetLocaleText(self._talentNode:GetHeroTalentNodeCfg().name)
  self:RefreshHeroTalentDetailUI()
end

function UINHeroTalentDetailNode:RefreshHeroTalentDetailUI()
  self._effectPool:HideAll()
  self._costPool:HideAll()
  self._condition:HideAll()
  self._rewardPool:HideAll()
  self._branchPool:HideAll()
  self:__RefreshTalentDescDes()
  self:__RefreshAttriDes()
  self.ui.isMax:SetActive(false)
  self.ui.lvUp:SetActive(false)
  self.ui.condition:SetActive(false)
  self.ui.togGroup:SetActive(false)
  self:__RefreshBranch()
  if self._talentNode:IsHeroTalentNodeMaxLevel() then
    self.ui.isMax:SetActive(true)
  elseif not self._talentNode:IsHeroTalentNodeUnlock() then
    self:__RefreshLockState()
  else
    self:__RefreshCostState()
  end
end

function UINHeroTalentDetailNode:__RefreshTalentDescDes()
  self.ui.tex_TalentDesc.gameObject:SetActive(false)
  local effectCfg = self._talentNode:GetHeroTalentNodeCurLevelEffect()
  if effectCfg == nil then
    effectCfg = self._talentNode:GetHeroTalentNodeNexLevelEffect()
  end
  local talentDesc = LanguageUtil.GetLocaleText(effectCfg.text_context) .. "\n"
  for i, skillId in ipairs(effectCfg.skill_list) do
    local battleSkill = DynBattleSkill.New(effectCfg.skill_list[skillId], 1)
    talentDesc = talentDesc .. tostring(battleSkill:GetLevelDescribe(1, false, false)) .. "\n"
  end
  if effectCfg.energy_return > 0 then
    talentDesc = talentDesc .. string.format(ConfigData:GetTipContent(5070), tostring(FormatNum(effectCfg.energy_return / 10)) .. "%")
  end
  for areaId, spceAdd in ipairs(effectCfg.algorithm_space) do
    if 0 < spceAdd then
      talentDesc = talentDesc .. "\n" .. string.format(ConfigData:GetTipContent(5079), LanguageUtil.GetLocaleText(ConfigData.ath_area[areaId].name2), tostring(spceAdd))
    end
  end
  for i, logicId in ipairs(effectCfg.logic) do
    local longDes, _, _ = CommonLogicUtil.GetDesString(logicId, effectCfg.para1[i], effectCfg.para2[i], effectCfg.para2[i])
    talentDesc = talentDesc .. "\n" .. longDes
  end
  if not string.IsNullOrEmpty(talentDesc) then
    self.ui.tex_TalentDesc.gameObject:SetActive(true)
    self.ui.tex_TalentDesc.text = talentDesc
  end
end

function UINHeroTalentDetailNode:__RefreshAttriDes()
  local attributeUpDic = self._talentNode:GetTalentNextLvAttriDescrib()
  local curEffect = self._talentNode:GetHeroTalentNodeCurLevelEffect()
  local nextEffect = self._talentNode:GetHeroTalentNodeNexLevelEffect()
  if attributeUpDic ~= nil then
    for attriId, info in pairs(attributeUpDic) do
      local item = self._effectPool:GetOne()
      local showColor
      if attriId > attrIdOffset and attriId < attrIdOffset * 2 then
        showColor = self.ui.baseAttrColor
      end
      item:RefreshDetailEffectByAttriId(attriId, info.cur, info.next, true, showColor)
    end
  end
  local curEnergyReturn = curEffect ~= nil and curEffect.energy_return or 0
  local nextEnergyReturn = nextEffect ~= nil and nextEffect.energy_return or nil
  if 0 < curEnergyReturn or 0 < (nextEnergyReturn or 0) then
    local curStr = tostring(FormatNum(curEnergyReturn / 10)) .. "%"
    local nextStr = nextEnergyReturn ~= nil and tostring(FormatNum(nextEnergyReturn / 10)) .. "%" or nil
    local item = self._effectPool:GetOne()
    item:RefreshDetailEffect(ConfigData:GetTipContent(5078), curStr, nextStr, ConfigData.game_config.heroTalentEnergyRetuenIcon)
  end
  for areaId, cfg in ipairs(ConfigData.ath_area) do
    local curAdd = curEffect ~= nil and curEffect.algorithm_space[areaId] or nil
    local nextAdd = nextEffect ~= nil and nextEffect.algorithm_space[areaId] or nil
    if (curAdd or 0) ~= (nextAdd or 0) then
      local item = self._effectPool:GetOne()
      curAdd = tostring(curAdd or 0)
      nextAdd = nextAdd ~= nil and tostring(nextAdd) or nil
      item:RefreshDetailEffect(string.format(ConfigData:GetTipContent(5080), LanguageUtil.GetLocaleText(cfg.name2)), curAdd, nextAdd)
    end
  end
  local logicList, attrIdList
  if curEffect == nil then
    logicList = CommonLogicUtil:GetDesAboutLvDiff(nil, nil, nil, nil, nextEffect.logic, nextEffect.para1, nextEffect.para2, nextEffect.para3)
    attrIdList = nextEffect.para1
  elseif nextEffect == nil then
    logicList = CommonLogicUtil:GetDesAboutLvDiff(curEffect.logic, curEffect.para1, curEffect.para2, curEffect.para3, nil, nil, nil, nil)
    attrIdList = curEffect.para1
  else
    logicList = CommonLogicUtil:GetDesAboutLvDiff(curEffect.logic, curEffect.para1, curEffect.para2, curEffect.para3, nextEffect.logic, nextEffect.para1, nextEffect.para2, nextEffect.para3)
    attrIdList = curEffect.para1
  end
  if logicList ~= nil and 0 < #logicList then
    for i, desTable in ipairs(logicList) do
      local item = self._effectPool:GetOne()
      item:RefreshDetailEffect(desTable.currentInfo, desTable.curValue, desTable.nextInfoValue, ConfigData.game_config.heroTalentTeamAttrIconDic[attrIdList[i]])
    end
  end
  self.ui.attNode:SetActive(0 < #self._effectPool.listItem)
end

function UINHeroTalentDetailNode:__RefreshBranch()
  local flag, selectId = self._talentNode:GetHeroTalentNodeBranchId()
  local branchList = self._talentNode:GetTalentNextLvBranchAttriDescrib()
  if branchList == nil then
    return
  end
  self.ui.togGroup:SetActive(true)
  for i, attrDiffDic in ipairs(branchList) do
    for attrid, diffval in pairs(attrDiffDic) do
      local item = self._branchPool:GetOne()
      item:InitHeroTalentBranch(i, attrid, diffval.cur, diffval.next, self.__OnClickBranchSelectListenCallback)
      item:SetTalentBranckSelectState(selectId)
      item:SetTalentBranckActiveState(flag)
      break
    end
  end
end

function UINHeroTalentDetailNode:__RefreshLockState()
  self.ui.condition:SetActive(true)
  local list = self._talentNode:GetHeroTalentNodeLockDesList()
  for _, info in ipairs(list) do
    local item = self._condition:GetOne()
    item:RefreshDetailCondition(info.lockReason, info.unlock)
  end
end

function UINHeroTalentDetailNode:__RefreshCostState()
  self.ui.img_Upgrade.color = self._talentNode:IsHeroTalentNodeCanLeveUp() and self.defaultBtnColor or self.ui.color_unclick
  self.ui.lvUp:SetActive(true)
  local rewardIds, rewardCounts = self._talentNode:GetHeroTalentNodeLevelupReward()
  local hasReward = rewardIds ~= nil and 0 < #rewardIds
  self.ui.obj_UpgradeGet:SetActive(hasReward)
  self.ui.obj_Consume:SetActive(not hasReward)
  self.ui.tex_Tile:SetIndex(hasReward and 1 or 0)
  if hasReward then
    self.ui.consumeNode:SetActive(false)
    self.ui.rewardNode:SetActive(true)
    for index, itemId in ipairs(rewardIds) do
      local item = self._rewardPool:GetOne()
      local itemCfg = ConfigData.item[itemId]
      item:InitItemWithCount(itemCfg, rewardCounts[index])
    end
    return
  end
  self.ui.consumeNode:SetActive(true)
  self.ui.rewardNode:SetActive(false)
  local costIds, costNums = self._talentNode:GetHeroTalentNodeLevelupCost()
  if costIds == nil or costNums == nil then
    return
  end
  local hasCoin = false
  local sTokenIndex
  for index, itemId in ipairs(costIds) do
    if itemId == ConstGlobalItem.NormalGold then
      hasCoin = true
      sTokenIndex = index
    else
      local item = self._costPool:GetOne()
      item:RefresheDetailCost(itemId, costNums[index])
    end
  end
  self.ui.img_UpIcon.enabled = hasCoin
  self.ui.tex_UpNum.text.enabled = hasCoin
  if not hasCoin then
    return
  end
  self.ui.img_UpIcon.sprite = CRH:GetSpriteByItemId(1003)
  local costNum = costNums[sTokenIndex]
  local index = 0
  local curNum = PlayerDataCenter:GetItemCount(ConstGlobalItem.NormalGold)
  if costNum <= curNum then
    index = 1
  end
  self.ui.tex_UpNum:SetIndex(index, tostring(costNum))
end

function UINHeroTalentDetailNode:OnClickTalentLvUp()
  if self._lvUpClickFunc ~= nil then
    self._lvUpClickFunc(self._talentNode)
  end
end

function UINHeroTalentDetailNode:__OnClickBranchSelectListen(branchId)
  if self._branchClickFunc ~= nil then
    self._branchClickFunc(branchId)
  end
end

return UINHeroTalentDetailNode

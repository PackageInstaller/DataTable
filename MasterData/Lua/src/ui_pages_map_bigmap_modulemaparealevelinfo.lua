local this = class("moduleMapAreaLevelInfo", G_UIModuleBase)
local L_areaTypeTpl = L_GameTpl:getKiboDuelAreaTypeTpl()
local L_areaLeveTpl = L_GameTpl:getKiboDuelAreaLevelTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    imgIcon = "",
    txtName = "",
    txtMapAreaName = "",
    txtDesc = "",
    showDesc = true,
    txt_trace = "",
    imgLevelIcon = "",
    txtExpTitle = "",
    unlockLayout = true,
    rewardLayout = true,
    moduleExpInfo = {
      moduleName = "pages/kiboDuelAreaLevel/moduleAreaLevelExpInfo"
    },
    moduleUnlockList = {
      moduleName = "pages/kiboDuelAreaLevel/moduleAreaLevelUnlockList"
    },
    rewardList = L_Const.ModuleInfo.CellIconBag,
    moduleSkillTips = {
      moduleName = "pages/kiboDuelAreaLevel/moduleArealLevelSkillTips"
    },
    skillTipsLocalPos = nil
  }
end

function this.methods()
  return {
    onClick_trace = function(self, value)
      local curTracedNode = L_MapStore:getCurNodeTargetTracing()
      if table.isEmpty(curTracedNode) then
        self.parent:excuteNodeFunction()
      elseif curTracedNode.nodeType == self.node.type and curTracedNode.id == self.node.id then
        L_MapStore:disposeNodeTarget()
      else
        self.parent:excuteNodeFunction()
      end
    end
  }
end

function this:open()
  self.modules.moduleSkillTips:showModule(false)
  self.modules.moduleUnlockList:setClickCallbackFunc(function(cell, skillId)
    if skillId then
      self.modules.moduleSkillTips:showModule(true, {skillId = skillId})
      self:setSkillTipsPos(cell:getRootTran())
    end
  end)
  L_MapStore:listenCallFunc(L_MapStore.event.refreshNodeTrace, self.refreshButtonState, self)
end

function this:initModule(node)
  self.node = node
  self.bind.imgIcon = node.iconPath
  self.bind.showDesc = not string.isEmpty(node.desc) and true or false
  self.bind.txtDesc = node.desc
  self.bind.txtName = node.name
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_bg)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_listUnlock)
  self.bind.txtMapAreaName = node.mapAreaName
  self.areaType = self.node.param
  self.areaLevel = L_PetDuelStore:getAreaLevel(self.areaType)
  local maxLevel = L_areaLeveTpl:getMaxLevel(self.areaType)
  self.nextLevel = math.min(self.areaLevel + 1, maxLevel)
  self.isMaxLevel = maxLevel <= self.areaLevel
  self:refreshLevelInfoShow()
  self:refreshRewardShow()
  self:refreshUnlockContentShow()
  self:refreshButtonState()
  self.modules.moduleSkillTips:showModule(false)
  local isHasReward = L_PetDuelStore:isGetAreaLevelReward(self.areaType)
  self.bindComponents.reddotTran.gameObject:SetActive(isHasReward)
end

function this:setSkillTipsPos(targetTran)
  if not targetTran then
    return
  end
  local targetPos = self.bindComponents.rootTran:InverseTransformPoint(targetTran.position)
  self.bind.skillTipsLocalPos = L_Vector3.new(targetPos.x - 660, targetPos.y, 0)
end

function this:refreshRewardShow()
  if self.isMaxLevel then
    self.bind.rewardLayout = false
    return
  end
  local isHasReward, rewards = L_PetDuelStore:getAreaLevelRewards(self.areaType, self.nextLevel)
  if not isHasReward then
    self.bind.rewardLayout = false
    return
  end
  self.bind.rewardList:clear()
  self.bind.rewardList:insert_array(rewards)
  self.bind.rewardLayout = true
end

function this:refreshUnlockContentShow()
  if self.isMaxLevel then
    self.bind.unlockLayout = false
    return
  end
  self.modules.moduleUnlockList:setAreaLevelData(self.areaType, self.nextLevel)
  self.bind.unlockLayout = true
end

function this:refreshLevelInfoShow()
  local areaTypeTpl = L_areaTypeTpl:getTplById(self.areaType)
  local areaName = L_areaTypeTpl:getName(areaTypeTpl)
  local mapIcon = L_areaTypeTpl:getMapIcon(areaTypeTpl)
  self.modules.moduleExpInfo:setAreaLevelData(self.areaType, self.nextLevel, "#9d814f")
  self.bind.imgLevelIcon = mapIcon
  self.bind.txtExpTitle = table.concat({
    L_Lang:get(areaName),
    L_Const.Number2Roma[self.nextLevel]
  })
end

function this:refreshButtonState()
  local curTracedNode = L_MapStore:getCurNodeTargetTracing()
  if table.isEmpty(curTracedNode) then
    self.bind.txt_trace = L_WordsTpl:getValue("ui_moduleMapCollectionInfo_04")
  elseif curTracedNode.nodeType == self.node.type and curTracedNode.id == self.node.id then
    self.bind.txt_trace = L_WordsTpl:getValue("ui_moduleMapCollectionInfo_05")
  else
    self.bind.txt_trace = L_WordsTpl:getValue("ui_moduleMapCollectionInfo_04")
  end
end

function this:close()
  L_MapStore:unListenCallFunc(L_MapStore.event.refreshNodeTrace, self.refreshButtonState)
end

return this

local this = class("moduleMapKiBoDuelInfo", G_UIModuleBase)
local _kiboDuelTpl = L_GameTpl:getKiboDuelTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    icon = "",
    name = "",
    mapAreaName = "",
    desc = "",
    show_desc = true,
    txt_trace = "",
    txt_level = "",
    table_reward = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelReward"
    },
    table_condition = {
      moduleName = "pages/petDuelOutside/cellPetDuelCondition"
    }
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
  L_MapStore:listenCallFunc(L_MapStore.event.refreshNodeTrace, self.refreshButtonState, self)
end

function this:initModule(node)
  self.node = node
  self.bind.icon = node.iconPath
  self.bind.show_desc = not string.isEmpty(node.desc) and true or false
  self.bind.desc = node.desc
  self.bind.name = node.name
  self.selectLevelId = node.param
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_bg)
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_listCondition)
  self.bind.mapAreaName = node.mapAreaName
  self:refreshRewardShow()
  self:refreshConditionShow()
  self:refreshButtonState()
  local tpl = _kiboDuelTpl:getTplById(self.selectLevelId)
  local recommendLevel = _kiboDuelTpl:getRecommendLevel(tpl)
  self.bind.txt_level = string.format("Lv.%s", recommendLevel)
end

function this:refreshRewardShow()
  local tpl = _kiboDuelTpl:getTplById(self.node.param)
  local reward = _kiboDuelTpl:getFirstLoot(tpl)
  local rewardItems = {}
  for i = 1, #reward do
    local item = L_ItemTplManager:getItemConfig(reward[i].itemType, reward[i].itemId)
    table.insert(rewardItems, {
      itemType = item.itemType,
      itemId = item.itemId,
      selectLevelId = self.selectLevelId,
      num = reward[i].itemNum
    })
  end
  self.bind.table_reward:clear()
  self.bind.table_reward:insert_array(rewardItems)
end

function this:refreshConditionShow()
  local starData = L_PetDuelStore:getKiBoDuelStar(self.node.param)
  local tpl = _kiboDuelTpl:getTplById(self.node.param)
  local challengeTask = _kiboDuelTpl:getChallenge(tpl)
  local conditionItem = {}
  if challengeTask then
    for i = 1, #challengeTask do
      table.insert(conditionItem, {
        conditionId = challengeTask[i][1],
        conditionParma = challengeTask[i][2],
        finished = starData[i]
      })
    end
  end
  local reward = _kiboDuelTpl:getChallengeRewardShow(tpl)
  for i = 1, #reward do
    local item = L_ItemTplManager:getItemConfig(reward[i].itemType, reward[i].itemId)
    if conditionItem[i] then
      conditionItem[i].rewardIcon = item.icon
      conditionItem[i].rewardNum = reward[i].itemNum
    end
  end
  self.bind.table_condition:clear()
  self.bind.table_condition:insert_array(conditionItem)
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

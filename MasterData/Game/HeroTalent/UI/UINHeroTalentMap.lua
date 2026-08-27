local UINHeroTalentMap = class("UINHeroTalentMap", UIBaseNode)
local base = UIBaseNode
local UINHeroTalentNode = require("Game.HeroTalent.UI.UINHeroTalentNode")
local UINHeroTalentLine = require("Game.HeroTalent.UI.UINHeroTalentLine")
local eHeroTalentNodeType = {SmallNode = 1, BigNode = 2}
local eHeroTalentNodeSelectScale = {
  [eHeroTalentNodeType.SmallNode] = Vector3.New(0.7, 0.7, 0.7)
}

function UINHeroTalentMap:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.touchArea, self, self.OnClickCancleSelect)
  UIUtil.AddButtonListener(self.ui.talentMainEntityItem, self, self.OnSelectHeroTalentMain)
  self._smallNodePool = UIItemPool.New(UINHeroTalentNode, self.ui.talentSmallEntityItem)
  self._bigNodePool = UIItemPool.New(UINHeroTalentNode, self.ui.talentBigEntityItem)
  self.ui.talentSmallEntityItem:SetActive(false)
  self.ui.talentBigEntityItem:SetActive(false)
  self._linePool = UIItemPool.New(UINHeroTalentLine, self.ui.obj_Line)
  self.ui.obj_Line:SetActive(false)
  self.__OnSelectHeroTalentNode = BindCallback(self, self.OnSelectHeroTalentNode)
  self._nodePoolDic = {
    [eHeroTalentNodeType.SmallNode] = self._smallNodePool,
    [eHeroTalentNodeType.BigNode] = self._bigNodePool
  }
  self.ui.lvParticlePrimary.scale = eHeroTalentNodeSelectScale[eHeroTalentNodeType.SmallNode].x
  self._particleDic = {}
  self._particlePool = {}
end

function UINHeroTalentMap:InitHeroTalentMap(selectAct, rightOffset, selectMainAct, selectCancle)
  self._selectAct = selectAct
  self._rightOffset = rightOffset or 0
  self._selectMainAct = selectMainAct
  self._selectCancle = selectCancle
end

function UINHeroTalentMap:SetCampColor(color)
  self.ui.center.color = color
end

function UINHeroTalentMap:SetNodeMaxColor(color)
  self._maxLevelColor = color
end

function UINHeroTalentMap:SetTouchAreaScale(localScale)
  self.ui.touchArea.transform.localScale = localScale
end

function UINHeroTalentMap:GetTouchAreaScaleX()
  return self.ui.touchArea.transform.localScale.x
end

function UINHeroTalentMap:UpdateHeroTalentMap(talentInfo)
  self._talentInfo = talentInfo
  local modelId = self._talentInfo:GetHeroTalentModelId()
  local modelCfg = PlayerDataCenter.allHeroTalentData:GetHeroTalentModelCfg(modelId)
  if modelCfg == nil then
    return
  end
  self.ui.obj_itemSelect:SetActive(false)
  local width = modelCfg.size[3] + self._rightOffset
  local height = modelCfg.size[4]
  self.ui.touchArea.transform.sizeDelta = Vector2.New(width, height)
  local offsetOri = Vector3.New(self._rightOffset / 2, 0, 0)
  self.ui.touchArea.transform.anchoredPosition = offsetOri
  local holderOri = Vector3.New(-self._rightOffset / 2, 0, 0)
  for _, subNode in ipairs(self.ui.touAreaSubNodes) do
    subNode.transform.anchoredPosition = holderOri
  end
  self:__GenMap(modelCfg)
  PlayerDataCenter.allHeroTalentData:RemoveHeroTalentModelCfg(modelId)
  self:__RefreshMainState()
  self.ui.lvParticlePrimary.gameObject:SetActive(false)
  self.ui.lvParticleSenior.gameObject:SetActive(false)
  for k, particleItem in pairs(self._particleDic) do
    particleItem.gameObject:SetActive(false)
    table.insert(self._particlePool, particleItem)
    self._particleDic[k] = nil
  end
  self:UpdateItemTalentMap()
end

function UINHeroTalentMap:UpdateItemTalentMap()
  for pointId, talentUINode in pairs(self._nodeDic) do
    local nodeInfo = talentUINode:GetHeroTalentNode()
    if nodeInfo:IsHeroTalentNodeCanLeveUp() then
      if self._particleDic[pointId] == nil then
        local nodeType = nodeInfo:GetHeroTalentNodeType()
        local particleItem
        local poolCount = #self._particlePool
        if 0 < poolCount then
          particleItem = table.remove(self._particlePool, poolCount)
        else
          particleItem = self.ui.uI_TalentMain_loop.gameObject:Instantiate().transform
          particleItem:SetParent(self.ui.particleHolder.transform)
        end
        self._particleDic[pointId] = particleItem
        particleItem.localPosition = talentUINode.transform.localPosition
        particleItem.localScale = eHeroTalentNodeSelectScale[nodeType] or Vector3.one
        particleItem.gameObject:SetActive(true)
      end
    else
      local particleItem = self._particleDic[pointId]
      if particleItem ~= nil then
        particleItem.gameObject:SetActive(false)
        self._particleDic[pointId] = nil
        table.insert(self._particlePool, particleItem)
      end
    end
  end
end

function UINHeroTalentMap:LvUpHeroTalentMap(heroId, nodeId)
  if heroId ~= self._talentInfo:GetHeroTalentHeroId() then
    return
  end
  if self._nodeDic[nodeId] == nil then
    return
  end
  local item = self._nodeDic[nodeId]
  item:RefreshHeroTalentNodeUI()
  local curNodeData = item:GetHeroTalentNode()
  local curLevel = curNodeData:GetHeroTalentNodeCurLevel()
  local lines = self._reverseLineDic[nodeId]
  if lines ~= nil then
    for toNodeId, line in pairs(lines) do
      local toNodeItem = self._nodeDic[toNodeId]
      local toNode = toNodeItem:GetHeroTalentNode()
      if toNodeItem ~= nil then
        local vaild = toNode:IsHeroTalentNodeUnlock()
        local isDottedLine = vaild and toNode:GetHeroTalentNodeCurLevel() == 0
        line:RefreshHeroTalentLine(vaild, isDottedLine)
        toNodeItem:RefreshHeroTalentNodeUI()
      end
    end
  end
  local lines = self._lineDic[nodeId]
  if lines ~= nil then
    for preNodeId, line in pairs(lines) do
      local preNodeItem = self._nodeDic[preNodeId]
      if preNodeItem ~= nil and preNodeItem:GetHeroTalentNode():IsHeroTalentNodeUnlock() then
        line:RefreshHeroTalentLine(true, false)
      end
    end
  end
  self:__RefreshMainState()
  self:UpdateItemTalentMap()
end

function UINHeroTalentMap:ShowHeroTalentMapLvupEffect(nodeId)
  if self._nodeDic[nodeId] == nil then
    return
  end
  local item = self._nodeDic[nodeId]
  if item:GetHeroTalentNode():GetHeroTalentNodeType() == eHeroTalentNodeType.SmallNode then
    self.ui.lvParticlePrimary.gameObject:SetActive(false)
    self.ui.lvParticlePrimary.gameObject:SetActive(true)
    self.ui.lvParticlePrimary.transform.localPosition = item.transform.localPosition
  else
    self.ui.lvParticleSenior.gameObject:SetActive(false)
    self.ui.lvParticleSenior.gameObject:SetActive(true)
    self.ui.lvParticleSenior.transform.localPosition = item.transform.localPosition
  end
end

function UINHeroTalentMap:__GenMap(modelCfg)
  for _, pool in pairs(self._nodePoolDic) do
    pool:HideAll()
  end
  self._linePool:HideAll()
  self._nodeDic = {}
  self._lineDic = {}
  self._reverseLineDic = {}
  local oriPos = Vector3.New(modelCfg.oriPos[1], modelCfg.oriPos[2], 0)
  self.ui.talentMainEntityItem.transform.localPosition = oriPos
  for pointId, vec in pairs(modelCfg.pos) do
    local nodeInfo = self._talentInfo:GetHeroTalentNodeById(pointId)
    if nodeInfo == nil then
      error(" nodeInfo is NIL,  heroId is " .. tostring(self._talentInfo:GetHeroTalentHeroId()) .. " ,point is " .. tostring(pointId))
      return
    end
    local itemPool = self._nodePoolDic[nodeInfo:GetHeroTalentNodeType()]
    if itemPool == nil then
      error(" point nodeType ERROR,  heroId is " .. tostring(self._talentInfo:GetHeroTalentHeroId()) .. " ,point is " .. tostring(pointId))
      return
    end
    local item = itemPool:GetOne()
    self._nodeDic[pointId] = item
    if self._maxLevelColor ~= nil then
      item:SetTalentMaxColor(self._maxLevelColor)
    end
    item:InitHeroTalentNode(nodeInfo, self.__OnSelectHeroTalentNode)
    item.gameObject.transform:SetParent(self.ui.itemHolder.transform)
    item.gameObject.transform.localPosition = Vector2.New(vec[1], vec[2])
  end
  for nodeId, nodeItem in pairs(self._nodeDic) do
    local nodeInfo = nodeItem:GetHeroTalentNode()
    local preIdLevelDic = nodeInfo:GetHeroTalentNodePreIdLvDic()
    local toNodePos = nodeItem.transform.anchoredPosition
    if table.count(preIdLevelDic) ~= 0 then
      self._lineDic[nodeId] = {}
      for preId, preLeve in pairs(preIdLevelDic) do
        local preItem = self._nodeDic[preId]
        if preItem ~= nil then
          local formNodePos = preItem.transform.anchoredPosition
          local diffDir = formNodePos - toNodePos
          local fromPos = preItem:GetLineTargetPoint(-diffDir.x, -diffDir.y)
          fromPos = formNodePos + fromPos
          fromPos = Vector3.New(fromPos.x, fromPos.y, 0)
          local toPos = nodeItem:GetLineTargetPoint(diffDir.x, diffDir.y)
          toPos = toNodePos + toPos
          toPos = Vector3.New(toPos.x, toPos.y, 0)
          local lineItem = self._linePool:GetOne()
          self._lineDic[nodeId][preId] = lineItem
          lineItem:SetHeroTalentLine(fromPos, toPos)
          local preNodeData = preItem:GetHeroTalentNode()
          local vaild = preNodeData:IsHeroTalentNodeUnlock() and nodeInfo:IsHeroTalentNodeUnlock()
          local isDottedLine = vaild and nodeInfo:GetHeroTalentNodeCurLevel() == 0
          lineItem:RefreshHeroTalentLine(vaild, isDottedLine)
          if self._reverseLineDic[preId] == nil then
            self._reverseLineDic[preId] = {}
          end
          self._reverseLineDic[preId][nodeId] = lineItem
        end
      end
    end
  end
end

function UINHeroTalentMap:__RefreshMainState()
  local totalLv, maxLv = self._talentInfo:GetHeroTalentTotalLevel()
  local stage = ConfigData:GetTalentStage(totalLv)
  self.ui.img_Icon:SetIndex(stage - 1)
end

function UINHeroTalentMap:OnSelectHeroTalentNode(talentNodeItem)
  if talentNodeItem == nil then
    return
  end
  local talentNodeData = talentNodeItem:GetHeroTalentNode()
  if self._selectAct ~= nil then
    self._selectAct(talentNodeData)
  end
  self.ui.obj_itemSelect:SetActive(true)
  self.ui.obj_itemSelect.transform:SetParent(talentNodeItem.transform)
  self.ui.obj_itemSelect.transform.localPosition = Vector3.zero
  self.ui.obj_itemSelect.transform.localScale = eHeroTalentNodeSelectScale[talentNodeData:GetHeroTalentNodeType()] or Vector3.one
end

function UINHeroTalentMap:OnSelectHeroTalentMain()
  self.ui.obj_itemSelect:SetActive(false)
  if self._selectMainAct ~= nil then
    self._selectMainAct(true)
  end
end

function UINHeroTalentMap:OnClickCancleSelect()
  if self._selectCancle ~= nil then
    self.ui.obj_itemSelect:SetActive(false)
    self._selectCancle()
  end
end

return UINHeroTalentMap

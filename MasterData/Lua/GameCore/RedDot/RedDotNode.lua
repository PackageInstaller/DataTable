local RedDotNode = class("RedDotNode")
local RedDotType = AllEnum.RedDotType

function RedDotNode:ctor(sKey, parent)
  self.bManualRefresh = nil
  self.sNodeKey = sKey
  self.parentNode = parent
  self.tbChildNodeList = nil
  self.nRedDotCount = 0
  self.tbObjNode = nil
  self.tbTxtRedDotCount = nil
  self.nShowType = nil
end

function RedDotNode:RegisterNode(objGo, nType, bManualRefresh)
  if nil == objGo then
    traceback(string.format("注册红点失败！！！传入的gameObject为空.  nodeKey = %s", self.sNodeKey))
    return
  end
  if nil == nType then
    nType = RedDotType.Single
  end
  self.nShowType = nType
  self.bManualRefresh = bManualRefresh
  if self.tbObjNode == nil then
    self.tbObjNode = {}
  end
  if type(objGo) == "table" then
    for _, v in ipairs(objGo) do
      local nInstanceId = v.gameObject:GetInstanceID()
      self.tbObjNode[nInstanceId] = v.gameObject
    end
  else
    local nInstanceId = objGo.gameObject:GetInstanceID()
    self.tbObjNode[nInstanceId] = objGo.gameObject
  end
  self.tbTxtRedDotCount = {}
  for _, v in pairs(self.tbObjNode) do
    if v:IsNull() ~= true then
      local trObj = v.gameObject:GetComponent("Transform")
      local trNode = trObj:Find("---RedDot---")
      if nil == trNode then
        printError("红点UI结构不标准！！！请检查")
        return
      end
      if nType == RedDotType.Number then
        local trText = trNode:Find("txtRedDot")
        if nil ~= trText then
          local nInstanceId = trText:GetInstanceID()
          self.tbTxtRedDotCount[nInstanceId] = trText:GetComponent("TMP_Text")
        end
      end
    end
  end
  self:RefreshRedDotShow()
end

function RedDotNode:UnRegisterNode(objGo)
  if nil == objGo then
    self.tbObjNode = nil
    self.tbTxtRedDotCount = nil
  else
    if self.tbObjNode == nil then
      return
    end
    if type(objGo) == "table" then
      for _, v in ipairs(objGo) do
        local nInstanceId = v:GetInstanceID()
        self.tbObjNode[nInstanceId] = nil
      end
    else
      local nInstanceId = objGo:GetInstanceID()
      self.tbObjNode[nInstanceId] = nil
    end
  end
end

function RedDotNode:AddChildNode(sKey)
  if nil == self.tbChildNodeList then
    self.tbChildNodeList = {}
  end
  local node = RedDotNode.new(sKey, self)
  table.insert(self.tbChildNodeList, node)
  return node
end

function RedDotNode:GetChildNode(sKey)
  if nil ~= self.tbChildNodeList then
    for _, node in ipairs(self.tbChildNodeList) do
      if node:GetNodeKey() == sKey then
        return node
      end
    end
  end
end

function RedDotNode:SetValid(bValid)
  if self:GetValid() == bValid and (nil == self.tbChildNodeList or #self.tbChildNodeList <= 0) then
    return
  end
  if bValid then
    self.nRedDotCount = self.nRedDotCount + 1
  else
    self.nRedDotCount = self.nRedDotCount - 1
  end
  if not self.bManualRefresh then
    self:RefreshRedDotShow()
  end
  if nil ~= self.parentNode then
    self.parentNode:SetValid(bValid)
  end
end

function RedDotNode:SetCount(nCount)
  if self:GetCount() == nCount and (nil == self.tbChildNodeList or #self.tbChildNodeList <= 0) then
    return
  end
  self.nRedDotCount = nCount
  self:RefreshRedDotShow()
  if nil ~= self.parentNode then
    self.parentNode:SetCount(nCount)
  end
end

function RedDotNode:RefreshRedDotShow()
  if nil == self.tbObjNode or nil == next(self.tbObjNode) then
    return
  end
  for _, v in pairs(self.tbObjNode) do
    if v:IsNull() == true then
      traceback("疑似上一次注册的红点未注销！！！请检查 nodeKey = " .. self.sNodeKey)
    else
      v.gameObject:SetActive(self:GetValid())
    end
  end
  if self.nShowType == RedDotType.Number then
    for _, v in pairs(self.tbTxtRedDotCount) do
      NovaAPI.SetTMPText(v, self:GetCount())
    end
  end
end

function RedDotNode:GetNodeKey()
  return self.sNodeKey
end

function RedDotNode:GetValid()
  return self.nRedDotCount > 0
end

function RedDotNode:GetCount()
  return self.nRedDotCount
end

function RedDotNode:CheckLeafNode()
  return nil == self.tbChildNodeList or #self.tbChildNodeList == 0
end

function RedDotNode:PrintRedDot(bLeaf, tbNode, nDepth)
  if self.sNodeKey == "Root" then
    if bLeaf and nil ~= self.tbChildNodeList then
      for _, v in ipairs(self.tbChildNodeList) do
        v:PrintRedDot(true, tbNode, 0)
      end
    end
    return
  end
  table.insert(tbNode, {
    node = self,
    depth = nDepth or 0
  })
  if bLeaf and nil ~= self.tbChildNodeList then
    for _, v in ipairs(self.tbChildNodeList) do
      v:PrintRedDot(true, tbNode, (nDepth or 0) + 1)
    end
  end
end

function RedDotNode:GetParentKey(tbKey)
  if self.parentNode ~= nil and self.parentNode.sNodeKey ~= "Root" then
    table.insert(tbKey, self.parentNode.sNodeKey)
    self.parentNode:GetParentKey(tbKey)
  end
end

function RedDotNode:GetBindObjCount()
  local nCount = 0
  if self.tbObjNode ~= nil then
    for _, v in pairs(self.tbObjNode) do
      nCount = nCount + 1
    end
  end
  return nCount
end

return RedDotNode

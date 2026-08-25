local GameObject = CS.UnityEngine.GameObject
local CommonEffectDescGroup, Super = System.NewComponent("CommonEffectDescGroup")

function CommonEffectDescGroup:ctor(uiNode, descGroup)
  Super.ctor(self)
  self.ui = CardKeyWordItem_NewResource(uiNode)
  self.descGroup = descGroup
  self.descNodeList = {}
  self.baseDescNode = self.ui.CardKeyWordItem_New_Info
  self.baseDescNodeParent = self.baseDescNode.transform.parent
end

function CommonEffectDescGroup:OnBind(binder)
  self.binder = binder
  self:RemoveDuplicate(self.descGroup.descList)
  binder:BindToText(self.ui.Text_AffixInfo, function()
    return self.descGroup.name
  end, nil, nil, {banKeywordBtn = true})
  self:BindEffectDescList(binder, self.descGroup.descList)
end

function CommonEffectDescGroup:BindEffectDescList(binder, descList)
  local baseName = self.baseDescNode.name
  local destroyList = {}
  for i = 0, self.baseDescNodeParent.childCount - 1 do
    local childGo = self.baseDescNodeParent:GetChild(i).gameObject
    if childGo ~= self.baseDescNode and 1 == string.find(childGo.name, baseName, 1, true) then
      table.insert(destroyList, childGo)
    end
  end
  for _, childGo in ipairs(destroyList) do
    GameObject.Destroy(childGo)
  end
  self.descNodeList = {}
  binder:SetActive(self.baseDescNode, false)
  local createList = {}
  local validCount = 0
  for _, descInfo in ipairs(descList) do
    validCount = validCount + 1
    if 1 == validCount then
      binder:SetActive(self.baseDescNode, true)
      table.insert(createList, {
        self.baseDescNode,
        descInfo
      })
    else
      local newGroupNode = self.binder:Instantiate(self.baseDescNode, self.baseDescNodeParent)
      table.insert(self.descNodeList, newGroupNode)
      binder:SetActive(newGroupNode, true)
      table.insert(createList, {newGroupNode, descInfo})
    end
  end
  for _, info in ipairs(createList) do
    binder:BindComponent(CommonEffectDesc(info[1], info[2]))
  end
end

function CommonEffectDescGroup:RemoveDuplicate(descList)
  local nameMap = {}
  for index = #descList, 1, -1 do
    local effectDesc = descList[index]
    local name = LT.Text(effectDesc.name)
    if not table.contains(nameMap, name) then
      table.insert(nameMap, name)
    else
      table.remove(descList, index)
    end
  end
  return descList
end

function CommonEffectDescGroup:OnUnbind()
  for _, node in ipairs(self.descNodeList) do
    GameObject.Destroy(node)
  end
end

return CommonEffectDescGroup

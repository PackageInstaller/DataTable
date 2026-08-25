local GameObject = CS.UnityEngine.GameObject
local CommonEffectDescGroupItem, Super = NewViewComponent("CommonEffectDescGroupItem")

function CommonEffectDescGroupItem:ctor(uiNode, view, descGroup)
  Super.ctor(self, uiNode, view)
  self.ui = CardKeyWordItem_NewResource(uiNode)
  self._descGroup = descGroup
  self._descNodeList = {}
  self._baseDescNode = self.ui.CardKeyWordItem_New_Info
  self._baseDescNodeParent = self._baseDescNode.transform.parent
end

function CommonEffectDescGroupItem:OnEnterComponent()
  self:_RemoveDuplicate(self._descGroup.descList)
  if self._descGroup.name then
    self:SetText(self.ui.Text_AffixInfo, self._descGroup.name, nil, nil, {banKeywordBtn = true})
  end
  self:_BindEffectDescList(self._descGroup.descList)
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.gameObject)
end

function CommonEffectDescGroupItem:OnExitComponent()
  for _, node in ipairs(self._descNodeList) do
    if node and not IsNil(node) then
      GameObject.Destroy(node)
    end
  end
  self._descNodeList = {}
  Super.OnExitComponent(self)
end

function CommonEffectDescGroupItem:_BindEffectDescList(descList)
  local baseName = self._baseDescNode.name
  local destroyList = {}
  for i = 0, self._baseDescNodeParent.childCount - 1 do
    local childGo = self._baseDescNodeParent:GetChild(i).gameObject
    if childGo ~= self._baseDescNode and 1 == string.find(childGo.name, baseName, 1, true) then
      table.insert(destroyList, childGo)
    end
  end
  for _, childGo in ipairs(destroyList) do
    GameObject.Destroy(childGo)
  end
  self._descNodeList = {}
  self:SetActive(self._baseDescNode, false)
  local createList = {}
  local validCount = 0
  for _, descInfo in ipairs(descList) do
    validCount = validCount + 1
    local descNode
    if 1 == validCount then
      descNode = self._baseDescNode
      self:SetActive(descNode, true)
      table.insert(createList, {descNode, descInfo})
    else
      descNode = self.view:Instantiate(self._baseDescNode, self._baseDescNodeParent)
      table.insert(self._descNodeList, descNode)
      self:SetActive(descNode, true)
      table.insert(createList, {descNode, descInfo})
    end
  end
  for _, info in ipairs(createList) do
    self:AddViewComponent(info[1], CommonEffectDescItem, info[2])
  end
end

function CommonEffectDescGroupItem:_RemoveDuplicate(descList)
  local nameMap = {}
  for index = #descList, 1, -1 do
    local effectDesc = descList[index]
    local name = LT.Text(effectDesc.name)
    if nameMap[name] then
      table.remove(descList, index)
    else
      nameMap[name] = true
    end
  end
  return descList
end

return CommonEffectDescGroupItem

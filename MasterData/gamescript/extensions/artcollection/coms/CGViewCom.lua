local TYPEOF_RectTransform = typeof(CS.UnityEngine.RectTransform)
local CGViewCom, Super = NewViewComponent("CGViewCom")

function CGViewCom:ctor(uiNode, view, uiMap, subFeature)
  Super.ctor(self, uiNode, view)
  self.ui = uiMap
  self.subFeature = subFeature
end

function CGViewCom:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:UpdateScroll()
end

function CGViewCom:FixList()
  local resultList = {}
  local feature = CommonDefine.FeatureId.CollectionPicture
  local groupDatas = ArtCollectionController.Instance:GetDataSortListByFeature(feature, self.subFeature)
  local chilCnt = self.ui.groupContent.transform.childCount
  for _, groupData in ipairs(groupDatas) do
    if type(groupData) == "number" then
      self:SplitIntoList(groupDatas, chilCnt, resultList)
      break
    end
    table.insert(resultList, groupData.groupId)
    self:SplitIntoList(groupData.list, chilCnt, resultList)
  end
  self.resultList = resultList
end

function CGViewCom:SplitIntoList(list, splitSize, resultList)
  for i = 1, #list, splitSize do
    local subList = {}
    local loopEnd = i + splitSize - 1
    for j = i, loopEnd do
      local cfgId = list[j]
      if cfgId then
        table.insert(subList, cfgId)
      else
        break
      end
    end
    table.insert(resultList, subList)
  end
end

local TableCellType = {collectTitle = 1, collectContent = 2}

function CGViewCom:UpdateScroll()
  if self.tableView == nil then
    self:FixList()
    self:CalcHeight()
    self.tableView = self:CreateTableview(self.ui.ScrollView, function()
      return #self.resultList
    end, function(view, index)
      local data = self.resultList[index]
      local tag = type(data) ~= "table" and TableCellType.collectTitle or TableCellType.collectContent
      local cell = self:GetCellByTag(view, tag)
      self:UpdateScollCom(cell, tag, data)
      return cell
    end, function(_, index)
      return self.CacheSize[index].x, self.CacheSize[index].y
    end)
    self.tableView:ReloadData()
  else
    self.tableView:Refresh()
  end
end

local classMap = {
  [TableCellType.collectTitle] = CGGroupTitle,
  [TableCellType.collectContent] = CGGroupItem
}

function CGViewCom:UpdateScollCom(cell, tag, data)
  self.comMap = self.comMap or {}
  local com = self.comMap[cell]
  if nil == com then
    com = self:AddViewComponentOnce(cell.gameObject, classMap[tag], data)
    self.comMap[cell] = com
  else
    com:UpdateShow(data)
  end
end

local objMap = {
  [TableCellType.collectTitle] = "UI_Collection_Image_Bookmark",
  [TableCellType.collectContent] = "UI_Collection_Item_Expression_Manage"
}

function CGViewCom:GetCellByTag(view, tag)
  local cell = view:DequeueCellByTag(tag)
  if not cell then
    local uiName = objMap[tag]
    cell = view:AddChild(self.ui[uiName])
    cell.tag = tag
  end
  return cell
end

function CGViewCom:CalcHeight()
  local titleCellRT = self.ui.UI_Collection_Image_Bookmark:GetComponent(TYPEOF_RectTransform)
  local titleWidth, titleHeight = titleCellRT.sizeDelta.x, titleCellRT.sizeDelta.y
  local cellRT = self.ui.UI_Collection_Item_Expression_Manage:GetComponent(TYPEOF_RectTransform)
  local width, height = cellRT.sizeDelta.x, cellRT.sizeDelta.y
  self.CacheSize = {}
  for index, value in ipairs(self.resultList) do
    if type(value) ~= "table" then
      self.CacheSize[index] = {x = titleWidth, y = titleHeight}
    else
      self.CacheSize[index] = {x = width, y = height}
    end
  end
end

return CGViewCom

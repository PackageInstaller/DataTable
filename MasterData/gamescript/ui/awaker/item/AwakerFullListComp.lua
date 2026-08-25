local RedType = RedPointDataUtils.RedType
local RedAttrType = RedPointDataUtils.RedAttrType
local AwakerPage = CommonDefine.AwakerPage
local Animator = CS.UnityEngine.Animator
local typeof = _ENV.typeof
local filterCheckCnt = 2
local AwakerFullListComp, Super = System.NewComponent("AwakerFullListComp")

function AwakerFullListComp:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Fullhead_ListResource(uiNode)
  self.model = model
end

function AwakerFullListComp:OnBind(binder)
  self.binder = binder
  local filterAnimator = self.ui.Group_Career_List:GetComponent(typeof(Animator))
  self:CreateAwakerHeadTable()
  binder:BindRawTable(function()
    return self.model.awakerList
  end, function(_, new, old, index)
  end, false, function()
    self.tableView:ReloadData()
  end)
  binder:BindToVisible(self.ui.Btn_Mask, function()
    return self.model.showSchollFilter or self.model.showSortType
  end)
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    if self.model.showSchollFilter then
      self.model:SetSchoolFilterShow(false)
      binder:SetZ1Toggle(self.ui.Btn_Filter, false)
    end
    if self.model.showSortType then
      self.model:SetSortTypeShow(false)
      binder:SetZ1Toggle(self.ui.Btn_Level, false)
    end
  end)
  binder:BindToAnimator(self.ui.Group_Career_List, function(_, animator, show)
    if not self.ui then
      return
    end
    AnimatorUtils.SetStateEndInBehavior(animator, "Close", function()
      binder:SetActive(self.ui.Group_Career_List, false)
    end)
    local name = show and "Open" or "Close"
    if "Open" == name then
      return
    end
    local state = string.format("Base Layer.%s", name)
    AnimatorUtils.PlayState(animator, state)
  end, nil, function()
    return self.model.showSchollFilter
  end)
  binder:BindToAnimator(self.ui.Group_Sort_List, function(_, animator, show)
    if not self.ui then
      return
    end
    AnimatorUtils.SetStateEndInBehavior(animator, "Close", function()
      if not self.ui then
        return
      end
      binder:SetActive(self.ui.Group_Sort_List, false)
    end)
    local name = show and "Open" or "Close"
    if "Open" == name then
      return
    end
    local state = string.format("Base Layer.%s", name)
    AnimatorUtils.PlayState(animator, state)
  end, nil, function()
    return self.model.showSortType
  end)
  binder:BindToCircularListView(self.ui.ScrollView_List_Btn, function()
    return self.model.filterSchools
  end, function(itemBinder, obj, index)
    local school = self.model.filterSchools[index]
    local schoolName = self.model:GetSchoolName(school)
    
    local function IsSelected()
      return self.model.curSchool == school
    end
    
    local function OnClick(tid)
      if not tid then
        return
      end
      self.model:SetCurSchool(tid)
      itemBinder:SetZ1Toggle(self.ui.Btn_Filter, false)
      AnimatorUtils.PlayState(filterAnimator, "Base Layer.Close")
      self.model:SetSchoolFilterShow(false)
      self.model:CheckUpdateSelectAwaker()
    end
    
    local itemData = {
      tid = self.model.filterSchools[index],
      name = schoolName,
      selectedFunc = IsSelected,
      callback = OnClick
    }
    itemBinder:BindComponent(CommonFilterListItem(obj, itemData))
  end)
  self.curHoverCnt = 0
  self.triCnt = filterCheckCnt
  
  local function tempCheck(hover)
    if hover then
      self.curHoverCnt = self.curHoverCnt + 1
    end
    self.triCnt = self.triCnt - 1
    if self.triCnt <= 0 then
      self:FilterBtnHoverCheck()
    end
  end
  
  binder:BindUICustomInput(self.ui.Group_Career_List, function(hover)
    if not self.model.showSchollFilter then
      return
    end
    tempCheck(hover)
  end)
  binder:BindUICustomInput(self.ui.Btn_Filter, function(hover)
    if not self.model.showSchollFilter then
      return
    end
    tempCheck(hover)
  end)
  binder:BindUICustomInput(self.ui.Group_Sort_List, function(hover)
    if not self.model.showSortType then
      return
    end
    tempCheck(hover)
  end)
  binder:BindUICustomInput(self.ui.Btn_Level, function(hover)
    if not self.model.showSortType then
      return
    end
    tempCheck(hover)
  end)
  binder:BindToText(self.ui.Text_Filter_Normal, function()
    local tid = self.model.curSchool
    do return self.model.GetSchoolName, self.model end
    return self.model.GetSchoolName, self.model, tid
  end)
  binder:BindToText(self.ui.Text_Filter_Select, function()
    local tid = self.model.curSchool
    do return self.model.GetSchoolName, self.model end
    return self.model.GetSchoolName, self.model, tid
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Sort_List, function()
    return self.model.sortTypeList
  end, function(itemBinder, obj, index)
    local sortType = self.model.sortTypeList[index]
    local sortTypeName = self.model:GetSortTypeName(sortType)
    
    local function IsSelected()
      return self.model.sortType == sortType
    end
    
    local function OnClick(tid)
      if not tid then
        return
      end
      self.model:SetSortType(tid)
      itemBinder:SetZ1Toggle(self.ui.Btn_Level, false)
      self.model:SetSortTypeShow(false)
    end
    
    local itemData = {
      tid = self.model.sortTypeList[index],
      name = sortTypeName,
      selectedFunc = IsSelected,
      callback = OnClick
    }
    itemBinder:BindComponent(CommonFilterListItem(obj, itemData))
  end)
  binder:BindToText(self.ui.Text_Level_Normal, function()
    local sortType = self.model.sortType
    do return self.model.GetSortTypeName, self.model end
    return self.model.GetSortTypeName, self.model, sortType
  end)
  binder:BindToText(self.ui.Text_Level_Select, function()
    local sortType = self.model.sortType
    do return self.model.GetSortTypeName, self.model end
    return self.model.GetSortTypeName, self.model, sortType
  end)
  binder:SetZ1Toggle(self.ui.Btn_Filter, false)
  binder:BindToZ1Toggle(self.ui.Btn_Filter, nil, function(isOn)
    self.model:SetSchoolFilterShow(isOn)
    if isOn then
      binder:SetActive(self.ui.Group_Career_List, true)
    end
  end)
  binder:SetZ1Toggle(self.ui.Btn_Level, false)
  binder:BindToZ1Toggle(self.ui.Btn_Level, nil, function(isOn)
    self.model:SetSortTypeShow(isOn)
    if isOn then
      binder:SetActive(self.ui.Group_Sort_List, true)
    end
  end)
  binder:BindButtonClick(self.ui.Btn_Sort, function()
    self.model:SetSortOrder()
  end)
  binder:BindToText(self.ui.Text_Sort_Normal, function()
    local sortOrder = self.model.sortOrder
    do return self.model.GetSortOrderName, self.model end
    return self.model.GetSortOrderName, self.model, sortOrder
  end)
end

function AwakerFullListComp:CreateAwakerHeadTable()
  local baseGameObj = self.ui.UI_Awaker_Item_List1
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.tableView = UIBasePanel.CreateTableview(self, self.ui.ScrollView_Awaker_List, function()
    return #self.model.awakerList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local data = self.model.awakerList[index]
    
    local function clickCallback(tid)
      if not tid then
        return
      end
      RedPointDataUtils.ReqRemoveData(RedType.Awaker, RedAttrType.IsNew, tid)
      self.model:SetSelectAwakerId(tid)
    end
    
    local itemData = {
      awakerData = data,
      callback = clickCallback,
      model = self.model
    }
    itemComps[gameObj] = self.binder:BindComponent(AwakerFullListItem(gameObj, itemData))
    return cell
  end, function(view, index)
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

function AwakerFullListComp:FilterBtnHoverCheck()
  if self.curHoverCnt <= 0 then
    if self.model.showSchollFilter then
      self.binder:SetZ1Toggle(self.ui.Btn_Filter, false)
    end
    if self.model.showSortType then
      self.binder:SetZ1Toggle(self.ui.Btn_Level, false)
    end
  end
  self.curHoverCnt = 0
  self.triCnt = filterCheckCnt
end

function AwakerFullListComp:OnUnbind()
  Super.OnUnbind(self)
end

return AwakerFullListComp

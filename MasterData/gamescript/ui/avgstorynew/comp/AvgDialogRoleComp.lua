local Vector3 = CS.UnityEngine.Vector3
local AvgDialogRoleComp, Super = System.NewClass("AvgDialogRoleComp")

function AvgDialogRoleComp:ctor(ui, binder, avgModel)
  Super.ctor(self)
  self.ui = ui
  self.binder = binder
  self.avgModel = avgModel
  self.roleDataMap = {}
  self.roleItemMap = {}
end

function AvgDialogRoleComp:Awake()
  local normalPosList = self:GetNormalPosList()
  local roleType = CommonDefine.AvgRoleType.Normal
  self.roleDataMap[roleType] = {}
  self.roleItemMap[roleType] = {}
  self.ui.normal:SetActive(true)
  self.ui.vertical:SetActive(true)
  self.ui.horizontal:SetActive(true)
  for i = 1, 5 do
    local roleData = Vue.ref(nil)
    local item = self.binder:BindComponent(AvgNormalRoleItem(self.ui["Image_Role_" .. i], roleData, normalPosList, self.avgModel))
    item.roleType = roleType
    self.roleDataMap[roleType][i] = roleData
    self.roleItemMap[roleType][i] = item
  end
  roleType = CommonDefine.AvgRoleType.Vertical
  self.roleDataMap[roleType] = {}
  self.roleItemMap[roleType] = {}
  for i = 1, 3 do
    local roleData = Vue.ref(nil)
    local item = self.binder:BindComponent(AvgNormalRoleItem(self.ui["Vertical_Char_" .. i], roleData, normalPosList, self.avgModel))
    item.roleType = roleType
    self.roleDataMap[roleType][i] = roleData
    self.roleItemMap[roleType][i] = item
  end
  roleType = CommonDefine.AvgRoleType.Horizontal
  self.roleDataMap[roleType] = {}
  self.roleItemMap[roleType] = {}
  for i = 1, 2 do
    local roleData = Vue.ref(nil)
    local item = self.binder:BindComponent(AvgNormalRoleItem(self.ui["Horizontal_Char_" .. i], roleData, normalPosList, self.avgModel))
    item.roleType = roleType
    self.roleDataMap[roleType][i] = roleData
    self.roleItemMap[roleType][i] = item
  end
  roleType = CommonDefine.AvgRoleType.Big
  self.roleDataMap[roleType] = {}
  self.roleItemMap[roleType] = {}
  for i = 1, 1 do
    local roleData = Vue.ref(nil)
    local item = self.binder:BindComponent(AvgNormalRoleItem(self.ui["Big_Char_" .. i], roleData, normalPosList, self.avgModel))
    item.roleType = roleType
    self.roleDataMap[roleType][i] = roleData
    self.roleItemMap[roleType][i] = item
  end
end

function AvgDialogRoleComp:TempDealHorizontalBug()
  self.ui.horizontal.transform.localPosition = Vector3(9999, 9999, 0)
  self.ui.vertical.transform.localPosition = Vector3(9999, 9999, 0)
  self.binder:BindTimer(1, 0, nil, function()
    self.ui.horizontal.transform.localPosition = Vector3.zero
    self.ui.vertical.transform.localPosition = Vector3.zero
  end)
end

function AvgDialogRoleComp:GetNormalPosList()
  local posList = {}
  for pos = 1, 5 do
    local transform = self.ui["Root_" .. pos]:GetComponent(typeof(CS.UnityEngine.RectTransform))
    local localpos = transform.localPosition
    posList[pos] = Vector3(localpos.x, localpos.y, localpos.z)
  end
  return posList
end

function AvgDialogRoleComp:SetRoleList()
  for roleType, roleDataList in pairs(self.roleDataMap) do
    for pos, _ in ipairs(roleDataList) do
      local roleData = self.avgModel:GetRoleData(roleType, pos)
      roleDataList[pos].value = roleData
    end
  end
end

function AvgDialogRoleComp:DoEnterDialog()
  for roleType, itemList in pairs(self.roleItemMap) do
    for pos, roleData in ipairs(itemList) do
      local item = self.roleItemMap[roleType][pos]
      item:DoEnterDialog()
    end
  end
end

function AvgDialogRoleComp:DoExitDialog(callback)
  local exitCnt = 0
  for roleType, itemList in pairs(self.roleItemMap) do
    for pos, _ in ipairs(itemList) do
      local item = self.roleItemMap[roleType][pos]
      exitCnt = exitCnt + 1
      item:DoExitDialog(function()
        exitCnt = exitCnt - 1
        if exitCnt <= 0 then
          callback()
        end
      end)
    end
  end
end

function AvgDialogRoleComp:SetAllRoleDark()
  for roleType, itemList in pairs(self.roleItemMap) do
    for pos, roleData in ipairs(itemList) do
      local item = self.roleItemMap[roleType][pos]
      item:SetRoleDark()
    end
  end
end

return AvgDialogRoleComp

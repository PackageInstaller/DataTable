local this = class("cellAccessoryRecChildItem", G_UIModuleBase)
local _accessoryTpl = L_GameTpl:getAccessoryTpl()
local _jumpTpl = L_GameTpl:getCommonJumpTpl()
local _productsTpl = L_GameTpl:getProductsTpl()
local _homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()

function this.bind()
  return {
    txt_name = "",
    awardItem = {
      moduleName = "pages/achievement/cellAchievementAwardPreViewItem"
    },
    go_access = false,
    list_access = {
      moduleName = "pages/bag/cellItemAccess"
    }
  }
end

function this.methods()
  return {}
end

function this:open()
  this.super.open(self)
  self:refreshView()
end

function this:refreshView()
  local notShowAccess = self:GetSourceLuaPageOptions("notShowAccess")
  local accessoryTpl = _accessoryTpl:getTplById(self.bind.accessoryConfigId)
  self.bind.txt_name = _accessoryTpl:getName(accessoryTpl)
  if C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.itemAccess) then
    self.bind.go_access = true
    self.bind.list_access:clear()
    if not notShowAccess then
      local accessList = _accessoryTpl:getWayList(accessoryTpl)
      local tmp = {}
      for i, v in ipairs(accessList) do
        local isOpen = self.bind.systemId and L_JumpMgr:checkJumpFuncOpen(self.bind.systemId)
        table.insert(tmp, {
          systemId = v.id,
          txt_access = not isOpen and L_GameUtil.fillColor(v.desc, "#c7c0b1") or L_GameUtil.fillColor(v.desc, "#898989"),
          itemId = self.bind.accessoryConfigId
        })
      end
      self.bind.list_access:insert_array(tmp)
    end
  end
  self.modules.awardItem:refreshView(L_Const.resType.accessory, self.bind.accessoryConfigId, 0)
end

function this:accessListClickCallback(systemId)
  local jumpTpl = _jumpTpl:getTplById(systemId)
  local unlockConditionList = _jumpTpl:getCondition(jumpTpl)
  local buildingId = AzurWorld.HomeMgr:GetHomeStore():GetMaxLvBuildIdByGroup(unlockConditionList[1][2])
  if buildingId ~= 0 then
    local buildingInfo = L_HomeStore:getHomeBuildingByGuid(buildingId)
    local buildProductionTpl = _homeBuildingProductionTpl:getTplById(buildingInfo.build_id)
    local groupId = _homeBuildingProductionTpl:getGroupId(buildProductionTpl)
    local tab = _productsTpl:getTabId(_productsTpl:getTplById(_productsTpl:getProductByGroupAndReward(groupId, self.bind.accessoryConfigId)))
    L_UI:open("pageProductAccessory", {
      buildingGuid = buildingId,
      selectTabId = tab,
      selProductId = _productsTpl:getProductByGroupAndReward(groupId, self.bind.accessoryConfigId)
    })
  end
end

return this

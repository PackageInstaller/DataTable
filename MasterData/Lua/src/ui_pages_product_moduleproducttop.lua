local this = class("moduleProductTop", G_UIModuleBase)
local _HomeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _HomeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()

function this.bind()
  return {
    txt_buildName = "",
    txt_buildLevel = "",
    toggle_lvMax = false,
    active_canUpgrade = false
  }
end

function this.methods()
  return {
    onClick_upgrade = function(self)
      if self.bind.toggle_lvMax then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_home_manage_13"))
        return
      end
      L_UI:open("pageBuildingUpgrade", {
        guid = self._guid
      })
    end
  }
end

function this:open()
  function self._refreshView()
    self:refreshInfo()
  end
  
  L_HomeStore:listenCallFunc(L_HomeStore.event.syncWorldMapHomeItem, self._refreshView)
end

function this:close()
  L_HomeStore:unListenCallFunc(L_HomeStore.event.syncWorldMapHomeItem, self._refreshView)
end

function this:initModule(guid)
  self._guid = guid
  self._data = L_HomeStore:getHomeBuildingByGuid(guid)
  self:refreshInfo()
end

function this:refreshInfo()
  if not self._guid then
    return
  end
  local buildTpl = _HomeBuildingTpl:getTplById(self._data.build_id)
  local groupId = _HomeBuildingTpl:getGroupId(buildTpl)
  local groupTpl = _HomeBuildingGroupTpl:getTplById(groupId)
  local isMax = math.isEmpty(_HomeBuildingTpl:getNextLevel(buildTpl))
  self.bind.txt_buildName = _HomeBuildingGroupTpl:getName(groupTpl)
  self.bind.toggle_lvMax = isMax
  self.bind.txt_buildLevel = string.concat("Lv.", _HomeBuildingTpl:getLevel(buildTpl))
  self.bind.active_canUpgrade = false
end

return this

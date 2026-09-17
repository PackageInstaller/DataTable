local module = class("moduleHomeCenterCrop", require("ui.pages.home.homeCenter.moduleHomeCenterToggleModule"))

function module.bind()
  return {
    grl_homeCrop = {
      moduleName = "pages/home/homeCenter/moduleHomeCenterCrop/cellHomeCropItem"
    }
  }
end

function module:registerListening()
  if self._isHadRegister then
    return
  end
  self._isHadRegister = true
  
  function self._eventHomeBuildSync()
    self:onEventMessageHomeBuildSync()
  end
  
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeBuildSync, self._eventHomeBuildSync)
end

function module:unRegisterListening()
  if not self._isHadRegister then
    return
  end
  self._isHadRegister = false
  C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeBuildSync, self._eventHomeBuildSync)
end

function module:show()
  self:registerListening()
  self:onRefreshBuildList()
end

function module:close()
  self:unRegisterListening()
  self._isOpenBranchPanel = false
  self._buildCount = nil
end

function module:onRefreshBuildList()
  if not self.isBind then
    return
  end
  local guidList = C_HomeUtil.GetAllBuildGuidByGroupId(L_HomeConst.HomeBuildGroupID.FARMING_HUT)
  local buildList = {}
  for i = 0, guidList.Count - 1 do
    local item = {
      index = i + 1,
      buildGuid = guidList[i]
    }
    table.insert(buildList, item)
  end
  self._buildCount = #buildList
  self.bind.grl_homeCrop:refresh_array(buildList)
end

function module:onRefreshBranchPanel()
  if not self._isOpenBranchPanel then
    return
  end
  self.modules.module_homeCenterBranchCrop:onRefreshAll()
end

function module:onEventMessageHomeBuildSync()
  self:onRefreshBuildList()
  self:onRefreshBranchPanel()
end

return module

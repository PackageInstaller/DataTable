local cell = class("cellHomeCropItem", G_UIModuleBase)
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local path = "UI/Texture/FrameTexture/tex_frame_build_farminghut.png"
local colorStatus = L_MapConst.CollectionStatusColor
local statusIcon = L_MapConst.CollectionStatusIcon

function cell.bind()
  return {
    active_select = true,
    active_work = false,
    toggleFullStatus = nil,
    img_productIcon = "",
    txt_index = "",
    txt_buildingName = "",
    img_building = "",
    buildFrameTexture = L_Const.ModuleInfo.FrameTexture,
    rl_pet = {
      moduleName = "pages/home/homeCenter/moduleHomeCenterCrop/cellHomeCropPetSlotItem"
    },
    text_workStatus = "",
    statusIconShow = false,
    statusIcon = ""
  }
end

function cell.methods()
  return {
    onClick_rewardIcon = function(self)
      self:onClickRewardIcon()
    end,
    onClick_buildingIcon = function(self)
      self:onClickBuildingIcon()
    end
  }
end

function cell:onSetData(param)
  self._buildGuid = param.buildGuid
  self._index = param.index
end

function cell:open()
  self:onSetData(self.bind)
end

function cell:close()
end

function cell:show()
end

function cell:hide()
  L_TimerManager:stopTimer(self, "petGif")
end

function cell:refresh()
  self:onRefreshCell()
end

function cell:onRefreshCell()
  if self._buildGuid == nil then
    return
  end
  self.bind.txt_index = string.format("N0.%s", tostring(self._index))
  self._buildingData = C_HomeUtil.GetBuildData(self._buildGuid)
  if self._buildingData == nil then
    return
  end
  local buildId = self._buildingData.buildId
  local buildTpl = _homeBuildingTpl:getTplById(buildId)
  self.bind.txt_buildingName = _homeBuildingTpl:getName(buildTpl)
  local buildFrameId = _homeBuildingTpl:getFrameTexture(buildTpl)
  self.modules.buildFrameTexture:setFrameId(buildFrameId)
  self.bind.img_building = ""
  local petList = {}
  for i = 1, 3 do
    local item = {
      slotIndex = i,
      buildGuid = self._buildGuid
    }
    table.insert(petList, item)
  end
  self.bind.rl_pet:refresh_array(petList)
  self._rewardList = self._buildingData.auto.rewards
  local rewardCount = self._rewardList.Count
  if 0 < rewardCount then
    self.bind.active_work = true
    local commonItem = self._rewardList[0]
    local conf = L_ItemTplManager:getCommonItem(commonItem.itemId)
    self.bind.img_productIcon = conf.icon
  else
    self.bind.active_work = false
  end
  self._autoWorkData = self._buildingData.auto
  local autoWorkPetGuidList = {}
  if self._autoWorkData.plantPetGuid ~= 0 then
    table.insert(autoWorkPetGuidList, self._autoWorkData.plantPetGuid)
  end
  if self._autoWorkData.waterPetGuid ~= 0 then
    table.insert(autoWorkPetGuidList, self._autoWorkData.waterPetGuid)
  end
  if self._autoWorkData.harvestPetGuid ~= 0 then
    table.insert(autoWorkPetGuidList, self._autoWorkData.harvestPetGuid)
  end
  local isWorking = false
  for _, petGuid in pairs(autoWorkPetGuidList) do
    local csPetData = L_PetStore:getCsPetData(petGuid)
    if csPetData ~= nil then
      isWorking = L_PetStore:getWorkBuildingGuid(csPetData) ~= 0 and L_PetStore:getPetAutoWorkStatus(csPetData) == L_Const.PetFSMStateType.PFST_WORK
    end
  end
  local text = L_WordsTpl:getValue(isWorking and "notice_cellHomeCenterCollection_01" or "ui_cellFastProductQueue_02")
  local status = isWorking and L_MapConst.CollectionStatus.Working or L_MapConst.CollectionStatus.Free
  self.bind.text_workStatus = L_GameUtil.fillColor(text, colorStatus[status])
  self.bind.statusIconShow = not string.isEmpty(statusIcon[status])
  self.bind.statusIcon = statusIcon[status]
  if not isWorking then
    self.modules.buildFrameTexture:setFrameId(0)
    self.bind.img_building = _homeBuildingTpl:getBuildingPixelIcon(buildTpl)
  end
end

function cell:close()
  self._buildGuid = nil
  self._index = nil
end

function cell:onClickRewardIcon()
  if self._buildingData and self._buildingData.auto then
    self._buildingData.auto:Req_GetReward()
  end
end

function cell:onClickBuildingIcon()
  L_UI:open("pageHomeCropPet", {
    buildingGuid = self._buildGuid,
    buildType = L_Const.WorldMapBuildType.WMBT_FIELD_HOUSE
  })
end

return cell

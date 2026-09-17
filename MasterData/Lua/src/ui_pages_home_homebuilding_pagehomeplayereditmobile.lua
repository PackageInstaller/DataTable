local this = class("pageHomePlayerEditMobile", G_UIPageBase)
local _BlockTpl = L_GameTpl:getHomeBlockTpl()
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _homeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
local _liftAudio = "Play_SFX_System_FB_Home_Building_Lift"
local _dropAudio = "Play_SFX_System_FB_Home_Building_Drop"
local HomeBuildPutState = CS.Lens.Gameplay.Home.HomeBuildPutState
local editMode = {
  none = -1,
  create = 0,
  set = 1,
  move = 2,
  onlyMove = 3
}

function this.bind()
  return {
    goEditNode = true,
    toggleSure = true,
    goGarbage = false,
    module_belt = {
      moduleName = "pages/home/homeBag/moduleHomeBeltPlatform"
    },
    go_tipSet = false,
    txt_tipSet = ""
  }
end

function this.methods()
  return {
    onClick_exit = function(self)
      self:exit()
    end,
    onClick_cancel = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_garbage = function(self)
      self:unLocateBuilding()
    end,
    onClick_rotate = function(self)
      self:onClick_rotate()
    end,
    onClick_sure = function(self)
      self:locateHomeBuilding()
    end,
    onClick_jump = function(self)
      self:OnEvent_Btn_Jump()
    end
  }
end

function this:check(options, callback)
  local currBlockId, currGridId = AzurWorld.HomeMgr:GetInteractBlockIdAndGridIdWithPlayerByOffset()
  local blockTpl = _BlockTpl:getTplById(currBlockId)
  local curBlock
  if blockTpl and _BlockTpl:getBlockType(blockTpl) == L_HomeConst.blockType.BUILD and C_HomeUtil.GetIsBlockUnlock(currBlockId) then
    self._manager = AzurWorld.HomeMgr
    curBlock = self._manager:GetHomeBlock(currBlockId)
  end
  if curBlock then
    if options.buildingId then
      local checkFieldHouse = C_HomeUtil:CheckFieldHouseAbleToPut(curBlock, options.buildingId)
      if not checkFieldHouse then
        callback(false)
        return
      end
    end
    callback(true)
  else
    callback(false)
  end
end

function this:computeCurBlock()
  local currBlockId, currGridId = AzurWorld.HomeMgr:GetInteractBlockIdAndGridIdWithPlayerByOffset()
  local lastBlockId = self.curBlockId
  self.curBlockId = currBlockId
  self._blockList = self._blockList or {}
  self._blockList[currBlockId] = currBlockId
  if self.curBlockId ~= lastBlockId then
    if self.curBlockId == 0 then
      self._manager:SetFocusBlock(0)
      if self._curBlock ~= nil and self.entity == nil then
        self._curBlock = nil
      else
      end
    else
      self._curBlock = self._manager:GetHomeBlock(self.curBlockId)
      self._manager:SetFocusBlock(self._curBlock.blockId)
      if self.buildingId then
        self:doEditEntity(self.buildingId)
      elseif self.entity then
        self:doMoveEntity(self.entity)
      end
    end
  end
end

function this:created(...)
  this.super.created(self, ...)
  local addModuleGeneric = xlua.get_generic_method(self.csharpPage:GetType(), "AddModule", 1)
  local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.ModuleBattleDodgeSkillBtnMobile, CS.UnityEngine.GameObject)
  self.dodgeSkillBtn = addModule(self.csharpPage, self.csharpPage, self.bindComponents.moduleBattleDodgeSkillBtnMobile.gameObject)
  self.skillCDTimer = CS.Lens.Gameplay.UI.SkillCdTimer()
  self.dodgeSkillBtn:BindTimer(self.skillCDTimer)
end

function this:preOpen(options)
  self.modules.module_belt:setBelt(L_Const.HomeShortcutBarType.HSBT_BUILD, false, {
    onClickCell = function(buildingId)
      self:onBeltClick(buildingId)
    end
  })
  AzurWorld.HomeMgr:OnEnterBuildEditorModel()
  this.super.preOpen(self, options)
  options = options or {}
  self._checkTime = 0
  self._checkOut = false
  self.buildingId = options.buildingId
  self.entity = options.entity
  local moveBuildGroupId = self.entity and 0 < self.entity.buildId and _homeBuildingTpl:getTplById(self.entity.buildId).groupId or 0
  local moveBuildType = 0 < moveBuildGroupId and _homeBuildingGroupTpl:getTplById(moveBuildGroupId).type or nil
  self.isFarmland = moveBuildType == L_Const.WorldMapBuildType.WMBT_FIELD_NEW or moveBuildType == L_Const.WorldMapBuildType.WMBT_FIELD_NEW2
  self:computeCurBlock()
  if self.buildingId == nil and self.entity == nil then
    errorf(L_WordsTpl:getValue("notice_pageHomePlayerEdit_02"))
  end
  self.hadBuildChanger = false
end

function this:show()
  self:initEditView()
  self:registerPosJoyStick()
end

function this:hide()
  self.bindComponents.joystick:ResetState()
  if L_CommonUtil.isValid(self.oldJoyStick) then
    L_GameUtil.setJoyStick(self.oldJoyStick)
    self.oldJoyStick = nil
  end
end

function this:registerPosJoyStick()
  if L_CommonUtil.isValid(self.oldJoyStick) then
    return
  end
  self.oldJoyStick = L_GameUtil.getJoyStick()
  L_GameUtil.setJoyStick(self.bindComponents.joystick)
end

function this:onBeltClick(buildingId)
  if self._buildMode ~= editMode.set or buildingId == 0 then
    return
  end
  if self._curBlock ~= nil then
    local checkFieldHouse = C_HomeUtil:CheckFieldHouseAbleToPut(self._curBlock, buildingId)
    if not checkFieldHouse then
      return
    end
  end
  local build = L_HomeStore:getBuildingInBag(buildingId)
  local restNum = build.total_num - build.used_num
  if restNum == 0 then
    return
  end
  self.buildingId = buildingId
  self:doEditEntity(self.buildingId)
end

function this:doEditEntity(buildingId)
  self._buildMode = editMode.set
  AzurWorld.HomeMgr.BlockModule:OnSetDefaultEditBuild(buildingId)
  local editEntity = AzurWorld.HomeMgr.BlockModule.DefaultEditBuild
  editEntity.buildId = buildingId
  if not self.isSetBuildLocate then
    local _, cameraY, _ = C_CameraManager.mainCamera.transform:GetEulerAngles()
    editEntity:SetLocate(C_Vector2(0, 0), (math.floor((cameraY + 45) % 360 / 90) + 2) % 4)
    self:setCurSelectedEntity(editEntity, true)
  end
  self.isSetBuildLocate = true
end

function this:doMoveEntity(entity)
  if L_HomeStore:getStatusByGuid(entity.guid) == L_Const.WorldMapBuildStatusType.WMBST_NORMAL then
    self._buildMode = editMode.move
  else
    self._buildMode = editMode.onlyMove
  end
  self:setCurSelectedEntity(entity, true)
end

function this:exit()
  L_UI:close(self.pageName)
end

function this:open(options)
  this.super.open(self, options)
  if self.skillCDTimer ~= nil then
    self.skillCDTimer:StartTimer()
  end
end

function this:close(options)
  if self.skillCDTimer ~= nil then
    self.skillCDTimer:StopTimer()
  end
  if not self.hadBuildChanger then
    self:resetInitPos()
  end
  AzurWorld.HomeMgr:OnExitBuildEditorModel()
  self._buildMode = nil
  self._manager:SetFocusBlock(0)
  AzurWorld.HomeMgr.BlockModule:SetEditBuild(nil)
  self:setCurSelectedEntity(nil, not self.hadBuildChanger)
  self.isSetBuildLocate = nil
  self._blockList = nil
  self._curBlock = nil
  self.hadBuildChanger = nil
  self.buildingId = nil
  self.entity = nil
end

function this:resetInitPos()
  local entity = self._curSelectBuild
  if entity == nil then
    return
  end
  entity:RefreshBuildState()
end

function this:resetSelection()
  self._buildMode = editMode.none
  self:setCurSelectedEntity(nil, true)
end

function this:setCurSelectedEntity(select, resetLastBuild)
  if self._curSelectBuild == select then
    return
  end
  if resetLastBuild == nil then
    resetLastBuild = true
  end
  self._curSelectBuild = select
  AzurWorld.HomeMgr.BlockModule:SetEditBuild(select)
end

function this:initEditView()
  local tpl = _homeBuildingTpl:getTplById(self._curSelectBuild.buildId)
  local groupId = _homeBuildingTpl:getGroupId(tpl)
  local groupTpl = _homeBuildingGroupTpl:getTplById(groupId)
  local isCanGarbage = _homeBuildingGroupTpl:getIsStorable(groupTpl)
  self.bind.goGarbage = self._buildMode == editMode.move and isCanGarbage
  L_AudioUtil.playSound(_liftAudio)
end

function this:getContinueInfo()
  local buildingId = self._curSelectBuild:getBuildingId()
  local buildingInfo = L_HomeStore:getBuildingInBag(buildingId)
  if buildingInfo.total_num - buildingInfo.used_num >= 1 then
    return true
  end
  return false
end

local setType2Tip = {
  [HomeBuildPutState.OVERLAP_BUILD] = "notice_home_arrange_tip_1",
  [HomeBuildPutState.OUT_OF_AREA] = "notice_home_arrange_tip_2",
  [HomeBuildPutState.OVERLAP_BARRIER] = "notice_home_arrange_tip_8",
  [HomeBuildPutState.OVERLAP_MINE] = "notice_home_arrange_tip_9"
}

function this:refreshTips()
  self.bind.go_tipSet = false
  if self._checkOut then
    self.bind.go_tipSet = true
    self.bind.txt_tipSet = L_WordsTpl:getValue("notice_home_arrange_tip_6", {
      [0] = tostring(math.floor(5 - self._checkTime))
    })
  elseif self._curSelectBuild then
    local setType = self._curSelectBuild:GetPutState()
    self.bind.toggleSure = setType == HomeBuildPutState.SUCCESS
    if setType ~= HomeBuildPutState.SUCCESS then
      self.bind.go_tipSet = true
      self.bind.txt_tipSet = L_WordsTpl:getValue(setType2Tip[setType])
    end
  end
end

function this:locateHomeBuilding()
  if self._curSelectBuild == nil then
    return
  end
  if self._curSelectBuild:GetPutState() ~= HomeBuildPutState.SUCCESS then
    return
  end
  if self._curSelectBuild.buildId and self._curBlock ~= nil then
    local checkFieldHouse = C_HomeUtil:CheckFieldHouseAbleToPut(self._curBlock, self._curSelectBuild.buildId, self._curSelectBuild.guid)
    if not checkFieldHouse then
      return
    end
  end
  self.hadBuildChanger = true
  if self._buildMode == editMode.set then
    local buildingId = self._curSelectBuild.buildId
    local blockId, gridId, rotId = self._curBlock.blockId, self._curSelectBuild.gridId, self._curSelectBuild.rotId
    L_HomeStore:req_locateBuilding(nil, buildingId, blockId, gridId, rotId, function()
    end)
    self:exit()
  elseif self._buildMode == editMode.move or self._buildMode == editMode.onlyMove then
    local targetEntity = self._curSelectBuild
    local guid, blockId, gridId, rotId = self._curSelectBuild.guid, self._curBlock.blockId, self._curSelectBuild.gridId, self._curSelectBuild.rotId
    if self.isFarmland then
      self.entity:ReqRelocateNxNTree()
      self:exit()
    else
      L_HomeStore:req_locateBuilding(guid, nil, blockId, gridId, rotId, function()
        targetEntity:PlaySmoke()
        L_AudioUtil.playSound(_dropAudio)
      end)
      self:exit()
    end
  end
end

function this:unLocateBuilding()
  if self.isFarmland then
    return
  end
  if self._curSelectBuild == nil then
    return
  end
  local csServerData = self._curSelectBuild:GetStoreData()
  local serverData = L_HomeStore:getHomeBuildingByGuid(self._curSelectBuild.guid)
  if not serverData then
    return
  end
  if serverData.status == L_Const.WorldMapBuildStatusType.WMBST_PRODUCT then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageHomePlayerEdit_03"))
    return
  elseif csServerData:GetGroupConfig().type == L_Const.WorldMapBuildType.WMBT_FIELD_NEW and csServerData.crop.seedId ~= 0 then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageHomePlayerEdit_04"))
    return
  elseif csServerData:GetGroupConfig().type == L_Const.WorldMapBuildType.WMBT_FIELD_HOUSE and (csServerData.auto.plantPetGuid ~= 0 or csServerData.auto.waterPetGuid ~= 0 or csServerData.auto.harvestPetGuid ~= 0) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageHomePlayerEdit_05"))
    return
  elseif csServerData:GetGroupConfig().type == L_Const.WorldMapBuildType.WMBT_DORM then
    local csHomeStore = AzurWorld.HomeMgr:GetHomeStore()
    local hadPlayerInDorm = csHomeStore:OnCheckHadPlayerInDormByBuildGuid(self._curSelectBuild.guid)
    if hadPlayerInDorm then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_home_dorm_cannotstore"))
      return
    end
  else
    local buildType = L_HomeManager:getBuildTypeById(serverData.build_id)
    if buildType == L_Const.WorldMapBuildType.WMBT_PET_CANTEEN and (0 < L_SatietyManager:getBuildingSatiety(serverData.guid) or L_SatietyManager:isBuildingHasPetEating(serverData.guid)) then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_moduleHomeBagCropInfo_01"))
      return
    end
  end
  local tpl = _homeBuildingTpl:getTplById(self._curSelectBuild.buildId)
  local groupId = _homeBuildingTpl:getGroupId(tpl)
  local groupTpl = _homeBuildingGroupTpl:getTplById(groupId)
  local isCanGarbage = _homeBuildingGroupTpl:getIsStorable(groupTpl)
  if not isCanGarbage then
    return
  end
  if csServerData:GetGroupConfig().type == L_Const.WorldMapBuildType.WMBT_HOME_COLLECT then
    local csHomeStore = AzurWorld.HomeMgr:GetHomeStore()
    local collectionList = csHomeStore.HomeCollectModule:GetCollectCommonItemRewardList(self._curSelectBuild.guid)
    if 0 < collectionList.Count then
      do
        local data = {
          txtContent = L_WordsTpl:getValue("ui_home_collection_16"),
          confirmCallback = function()
            local function cbFunc()
              csHomeStore.HomeCollectModule:ReqCollectTarget(self._curSelectBuild.guid, function(errCode, rspData)
                if errCode == L_Const.errorCode.ErrCodeSucc then
                  L_HomeStore:req_BuildUnlocate(self._curSelectBuild.guid, function()
                    self:exit()
                  end)
                  self:setCurSelectedEntity(nil, false)
                end
              end, true)
            end
            
            FrameScheduler.add(cbFunc, 1)
          end
        }
        L_GameUtil.showCommonTip(data)
        return
      end
    end
  end
  L_HomeStore:req_BuildUnlocate(self._curSelectBuild.guid, function()
    self:exit()
  end)
  self:setCurSelectedEntity(nil, false)
end

function this:onClick_rotate()
  if self.isFarmland then
    return
  end
  local entity = self._curSelectBuild
  local direction = entity.rotId
  direction = (direction + 1) % 4
  entity:SetLocate(entity.gridPos, direction)
  self._curBlock:OnUpdate()
end

function this:update()
  self:outCheck()
  self:refreshTips()
end

function this:outCheck()
  local isIn = true
  if self._curBlock == nil then
    isIn = false
  else
    local playerRelativeGridPos = self._curBlock:GetPlayerRelativeGridPos()
    isIn = self._curBlock:CheckRelativeGridPosIsInBlockArea(playerRelativeGridPos)
  end
  self._checkOut = not isIn
  if isIn then
    self._checkTime = 0
  end
  if self._checkOut then
    if self._timerFrame == nil then
      self._timerFrame = 0
    end
    local deltaTime = Unity.Time.deltaTime
    self._timerFrame = self._timerFrame + deltaTime
    self._checkTime = self._checkTime + deltaTime
  end
  if self._checkTime > 0 then
    if self._timerFrame >= 0.3 then
      self._timerFrame = 0
      self:computeCurBlock()
    end
    if self._checkTime >= 5 then
      self:exit()
    end
  end
end

function this:OnEvent_Btn_Jump()
  L_PlayerManager:fireJump()
end

return this

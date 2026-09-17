local cls = class("cellPetEggItem", G_UIModuleBase)

function cls.bind()
  return {
    txtPetEggName = "",
    imageIcon = "",
    activeHatching = false,
    activeInQueue = false,
    activeSelect = false,
    activeHatched = false,
    active_content = false
  }
end

function cls.methods()
  return {
    onClick = function(self)
      if math.isEmpty(self.guid) then
        return
      end
      self:emit("onClick_selectId", self.guid)
    end
  }
end

function cls:setSelect(state)
  if state == true then
    C_MJLog.LogImportant("[家园生产] cellPetEggItem 选择奇波蛋 guid :" .. self.guid .. ", 奇波蛋名字:" .. self.bind.txtPetEggName, C_ELogModule.Home)
  end
  self.bind.activeSelect = state
end

function cls:refreshView(guid, buildGuid)
  self.guid = guid
  self.buildGuid = buildGuid
  self:setPetEggDataContent(guid, buildGuid)
end

function cls:setPetEggDataContent(guid, buildGuid)
  if math.isEmpty(guid) then
    self.bind.active_content = false
    return
  end
  self.bind.active_content = true
  local petEggData = L_PetStore:getPetEggItem(guid)
  if not petEggData then
    errorf("宠物蛋数据不存在 uid = " .. tostring(guid))
    return
  end
  local petEggConf = L_ItemTplManager:getPetEggItem(petEggData.configId, guid)
  self.bind.imageIcon = petEggConf.icon
  self.bind.txtPetEggName = petEggConf.name
  local productGuid = L_ProductManager:getProductGuidBySpecialGuid(buildGuid, guid)
  local state = L_ProductManager:getProductState(buildGuid, productGuid)
  if state ~= L_HomeConst.ProductQueueState.NONE then
    self.bind.activeHatching = state == L_HomeConst.ProductQueueState.RUNNING
    self.bind.activeInQueue = state == L_HomeConst.ProductQueueState.WAITING
    self.bind.activeHatched = state == L_HomeConst.ProductQueueState.FINISH
    L_TimerManager:newOrResetTimer(self, "refresh", function()
      self:refreshView(self.guid, self.buildGuid)
    end, 1, -1)
  else
    self.bind.activeHatching = false
    self.bind.activeInQueue = false
    self.bind.activeHatched = false
    L_TimerManager:clearTimer(self)
  end
end

function cls:close()
  L_TimerManager:clearTimer(self)
end

return cls

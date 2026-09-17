local this = class("pageMountRidingInfo", G_UIPageBase)
local _petTpl = L_GameTpl:getPetTpl()
local _mountTpl = L_GameTpl:getMountTpl()

function this.bind()
  return {
    txt_name = nil,
    module_pixelPet = {
      moduleName = "pages/pet/modulePetPixelIcon"
    },
    module_moveType = {
      moduleName = "pages/mount/moduleMountMoveType"
    },
    list_condition = {
      moduleName = "pages/mount/cellMountRidingCondition"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
      L_MountStore:call(L_MountStore.event.mountLockRideShow)
    end,
    onClick_viewDetail = function(self)
      local pet = L_PetStore:getPetItem(self._petId)
      local tpl_mount = _mountTpl:getTplById(pet.id)
      L_UI:open("pageHomeLevelInfo", {
        defaultSelectItemType = L_HomeConst.HomeLevelUnlockModuleType.MountSaddle,
        defaultSelectItemId = _mountTpl:getUnlock(tpl_mount)
      })
    end
  }
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.MountRiding)
  callback(result)
end

function this:preOpen(options)
  self._petId = options.petId
  self.isUnLock = options.isUnLock
  self:initPage()
end

function this:close()
  L_TimerManager:clearTimer(self)
end

function this:initPage()
  local pet = L_PetStore:getPetItem(self._petId)
  self.bind.txt_name = pet.pet_name
  local moduleMoveType = self.modules.module_moveType
  moduleMoveType:setData(self._petId)
  local modulePixelIcon = self.modules.module_pixelPet
  modulePixelIcon:setGuid(self._petId, true)
  local tpl_mount = _mountTpl:getTplById(pet.id)
  if tpl_mount == nil then
    printf(string.format("mountTpl的PetId: %d 不存在" .. pet.id))
    return
  end
  local mount_saddleId = _mountTpl:getHomeLevelShow(tpl_mount)
  local _productsTpl = L_GameTpl:getProductsTpl()
  local productId = _productsTpl:getRewardProductMapById(mount_saddleId)
  if productId == 0 then
    printf(string.format("ProductsTpl没有此鞍具 %d 的数据", mount_saddleId))
    return
  end
  local product = _productsTpl:getTplById(productId)
  if product == nil then
    printf(string.format("ProductsTpl没有此Id %d", productId))
    return
  end
  local unlockCondition = _productsTpl:getUnlockCondition(product)
  if unlockCondition == nil then
    printf(string.format("ProductsTpl没有此解锁条件"))
    return
  end
  local isConCompleted = L_ConditionManager:isComplete(unlockCondition)
  local isItemGet, itemId = L_MountManager:getIsMountUnlock(self._petId)
  local tplData = L_ItemTplManager:getMountSaddleItem(itemId)
  local playUnlockConditionAudio = isConCompleted or self.isUnLock
  local tmp = {
    {
      txt_desc = L_GameUtil.fillColor(L_ConditionManager:getSingleDesc(unlockCondition[1]), isConCompleted and L_Const.colorHtml.green001 or L_Const.colorHtml.grey006),
      txt_desc_1 = L_ConditionManager:getSingleDesc(unlockCondition[1]),
      go_completed = isConCompleted,
      isUnLock = isConCompleted
    },
    {
      txt_desc = L_GameUtil.fillColor(L_WordsTpl:getValue("petsaddle_make", {
        name = tplData.name
      }), isItemGet and L_Const.colorHtml.green001 or L_Const.colorHtml.grey006),
      txt_desc_1 = L_WordsTpl:getValue("petsaddle_make", {
        name = tplData.name
      }),
      go_completed = isItemGet,
      isUnLock = self.isUnLock
    }
  }
  L_AudioUtil.playSound("Play_SFX_System_HUD_MounRidingInfo_Open", nil, nil, false)
  if self.isUnLock then
    L_AudioUtil.playSound("Play_SFX_System_HUD_MounRidingInfo_Unlock", nil, nil, false)
    L_TimerManager:newOrResetTimer(self, "VFX_pagemounridinginfo", function()
      self.bindComponents.anim_pagemounridinginfo:Play("anim_pagemounridinginfo_impress")
    end, 0.5)
  end
  self.bind.list_condition:clear()
  self.bind.list_condition:insert_array(tmp)
  if playUnlockConditionAudio then
    L_AudioUtil.playSound("Play_SFX_System_HUD_MounRidingInfo_Achieve", nil, nil, false)
  end
end

return this

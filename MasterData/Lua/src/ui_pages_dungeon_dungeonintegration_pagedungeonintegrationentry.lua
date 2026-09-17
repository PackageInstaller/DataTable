local this = class("pageDungeonIntegrationEntry", G_UIPageBase)
local STAMINA_RESOURCE_BAR_ITEM_TPL_ID = 400

function this.bind()
  return {
    moduleCurrency = {
      moduleName = "modulePages/moduleCurrency"
    },
    moduleDungeonDesc = {
      moduleName = "pages/dungeon/dungeonIntegration/moduleDungeonDesc"
    },
    moduleDungeonEntry = {
      moduleName = "pages/dungeon/dungeonIntegration/moduleDungeonEntry"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close("pageDungeonIntegrationEntry")
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.chooseDoorId = options.doorId
  self:loadVirtualCamera(options.entity)
  self:initPage()
end

function this:initPage()
  self:initModulesCodeJump()
  self:initStaminaCurrency()
  self.modules.moduleDungeonDesc:initParent(self)
  self.modules.moduleDungeonEntry:initParent(self)
  self.modules.moduleDungeonDesc:initData(self.chooseDoorId and {
    self.chooseDoorId
  })
  self.modules.moduleDungeonDesc:initUI()
  self.modules.moduleDungeonDesc:initFirstClick()
  local blurBackground = self.bindComponents.blurBackground
  if blurBackground ~= nil and not self.chooseDoorId then
    blurBackground.enabled = false
    blurBackground.useStaticBackground = true
    blurBackground.enabled = true
  end
end

function this:check(options, callback)
end

function this:close(options)
  self:unloadVirtualCamera()
end

function this:onClickDungeonDescCard(doorId)
  self.modules.moduleDungeonEntry:initData(doorId, not self.chooseDoorId)
  self.modules.moduleDungeonEntry:initUI()
end

function this:initModulesCodeJump()
  self.modules.moduleDungeonDesc = self.modules.moduleDungeonDesc
  self.modules.moduleDungeonEntry = self.modules.moduleDungeonEntry
end

function this:initStaminaCurrency()
  self.modules.moduleCurrency = self.modules.moduleCurrency
  self.modules.moduleCurrency:refreshResByResBarTplIdList({STAMINA_RESOURCE_BAR_ITEM_TPL_ID})
end

function this:loadVirtualCamera(entity)
  if self.chooseDoorId then
    C_CameraManager.ActivateTactics(C_ECameraType.Dungeon, C_CinemachineBlendType.EaseIn, 800)
    local cameraController = C_CameraManager.GetTactics(C_ECameraType.Dungeon)
    cameraController:SetDungeonDoorId(entity:GetTransform(), self.chooseDoorId)
  end
end

function this:unloadVirtualCamera()
  if self.chooseDoorId then
    C_CameraManager.DeactivateTactics(C_ECameraType.Dungeon)
  end
end

return this

local this = class("pageStandeeShoot", G_UIPageBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local scenePath = "Program/UIScene/pre_ui_standeeShoot.prefab"

function this:created(obj, pageConfig)
  this.super.created(self, obj, pageConfig)
end

function this:preBind()
  return {}
end

function this:bind()
  return {
    module_commonTop = {
      moduleName = "modulePages/moduleCommonTop"
    },
    listHeroHeads = {
      moduleName = "modulePages/cellHeroHeadItemCircle"
    },
    module_actionSelect = {
      moduleName = "pages/standeeShoot/moduleStandeePhotoGroup_action"
    }
  }
end

function this:methods()
  return {
    listHeroHeads = {
      onClick = function(self, bind)
        if self.curSelectId == bind.id then
          return
        end
        self:onClick_heroItem(bind.id)
      end
    },
    onClick_btnShoot = function(self)
      self:shoot()
    end
  }
end

function this:check(options, callback)
  callback(true)
end

function this:preOpen(options)
  self:initHeroListData()
  self.slotId = options.slotId
  self:initCommonTopModule()
  self:initHeroList()
  self:initUIScene()
  if self.heroGuidList ~= nil and #self.heroGuidList > 0 then
    self:onClick_heroItem(self.heroGuidList[1])
  end
  CS.Lens.Gameplay.Setting.GameSettingUtil.SetCaptureSetting()
end

function this:initCommonTopModule()
  local data = {
    name = L_WordsTpl:getValue("notice_pagePhoto_02"),
    nameEn = "Photo",
    closeCurPage = handler(self, function(self)
      L_UI:close(self.pageName)
    end)
  }
  self.modules.module_commonTop:initModule(data)
end

function this:show(options)
end

function this:hide()
end

function this:close(options)
  self:releaseHeroModel()
  self:destroyUIScene()
  CS.Lens.Gameplay.Setting.GameSettingUtil.RevertCaptureSetting()
end

function this:destroy(options)
end

function this:initHeroListData()
  self.modeController = require("ui.pages.heroPanel.controller.heroListModeController").new()
  self.heroGuidList = {}
  for i, v in pairs(L_HeroStore:getAllHero()) do
    table.insert(self.heroGuidList, L_HeroStore:getHeroGuid(v))
  end
  self:sortHeroGuidList()
end

function this:initHeroList()
  local tempData = {}
  local formationData = self:getFormationData()
  for k, v in ipairs(self.heroGuidList) do
    local heroId = v
    local hero = self.modeController:getHero(heroId)
    local heroConfigId = L_HeroStore:getHeroConfigId(hero)
    local heroItem = L_ItemManager:parseHeroItem(heroConfigId)
    local heroHeadAvatarTexture = L_GameUtil.getAvatarTexturePath(heroConfigId, L_Const.resourceIndexOfAvatarTextureInHeroTpl.small)
    local tpl = _heroTpl:getTplById(heroConfigId)
    local rarity = _heroTpl:getRarity(tpl)
    local rarityTpl = L_RarityTpl:getTplById(rarity)
    local colorCfg = L_RarityTpl:getColorCircle(rarityTpl)
    for id, _ in pairs(formationData) do
      if id == heroId then
        colorCfg = "#eaffaa"
      end
    end
    local _, color = C_ColorUtility.TryParseHtmlString(colorCfg)
    table.insert(tempData, {
      id = heroId,
      selected = k == self.heroIndex,
      qualityColor = color,
      activeCarrer = false,
      isPhotoHead = true,
      blockCarrer = true
    })
  end
  self.bind.listHeroHeads:clear()
  self.bind.listHeroHeads:insert_array(tempData)
  if self.heroIndex then
    self.bindComponents.panelHeroHeads:FocusItemIndex(self.heroIndex - 1)
  end
end

function this:getFormationData()
  local formationType = L_FormationConst.FormationType.world
  local posData = L_FormationStore:getFormationPosData(formationType)
  local data = {}
  for i, guid in pairs(posData) do
    if not math.isEmpty(guid) then
      data[guid] = i
    end
  end
  return data
end

function this:sortHeroGuidList()
  self._heroId2FormationData = self:getFormationData()
  table.sort(self.heroGuidList, function(a, b)
    local heroDataA = self.modeController:getHero(a)
    local heroDataB = self.modeController:getHero(b)
    if heroDataA == nil or heroDataB == nil then
      return a < b
    end
    local configA = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroDataA))
    local configB = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroDataB))
    local isOutA = self._heroId2FormationData[a] or math.huge
    local isOutB = self._heroId2FormationData[b] or math.huge
    if isOutA ~= isOutB then
      return isOutA < isOutB
    end
    local priorityOrder = {
      function()
        return L_HeroStore:getHeroLevel(heroDataA), L_HeroStore:getHeroLevel(heroDataB)
      end,
      function()
        return configA.quality, configB.quality
      end,
      function()
        return L_HeroStore:getHeroStar(heroDataA), L_HeroStore:getHeroStar(heroDataB)
      end
    }
    for _, getPriorityValue in ipairs(priorityOrder) do
      local valueA, valueB = getPriorityValue()
      if valueA ~= valueB then
        return valueB < valueA
      end
    end
    return a < b
  end)
end

function this:onClick_heroItem(id)
  self.curSelectId = id
  for i, v in pairs(self.heroGuidList) do
    if v == self.curSelectId then
      self.bind.listHeroHeads:change(i, {selected = true})
    else
      self.bind.listHeroHeads:change(i, {selected = false})
    end
  end
  self:releaseHeroModel()
  local hero = self:createHero(id)
  self.curShowHero = hero
  self.modules.module_actionSelect:bindHero(hero)
end

function this:createHero(heroId)
  local heroServerData = L_HeroStore:getHero(heroId)
  local heroConfigId = L_HeroStore:getHeroConfigId(heroServerData)
  local clothingId = AzurWorld.heroMgr:GetUsingClothingId(heroId, heroConfigId)
  local isPlayerHero = false
  local unitId = L_GameUtil.getUnitIdByRole(clothingId, L_Const.roleType.hero)
  local heroModelPath = ""
  if unitId then
    heroModelPath = L_GameUtil.getAvatarModelPathByUnitId(unitId, L_Const.avatarModelIndex.UnitModel)
    isPlayerHero = heroServerData.type == L_Const.HeroType.HT_MAIN
  end
  local obj = C_UIMgr.uiLoader:Spawn(heroModelPath)
  obj.name = string.concat("hero_", heroId)
  local heroTrans = obj.transform
  obj:SetActive(true)
  obj.transform:SetParent(self.sceneData.heroPoint)
  L_Vector3.setLocalPos(heroTrans, L_Vector3.zero)
  L_Vector3.setLocalRot(heroTrans, L_Vector3.zero)
  local entity = L_EntityManager:generateSimpleHero(heroConfigId, obj, isPlayerHero, L_Const.avatarAnimatorConfigIndex.world, nil, C_EEntityEntranceType.StandeeShoot)
  if entity.biologyData then
    entity.biologyData.magicaClothActive = false
    entity.biologyData:UsePreviewLevel()
  end
  local hero = {
    gameObject = obj,
    entity = entity,
    id = heroId,
    configId = heroConfigId
  }
  return hero
end

function this:releaseHeroModel()
  local hero = self.curShowHero
  if hero == nil then
    return
  end
  self.curShowHero = nil
  hero.entity:onDestroy()
  if L_CommonUtil.isValid(hero.gameObject) then
    C_PrefabManager:RecycleByLoader(hero.gameObject)
  end
end

function this:initUIScene()
  self.sceneData = {}
  local sceneObj = L_ResPool:syncGameObject(scenePath)
  local sceneObjTrans = sceneObj.transform
  sceneObjTrans:SetParent(C_LuaUtility.GetRootNode())
  L_Vector3.setPos(sceneObjTrans, C_UIMgr.SceneLoadDefaultPosition)
  local heroPoint = sceneObjTrans:Find("Marks/heroPoint")
  local captureCam = sceneObjTrans:Find("Cameras/camera_standee/camera_capture"):GetComponent(typeof(CS.UnityEngine.Camera))
  self.sceneData.sceneObj = sceneObj
  self.sceneData.heroPoint = heroPoint
  self.sceneData.captureCam = captureCam
end

function this:destroyUIScene()
  if L_CommonUtil.isValid(self.sceneData.sceneObj) then
    C_GameObject.Destroy(self.sceneData.sceneObj)
  end
end

function this:shoot()
  self.sceneData.captureCam.gameObject:SetActive(true)
  local pos = L_Vector3.getAnchored(self.bindComponents.captureArea)
  local rect = C_Rect(pos.x, pos.y, 1920, 1080)
  local width = rect.width
  local height = rect.height
  local tex = CS.Azur.Gameplay.Core.Asset.AssetManager.Instance:NewTexture2D("pageStandeeShoot", 1920, 1080, Unity.TextureFormat.RGBA32, false, true)
  C_CameraCaptureUtil.CaptureFrameToTexture2D2(self.sceneData.captureCam, tex, rect)
  self.sceneData.captureCam.gameObject:SetActive(false)
  self.modules.module_actionSelect:pause()
  local hero = L_HeroStore:getHero(self.curSelectId)
  local configId = hero.configId
  L_UI:open("pageStandeePreview", {
    tex = tex,
    slotId = self.slotId,
    heroConfigId = configId,
    actionId = self.modules.module_actionSelect.actionId
  })
end

return this

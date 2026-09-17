local this = class("pageNoviceTask", G_UIPageBase)
local _unitTpl = L_GameTpl:getUnitTpl()
local PETSCENEPATH = "Program/UIScene/pre_activity_noviceTaskScene_ui_01.prefab"
local charactorUnitId = 103004
local charactorKiBoUnitId = 104004
local GUIDE_FX_LIGHT = "pre_petduel_guide_fx_light"

function this.bind()
  return {
    module_tabList = {
      moduleName = "pages/common/modules/moduleCommonTab"
    },
    kiboModuleTask = {
      moduleName = "pages/activityTask/moduleKiBoTask"
    },
    noviceModuleTask = {
      moduleName = "pages/activityTask/moduleNoviceTask"
    },
    active_novice = true,
    active_kibo = false
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      self:escHandle()
    end
  }
end

function this:check(options, callback)
  if AzurWorld.DungeonMgr:CheckIsInTeaching() then
    callback(false)
    return
  end
  callback(true)
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:initPage()
end

function this:initPage()
  self.data = {}
  self.data.currTypeTaskId = 1
  if C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.noviceDuelTask) and not self.isLock then
    self.isLock = true
  end
  self:initCharactorSceneAsync()
  self:initTabList()
  self.modules.noviceModuleTask:refreshModule()
end

function this:initTabList()
  local tabList = {
    [1] = {
      id = 1,
      name = L_WordsTpl:getValue("ui_newbie_task_name_02"),
      active_lock = false,
      reddotKey = L_ReddotManager.DotDef.GuideTaskManual
    },
    [2] = {
      id = 201,
      name = L_WordsTpl:getValue("ui_newbie_task_name"),
      active_lock = not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.noviceDuelTask),
      reddotKey = L_ReddotManager.DotDef.DuelTaskManual
    }
  }
  local selectIndex = self.selectType or 1
  self.modules.module_tabList:initData(tabList, function(tabId)
    if tabId == -1 then
      return
    end
    if tabId ~= 1 and not self.isLock then
      self.modules.module_tabList:setSelectTabId(self.selectType)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_systemMessage_16"))
      return
    end
    self:switchManual(tabId)
    self.selectType = tabId
  end, selectIndex)
end

function this:switchManual(titleType)
  if self.data.currTypeTaskId == titleType then
    return
  end
  if titleType ~= 1 then
    self.bindComponents.ani_pageNoviceTask:Stop()
    if L_DeviceTpl:getIsPc() then
      self.bindComponents.ani_pageNoviceTask:Play("anim_KT_in")
    else
      self.bindComponents.ani_pageNoviceTask:Play("anim_KT_in_mobile")
    end
    self.bgNovice:ActiveTrans(false)
    self.bgKiBo:ActiveTrans(true)
    self.guideFxLight:SetActive(true)
    self.charactorGo:SetActive(false)
    self.charactorKiBoGo:SetActive(true)
    self.data.currTypeTaskId = titleType
    self.bind.active_kibo = true
    self.bind.active_novice = false
    self.modules.kiboModuleTask:refreshModule()
  else
    self.bindComponents.ani_pageNoviceTask:Stop()
    if L_DeviceTpl:getIsPc() then
      self.bindComponents.ani_pageNoviceTask:Play("anim_NT_in")
    else
      self.bindComponents.ani_pageNoviceTask:Play("anim_NT_in_mobile")
    end
    self.bgNovice:ActiveTrans(true)
    self.bgKiBo:ActiveTrans(false)
    self.guideFxLight:SetActive(false)
    self.charactorGo:SetActive(true)
    self.charactorKiBoGo:SetActive(false)
    self.bind.active_kibo = false
    self.bind.active_novice = true
    self.data.currTypeTaskId = titleType
    self.modules.noviceModuleTask:refreshModule()
  end
end

function this:show()
  if L_CommonUtil.isValid(self.sceneGo) then
    self.sceneGo:SetActive(true)
  end
  C_UISceneManager.SetSceneVisible()
  if self.bind.active_kibo then
    self.bindComponents.ani_pageNoviceTask:Stop()
    if L_DeviceTpl:getIsPc() then
      self.bindComponents.ani_pageNoviceTask:Play("anim_KT_in")
    else
      self.bindComponents.ani_pageNoviceTask:Play("anim_KT_in_mobile")
    end
    return
  end
  if self._hasInitShown then
    self.modules.noviceModuleTask:refreshNoviceTaskAllImmediately()
    self.modules.noviceModuleTask:playListCellInVFX(0, 0)
    self.bindComponents.ani_pageNoviceTask:Stop()
    if L_DeviceTpl:getIsPc() then
      self.bindComponents.ani_pageNoviceTask:Play("anim_NT_in")
    else
      self.bindComponents.ani_pageNoviceTask:Play("anim_NT_in_mobile")
    end
  end
  self._hasInitShown = true
end

function this:hide()
  L_TimerManager:newOrResetTimer(self, "VFX_hideSceneGo", function()
    self.sceneGo:SetActive(false)
  end, 0.1)
end

function this:close()
  L_TimerManager:clearTimer(self)
  self:clearAnim()
  if L_CommonUtil.isValid(self.sceneGo) then
    C_UISceneManager.SetSceneVisible()
    C_GameObject.Destroy(self.sceneGo)
  end
  L_ResPool:destroyGo(self.charactorGo)
  L_ResPool:destroyGo(self.charactorKiBoGo)
  self.sceneGo = nil
  self.sceneCameraTrans = nil
  self.bgNovice = nil
  self.bgKiBo = nil
  self.charactorGo = nil
  self.charactorKiBoGo = nil
  self.guideFxLight = nil
  self.charactorEntity = nil
  self.charactorKiBoEntity = nil
end

function this:escHandle()
  if self.data.currTypeTaskId ~= 1 then
    self.bindComponents.ani_pageNoviceTask:Stop()
    if L_DeviceTpl:getIsPc() then
      self.bindComponents.ani_pageNoviceTask:Play("anim_KT_out")
    else
      self.bindComponents.ani_pageNoviceTask:Play("anim_KT_out_mobile")
    end
    L_TimerManager:newOrResetTimer(self, "TaskPageClose", function()
      L_LoadingManager:openSaveFormationLoading(nil, function()
        L_UI:close(self.pageName, nil, function()
          L_LoadingManager:closeLoading()
        end)
      end)
    end, 0.3)
  else
    L_LoadingManager:openSaveFormationLoading(nil, function()
      L_UI:close(self.pageName, nil, function()
        L_LoadingManager:closeLoading()
      end)
    end)
  end
end

function this:initCharactorSceneAsync()
  self.sceneGo = L_ResPool:syncGameObject(PETSCENEPATH)
  local sceneTrans = self.sceneGo.transform
  local bgRoot = sceneTrans:Find("BgRoot").transform
  self.sceneCameraTrans = sceneTrans:Find("camera")
  self.bgNovice = bgRoot:Find("BgFullScreen").gameObject
  self.bgKiBo = bgRoot:Find("BgFullScreen_KiBo").gameObject
  self.bgNovice:ActiveTrans(true)
  self.bgKiBo:ActiveTrans(false)
  sceneTrans:SetParent(C_LuaUtility.GetRootNode())
  L_Vector3.setPos(sceneTrans, C_UIMgr.SceneLoadDefaultPosition)
  L_Vector3.setRot(sceneTrans, L_Vector3.zero)
  local transPointChar = sceneTrans:Find("ModelRoot")
  
  local function loadCharacter(unitId, name)
    local tpl = _unitTpl:getTplById(unitId)
    local modelPath = _unitTpl:getModel(tpl, L_Const.avatarModelIndex.UnitModel)
    local go = L_ResPool:syncGameObject(modelPath, transPointChar)
    go.name = name
    return go
  end
  
  local charGo = loadCharacter(charactorUnitId, "charactor")
  local kiBoGo = loadCharacter(charactorKiBoUnitId, "charactorKiBo")
  self.charactorGo, self.charactorKiBoGo = charGo, kiBoGo
  self.guideFxLight = transPointChar:Find(GUIDE_FX_LIGHT).gameObject
  local anchorFit = transPointChar:GetComponent(typeof(CS.Lens.Gameplay.UI.CharacterAnchorFit))
  if L_CommonUtil.isValid(anchorFit) then
    anchorFit:SetBindObject(self.bindComponents.img_3dCharactorMask_2)
  end
  charGo.transform:SetParent(transPointChar)
  kiBoGo.transform:SetParent(transPointChar)
  
  local function createPreviewEntity(unitId, go, animation)
    local npc = require(L_EcsConst.aliveType.previewNpc).new(L_EcsConst.aliveType.previewNpc)
    local needAnimaList = {animation}
    npc:initPreview(unitId, go, nil, nil, needAnimaList)
    npc.playableAnimator:Play(animation)
    return npc
  end
  
  self.charactorEntity = createPreviewEntity(charactorUnitId, charGo, "Activity1")
  self.charactorKiBoEntity = createPreviewEntity(charactorKiBoUnitId, kiBoGo, "FormationIdle")
  if L_CommonUtil.isValid(anchorFit) then
    anchorFit:SetCharacterBounds()
  end
  
  local function setTransform(t, pos, rot, scale)
    if pos then
      L_Vector3.setLocalPos(t, pos)
    end
    if rot then
      L_Vector3.setLocalRot(t, rot)
    end
    if scale then
      L_Vector3.setScale(t, scale)
    end
  end
  
  setTransform(charGo.transform, C_Vector3(-0.04, 0, 0), L_Vector3.zero)
  setTransform(kiBoGo.transform, C_Vector3(0, -0.15, 0.1), C_Vector3(0, 30, 0), L_Vector3.getTemp(-1, 1, 1))
  C_CameraManager.SetBrainBlendStyle(L_Const.blendStyle.cut)
  local brain = C_CameraManager.GetMainCameraBrain()
  brain.m_CustomBlends = nil
  self.sceneGo:SetActive(true)
  self.guideFxLight:SetActive(false)
  kiBoGo:SetActive(false)
  L_LoadingManager:closeLoading()
end

function this:clearAnim()
  if self.charactorEntity then
    self.charactorEntity:onDestroy()
    self.charactorEntity = nil
  end
  if self.charactorKiBoEntity then
    self.charactorKiBoEntity:onDestroy()
    self.charactorKiBoEntity = nil
  end
end

return this

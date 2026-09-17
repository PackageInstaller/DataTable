local this = class("pageIllustratedbookMain", G_UIPageBase)
local SCENE_PATH = "Program/UIScene/pre_illustratedBookScene_ui_01.prefab"
local _illustrationMainTpl = L_GameTpl:getIllustratedhandbookMainTpl()

function this.bind()
  return {
    cellList_enter = {
      moduleName = "pages/illustratedbook/cellIllustratedbookEnter"
    },
    toggleModuleBar = {
      type = "toggleModule",
      moduleIllustrateLibraryBook = {
        assetName = "UI/Pages/LibraryBook/moduleIllustrateLibraryBook",
        moduleName = "pages/libraryBook/moduleIllustrateLibraryBook"
      },
      moduleIllustrateLibrarysoulessence = {
        assetName = "UI/Pages/IllustratedSoulEssence/moduleIllustratedSoulEssence",
        moduleName = "pages/illustratedSoulEssence/moduleIllustratedSoulEssence"
      },
      moduleIllustratedCharacter = {
        assetName = "UI/Pages/IllustratedCharacter/moduleIllustratedCharacter",
        moduleName = "pages/illustratedCharacter/moduleIllustratedCharacter"
      }
    },
    toggleModuleName = ""
  }
end

function this.methods()
  return {
    cellList_enter = {
      onClick = function(self, tpl)
        self:onEnterClick(tpl)
      end
    }
  }
end

function this:ctor()
  this.super.ctor(self)
  self.data = {
    uiCpt = {
      submodule = nil,
      canvasgroup_btn = nil,
      anim_detal = nil,
      anim = nil
    },
    list_enter = {}
  }
end

function this:preOpen(options)
  self.originTime = C_RealWeather.GetTimeOfDay()
  self.originTimeTick = C_RealWeather.GetTimeTick()
end

function this:open(options)
  this.super.open(self, options)
  if self.sceneGo == nil and self.sceneLoadHandle == nil then
    self.sceneLoadHandle = L_ResPool:asyncGameObject(SCENE_PATH, function(id, go)
      C_UISceneManager.SetSceneVisible()
      self.sceneGo = go
      self.sceneGo.transform:SetParent(C_LuaUtility.GetRootNode())
      L_Vector3.setPos(self.sceneGo.transform, C_UIMgr.SceneLoadDefaultPosition)
    end)
  end
  self:initPage()
end

function this:initPage()
  L_AudioUtil.playSound("Play_SFX_System_UI_Gallery_Open")
  self:initData()
  self:initTopBtn()
  C_RealWeather.SetTime(1650)
  C_RealWeather.SetTimeTick(0)
end

function this:close(options)
  this.super.close(self, options)
  if self.sceneLoadHandle then
    L_ResPool:destroyGo(self.sceneLoadHandle)
    self.sceneLoadHandle = nil
  end
  if L_CommonUtil.isValid(self.sceneGo) then
    C_GameObject.Destroy(self.sceneGo)
  end
  C_UISceneManager.SetSceneVisible()
  C_RealWeather.SetTime(self.originTime)
  C_RealWeather.SetTimeTick(self.originTimeTick)
end

function this:initData()
  local info = {}
  local data = _illustrationMainTpl:getData()
  for k, v in pairs(data) do
    local moduleName = _illustrationMainTpl:getPage(v)
    table.insert(info, {enterTpl = v})
  end
  table.sort(info, function(a, b)
    return a.enterTpl.areaId < b.enterTpl.areaId
  end)
  self.bind.cellList_enter:clear()
  self.bind.cellList_enter:insert_array(info)
end

function this:initTopBtn()
  C_IntegrateMgr.TopBarModule:SetTopBarCloseFunc(function()
    self:closeFunc()
  end)
end

function this:onEnterClick(enterTpl)
  local isLock = _illustrationMainTpl:getIsLock(enterTpl)
  local moduleName = _illustrationMainTpl:getPage(enterTpl)
  if isLock == 0 then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("residual_code_pageillustratedbookmain_01"))
    return
  end
  local module = self.modules.toggleModuleBar[moduleName]
  if module then
    self.bind.toggleModuleName = moduleName
    self.modules.toggleModuleBar[moduleName]:initPage(self.sceneGo)
    self:playAnimationReversed(self.bindComponents.anim, "anim_lllustrate_change", 1)
    self.modules.toggleModuleBar[moduleName]:setCloseFunc(function()
      self:submoduleCloseFunc()
    end)
  else
    error("未获取到子模块")
    return
  end
  self.inSubModule = true
  self.bindComponents.interactionMask.interactable = false
end

function this:playAnimationReversed(animComponent, clipName, speed)
  if not animComponent then
    error("未找到动画组件")
    return
  end
  local animState = self:getAnimationStateByName(animComponent, clipName)
  if not animState then
    error("未找到动画片段，检查名称是否正确")
    return
  end
  if animComponent:IsPlaying() and self:getAnimationStateByName(animComponent, clipName .. "_into") then
    self:playAnimationReversed(animComponent, clipName .. "_into")
  end
  speed = speed or 1
  animState.speed = speed
  if not animComponent:IsPlaying(clipName) then
    if 0 < speed then
      animState.time = 0
    else
      if speed < 0 then
        animState.time = animState.length
      else
      end
    end
  end
  print("播放动画：" .. clipName)
  L_AudioUtil.playSound("Play_SFX_System_UI_Gallery_Book_Open")
  animComponent:Play(clipName)
end

function this:getAnimationStateByName(animComponent, clipName)
  if not animComponent or not clipName then
    return nil
  end
  for _, state in pairs(animComponent) do
    if state and state.name == clipName then
      return state
    end
  end
  return nil
end

function this:escHandle()
  if self.inSubModule == true then
    self:submoduleCloseFunc()
  else
    self:closeFunc()
  end
end

function this:submoduleCloseFunc()
  if self.modules.toggleModuleBar[self.bind.toggleModuleName].BeforeClose then
    self.modules.toggleModuleBar[self.bind.toggleModuleName]:BeforeClose()
  end
  self.bindComponents.interactionMask.interactable = true
  self:playAnimationReversed(self.bindComponents.anim, "anim_lllustrate_back", 1)
  self.inSubModule = false
  C_IntegrateMgr.TopBarModule:SetTopBarBackName("星源之庭")
end

function this:closeFunc()
  if self.inSubModule == true then
    self:submoduleCloseFunc()
  else
    L_UI:close(self.pageName)
  end
end

return this

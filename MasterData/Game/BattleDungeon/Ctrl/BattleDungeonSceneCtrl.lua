local base = require("Game.Common.CommonGameCtrl.DungeonSceneBaseCtrl")
local BattleDungeonSceneCtrl = class("BattleDungeonSceneCtrl", base)
local DungeonConst = require("Game.BattleDungeon.DungeonConst")
local CS_GSceneManager_Ins = CS.GSceneManager.Instance
local util = require("XLua.Common.xlua_util")

function BattleDungeonSceneCtrl:ctor(bdCtrl)
  self.bdCtrl = bdCtrl
  table.insert(self.bdCtrl.ctrls, self)
  self.__sceneStepLogic = BindCallback(self, self.DungeonSceneStepLogic)
  self.bdCtrl:RegisterDungeonLogic(DungeonConst.LogicType.SceneStep, self.__sceneStepLogic)
end

function BattleDungeonSceneCtrl:EnterDungeonScene(sceneWave, compeleteAction)
  self.curSceneId = sceneWave.scene
  self.sceneWave = sceneWave
  self:__StartLoadScene(self.curSceneId, function(success)
    if not success then
      error("load scene fail,sceneId:" .. tostring(self.curSceneId))
      return
    end
    if compeleteAction ~= nil then
      compeleteAction()
    end
  end)
end

function BattleDungeonSceneCtrl:__StartLoadScene(sceneId, sceneLoadComplete)
  local sceneCfg = ConfigData.scene[sceneId]
  if sceneCfg == nil then
    error("scene config is null,id:" .. tostring(sceneId))
    return
  end
  AudioManager:PlayAudioById(sceneCfg.audio_id)
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, eAuSelct.Sector.name, eAuSelct.Sector.normalCombat)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
  end
  self.resloader = CS.ResLoader.Create()
  self.heroPrefabs = {}
  self.heroObjectDic = {}
  
  local function preLoadFunc()
    self:__InitDungeonSceneEffect()
    self:__PreLoadCharacterAndSkill(self.bdCtrl.dynPlayer, self.heroPrefabs, self.heroObjectDic)
  end
  
  local loadingWindow = UIManager:GetWindow(UIWindowTypeID.Loading)
  if loadingWindow ~= nil then
    loadingWindow:SetLoadingTipsSystemId(2)
  end
  CS_GSceneManager_Ins:LoadSceneAsyncByABEx(sceneCfg.scene_name, true, false, function(result)
    local roomRoot = CS.UnityEngine.GameObject.Find("RoomMap")
    if not IsNull(roomRoot) then
      self.bind = {}
      UIUtil.LuaUIBindingTable(roomRoot.transform, self.bind)
      self.bind.canvasGroup.alpha = 0
    end
    self.bind = {}
    UIUtil.LuaUIBindingTable(CS.CameraController.Instance.transform.parent, self.bind)
    self:SetEpMapCameraCullMask(LayerMask.UI3D)
    self:CheckAndOpenSepcialMode(sceneCfg)
    if sceneLoadComplete ~= nil then
      sceneLoadComplete(result)
    end
  end, util.cs_generator(preLoadFunc))
end

function BattleDungeonSceneCtrl:DungeonSceneStepLogic(sceneWave)
  self.sceneWave = sceneWave
  if self.curSceneId == sceneWave.scene then
    self.bdCtrl:StartRunNextLogic()
    return
  end
  self:EnterDungeonScene(sceneWave, function()
    self.bdCtrl:StartRunNextLogic()
  end)
end

function BattleDungeonSceneCtrl:ChangeBattleScene(sceneWave)
end

function BattleDungeonSceneCtrl:GetDungeonCrazyTime()
  if self.sceneWave == nil or self.sceneWave.crazyTime == nil then
    return 0
  end
  return self.sceneWave.crazyTime
end

function BattleDungeonSceneCtrl:GetBattleFieldSizeBySceneId()
  local sceneCfg = ConfigData.scene[self.curSceneId]
  if sceneCfg == nil then
    error("scene cfg is null,scene_id:" .. tostring(self.curSceneId))
    return
  end
  return sceneCfg.size_row, sceneCfg.size_col, sceneCfg.deploy_rows, sceneCfg.grid_scale_factor
end

function BattleDungeonSceneCtrl:SetEpMapCameraCullMask(LayerMaskEnum)
  local epMapCamera = CS.CameraController.Instance.EpMapCamera
  if epMapCamera then
    epMapCamera.cullingMask = 1 << LayerMaskEnum
  end
end

function BattleDungeonSceneCtrl:OnDelete()
  self.bdCtrl:UnRegisterDungeonLogic(DungeonConst.LogicType.SceneStep, self.__sceneStepLogic)
  base.OnDelete(self)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
end

return BattleDungeonSceneCtrl

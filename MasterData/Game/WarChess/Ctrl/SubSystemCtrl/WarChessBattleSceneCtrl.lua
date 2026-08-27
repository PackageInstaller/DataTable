local base = require("Game.Common.CommonGameCtrl.DungeonSceneBaseCtrl")
local WarChessBattleSceneCtrl = class("WarChessBattleSceneCtrl", base)
local util = require("XLua.Common.xlua_util")

function WarChessBattleSceneCtrl:ctor(wcCtrl)
  self.wcCtrl = wcCtrl
end

function WarChessBattleSceneCtrl:WCLoadBattleScene(sceneId, curDynPlayer, monsters, loadOverCallback)
  self.curSceneId = sceneId
  local sceneCfg = ConfigData.scene[sceneId]
  if sceneCfg == nil then
    error("scene config is null,id:" .. tostring(sceneId))
    return
  end
  self.heroPrefabs = {}
  self.heroObjectDic = {}
  
  local function afterLoadFunc(result)
    local roomRoot = CS.UnityEngine.GameObject.Find("RoomMap")
    if not IsNull(roomRoot) then
      self.bind = {}
      UIUtil.LuaUIBindingTable(roomRoot.transform, self.bind)
      self.bind.canvasGroup.alpha = 0
    end
    self.bind = {}
    UIUtil.LuaUIBindingTable(CS.CameraController.Instance.transform.parent, self.bind)
    self:SetWCBattleCameraCullMask(LayerMask.UI3D)
    local loadingWindow = UIManager:GetWindow(UIWindowTypeID.WarChessLoading)
    if loadingWindow ~= nil then
      loadingWindow:PlayHideEffect()
    end
    self:CheckAndOpenSepcialMode(sceneCfg)
    local noticeWindow = UIManager:GetWindow(UIWindowTypeID.WarChessNotice)
    if noticeWindow ~= nil then
      noticeWindow:ForceHideWindow()
    end
    self._afterLoadCo = GR.StartCoroutine(util.cs_generator(function()
      self:__InitDungeonSceneEffect()
      self:__PreLoadCharacterAndSkill(curDynPlayer, self.heroPrefabs, self.heroObjectDic)
      if loadOverCallback ~= nil then
        loadOverCallback(result)
      end
      self._afterLoadCo = nil
    end))
  end
  
  CS.GSceneManager.Instance:LoadSceneAsyncByABEx(sceneCfg.scene_name, true, true, afterLoadFunc, nil)
end

function WarChessBattleSceneCtrl:GetBattleFieldSizeBySceneId()
  local sceneCfg = ConfigData.scene[self.curSceneId]
  if sceneCfg == nil then
    error("scene cfg is null,scene_id:" .. tostring(self.curSceneId))
    return
  end
  return sceneCfg.size_row, sceneCfg.size_col, sceneCfg.deploy_rows, sceneCfg.grid_scale_factor
end

function WarChessBattleSceneCtrl:SetWCBattleCameraCullMask(LayerMaskEnum)
  local epMapCamera = CS.CameraController.Instance.EpMapCamera
  if epMapCamera then
    epMapCamera.cullingMask = 1 << LayerMaskEnum
  end
end

function WarChessBattleSceneCtrl:OnWCBattleOver()
  self:BattleSceneDisposeMember()
  self.heroResLoaderDic = {}
  self.heroPrefabs = {}
end

function WarChessBattleSceneCtrl:OnDelete()
  if self._afterLoadCo ~= nil then
    GR.StopCoroutine(self._afterLoadCo)
    self._afterLoadCo = nil
  end
  base.OnDelete(self)
end

return WarChessBattleSceneCtrl

_class("SMazeProp_Bomb", SMazePropBase)
SMazeProp_Bomb = SMazeProp_Bomb

function SMazeProp_Bomb:SetTarget(target)
  self._target = target
end

function SMazeProp_Bomb:GetTarget()
  return self._target
end

function SMazeProp_Bomb:Use(TT)
  if not self._target then
    Log.exception("严重错误 炸弹还未选择目标 不可以使用")
  end
  local cpt = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj():GetMazeComponent()
  local res = AsyncRequestRes:New()
  local result = cpt:HandleSeasonMazeUseOnce(TT, res, self:CfgID(), self._target:ID())
  if res:GetSucc() then
    Log.info("炸弹道具使用成功")
    self._assets = {}
    for _, eft in pairs(result.reward) do
      local asset = SeasonMazeTool:GetInstance():Effect2Asset(eft, eft.value_min)
      table.insert(self._assets, asset)
      if asset:Type() == SeasonMazeEffectType.SMET_Pro then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, asset:SubParam())
      end
    end
    local req = ResourceManager:GetInstance():SyncLoadAsset("eff_pfb_zhadan.prefab", LoadType.GameObject)
    local eft = req.Obj
    local tr = eft.transform
    tr.position = self._target:Position() + Vector3(0, 0.1, 0)
    tr.rotation = Quaternion.identity
    tr.localScale = Vector3.one
    eft:SetActive(true)
    YIELD(TT, 1200)
    local cpt = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj():GetMazeComponent()
    local svrData = cpt:GetComponentInfo().rooms[self._target:ID()]
    local battleRoom = self._target:Room()
    battleRoom:Boom(svrData)
    YIELD(TT, 1800)
    req:Dispose()
    return true
  else
    Log.error("炸弹道具使用失败:", res:GetResult())
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return false
    end
    return false
  end
end

function SMazeProp_Bomb:RewardAsset()
  return self._assets
end

require("s_maze_state_base")
_class("SMazeState_ArriveRoom", SMazeStateBase)
SMazeState_ArriveRoom = SMazeState_ArriveRoom

function SMazeState_ArriveRoom:OnEnter(source, node)
  self:_Log("到达房间:", node:ID())
  self:StartTask(self._OnArrive, self, node)
end

function SMazeState_ArriveRoom:_OnArrive(TT, node)
  local cpt = self._manager:GetMazeComponent()
  if cpt:CurOperate() == SeasonMazeActionState.SMAS_GoPoint then
    local res = AsyncRequestRes:New()
    self:Lock("SMazeState_ArriveRoom:HandleSeasonMazeGoPoint")
    cpt:HandleSeasonMazeGoPoint(TT, res, node:ID(), false)
    self:UnLock("SMazeState_ArriveRoom:HandleSeasonMazeGoPoint")
    if not self._valid then
      return
    end
    local svrData = self._manager:GetMazeComponent():GetComponentInfo().rooms[node:ID()]
    do
      local roomType = node:Room():Type()
      self:RectifyServerData(svrData, roomType)
    end
    if not res:GetSucc() then
      self:_LogError("到达房间消息失败:", res:GetResult())
      if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
        return
      end
      return
    end
  end
  if node:Room():Type() == SeasonMazeRoomType.SMRT_PVE then
    local relicParam = cpt:GetAttrValue(SeasonMazeAttrType.SMAT_Fight_Room_Exp)
    if relicParam and relicParam ~= 0 then
      local eft = SeasonMazeEffect:New()
      eft.type = SeasonMazeEffectType.SMET_Pro
      eft.id = SeasonMazeAttrType.SMAT_Exp
      eft.value_min = relicParam
      eft.value_max = relicParam
      self:AddRelicEft(eft)
    end
    self:PlayAssetToast(TT, {})
  end
  if cpt:CurOperate() == SeasonMazeActionState.SMAS_NewHand then
    self._machine:ChangeStateTo(SMazeState_Levelup)
  else
    self._machine:ChangeStateTo(SMazeState_RoomSettle, node, false)
  end
end

function SMazeState_ArriveRoom:RectifyServerData(svrData, roomType)
  if roomType == SeasonMazeRoomType.SMRT_Camp then
    svrData.state = SeasonMazePointStateType.SMPST_Occupy
  elseif roomType == SeasonMazeRoomType.SMRT_Altar then
    svrData.state = SeasonMazePointStateType.SMPST_Occupy
  elseif roomType == SeasonMazeRoomType.SMRT_Market then
    svrData.state = SeasonMazePointStateType.SMPST_Occupy
  elseif roomType == SeasonMazeRoomType.SMRT_PVE then
    svrData.state = SeasonMazePointStateType.SMPST_Occupy
  elseif roomType == SeasonMazeRoomType.SMRT_Shop then
    svrData.state = SeasonMazePointStateType.SMPST_Occupy
  elseif roomType == SeasonMazeRoomType.SMRT_BeadShop then
    svrData.state = SeasonMazePointStateType.SMPST_Occupy
  else
    svrData.state = SeasonMazePointStateType.SMPST_Choose
  end
end

require("_buff_view_base_r")
_class("BuffViewConvertOnChainPosByLeftRound", BuffViewBase)
BuffViewConvertOnChainPosByLeftRound = BuffViewConvertOnChainPosByLeftRound

function BuffViewConvertOnChainPosByLeftRound:IsNotifyMatch(notify)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if self._entity:Pet() then
    local ownerTeamEntity = self._entity:Pet():GetOwnerTeamEntity()
    if teamEntity:GetID() ~= ownerTeamEntity:GetID() then
      return false
    end
  end
  return true
end

function BuffViewConvertOnChainPosByLeftRound:PlayView(TT)
  local buffRes = self._buffResult
  local buffViewParam = self:ViewParams()
  local pieceSvc = self._world:GetService("Piece")
  local boardRSvc = self._world:GetService("BoardRender")
  local effectSvc = self._world:GetService("Effect")
  local gridPos = buffRes:GetGridPos()
  local oldPieceType = buffRes:GetOldPieceType()
  local newPieceType = buffRes:GetNewPieceType()
  local convertInfo = NTGridConvert_ConvertInfo:New(gridPos, oldPieceType, newPieceType)
  local tConvertInfo = {}
  table.insert(tConvertInfo, convertInfo)
  effectSvc:CreateWorldPositionEffect(buffViewParam.ConvertEffectID, gridPos)
  if buffViewParam.ConvertDelayTime then
    YIELD(TT, buffViewParam.ConvertDelayTime)
  end
  boardRSvc:ReCreateGridEntity(newPieceType, gridPos, false)
  local gridEntity = pieceSvc:FindPieceEntity(gridPos)
  gridEntity:SetViewVisible(true)
  pieceSvc:RefreshPieceAnim()
  local nt = NTGridConvert:New(self._entity, tConvertInfo)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, nt)
end

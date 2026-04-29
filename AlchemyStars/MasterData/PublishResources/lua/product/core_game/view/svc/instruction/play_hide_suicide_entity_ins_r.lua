require("base_ins_r")
_class("PlayHideSuicideEntityInstruction", BaseInstruction)
PlayHideSuicideEntityInstruction = PlayHideSuicideEntityInstruction

function PlayHideSuicideEntityInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = routineComponent:GetEffectResultByArrayAll(SkillEffectType.Suicide)
  if not resultArray then
    return
  end
  local boardServiceRender = world:GetService("BoardRender")
  local pieceService = world:GetService("Piece")
  local renderEntityService = world:GetService("RenderEntity")
  for _, result in ipairs(resultArray) do
    local targetID = result:GetTargetID()
    local targetEntity = world:GetEntityByID(targetID)
    if targetEntity then
      renderEntityService:DestroyMonsterAreaOutLineEntity(targetEntity)
      local curPos = boardServiceRender:GetRealEntityGridPos(targetEntity)
      local workPos = curPos - targetEntity:GridLocation():GetGridOffset()
      local bodyArea = targetEntity:BodyArea():GetArea()
      for _, area in ipairs(bodyArea) do
        local tmpPos = area + workPos
        local curPieceAnim = pieceService:GetPieceAnimation(tmpPos)
        if curPieceAnim == "Down" then
          pieceService:SetPieceAnimNormal(tmpPos)
        end
      end
      local location = targetEntity:Location()
      if location then
        local gridWorldPos = targetEntity:GetPosition()
        local offsetY = BattleConst.TeleportExitBoardOffsetY
        local gridWorldNew = UnityEngine.Vector3.New(gridWorldPos.x + offsetY, offsetY, gridWorldPos.z)
        targetEntity:SetPosition(gridWorldNew)
      end
      local cHP = targetEntity:HP()
      if not cHP then
        return
      end
      local eidHPBar = cHP:GetHPSliderEntityID()
      local hpBarEntity = world:GetEntityByID(eidHPBar)
      if not hpBarEntity then
        return
      end
      hpBarEntity:SetViewVisible(false)
    end
  end
end

require("base_ins_r")
local SchummerShowHideMode = {
  Hide = 1,
  Show = 2,
  Reset = 3
}
_enum("SchummerShowHideMode", SchummerShowHideMode)
_G.SchummerShowHideMode = SchummerShowHideMode
_class("PlaySchummerHitbackShowHideInstruction", BaseInstruction)
PlaySchummerHitbackShowHideInstruction = PlaySchummerHitbackShowHideInstruction

function PlaySchummerHitbackShowHideInstruction:Constructor(paramList)
  self._mode = tonumber(paramList.mode)
  self._v2LeftPos = self:_GetV2FromCfg(paramList.leftPos) or Vector2.New(11, 5)
  self._v2RightPos = self:_GetV2FromCfg(paramList.rightPos) or Vector2.New(-1, 5)
  self._v2UpPos = self:_GetV2FromCfg(paramList.upPos) or Vector2.New(5, -1)
  self._v2DownPos = self:_GetV2FromCfg(paramList.downPos) or Vector2.New(5, 11)
end

function PlaySchummerHitbackShowHideInstruction:_GetV2FromCfg(str)
  if not str or str == "" then
    return
  end
  local split = string.split(str, "|")
  local x = tonumber(split[1])
  local y = tonumber(split[2])
  if not x or not y then
    Log.exception(self._className, "cannot parse param to vector2: ", str)
    return
  end
  return Vector2.New(x, y)
end

function PlaySchummerHitbackShowHideInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local container = casterEntity:SkillRoutine():GetResultContainer()
  local result = container:GetEffectResultByArray(SkillEffectType.HitBack)
  if not result then
    return
  end
  if self._mode == SchummerShowHideMode.Hide then
    casterEntity:Location():SetPosition(Vector3.New(0, 1000, 0))
    local eidSlider = casterEntity:HP():GetHPSliderEntityID()
    if eidSlider and world:GetEntityByID(eidSlider) then
      local eSlider = world:GetEntityByID(eidSlider)
      eSlider:SetViewVisible(false)
    end
  elseif self._mode == SchummerShowHideMode.Show then
    local v2Dir = result:GetHitDir()
    local v2FinalPos
    if v2Dir == Vector2.left then
      v2FinalPos = self._v2LeftPos
    elseif v2Dir == Vector2.right then
      v2FinalPos = self._v2RightPos
    elseif v2Dir == Vector2.up then
      v2FinalPos = self._v2UpPos
    elseif v2Dir == Vector2.down then
      v2FinalPos = self._v2DownPos
    end
    casterEntity:SetLocation(v2FinalPos, v2Dir)
  elseif self._mode == SchummerShowHideMode.Reset then
    local v2GridPos = casterEntity:GridLocation():Center()
    casterEntity:SetLocation(v2GridPos)
    local eidSlider = casterEntity:HP():GetHPSliderEntityID()
    if eidSlider and world:GetEntityByID(eidSlider) then
      local eSlider = world:GetEntityByID(eidSlider)
      eSlider:SetViewVisible(false)
    end
  end
end

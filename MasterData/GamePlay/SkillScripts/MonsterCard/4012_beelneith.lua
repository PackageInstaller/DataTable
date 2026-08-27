local bs_4012 = class("bs_4012", LuaSkillBase)
local base = LuaSkillBase
bs_4012.config = {buffId = 40121}

function bs_4012:ctor()
end

function bs_4012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_4012_2", 1, self.OnAfterPlaySkill)
  self.atk_num = 0
end

function bs_4012:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack then
    self.atk_num = self.atk_num + 1
    if self.atk_num == self.arglist[1] then
      self.atk_num = 0
      local target = role.recordTable.lastAttackRole
      if target == nil then
        return
      end
      self:blink(target)
    end
  end
end

function bs_4012:blink(target)
  local Grid = self:GetRoleBehindGrid(target)
  if Grid ~= nil then
    LuaSkillCtrl:SetRolePos(Grid, self.caster)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, self.arglist[3])
    self.caster:LookAtTarget(target)
  end
end

function bs_4012:GetRoleBehindGrid(role)
  local grid = LuaSkillCtrl:FindEmptyGridAroundRole(role)
  if grid ~= nil then
    return grid
  end
  local grid_dict = LuaSkillCtrl:FindEmptyGridsWithinRange(role.x, role.y, 1)
  if grid_dict == nil or grid_dict.Count <= 0 then
    return nil
  end
  for j = 0, grid_dict.Count - 1 do
    local grid = grid_dict[j]
    local lsObject = role.lsObject
    local tempdir = CS.TrueSync.TSVector3.Subtract(lsObject.localPosition, grid.fixLogicPosition).normalized
    local qua = CS.TrueSync.TSQuaternion.LookRotation(tempdir)
    if qua.eulerAngles ~= lsObject.localRotation.eulerAngles then
      local angle = CS.TrueSync.TSQuaternion.Angle(qua, lsObject.localRotation):AsInt()
      if -60 < angle and angle < 60 then
        return grid
      end
    end
  end
  return nil
end

function bs_4012:LuaDispose()
  base.LuaDispose(self)
end

function bs_4012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4012

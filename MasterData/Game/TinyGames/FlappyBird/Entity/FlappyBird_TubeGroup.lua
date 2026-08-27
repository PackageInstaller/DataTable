local base = require("Game.TinyGames.FlappyBird.Entity.FlappyBird_EntityBase")
local FlappyBird_TubeGroup = class("FlappyBird_TubeGroup", base)
local FlappyBird_Tube = require("Game.TinyGames.FlappyBird.Entity.FlappyBird_Tube")

function FlappyBird_TubeGroup:OnInit()
  self:SetMoveFollowBackGroud()
  self:SetGravityInfluenceEnable(false)
  self.__isPickedScore = false
  self.tubeEntityList = {}
end

function FlappyBird_TubeGroup:SetGroupType(groupType)
  self.__tubeGroupType = groupType
end

function FlappyBird_TubeGroup:InitWithGroupData(groupData)
  local childrenTubes = groupData.tubeChildren
  for _, v in ipairs(childrenTubes) do
    local tube = FlappyBird_Tube.New(v.tubeType)
    tube:SetOffset2Center(v.tubeOffset.x, v.tubeOffset.y)
    tube:SetColliderSize(v.scale.halfWidth, v.scale.halfHeight)
    table.insert(self.tubeEntityList, tube)
  end
  self.bonusScore = groupData.score
end

function FlappyBird_TubeGroup:SetPos(x, y)
  base.SetPos(self, x, y)
  self:__UpdateChildTubePos()
end

function FlappyBird_TubeGroup:UpdatePos()
  base.UpdatePos(self)
  self:__UpdateChildTubePos()
end

function FlappyBird_TubeGroup:__UpdateChildTubePos()
  for _, tubeEntity in ipairs(self.tubeEntityList) do
    tubeEntity:SetTubePos(self.pos.x, self.pos.y)
  end
end

function FlappyBird_TubeGroup:IsOnCollission(otherEntity)
  for _, tubeEntity in ipairs(self.tubeEntityList) do
    if self:IsOnCollisionInSky(tubeEntity, otherEntity) then
      return true
    end
    if tubeEntity:IsOnTubeCollission(otherEntity) then
      return true
    end
  end
end

function FlappyBird_TubeGroup:IsOnCollisionInSky(tubeEntity, otherEntity)
  if otherEntity.pos.y < self.evnData.playGroundHeight then
    return false
  end
  local tubeHalfHeight = tubeEntity.colliderBox.top
  local tubeHalfWidth = tubeEntity.colliderBox.right
  local left = tubeEntity.pos.x - tubeHalfWidth
  local right = tubeEntity.pos.x + tubeHalfWidth
  if tubeEntity.pos.y + tubeHalfHeight < self.evnData.playGroundHeight then
    return false
  end
  return left <= otherEntity.pos.x and right >= otherEntity.pos.x
end

function FlappyBird_TubeGroup:GetTubeEntityList()
  return self.tubeEntityList
end

function FlappyBird_TubeGroup:GetTubeGroupType()
  return self.__tubeGroupType
end

function FlappyBird_TubeGroup:GetIsPickScore()
  return self.__isPickedScore
end

function FlappyBird_TubeGroup:SetIsPickScore(bool)
  self.__isPickedScore = bool
end

return FlappyBird_TubeGroup

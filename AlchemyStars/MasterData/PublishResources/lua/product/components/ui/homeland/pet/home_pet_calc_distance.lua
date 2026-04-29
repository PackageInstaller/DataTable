_class("HomePetCalcDistance", Object)
HomePetCalcDistance = HomePetCalcDistance

function HomePetCalcDistance:Constructor(homelandClient)
  self._charaMgr = homelandClient:CharacterManager()
  self._petMgr = homelandClient:PetManager()
  self._fiexdTime = 200
  self._yieldTime = self._fiexdTime
  self:CreateArea()
  self._innerPets = {}
  self._currentInnerPet = nil
end

function HomePetCalcDistance:CreateArea()
  local posGo_Left_Up = UnityEngine.GameObject.Find("PointLeftUp")
  local posGo_Right_Down = UnityEngine.GameObject.Find("PointRightDown")
  local pos_left_up = posGo_Left_Up.transform.position
  local pos_right_down = posGo_Right_Down.transform.position
  local pos_left_up_inner = pos_left_up - (pos_left_up - pos_right_down) / 3
  local pos_right_down_inner = pos_right_down + (pos_left_up - pos_right_down) / 3
  self._connect = {
    [1] = {
      [1] = 1,
      [2] = 1,
      [3] = 0,
      [4] = 1,
      [5] = 1,
      [6] = 0,
      [7] = 0,
      [8] = 0,
      [9] = 0
    },
    [2] = {
      [1] = 1,
      [2] = 1,
      [3] = 1,
      [4] = 1,
      [5] = 1,
      [6] = 1,
      [7] = 0,
      [8] = 0,
      [9] = 0
    },
    [3] = {
      [1] = 0,
      [2] = 1,
      [3] = 1,
      [4] = 0,
      [5] = 1,
      [6] = 1,
      [7] = 0,
      [8] = 0,
      [9] = 0
    },
    [4] = {
      [1] = 1,
      [2] = 1,
      [3] = 0,
      [4] = 1,
      [5] = 1,
      [6] = 0,
      [7] = 1,
      [8] = 1,
      [9] = 0
    },
    [5] = {
      [1] = 1,
      [2] = 1,
      [3] = 1,
      [4] = 1,
      [5] = 1,
      [6] = 1,
      [7] = 1,
      [8] = 1,
      [9] = 1
    },
    [6] = {
      [1] = 0,
      [2] = 1,
      [3] = 1,
      [4] = 0,
      [5] = 1,
      [6] = 1,
      [7] = 0,
      [8] = 1,
      [9] = 1
    },
    [7] = {
      [1] = 0,
      [2] = 0,
      [3] = 0,
      [4] = 1,
      [5] = 1,
      [6] = 0,
      [7] = 1,
      [8] = 1,
      [9] = 0
    },
    [8] = {
      [1] = 0,
      [2] = 0,
      [3] = 0,
      [4] = 1,
      [5] = 1,
      [6] = 1,
      [7] = 1,
      [8] = 1,
      [9] = 1
    },
    [9] = {
      [1] = 0,
      [2] = 0,
      [3] = 0,
      [4] = 0,
      [5] = 1,
      [6] = 1,
      [7] = 0,
      [8] = 1,
      [9] = 1
    }
  }
  self._checkArea = {
    [1] = {
      left_up = Vector2(pos_left_up.x, pos_left_up.z),
      right_down = Vector2(pos_left_up_inner.x, pos_left_up_inner.z)
    },
    [2] = {
      left_up = Vector2(pos_left_up_inner.x, pos_left_up.z),
      right_down = Vector2(pos_right_down_inner.x, pos_left_up_inner.z)
    },
    [3] = {
      left_up = Vector2(pos_right_down_inner.x, pos_left_up.z),
      right_down = Vector2(pos_right_down.x, pos_left_up_inner.z)
    },
    [4] = {
      left_up = Vector2(pos_left_up.x, pos_left_up_inner.z),
      right_down = Vector2(pos_left_up_inner.x, pos_right_down_inner.z)
    },
    [5] = {
      left_up = Vector2(pos_left_up_inner.x, pos_left_up_inner.z),
      right_down = Vector2(pos_right_down_inner.x, pos_right_down_inner.z)
    },
    [6] = {
      left_up = Vector2(pos_right_down_inner.x, pos_left_up_inner.z),
      right_down = Vector2(pos_right_down.x, pos_right_down_inner.z)
    },
    [7] = {
      left_up = Vector2(pos_left_up.x, pos_right_down_inner.z),
      right_down = Vector2(pos_left_up_inner.x, pos_right_down.z)
    },
    [8] = {
      left_up = Vector2(pos_left_up_inner.x, pos_right_down_inner.z),
      right_down = Vector2(pos_right_down_inner.x, pos_right_down.z)
    },
    [9] = {
      left_up = Vector2(pos_right_down_inner.x, pos_right_down_inner.z),
      right_down = Vector2(pos_right_down.x, pos_right_down.z)
    }
  }
  for i = 1, #self._checkArea do
    local area = self._checkArea[i]
    Log.debug("###[HomePetCalcDistance] area[", i, "] left_up[", tostring(area.left_up), "] right_down[", tostring(area.right_down), "]")
  end
end

function HomePetCalcDistance:GetCharacterPosXZ()
  local characterTransform = self._charaMgr:GetCharacterTransform()
  local characterPostion = characterTransform.position
  local _x = characterPostion.x
  local _z = characterPostion.z
  return _x, _z
end

function HomePetCalcDistance:Update(dms)
  if self._yieldTime < 0 then
    self._yieldTime = self._fiexdTime
    self:CheckDistance()
  end
  self._yieldTime = self._yieldTime - dms
end

function HomePetCalcDistance:CheckDistance()
  local posx, posz = self:GetCharacterPosXZ()
  local area = self:GetArea(posx, posz, "character")
  local pets = self._petMgr:GetPets(function(pet)
    local behavior = pet._behavior
    local curBehavior = behavior._curBehavior
    local behaviorType = curBehavior._behaviorType
    if behaviorType ~= HomelandPetBehaviorType.Following then
      return true
    end
  end)
  if not self._currentInnerPet then
    for i = 1, #pets do
      local pet = pets[i]
      local petPos = pet:WorldPosition()
      local petArea = self:GetArea(petPos.x, petPos.z, tostring(pet:TemplateID()))
      if self._connect[area][petArea] == 1 then
        local trigger = self:CheckTrigger(Vector2(posx, posz), Vector2(petPos.x, petPos.z))
        local petid = pet:TemplateID()
        if trigger then
          self._currentInnerPet = pet
          Log.fatal("###[HomePetCalcDistance] 星灵进入 petid --> ", petid)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomePetInner, true, petid)
          break
        end
      end
    end
  else
    local petPos = self._currentInnerPet:WorldPosition()
    local petArea = self:GetArea(petPos.x, petPos.z, tostring(self._currentInnerPet:TemplateID()))
    if self._connect[area][petArea] == 1 then
      local trigger = self:CheckTrigger(Vector2(posx, posz), Vector2(petPos.x, petPos.z))
      local petid = self._currentInnerPet:TemplateID()
      if trigger then
      else
        Log.fatal("###[HomePetCalcDistance] 星灵离开 petid --> ", petid)
        self._currentInnerPet = nil
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomePetInner, false, petid)
      end
    end
  end
end

function HomePetCalcDistance:CheckTrigger(v1, v2)
  local dis = math.sqrt((v1.x - v2.x) * (v1.x - v2.x) + (v1.y - v2.y) * (v1.y - v2.y))
  if dis <= 1 then
    return true
  end
end

function HomePetCalcDistance:GetArea(posx, posz, log)
  local currArea
  for i = 1, #self._checkArea do
    local area = self._checkArea[i]
    if posx >= area.left_up.x and posx <= area.right_down.x and posz >= area.right_down.y and posz <= area.left_up.y then
      currArea = i
      break
    end
  end
  if not currArea then
    Log.error("###[HomePetCalcDistance] area is nil ! pos x[", posx, "] z[", posz, "] log[", log, "]")
  end
  return currArea
end

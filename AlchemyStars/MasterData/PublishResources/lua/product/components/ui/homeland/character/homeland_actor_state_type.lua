_enum("HomelandActorStateType", HomelandActorStateType)
HomelandActorStateType = {
  Idle = 1,
  Run = 2,
  Swim = 3,
  Dash = 4,
  Interact = 5,
  Axe = 6,
  Pick = 7,
  Fish = 8,
  Navigate = 9,
  Stationary = 10,
  Dispose = 11,
  NotDefined = 99
}

function HomelandActorStateType.TypeToName(type)
  for name, value in pairs(HomelandActorStateType) do
    if type == value then
      return name
    end
  end
end

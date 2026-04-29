local HomelandPetLoadState = {
  None = 0,
  Wait = 1,
  Loading = 2,
  Invalid = 3,
  Finish = 4,
  Closed = 5
}
_enum("HomelandPetLoadState", HomelandPetLoadState)
local HomelandPetAnimName = {
  Stand = "stand",
  Walk = "walk",
  Click = "click01",
  Sit = "sit",
  Run = "move",
  Greet = "stand",
  Happy = "happy",
  Depression = "depression",
  Angry = "angry",
  Amaze = "amaze",
  Surprise = "surprise",
  Sad = "sad",
  Float = "float_hli",
  Swim = "swim_hli",
  FastSwim = "fastswim_hli"
}
_enum("HomelandPetAnimName", HomelandPetAnimName)
local HomelandPetBehaviorType = {
  Free = 1,
  Roam = 2,
  InteractingPlayer = 3,
  Following = 4,
  InteractingFurniture = 5,
  TreasureIdle = 6,
  GreetPlayer = 7,
  StoryPlaying = 8,
  StoryWaitingBuild = 9,
  StoryWaitingBuildStand = 10,
  StoryWaitingStand = 11,
  StoryWaitingWalk = 12,
  SwimmingPool = 14,
  FishingPrepare = 15,
  FishingMatch = 16
}
_enum("HomelandPetBehaviorType", HomelandPetBehaviorType)
local HomelandPetComponentType = {
  Move = 1,
  Bubble = 2,
  Animation = 3,
  Face = 4,
  Soliloquize = 5,
  InteractionAnimation = 6,
  Swim = 7,
  ExtraAnimation = 8
}
_enum("HomelandPetComponentType", HomelandPetComponentType)
local HomelandPetBehaviorStructure = {
  [HomelandPetBehaviorType.Free] = {
    HomelandPetComponentType.Animation,
    HomelandPetComponentType.Bubble
  },
  [HomelandPetBehaviorType.Roam] = {
    HomelandPetComponentType.Move,
    HomelandPetComponentType.Bubble,
    HomelandPetComponentType.Soliloquize
  },
  [HomelandPetBehaviorType.InteractingPlayer] = {
    HomelandPetComponentType.Bubble,
    HomelandPetComponentType.Animation
  },
  [HomelandPetBehaviorType.Following] = {
    HomelandPetComponentType.Move,
    HomelandPetComponentType.Bubble,
    HomelandPetComponentType.Animation
  },
  [HomelandPetBehaviorType.InteractingFurniture] = {
    {
      HomelandPetComponentType.Move,
      HomelandPetComponentType.Bubble,
      HomelandPetComponentType.InteractionAnimation
    }
  },
  [HomelandPetBehaviorType.TreasureIdle] = {
    HomelandPetComponentType.Bubble,
    HomelandPetComponentType.Animation
  },
  [HomelandPetBehaviorType.GreetPlayer] = {
    HomelandPetComponentType.Bubble,
    HomelandPetComponentType.Animation
  },
  [HomelandPetBehaviorType.StoryPlaying] = {
    HomelandPetComponentType.Bubble,
    HomelandPetComponentType.Face,
    HomelandPetComponentType.Animation
  },
  [HomelandPetBehaviorType.StoryWaitingStand] = {
    HomelandPetComponentType.Bubble,
    HomelandPetComponentType.Face,
    HomelandPetComponentType.Animation
  },
  [HomelandPetBehaviorType.StoryWaitingWalk] = {
    HomelandPetComponentType.Move,
    HomelandPetComponentType.Bubble,
    HomelandPetComponentType.Face,
    HomelandPetComponentType.Animation
  },
  [HomelandPetBehaviorType.StoryWaitingBuild] = {
    HomelandPetComponentType.Bubble,
    HomelandPetComponentType.Face,
    HomelandPetComponentType.Animation,
    HomelandPetComponentType.InteractionAnimation
  },
  [HomelandPetBehaviorType.StoryWaitingBuildStand] = {
    HomelandPetComponentType.Bubble,
    HomelandPetComponentType.Face,
    HomelandPetComponentType.Animation
  },
  [HomelandPetBehaviorType.SwimmingPool] = {
    {
      HomelandPetComponentType.Move,
      HomelandPetComponentType.Swim
    }
  },
  [HomelandPetBehaviorType.FishingPrepare] = {
    {
      HomelandPetComponentType.Bubble
    }
  },
  [HomelandPetBehaviorType.FishingMatch] = {
    HomelandPetComponentType.Bubble,
    HomelandPetComponentType.ExtraAnimation
  }
}
_enum("HomelandPetBehaviorStructure", HomelandPetBehaviorStructure)
local HomelandPetComponentState = {
  Resting = 1,
  Failure = 2,
  Success = 3,
  Running = 4,
  Error = 5
}
_enum("HomelandPetComponentState", HomelandPetComponentState)
local HomelandPetMode = {Normal = 1, Debug = 2}
_enum("HomelandPetMode", HomelandPetMode)
local HomelandPetOccupiedType = {
  None = 0,
  Treasure = 1,
  StoryWaiting = 2,
  FishingMatch = 3
}
_enum("HomelandPetOccupiedType", HomelandPetOccupiedType)
local HomelandPetModeChangeProcessType = {RefreshNavmeshPos = 0, Custom = 1}
_enum("HomelandPetModeChangeProcessType", HomelandPetModeChangeProcessType)
local HomelandPetMotionType = {None = 1, Swim = 2}
_enum("HomelandPetMotionType", HomelandPetMotionType)
local HomelandRoleInteractingFunction = {None = 0, ChangeSwimsuit = 1}
_enum("HomelandRoleInteractingFunction", HomelandRoleInteractingFunction)
local HomelandInteractAnimationType = {
  In = 1,
  Loop = 2,
  Out = 3
}
_enum("HomelandInteractAnimationType", HomelandInteractAnimationType)

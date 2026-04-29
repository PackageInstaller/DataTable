local ScoreType = {
  B = 1,
  A = 2,
  S = 4
}
_enum("ScoreType", ScoreType)
local MiniGameState = {
  Start = 1,
  Playing = 2,
  Pause = 3,
  Skill = 4,
  Over = 5
}
_enum("MiniGameState", MiniGameState)
local Weight = {Small = 1, Big = 2}
_enum("Weight", Weight)
local Ingredient = {
  Chocolate = 1,
  Coco = 2,
  Pudding = 3,
  Taro = 4
}
_enum("Ingredient", Ingredient)
local Jam = {
  Strawberry = 1,
  Matcha = 2,
  Biolac = 3,
  Mango = 4
}
_enum("Jam", Jam)
local OrderformStep = {
  Weight = 1,
  Ingredient = 2,
  Jam = 3,
  Delivery = 4
}
_enum("OrderformStep", OrderformStep)
local OrderformState = {
  Appearing = 1,
  Waiting = 2,
  TimeOut = 3,
  TimeOutAnimation = 4,
  Fail = 5,
  Success = 6,
  DisAppearing = 7
}
_enum("OrderformState", OrderformState)
local GuestMood = {
  LookForward = 1,
  Quietness = 2,
  Impatient = 3,
  Happy = 4
}
_enum("GuestMood", GuestMood)
local OrderformImg = {
  Img = {
    [OrderformStep.Weight] = {
      [Weight.Small] = "n48_game_smlbowl",
      [Weight.Big] = "n48_game_bigbowl"
    },
    [OrderformStep.Ingredient] = {
      [Weight.Small] = {
        [Ingredient.Chocolate] = "n48_game_smlbowl8",
        [Ingredient.Coco] = "n48_game_smlbowl7",
        [Ingredient.Pudding] = "n48_game_smlbowl6",
        [Ingredient.Taro] = "n48_game_smlbowl5"
      },
      [Weight.Big] = {
        [Ingredient.Chocolate] = "n48_game_bigbowl8",
        [Ingredient.Coco] = "n48_game_bigbowl7",
        [Ingredient.Pudding] = "n48_game_bigbowl6",
        [Ingredient.Taro] = "n48_game_bigbowl5"
      }
    },
    [OrderformStep.Jam] = {
      [Weight.Small] = {
        [Jam.Strawberry] = "n48_game_smlbowl4",
        [Jam.Matcha] = "n48_game_smlbowl1",
        [Jam.Biolac] = "n48_game_smlbowl3",
        [Jam.Mango] = "n48_game_smlbowl2"
      },
      [Weight.Big] = {
        [Jam.Strawberry] = "n48_game_bigbowl4",
        [Jam.Matcha] = "n48_game_bigbowl1",
        [Jam.Biolac] = "n48_game_bigbowl3",
        [Jam.Mango] = "n48_game_bigbowl2"
      }
    }
  },
  ImgColor = {
    [true] = Color(1, 1, 1, 1),
    [false] = Color(1, 1, 1, 0)
  }
}
_enum("OrderformImg", OrderformImg)
_class("Orderform", Object)
Orderform = Orderform

function Orderform:Constructor(...)
  local param = {
    ...
  }
  self._weight = param[1]
  self._ingredient = param[2]
  self._jam = param[3]
  self._guest = param[4]
  self._appearingTime = 0.967
  self._timeOutAnimation = 0.233
  self._disAppearingTime = 1.433
  self._waitingTime = param[5]
  self._elapseWaitingTime = 0
  self._widgetIndex = param[6]
  self._score = 0
  self._step = OrderformStep.Weight
  self._state = OrderformState.Appearing
end

function Orderform:CanDo()
  return self._state == OrderformState.Appearing or self._state == OrderformState.Waiting
end

function Orderform:Do(step, param)
  if self._step == step and step == OrderformStep.Weight then
    self._weight = param
    self:NextStep()
    return true
  elseif self._step > OrderformStep.Weight and step == OrderformStep.Ingredient and self._ingredient <= 0 then
    self._ingredient = param
    self:NextStep()
    return true
  elseif self._step > OrderformStep.Weight and step == OrderformStep.Jam and 0 >= self._jam then
    self._jam = param
    self:NextStep()
    return true
  end
  return false
end

function Orderform:NextStep()
  self._step = self._step + 1
end

function Orderform:Done()
  self:Clear()
end

function Orderform:Clear()
  self._weight = 0
  self._ingredient = 0
  self._jam = 0
  self._guest = 0
  self._appearingTime = 0
  self._timeOutAnimation = 0
  self._disAppearingTime = 0
  self._waitingTime = 0
  self._elapseWaitingTime = 0
  self._widgetIndex = 0
  self._score = 0
  self._step = OrderformStep.Weight
  self._state = OrderformState.DisAppearing
end

function Orderform:Equal(orderform)
  return self._weight == orderform._weight and self._ingredient == orderform._ingredient and self._jam == orderform._jam
end

local GuestOrderformImg = {
  MoodImg = {
    [GuestMood.LookForward] = "n48_game_mood_good",
    [GuestMood.Quietness] = "n48_game_mood_normal",
    [GuestMood.Impatient] = "n48_game_mood_mad"
  },
  DiImg = {
    [Weight.Small] = "xiahuo_game_mood_smldi",
    [Weight.Big] = "xiahuo_game_mood_bigdi"
  },
  WeightImg = {
    [Weight.Small] = "n20_game_head_smlbowl",
    [Weight.Big] = "n20_game_head_bigbowl"
  },
  IngredientImg = {
    [Weight.Small] = {
      [Ingredient.Chocolate] = "n48_game_head_smlbowl8",
      [Ingredient.Coco] = "n48_game_head_smlbowl7",
      [Ingredient.Pudding] = "n48_game_head_smlbowl6",
      [Ingredient.Taro] = "n48_game_head_smlbowl5"
    },
    [Weight.Big] = {
      [Ingredient.Chocolate] = "n48_game_head_bigbowl8",
      [Ingredient.Coco] = "n48_game_head_bigbowl7",
      [Ingredient.Pudding] = "n48_game_head_bigbowl6",
      [Ingredient.Taro] = "n48_game_head_bigbowl5"
    }
  },
  JamImg = {
    [Weight.Small] = {
      [Jam.Strawberry] = "n48_game_head_smlbowl4",
      [Jam.Matcha] = "n48_game_head_smlbowl1",
      [Jam.Biolac] = "n48_game_head_smlbowl3",
      [Jam.Mango] = "n48_game_head_smlbowl2"
    },
    [Weight.Big] = {
      [Jam.Strawberry] = "n48_game_head_bigbowl4",
      [Jam.Matcha] = "n48_game_head_bigbowl1",
      [Jam.Biolac] = "n48_game_head_bigbowl3",
      [Jam.Mango] = "n48_game_head_bigbowl2"
    }
  }
}
_enum("GuestOrderformImg", GuestOrderformImg)
local GuestOrderformHandImg = {
  Decorate = {
    [Weight.Small] = "n48_game_hand_bigbowl",
    [Weight.Big] = "n48_game_hand_bigndle"
  },
  WeightImg = {
    [Weight.Small] = "n48_game_hand_bigbowl9",
    [Weight.Big] = "n48_game_hand_bigbowl"
  },
  IngredientImg = {
    [Weight.Small] = {
      [Ingredient.Chocolate] = "n48_game_hand_bigbowl17",
      [Ingredient.Coco] = "n48_game_hand_bigbowl16",
      [Ingredient.Pudding] = "n48_game_hand_bigbowl15",
      [Ingredient.Taro] = "n48_game_hand_bigbowl14"
    },
    [Weight.Big] = {
      [Ingredient.Chocolate] = "n48_game_hand_bigbowl8",
      [Ingredient.Coco] = "n48_game_hand_bigbowl7",
      [Ingredient.Pudding] = "n48_game_hand_bigbowl6",
      [Ingredient.Taro] = "n48_game_hand_bigbowl5"
    }
  },
  JamImg = {
    [Weight.Small] = {
      [Jam.Strawberry] = "n48_game_hand_bigbowl12",
      [Jam.Matcha] = "n48_game_hand_bigbowl10",
      [Jam.Biolac] = "n48_game_hand_bigbowl13",
      [Jam.Mango] = "n48_game_hand_bigbowl11"
    },
    [Weight.Big] = {
      [Jam.Strawberry] = "n48_game_hand_bigbowl4",
      [Jam.Matcha] = "n48_game_hand_bigbowl1",
      [Jam.Biolac] = "n48_game_hand_bigbowl3",
      [Jam.Mango] = "n48_game_hand_bigbowl2"
    }
  }
}
_enum("GuestOrderformHandImg", GuestOrderformHandImg)
local GuestImg = {
  Img = {
    [GuestMood.LookForward] = "n48_game_%s_good",
    [GuestMood.Quietness] = "n48_game_%s_normal",
    [GuestMood.Impatient] = "n48_game_%s_mad",
    [GuestMood.Happy] = "n48_game_%s_complete"
  },
  Misc = {
    Hand = "n48_game_%s_hand"
  }
}
_enum("GuestImg", GuestImg)
local MGAnimations = {
  OrderformStep = {
    [OrderformStep.Weight] = "uieffUIMiniGameController_Plate_Weight",
    [OrderformStep.Ingredient] = "uieffUIMiniGameController_Plate_Ingredient",
    [OrderformStep.Jam] = "uieffUIMiniGameController_Plate_Jam"
  },
  MiniGameState = {
    [MiniGameState.Start] = "uieffanim_UIN20MiniGame_Start_in",
    [MiniGameState.Over] = "uieffanim_UIN20MiniGame_Finish_in",
    [MiniGameState.Pause] = "uieffanim_UIN20MiniGame_puase_in",
    [MiniGameState.Skill] = {
      Start = "uieffUIMiniGameController_Center_skill_start",
      Loop = "uieffUIMiniGameController_Center_skill_loop",
      End = "uieffUIMiniGameController_Center_skill_end"
    },
    Cd = "uieffUIMiniGameController_Center_start_number"
  },
  Orderform = {
    ["in"] = "UIMiniGameOrderformItem_in",
    twinkle01 = "UIMiniGameOrderformItem_twinkle01",
    out = "UIMiniGameOrderformItem_out",
    twinkle02 = "UIMiniGameOrderformItem_twinkle02",
    ready = "UIMiniGameOrderformItem_ready"
  },
  Guest = {
    [GuestMood.LookForward] = "uieffUIMiniGameController_Guest_come",
    [GuestMood.Impatient] = "uieffUIMiniGameController_Guest_go",
    [GuestMood.Happy] = "uieffUIMiniGameController_Guest_happy"
  },
  Other = {
    Trash = "uieffUIMiniGameController_Trash",
    Score = "uieffanim_UIN20MiniGame_PanelEff",
    Bouns = "uieffanim_UIN20MiniGame_PanelEff",
    Skill = "uieffUIMiniGameController_Skill_Full",
    Switch = "uieffanim_N20MiniGameStage_in",
    SwitchMark = "uieff_Activity_Summer1_minigame_selectlevel"
  }
}
_enum("MGAnimations", MGAnimations)
local StepAudio = {
  [OrderformStep.Weight] = CriAudioIDConst.Summer1GameWeight,
  [OrderformStep.Ingredient] = CriAudioIDConst.Summer1GameIngredient,
  [OrderformStep.Jam] = CriAudioIDConst.Summer1GameJam
}
_enum("StepAudio", StepAudio)

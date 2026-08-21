local NewPlayerLoginStatus = {
  NPLS_UnReach = 1,
  NPLS_UnAccept = 2,
  NPLS_Accepted = 3
}
_enum("NewPlayerLoginStatus", NewPlayerLoginStatus)
_class("SignInOneDayInfo", Object)
SignInOneDayInfo = SignInOneDayInfo

function SignInOneDayInfo:Constructor()
  self.nDay = 0
  self.reward = RoleAsset:New()
  self.reward_is_good = false
end

SignInOneDayInfo._proto = {
  [1] = {"nDay", "int"},
  [2] = {"reward", "RoleAsset"},
  [3] = {
    "reward_is_good",
    "bool"
  }
}
_class("SignInState", Object)
SignInState = SignInState

function SignInState:Constructor()
  self.is_sign_in_today = false
  self.next_sign_in_time = 0
  self.sign_in_days = 0
  self.b_can_re_sign_in_ex_vig = false
end

SignInState._proto = {
  [1] = {
    "is_sign_in_today",
    "bool"
  },
  [2] = {
    "next_sign_in_time",
    "time"
  },
  [3] = {
    "sign_in_days",
    "int"
  },
  [4] = {
    "b_can_re_sign_in_ex_vig",
    "bool"
  }
}
_class("SignInBaseInfo", Object)
SignInBaseInfo = SignInBaseInfo

function SignInBaseInfo:Constructor()
  self.nMonth = 0
  self.MonthInfo = {}
  self.RoleSignInState = SignInState:New()
  self.nYear = 0
end

SignInBaseInfo._proto = {
  [1] = {"nMonth", "int"},
  [2] = {
    "MonthInfo",
    "list<SignInOneDayInfo>"
  },
  [3] = {
    "RoleSignInState",
    "SignInState"
  },
  [4] = {"nYear", "int"}
}
_class("TotalLoginInfo", Object)
TotalLoginInfo = TotalLoginInfo

function TotalLoginInfo:Constructor()
  self.nDay = 0
  self.Reward = {}
  self.bIsAccept = false
end

TotalLoginInfo._proto = {
  [1] = {"nDay", "int"},
  [2] = {
    "Reward",
    "list<RoleAsset>"
  },
  [3] = {"bIsAccept", "bool"}
}
local PredictionStatus = {
  PRES_UnReach = 1,
  PRES_UnAccept = 2,
  PRES_Accepted = 3
}
_enum("PredictionStatus", PredictionStatus)
local Prediction_Result_Code = {
  PREDICTION_SUCCEED = 0,
  PREDICTION_NO_OPEN = 1,
  PREDICTION_NO_STATUS = 2,
  PREDICTION_NO_DAY = 3,
  PREDICTION_SWITCH = 4,
  PREDICTION_HAVE_GET = 5,
  PREDICTION_NO_RES = 6
}
_enum("Prediction_Result_Code", Prediction_Result_Code)
_class("PredictionMsgInfo", Object)
PredictionMsgInfo = PredictionMsgInfo

function PredictionMsgInfo:Constructor()
  self.id = 0
  self.status = {}
  self.end_time = 0
  self.day = 0
end

PredictionMsgInfo._proto = {
  [1] = {"id", "int"},
  [2] = {
    "status",
    "map<int,int>"
  },
  [3] = {"end_time", "time"},
  [4] = {"day", "int"}
}
_class("MainDressUpInfo", Object)
MainDressUpInfo = MainDressUpInfo

function MainDressUpInfo:Constructor()
  self.range_select = 0
  self.pet_cfg_id = 0
  self.pet_grade = 0
  self.pet_skin_id = 0
  self.pet_x = 0
  self.pet_y = 0
  self.pet_scale = 0
  self.is_static = false
  self.bg_id = 0
  self.board_pet = 0
  self.bg_type = 0
  self.bg_x = 0
  self.bg_y = 0
  self.bg_scale = 0
  self.is_hand_operate = false
  self.spine_id = 0
end

MainDressUpInfo._proto = {
  [1] = {
    "range_select",
    "int"
  },
  [2] = {"pet_cfg_id", "int"},
  [3] = {"pet_grade", "int"},
  [4] = {
    "pet_skin_id",
    "int"
  },
  [5] = {"pet_x", "float"},
  [6] = {"pet_y", "float"},
  [7] = {"pet_scale", "float"},
  [8] = {"is_static", "bool"},
  [20] = {"bg_id", "int"},
  [21] = {"board_pet", "int"},
  [22] = {"bg_type", "int"},
  [23] = {"bg_x", "float"},
  [24] = {"bg_y", "float"},
  [25] = {"bg_scale", "float"},
  [26] = {
    "is_hand_operate",
    "bool"
  },
  [27] = {"spine_id", "int"}
}
_class("MainDressUpMap", Object)
MainDressUpMap = MainDressUpMap

function MainDressUpMap:Constructor()
  self.cur_index = -1
  self.info = {}
end

MainDressUpMap._proto = {
  [1] = {"cur_index", "int"},
  [2] = {
    "info",
    "map<int,MainDressUpInfo>"
  }
}

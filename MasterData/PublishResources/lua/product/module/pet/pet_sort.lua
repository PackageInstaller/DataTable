require("pet_type")
_class("PetFilterParam", Object)
PetFilterParam = PetFilterParam

function PetFilterParam:Constructor(filter_type, filter_tag, ...)
  self._filter_type = filter_type
  self._filter_tag = filter_tag
  self._param = {
    ...
  }
end

function PetFilterParam:IsFiltered(pet, containsSecondAttribute)
  if self._filter_type == PetFilterType.ElementBlue then
    if containsSecondAttribute then
      local es = pet:GetPetElements()
      return table.icontains(es, ElementType.ElementType_Blue)
    else
      return pet:GetPetFirstElement() == ElementType.ElementType_Blue
    end
  elseif self._filter_type == PetFilterType.ElementYellow then
    if containsSecondAttribute then
      local es = pet:GetPetElements()
      return table.icontains(es, ElementType.ElementType_Yellow)
    else
      return pet:GetPetFirstElement() == ElementType.ElementType_Yellow
    end
  elseif self._filter_type == PetFilterType.ElementGreen then
    if containsSecondAttribute then
      local es = pet:GetPetElements()
      return table.icontains(es, ElementType.ElementType_Green)
    else
      return pet:GetPetFirstElement() == ElementType.ElementType_Green
    end
  elseif self._filter_type == PetFilterType.ElementRed then
    if containsSecondAttribute then
      local es = pet:GetPetElements()
      return table.icontains(es, ElementType.ElementType_Red)
    else
      return pet:GetPetFirstElement() == ElementType.ElementType_Red
    end
  elseif self._filter_type == PetFilterType.ElementNone then
    if containsSecondAttribute then
      local es = pet:GetPetElements()
      return table.icontains(es, ElementType.ElementType_AnyNone)
    else
      return pet:GetPetFirstElement() == ElementType.ElementType_AnyNone
    end
  elseif self._filter_type == PetFilterType.MainElementBlue then
    return pet:GetPetFirstElement() == ElementType.ElementType_Blue
  elseif self._filter_type == PetFilterType.MainElementRed then
    return pet:GetPetFirstElement() == ElementType.ElementType_Red
  elseif self._filter_type == PetFilterType.MainElementGreen then
    return pet:GetPetFirstElement() == ElementType.ElementType_Green
  elseif self._filter_type == PetFilterType.MainElementYellow then
    return pet:GetPetFirstElement() == ElementType.ElementType_Yellow
  elseif self._filter_type == PetFilterType.MainElementNone then
    return pet:GetPetFirstElement() == ElementType.ElementType_AnyNone
  elseif self._filter_type == PetFilterType.InCentralRoom then
    return pet:SkillRelated(AirRoomType.CentralRoom)
  elseif self._filter_type == PetFilterType.InMazeRoom then
    return pet:SkillRelated(AirRoomType.MazeRoom)
  elseif self._filter_type == PetFilterType.InPowerRoom then
    return pet:SkillRelated(AirRoomType.PowerRoom)
  elseif self._filter_type == PetFilterType.InPrismRoom then
    return pet:SkillRelated(AirRoomType.PrismRoom)
  elseif self._filter_type == PetFilterType.InResouceRoom then
    return pet:SkillRelated(AirRoomType.ResouceRoom)
  elseif self._filter_type == PetFilterType.InEvilRoom then
    return pet:SkillRelated(AirRoomType.EvilRoom)
  elseif self._filter_type == PetFilterType.InPurifyRoom then
    return pet:SkillRelated(AirRoomType.PurifyRoom)
  elseif self._filter_type == PetFilterType.InTowerRoom then
    return pet:SkillRelated(AirRoomType.TowerRoom)
  elseif self._filter_type == PetFilterType.NotInRoom then
    return pet:GetPetAirRoom() == nil
  elseif self._filter_type == PetFilterType.BaiYeCheng or self._filter_type == PetFilterType.BaiYeXiaCheng or self._filter_type == PetFilterType.QiGuang or self._filter_type == PetFilterType.BeiJing or self._filter_type == PetFilterType.HongYouBanShou or self._filter_type == PetFilterType.TaiYangJiaoTuan or self._filter_type == PetFilterType.YouMin or self._filter_type == PetFilterType.LongZhou then
    local tags = pet:GetPetTags()
    return table.icontains(tags, self._filter_type)
  elseif self._filter_type == PetFilterType.JobColor then
    return pet:GetProf() == PetProfType.PetProf_Color
  elseif self._filter_type == PetFilterType.JobBlood then
    return pet:GetProf() == PetProfType.PetProf_Blood
  elseif self._filter_type == PetFilterType.JobAttack then
    return pet:GetProf() == PetProfType.PetProf_Attack
  elseif self._filter_type == PetFilterType.JobFunction then
    return pet:GetProf() == PetProfType.PetProf_Function
  elseif self._filter_type == PetFilterType.Refine then
    return UIPetEquipHelper.HasRefine(pet:GetTemplateID())
  elseif self._filter_type == PetFilterType.RedPoint_Break then
    local isShow = pet:IsShowRedPoint() or pet:IsShowSkinRedPoint()
    isShow = isShow or UIPetEquipHelper.CheckRefineRed(pet)
    return isShow
  elseif self._filter_type == PetFilterType.Fav_Collect then
    local isShow = pet:IsLike()
    return isShow
  end
  return true
end

PetSortType = {
  ID = 0,
  Star = 1,
  Level = 2,
  Element = 3,
  Attack = 4,
  Defence = 5,
  Health = 6,
  Affinity = 7,
  InRoom = 8,
  InOtherRoom = 9,
  WorkState = 10,
  NewOrOld = 11,
  Name = 12,
  Grade = 13,
  Die = 14,
  MazeHealth = 15,
  WorldBossRecord = 16,
  AirSwitchCount = 17,
  WaterFirst = 18,
  FireFirst = 19,
  SenFirst = 20,
  ElectricityFirst = 21,
  HomeSettled = 22,
  Refine = 23,
  FastTeam = 24,
  PopstarPro = 25,
  SMazeDie = 26,
  SMazeDispatch = 27,
  SMazeInTeam = 28,
  SMazeRotateBan = 29,
  SMazeBanPet = 30,
  NoneElementFirst = 31
}
PetSortOrder = {
  None = 0,
  Ascending = 1,
  Descending = 2
}
PetFilterTag = {
  ShuXing = 1,
  LeiXing = 2,
  ShiLi = 3,
  SecondAttribute = 4,
  General = 5
}
UISortFilterCfg = {
  UIHeartSpirit = {
    Sort = {
      1,
      2,
      3,
      4,
      5,
      6,
      7
    },
    Filter = {
      [PetFilterTag.ShuXing] = {
        1,
        2,
        3,
        4,
        18
      },
      [PetFilterTag.LeiXing] = {
        5,
        6,
        7,
        8
      },
      [PetFilterTag.ShiLi] = {
        9,
        10,
        11,
        12,
        13,
        14,
        17,
        15
      },
      [PetFilterTag.General] = {16}
    }
  },
  NormalTeam = {
    Sort = {
      1,
      2,
      3,
      4,
      5,
      6,
      7
    },
    Filter = {
      [PetFilterTag.ShuXing] = {
        1,
        2,
        3,
        4,
        18
      },
      [PetFilterTag.LeiXing] = {
        5,
        6,
        7,
        8
      },
      [PetFilterTag.ShiLi] = {
        9,
        10,
        11,
        12,
        13,
        14,
        17,
        15
      },
      [PetFilterTag.General] = {16}
    }
  },
  MazeTeam = {
    Sort = {
      1,
      15,
      3,
      4,
      5,
      6,
      2
    },
    Filter = {
      [PetFilterTag.ShuXing] = {
        1,
        2,
        3,
        4,
        18
      },
      [PetFilterTag.LeiXing] = {
        5,
        6,
        7,
        8
      },
      [PetFilterTag.ShiLi] = {
        9,
        10,
        11,
        12,
        13,
        14,
        17,
        15
      },
      [PetFilterTag.General] = {16}
    }
  },
  TowerTeam = {
    Sort = {
      1,
      2,
      4,
      5,
      6,
      7
    },
    Filter = {
      [PetFilterTag.LeiXing] = {
        5,
        6,
        7,
        8
      },
      [PetFilterTag.ShiLi] = {
        9,
        10,
        11,
        12,
        13,
        14,
        17,
        15
      },
      [PetFilterTag.General] = {16}
    }
  },
  HelpPetSelf = {
    Sort = {
      1,
      2,
      4,
      5,
      6,
      7
    },
    Filter = {
      [PetFilterTag.LeiXing] = {
        5,
        6,
        7,
        8
      },
      [PetFilterTag.ShiLi] = {
        9,
        10,
        11,
        12,
        13,
        14,
        17,
        15
      },
      [PetFilterTag.General] = {16}
    }
  },
  AircraftSettle = {
    Sort = {
      1,
      2,
      3,
      4,
      5,
      6,
      7
    },
    Filter = {
      [PetFilterTag.ShuXing] = {
        1,
        2,
        3,
        4,
        18
      },
      [PetFilterTag.LeiXing] = {
        5,
        6,
        7,
        8
      },
      [PetFilterTag.ShiLi] = {
        9,
        10,
        11,
        12,
        13,
        14,
        17,
        15
      },
      [PetFilterTag.General] = {16}
    }
  },
  SummerTwo = {
    Sort = {
      1,
      2,
      4,
      5,
      6,
      7
    },
    Filter = {
      [PetFilterTag.LeiXing] = {
        5,
        6,
        7,
        8
      },
      [PetFilterTag.ShiLi] = {
        9,
        10,
        11,
        12,
        13,
        14,
        17,
        15
      },
      [PetFilterTag.General] = {16}
    }
  },
  WorldBossTeam = {
    Sort = {
      1,
      16,
      3,
      4,
      5,
      6,
      7
    },
    Filter = {
      [PetFilterTag.ShuXing] = {
        1,
        2,
        3,
        4,
        18
      },
      [PetFilterTag.LeiXing] = {
        5,
        6,
        7,
        8
      },
      [PetFilterTag.ShiLi] = {
        9,
        10,
        11,
        12,
        13,
        14,
        17,
        15
      },
      [PetFilterTag.General] = {16}
    }
  },
  HomeSettle = {
    Sort = {
      4,
      1,
      3,
      2
    },
    Filter = {
      [PetFilterTag.ShuXing] = {
        1,
        2,
        3,
        4,
        18
      },
      [PetFilterTag.LeiXing] = {
        5,
        6,
        7,
        8
      },
      [PetFilterTag.ShiLi] = {
        9,
        10,
        11,
        12,
        13,
        14,
        17,
        15
      },
      [PetFilterTag.General] = {16}
    }
  },
  ChooseSortItem = {
    Sort = {
      1,
      4,
      3
    },
    Filter = {
      [PetFilterTag.ShuXing] = {
        1,
        2,
        3,
        4,
        18
      },
      [PetFilterTag.LeiXing] = {
        5,
        6,
        7,
        8
      },
      [PetFilterTag.ShiLi] = {
        9,
        10,
        11,
        12,
        13,
        14,
        17,
        15
      }
    }
  },
  SeasonMazeTeam = {
    Sort = {
      1,
      2,
      3,
      5,
      6,
      7
    },
    Filter = {
      [PetFilterTag.ShuXing] = {
        1,
        2,
        3,
        4,
        18
      },
      [PetFilterTag.LeiXing] = {
        5,
        6,
        7,
        8
      },
      [PetFilterTag.ShiLi] = {
        9,
        10,
        11,
        12,
        13,
        14,
        17,
        15
      }
    }
  },
  SeasonMazeBanPet = {
    Sort = {1, 3},
    Filter = {
      [PetFilterTag.ShuXing] = {
        1,
        2,
        3,
        4,
        18
      },
      [PetFilterTag.LeiXing] = {
        5,
        6,
        7,
        8
      },
      [PetFilterTag.ShiLi] = {
        9,
        10,
        11,
        12,
        13,
        14,
        17,
        15
      }
    }
  }
}
_class("PetSortParam", Object)
PetSortParam = PetSortParam

function PetSortParam:Constructor(sort_type, sort_order, ...)
  self._sort_type = sort_type
  self._sort_order = sort_order
  self._params = {
    ...
  }
end

function PetSortParam:SetParams(params)
  self._params = params
end

function PetSortParam:GetSortValue(pet)
  if self._sort_type == PetSortType.ID then
    return pet:GetTemplateID()
  elseif self._sort_type == PetSortType.Affinity then
    return pet:GetPetAffinityLevel()
  elseif self._sort_type == PetSortType.Star then
    return pet:GetPetStar()
  elseif self._sort_type == PetSortType.Level then
    return pet:GetPetLevel()
  elseif self._sort_type == PetSortType.Element then
    return pet:GetPetFirstElement() * -1
  elseif self._sort_type == PetSortType.Attack then
    return pet:GetPetAttack()
  elseif self._sort_type == PetSortType.Defence then
    return pet:GetPetDefence()
  elseif self._sort_type == PetSortType.Health then
    return pet:GetPetHealth()
  elseif self._sort_type == PetSortType.MazeHealth then
    local mazeModule = GameGlobal.GetModule(MazeModule)
    local pstid = pet:GetPstID()
    local mazePet = mazeModule:GetMazePetInfoByPstId(pstid)
    local upper = math.floor(mazeModule:GetCalPetMaxHp(pstid))
    local hp = math.floor(mazePet.blood * upper)
    return hp
  elseif self._sort_type == PetSortType.InRoom then
    local room = self._params[1]
    if room and pet == room:GetPet(pet:GetPstID()) then
      return 1
    end
    return 2
  elseif self._sort_type == PetSortType.InOtherRoom then
    local md = GameGlobal:GetInstance().GetModule(AircraftModule)
    local room_find = md:GetPetAirRoom(pet)
    local room_this = self._params[1]
    if room_find and room_this ~= room_find then
      return 1
    end
    return 2
  elseif self._sort_type == PetSortType.WorkState then
    local room_type = self._params[1]
    if room_type and pet:SkillRelated(room_type) then
      return 1
    end
    return 2
  elseif self._sort_type == PetSortType.NewOrOld then
    local md = GameGlobal:GetInstance().GetModule(PetModule)
    if md:BeNewPet(pet:GetTemplateID()) then
      return 1
    else
      return 2
    end
  elseif self._sort_type == PetSortType.Name then
    return pet:GetPetName()
  elseif self._sort_type == PetSortType.Grade then
    return pet:GetPetGrade()
  elseif self._sort_type == PetSortType.Die then
    local pstid = pet:GetPstID()
    local mazeModule = GameGlobal.GetModule(MazeModule)
    local mazePet = mazeModule:GetMazePetInfoByPstId(pstid)
    if mazePet.is_dead then
      return 1
    else
      return 2
    end
  elseif self._sort_type == PetSortType.SMazeDie then
    local pstid = pet:GetPstID()
    local uiSeasonMazeModule = GameGlobal.GetUIModule(SeasonMazeModule)
    local isDie = uiSeasonMazeModule:GetPetState(pstid, ESeasonMazePetStateType.ESeasonMazePetStateType_Dead)
    if isDie then
      return 1
    else
      return 2
    end
  elseif self._sort_type == PetSortType.SMazeDispatch then
    local pstid = pet:GetPstID()
    local uiSeasonMazeModule = GameGlobal.GetUIModule(SeasonMazeModule)
    local isWorking = uiSeasonMazeModule:GetPetState(pstid, ESeasonMazePetStateType.ESeasonMazePetStateType_Dispatch)
    if isWorking then
      return 1
    else
      return 2
    end
  elseif self._sort_type == PetSortType.WorldBossRecord then
    local pstid = pet:GetPstID()
    local worldBossModule = GameGlobal.GetModule(WorldBossModule)
    local inRecord = worldBossModule:CheckPetInRecordTeam(pstid)
    if inRecord then
      return 1
    else
      return 2
    end
  elseif self._sort_type == PetSortType.AirSwitchCount then
    local pstid = pet:GetPstID()
    local airModule = GameGlobal.GetModule(AircraftModule)
    local room = airModule:GetRoomByRoomType(AirRoomType.TacticRoom)
    local switchCount = room:GetPetRemainFightNum(pstid)
    if switchCount <= 0 then
      return 1
    else
      return 2
    end
  elseif self._sort_type == PetSortType.WaterFirst then
    return self:_GetSortElementValue(pet, ElementType.ElementType_Blue)
  elseif self._sort_type == PetSortType.FireFirst then
    return self:_GetSortElementValue(pet, ElementType.ElementType_Red)
  elseif self._sort_type == PetSortType.SenFirst then
    return self:_GetSortElementValue(pet, ElementType.ElementType_Green)
  elseif self._sort_type == PetSortType.ElectricityFirst then
    return self:_GetSortElementValue(pet, ElementType.ElementType_Yellow)
  elseif self._sort_type == PetSortType.NoneElementFirst then
    return self:_GetSortElementValue(pet, ElementType.ElementType_AnyNone)
  elseif self._sort_type == PetSortType.HomeSettled then
    local homeModule = GameGlobal.GetModule(HomelandModule)
    local canSettle = homeModule:PetCanSettle(pet:GetTemplateID())
    if not canSettle then
      return 3
    else
      local room = homeModule:GetPetSettledRoom(pet:GetPstID())
      if room ~= nil then
        return 2
      else
        return 1
      end
    end
  elseif self._sort_type == PetSortType.Refine then
    if not UIPetEquipHelper.HasRefine(pet:GetTemplateID()) then
      return 0
    end
    return pet:GetEquipRefineLv()
  elseif self._sort_type == PetSortType.FastTeam then
    local memId = pet:FastTeamMemID()
    if self._params ~= nil then
      memId = self._params[pet:GetPstID()]
    end
    if memId == nil then
      return 0
    else
      return 1
    end
  elseif self._sort_type == PetSortType.SMazeInTeam then
    local petid = pet:GetPstID()
    local inteam
    if self._params ~= nil then
      for k, v in pairs(self._params[1]) do
        if v == petid then
          inteam = true
          break
        end
      end
    end
    if inteam then
      return 1
    else
      return 0
    end
  elseif self._sort_type == PetSortType.PopstarPro then
    local missionModule = GameGlobal.GetModule(MissionModule)
    local ctx = missionModule:TeamCtx()
    local param = ctx.param
    local seasonCfg = Cfg.cfg_anipop_season[param[4]]
    local fetterID = seasonCfg.FettersId
    local petTempID = pet:GetPstID()
    local teams = ctx:Teams()
    local team = teams:Get(ctx.aniPopStarTeamId):Clone()
    local isFetter, fetterPetID = EliminateHelper.CheckFetter(fetterID, team.pets, petTempID)
    local curSlot = ctx.curSlot
    local replacePsdID = team.pets[curSlot]
    local petModule = GameGlobal.GetModule(PetModule)
    if curSlot == -1 then
      local memId = pet:FastTeamMemID()
      if self._params ~= nil then
        memId = self._params[pet:GetPstID()]
      end
      if memId == nil then
        return 0
      else
        return 1
      end
    end
    if replacePsdID ~= 0 and petModule:GetPet(replacePsdID):GetTemplateID() == fetterPetID then
      return 1
    end
    if isFetter then
      return 2
    else
      return 1
    end
  elseif self._sort_type == PetSortType.SMazeRotateBan then
    local memId
    if self._params ~= nil and table.icontains(self._params, pet:GetPstID()) then
      memId = 1
    end
    if memId == nil then
      return 1
    else
      return 0
    end
  elseif self._sort_type == PetSortType.SMazeBanPet then
    local sortVal = 2
    if self._params ~= nil then
      local manualBanPetList = self._params[1]
      local rotateBanPetList = self._params[2]
      if manualBanPetList and table.icontains(manualBanPetList, pet:GetPstID()) then
        sortVal = 1
      end
      if rotateBanPetList and table.icontains(rotateBanPetList, pet:GetPstID()) then
        sortVal = 0
      end
    end
    return sortVal
  end
  return 0
end

function PetSortParam:_GetSortElementValue(pet, elementType)
  local missionModule = GameGlobal.GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  if ctx.teamOpenerType == TeamOpenerType.PopStarPro then
    local param = ctx.param
    local fetterID = param[5]
    local petTempID = pet:GetPstID()
    local teams = ctx:Teams()
    local team = teams:Get(ctx.popStarTeamId):Clone()
    local tempValue = 0
    local isFetter, fetterID = EliminateHelper.CheckFetter(fetterID, team.pets, petTempID)
    if isFetter then
      tempValue = 1
    else
      tempValue = 0
    end
    local curSlot = ctx.curSlot
    local replacePsdID = team.pets[curSlot]
    local petModule = GameGlobal.GetModule(PetModule)
    if curSlot ~= -1 and replacePsdID ~= 0 and petModule:GetPet(replacePsdID):GetTemplateID() == fetterID then
      tempValue = 0
    end
    if pet:GetPetFirstElement() == elementType then
      return 0 + tempValue
    else
      return pet:GetPetFirstElement() * -2 + tempValue
    end
  elseif ctx.teamOpenerType == TeamOpenerType.AniPopStar then
    local param = ctx.param
    local curSeason = param[4]
    local seasonCfg = Cfg.cfg_anipop_season[curSeason]
    local fetterID = seasonCfg.FettersId
    local petTempID = pet:GetPstID()
    local teams = ctx:Teams()
    local team = teams:Get(ctx.aniPopStarTeamId):Clone()
    local tempValue = 0
    local isFetter, fetterPetID = EliminateHelper.CheckFetter(fetterID, team.pets, petTempID)
    if isFetter then
      tempValue = 1
    else
      tempValue = 0
    end
    local curSlot = ctx.curSlot
    local replacePsdID = team.pets[curSlot]
    local petModule = GameGlobal.GetModule(PetModule)
    if curSlot ~= -1 and replacePsdID ~= 0 and petModule:GetPet(replacePsdID):GetTemplateID() == fetterPetID then
      tempValue = 0
    end
    if pet:GetPetFirstElement() == elementType then
      return 0 + tempValue
    else
      return pet:GetPetFirstElement() * -2 + tempValue
    end
  elseif pet:GetPetFirstElement() == elementType then
    return 0
  else
    return pet:GetPetFirstElement() * -1
  end
end

function PetSortParam:Compare(a, b)
  local va = self:GetSortValue(a)
  local vb = self:GetSortValue(b)
  if self._sort_order == PetSortOrder.Ascending then
    return va < vb
  else
    return va > vb
  end
end

function PetModule:_SortPets(pet_list, filter_params, sort_params, containsSecondAttribute)
  local out = {}
  local filters = {}
  local filter_cnt = 0
  for _, filter in ipairs(filter_params) do
    local tag = filters[filter._filter_tag]
    if not tag then
      tag = {}
      filters[filter._filter_tag] = tag
      filter_cnt = filter_cnt + 1
    end
    tag[#tag + 1] = filter
  end
  for _, pet in pairs(pet_list) do
    local choosed = 0
    for _, tags in pairs(filters) do
      for _, tag in ipairs(tags) do
        if tag:IsFiltered(pet, containsSecondAttribute) then
          choosed = choosed + 1
          break
        end
      end
    end
    if choosed == filter_cnt then
      out[#out + 1] = pet
    end
  end
  
  local function sort_runner(runner, idx, a, b)
    local sorter = sort_params[idx]
    if sorter == nil then
      return false
    end
    if sorter:GetSortValue(a) == sorter:GetSortValue(b) then
      return runner(runner, idx + 1, a, b)
    else
      return sorter:Compare(a, b)
    end
  end
  
  table.sort(out, function(a, b)
    return sort_runner(sort_runner, 1, a, b)
  end)
  return out
end

PetDefaulSort = {
  [PetSortType.Star] = {
    [PetSortOrder.Descending] = {
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    },
    [PetSortOrder.Ascending] = {
      PetSortParam:New(PetSortType.Star, PetSortOrder.Ascending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    }
  },
  [PetSortType.Level] = {
    [PetSortOrder.Descending] = {
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    },
    [PetSortOrder.Ascending] = {
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Ascending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Ascending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    }
  },
  [PetSortType.Element] = {
    [PetSortOrder.Descending] = {
      PetSortParam:New(PetSortType.Element, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    },
    [PetSortOrder.Ascending] = {
      PetSortParam:New(PetSortType.Element, PetSortOrder.Ascending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    }
  },
  [PetSortType.Attack] = {
    [PetSortOrder.Descending] = {
      PetSortParam:New(PetSortType.Attack, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    },
    [PetSortOrder.Ascending] = {
      PetSortParam:New(PetSortType.Attack, PetSortOrder.Ascending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    }
  },
  [PetSortType.Defence] = {
    [PetSortOrder.Descending] = {
      PetSortParam:New(PetSortType.Defence, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    },
    [PetSortOrder.Ascending] = {
      PetSortParam:New(PetSortType.Defence, PetSortOrder.Ascending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    }
  },
  [PetSortType.Health] = {
    [PetSortOrder.Descending] = {
      PetSortParam:New(PetSortType.Health, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    },
    [PetSortOrder.Ascending] = {
      PetSortParam:New(PetSortType.Health, PetSortOrder.Ascending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    }
  },
  [PetSortType.Affinity] = {
    [PetSortOrder.Descending] = {
      PetSortParam:New(PetSortType.Affinity, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    },
    [PetSortOrder.Ascending] = {
      PetSortParam:New(PetSortType.Affinity, PetSortOrder.Ascending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    }
  },
  [PetSortType.MazeHealth] = {
    [PetSortOrder.Descending] = {
      PetSortParam:New(PetSortType.MazeHealth, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    },
    [PetSortOrder.Ascending] = {
      PetSortParam:New(PetSortType.MazeHealth, PetSortOrder.Ascending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    }
  },
  [PetSortType.WorldBossRecord] = {
    [PetSortOrder.Descending] = {
      PetSortParam:New(PetSortType.WorldBossRecord, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    },
    [PetSortOrder.Ascending] = {
      PetSortParam:New(PetSortType.WorldBossRecord, PetSortOrder.Ascending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Ascending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Ascending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    }
  },
  [PetSortType.WaterFirst] = {
    [PetSortOrder.Descending] = {
      PetSortParam:New(PetSortType.WaterFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.FireFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.SenFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    }
  },
  [PetSortType.FireFirst] = {
    [PetSortOrder.Descending] = {
      PetSortParam:New(PetSortType.FireFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.WaterFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.SenFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ElectricityFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    }
  },
  [PetSortType.SenFirst] = {
    [PetSortOrder.Descending] = {
      PetSortParam:New(PetSortType.SenFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.WaterFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.FireFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ElectricityFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    }
  },
  [PetSortType.ElectricityFirst] = {
    [PetSortOrder.Descending] = {
      PetSortParam:New(PetSortType.ElectricityFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.WaterFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.FireFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.SenFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    }
  },
  [PetSortType.NoneElementFirst] = {
    [PetSortOrder.Descending] = {
      PetSortParam:New(PetSortType.NoneElementFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.WaterFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.FireFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ElectricityFirst, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    }
  },
  [PetSortType.Refine] = {
    [PetSortOrder.Descending] = {
      PetSortParam:New(PetSortType.Refine, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    },
    [PetSortOrder.Ascending] = {
      PetSortParam:New(PetSortType.Refine, PetSortOrder.Ascending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Ascending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Ascending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    }
  },
  [PetSortType.PopstarPro] = {
    [PetSortOrder.Descending] = {
      PetSortParam:New(PetSortType.PopstarPro, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Grade, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Level, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.Star, PetSortOrder.Descending),
      PetSortParam:New(PetSortType.ID, PetSortOrder.Ascending)
    }
  }
}

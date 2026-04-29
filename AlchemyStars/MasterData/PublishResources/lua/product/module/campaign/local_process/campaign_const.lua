_class("CampaignConst", Object)
CampaignConst = CampaignConst

function CampaignConst.GetSafeStateInfo(campaignId, componentId, stateType, uiParamsTable)
  return {
    campaignId = campaignId,
    componentId = componentId,
    stateType = stateType,
    uiParamsTable = uiParamsTable
  }
end

function CampaignConst.GetCampaignUIStateParams(campID, campType, comID, missionCreateInfo, isWin, battleresultRt)
  local state, params = CampaignConst.GetCampaignUIStateParams_Old(campID, campType, comID, missionCreateInfo, isWin, battleresultRt)
  if state ~= nil then
    local stateInfos = {}
    table.insert(stateInfos, CampaignConst.GetSafeStateInfo(campID, comID, state, params))
    table.insert(stateInfos, CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UIMain, nil))
    return stateInfos
  end
  return CampaignConst._CampaignUIStateParams_SafeState(campID, campType, comID, missionCreateInfo, isWin, battleresultRt)
end

function CampaignConst._CampaignUIStateParams_SafeState(campID, campType, comID, missionCreateInfo, isWin, battleresultRt)
  local tb = {}
  tb[ECampaignType.CAMPAIGN_TYPE_N39] = {
    [ECampaignN39ComponentID.ECAMPAIGN_N39_LINE_MISSION] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UIN39LineMissionController, nil),
      CampaignConst.GetSafeStateInfo(campID, nil, UIStateType.UIN39MainController, {false, battleresultRt})
    },
    [ECampaignN39ComponentID.ECAMPAIGN_N39_HARD_LINE_MISSION] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UIN39HardLevelMain, {true, 1}),
      CampaignConst.GetSafeStateInfo(campID, nil, UIStateType.UIN39MainController, {false, battleresultRt})
    },
    [ECampaignN39ComponentID.ECAMPAIGN_N39_BLACK_DIFFICULT_MISSION] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UIN39HardLevelMain, {true, 2}),
      CampaignConst.GetSafeStateInfo(campID, nil, UIStateType.UIN39MainController, {false, battleresultRt})
    }
  }
  tb[ECampaignType.CAMPAIGN_TYPE_INLAND_N12] = {
    [ECampaignCN12ComponentID.ECAMPAIGN_N12_LINE_MISSION] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UICN12N41LineController, nil),
      CampaignConst.GetSafeStateInfo(campID, nil, UIStateType.UICN12N41MainController, nil)
    },
    [ECampaignCN12ComponentID.ECAMPAIGN_N12_DIFFICULT_MISSION] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UICN12N41HardController, nil),
      CampaignConst.GetSafeStateInfo(campID, nil, UIStateType.UICN12N41MainController, nil)
    },
    [ECampaignCN12ComponentID.ECAMPAIGN_N12_HEIXIA] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UICN12N41HardController, nil),
      CampaignConst.GetSafeStateInfo(campID, nil, UIStateType.UICN12N41MainController, nil)
    }
  }
  tb[ECampaignType.CAMPAIGN_TYPE_N42] = {
    [ECampaignN28ComponentID.ECAMPAIGN_N28_LINE_MISSION] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UIN28Line, nil),
      CampaignConst.GetSafeStateInfo(campID, nil, UIStateType.UIActivityN28MainController, nil)
    },
    [ECampaignN28ComponentID.ECAMPAIGN_N28_DIFFICULT_MISSION] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UIN28HardLevel, {
        {
          true,
          isWin,
          comID
        }
      }),
      CampaignConst.GetSafeStateInfo(campID, nil, UIStateType.UIActivityN28MainController, nil)
    },
    [ECampaignN28ComponentID.ECAMPAIGN_N28_FIRST_MEET] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UIN28HardLevel, {
        {
          true,
          isWin,
          comID
        }
      }),
      CampaignConst.GetSafeStateInfo(campID, nil, UIStateType.UIActivityN28MainController, nil)
    }
  }
  tb[ECampaignType.CAMPAIGN_TYPE_WEEK_TOWER] = {
    [ECampaignWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_MISSION] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UISideEnterCenter, {
        {
          campaign_type = ECampaignType.CAMPAIGN_TYPE_WEEK_TOWER
        }
      })
    }
  }
  tb[ECampaignType.CAMPAIGN_TYPE_STORY_ACTIVITY] = {
    [ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_MISSION] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UICommonLineMission, nil),
      CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UISideEnterCenter, nil)
    }
  }
  tb[ECampaignType.CAMPAIGN_TYPE_INLAND_N16] = {
    [ECampaignCN16ComponentID.ECAMPAIGN_N16_LINE_MISSION] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UICN16N45LineController, nil),
      CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UICN16N45MainController, nil)
    },
    [ECampaignCN16ComponentID.ECAMPAIGN_N16_HEIXIA] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UICN16N45HardLevel, nil),
      CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UICN16N45MainController, nil)
    }
  }
  tb[ECampaignType.CAMPAIGN_TYPE_INLAND_N4_CHALLENGE] = {
    [ECCampaignInlandN4ChallengeComponentID.CHALLENGE] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UISideEnterCenter, {
        {
          campaign_type = ECampaignType.CAMPAIGN_TYPE_INLAND_N4_CHALLENGE
        }
      })
    }
  }
  tb[ECampaignType.CAMPAIGN_TYPE_INLAND_N17] = {
    [ECampaignCN17ComponentID.ECAMPAIGN_N17_LINE_MISSION] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UICN17N46LineController, nil),
      CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UICN17N46MainController, nil)
    },
    [ECampaignCN17ComponentID.ECAMPAIGN_N17_HEIXIA] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UICN17N46HardLevel, nil),
      CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UICN17N46MainController, nil)
    }
  }
  tb[ECampaignType.CAMPAIGN_TYPE_INLAND_N18] = {
    [ECampaignCN18ComponentID.ECAMPAIGN_N18_LINE_MISSION] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UICN18N47LineController, nil),
      CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UICN18N47MainController, nil)
    },
    [ECampaignCN18ComponentID.ECAMPAIGN_N18_HEIXIA] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UICN18N47HardLevel, nil),
      CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UICN18N47MainController, nil)
    }
  }
  tb[ECampaignType.CAMPAIGN_TYPE_N48] = {
    [ECampaignN48ComponentID.LINE_MISSION] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UIN48LineMissionController, nil),
      CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UIN48MainController, nil)
    },
    [ECampaignN48ComponentID.HEIXIA] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UIN48HardController, nil),
      CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UIN48MainController, nil)
    }
  }
  tb[ECampaignType.CAMPAIGN_TYPE_INLAND_N20] = {
    [ECampaignCN20ComponentID.ECN20_LINE_MISSION] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UICN20N49LineController, nil),
      CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UICN20N49MainController, nil)
    },
    [ECampaignCN20ComponentID.ECN20_LINE_MISSION_TALEN] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UICN20N49LineTalentController, nil),
      CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UICN20N49MainController, nil)
    }
  }
  tb[ECampaignType.CAMPAIGN_TYPE_INLAND_N21] = {
    [ECampaignCN21ComponentID.ECN21_LINE_MISSION] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UICN21N50LineController, nil),
      CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UICN21N50MainController, nil)
    },
    [ECampaignCN21ComponentID.ECN21_HEIXIA] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UICN21N50HardLevel, nil),
      CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UICN21N50MainController, nil)
    }
  }
  tb[ECampaignType.CAMPAIGN_TYPE_INLAND_N22] = {
    [ECampaignCN22ComponentID.ECN22_LINE_MISSION] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UICN22N51LineController, nil),
      CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UICN22N51MainController, nil)
    },
    [ECampaignCN22ComponentID.ECN22_HEIXIA] = {
      CampaignConst.GetSafeStateInfo(campID, comID, UIStateType.UICN22N51HardLevel, nil),
      CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UICN22N51MainController, nil)
    }
  }
  local stateInfos = tb[campType] and tb[campType][comID] or {}
  table.insert(stateInfos, CampaignConst.GetSafeStateInfo(nil, nil, UIStateType.UIMain, nil))
  return stateInfos
end

function CampaignConst.GetCampaignUIStateParams_Old(campID, campType, comID, missionCreateInfo, isWin, battleresultRt)
  local state
  local params = {}
  if campType == ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN then
    if comID == ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_LINE_MISSION then
      state = UIStateType.UIActivityEveSinsaLevelAController
    elseif comID == ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_TREE_MISSION then
      state = UIStateType.UIActivityEveSinsaLevelBController
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_SUMMER_I then
    if comID == ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_COMMON then
      state = UIStateType.UIXH1SimpleLevel
    elseif comID == ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_HARD then
      state = UIStateType.UIXH1HardLevel
      params = {
        {true, isWin}
      }
    elseif comID == ECampaignSummerIComponentID.ECAMPAIGN_SUMMER_I_LEVEL_FIXTEAM then
      state = UIStateType.UIXH1SimpleLevel
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_SUMMER_II then
    if comID == ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION then
      state = UIStateType.UISummer2Level
      params = {
        {true, battleresultRt}
      }
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N5 then
    local missionId = missionCreateInfo.nCampaignMissionId
    if comID == ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION then
      state = UIStateType.UIActivityN5SimpleLevel
      params = {
        {
          true,
          isWin,
          missionId
        }
      }
    elseif comID == ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD then
      state = UIStateType.UIActivityN5BattleField
    elseif comID == ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION_FIXTEAM then
      state = UIStateType.UIActivityN5SimpleLevel
      params = {
        {
          true,
          isWin,
          missionId
        }
      }
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_HALLOWEEN then
    if comID == ECampaignN6ComponentID.ECAMPAIGN_N6_LINE_MISSION or comID == ECampaignN6ComponentID.ECAMPAIGN_N6_LINE_MISSION_FIXTEAM then
      state = UIStateType.UINP6Level
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_GRASS then
    if comID == ECampaignGrassComponentID.ECAMPAIGN_GRASS_MISSION then
      state = UIStateType.UIDiscovery
      local data = GameGlobal.GetModule(MissionModule):GetDiscoveryData()
      data:UpdatePosByEnter(7, missionCreateInfo.nCampaignMissionId)
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N7 then
    if comID == ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION or comID == ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION_FIXTEAM then
      state = UIStateType.UIN7Level
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N8 then
    if comID == ECampaignN8ComponentID.ECAMPAIGN_N8_LINE_MISSION or comID == ECampaignN8ComponentID.ECAMPAIGN_N8_LINE_MISSION_FIXTEAM then
      state = UIStateType.UIActivityN8LineMissionController
    elseif comID == ECampaignN8ComponentID.ECAMPAIGN_N8_COMBAT_SIMULATOR then
      state = UIStateType.UIActivityN8BattleSimulatorController
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N9 then
    if comID == ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_COMMON then
      state = UIStateType.UIActivityN9LineMissionController
    elseif comID == ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_HARD then
      state = UIStateType.UIN9HardLevel
      params = {
        {true, isWin}
      }
    elseif comID == ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_FIXTEAM then
      state = UIStateType.UIActivityN9LineMissionController
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N10 then
    if comID == ECampaignN10ComponentID.ECAMPAIGN_N10_LEVEL_FIXTEAM then
      state = UIStateType.UIN10MainController
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N11 then
    if comID == ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_COMMON then
      state = UIStateType.UIActivityN11LineMissionController
    elseif comID == ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_HARD then
      state = UIStateType.UIActivtiyN11HardLevelController
      params = {
        {true, isWin}
      }
    elseif comID == ECampaignN11ComponentID.ECAMPAIGN_N11_LEVEL_FIXTEAM then
      state = UIStateType.UIActivityN11LineMissionController
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N12 then
    if comID == ECampaignN12ComponentID.ECAMPAIGN_N12_ENTRUST then
      local curLevelId = component:GetCurLevelId()
      state = UIStateType.UIN12EntrustLevelController
      params = CampaignConst.GetCampaignUIStateParams_Entrust(campType, comID)
    elseif comID == ECampaignN12ComponentID.ECAMPAIGN_N12_DAILY_MISSION then
      state = UIStateType.UIN12NormalLevel
    elseif comID == ECampaignN12ComponentID.ECAMPAIGN_N12_CHALLENGE_MISSION then
      state = UIStateType.UIN12HardlLevelInfo
    elseif comID == ECampaignN12ComponentID.ECAMPAIGN_N12_LEVEL_FIXTEAM then
      state = UIStateType.UIN12HardlLevel
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N13 then
    if comID == ECampaignN13ComponentID.ECAMPAIGN_N13_LINE_MISSION then
      state = UIStateType.UIN13LineMissionController
    elseif comID == ECampaignN13ComponentID.ECAMPAIGN_N13_LEVEL_FIXTEAM then
      state = UIStateType.UIN13LineMissionController
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N14 then
    if comID == ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_COMMON then
      state = UIStateType.UIActivityN14LineMissionController
    elseif comID == ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_HARD then
      state = UIStateType.UIActivityN14HardMissionController
    elseif comID == ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_FIXTEAM then
      state = UIStateType.UIActivityN14LineMissionController
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N15 then
    if comID == ECampaignN15ComponentID.ECAMPAIGN_N15_LEVEL_FIXTEAM then
      state = UIStateType.UIN15LineMissionController
    elseif comID == ECampaignN15ComponentID.ECAMPAIGN_N15_LEVEL_COMMON then
      state = UIStateType.UIN15LineMissionController
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N16 then
    if comID == ECampaignN16ComponentID.ECAMPAIGN_N16_LEVEL_FIXTEAM then
      state = UIStateType.UIActivityN16LineMissionController
    elseif comID == ECampaignN16ComponentID.ECAMPAIGN_N16_LEVEL_HARD then
      params = {
        {true, isWin}
      }
      state = UIStateType.UIN16HardLevel
    elseif comID == ECampaignN16ComponentID.ECAMPAIGN_N16_LEVEL_COMMON then
      state = UIStateType.UIActivityN16LineMissionController
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N18 then
    if comID == ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_FIXTEAM then
      state = UIStateType.UIN18LineMissionController
    elseif comID == ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_HARD then
      state = UIStateType.UIN18HardMissionController
    elseif comID == ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_COMMON then
      state = UIStateType.UIN18LineMissionController
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N19_COMMON then
    if comID == ECampaignN19CommonComponentID.HARD_LEVEL then
      state = UIStateType.UIN19HardLevelController
    elseif comID == ECampaignN19CommonComponentID.COMMON_LEVEL then
      state = UIStateType.UIN19LineMissionController
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N19_P5 then
    if comID == ECampaignN19P5ComponentID.LEVEL then
      state = UIStateType.UIN19P5
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N20 then
    if comID == ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_COMMON then
      state = UIStateType.UIActivityN20NormalLevel
    end
    if comID == ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_HARD then
      state = UIStateType.UIActivityN20HardLevel
    end
    if comID == ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_FIXTEAM then
      state = UIStateType.UIActivityN20NormalLevel
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N21 then
    state = UIStateType.UIN21LineMissionController
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N21_CHALLENGE then
    state = UIStateType.UIActivityN21CCLevelDetail
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N22 then
    if comID == ECampaignN22ComponentID.ECAMPAIGN_N22_ENTRUST then
      state = UIStateType.UIN22EntrustLevelController
      params = CampaignConst.GetCampaignUIStateParams_Entrust(campType, comID)
    end
    if comID == ECampaignN22ComponentID.ECAMPAIGN_N22_FIRST_MEET then
      state = UIStateType.UIActivityN22LineMissionController
    end
    if comID == ECampaignN22ComponentID.ECAMPAIGN_N22_LINE_MISSION then
      state = UIStateType.UIActivityN22LineMissionController
    end
    if comID == ECampaignN22ComponentID.ECAMPAIGN_N22_DIFFICULT_MISSION then
      state = UIStateType.UIActivtiyN22HardLevelController
      params = {
        {true, isWin}
      }
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N23 then
    if comID == ECampaignN23ComponentID.ECAMPAIGN_N23_LINE_MISSION or comID == ECampaignN23ComponentID.ECAMPAIGN_N23_FIRST_MEET then
      state = UIStateType.UIN23Line
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N24 then
    if comID == ECampaignN24ComponentID.ECAMPAIGN_N24_FIRST_MEET then
      state = UIStateType.UIActivityN24MainController
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N25 then
    if comID == ECampaignN25ComponentID.ECAMPAIGN_N25_FIRST_MEET then
      state = UIStateType.UIN25Line
    elseif comID == ECampaignN25ComponentID.ECAMPAIGN_N25_LINE_MISSION then
      state = UIStateType.UIN25Line
    elseif comID == ECampaignN25ComponentID.ECAMPAIGN_N25_DIFFICULT_MISSION then
      state = UIStateType.UIActivtiyN25HardLevelController
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N26 then
    if comID == ECampaignN26ComponentID.ECAMPAIGN_N26_FIRST_MEET then
      state = UIStateType.UIN26Line
    elseif comID == ECampaignN26ComponentID.ECAMPAIGN_N26_LINE_MISSION then
      state = UIStateType.UIN26Line
    elseif comID == ECampaignN26ComponentID.ECAMPAIGN_N26_DIFFICULT_MISSION then
      state = UIStateType.UIN26HardLevel
      params = {
        {true, isWin}
      }
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N27 then
    if comID == ECampaignN27ComponentID.ECAMPAIGN_N27_DIFFICULT_MISSION then
      state = UIStateType.UIActivityN27HardLevelMain
      params = {false, 1}
    elseif comID == ECampaignN27ComponentID.ECAMPAIGN_N27_BLACK_DIFFICULT_MISSION then
      state = UIStateType.UIActivityN27HardLevelMain
      params = {
        false,
        2,
        missionCreateInfo.nCampaignMissionId
      }
    elseif comID == ECampaignN27ComponentID.ECAMPAIGN_N27_FIRST_MEET then
      state = UIStateType.UIN27LineMissionController
    elseif comID == ECampaignN27ComponentID.ECAMPAIGN_N27_LINE_MISSION then
      state = UIStateType.UIN27LineMissionController
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N29 then
    if comID == ECampaignN29ComponentID.ECAMPAIGN_N29_DIFFICULT_MISSION then
      state = UIStateType.UIActivityN29HardLevelMain
      params = {false, 1}
    elseif comID == ECampaignN29ComponentID.ECAMPAIGN_N29_BLACK_DIFFICULT_MISSION then
      state = UIStateType.UIActivityN29HardLevelMain
      params = {
        false,
        2,
        missionCreateInfo.nCampaignMissionId
      }
    elseif comID == ECampaignN29ComponentID.ECAMPAIGN_N29_LINE_MISSION then
      state = UIStateType.UIActivityN29LineLevel
    elseif comID == ECampaignN29ComponentID.ECAMPAIGN_N29_FIRST_MEET then
      state = UIStateType.UIActivityN29LineLevel
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N30 then
    if comID == ECampaignN30ComponentID.ECAMPAIGN_N30_ENTRUST then
      state = UIStateType.UIN30EntrustLine
      params = CampaignConst.GetCampaignUIStateParams_Entrust(campType, comID)
      params[2] = true
      params[3] = isWin
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N31 then
    if comID == ECampaignN31ComponentID.ECAMPAIGN_N31_LINE_MISSION then
      state = UIStateType.UIN31Line
    elseif comID == ECampaignN31ComponentID.ECAMPAIGN_N31_DIFFICULT_MISSION then
      state = UIStateType.UIN31HardLevel
      params = {
        {true, isWin}
      }
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N32 then
    if comID == ECampaignN32ComponentID.ECAMPAIGN_N32_MULTILINE_MISSION then
      state = UIStateType.UIN32MultiLineMapController
      params = {
        UIMultiLineData.LastFightForderIndex,
        true,
        isWin
      }
    elseif comID == ECampaignN32ComponentID.ECAMPAIGN_N32_DIFFICULT_MISSION then
      state = UIStateType.UIActivityN32HardLevelMain
      params = {false, 1}
    elseif comID == ECampaignN32ComponentID.ECAMPAIGN_N32_BLACK_DIFFICULT_MISSION then
      state = UIStateType.UIActivityN32HardLevelMain
      params = {
        false,
        2,
        missionCreateInfo.nCampaignMissionId
      }
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_DIFFICULTY_WEEK_TOWER then
    if comID == ECampaignDiffcultyWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_DIFFICULT_MISSION then
      state = UIStateType.UISideEnterCenter
      local tb = {}
      tb.campaign_type = ECampaignType.CAMPAIGN_TYPE_DIFFICULTY_WEEK_TOWER
      tb.params = missionCreateInfo
      params = {tb}
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_LINE_MISSION then
    if comID == ECampaignLineMissionComponentID.ECAMPAIGN_LINE_MISSION then
      state = UIStateType.UISideEnterCenter
      local tb = {}
      tb.campaign_type = ECampaignType.CAMPAIGN_TYPE_LINE_MISSION
      params = {tb}
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N33 then
    if comID == ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION then
      state = UIStateType.UIActivityN33LevelController
      local missionId = missionCreateInfo.nCampaignMissionId
      params = {
        1,
        false,
        missionId,
        true
      }
    elseif comID == ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION then
      state = UIStateType.UIActivityN33LevelController
      local missionId = missionCreateInfo.nCampaignMissionId
      params = {
        2,
        false,
        missionId,
        true
      }
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_INLAND_N6 then
    if comID == ECampaignCN6ComponentID.ECAMPAIGN_N6_LINE_MISSION then
      state = UIStateType.UICN6N35Line
      local missionId = missionCreateInfo.nCampaignMissionId
      params = {
        false,
        false,
        missionId,
        true
      }
    elseif comID == ECampaignCN6ComponentID.ECAMPAIGN_N6_DIFFICULT_MISSION then
      state = UIStateType.UIActivityCN6N35HardLevelMain
      params = {false, 1}
    elseif comID == ECampaignCN6ComponentID.ECAMPAIGN_N6_HEIXIA then
      state = UIStateType.UIActivityCN6N35HardLevelMain
      params = {
        false,
        2,
        missionCreateInfo.nCampaignMissionId
      }
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_INLAND_N7 then
    if comID == ECampaignCN7ComponentID.ECAMPAIGN_N7_LINE_MISSION then
      state = UIStateType.UICN7N36Line
      params = {false}
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_N37 then
    if comID == ECampaignN37ComponentID.ECAMPAIGN_N37_LINE_MISSION then
      state = UIStateType.UIN37LineMissionController
    elseif comID == ECampaignN37ComponentID.ECAMPAIGN_N37_HARD_LINE_MISSION then
      state = UIStateType.UIN37HardLevelMain
      params = {false, 1}
    elseif comID == ECampaignN37ComponentID.ECAMPAIGN_N37_BLACK_DIFFICULT_MISSION then
      state = UIStateType.UIN37HardLevelMain
      params = {false, 2}
    end
  elseif campType == ECampaignType.CAMPAIGN_TYPE_INLAND_N9 then
    if comID == ECampaignCN9ComponentID.ECAMPAIGN_N9_LINE_MISSION then
      state = UIStateType.UIN38Line
    elseif comID == ECampaignCN9ComponentID.ECAMPAIGN_N9_DIFFICULT_MISSION then
      state = UIStateType.UIN38HardLevel
      params = {false, 1}
    elseif comID == ECampaignCN9ComponentID.ECAMPAIGN_N9_HEIXIA then
      state = UIStateType.UIN38HardLevel
      params = {false, 2}
    end
  end
  if not state then
    state, params = CampaignConst._CampaignUIStateParams_SideEnter(campID, campType, comID, missionCreateInfo, isWin, battleresultRt)
  end
  if not state then
    local uimodule = GameGlobal.GetUIModule(CampaignModule)
    local data = uimodule:GetReviewData()
    state, params = data:GetBattleExitParam(campType, comID, missionCreateInfo, isWin, battleresultRt)
  end
  return state, params
end

function CampaignConst._CampaignUIStateParams_SideEnter(campID, campType, comID, missionCreateInfo, isWin, battleresultRt)
  local tb = {}
  tb[ECampaignType.CAMPAIGN_TYPE_INLAND_FIRSTPET] = {
    [ECCampaignInlandFirstPetComponentID.Line_MISSION] = {
      state = UIStateType.UISideEnterCenter,
      params = {
        {campaign_id = campID}
      }
    }
  }
  tb[ECampaignType.CAMPAIGN_TYPE_N33_EIGHT_PETS] = {
    [ECampaignN33EightPetsMissionComponentID.ECAMPAIGN_N33_Eight_Pets_MISSION] = {
      state = UIStateType.UISideEnterCenter,
      params = {
        {campaign_id = campID}
      }
    }
  }
  tb[ECampaignType.CAMPAIGN_TYPE_INLAND_S1] = {
    [ECCampaignInlandS1ComponentID.Line_MISSION] = {
      state = UIStateType.UISideEnterCenter,
      params = {
        {
          campaign_type = ECampaignType.CAMPAIGN_TYPE_INLAND_S1
        }
      }
    }
  }
  local jump = tb[campType] and tb[campType][comID]
  local state = jump and jump.state
  local params = jump and jump.params or {}
  return state, params
end

function CampaignConst.GetCampaignUIStateParams_Entrust(campType, comID)
  local campaign = UIActivityCampaign:New()
  campaign:LoadCampaignInfo_Local(campType)
  local component = campaign:GetComponent(comID)
  local curLevelId = component:GetCurLevelId()
  return {curLevelId}
end

function CampaignConst.GetCampaignAutoFightInfo(campType)
  local tb = {
    [ECampaignType.CAMPAIGN_TYPE_SUMMER_I] = {
      "UIXH1Stage",
      "UIXH1SimpleLevel"
    },
    [ECampaignType.CAMPAIGN_TYPE_N5] = {
      "UIActivityN5Stage",
      "UIActivityN5SimpleLevel"
    },
    [ECampaignType.CAMPAIGN_TYPE_HALLOWEEN] = {
      "UIActivityLevelStage",
      "UINP6Level"
    },
    [ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN] = {
      "UIActivityLevelStage",
      "UIActivityEveSinsaLevelAController"
    },
    [ECampaignType.CAMPAIGN_TYPE_N7] = {
      "UIActivityLevelStage",
      "UIN7Level"
    },
    [ECampaignType.CAMPAIGN_TYPE_N9] = {
      "UIActivityLevelStage",
      "UIActivityN9LineMissionController"
    },
    [ECampaignType.CAMPAIGN_TYPE_N11] = {
      "UIActivityLevelStage",
      "UIActivityN11LineMissionController"
    },
    [ECampaignType.CAMPAIGN_TYPE_N14] = {
      "UIActivityLevelStage",
      "UIActivityN14LineMissionController"
    },
    [ECampaignType.CAMPAIGN_TYPE_N18] = {
      "UIActivityLevelStageNew",
      "UIN18LineMissionController"
    },
    [ECampaignType.CAMPAIGN_TYPE_N20] = {
      "UIActivityLevelStage",
      "UIActivityN20NormalLevel"
    },
    [ECampaignType.CAMPAIGN_TYPE_REVIEW_N6] = {
      "UIActivityLevelStageNew",
      "UIActivityN6LineMissionReview"
    }
  }
  if campType then
    if campType == ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON then
      return UISeasonHelper.CurSeasonStageUI(), UISeasonHelper.CurSeasonSceneUI()
    end
    if tb[campType] then
      local campStageUI, campWaitUI = tb[campType][1], tb[campType][2]
      return campStageUI, campWaitUI
    else
      Log.error("CampaignConst.GetCampaignAutoFightInfo() 活动类型未配置，", campType)
    end
  end
end

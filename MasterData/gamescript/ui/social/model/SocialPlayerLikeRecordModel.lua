local RelationListType = SocialDefine.RelationListType

local function createSocialPlayerLikeRecordModelState()
  local state = {}
  
  function state.totdayLikeRecord()
    local myPlayerData = SocialDataUtils.GetMyPlayer()
    return myPlayerData and myPlayerData.todayGoodRecord or {}
  end
  
  function state.showingGroup()
    local rst = SocialDataUtils.GetRelationListByType(RelationListType.Good) or {}
    return rst
  end
  
  function state.likeRecordNum()
    local myPlayerData = SocialDataUtils.GetMyPlayer()
    if not myPlayerData then
      return 0
    end
    return myPlayerData.goodRecordNum or 0
  end
  
  state.scrollBarVal = 0
  state.perQueryNum = 10
  state.maxListNum = DT.GetConstant("SocializeAdmireListLimit")
  return state
end

local function createSocialPlayerLikeRecordModelViews(_)
  local views = {}
  return views
end

local function createSocialPlayerLikeRecordModelActions(_)
  local actions = {}
  
  function actions:AddTodayLikeRecord(uid, timestamp)
    if not uid or not timestamp then
      return
    end
    SocialDataUtils.AddLikeRecord(uid, 1, timestamp)
  end
  
  function actions:SetScrollBarVal(nVal)
    self.scrollBarVal = nVal
  end
  
  return actions
end

local function onSetup(_, _)
  SocialDataUtils.ResetRelationListByType(RelationListType.Good)
  SocialDataUtils.ReqOnSocialQueryList(RelationListType.Good, 1, 10, 1)
end

local SocialPlayerLikeRecordModel = Vue.model("SocialPlayerLikeRecordModel", createSocialPlayerLikeRecordModelState):views(createSocialPlayerLikeRecordModelViews):actions(createSocialPlayerLikeRecordModelActions):setup(onSetup)
return SocialPlayerLikeRecordModel

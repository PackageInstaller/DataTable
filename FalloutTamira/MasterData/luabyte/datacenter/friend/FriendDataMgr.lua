local FriendDataMgr = BaseClass("FriendDataMgr", Singleton)
local M = FriendDataMgr
local MessageId = Proto.MessageId
local tSort = table.sort
local tInsert = table.insert


-- 获取当前最大好友数量
function M:GetFriendNumMax()
    return self._maxFriendNum
end

-- 获取当前最大申请好友数量
function M:GetApplyFriendNumMax()
    return self._maxApplyFriendNum
end

-- 获取当前上阵英雄Id
function M:GetUpHeroIds()
   return self._curUpHeros
end

-- 获得好友数据的请求 从index开始 请求num个 会获取好友详细数据 获取结束 callback(data) 返回
-- 数据结构 data { FriendId = 好友id, BaseData = 基础数据, DetailData = 详细数据 }
function M:SendRequestFriendData(index, num, callback)
    self._callBack = callback

    local data = {}
    data.StartIndex = index
    data.Count = num
    NetPack:SendMessage(MessageId.RequestFriendships, data)
end


function M:_OnResponseFriendshipsCallBack(messagId, result, msg)
    if not self:_IsSuccess(result) then
        self:_DebugError("请求好友数据", result)
        return 
    end
    
    self._maxFriendNum = msg.Total
    self._friendData = {}

    self:_SetFriendData(msg.List)
    self:_CallBack(self._friendData)
end

function M:_SetFriendData(data)
    for i,v in ipairs(data) do        
        local firend = {
            FriendId = v.FriendId,
            BaseData = 
            {
                Avatar = v.Avatar,
                FriendId = v.FriendId,
                Level = v.Level,
                LogoutTime = v.LogoutTime,
                Nickname = v.Nickname,
                Online = v.Online,
                PlayerIconId = v.PlayerIconId,
                Remark = v.Remark,
            },
            DetailData = 
            {
                Achievements = v.Achievements,
                AchievementsFinishedCount = v.AchievementsFinishedCount,
                EliteId = v.EliteId,
                HeroList = v.HeroList,
                MissionId = v.MissionId,
            }
        }
        tInsert(self._friendData, firend)
    end
end

-- function M:_OnResponseFriendshipDetailCallBack(messagId, result, msg)
--     if not self:_IsSuccess(result) then
--         self:_DebugError("请求好友详细数据", result)
--         return
--     end
-- end


-- 获取所有好友助战英雄数据 全量数据 获取到后会进行排序
function M:SendRequestFriendHeroData(callback)
    self._callBack = callback
    local nowTimer = TimeUtil.GetNowTimeStamp()
    local cd = ConfigHelper.GetSystemParam(308)
    if not self.lastTimer or nowTimer - self.lastTimer >= cd then
        NetPack:SendMessage(MessageId.RequestFriendHelpBattleInfo, {})
    else
        self:_CallBack(self.heroList) 
    end
end

-- 获取好友申请数据 
function M:SendRequestApplyFriendData(index, num, callback)
    self._callBack = callback

    local data = {}
    data.StartIndex = index
    data.Count = num
    NetPack:SendMessage(MessageId.RequestGetFriendshipRequests, data)
end

-- 查找指定id的好友
function M:SendRequestFindFriendData(id, callback)
    self._callBack = callback
    if id > 2^63 -1 then 
        GameHelper.Tips("位數超出限制")
        return 
    end
    local data = {}
    data.FriendId = id
    NetPack:SendMessage(MessageId.RequestFindFriend, data)
end

-- 添加好友申请
function M:SendRequestAddFriendShip(id, callback)
    self._friendId = id
    self._callBack = callback

    local data = {}
    data.FriendId = id
    NetPack:SendMessage(MessageId.RequestAddFriendshipRequest, data)   
end

-- 添加好友
function M:SendRequestAgreeFriendShip(id, callback)
    self._callBack = callback

    local data = {}
    data.FriendId = id
    NetPack:SendMessage(MessageId.RequestAgreeFriendshipRequest, data)   
end

--  拒绝好友
function M:SendRequestRefuseFriendShip(id, callback)
    self._callBack = callback

    local data = {}
    data.FriendId = id
    NetPack:SendMessage(MessageId.RequestRefuseFriendshipRequest, data)   
end

-- 删除好友
function M:SendRequsetRemoveFriendData(id, callback)
    self._friendId = id
    self._callBack = callback

    local data = {}
    data.FriendId = id
    NetPack:SendMessage(MessageId.RequestDelFriendship, data) 
end

-- 全部同意好友请求
function M:SendRequsetAllAddFriends(callback)
    self._callBack = callback
    NetPack:SendMessage(MessageId.RequestAgreeAllFriendshipRequests, {})   
end

-- 全部拒绝好友请求
function M:SendRequestAllRefuseFriends(callback)
    self._callBack = callback
    NetPack:SendMessage(MessageId.RequestRefuseAllFriendshipRequests, {})   
end

-- 设置我的上阵英雄
function M:SendRequestSelectHero(ids, callback)
    self._heroIds = ids
    self._callBack = callback

    local data = {}
    data.HeroIds = ids
    NetPack:SendMessage(MessageId.RequestSetHelpBattleHero, data)   
end

-- 获取我的上阵英雄
function M:SendRequsetMyUpHero(callback)
    self._callBack = callback
    NetPack:SendMessage(MessageId.RequestGetFriendshipData, {})   
end

-- 设置备注
function M:SendRequsetRemark(id, name, callback)
    self._callBack = callback

    local data = {}
    data.FriendId = id
    data.Remark = name
    NetPack:SendMessage(MessageId.RequestUpdateFriendshipRemark, data)   
end

-- 获取好友英雄数据
function M:SendRequestHeroData(heroid, friendid, callback)
    self._callBack = callback

    local data = {}
    data.FriendId = friendid
    data.HeroId = heroid
    NetPack:SendMessage(MessageId.RequestHelpBattleHero, data)  
end

-- 获取好友成就信息
function M:SendRequsetFriendAchievements(friendid, callback)
    self._callBack = callback

    local data = {}
    data.FriendId = friendid
    NetPack:SendMessage(MessageId.RequestFriendAchievements, data)  
end

function M:__init()
    self._maxApplyFriendNum = 0
    self._maxFriendNum = 0
    self._detailIndex = 0
    self._curUpHeros = {} 
    self._heroIds = nil
    self._ResponseFriendships = NetPack:RegistResponse(MessageId.ResponseFriendships, Bind(self, self._OnResponseFriendshipsCallBack))
    self._ResponseAddFriendshipRequest = NetPack:RegistResponse(MessageId.ResponseAddFriendshipRequest, Bind(self, self._OnResponseAddFriendshipRequestCallBack))
    self._ResponseFriendHelpBattleInfo = NetPack:RegistResponse(MessageId.ResponseFriendHelpBattleInfo, Bind(self, self._OnResponseFriendHelpBattleInfoCallBack))
    self._ResponseGetFriendshipRequests = NetPack:RegistResponse(MessageId.ResponseGetFriendshipRequests, Bind(self, self._OnResponseGetFriendshipRequestsCallBack))
    self._ResponseAgreeFriendshipRequest = NetPack:RegistResponse(MessageId.ResponseAgreeFriendshipRequest, Bind(self, self._OnResponseAgreeFriendshipRequestCallBack))
    self._ResponseFindFriend = NetPack:RegistResponse(MessageId.ResponseFindFriend, Bind(self, self._OnResponseFindFriendCallBack))
    self._ResponseDelFriendship = NetPack:RegistResponse(MessageId.ResponseDelFriendship, Bind(self, self._OnResponseDelFriendshipCallBack))
    self._ResponseRefuseFriendship = NetPack:RegistResponse(MessageId.ResponseRefuseFriendshipRequest, Bind(self, self._OnResponseRefuseFriendshipCallBack))
    self._ResponseAgreeAllFriendshipRequests = NetPack:RegistResponse(MessageId.ResponseAgreeAllFriendshipRequests, Bind(self, self._OnResponseAgreeAllFriendshipRequestsCallBack))  
    self._ResponseRefuseAllFriendshipRequests = NetPack:RegistResponse(MessageId.ResponseRefuseAllFriendshipRequests, Bind(self, self._OnResponseRefuseAllFriendshipRequestsCallBack))  
    self._ResponseGetFriendshipData = NetPack:RegistResponse(MessageId.ResponseGetFriendshipData, Bind(self, self._OnResponseGetFriendshipDataCallBack))    
    self._ResponseSetHelpBattleHero = NetPack:RegistResponse(MessageId.ResponseSetHelpBattleHero, Bind(self, self._OnResponseSetHelpBattleHeroCallBack))   
    self._ResponseUpdateFriendshipRemark = NetPack:RegistResponse(MessageId.ResponseUpdateFriendshipRemark, Bind(self, self._OnResponseUpdateFriendshipRemarkCallBack)) 
    self._ResponseHelpBattleHero = NetPack:RegistResponse(MessageId.ResponseHelpBattleHero, Bind(self, self._OnResponseHelpBattleHeroCallBack)) 
    self._ResponseFriendAchievements = NetPack:RegistResponse(MessageId.ResponseFriendAchievements, Bind(self, self._OnResponseFriendAchievementsCallBack))
    self._NotifyAddFriendRequest = NetPack:RegistResponse(MessageId.NotifyAddFriendRequest, Bind(self, self._OnNotifyAddFriendRequestCallBack))     
    --self._ResponseFriendshipDetail = NetPack:RegistResponse(MessageId.ResponseFriendshipDetail, Bind(self, self._OnResponseFriendshipDetailCallBack))
end

function M:_OnNotifyAddFriendRequestCallBack(messagId, result, msg)
    if not self:_IsSuccess(result) then
        self:_DebugError("通知有好友申请", result)
        return 
    end

    self._maxApplyFriendNum = msg.TotalCount
    RedPointMgr:ForceCheck(RedPointConst.FriendApplyRedPointChecker)
end

function M:_OnResponseFriendAchievementsCallBack(messagId, result, msg)
    if not self:_IsSuccess(result) then
        self:_DebugError("获取好友成就数据", result)
        return 
    end

    local msgData = msg
    if #msgData.Achievements <= 0 then
        msgData.Achievements  = {}

        local cfg = ConfigHelper.GetCfgs("achievementGroup") 
        for i,k in ipairs(cfg) do
            local data = {}
            data.Id = k.id;
            data.Level = 1;
            data.FinishedCount = 0;
            tInsert(msgData.Achievements, data)
        end
    end

    self:_CallBack(msgData.Achievements)
end

function M:_OnResponseHelpBattleHeroCallBack(messagId, result, msg)
    if not self:_IsSuccess(result) then
        self:_DebugError("获取好友英雄数据", result)
        return 
    end

    -- 重置等级 一切等级 根据自己英雄最大的等级匹配
    local heroMsg = msg.Hero
    FriendHelper.ReplaceMaxParme(heroMsg, nil, "Level", "GetLevel")
    FriendHelper.ReplaceMaxParme(heroMsg, nil, "SkillLevel", "GetSkillLevel")
    FriendHelper.ReplaceMaxParme(heroMsg, nil, "AwakeLevel", "GetAwakeLevel")
    FriendHelper.ReplaceMaxParme(heroMsg, nil, "Grade", "GetBreakLevel")

    -- 定义一个新的 herodatanew
    local heroData = IHeroDataMgr:GetNewHeroDataById(heroMsg.HeroId)
    heroData:SetLevel(heroMsg.Level);
    heroData:SetAwakeLevel(heroMsg.AwakeLevel);
    heroData:SetSkillLevel(heroMsg.SkillLevel);
    heroData:SetCoreLevel(heroMsg.CoreLevel);
    heroData:SetAIWeapon(heroMsg.AIWeapon);
    heroData:SetBreakLevel(heroMsg.Grade)
    heroData:SetFashion(self:_getSkinId(heroMsg.HeroId))
    heroData:SetGeneStar(GenesStar)
    if heroMsg.GenesStars ~= nil and #heroMsg.GenesStars>0 then
        heroData:SetGenesStars(heroMsg.GenesStars)
    end

    -- team 里 需要存储的 数据结构
    local data = {}
    data.FriendId = heroMsg.FriendId
    data.HeroData = heroData
    self:_CallBack(data)
end

function M:_getSkinId(heroId)
    for k ,v in pairs(self.heroList)do
        if v.HeroId==heroId then
            return v.Skin
        end
    end
    return 0
end

function M:_OnResponseUpdateFriendshipRemarkCallBack(messagId, result, msg)
    if not self:_IsSuccess(result) then
        self:_DebugError("设置备注", result)
        return 
    end

    self:_CallBack()
end

function M:_OnResponseSetHelpBattleHeroCallBack(messagId, result, msg)
    if not self:_IsSuccess(result) then
        self:_DebugError("设置我自己的上阵英雄数据", result)
        return 
    end

    self._curUpHeros = self._heroIds
    self._heroIds = nil
    self:_CallBack()
end

function M:_OnResponseGetFriendshipDataCallBack(messagId, result, msg)
    if not self:_IsSuccess(result) then
        self:_DebugError("获取我自己的上阵英雄数据", result)
        return 
    end

    self._curUpHeros = {}
    for i,v in ipairs(msg.HelpHeroes) do
        tInsert( self._curUpHeros, v.HeroId)
    end

    self:_CallBack()
end

function M:_OnResponseRefuseAllFriendshipRequestsCallBack(messagId, result, msg)
    if not self:_IsSuccess(result) then
        self:_DebugError("拒绝全部好友", result)
        return 
    end

    self._maxApplyFriendNum = 0
    self:_CallBack()
    RedPointMgr:ForceCheck(RedPointConst.FriendApplyRedPointChecker)
end

function M:_OnResponseAgreeAllFriendshipRequestsCallBack(messagId, result, msg)
    if not self:_IsSuccess(result) then
        self:_DebugError("同意全部好友", result)
        return 
    end

    self._maxApplyFriendNum = 0
    self._maxFriendNum = self._maxFriendNum + msg.Total
    self:_CallBack()
    RedPointMgr:ForceCheck(RedPointConst.FriendApplyRedPointChecker)
end

function M:_OnResponseRefuseFriendshipCallBack(messagId, result, msg)
    if not self:_IsSuccess(result) then
        self:_DebugError("拒绝好友", result)
        return 
    end

    self._maxApplyFriendNum = self._maxApplyFriendNum - 1
    self:_CallBack()
    RedPointMgr:ForceCheck(RedPointConst.FriendApplyRedPointChecker)
end

function M:_OnResponseDelFriendshipCallBack(messagId, result, msg)
    if not self:_IsSuccess(result) then
        self:_DebugError("删除好友", result)
        return 
    end

    self._maxFriendNum = self._maxFriendNum - 1
    self:_CallBack()
    EventMgr:Broadcast(UIMessageNames.FRIEND_REMOVE_UPDATE, self._friendId)
end

function M:_OnResponseAddFriendshipRequestCallBack(messagId, result, msg)
    if not self:_IsSuccess(result) then
        self:_DebugError("添加好友请求", result)
        return 
    end

    self:_CallBack()
end

function M:_OnResponseAgreeFriendshipRequestCallBack(messagId, result, msg)
    if not self:_IsSuccess(result) then
        self:_DebugError("同意好友申请", result)
        return 
    end

    self._maxApplyFriendNum = self._maxApplyFriendNum - 1
    self._maxFriendNum = self._maxFriendNum + 1
    self:_CallBack()
    EventMgr:Broadcast(UIMessageNames.FRIEND_ADD_UPDATE, self._friendId)
    GameKeyNodeMgr:GetInstance():Record(EGameKeyNode.AddFriends)
    RedPointMgr:ForceCheck(RedPointConst.FriendApplyRedPointChecker)
end

function M:_OnResponseFindFriendCallBack(messagId, result, msg)
    if not self:_IsSuccess(result) then
        self:_DebugError("请求查找好友数据", result)
        return 
    end

    self:_CallBack({ msg.friend })
end

function M:_OnResponseGetFriendshipRequestsCallBack(messagId, result, msg)
    self._isloading = false 
    self._dataLoaded = true
    
    if not self:_IsSuccess(result) then
        self:_DebugError("请求好友申请数据", result)
        return 
    end

    self._maxApplyFriendNum = msg.Total
    self:_CallBack(msg.Requests)
end

--请求助战英雄的简单数据 Ack
function M:_OnResponseFriendHelpBattleInfoCallBack(messagId, result, msg)
    if not self:_IsSuccess(result) then
        self:_DebugError("请求全部好友英雄数据", result)
        return 
    end
    self.heroList = {}
    self.lastTimer = TimeUtil.GetNowTimeStamp()
    if #msg.Heroes <= 0 then
        self:_CallBack(self.heroList)
        return
    end

    for _,FriendHelpBattleHero in pairs(msg.Heroes) do
        local friendId = FriendHelpBattleHero.FriendId
        local friendData = {}
        friendData.FriendId = friendId
        friendData.Nickname = msg.Nicknames[friendId]
        friendData.IsFriends = msg.IsFriends[friendId]
        friendData.HeroId = FriendHelpBattleHero.HeroId
        friendData.Level = FriendHelpBattleHero.Level
        friendData.Grade = FriendHelpBattleHero.Grade
        friendData.Awake = FriendHelpBattleHero.Awake
        friendData.Skin = FriendHelpBattleHero.Skin
        self.heroList[#self.heroList + 1] = friendData 
    end
    tSort(self.heroList,self.HeroSort)
    -- FriendHelper.HeroSort(self.heroList)

    local maxLevel = FriendHelper.FindMaxParme("GetLevel")
    for _,v in ipairs(self.heroList) do 
        FriendHelper.ReplaceMaxParme(v, maxLevel, "Level")
    end

    self:_CallBack(self.heroList)
end

function M.HeroSort(v1, v2)
    if not v1.Cfg then
        v1.Cfg = ConfigHelper.GetCfg("hero", v1.HeroId)
        v1.Profession = (ConfigHelper.GetCfg("role", v1.HeroId)).Profession
    end

    if not v2.Cfg then
        v2.Cfg = ConfigHelper.GetCfg("hero", v2.HeroId)
        v1.Profession = (ConfigHelper.GetCfg("role", v1.HeroId)).Profession
    end

    local cfg1 = v1.Cfg
    local cfg2 = v2.Cfg
         
    if v1.Level ~= v2.Level then
        return v1.Level > v2.Level
    end 

    if cfg1.rare ~= cfg2.rare then
        return cfg1.rare > cfg2.rare
    end
    return cfg1.order > cfg2.order
end



function M:_CallBack(...)
    if not self._callBack then
        return
    end

    local callback = self._callBack
    self._callBack = nil
    callback(...)
end

function M:_DebugError(desc, result)
    local str = string.format("【FriendDataMgr】%s 失败错误码：%d ", desc, result)
    Logger.LogError(str)
    self._callBack = nil
end

function M:_IsSuccess(result)
    if result == 0 or result == "Success" then
        return true
    end

    return false
end

function M:_Destory()
    NetPack:UnRegistResponse(MessageId.ResponseFriendships, self._ResponseFriendships)
    NetPack:UnRegistResponse(MessageId.ResponseAddFriendshipRequest, self._ResponseAddFriendshipRequest)
    NetPack:UnRegistResponse(MessageId.ResponseGetAllHelpBattleHeroes, self._ResponseGetAllHelpBattleHeroes)
    NetPack:UnRegistResponse(MessageId.ResponseGetFriendshipRequests, self._ResponseGetFriendshipRequests)
    NetPack:UnRegistResponse(MessageId.ResponseAgreeFriendshipRequest, self._ResponseAgreeFriendshipRequest)
    NetPack:UnRegistResponse(MessageId.ResponseFindFriend, self._ResponseFindFriend)
    NetPack:UnRegistResponse(MessageId.ResponseDelFriendship, self._ResponseDelFriendship)
    NetPack:UnRegistResponse(MessageId.ResponseRefuseFriendshipRequest, self._ResponseRefuseFriendship)
    NetPack:UnRegistResponse(MessageId.ResponseAgreeAllFriendshipRequests, self._ResponseAgreeAllFriendshipRequests)
    NetPack:UnRegistResponse(MessageId.ResponseRefuseAllFriendshipRequests, self._ResponseRefuseAllFriendshipRequests)
    NetPack:UnRegistResponse(MessageId.ResponseGetFriendshipData, self._ResponseGetFriendshipData)
    NetPack:UnRegistResponse(MessageId.ResponseSetHelpBattleHero, self._ResponseSetHelpBattleHero)
    NetPack:UnRegistResponse(MessageId.ResponseUpdateFriendshipRemark, self._ResponseUpdateFriendshipRemark)
    NetPack:UnRegistResponse(MessageId.ResponseHelpBattleHero, self._ResponseHelpBattleHero)
    NetPack:UnRegistResponse(MessageId.ResponseFriendshipDetail, self._ResponseFriendshipDetail)
end

function M:Dispose()
    self:_Destory()
end

--IDataGetter start 
--用于在登录的时候初始化相关数据
function M:LoadData()
    self._isloading = true 
    self._dataLoaded = false
    self._errorCode = 0
    self:SendRequestApplyFriendData(0, 1)
end

function M:IsLoading()
    return self._isloading
end

function M:IsReady()
    return self._dataLoaded
end

function M:ErrorCode()
    return self._isloading
end

--IDataGetter end 

function M:GetLastTimer()
    return self.lastTimer or 0
end

return FriendDataMgr

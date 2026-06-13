local EncounterPlandCtrl = BaseClass("EncounterPlandCtrl")
local M = EncounterPlandCtrl

function M:GetSelect()
    return self._isSelect
end

--未选中
function M:NoSelect()
    self._view.bg:SetColor(255, 255, 255, 90)
    self._view.selected:SetActive(false)
    self._isSelect = false
end

--选中 ,返回选中成功
function M:Show()
    local isPass = EnTeamConfMgr:GetInstance():IsPass(self.m_TeamId)
    -- self:RefreshHeroList()
    -- self._view.bg:SetColor(255, 255, 255, 255)
    --未通关才能选中
    if not isPass then 
        self._view.selected:SetActive(true)
        self._isSelect = true
    end
    
    -- if self.m_cncounterMissionCfg == nil then
    --     Logger.LogError("missionCfg is nil")
    --     return false 
    -- end
    -- local entryLen = self.m_cncounterMissionCfg.entry and #self.m_cncounterMissionCfg.entry or 0 
    -- for i = 1 , 3 do 
    --     local itemCtrl = self._view["entry"..i]
    --     if i <= entryLen then
    --         itemCtrl:SetActive(true)
    --         itemCtrl:SetEntryInfo(self.m_cncounterMissionCfg.entryNames[i],self.m_cncounterMissionCfg.entryIcon[i],self.m_cncounterMissionCfg.entry[i])
    --     else
    --         itemCtrl:SetActive(false)
    --     end
    -- end
    --如果通关，则显示上锁
    self._view.lockArea:SetActive(isPass)
    return not isPass
end

--设置英雄ID
function M:SetHero(heroId)
    --查找英雄所在的编队ID和
    local teamId, heroIndex = EnTeamConfMgr:GetInstance():FindHero(heroId)

    if heroIndex then
        if teamId == self.m_TeamId then
            --下阵
            EnTeamConfMgr:GetInstance():DownPlandHero(self.m_TeamId, heroIndex)
            self:RefreshHeroList()
        else
            --从原阵下阵，再上阵
            EnTeamConfMgr:GetInstance():DownPlandHero(teamId, heroIndex)
            EnTeamConfMgr:GetInstance():SetPlandHero(self.m_TeamId, heroId)
            --刷新英雄列表
            self.m_Main:RefreshPland()
        end
    else
        --不在编队中
        local list = EnTeamConfMgr:GetInstance():GetHeroIdsByType(self.m_TeamId)
        if #list >= 8 then
            -- 已经达到当前队列最大上阵人数
            GameHelper.TipsById(5209)
            return
        end
        --上阵
        EnTeamConfMgr:GetInstance():SetPlandHero(self.m_TeamId, heroId)
        self:RefreshHeroList()
    end
end

--设置助战英雄ID
function M:SetFriendHero(friendId, heroId, callBack)
    local teamId = EnTeamConfMgr:GetInstance():FindFriendHero(friendId, heroId)

    if teamId then
        if teamId ~= self.m_TeamId then
            local data = EnTeamConfMgr:GetInstance():GetFriendHeroDataById(teamId)
            EnTeamConfMgr:GetInstance():DownPlandFriendHero(teamId)
            EnTeamConfMgr:GetInstance():SetPlandFriendHero(self.m_TeamId, data)
            EnTeamConfMgr:GetInstance():SetFriendHeroDataById(teamId, {})
            EnTeamConfMgr:GetInstance():SetFriendHeroDataById(self.m_TeamId, data)
            self.m_Main:RefreshPland()
        else
            EnTeamConfMgr:GetInstance():DownPlandFriendHero(teamId)
            EnTeamConfMgr:GetInstance():SetFriendHeroDataById(self.m_TeamId, {})
            self:RefreshHeroList()
        end

        callBack()
    else
        self.m_CallBack = callBack
        FriendDataMgr:GetInstance():SendRequestHeroData(heroId, friendId, Bind(self, self._LoadEnTeamFriendData))
    end
end


function M:_LoadEnTeamFriendData(data)
    EnTeamConfMgr:GetInstance():SetFriendHeroDataById(self.m_TeamId, data)
    EnTeamConfMgr:GetInstance():SetPlandFriendHero(self.m_TeamId, data)
    self:RefreshHeroList()
    self:_CallBack()
end


function M:RefreshHeroList()
    --获得当前编队数据
    local teamHeroIds = EnTeamConfMgr:GetInstance():GetHeroIdsByType(self.m_TeamId)
    --获得当前编队助战数据
    local friendData = EnTeamConfMgr:GetInstance():GetFriendHeroDataById(self.m_TeamId)
    --设置英雄列表
    for i = 1, 8 do
        local name = string.format("hero%d", i)
        local heroId = teamHeroIds[i];
        self._view[name].null:SetActive( not heroId or heroId == 0 )
        self._view[name].heroItem.transform:SetActive( heroId and heroId > 0 )

        if heroId then
            local heroData = IHeroDataMgr:GetMyHeroDataById(heroId);
            self._view[name].heroItem:SetHeroId(heroData:GetHeroId(), heroData:GetLevel())
            self._view[name].delateBtn:onClick(Bind(self, self._OnItemClick, heroData:GetHeroId(), nil, i))
        else
            self._view[name].delateBtn:onClick(Bind(self, self._OnItemClick, nil))
        end
    end
    --设置助战位
    if friendData.FriendId then
        self._view.friendHero.heroItem:SetHeroId(friendData.HeroData:GetHeroId(), friendData.HeroData:GetLevel())
        self._view.friendHero.delateBtn:onClick(Bind(self, self._OnItemClick, friendData.HeroData:GetHeroId(), friendData.FriendId))
    else
        self._view.friendHero.delateBtn:onClick(Bind(self, self._OnItemClick, nil))
    end
    
    self._view.friendHero.heroItem.transform:SetActive(friendData.FriendId ~= nil)
    self._view.friendHero.null:SetActive(friendData.FriendId == 0)
end

function M:_CallBack()
    if self.m_CallBack then
        self.m_CallBack()
        self.m_CallBacks = nil
    end
end

function M:Init(type, main,cncounterMissionId )
    self.m_TeamId = type
    self.m_Main = main
    self.m_cncounterMissionCfg = ConfigHelper.GetCfg("encounterMission",cncounterMissionId)

    local isPass = EnTeamConfMgr:GetInstance():IsPass(self.m_TeamId)
    self:RefreshHeroList()
    self._view.bg:SetColor(255, 255, 255, 255)
    --未通关才能选中
    if not isPass then 
        self._view.selected:SetActive(true)
        self._isSelect = true
    end
    
    if self.m_cncounterMissionCfg == nil then
        Logger.LogError("missionCfg is nil")
        return false 
    end
    local entryLen = self.m_cncounterMissionCfg.entry and #self.m_cncounterMissionCfg.entry or 0 
    for i = 1 , 3 do 
        local itemCtrl = self._view["entry"..i]
        if i <= entryLen then
            itemCtrl:SetActive(true)
            itemCtrl:SetEntryInfo(self.m_cncounterMissionCfg.entryNames[i],self.m_cncounterMissionCfg.entryIcon[i],self.m_cncounterMissionCfg.entry[i])
        else
            itemCtrl:SetActive(false)
        end
    end
    --如果通关，则显示上锁
    self._view.lockArea:SetActive(isPass)
end

function M:GetTeamId()
    return self.m_TeamId
end

function M:__init(view)
    self._view = view
    self._view.deleteBtn:onClick(Bind(self, self._OnClickDelect))
    self._view.unlockBtn:onClick(Bind(self,self._OnClickUnlock))
    self._isSelect = false 
end

function M:_OnClickUnlock(go)
    GameHelper.Confirm("解锁之后，通关记录将会被清除",function(isYes)
        if isYes then
            EnTeamConfMgr:GetInstance():UnlockTeam(self.m_TeamId,Bind(self,self._OnUnlockSuc))
        end
    end)
    
end

function M:_OnUnlockSuc()
    self._view.lockArea:SetActive(false)
end

function M:_OnItemClick(heroId, firendId, index)
    if not heroId then
        return
    end

    if firendId then
        EnTeamConfMgr:GetInstance():DownPlandFriendHero(self.m_TeamId)
        EnTeamConfMgr:GetInstance():SetFriendHeroDataById(self.m_TeamId, {})
        self:RefreshHeroList()
        self.m_Main:RefreshHeroList(self.m_TeamId, firendId)
        return 
    end

    EnTeamConfMgr:GetInstance():DownPlandHero(self.m_TeamId, index)
    self:RefreshHeroList()
    self.m_Main:RefreshHeroList(self.m_TeamId)
end

function M:_OnClickDelect()
    EnTeamConfMgr:GetInstance():ClaerPlandHeroList(self.m_TeamId)
    
    self.m_Main:RefreshHeroList(self.m_TeamId)

     --获得当前编队助战数据
    local friendData = EnTeamConfMgr:GetInstance():GetFriendHeroDataById(self.m_TeamId)
    if friendData and friendData.FriendId > 0  then
        EnTeamConfMgr:GetInstance():DownPlandFriendHero(self.m_TeamId)
        EnTeamConfMgr:GetInstance():SetFriendHeroDataById(self.m_TeamId, {})
        self.m_Main:RefreshHeroList(self.m_TeamId, firendId)
    end
    self:RefreshHeroList()
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return EncounterPlandCtrl

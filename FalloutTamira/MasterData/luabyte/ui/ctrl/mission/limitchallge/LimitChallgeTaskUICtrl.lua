local M = BaseClass("LimitChallgeTaskUICtrl",BaseUICtrl)
local MissionType = {Challenge=1,Season=2}
function M:__init()
    self.view.tgl_challge:onClick(Bind(self,self._OnClickChallge))
    self.view.tgl_season:onClick(Bind(self,self._OnClickSeason))
    self.m_listDic = {}
    self.view.looplist:Init(require("UI.Ctrl.Mission.limitChallge.LimitChallgeTaskItemCtrl"),
    require("UI.View.Mission.LimitChallgeTaskItemView"))
    self.m_selectSubTabCallback = Bind(self,self._OnSelectSubTab)
    self.view.btn_quick:onClick(Bind(self,self._OnClickGainAll))
    self.m_curType = MissionType.Challenge
    self.m_OnRequestExtremeBattleAwardHandler = Bind(self,self._OnRequestExtremeBattleAward)
    self.view.txt_back:onClick(Bind(self,self._OnClose))
end

function M:_OnClose()
    self:Close()
end

function _Sort(task1,task2)
    if task1:GetState() == task2:GetState() then 
        return task1:GetId() < task2:GetId()
    end
    if task1:GetState() == 1 then 
        return true
    end
    if task2:GetState() == 1 then 
        return false
    end
    --已领排 后面
    if task1:GetState() == 2 then 
        return false
    end
    if task2:GetState() == 2 then 
        return true
    end
    return 0
end

function M:OnEnter(challgeData)
    self.m_challgeData = challgeData
    self:_InitList()
    self:_OnClickChallge(nil)
end

function M:_InitList()
    local list = self.m_challgeData:GetTasks()
    for _, taskData in ipairs(list) do
        self.m_listDic[taskData:GetType()] = self.m_listDic[taskData:GetType()] or {}
        table.insert(self.m_listDic[taskData:GetType()],taskData)
    end
    for type, tmpList in pairs(self.m_listDic) do
        -- body
        table.sort(tmpList,_Sort)
    end
end



function M:_OnClickChallge(go)
    self:_RefreshList(MissionType.Challenge,0)
    self.view.season_subTab:SetActive(false)
end

function M:_OnClickSeason(go)
    self.danType = 1 
    self:_RefreshList(MissionType.Season,self.danType)
    self.view.season_subTab:SetActive(true)
    self.view.season_subTab:Init(0,self.m_selectSubTabCallback)
end

function M:_OnSelectSubTab(tabIdx)
    self.danType = tabIdx + 1 
    -- 1 专家2、大师 3、王者
    self:_RefreshList(MissionType.Season,self.danType)
end

function M:_RefreshList(type,danType)
    local list = self.m_listDic[type]
    self.m_curType = type
    if danType > 0 then 
        local newList = {}
        for _, data in ipairs(list) do
            -- body
            local id = data:GetId()
            local c = ConfigHelper.GetCfg("extremeMissionTasks",id)
            if c.type == type and danType == c.danType then 
                table.insert(newList,data)
            end
        end
        list = newList
    end
    local canGain = false
    for _, data in ipairs(list) do
        if data:GetState() == 1 then 
            canGain = true
            break
        end
    end
    self.view.btn_quick:SetActive(canGain)
    self.view.looplist:SetDataList(list)
end

function M:_OnClickGainAll(go)
    LimitDataMgr:GetInstance():RequestExtremeBattleAward(0,self.m_curType,self.danType,self.m_OnRequestExtremeBattleAwardHandler)
end

function M:_OnRequestExtremeBattleAward()
    self.view.looplist:UpdateList()
end

return M
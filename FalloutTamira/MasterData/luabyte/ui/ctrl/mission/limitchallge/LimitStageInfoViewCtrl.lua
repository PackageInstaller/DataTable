local M = BaseClass("LimitStageInfoViewCtrl",UIBaseComponent)
local tipsKey = "tipsKey"
function M:__init(view)
    self._view = view
    self._view.btn_map:onClick(Bind(self,self._OnMapInfoClick))
    self._view.enemyBtn:onClick(Bind(self,self._OnMonInfoClick))
    self._view.battleBtn:onClick(Bind(self,self._OnFight))
    self._allItems = {}
    self._curAllItems = {}
    self._clickCallback = Bind(self,self._OnClickItem)
    self._lockNum = 0
    self._mapConRanCount = 0
    self._view.tips:onClick(Bind(self,self._OnClickTips))
    self._view.tips:SetActive(false)
end

function M:_OnClickTips(go)
    self._view.tips:SetActive(false)
    PlayerPrefTools.SetPlayerPrefs(tipsKey, 1)
end

function M:SetStageInfo( extremeMissionId, missionId, words , skillWords ,star ,selectedWords)
    self.m_mission = ConfigHelper.GetCfg("mission",missionId)
    self._words = {}
    LimitDataMgr:GetInstance():SetCurExtremeMissionId(extremeMissionId)
    local globalTarget = self.m_mission.Stage.globalTarget
    for i = 0 , globalTarget.Length - 1 do 
        table.insert(self._words,globalTarget[i])
    end
    for _, wid in ipairs(words) do
        -- body
        table.insert(self._words,wid)
    end
    self._lockNum = globalTarget.Length
    self._mapConRanCount = #words
    self.m_star = star
    --已经选择的词条，用于已经打过的关卡
    self.m_selectedWords = selectedWords or {}
    --破限技
    self.m_skillWords = skillWords or {}
    --总星数
    local itemContainer = self._view.itemContainer
    local itemCount = itemContainer.childCount
    self._allItems = {}
    self._view.item:SetActive(false)
    for key, item in pairs(self._curAllItems) do
        -- body
        item:SetActive(false)
        table.insert(self._allItems,item)
    end
    self._curAllItems = {}
    self:_UpdateWords()
    self._view.missionName:SetText(self.m_mission.name)
    self._view.btn_map:SetPic(self.m_mission.map)
    self._view.battleBtn:SetActive(star==0)
    self._view.passLabel:SetActive(star>0)
    self._view.starOn:SetActive(star>0)
    self._view.starOff:SetActive(star==0)
end

--更新词条
function M:_UpdateWords()
    --锁定的词条数量
    local lockedNum = self._lockNum
    --待选的词条数量
    local mapConRanCount = self._mapConRanCount
    for i = 1 , #self._words do 
        local wordId = self._words[i]
        local item = self:_GetItem(wordId)
        local state = i <= lockedNum and 2 or 1
        --未锁住的有可能会默认选中
        if state ~= 2 then 
            if table.indexof(self.m_selectedWords,wordId) then 
                state = 2 
            end
        end
        item:SetWord(wordId,state,self._clickCallback)
        item:SetActive(true)
        item:SetParent(self._view.itemContainer)
        item:SetAsLastSibling()
        self._curAllItems[wordId]=item
    end
    self:_UpdateStarsAndSelect()
end

function M:_GetItem(wordId)
    if #self._allItems > 0 then 
        local item = self._allItems[1]
        table.remove(self._allItems,1)
        return item
    end
    return self._view.item:Instantiate()
end

function M:_OnClickItem(wordId,curState)
    --打过了就不能再修改了
    if self.m_star > 0 then 
        return
    end
    --强行锁定
    if curState == 2 then 
        return
    end
    --未选择，则选择
    if curState == 1 then 
        self._curAllItems[wordId]:SetState(3)
    else
        self._curAllItems[wordId]:SetState(1)
    end
    self:_UpdateStarsAndSelect()
end

--更新总星和词条数
function M:_UpdateStarsAndSelect()
    local selectNum = 0 
    for wordId, item in pairs(self._curAllItems) do
        -- body
        local state = item:GetState()
        if state == 2 or state == 3 then 
            selectNum = selectNum + 1
        end
    end
     --锁定的词条数量
     local lockedNum = self._lockNum
     --待选的词条数量
     local mapConRanCount = self._mapConRanCount
    --self._view.alreadyChooseTxt:SetText( selectNum .. "/" .. ( lockedNum + mapConRanCount ) )
    -- 通关1颗星，一个词条1颗星
    self._view.starLabel:SetText(tostring(1+selectNum) .. "/" .. ( lockedNum + mapConRanCount + 1) )
end

-- 打开地图详情面板
function M:_OnMapInfoClick(go)
    UIContextMgr:GetInstance():Show("MissionMapUI", self.m_mission.map)
end

-- 打开怪物详情面板
function M:_OnMonInfoClick(go)
    UIContextMgr:GetInstance():Show("MonsterInfoUI", self.m_mission.Stage)
end

function M:_OnFight(go)
    if  PlayerPrefTools.GetPlayerPrefsInt(tipsKey, 0) == 0 then 
        self._view.tips:SetActive(true)
        return
    end
    local startStr,endStr,isInOffTime = LimitDataMgr:GetInstance():GetCycleInfo()
    if isInOffTime then 
        GameHelper.Tips("休赛结算期间无法进入战斗")
        return
    end
    local selectWords = {}

    for wordId, item in pairs(self._curAllItems) do
        -- body
        local state = item:GetState()
        if state == 2 or state == 3 then 
            Logger.Log("添加选择词条："..wordId)
            table.insert(selectWords,wordId)
        end
    end
    --破限技也是词条
    for index, wordId in ipairs(self.m_skillWords) do
        Logger.Log("添加破限技词条："..wordId)
        local exCfg = ConfigHelper.GetCfg("extremeMissionCondition",wordId)
        if exCfg == nil then 
            Logger.LogError("extremeMissionCondition id error " .. tostring(wordId))
        end
        table.insert(selectWords,exCfg.mapConditionId)
    end
    -- 保存词条
    GameHelper.SetChallengeTarget(selectWords, self.m_mission.id)

    local battleStyle = EnumConst.EBattleStyle.LimitChallge
    UIContextMgr:GetInstance():Show(
        UIDefine.UITeamConfig,
        false,
        self.m_mission.id,
        EnumConst.TeamConfigStyle.Battle,
        0,
        battleStyle
    )
end

function M:OnDestroy()
    M.super.OnDestroy(self)

end

return M
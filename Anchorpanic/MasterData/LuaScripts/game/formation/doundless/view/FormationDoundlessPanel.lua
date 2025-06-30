-- 主线固定阵容
module("formation.FormationDoundlessPanel", Class.impl(formation.FormationPanel))

function configUI(self)
    super.configUI(self)
    self.mBtnFormation:SetActive(false)
    self.mNowSelectFormation:SetActive(false)

    self.mScrollerSelect.gameObject:SetActive(false)
end

function onRestoreHandler(self, isInit)

end

-- 更新队长
function __updateCaptain(self, cusInit)

end

-- 更新阵型格子图显示
function __updateMapView(self)
    local formationHeroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
    local storyRo = self:getManager():getData()
    local tempData = storyRo:getEffectParam()

    local formationId = tempData[1]
    local formationDic = self:getManager():getFormationConfigVo(formationId)
    local formationConfigList = formationDic:getFormationList()

    local showHeroList = {}
    for i, v in ipairs(formationHeroList) do
        table.insert(showHeroList, v)
    end

    for i = 2, #tempData do
        local monsterTidVo = monster.MonsterManager:getMonsterVo(tempData[i][2])

        local isExistSame = false
        for i = 1, #formationHeroList do
            local formationHeroVo = formationHeroList[i]
            if (formationHeroVo.heroId == monsterTidVo.uniqueTid and formationHeroVo:getHeroTid() == monsterTidVo.tid) then
                isExistSame = true
                break
            end
        end
        if isExistSame == false then
            local vo = LuaPoolMgr:poolGet(formation.FormationHeroVo)
            vo.heroPos = tempData[i][1]
            vo.heroId = monsterTidVo.uniqueTid
            vo.sourceType = formation.HERO_SOURCE_TYPE.PROTECT_PEOPLE

            vo.m_heroTid = monsterTidVo.tid
            vo.m_heroLvl = monsterTidVo.lvl
            vo.m_evolutionLvl = monsterTidVo.evolutionLvl
            table.insert(showHeroList, vo)
        end
    end

    local selectTidList = self:getManager():getMySelectHeroTidList()
    local isHasEmpty = 5 > #selectTidList
    if (isHasEmpty) then
        if (not self.m_myAllHeroTidList) then
            self.m_myAllHeroTidList = hero.HeroManager:getAllHeroTidList()
        end
        if (#selectTidList >= #self.m_myAllHeroTidList) then
            self.m_sceneController:setIsShowTipTile(false)
        else
            self.m_sceneController:setIsShowTipTile(true)
        end
    else
        self.m_sceneController:setIsShowTipTile(false)
    end

    local function allFinishCall()
        self:updateEleEff(true)
        self:updateLoopEleEff()
    end

    self.m_sceneController:setModelList(formationConfigList, showHeroList, self.m_formationId, allFinishCall)
    self:updatePosEff()
end

-- 点击保存出战队列并且回调
function __onClickBtnControlHandler(self)
    local count = self:getManager():getSelectFilterHeroCount(self.m_teamId, formation.HERO_SOURCE_TYPE.OWN) --差异在这里
    if (count <= 0) then
        gs.Message.Show(_TT(1284))
        gs.Message.Show(_TT(29119))
    else
        local function run()
            -- 可能会有援助的怪物，必要同步
            self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, {})
            -- 设置出战队列
            self:getManager():dispatchEvent(self:getManager().REQ_SET_FIGHT_TEAM, {
                teamId = self.m_teamId
            })
            -- 放在CALL_FUN_REASON前面，防止会自动弹出其他界面音乐，导致回调打开的界面音乐被顶掉
            self:forceClose()
            -- 回调外部
            self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
            -- 可能会有援助的怪物，通知后端进入战斗后需要撤下，必要同步
            self:rsyncFormationList(true)
        end

        if self:getDupVo() then
            local recommandFight = self:getDupVo().suggestLevel[2] -- 推荐等级
            if (recommandFight == nil or recommandFight <= 0) then
                run()
            else
                local isShowTips = false
                local fight = self:getFormationAvgLv()
                for i, v in pairs(self.mRecommandLvData) do
                    if v[1] <= recommandFight and v[2] > recommandFight then
                        local value = sysParam.SysParamManager:getValue(v[3])
                        isShowTips = (recommandFight - fight) >= value
                        break
                    end
                end
                isShowTips = isShowTips or (count < (#self:getDupVo().enemyList - sysParam.SysParamManager:getValue(SysParamType.FORMATION_TIP_OTHER_JUG)))
                if (isShowTips) then
                    UIFactory:alertMessge(_TT(1366), true, function()
                        run()
                    end, _TT(1), nil, true, function()
                    end, _TT(2), _TT(5), nil, RemindConst.FORMATION_FIGHT)
                else
                    run()
                end
            end
        else
            run()
        end
    end
end

return _M
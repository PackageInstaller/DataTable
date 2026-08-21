--[[ 
-----------------------------------------------------
@filename       : FormationMainExplorePanel
@Description    : 主探索·副本备战
@date           : 2021-05-12 17:00:26
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('fomation.FormationMainExplorePanel', Class.impl(formation.FormationPanel))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("formation/FormationMazePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁

function configUI(self)
    super.configUI(self)
    self.mBtnControl:SetActive(false)
end

function deActive(self)
    super.deActive(self)
    self.m_myAllHeroIdList = nil
    self.m_myAllHeroTidList = nil
end

function __playerClose(self)
    self:initData()
    -- 策划说这里迷宫的支援队友不需要清除非玩家自己的英雄
    -- 可能会有援助的怪物，通知后端进入战斗后需要撤下，必要同步
    self:rsyncFormationList(false)
    self:getManager():setSelectFormationTeamId(nil)
end

-- 更新界面
function __updateView(self, cusInit)
    if (self:isLoadFinish()) then
        self.m_teamId = self.m_teamId and self.m_teamId or self:getManager():getFightTeamId()
        if (not self.m_teamId) then
            Debug:log_error("FormationPanel", "出战队列id错误")
            return
        end
        self.m_formationId = self.m_formationId and self.m_formationId or self:getManager():getFightFormationId()
        if (not self.m_formationId) then
            Debug:log_error("FormationPanel", "出战阵型id错误")
            return
        end
        local nowNum = self:getManager():getAssistUnlockNum()
        local nowAssist = #self:getManager():getSelectTeamAssistHeroList(self.m_teamId)

        if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_ASSIST, false) == true and nowNum > 0) then
            self.mBtnAssist:SetActive(true)
            self:setBtnLabel(self.mBtnAssist, 1240, "助战 ("..nowAssist.."/"..nowNum..")", nowAssist, nowNum) 
        else
            self.mBtnAssist:SetActive(false)
        end
        cusInit = cusInit == nil and true or cusInit
        self:__updateTeamList(cusInit)
        self:__updateFightPowerView(cusInit)
        self:__updateCaptain(cusInit)
        self:__updateMiniFormation(cusInit)
        self:__updateMapView()
        self:__updateHeroHp()
    end
end

-- 更新阵型格子图显示
function __updateMapView(self)
    local formationHeroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
    local formationConfigVo = self:getManager():getFormationConfigVo(self.m_formationId)
    local formationConfigList = formationConfigVo:getFormationList()

    local isHasEmpty = #formationConfigList > #formationHeroList
    if (isHasEmpty) then
        local selectTidList = self:getManager():getMySelectHeroTidList()
        if (not self.m_myAllHeroTidList) then
            self.m_myAllHeroTidList = hero.HeroManager:getAllHeroTidList()
        end

        local function isCanMonster()
            local tempTidList = self:getManager():getData().data.uniqueTidList
            local uniqueTidList = {}
            for i = 1, #tempTidList do
                if(table.indexof(uniqueTidList, tempTidList[i]) == false)then
                    local isAdd = #uniqueTidList <= 0
                    for j = #uniqueTidList, 1, -1 do
                        local tempMonsterVo = monster.MonsterManager:getMonsterVo(tempTidList[i])
                        local compareMonsterVo = monster.MonsterManager:getMonsterVo(uniqueTidList[j])
                        local tempMainExploreHeroVo = mainExplore.MainExploreManager:getMainExploreHero(self:getManager():getData().data.mapId, tempMonsterVo.uniqueTid, mainExplore.HERO_SOURCE_TYPE.SUPPORT)
                        if(tempMonsterVo.tid == compareMonsterVo.tid)then
                            local compareMainExploreHeroVo = mainExplore.MainExploreManager:getMainExploreHero(self:getManager():getData().data.mapId, compareMonsterVo.uniqueTid, mainExplore.HERO_SOURCE_TYPE.SUPPORT)
                            if(tempMainExploreHeroVo.nowHp > compareMainExploreHeroVo.nowHp)then
                                table.remove(uniqueTidList, j)
                                isAdd = true
                            end
                        else
                            if(tempMainExploreHeroVo.nowHp > 0)then
                                isAdd = true
                            end
                        end
                    end
                    if(isAdd)then
                        table.insert(uniqueTidList, tempTidList[i])
                    end
                else
                    Debug:log_error("FormationMainExploreManager", "询问策划，探索里不同副本的怪物唯一id是不能重复的，才能保证正确读取到血量")
                end
            end

            if(uniqueTidList and #uniqueTidList > 0)then          
                local filterMonUniqueTidList = {}
                for i = 1, #uniqueTidList do
                    local monsterTidVo = monster.MonsterManager:getMonsterVo(uniqueTidList[i])
                    local isExistSame = false
                    for i = 1, #formationHeroList do
                        local formationHeroVo = formationHeroList[i]
                        if (formationHeroVo.heroId == monsterTidVo.uniqueTid or formationHeroVo:getHeroTid() == monsterTidVo.tid) then
                            isExistSame = true
                            break
                        end
                    end
                    if(not isExistSame)then
                        local mainExploreHeroVo = mainExplore.MainExploreManager:getMainExploreHero(self:getManager():getData().data.mapId, monsterTidVo.uniqueTid, mainExplore.HERO_SOURCE_TYPE.SUPPORT)
                        if(mainExploreHeroVo.nowHp > 0)then
                            return true
                        end
                    end
                end

                return false
            else
                return false
            end
        end
        if (#selectTidList >= #self.m_myAllHeroTidList) then
            self.m_sceneController:setIsShowTipTile(isCanMonster())
        else
            if (not self.m_myAllHeroIdList) then
                self.m_myAllHeroIdList = hero.HeroManager:getAllHeroIdList()
            end
            local lifeTidList = {}
            for i = 1, #self.m_myAllHeroIdList do
                local heroId = self.m_myAllHeroIdList[i]
                local mainExploreHeroVo = mainExplore.MainExploreManager:getMainExploreHero(self:getManager():getData().data.mapId, heroId, mainExplore.HERO_SOURCE_TYPE.OWN)
                if(mainExploreHeroVo.nowHp > 0)then
                    local heroVo = hero.HeroManager:getHeroVo(heroId)
                    if(table.indexof(lifeTidList, heroVo.tid) == false)then
                        table.insert(lifeTidList, heroVo.tid)
                    end
                end
            end
            if(#selectTidList >= #lifeTidList)then
                self.m_sceneController:setIsShowTipTile(isCanMonster())
            else
                if(#lifeTidList > 0)then
                    self.m_sceneController:setIsShowTipTile(true)
                else
                    self.m_sceneController:setIsShowTipTile(false)
                end
            end
        end
    else
        self.m_sceneController:setIsShowTipTile(false)
    end

    self.m_sceneController:setModelList(formationConfigList, formationHeroList)

    self:__updateHeroHp()
end

-- 点击保存出战队列并且回调
function __onClickBtnControlHandler(self)
    local hasZeroHp = false
    local tileFormationHeroVo = nil
    local formationTileCount, row, col = self:getManager():getFormationTileCount()
    for col_x = 1, col do
        for row_y = 1, row do
            local tilePos = self:getManager():getFormationTilePos(self.m_formationId, col_x, row_y)
            tileFormationHeroVo = self:getManager():getFormationHeroVoByPos(self.m_teamId, tilePos)
            if tileFormationHeroVo then
                local mainExploreHeroVo = self:getMainExploreHeroVo(tileFormationHeroVo)
                if(mainExploreHeroVo.nowHp <= 0)then
                    hasZeroHp = true
                    break
                end
            end
        end
    end
    if hasZeroHp then
        gs.Message.Show(_TT(1258))
        return
    end

    local count = self:getManager():getSelectFilterHeroCount(self.m_teamId)
    if (count <= 0) then
        -- gs.Message.Show("不可出战空队列")
        gs.Message.Show(_TT(29119))
    else
        local function run()
            -- 可能会有援助的怪物，必要同步
            self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, {})
            -- 设置出战队列
            self:getManager():dispatchEvent(self:getManager().REQ_SET_FIGHT_TEAM, {teamId = self.m_teamId})
            -- 放在CALL_FUN_REASON前面，防止会自动弹出其他界面音乐，导致回调打开的界面音乐被顶掉
            self:forceClose()
            -- 回调外部
            self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
            -- 可能会有援助的怪物，通知后端进入战斗后需要撤下，必要同步
            self:rsyncFormationList(true)
        end

        local recommandFight = self:getManager():getRecommandFight()
        if (recommandFight == nil or recommandFight <= 0) then
            run()
        else
            local fight = self:getFormationFight()
            if(fight >= recommandFight)then
                run()
            else
                UIFactory:alertMessge(_TT(1366),
                true, function() run() end, _TT(1), nil,
                true, function() end, _TT(2),
                _TT(5), nil, RemindConst.FORMATION_FIGHT)
            end
        end
    end
end

function __updateHeroHp(self)
    self:recoverHeroHp()
    local formationTileCount, row, col = self:getManager():getFormationTileCount()
    local tileFormationHeroVo = nil
    for col_x = 1, col do
        for row_y = 1, row do
            local tilePos = self:getManager():getFormationTilePos(self.m_formationId, col_x, row_y)
            tileFormationHeroVo = self:getManager():getFormationHeroVoByPos(self.m_teamId, tilePos)
            if tileFormationHeroVo then
                local mainExploreHeroVo = self:getMainExploreHeroVo(tileFormationHeroVo)
                local worldPos = self.m_sceneController:getTileWorldPos(col_x, row_y)
                local pos = gs.CameraMgr:World2CameraUI01(gs.CameraMgr:GetDefSceneCamera(), gs.CameraMgr:GetUICamera(), worldPos, self:getChildTrans("mGroupHeroInfo"), nil)
                local item = SimpleInsItem:create(self:getChildGO("GroupHeroHpItem"), self:getChildTrans("mGroupHeroInfo"))
                if mainExploreHeroVo.nowHp > 0 then
                    item:setText("mTxtCont", 1259, string.format("血量：%s", mainExploreHeroVo.nowHp) .. "%", mainExploreHeroVo.nowHp)
                    item:getChildGO("mImgProBar"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor("26D5D3FF")
                else
                    item:setText("mTxtCont", 1260, string.format("血量：<color='#ed1941'>%s</color>", mainExploreHeroVo.nowHp) .. "%", mainExploreHeroVo.nowHp)
                    item:getChildGO("mImgProBar"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor("d52628FF")
                end
                gs.TransQuick:ScaleX(item:getChildTrans("mImgProBar"), mainExploreHeroVo.nowHp / 100)
                gs.TransQuick:UIPos(item:getTrans(), pos.x - 78, pos.y + 139)
                table.insert(self.mHeroHpList, item)
            end
        end
    end
end

function getMainExploreHeroVo(self, formationHeroVo)
    local mainExploreHeroVo = nil
    if(formationHeroVo:getIsMonster())then
        mainExploreHeroVo = mainExplore.MainExploreManager:getMainExploreHero(self:getManager():getData().data.mapId, formationHeroVo.heroId, mainExplore.HERO_SOURCE_TYPE.SUPPORT)
    else
        mainExploreHeroVo = mainExplore.MainExploreManager:getMainExploreHero(self:getManager():getData().data.mapId, formationHeroVo.heroId, mainExplore.HERO_SOURCE_TYPE.OWN)
    end
    return mainExploreHeroVo
end

function recoverHeroHp(self)
    if self.mHeroHpList then
        for i, v in ipairs(self.mHeroHpList) do
            v:poolRecover()
        end
    end
    self.mHeroHpList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1258):	"含有0血量战员"
]]

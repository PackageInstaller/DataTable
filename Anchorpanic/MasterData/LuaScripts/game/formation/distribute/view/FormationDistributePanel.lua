-- 主线分配阵容
module("formation.FormationDistributePanel", Class.impl(formation.FormationPanel))

function configUI(self)
    super.configUI(self)

    self.mGroupFight:SetActive(false)
    self.mBtnFormation:SetActive(false)
    self.mBtnDevelop:SetActive(false)
    self.mBtnAssist:SetActive(false)
    self.mBtnCaptain:SetActive(false)
end

function active(self, args)
    super.active(self, args)
    self:getManager():addEventListener(self:getManager().RES_GET_SUPPORT_HERO, self.__onUpdateDistributeDataHandler, self)
end

function deActive(self)
    super.deActive(self)
    self:getManager():removeEventListener(self:getManager().RES_GET_SUPPORT_HERO, self.__onUpdateDistributeDataHandler, self)
end

-- 后面特殊两关卡用到保存在服务器的分配数据
function __onUpdateDistributeDataHandler(self)
    self:__updateMapView()
end

-- 更新界面
function __updateView(self, cusInit)
    cusInit = cusInit == nil and true or cusInit
    self:__updateTeamList(cusInit)
    self:__updateFightPowerView(cusInit)
    self:__updateCaptain(cusInit)
    self:__updateMiniFormation(cusInit)
    self:__updateMapView()
end

-- 阵型瓦片点击事件
function __onClickFormationTileHandler(self, pos, tileTrans)
    -- 分配阵型不需要选择英雄
end

-- 点击保存出战队列并且回调
function __onClickBtnControlHandler(self)
    -- 分配阵型不需设置战斗队列直接战斗
    -- 放在CALL_FUN_REASON前面，防止会自动弹出其他界面音乐，导致回调打开的界面音乐被顶掉
    self:forceClose()
    self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
end

-- 更新战力
function __updateFightPowerView(self, cusInit)
    -- 置空，谁做的到时换界面同步下逻辑
end

-- 更新队长
function __updateCaptain(self, cusInit)
    -- 置空，谁做的到时换界面同步下逻辑
end

-- 更新迷你阵型图
function __updateMiniFormation(self, cusInit)
    -- 置空，谁做的到时换界面同步下逻辑
end

-- 更新阵型格子图显示
function __updateMapView(self)
    -- 分配阵容
    if(self:getManager():getData():getEffectType() == storyTalk.Effect.TYPE_8)then
        local storyRo = self:getManager():getData()
        local battleType = storyRo:getBattleType()
        local dupId = storyRo:getBattleFieldId()
        local teamIndex = 1
        self:setFormationScene(battleType, dupId, teamIndex)
        
    elseif(self:getManager():getData():getEffectType() == storyTalk.Effect.TYPE_10)then
        local effectList = self:getManager():getData():getEffectParam()
        local battleType = effectList[1]
        local dupId = effectList[2]
        local teamIndex = effectList[3]
        local distributeData = self:getManager():getDistributeData(battleType, dupId)
        if(distributeData)then
            self:setFormationScene(battleType, dupId, teamIndex)
        end
    end
end

function setFormationScene(self, battleType, dupId, teamIndex)
    local storyEffectParam = storyTalk.StoryTalkManager:getStoryParamByEffectType(battleType, dupId, storyTalk.Effect.TYPE_8)
    local firstTeamConfigData = storyEffectParam[1]
    local formationId = firstTeamConfigData[1]
    -- 默认的小队英雄补在第一个
    local heroConfigId = firstTeamConfigData[2]

    local formationHeroList = {}
    local selectIdList = self:getManager():getDistributeSelectList(battleType, dupId, teamIndex)
    table.insert(selectIdList, 1, heroConfigId)
    local formationConfigList = self:getManager():getMonFormationConfigVo(formationId):getFormationList()
    local formationIndex = 0
    for i = 1, #selectIdList do
        local monsterTidVo = monster.MonsterManager:getMonsterVo(selectIdList[i])
        local vo = LuaPoolMgr:poolGet(formation.FormationHeroVo)
        formationIndex = formationIndex + 1
        vo.heroPos = formationConfigList[formationIndex][1]
        vo.heroId = monsterTidVo.uniqueTid
        vo.sourceType = formation.HERO_SOURCE_TYPE.MAIN_STORY

        vo.m_heroTid = monsterTidVo.tid
        vo.m_heroLvl = monsterTidVo.lvl
        vo.m_evolutionLvl = monsterTidVo.evolutionLvl
        table.insert(formationHeroList, vo)
    end
    self.m_sceneController:setModelList(formationConfigList, formationHeroList)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

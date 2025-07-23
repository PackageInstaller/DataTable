-- 主线固定阵容
module("formation.FormationMainFixedPanel", Class.impl(formation.FormationPanel))

UIRes = UrlManager:getUIPrefabPath("formation/FormationFixedPanel.prefab")

function configUI(self)
    super.configUI(self)

    self.mGroupFight:SetActive(false)
    self.mBtnFormation:SetActive(false)
    self.mBtnDevelop:SetActive(false)
    self.mBtnAssist:SetActive(false)
    self.mBtnCaptain:SetActive(false)

    self.mFixedTxt = self:getChildGO("FixedTxt"):GetComponent(ty.Text)
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
    -- 固定阵型不需要选择英雄
    if (self:getManager():getType() == formation.TYPE.MAIN_FIXED) then
        return
    end
end

-- 点击保存出战队列并且回调
function __onClickBtnControlHandler(self)
    -- 固定阵型不需设置战斗队列直接战斗
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
    local formationHeroList = {}
    local tempData = self:getManager():getData()
    local formationId = tempData[1]
    local formationConfigList = self:getManager():getMonFormationConfigVo(formationId):getFormationList()
    local formationIndex = 0
    for i = 2, #tempData do
        local monsterTidVo = monster.MonsterManager:getMonsterVo(tempData[i])
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

function __isCanDrag(self)
    return false
end

function initViewText(self)
    super.initViewText(self)
    self.mFixedTxt.text = _TT(25)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

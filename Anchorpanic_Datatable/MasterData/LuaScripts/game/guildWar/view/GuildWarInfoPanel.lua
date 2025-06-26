
--[[ 
-----------------------------------------------------
@Description    : 联盟团战人员情报
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]

module('guildWar.GuildWarInfoPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("guildWar/GuildWarInfoPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)

    self:setSize(1120, 540)
    self:setTxtTitle(_TT(149160))
end

--析构
function dtor(self)
end

function initData(self)
    self.mTeamList = {}
    self.mHeroGridList = {}
end

-- 初始化
function configUI(self)
    self.mEmptyHero = self:getChildGO("mEmptyHero")
    
end

function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function active(self,args)
    super.active(self)
    self.formationInfo = args.formation
    self:showPanel()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearHeroGridList()
    self:clearTeamList()
end

function showPanel(self)

    table.sort(self.formationInfo,function (vo1,vo2)
        return vo1.team_id < vo2.team_id
    end)
    self:clearHeroGridList()
    self:clearTeamList()
    for i = 1,#self.formationInfo do
        local temaId = self.formationInfo[i].team_id
        self:getChildGO("mTxtTeam"..i):GetComponent(ty.Text).text = _TT(149161)..i
        local formationTid = self.formationInfo[i].formation_tid  
        local formationList = formation.FormationManager:getFormationConfigVo(formationTid):getFormationList()

        local heroList = self.formationInfo[i].hero_list


        for _, vo in pairs(formationList) do
            local pos = vo[2]
            local teamPos = pos[2] * 4 - (pos[1] - 1)
            local p = i == 1 and "L" or "R"
            local heroInfo = self:getPosHeroInfo(heroList,teamPos)
            
            if heroInfo ~= nil then
                local grid = HeroHeadGrid:poolGet()
                local heroVo = hero.HeroManager:getHeroConfigVo(heroInfo.tid)
                grid:setData(heroVo)
                grid:setScale(0.8)
                grid:setStarLvl(heroInfo.evolution)
                grid:setLvl(heroInfo.lv)
                grid:setParent(self:getChildTrans("mImg".. p .. teamPos))
                table.insert(self.mHeroGridList ,grid)
            else
                local emptyImg = SimpleInsItem:create(self.mEmptyHero, self:getChildTrans("mImg".. p .. teamPos), "mWarInfoEmptyHero")
                gs.TransQuick:UIPos(emptyImg:getGo():GetComponent(ty.RectTransform), 0, 0)
                table.insert(self.mTeamList, emptyImg)
            end
        end
    end
end

function getPosHeroInfo(self,heroList,pos)
    for i = 1, #heroList do
        if heroList[i].pos.y * 4 - (heroList[i].pos.x - 1) == pos then
            return heroList[i]
        end
    end
    return nil
end

function clearHeroGridList(self)
    for i = 1, #self.mHeroGridList do
        self.mHeroGridList[i]:poolRecover()
    end
    self.mHeroGridList = {}
end

function clearTeamList(self)
    for i = 1, #self.mTeamList do
        self.mTeamList[i]:poolRecover()
    end
    self.mTeamList = {}
end

return _M
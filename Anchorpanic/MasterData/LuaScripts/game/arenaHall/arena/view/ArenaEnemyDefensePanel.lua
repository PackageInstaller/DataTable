module("arena.ArenaEnemyDefensePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("arenaHall/arena/ArenaEnemyDefensePanel.prefab")
destroyTime = -1 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(920, 780)
    self:setTxtTitle("")
end

-- 初始化数据
function initData(self)
    self.m_formationVo = nil
    self.m_arenaEnemyVo = nil
    self.m_itemDic = {}
    local formationTileCount, row, col = formation.FormationManager:getFormationTileCount()
    for col_x = 1, col do
        for row_y = 1, row do
            if(not self.m_itemDic[col_x])then
                self.m_itemDic[col_x] = {}
            end
            self.m_itemDic[col_x][row_y] = arena.ArenaEnemyDefenseItem.new()
        end
    end
end

function configUI(self)
    super.configUI(self)

	self.m_headNode = self:getChildGO("HeadNode").transform
	self.mTxtName = self:getChildGO("TextName"):GetComponent(ty.Text)
	self.m_textScore = self:getChildGO("TextScore"):GetComponent(ty.Text)
	self.m_textFightNum = self:getChildGO("TextFightNum"):GetComponent(ty.Text)
    self.m_groupFormation = self:getChildGO("GroupFormation").transform
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_ARENA_ENEMY_DEFENSE, self.__onUpdateDefenseHandler, self)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ARENA_ENEMY_DEFENSE, self.__onUpdateDefenseHandler, self) 

    self:resetAllItem()
end

function resetAllItem(self)
    if(self.m_itemDic)then
        for col_x, dic in pairs(self.m_itemDic)do
            for row_y, item in pairs(dic)do
                item:resetData()
            end
        end
    end

    if (self.m_playerHeadGrid) then
        self.m_playerHeadGrid:poolRecover()
        self.m_playerHeadGrid = nil
    end
end

function setData(self, cusPlayerId)
    self:resetAllItem()
	-- 请求竞技场玩家防守阵容
    GameDispatcher:dispatchEvent(EventName.REQ_ARENA_PLAYER_DEFENSE, {playerId = cusPlayerId})
end

-- 玩家防守阵容数据更新
function __onUpdateDefenseHandler(self, args)
    self.m_arenaEnemyVo = args.arenaEnemyVo
    self.m_formationVo = args.formationVo
    self:__updateView()
end

function __updateView(self)
    -- 所有格子设置默认序号
    if(self.m_itemDic)then
        for col_x, dic in pairs(self.m_itemDic)do
            for row_y, item in pairs(dic)do
                item:setParent(self.m_groupFormation)
                local index = formation.FormationManager:getGridIndexByColAndRow(col_x, row_y)
                item:setIndex(index)
            end
        end
    end

    local formationConfigVo = nil
    if(self.m_arenaEnemyVo.isRobot)then
        formationConfigVo = formation.FormationManager:getMonFormationConfigVo(self.m_formationVo.formationId)
    else
        formationConfigVo = formation.FormationManager:getMonFormationConfigVo(self.m_formationVo.formationId)
    end
    if(not formationConfigVo)then
        Debug:log_error("ArenaEnemyDefensePanel", "找不到对应阵型配置，阵型id：" .. self.m_formationVo.formationId)
        return
    end

    local formationConfigList = formationConfigVo:getFormationList()
    for i = 1, #formationConfigList do
        local pos = formationConfigList[i][1]
        local col_x = formationConfigList[i][2][1]
        local row_y = formationConfigList[i][2][2]

        local item = self.m_itemDic[col_x][row_y]
        -- 按照配置将可以站位的格子设置默认状态
        item:setCanStand()

        -- 判断对应站位的格子上是否已有对应的英雄
        for j = 1, #self.m_formationVo.heroList do
            local formationHeroVo = self.m_formationVo.heroList[j]
            if(formationHeroVo.heroPos == pos)then
                item:setHero(formationHeroVo)
            end
        end
    end

	if (not self.m_playerHeadGrid) then
		self.m_playerHeadGrid = PlayerHeadGrid:poolGet()
	end
	self.m_playerHeadGrid:setData(self.m_arenaEnemyVo.avatar)
	self.m_playerHeadGrid:setParent(self.m_headNode)
	self.m_playerHeadGrid:setScale(0.9)
    self.m_playerHeadGrid:setLvl(self.m_arenaEnemyVo.lvl)

	self.mTxtName.text = self.m_arenaEnemyVo.name
	self.m_textFightNum.text = _TT(62217, self.m_arenaEnemyVo.fightNum)--"战力".. self.m_arenaEnemyVo.fightNum
	self.m_textScore.text = _TT(62218, self.m_arenaEnemyVo.fightNum)--"积分".. self.m_arenaEnemyVo.score
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

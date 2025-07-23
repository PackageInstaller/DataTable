--[[ 
-----------------------------------------------------
@filename       : FormationCodeHopeHeroSelectPanel
@Description    : 代号·希望副本选择战员
@date           : 2021-05-18 14:22:12
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('fomation.FormationCodeHopeHeroSelectPanel', Class.impl(formation.FormationHeroSelectPanel))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("formation/FormationCodeHopeHeroSelectPanel.prefab")

function __getHeadSelectItem(self)
    return formation.FormationCodeHopeHeroSelectItem
end


function __onFormationHeroSelectHandler(self, args)
    local teamId = self.m_teamId
    local selectHeroId = args.heroId
    local selectHeroTid = args.heroTid
    local selectHeroSourceType = args.heroSourceType
    local selectIsInFormation = args.isInFormation
    local selectIsInAssist = args.isInAssist

    local function reqSelect()
        local targetPos = self:getManager():getFormationTilePos(self.m_formationId, self.m_colIndex, self.m_rowIndex)
        local isFight = self:getManager():setSelectFormationHeroList(teamId, self.m_formationId, selectHeroId, selectHeroTid, selectHeroSourceType, targetPos, true)

        local heroNum = #self:getManager():getSelectFormationHeroList(teamId)
        local formationMaxCount = self:getManager():getFormationHeroMaxCount(self.m_formationId)
        local hasHeroNum = #hero.HeroManager:getAllHeroList()

        local dupVo = dup.DupCodeHopeManager:getDupVo(self:getManager():getData().dupId)
        local selectTidList = self:getManager():getMySelectHeroTidList(self.m_teamId)

        if heroNum >= hasHeroNum or #selectTidList >= dupVo.limitNum then
            self:close()
        else
            if heroNum < formationMaxCount and isFight then
                local formationTileCount, row, col = self:getManager():getFormationTileCount()
                local heroPos = -1
                local tempCol, tempRow = 0
                for col_x = 1, col do
                    for row_y = 1, row do
                        local tempPos = self:getManager():getFormationTilePos(self.m_formationId, col_x, row_y)
                        local isLock = self:getManager():getFormationTileLock(self.m_formationId, col_x, row_y)
                        if tempPos > 0 and not isLock then
                            if not self:getManager():getFormationHeroVoByPos(teamId, tempPos) then
                                heroPos = tempPos
                                tempCol = col_x
                                tempRow = row_y
                                break
                            end
                        end
                    end
                    if heroPos > -1 then
                        break
                    end
                end

                if tempCol > 0 and tempRow > 0 then
                    self:getManager():dispatchEvent(self:getManager().HERO_FORMATION_TILE_SELECT, { col = tempCol, row = tempRow })
                else
                    self:getManager():dispatchEvent(self:getManager().HERO_FORMATION_TILE_SELECT)
                    local tilePos = self:getManager():getFormationTilePos(self.m_formationId, self.m_colIndex, self.m_rowIndex)
                    self.tileFormationHeroVo = self:getManager():getFormationHeroVoByPos(self.m_teamId, tilePos)
                    self:__updateView()
                end

            else
                self:getManager():dispatchEvent(self:getManager().HERO_FORMATION_TILE_SELECT)
                local tilePos = self:getManager():getFormationTilePos(self.m_formationId, self.m_colIndex, self.m_rowIndex)
                self.tileFormationHeroVo = self:getManager():getFormationHeroVoByPos(self.m_teamId, tilePos)
                self:__updateView()
            end
        end
    end
    if (selectIsInAssist) then
        UIFactory:alertMessge(_TT(1282),
        true, function() reqSelect() end, _TT(1), nil,
        true, function() end, _TT(2),
        _TT(5), nil, RemindConst.NULL)
    else
        reqSelect()
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
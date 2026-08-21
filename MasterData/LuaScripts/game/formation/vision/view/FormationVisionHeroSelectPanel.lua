--[[ 
-----------------------------------------------------
@filename       : FormationVisionHeroSelectPanel
@Description    : 异象残境战员选择面板（多队伍，战员不可跨队重复）
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('formation.FormationVisionHeroSelectPanel', Class.impl(formation.FormationHeroSelectPanel))

function __getHeadSelectItem(self)
    return formation.FormationVisionHeroSelectItem
end

function active(self, args)
    super.active(self, args)
    self:getManager():addEventListener(self:getManager().HERO_TEAM_SEE, self.__onTeamSelectHandler, self)
end

function deActive(self)
    self:getManager():removeEventListener(self:getManager().HERO_TEAM_SEE, self.__onTeamSelectHandler, self)
    super.deActive(self)
end

function __onTeamSelectHandler(self, args)
    if not args or not args.teamId or self.m_teamId == args.teamId then
        return
    end

    self.m_teamId = args.teamId
    self.m_formationId = self:getManager():getFightFormationId(self.m_teamId)
    local tilePos = self:getManager():getFormationTilePos(self.m_formationId, self.m_colIndex, self.m_rowIndex)
    self.tileFormationHeroVo = self:getManager():getFormationHeroVoByPos(self.m_teamId, tilePos)
    self:__updateView(false)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]

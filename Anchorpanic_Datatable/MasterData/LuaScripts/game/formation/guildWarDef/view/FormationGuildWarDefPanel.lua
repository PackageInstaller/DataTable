--[[ 
-----------------------------------------------------
@filename       : FormationGuildWarDefPanel
@Description    : 联盟团战防守面板
-----------------------------------------------------
]]
module("formation.FormationGuildWarDefPanel", Class.impl(formation.FormationGuildWarAtkPanel))

function configUI(self)
    super.configUI(self)

    self.mLockToggle = self:getChildGO('mLockToggle'):GetComponent(ty.Toggle)
    self.mAnim = self.UIObject:GetComponent(ty.Animator)

    --self.mLockToggle.gameObject:SetActive(false)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    super.addAllUIEvent(self)

    local function onToggle(val)
        self.toggleChange(self)
    end
    self.mLockToggle.onValueChanged:AddListener(onToggle)
end

function deActive(self)
    super.deActive(self)
    self.mLockToggle.onValueChanged:RemoveAllListeners()
end

-- 更新锁定阵容属性开关
function updateLockToogle(self)
    local formationHeroList = self:getManager():getSelectFormationHeroList(self:getManager():getFightTeamId())
    if (#formationHeroList > 0) and self:getManager():isTeamChange(self:getManager():getFightTeamId()) == false then
        self.mLockToggle.gameObject:SetActive(true)
    end
    self.mLockToggle.isOn = guildWar.GuildWarManager:getGuildWarLockState() == 1
end

function toggleChange(self)
    if guildWar.GuildWarManager:getGuildWarLockState() == 0 and self.mLockToggle.isOn == true then
        if self:getManager():isTeamChange(self:getManager():getFightTeamId()) then
            self.mLockToggle.isOn = false
            gs.Message.Show(_TT(98007)) -- "阵容发生变化未保存，请保存后再操作"
            return
        end
        UIFactory:alertMessge(_TT(1425), true, function()
            GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_CHANGE_DEF_STATE)
        end, _TT(1), -- "确定"
        nil, true, function()
            self.mLockToggle.isOn = false
        end, _TT(2), -- "取消"
        _TT(5), -- "提示"
        nil)
    end
    if guildWar.GuildWarManager:getGuildWarLockState() == 1 and self.mLockToggle.isOn == false then
        GameDispatcher:dispatchEvent(EventName.REQ_GUILD_WAR_CHANGE_DEF_STATE)
    end
end

-- 玩家点击关闭
function onClickClose(self)
    if not self.mIsSelectHero then
        self.mCurTeamIndex = nil
    end
    local formationHeroList = self:getManager():getSelectFormationHeroList(self:getManager():getFightTeamId())
    if (#formationHeroList <= 0) then
        -- gs.Message.Show(_TT(1214)) -- 出战队列不可为空
        super.super.onClickClose(self)
        self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
    elseif self:getManager():isTeamChange(self:getManager():getFightTeamId()) then
        UIFactory:alertMessge(_TT(171), true, function()

            if guildWar.GuildWarManager:getGuildWarLockState() == 1 then
                if self.mAnim then
                    self.mAnim:Play("FormationPanel_Show")
                end
                gs.Message.Show(_TT(1426))
                return
            end

            self:__onClickBtnControlHandler()
            super.super.onClickClose(self)
            self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
        end, _TT(1), nil, true, function()
            super.super.onClickClose(self)
            self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
        end, _TT(2), _TT(5), nil)
    else
        super.super.onClickClose(self)
        self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
    end
end

-- 玩家关闭所有窗口的c#回调
function closeAll(self)
    self.mCurTeamIndex = nil
    local formationHeroList = self:getManager():getSelectFormationHeroList(self:getManager():getFightTeamId())
    if (#formationHeroList <= 0) then
        gs.Message.Show(_TT(1214)) -- 出战队列不可为空
        super.super.closeAll(self)
        self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
    elseif self:getManager():isTeamChange(self:getManager():getFightTeamId()) then
        UIFactory:alertMessge(_TT(171), true, function()

            if guildWar.GuildWarManager:getGuildWarLockState() == 1 then
                if self.mAnim then
                    self.mAnim:Play("FormationPanel_Show")
                end
                gs.Message.Show(_TT(1426))
                return
            end

            self:__onClickBtnControlHandler()
            super.super.closeAll(self)
            self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
        end, _TT(1), nil, true, function()
            super.super.closeAll(self)
            self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
        end, _TT(2), _TT(5), nil)
    else
        super.super.closeAll(self)
        self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
    end
end

-- 点击保存出战队列并且回调
function __onClickBtnControlHandler(self)
    if guildWar.GuildWarManager:getGuildWarLockState() == 1 then
        if self.mAnim then
            self.mAnim:Play("FormationPanel_Show")
        end
        gs.Message.Show(_TT(1426))
        return
    end
    local teamList = self:getManager():getAllTeamIdList()
    local emptyTeamIndex = nil
    local hasChangeTeam = false
    for i, teamId in ipairs(teamList) do
        local formationHeroList = self:getManager():getSelectFormationHeroList(teamId)
        if emptyTeamIndex == nil and #formationHeroList <= 0 then
            emptyTeamIndex = i
        end
        if hasChangeTeam == false and self:getManager():isTeamChange(teamId) then
            hasChangeTeam = true
        end
    end
    if emptyTeamIndex ~= nil then
        gs.Message.Show(string.format("保存失败，队伍%s没有布置战员", emptyTeamIndex))
        return
    end

    if hasChangeTeam == false then
        gs.Message.Show(_TT(172)) -- 暂无可保存的队伍
    else
        self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, {})
    end
end


return _M
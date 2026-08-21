--[[
-----------------------------------------------------
@filename       : FormationGuildBossWarPanel
@Description    : 联盟boss战
@date           : 2023-10-23 16:01:27
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('fomation.FormationGuildBossWarPanel', Class.impl(formation.FormationPanel))

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁

function active(self, args)
    Perset3dHandler:setupShowData(MainCityConst.ROLE_MODE_FORMATION, nil, nil, "")
    super.active(self, args)
    MoneyManager:setMoneyTidList()
    -- TextureCameraHandler:open()
    self:setManager(args.manager)
    self:getManager():addEventListener(self:getManager().HERO_TEAM_SEE, self.__onTeamSelectHandler, self)
    self:getManager():addEventListener(self:getManager().HERO_FORMATION_SEE, self.__onFormationSelectHandler, self)
    self:getManager():addEventListener(self:getManager().UPDATE_TEAM_FORMATION_DATA,
    self.__onFormationDataUpdateHandler, self)
    self:getManager():addEventListener(self:getManager().UPDATE_FIGHT_TEAM_ID, self.__checkUpdateTeamView, self)
    self:getManager():addEventListener(self:getManager().UPDATE_TEAM_NAME, self.__checkUpdateTeamView, self)
    self:getManager()
    :addEventListener(self:getManager().UPDATE_TEAM_FORMATION_ID, self.__checkUpdateFormationView, self)
    self:getManager():addEventListener(self:getManager().UPDATE_TEAM_CAPTAIN_ID, self.__checkUpdateCaptainView, self)
    self:getManager():addEventListener(self:getManager().HERO_FORMATION_TILE_SELECT, self.__onClickFormationTileHandler,
    self)
    self:getManager():addEventListener(self:getManager().HERO_FORMATION_TILE_POINTER_DOWN,
    self.__onPointerDownFormationTileHandler, self)
    self:getManager():addEventListener(self:getManager().HERO_FORMATION_TILE_POINTER_UP,
    self.__onPointerUpFormationTileHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_FORMATION_HEROLIST, self.onRestoreArrowHandler, self)
    hero.HeroFlagManager:addEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.updateTeamFlag, self)
    self.mNowSelectFormation:SetActive(false)
    self.mGroupMove.gameObject:SetActive(true)

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

    self:__checkUpdateView()

    -- local isShow = StorageUtil:getBool1(self.mArrowStateKey)
    local isShow = true
    if StorageUtil:getNumber1(self.mArrowStateKey) == 2 then
        -- 默认打开，0和1 为true
        isShow = false
    end
    self:onRestoreArrowHandler(isShow)
    formation.FormationManager:setSelectFormationTeamId(self.m_teamId)
    gs.RenderSettings.fog = false
    self.IS_CHECK_FOR_CLOSE = true
    gs.CameraMgr:GetDefSceneCamera().gameObject:SetActive(true)
    self.mRecommandLv:SetActive(self.mBtnSave.activeSelf ~= true)
    self.mClearDetail:SetActive(false)
    self.mBtnCloseFormation:SetActive(false)
    self.mEleTipGroup:SetActive(false)
    local camera = gs.CameraMgr:GetDefSceneCamera()
    self.flipComponent = camera:GetComponent(ty.FlipCameraComponent)
    self.flipComponent:SetFlipHorizontal(false)
    self.mBtnFormation:SetActive(false)
end

function deActive(self)
    super.deActive(self)
    if self.timerId then
        LoopManager:removeTimerByIndex(self.timerId)
    end
    self.timerId = nil
end

-- function __updateView(self, cusInit)
--     super.__updateView(self, cusInit)
--     if self.timerId then
--         LoopManager:removeTimerByIndex(self.timerId)
--     end
--     self.timerId = nil
--     local onTimer = function()
--         if (dup.DupApostlesWarManager:getWeekEnd()) then
--             self:closeAll()
--         end
--     end
--     self.timerId = LoopManager:addTimer(1, 0, self, onTimer)
-- end

-- 点击保存出战队列并且回调
function __onClickBtnControlHandler(self)
    local count = self:getManager():getSelectFilterHeroCount(self.m_teamId)
    if (count <= 0) then
        gs.Message.Show(_TT(1284))
        gs.Message.Show(_TT(29119))
    else
        local function run()
            local data = self:getManager():getData()
            if data.battleType == PreFightBattleType.Guild_boss_war then
                UIFactory:alertMessge(_TT(94607), true, function()
                    self:onClickBtnControlHandler()
                end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, RemindConst.DUP_APOSTLES_WAR
            )
        else
            self:onClickBtnControlHandler()
        end
    end

    local recommandFight = self:getManager():getRecommandFight()
    if (recommandFight == nil or recommandFight <= 0) then
        run()
    else
        local fight = self:getFormationFight()
        if (fight >= recommandFight) then
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

function onClickBtnControlHandler(self)
    -- if (dup.DupApostlesWarManager.mIsTrain) then
    --     local dupId = self:getManager():getData().dupId
    --     GameDispatcher:dispatchEvent(EventName.REQ_DUP_APOSTLES2_TRAIN, { bossId = self:getManager():getDataId(), dupId = dupId })
    -- end
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

function onRestoreHandler(self, isInit)
    local height = self.mScrollerSelectTrans.rect.height - self.mScrollerSelectTrans.rect.height % 0.001
    if height >= self.mMinHeight or isInit then
        if isInit then
            self:updateFormationList(isInit)
        end
        self.mImgArrowUp:SetActive(true)
        self.mImgArrowDown:SetActive(false)
        if not self.mEleTipGroup.activeSelf then
            self.mBtnCloseFormation:SetActive(false) -- 关闭
        end
        self.mNowImgIcon:SetImg(UrlManager:getPackPath(string.format("formation5/formation_mini_icon_%s.png",
        self.m_formationId)), true)
        self.mNowSelectFormation:SetActive(false)
        gs.TransQuick:SizeDelta02(self.mScrollerSelectTrans, self.mMinHeight)
        self.mFormationScrollerRect.enabled = false
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]

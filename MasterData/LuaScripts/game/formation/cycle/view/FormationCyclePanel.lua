module('fomation.FormationCyclePanel', Class.impl(formation.FormationPanel))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("formation/FormationCyclePanel.prefab")

destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁

function configUI(self)
    super.configUI(self)
    self.mCycContent = self:getChildTrans("mCycleContent")
end

function active(self, args)
    super.active(self, args)
    GameDispatcher:dispatchEvent(EventName.SHOW_CYCLE_TOP_PANEL)
    GameDispatcher:dispatchEvent(EventName.SET_CYCLE_TOP_PANEL_INFO, {
        title = "",
        showTypeList = {TOP_SHOW_TYPE.LV, TOP_SHOW_TYPE.REASON, TOP_SHOW_TYPE.COIN, TOP_SHOW_TYPE.HOPE,
                        TOP_SHOW_TYPE.RET_MAIN, TOP_SHOW_TYPE.TOPBAR}
    })

    --self.base_childGos["mGroupTop"]:SetActive(false)

    local data = self:getManager():getData()
    cycle.CycleManager:setIsPre(data.dupId == 0,true)
end

function deActive(self)
    --GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_TOP_PANEL)
    if self.IS_CHECK_FOR_CLOSE then
        self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, {})
    end
   
    super.deActive(self)
    local data = self:getManager():getData()
    cycle.CycleManager:setIsPre(data.dupId == 0,false)

    GameDispatcher:dispatchEvent(EventName.SET_CYCLE_CONTENT_PARENT, {
        parentTrans =  GameView.story,
        isShow = false
    })

    --cusLog("close=================")
end

-- 打开培养界面
function __onClickDevelopHandler(self, args)
    if self.mIsSelectHero then
        return
    end

    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_TOP_PANEL)

    local targetId = args
    hero.HeroManager:setPanelShowHeroId(targetId)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, {
        heroId = targetId,
        tabType = hero.DevelopTabType.LVL_UP,
        subData = {},
        teamId = self.m_teamId,
        isPrepare = true
    })
end

function updateChildCustom(self)
  
    local data = self:getManager():getData()
    cycle.CycleManager:setIsPre(data.dupId == 0,true)
    if data.dupId == 0 then
        self.mBtnAssist:SetActive(false)
        self.mBtnControl:SetActive(false)
        self.mBtnEnemyInfo:SetActive(false)
        -- self.base_childGos["mGroupTop"]:SetActive(true)
        self.mRecommandLv:SetActive(false)
    else
        self.mBtnAssist:SetActive(false)
        self.mBtnControl:SetActive(true)
        self.mBtnEnemyInfo:SetActive(true)
        -- self.base_childGos["mGroupTop"]:SetActive(false)
    end
    --self.base_childGos["mGroupTop"]:SetActive(false)
    GameDispatcher:dispatchEvent(EventName.SET_CYCLE_CONTENT_PARENT, {
        parentTrans =  self.mCycContent,
        isShow = false
    })
    GameDispatcher:dispatchEvent(EventName.SET_CYCLE_TOP_PANEL_INFO, {
        title = "",
        showTypeList = {TOP_SHOW_TYPE.LV, TOP_SHOW_TYPE.REASON, TOP_SHOW_TYPE.COIN, TOP_SHOW_TYPE.HOPE,
                        TOP_SHOW_TYPE.RET_MAIN, TOP_SHOW_TYPE.TOPBAR}
    })

    -- GameDispatcher:dispatchEvent(EventName.HIDE_CYCLE_TOP_PANEL)
end


function closeHeroSelectEvnt(self)
    --self.base_childGos["mGroupTop"]:SetActive(false)
end

-- 阵型瓦片点击事件
function __onClickFormationTileHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FORMATION_MOVE, true) == false then
        return
    end

    --self.base_childGos["mGroupTop"]:SetActive(true)
    if args == nil then
        return
    end

    if (self:isLoadFinish() and not self.mTweening) then
        local colIndex = args.col
        local rowIndex = args.row
        -- 获取配置里的可以上阵的格子次序位置
        local heroPos = self:getManager():getFormationTilePos(self.m_formationId, colIndex, rowIndex)
        -- 是否可以上阵的格子
        if (heroPos > 0) then
            self.mCanvasGroup.alpha = 0
            self.mCanvasGroup.gameObject:SetActive(false)
            self.m_sceneController:showChooseVFX(colIndex, rowIndex)
            if not self.mIsSelectHero then
                self:getManager():dispatchEvent(self:getManager().OPEN_FORMATION_HERO_SELECT_PANEL, {
                    teamId = self.m_teamId,
                    formationId = self.m_formationId,
                    rowIndex = rowIndex,
                    colIndex = colIndex,
                    closeCall = {
                        target = self,
                        func = self.recoverCanvasGroup,
                        group = self.mGroupMove
                    }
                })
                if self.mHeroDevelopNode.gameObject.activeSelf then
                    TweenFactory:move2LPosX(self.mGroupMove, self.mGroupMove.localPosition.x - 270, 0.3,
                        gs.DT.Ease.Linear)
                end
                local cameraTrans = gs.CameraMgr:GetDefSceneCameraTrans()
                cameraTrans:DOLocalMove(gs.Vector3(2, 0, 0), 0.5)
                self.m_selectMousePos = nil
                self.m_goLine:SetActive(false)
            else
                self:onClickBtnClose()
                GameDispatcher:dispatchEvent(EventName.REFRESH_FORMATION_HERO_SELECT, {
                    teamId = self.m_teamId,
                    formationId = self.m_formationId,
                    rowIndex = rowIndex,
                    colIndex = colIndex,
                    closeCall = {
                        target = self,
                        func = self.recoverCanvasGroup,
                        group = self.mGroupMove
                    }
                })

            end
            -- self.base_childGos["mGroupTop"]:SetActive(true)
            self.mIsSelectHero = true
        end

        local effectId, bgUrl, icon = self:getManager():getPosHasEffect(self.heroEffId, colIndex, rowIndex)
        if effectId then
            self.mEleTipGroup:SetActive(true)
            self.mBtnCloseFormation:SetActive(true)
            self.mTeamNode:SetActive(false)
            local buffVo = fight.SkillManager:getSkillRo(effectId)
            self.mTxtEleSkillName.text = buffVo.m_name
            self.mTxtEleSkillDes.text = buffVo.m_desc
        end
    end
end

return _M

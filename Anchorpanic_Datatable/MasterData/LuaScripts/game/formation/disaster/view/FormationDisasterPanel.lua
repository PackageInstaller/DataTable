--[[ 
-----------------------------------------------------
@filename       : FormationDisasterPanel
@Description    : 灾厄阵型界面
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]] module("formation.FormationDisasterPanel", Class.impl(formation.FormationPanel))

UIRes = UrlManager:getUIPrefabPath("formation/FormationDisasterPanel.prefab")
destroyTime = 0-- 自动销毁时间-1默认 0即时销毁 999不销毁


function configUI(self)
    super.configUI(self)
    self.mBtnControl:SetActive(true)
    self:getChildGO("mBtnFuncTips"):SetActive(false)
    -- self.mBtnSave = self:getChildGO("mBtnSave")
    -- self.mBtnSave:SetActive(true)

    self.mGroupTeam = self:getChildGO("mGroupTeam")
    self.mBtnTeamItem = self:getChildGO("mBtnTeamItem")

    -- self.mBtnDevelop:SetActive(false)
    -- self.mHeroDevelopNode.gameObject:SetActive(false)
    self.mBtnImitate = self:getChildGO("mBtnImitate")
    self.mBtnQuit = self:getChildGO("mBtnQuit")
    self.mTxtQuit = self:getChildGO("mTxtQuit"):GetComponent(ty.Text)
    self.mBtnHis = self:getChildGO("mBtnHis")
    self.mTxtRem = self:getChildGO("mTxtRem"):GetComponent(ty.Text)
    self.mInfInfo = self:getChildGO("mInfInfo")
    self.mTxtCurFight = self:getChildGO("mTxtCurFight"):GetComponent(ty.Text)
    self.triggerList = {}

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    super.addAllUIEvent(self)

    self:addUIEvent(self.mBtnImitate, self.onImitateClickHandler)
    self:addUIEvent(self.mBtnQuit, self.onQuitClickHandler)
    self:addUIEvent(self.mBtnHis, self.onHisClickHandler)
end

function onHisClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_DISASTER_LOG_PANEL)
end

function updateHeroOrMonster(self)
    super.updateHeroOrMonster(self)
    self.mBtnDevelop:SetActive(true)
end


function getMaxTxt(self, index)
    local s = ""
    if index == 1 then
        s = "一"
    elseif index == 2 then
        s = "二"
    elseif index == 3 then
        s = "三"
    elseif index == 4 then
        s = "四"
    elseif index == 5 then
        s = "五"
    elseif index == 6 then
        s = "六"
    elseif index == 7 then
        s = "七"
    elseif index == 8 then
        s = "八"
    elseif index == 9 then
        s = "九"
    elseif index == 10 then
        s = "十"
    end
    return s
end

function onInitGroupTeam(self)
    self.btnItemDic = {}
    local count = sysParam.SysParamManager:getValue(SysParamType.DISASTER_ROUNDTIMER)
    for i = 1, count do
        local isFight = disaster.DisasterManager:getFormationIsFight(i)
        local item = SimpleInsItem:create(self.mBtnTeamItem, self.mGroupTeam.transform, "mBtnTeamItem")
        item:getChildGO("mTxtTeamName"):GetComponent(ty.Text).text = "队伍" .. self:getMaxTxt(i)
        item:getChildGO("mTxtTeamName"):SetActive(not isFight)
        item:getChildGO("mIsFight"):SetActive(isFight)
        item:getChildGO("mImgTeamSelect"):SetActive(false)
        table.insert(self.triggerList, item)
        self.btnItemDic[i] = item
    end
    for index, item in pairs(self.btnItemDic) do
        local function onPointClickHandler()
            self:onPointClickHandler(index)
        end
        self:addUIEvent(item.m_go, onPointClickHandler)
    end
end

function onShowPointDownHandler(self, index)
    -- self.mStartMousePos = gs.Vector2(gs.Input.mousePosition.x, gs.Input.mousePosition.y)
    -- self.mSelectIndex = index
    -- self.mSelectBtn = self.triggerList[index]

    -- if not self.mShowFrameSn then
    --     self.mShowFrameSn = LoopManager:addFrame(1, 0, self, self.onShowTeamBtnFrameHandler)
    -- end
end

function onShowPointUpHandler(self, index)
    -- -- 2换1
    -- local teamList = self:getManager():getAllTeamIdList()
    -- local newIndex = self:getShowCollision() -- 1
    -- if newIndex and newIndex > 0 then
    --     local oldTeamId = teamList[index] -- 2
    --     local newTeamId = teamList[newIndex] -- 1

    --     -- 切换阵形
    --     local oldFormationId = self:getManager():getFightFormationId(oldTeamId)
    --     local newFormationId = self:getManager():getFightFormationId(newTeamId)
    --     self:getManager():updateTeamFormationId(oldTeamId, newFormationId)
    --     self:getManager():updateTeamFormationId(newTeamId, oldFormationId)

    --     -- 切换战员
    --     local oldHeroList = self:getManager():getSelectFormationHeroList(oldTeamId)
    --     local newHeroList = self:getManager():getSelectFormationHeroList(newTeamId)

    --     formation.FormationManager.m_selectFormationHeroDic[oldTeamId] = newHeroList
    --     formation.FormationManager.m_selectFormationHeroDic[newTeamId] = oldHeroList

    --     -- 切换锚驴
    --     local oldPetId = self:getManager():getPetIdByTeamId(oldTeamId)
    --     local newPetId = self:getManager():getPetIdByTeamId(newTeamId)

    --     formation.FormationManager:setUsePetByTeamId(oldTeamId, newPetId)
    --     formation.FormationManager:setUsePetByTeamId(newTeamId, oldPetId)

    --     self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, {})

    --     self.mCurTeamIndex = newIndex
    --     self:onPointClickHandler(newIndex)
    -- end
    -- if self.mShowFrameSn then
    --     LoopManager:removeFrameByIndex(self.mShowFrameSn)
    --     self.mShowFrameSn = nil
    -- end
    -- if (self.mShowDragGoBg and not gs.GoUtil.IsGoNull(self.mShowDragGoBg)) then
    --     gs.GameObject.Destroy(self.mShowDragGoBg)
    --     self.mShowDragGoBg = nil
    -- end
end

function onPointClickHandler(self, index)
    local isFight = disaster.DisasterManager:getFormationIsFight(index)
    if isFight then
        gs.Message.Show("已经战斗过了")
        return
    end
    self.mCurTeamIndex = index
    for i, item in pairs(self.btnItemDic) do
        item:getChildGO("mImgTeamSelect"):SetActive(i == index)
        item:getChildGO("mTxtTeamName"):GetComponent(ty.Text).color =
            i == index and gs.ColorUtil.GetColor("202226FF") or gs.ColorUtil.GetColor("FFFFFFFF")
    end

    self:onChangeTeam(index)
end

function onShowTeamBtnFrameHandler(self)
    if not self.mShowDragGoBg then
        self.mShowDragGoBg = gs.GameObject.Instantiate(self.mSelectBtn)
        local pos = self.mSelectBtn.transform.anchoredPosition
        gs.TransQuick:UIPos(self.mShowDragGoBg.transform, pos.x, pos.y)
        self.mShowDragGoBg.transform:SetParent(self.mGroupTeam.transform, false)
    end
    if self.mShowDragGoBg and not gs.GoUtil.IsGoNull(self.mShowDragGoBg) then
        -- 把当前鼠标的屏幕坐标转换成世界坐标
        local screenPos = gs.Vector3(gs.Input.mousePosition.x, gs.Input.mousePosition.y, gs.Input.mousePosition.z)
        local worldPos = gs.CameraMgr:ScreenToWorldByUICamera(screenPos)
        gs.TransQuick:PosXY(self.mShowDragGoBg.transform, worldPos.x, worldPos.y)
    end
end

-- 获取释放的替换队伍
function getShowCollision(self)
    if (self.mShowDragGoBg and not gs.GoUtil.IsGoNull(self.mShowDragGoBg)) then
        local uiPos = self.mShowDragGoBg.transform.anchoredPosition
        -- 将拖拽物的左边转成左上角对齐，和父容器一致
        uiPos.x = uiPos.x -- + self.mSkillShowSize.x / 2
        uiPos.y = uiPos.y --- self.mSkillShowSize.y / 2
        for index, btn in pairs(self.btnItemDic) do
            local slotSize = btn.transform.sizeDelta
            local slotUiPos = btn.transform.anchoredPosition
            if (uiPos.x >= slotUiPos.x - slotSize.x / 2 and uiPos.x <= slotUiPos.x + slotSize.x / 2 and uiPos.y >=
                slotUiPos.y - slotSize.y / 2 and uiPos.y <= slotUiPos.y + slotSize.y / 2) then
                return index
            end
        end
    end
end

-- 切换队伍
function onChangeTeam(self, index)
    --self.m_formationId = index
    local teamList = self:getManager():getAllTeamIdList()

    --self.m_teamId = teamList[index]
    self.m_formationId = self:getManager():getFightFormationId(teamList[index])

    self:getManager():dispatchEvent(self:getManager().HERO_TEAM_SEE, {
        teamId = teamList[index]
    })
    --self:__updateMapView()
end

function __updateTeamList(self, cusInit)
    -- 此处poolRecover回收数据后，要确保接下来会执行DataProvider或ReplaceAllDataProvider，以彻底断开LyScroller数据列表和Lua对象池内的引用关系
    -- self.mTeamNode:SetActive(false)
    -- self.mBtnDevelop:SetActive(false)
    -- self.mHeroDevelopNode.gameObject:SetActive(false)
    -- if self.mCurTeamIndex == nil then
    --     -- if self:getManager():getData() ~= nil then
    --     --     local index = self:getManager():getData()
    --     --     self:onPointClickHandler(index)
    --     -- else
    --         self:onPointClickHandler(1)
    --     --end
    -- end
end

function active(self, args)
    super.active(self, args)
    self:onInitGroupTeam()


    if not self.isReshow then
        local startIndex = disaster.DisasterManager:getFormationStartIndex()
        self:onPointClickHandler(startIndex)
    else
        self:onPointClickHandler(self.mCurTeamIndex)
    end
    --self.mBtnDevelop:SetActive(false)
    --self.mHeroDevelopNode.gameObject:SetActive(false)

  
    local pass,all = disaster.DisasterManager:getFormationCount()
    self.mTxtRem.text = _TT(104009,all-pass,all) 
    self.mTeamNode:SetActive(false)

    local curDif = disaster.DisasterManager:getCurChallengingDif()
    local maxDif = disaster.DisasterManager:getDisasterDupMaxDif()
    self.mInfInfo:SetActive(curDif == maxDif)
    self.mTxtCurFight.text = _TT(104019)..disaster.DisasterManager:getFormationCurDamage()
    self.mGroupTeam:SetActive(true)
    --self.mTxtRem.gameObject:SetActive(curDif ~= maxDif)
end

function deActive(self)
    super.deActive(self)
    for index, item in pairs(self.btnItemDic) do
        item:poolRecover()
    end
    self.btnItemDic = {}
end

function initViewText(self)
    super.initViewText(self)

    self.mTxtQuit.text = _TT(104024)
end

-- -- 玩家点击关闭
-- function onClickClose(self)
--     if not self.mIsSelectHero then
--         self.mCurTeamIndex = nil
--     end
--     local formationHeroList = self:getManager():getSelectFormationHeroList(self:getManager():getFightTeamId())
--     if (#formationHeroList <= 0) then
--         -- gs.Message.Show(_TT(1214)) -- 出战队列不可为空
--         super.onClickClose(self)
--         self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
--     elseif self:getManager():isTeamChange(self:getManager():getFightTeamId()) then
--         UIFactory:alertMessge(_TT(171), true, function()
--             self:__onClickBtnControlHandler()
--             super.onClickClose(self)
--             self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
--         end, _TT(1), nil, true, function()
--             super.onClickClose(self)
--             self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
--         end, _TT(2), _TT(5), nil)
--     else
--         super.onClickClose(self)
--         self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
--     end
-- end

-- -- 玩家关闭所有窗口的c#回调
-- function closeAll(self)
--     self.mCurTeamIndex = nil
--     local formationHeroList = self:getManager():getSelectFormationHeroList(self:getManager():getFightTeamId())
--     if (#formationHeroList <= 0) then
--         gs.Message.Show(_TT(1214)) -- 出战队列不可为空
--         super.closeAll(self)
--         self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
--     elseif self:getManager():isTeamChange(self:getManager():getFightTeamId()) then
--         UIFactory:alertMessge(_TT(171), true, function()
--             self:__onClickBtnControlHandler()
--             super.closeAll(self)
--             self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
--         end, _TT(1), nil, true, function()
--             super.closeAll(self)
--             self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
--         end, _TT(2), _TT(5), nil)
--     else
--         super.closeAll(self)
--         self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
--     end
-- end

-- function __playerClose(self)
--     self:recoverHeadItems()
--     self:initData()
--     -- -- 可能会有援助的怪物，通知后端进入战斗后需要撤下，必要同步
--     -- self:rsyncFormationList(true)
--     self:getManager():setSelectFormationTeamId(nil)

--     self:getManager():clearSelectHeroDic()
--     self:getManager():clearSelectAssistHeroDic()
-- end

-- 点击保存出战队列并且回调
function __onClickBtnControlHandler(self)
    local count = self:getManager():getSelectFilterHeroCount(self.m_teamId, formation.HERO_SOURCE_TYPE.OWN) -- 差异在这里
    if (count <= 0) then
        gs.Message.Show(_TT(1284))
        gs.Message.Show(_TT(29119))

    else
        local function run()
            self:getManager():setIsReadTeamId(self.m_teamId, false)
            -- 可能会有援助的怪物，必要同步
            self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, {})
            -- 设置出战队列
            self:getManager():dispatchEvent(self:getManager().REQ_SET_FIGHT_TEAM, {
                teamId = self.m_teamId
            })
            -- 放在CALL_FUN_REASON前面，防止会自动弹出其他界面音乐，导致回调打开的界面音乐被顶掉
            self:forceClose()
            -- 回调外部
            self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
            -- 可能会有援助的怪物，通知后端进入战斗后需要撤下，必要同步
            self:rsyncFormationList(true)
        end

        if self:getDupVo() then
            local recommandFight = self:getDupVo().suggestLevel[2] -- 推荐等级
            if (recommandFight == nil or recommandFight <= 0) then
                run()
            else
                local isShowTips = false
                local fight = self:getFormationAvgLv()
                for i, v in pairs(self.mRecommandLvData) do
                    if v[1] <= recommandFight and v[2] > recommandFight then
                        local value = sysParam.SysParamManager:getValue(v[3])
                        isShowTips = (recommandFight - fight) >= value
                        break
                    end
                end
                isShowTips = isShowTips or
                                 (count <
                                     (#self:getDupVo().enemyList -
                                         sysParam.SysParamManager:getValue(SysParamType.FORMATION_TIP_OTHER_JUG)))
                if (isShowTips) then
                    UIFactory:alertMessge(_TT(1366), true, function()
                        run()
                    end, _TT(1), nil, true, function()
                    end, _TT(2), _TT(5), nil, RemindConst.FORMATION_FIGHT)
                else
                    run()
                end
            end
        else
            run()
        end
    end
end

function onImitateClickHandler(self)
    local count = self:getManager():getSelectFilterHeroCount(self.m_teamId, formation.HERO_SOURCE_TYPE.OWN) -- 差异在这里
    if (count <= 0) then
        gs.Message.Show(_TT(1284))
        gs.Message.Show(_TT(29119))
    else
        local function run()
            self:getManager():setIsReadTeamId(self.m_teamId, true)
            -- 可能会有援助的怪物，必要同步
            self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, {})
            -- 设置出战队列
            self:getManager():dispatchEvent(self:getManager().REQ_SET_FIGHT_TEAM, {
                teamId = self.m_teamId
            })
            -- 放在CALL_FUN_REASON前面，防止会自动弹出其他界面音乐，导致回调打开的界面音乐被顶掉
            self:forceClose()
            -- 回调外部
            self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
            -- 可能会有援助的怪物，通知后端进入战斗后需要撤下，必要同步
            self:rsyncFormationList(true)
        end

        if self:getDupVo() then
            local recommandFight = self:getDupVo().suggestLevel[2] -- 推荐等级
            if (recommandFight == nil or recommandFight <= 0) then
                run()
            else
                local isShowTips = false
                local fight = self:getFormationAvgLv()
                for i, v in pairs(self.mRecommandLvData) do
                    if v[1] <= recommandFight and v[2] > recommandFight then
                        local value = sysParam.SysParamManager:getValue(v[3])
                        isShowTips = (recommandFight - fight) >= value
                        break
                    end
                end
                isShowTips = isShowTips or
                                 (count <
                                     (#self:getDupVo().enemyList -
                                         sysParam.SysParamManager:getValue(SysParamType.FORMATION_TIP_OTHER_JUG)))
                if (isShowTips) then
                    UIFactory:alertMessge(_TT(1366), true, function()
                        run()
                    end, _TT(1), nil, true, function()
                    end, _TT(2), _TT(5), nil, RemindConst.FORMATION_FIGHT)
                else
                    run()
                end
            end
        else
            run()
        end
    end
end

function onQuitClickHandler(self)
    UIFactory:alertMessge(_TT(104008), true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_ABANDON_DISASTER)
        self:close()
    end, _TT(1), nil, true, function()
    end, _TT(2), _TT(5))
end

--  获取背景图路径
function __getBgURL(self)
    return UrlManager:getBgPath("formation/formation_defence_bg.jpg")
end

-- 阵型瓦片点击事件
function __onClickFormationTileHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FORMATION_MOVE, true) == false then
        return
    end

    if args == nil then
        return
    end

    local isLock, id = self:getManager():getFormationTileLock(self.m_formationId, args.col, args.row)

    if isLock == true and id > 0 then
        local stageVo = battleMap.MainMapManager:getStageVo(id)
        gs.Message.Show(_TT(47, stageVo.indexName))
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
            self.mGroupTeam:SetActive(false)
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
            self.mBtnQuit:SetActive(false)
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

function recoverCanvasGroup(self)
    self.mIsSelectHero = false
    self.mTweening = true
    self.mBtnCloseFormation:SetActive(false)
    self:onClickBtnClose()
    self.m_sceneController:hideChooseVFX()
    self.mEleTipGroup:SetActive(false)
    self.mCanvasGroup.gameObject:SetActive(true)
    self.mCanvasGroup.alpha = 1
    self.mGroupTeam:SetActive(true)
    self.mBtnQuit:SetActive(true)

    -- TweenFactory:canvasGroupAlphaTo(self.mCanvasGroup, 0, 1, 0.7, gs.DT.Ease.Linear)
    self.mGroupMove:SetParent(self.mMoveNode, false)
    if self.mHeroDevelopNode.gameObject.activeSelf then
        TweenFactory:move2LPosX(self.mGroupMove, self.mGroupMove.localPosition.x + 270, 0.3, gs.DT.Ease.Linear,
            function()
                self.mGroupMove:SetAsFirstSibling()
                self.mBtnCloseFormation.transform:SetAsFirstSibling()
                self.mTweening = false
            end)
    else
        self.mGroupMove:SetAsFirstSibling()
        self.mBtnCloseFormation.transform:SetAsFirstSibling()
        self.mTweening = false
    end

    local cameraTrans = gs.CameraMgr:GetDefSceneCameraTrans()
    cameraTrans:DOLocalMove(gs.Vector3(0, 0, 0), 0.5)

end

function __onClickFormationHandler(self)
    local lock, formationId = self:getManager():isLockFormation()
    if lock == 1 then
        gs.Message.Show(_TT(3074))
        return
    end
    local height = self.mScrollerSelectTrans.rect.height - self.mScrollerSelectTrans.rect.height % 0.001
    if height <= self.mMinHeight then
        self:updateFormationList()
        self.mImgArrowUp:SetActive(false)
        self.mImgArrowDown:SetActive(true)
        self.mBtnCloseFormation:SetActive(true) -- 打开
        self.mNowSelectFormation:SetActive(false)
        gs.TransQuick:SizeDelta02(self.mScrollerSelectTrans, self.mMaxHeight)
        self.mFormationScrollerRect.enabled = true
        self.mGroupTeam:SetActive(false)
    else
        self:onRestoreHandler(false)
        self.mGroupTeam:SetActive(true)
    end
   
end

function __onFormationSelectHandler(self, args)
    super.__onFormationSelectHandler(self,args)
    self.mGroupTeam:SetActive(true)
end

return _M

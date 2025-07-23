--[[ 
-----------------------------------------------------
@filename       : FormationArenaPeakAttackPanel
@Description    : 巅峰竞技场进攻面板
@date           : 2023-09-25 16:12:21
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("formation.FormationArenaPeakAttackPanel", Class.impl(formation.FormationPanel))

UIRes = UrlManager:getUIPrefabPath("formation/FormationPeakPanel.prefab")

function configUI(self)
    super.configUI(self)

    self.mBtnControl:SetActive(false)
    self:getChildGO("mBtnFuncTips"):SetActive(false)

    self.mBtnSave = self:getChildGO("mBtnSave")
    self.mBtnSave:SetActive(true)

    self.mGroupTeam = self:getChildGO("mGroupTeam")

    self.mBtnTeam_1 = self:getChildGO("mBtnTeam_1")
    self.mBtnTeam_2 = self:getChildGO("mBtnTeam_2")
    self.mBtnTeam_3 = self:getChildGO("mBtnTeam_3")
    self.mTxtTeamName1 = self:getChildGO("mTxtTeamName1"):GetComponent(ty.Text)
    self.mTxtTeamName2 = self:getChildGO("mTxtTeamName2"):GetComponent(ty.Text)
    self.mTxtTeamName3 = self:getChildGO("mTxtTeamName3"):GetComponent(ty.Text)
    self.mImgTeamSelect1 = self:getChildGO("mImgTeamSelect1")
    self.mImgTeamSelect2 = self:getChildGO("mImgTeamSelect2")
    self.mImgTeamSelect3 = self:getChildGO("mImgTeamSelect3")

    self.triggerList = { self.mBtnTeam_1, self.mBtnTeam_2, self.mBtnTeam_3 }
end

function active(self, args)
    super.active(self, args)

    for i, btn in ipairs(self.triggerList) do
        local function onPointDownHandler()
            self:onShowPointDownHandler(i)
        end
        btn:GetComponent(ty.LongPressOrClickEventTrigger).onLongPress:AddListener(onPointDownHandler)
        local function onPointUpHandler()
            self:onShowPointUpHandler(i)
        end
        btn:GetComponent(ty.LongPressOrClickEventTrigger).onPointerUp:AddListener(onPointUpHandler)
    end
end

function deActive(self)
    super.deActive(self)

    if self.mShowFrameSn then
        LoopManager:removeFrameByIndex(self.mShowFrameSn)
        self.mShowFrameSn = nil
    end

    if (self.mShowDragGoBg and not gs.GoUtil.IsGoNull(self.mShowDragGoBg)) then
        gs.GameObject.Destroy(self.mShowDragGoBg)
        self.mShowDragGoBg = nil
    end

    for i, btn in ipairs(self.triggerList) do
        btn:GetComponent(ty.LongPressOrClickEventTrigger).onPointerDown:RemoveAllListeners()
        btn:GetComponent(ty.LongPressOrClickEventTrigger).onPointerUp:RemoveAllListeners()
    end
end

function initViewText(self)
    super.initViewText(self)
    self.m_textTitle.text = _TT(1244)
    self:setBtnLabel(self.mBtnSave, nil, _TT(173))
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnSave, self.__onClickBtnControlHandler)
    self:addUIEvent(self.mBtnTeam_1, self.onChangeTeamHandler1)
    self:addUIEvent(self.mBtnTeam_2, self.onChangeTeamHandler2)
    self:addUIEvent(self.mBtnTeam_3, self.onChangeTeamHandler3)
end

-- 长按
function onShowPointDownHandler(self, index)
    self.mStartMousePos = gs.Vector2(gs.Input.mousePosition.x, gs.Input.mousePosition.y)
    self.mSelectIndex = index
    self.mSelectBtn = self.triggerList[index]

    if not self.mShowFrameSn then
        self.mShowFrameSn = LoopManager:addFrame(1, 0, self, self.onShowTeamBtnFrameHandler)
    end
end

-- 释放
function onShowPointUpHandler(self, index)
    -- 2换1
    local teamList = self:getManager():getAllTeamIdList()
    local newIndex = self:getShowCollision() -- 1
    if newIndex and newIndex > 0 then
        local oldTeamId = teamList[index] --2
        local newTeamId = teamList[newIndex] --1

        -- 切换阵形
        local oldFormationId = self:getManager():getFightFormationId(oldTeamId)
        local newFormationId = self:getManager():getFightFormationId(newTeamId)
        -- self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_CHANGE, {
        --     teamId = oldTeamId,
        --     formationId = newFormationId
        -- })
        self:getManager():updateTeamFormationId(oldTeamId, newFormationId)

        -- self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_CHANGE, {
        --     teamId = newTeamId,
        --     formationId = oldFormationId
        -- })
        self:getManager():updateTeamFormationId(newTeamId, oldFormationId)

        -- 切换战员
        local oldHeroList = self:getManager():getSelectFormationHeroList(oldTeamId)
        local newHeroList = self:getManager():getSelectFormationHeroList(newTeamId)

        formation.FormationManager.m_selectFormationHeroDic[oldTeamId] = newHeroList
        formation.FormationManager.m_selectFormationHeroDic[newTeamId] = oldHeroList

        -- 切换锚驴
        local oldPetId = self:getManager():getPetIdByTeamId(oldTeamId)
        local newPetId = self:getManager():getPetIdByTeamId(newTeamId)

        formation.FormationManager:setUsePetByTeamId(oldTeamId, newPetId)
        formation.FormationManager:setUsePetByTeamId(newTeamId, oldPetId)
        -- GameDispatcher:dispatchEvent(EventName.REFLASH_FORMATION_PANEL)
        self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, {})

        self.mCurTeamIndex = newIndex
        self:onChangeTeam(newIndex)
    end

    if self.mShowFrameSn then
        LoopManager:removeFrameByIndex(self.mShowFrameSn)
        self.mShowFrameSn = nil
    end
    if (self.mShowDragGoBg and not gs.GoUtil.IsGoNull(self.mShowDragGoBg)) then
        gs.GameObject.Destroy(self.mShowDragGoBg)
        self.mShowDragGoBg = nil
    end
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
        for index, btn in pairs(self.triggerList) do
            local slotSize = btn.transform.sizeDelta
            local slotUiPos = btn.transform.anchoredPosition
            if (uiPos.x >= slotUiPos.x - slotSize.x / 2 and uiPos.x <= slotUiPos.x + slotSize.x / 2 and uiPos.y >= slotUiPos.y - slotSize.y / 2 and uiPos.y <= slotUiPos.y + slotSize.y / 2) then
                return index
            end
        end
    end
end


function __updateTeamList(self, cusInit)
    -- 此处poolRecover回收数据后，要确保接下来会执行DataProvider或ReplaceAllDataProvider，以彻底断开LyScroller数据列表和Lua对象池内的引用关系
    self.mTeamNode:SetActive(false)
    if self.mCurTeamIndex == nil then
        if self:getManager():getData() ~= nil then
            local index = self:getManager():getData()
            self:onChangeTeam(index)
            self.mCurTeamIndex = index
        else
            self:updateChangeTeamBtn(1)
        end
    end
end

-- 点击切换队伍
function onChangeTeamHandler1(self)
    self:onChangeTeam(1)
    self.mCurTeamIndex = 1
end
function onChangeTeamHandler2(self)
    self:onChangeTeam(2)
    self.mCurTeamIndex = 2
end
function onChangeTeamHandler3(self)
    self:onChangeTeam(3)
    self.mCurTeamIndex = 3
end

-- 切换队伍
function onChangeTeam(self, index)
    local teamList = self:getManager():getAllTeamIdList()
    self:getManager():dispatchEvent(self:getManager().HERO_TEAM_SEE, { teamId = teamList[index] })
    self:updateChangeTeamBtn(index)
end

function updateChangeTeamBtn(self, index)
    if index == 1 then
        self.mImgTeamSelect1:SetActive(true)
        self.mImgTeamSelect2:SetActive(false)
        self.mImgTeamSelect3:SetActive(false)
        self.mTxtTeamName1.color = gs.ColorUtil.GetColor("202226FF")
        self.mTxtTeamName2.color = gs.ColorUtil.GetColor("FFFFFFFF")
        self.mTxtTeamName3.color = gs.ColorUtil.GetColor("FFFFFFFF")
    end
    if index == 2 then
        self.mImgTeamSelect1:SetActive(false)
        self.mImgTeamSelect2:SetActive(true)
        self.mImgTeamSelect3:SetActive(false)
        self.mTxtTeamName1.color = gs.ColorUtil.GetColor("FFFFFFFF")
        self.mTxtTeamName2.color = gs.ColorUtil.GetColor("202226FF")
        self.mTxtTeamName3.color = gs.ColorUtil.GetColor("FFFFFFFF")
    end
    if index == 3 then
        self.mImgTeamSelect1:SetActive(false)
        self.mImgTeamSelect2:SetActive(false)
        self.mImgTeamSelect3:SetActive(true)
        self.mTxtTeamName1.color = gs.ColorUtil.GetColor("FFFFFFFF")
        self.mTxtTeamName2.color = gs.ColorUtil.GetColor("FFFFFFFF")
        self.mTxtTeamName3.color = gs.ColorUtil.GetColor("202226FF")
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
        super.onClickClose(self)
        self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
    elseif self:getManager():isTeamChange(self:getManager():getFightTeamId()) then
        UIFactory:alertMessge(_TT(171), true, function()
            self:__onClickBtnControlHandler()
            super.onClickClose(self)
            self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
        end, _TT(1), nil, true, function()
            super.onClickClose(self)
            self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
        end, _TT(2), _TT(5), nil)
    else
        super.onClickClose(self)
        self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
    end
end

-- 玩家关闭所有窗口的c#回调
function closeAll(self)
    self.mCurTeamIndex = nil
    local formationHeroList = self:getManager():getSelectFormationHeroList(self:getManager():getFightTeamId())
    if (#formationHeroList <= 0) then
        gs.Message.Show(_TT(1214)) -- 出战队列不可为空
        super.closeAll(self)
        self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
    elseif self:getManager():isTeamChange(self:getManager():getFightTeamId()) then
        UIFactory:alertMessge(_TT(171), true, function()
            self:__onClickBtnControlHandler()
            super.closeAll(self)
            self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
        end, _TT(1), nil, true, function()
            super.closeAll(self)
            self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
        end, _TT(2), _TT(5), nil)
    else
        super.closeAll(self)
        self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
    end
end

function __playerClose(self)
    self:recoverHeadItems()
    self:initData()
    -- -- 可能会有援助的怪物，通知后端进入战斗后需要撤下，必要同步
    -- self:rsyncFormationList(true)
    self:getManager():setSelectFormationTeamId(nil)

    self:getManager():clearSelectHeroDic()
    self:getManager():clearSelectAssistHeroDic()
end

-- 点击保存出战队列并且回调
function __onClickBtnControlHandler(self)
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
                    TweenFactory:move2LPosX(self.mGroupMove, self.mGroupMove.localPosition.x - 270, 0.3, gs.DT.Ease.Linear)
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

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1244):	"防守队伍总战力"
]]
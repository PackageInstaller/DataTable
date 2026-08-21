module("formation.FormationVisionPanel", Class.impl(formation.FormationPanel))

UIRes = UrlManager:getUIPrefabPath("formation/FormationVisionPanel.prefab")

function configUI(self)
    super.configUI(self)

    self.mGroupTeam = self:getChildGO("mGroupTeam")
    self.mBtnTeam_1 = self:getChildGO("mBtnTeam_1")
    self.mBtnTeam_2 = self:getChildGO("mBtnTeam_2")
    self.mBtnTeam_3 = self:getChildGO("mBtnTeam_3")
    self.mImgTeamSelect1 = self:getChildGO("mImgTeamSelect1")
    self.mImgTeamSelect2 = self:getChildGO("mImgTeamSelect2")
    self.mImgTeamSelect3 = self:getChildGO("mImgTeamSelect3")
    self.mTxtTeamName1 = self:getChildGO("mTxtTeamName1"):GetComponent(ty.Text)
    self.mTxtTeamName2 = self:getChildGO("mTxtTeamName2"):GetComponent(ty.Text)
    self.mTxtTeamName3 = self:getChildGO("mTxtTeamName3"):GetComponent(ty.Text)
    self.mTeamBtnList = { self.mBtnTeam_1, self.mBtnTeam_2, self.mBtnTeam_3 }
    self.mTeamSelectList = { self.mImgTeamSelect1, self.mImgTeamSelect2, self.mImgTeamSelect3 }
    self.mTeamNameList = { self.mTxtTeamName1, self.mTxtTeamName2, self.mTxtTeamName3 }
    self.triggerList = self.mTeamBtnList
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
        btn:GetComponent(ty.LongPressOrClickEventTrigger).onLongPress:RemoveAllListeners()
        btn:GetComponent(ty.LongPressOrClickEventTrigger).onPointerUp:RemoveAllListeners()
    end
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnTeam_1, self.onChangeTeamHandler1)
    self:addUIEvent(self.mBtnTeam_2, self.onChangeTeamHandler2)
    self:addUIEvent(self.mBtnTeam_3, self.onChangeTeamHandler3)
end

function __updateTeamList(self, cusInit)
    self.mTeamNode:SetActive(false)
    self:updateVisionTeamBtn()
    local index = self:getVisionTeamIndexByTeamId(self.m_teamId)
    self:updateChangeTeamBtn(index)
end

function onChangeTeamHandler1(self)
    self:onChangeTeam(1)
end

function onChangeTeamHandler2(self)
    self:onChangeTeam(2)
end

function onChangeTeamHandler3(self)
    self:onChangeTeam(3)
end

function onChangeTeam(self, index)
    local teamList = self:getManager():getAllTeamIdList()
    local teamId = teamList[index]
    if not teamId then
        return
    end
    if self.m_teamId ~= teamId and #self:getManager():getChangeTeamIdList() > 0 then
        self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, {})
    end
    self:getManager():dispatchEvent(self:getManager().HERO_TEAM_SEE, { teamId = teamId })
    self:updateChangeTeamBtn(index)
end

-- 队伍按钮不可见时，不能作为拖拽源或替换目标
function isVisionTeamBtnVisible(self, index)
    local btn = self.triggerList and self.triggerList[index]
    return btn and btn.activeSelf and btn.activeInHierarchy
        and self:getManager():getAllTeamIdList()[index] ~= nil
end

-- 长按
function onShowPointDownHandler(self, index)
    if not self:isVisionTeamBtnVisible(index) then
        return
    end
    self.mStartMousePos = gs.Vector2(gs.Input.mousePosition.x, gs.Input.mousePosition.y)
    self.mSelectIndex = index
    self.mSelectBtn = self.triggerList[index]

    if not self.mShowFrameSn then
        self.mShowFrameSn = LoopManager:addFrame(1, 0, self, self.onShowTeamBtnFrameHandler)
    end
end

-- 释放
function onShowPointUpHandler(self, index)
    local oldIndex = self.mSelectIndex or index
    local teamList = self:getManager():getAllTeamIdList()
    local newIndex = self:getShowCollision()
    if newIndex and newIndex > 0 and newIndex ~= oldIndex
        and self:isVisionTeamBtnVisible(oldIndex) and self:isVisionTeamBtnVisible(newIndex) then
        local oldTeamId = teamList[oldIndex]
        local newTeamId = teamList[newIndex]

        local oldFormationId = self:getManager():getFightFormationId(oldTeamId)
        local newFormationId = self:getManager():getFightFormationId(newTeamId)
        self:getManager():updateTeamFormationId(oldTeamId, newFormationId)
        self:getManager():updateTeamFormationId(newTeamId, oldFormationId)

        local oldHeroList = self:getManager():getSelectFormationHeroList(oldTeamId)
        local newHeroList = self:getManager():getSelectFormationHeroList(newTeamId)
        formation.FormationManager.m_selectFormationHeroDic[oldTeamId] = newHeroList
        formation.FormationManager.m_selectFormationHeroDic[newTeamId] = oldHeroList

        local oldPetId = self:getManager():getPetIdByTeamId(oldTeamId)
        local newPetId = self:getManager():getPetIdByTeamId(newTeamId)
        formation.FormationManager:setUsePetByTeamId(oldTeamId, newPetId)
        formation.FormationManager:setUsePetByTeamId(newTeamId, oldPetId)

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
    self.mSelectIndex = nil
    self.mSelectBtn = nil
end

function onShowTeamBtnFrameHandler(self)
    if not self.mShowDragGoBg then
        self.mShowDragGoBg = gs.GameObject.Instantiate(self.mSelectBtn)
        local pos = self.mSelectBtn.transform.anchoredPosition
        gs.TransQuick:UIPos(self.mShowDragGoBg.transform, pos.x, pos.y)
        self.mShowDragGoBg.transform:SetParent(self.mGroupTeam.transform, false)
    end
    if self.mShowDragGoBg and not gs.GoUtil.IsGoNull(self.mShowDragGoBg) then
        local screenPos = gs.Vector3(gs.Input.mousePosition.x, gs.Input.mousePosition.y, gs.Input.mousePosition.z)
        local worldPos = gs.CameraMgr:ScreenToWorldByUICamera(screenPos)
        gs.TransQuick:PosXY(self.mShowDragGoBg.transform, worldPos.x, worldPos.y)
    end
end

-- 获取释放的替换队伍
function getShowCollision(self)
    if (self.mShowDragGoBg and not gs.GoUtil.IsGoNull(self.mShowDragGoBg)) then
        local uiPos = self.mShowDragGoBg.transform.anchoredPosition
        for index, btn in pairs(self.triggerList) do
            if self:isVisionTeamBtnVisible(index) then
                local slotSize = btn.transform.sizeDelta
                local slotUiPos = btn.transform.anchoredPosition
                if (uiPos.x >= slotUiPos.x - slotSize.x / 2 and uiPos.x <= slotUiPos.x + slotSize.x / 2 and uiPos.y >= slotUiPos.y - slotSize.y / 2 and uiPos.y <= slotUiPos.y + slotSize.y / 2) then
                    return index
                end
            end
        end
    end
end

function updateVisionTeamBtn(self)
    -- 队伍按钮数量由当前层的服务器真实关卡数决定（最多 3 支），
    -- 必须按层数去 getServerDupListByLayer 取实际关卡数，而不能用硬编码的 getAllTeamIdList()
    -- 层数优先从 VisionManager 取（点击 item 时写入），再兜底 getDataId() / data.dupId
    local layer = vision.VisionManager:getCurVisionLayer()
    if not layer then
        layer = self:getManager():getDataId()
    end
    local data = self:getManager():getData()
    if not layer and data and type(data) == "table" then
        layer = data.dupId
    end
    if not layer then
        -- 层数仍取不到，退化显示满 3 支，避免少显示/异常
        self.mGroupTeam:SetActive(true)
        for i = 1, #self.mTeamBtnList do
            self.mTeamBtnList[i]:SetActive(true)
            if self.mTeamNameList[i] then
                self.mTeamNameList[i].text = string.format("队伍%s", i)
            end
        end
        return
    end
    local dupList = vision.VisionManager:getServerDupListByLayer(layer)
    local count = math.min(#dupList, 3)
    if count <= 0 then
        count = 1
    end
    -- 只有一支队伍时无需切换，隐藏整个队伍按钮区域
    self.mGroupTeam:SetActive(count > 1)
    for i = 1, #self.mTeamBtnList do
        local isShow = i <= count
        self.mTeamBtnList[i]:SetActive(isShow)
        if self.mTeamNameList[i] then
            self.mTeamNameList[i].text = string.format("队伍%s", i)
        end
    end
end

function updateChangeTeamBtn(self, index)
    index = index or 1
    for i = 1, #self.mTeamSelectList do
        local isSelect = i == index
        self.mTeamSelectList[i]:SetActive(isSelect)
        self.mTeamNameList[i].color = gs.ColorUtil.GetColor(isSelect and "202226FF" or "FFFFFFFF")
    end
end

-- VISION 阵型需要展示“敌方信息”按钮。基类 __updateView 因 openFormation 传入的 data 为 nil
-- （无 battleType），会走到 else 分支把 mBtnEnemyInfo 隐藏，此处覆盖基类空钩子强制显示。
-- 点击走基类 onClickEnemyInfoHandler → getDupVo()（已按层数正确返回当前关卡的 stageVo）。
function updateChildCustom(self)
    self.mBtnEnemyInfo:SetActive(true)
end

function getVisionTeamIndexByTeamId(self, teamId)
    local teamList = self:getManager():getAllTeamIdList()
    for i, id in ipairs(teamList) do
        if id == teamId then
            return i
        end
    end
    return 1
end

function getDupVo(self)
    local data = self:getManager():getData()
    if data and type(data) == "table" and data.battleType == PreFightBattleType.Vision then
        -- 层数优先从 VisionManager 取（点击 item 时写入），再兜底 getDataId() / data.dupId
        local layer = vision.VisionManager:getCurVisionLayer()
        if not layer then
            layer = self:getManager():getDataId()
        end
        if not layer and data and type(data) == "table" then
            layer = data.dupId
        end
        local index = self:getVisionTeamIndexByTeamId(self.m_teamId)
        return vision.VisionManager:getVisionMirrorStageDataByLayerAndIndex(layer, index)
    end
    return super.getDupVo(self)
end

function __onClickBtnControlHandler(self)
    -- 校验本层所需参战队伍（数量由服务器真实关卡数决定，最多 3 支）是否都已上阵战员
    local layer = vision.VisionManager:getCurVisionLayer()
    if not layer then
        layer = self:getManager():getDataId()
    end
    local data = self:getManager():getData()
    if not layer and data and type(data) == "table" then
        layer = data.dupId
    end
    local dupList = vision.VisionManager:getServerDupListByLayer(layer)
    local needCount = math.min(#dupList, 3)
    if needCount <= 0 then
        needCount = 1
    end
    local teamIdList = self:getManager():getAllTeamIdList()
    for i = 1, needCount do
        local teamId = teamIdList[i]
        local heroList = teamId and self:getManager():getSelectFormationHeroList(teamId) or {}
        if not heroList or #heroList == 0 then
            gs.Message.Show(_TT(29119))
            return
        end
    end

    local count = self:getManager():getSelectFilterHeroCount(self.m_teamId)
    if count <= 0 then
        --gs.Message.Show(_TT(1284))
        gs.Message.Show(_TT(29119))
        return
    end

    local function run()
        self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, {})
        self:getManager():dispatchEvent(self:getManager().REQ_SET_FIGHT_TEAM, {
            teamId = self.m_teamId
        })
        self:forceClose()
        local dupVo = self:getDupVo()
        local data = self:getManager():getData()
        if data and type(data) == "table" and dupVo then
            data.dupId = dupVo.stageId
        end
        self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
        self:rsyncFormationList(true)
    end

    local dupVo = self:getDupVo()
    if dupVo and dupVo.suggestLevel then
        local recommandFight = dupVo.suggestLevel[2]
        if recommandFight == nil or recommandFight <= 0 then
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
            isShowTips = isShowTips or (count < (#dupVo.enemyList - sysParam.SysParamManager:getValue(SysParamType.FORMATION_TIP_OTHER_JUG)))
            if isShowTips then
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

return _M


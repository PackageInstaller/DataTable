--[[ 
-----------------------------------------------------
@filename       : FormationCodeHopePanel
@Description    : 代号·希望副本备战
@date           : 2021-05-12 17:00:47
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('fomation.FormationCodeHopePanel', Class.impl(formation.FormationPanel))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("formation/FormationDupCodeHopePanel.prefab")

destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁

function configUI(self)
    super.configUI(self)
    self.mImgDupInfo = self:getChildGO("mImgDupInfo"):GetComponent(ty.AutoRefImage)
    self.mTxtDupInfoTips = self:getChildGO("mTxtDupInfoTips"):GetComponent(ty.Text)
    self.mTxtDupInfoLimit = self:getChildGO("mTxtDupInfoLimit"):GetComponent(ty.Text)
    self.mTxtDupInfoStamina = self:getChildGO("mTxtDupInfoStamina"):GetComponent(ty.Text)
    self.mImgLimit = self:getChildGO("mImgLimit")
end

function deActive(self)
    super.deActive(self)
    if self.limitTween then
        self.limitTween:Kill()
        self.limitTween = nil
    end
end



-- 阵型瓦片点击事件
function __onClickFormationTileHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FORMATION_MOVE, true) == false then
        return
    end

    if args == nil then
        return
    end
    local dupVo = dup.DupCodeHopeManager:getDupVo(self:getManager():getData().dupId)
    local selectTidList = self:getManager():getMySelectHeroTidList(self.m_teamId)

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
        local list = self:getManager():getFormationHeroVoByPos(self.m_teamId, heroPos)

        if #selectTidList < dupVo.limitNum or list ~= nil then
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
                        TweenFactory:move2LPosX(self.mGroupMove, self.mGroupMove.localPosition.x - 270, 0.3, gs.DT.Ease.Linear)
                    end
                    local cameraTrans = gs.CameraMgr:GetDefSceneCameraTrans()
                    cameraTrans:DOLocalMove(gs.Vector3(2, 0, 0), 0.5)
                    self.m_selectMousePos = nil
                    self.m_goLine:SetActive(false)

                    self:getChildTrans("mGroupHeroInfo"):DOLocalMove(gs.Vector3(-254, 0, 0), 0.5)
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
        else
            gs.Message.Show(_TT(1362))
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

    self:getChildTrans("mGroupHeroInfo"):DOLocalMove(gs.Vector3(0, 0, 0), 0.5)
end

-- 更新超员提示
function updateLimitTips(self)
    local dupVo = dup.DupCodeHopeManager:getDupVo(self:getManager():getData().dupId)
    local selectTidList = self:getManager():getMySelectHeroTidList()
    if #selectTidList > dupVo.limitNum then
        self.mImgLimit:SetActive(true)
        self:__tweenLimit1()
    else
        self.mImgLimit:SetActive(false)
        if self.limitTween then
            self.limitTween:Kill()
            self.limitTween = nil
        end
    end
end
function __tweenLimit1(self)
    self.limitTween = TweenFactory:canvasGroupAlphaTo(self.m_childGos["mImgLimit"]:GetComponent(ty.CanvasGroup), 1, 0.3, 0.6, nil, function()
        self:__tweenLimit2()
    end)
end
function __tweenLimit2(self)
    self.limitTween = TweenFactory:canvasGroupAlphaTo(self.m_childGos["mImgLimit"]:GetComponent(ty.CanvasGroup), 0.3, 1, 0.6, nil, function()
        self:__tweenLimit1()
    end)
end

-- 更新界面
function __updateView(self, cusInit, isTween)
    if (self:isLoadFinish()) then
        local data = self:getManager():getData()
        if (data and type(data) == "table" and data.battleType) then
            if (data.battleType == PreFightBattleType.ArenaChallenge) then
                self.mBtnEnemyInfo:SetActive(false)

            elseif data.battleType == PreFightBattleType.MainMapStage or data.battleType ==
            PreFightBattleType.ClimbTowerDup or data.battleType == PreFightBattleType.RogueLike or data.battleType ==
            PreFightBattleType.DupApostle2War or data.battleType == PreFightBattleType.ElementTower then
                local lock, formationId = self:getManager():isLockFormation()
                self.mImgLock:SetActive(lock == 1)
            end
        else
            self.mBtnEnemyInfo:SetActive(false)
        end

        self:updateFightBtn()
        self:updateHeroOrMonster()
        -- 助战
        local nowNum = self:getManager():getAssistUnlockNum()
        local nowAssist = #self:getManager():getSelectTeamAssistHeroList(self.m_teamId)

        if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_ASSIST, false) == true and nowNum > 0) then
            self.mBtnAssist:SetActive(true)
            self:setBtnLabel(self.mBtnAssist, 1240, "助战 (" .. nowAssist .. "/" .. nowNum .. ")", nowAssist, nowNum)
        else
            self.mBtnAssist:SetActive(false)
        end

        self.isCanClickClose = true
        self.gBtnClose:SetActive(true)
        self.gBtnCloseAll:SetActive(false)

        cusInit = cusInit == nil and true or cusInit

        -- if cusInit then
        --     self:updateEleEff(true)
        --     self:updateLoopEleEff()
        -- end
        --初始化时清理掉之前的元素特效
        self.m_sceneController:closeEffLoopPrefab()

        self:__updateTeamList(cusInit)
        self:__updateFightPowerView(cusInit)
        self:__updateCaptain(cusInit)
        self:__updateMiniFormation(cusInit)
        self:__updateMapView()
        self:updatePosEff()
        self:updatePetItem()
        self:updateDupInfo()
        self:updateLimitTips()
        --延迟，因为从敌人阵型界面返回会不对
        self:setTimeout(0.2, function()
            self:__updateGuide()
            self:updateHeroStamina()
        end)
        self:updateChildCustom()
        if isTween == nil or isTween then
            self:teewnIndex()
        end
        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO) == false or
        funcopen.FuncOpenManager:isOpen(50219) == false then
            self.mBtnDevelop:SetActive(false)
        end
    end
end

-- 更新阵型格子图显示
function __updateMapView(self)
    local dupVo = dup.DupCodeHopeManager:getDupVo(self:getManager():getData().dupId)

    local formationHeroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
    local formationConfigVo = self:getManager():getFormationConfigVo(self.m_formationId)
    local formationConfigList = formationConfigVo:getFormationList()

    local isHasEmpty = #formationConfigList > #formationHeroList
    if (isHasEmpty) then
        local selectTidList = self:getManager():getMySelectHeroTidList()
        if (not self.m_myAllHeroTidList) then
            self.m_myAllHeroTidList = hero.HeroManager:getAllHeroTidList()
        end
        if (#selectTidList >= #self.m_myAllHeroTidList or #selectTidList >= dupVo.limitNum) then
            self.m_sceneController:setIsShowTipTile(false)
        else
            self.m_sceneController:setIsShowTipTile(true)
        end
    else
        self.m_sceneController:setIsShowTipTile(false)
    end

    local function allFinishCall()
        self:updateEleEff(true)
        self:updateLoopEleEff()
    end

    self.m_sceneController:setModelList(formationConfigList, formationHeroList, self.m_formationId, allFinishCall)
    self:updatePosEff()
end

-- 点击保存出战队列并且回调
function __onClickBtnControlHandler(self)
    local heroCount = 0
    local isEnough = true
    local dupVo = dup.DupCodeHopeManager:getDupData()[self:getManager():getData().dupId]
    local formationTileCount, row, col = self:getManager():getFormationTileCount()
    for col_x = 1, col do
        for row_y = 1, row do
            local tilePos = self:getManager():getFormationTilePos(self.m_formationId, col_x, row_y)
            self.tileFormationHeroVo = self:getManager():getFormationHeroVoByPos(self.m_teamId, tilePos)
            if self.tileFormationHeroVo then
                heroCount = heroCount + 1
                local heroStaminaInfo = dup.DupCodeHopeManager:getHeroInfo(dup.DupCodeHopeManager:getChapterByDupId(self:getManager():getData().dupId), self.tileFormationHeroVo.heroId)
                local dupIsPass = dup.DupCodeHopeManager:getDupIsPass(self:getManager():getData().dupId)
                if not dupIsPass and heroStaminaInfo.remaidCount < dupVo.needNum then
                    isEnough = false
                    break
                end
            end
        end
    end
    if heroCount > dupVo.limitNum then
        -- gs.Message.Show(string.format("本关限制出战人数为%s人", dupVo.limitNum, heroCount))
        gs.Message.Show(_TT(29117, dupVo.limitNum, heroCount))
        return
    end
    if not isEnough then
        -- gs.Message.Show("出战战员耐力不足")
        gs.Message.Show(_TT(29118))
        return
    end

    local count = self:getManager():getSelectFilterHeroCount(self.m_teamId)
    if (count <= 0) then
        gs.Message.Show(_TT(1284))
        gs.Message.Show(_TT(29119))
    else
        local function run()
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
                isShowTips = isShowTips or (count < (#self:getDupVo().enemyList - sysParam.SysParamManager:getValue(SysParamType.FORMATION_TIP_OTHER_JUG)))
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

function updateHeroStamina(self)
    self:recoverHeroStamina()
    local dupIsPass = dup.DupCodeHopeManager:getDupIsPass(self:getManager():getData().dupId)
    if dupIsPass then
        -- 已通关不显示
        return
    end
    local dupVo = dup.DupCodeHopeManager:getDupVo(self:getManager():getData().dupId)

    local formationTileCount, row, col = self:getManager():getFormationTileCount()
    for col_x = 1, col do
        for row_y = 1, row do
            local tilePos = self:getManager():getFormationTilePos(self.m_formationId, col_x, row_y)
            self.tileFormationHeroVo = self:getManager():getFormationHeroVoByPos(self.m_teamId, tilePos)
            if self.tileFormationHeroVo then
                local heroStaminaInfo = dup.DupCodeHopeManager:getHeroInfo(dup.DupCodeHopeManager:getChapterByDupId(self:getManager():getData().dupId), self.tileFormationHeroVo.heroId)

                local worldPos = self.m_sceneController:getTileWorldPos(col_x, row_y)
                local pos = gs.CameraMgr:World2CameraUI01(gs.CameraMgr:GetDefSceneCamera(), gs.CameraMgr:GetUICamera(), worldPos, self:getChildTrans("mGroupHeroInfo"), nil)
                local item = SimpleInsItem:create(self:getChildGO("GroupHeroStaminaItem"), self:getChildTrans("mGroupHeroInfo"))
                -- if heroStaminaInfo.remaidCount >= dupVo.needNum then
                --     -- item:setText("mTxtCont", nil, string.format("耐力：%s/%s", heroStaminaInfo.remaidCount, heroStaminaInfo.maxCount))
                --     item:setText("mTxtCont", nil, _TT(29120, heroStaminaInfo.remaidCount, heroStaminaInfo.maxCount))
                --     item:getChildGO("mImgProBar"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor("26D5D3FF")
                -- else
                --     -- item:setText("mTxtCont", nil, string.format("耐力：<color='#ed1941'>%s</color>/%s", heroStaminaInfo.remaidCount, heroStaminaInfo.maxCount))
                --     item:setText("mTxtCont", nil, _TT(29121, heroStaminaInfo.remaidCount, heroStaminaInfo.maxCount))
                --     item:getChildGO("mImgProBar"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor("d52628FF")
                -- end
                item:setText("mTxtCont", nil, _TT(29120, heroStaminaInfo.remaidCount, heroStaminaInfo.maxCount))

                local pro = heroStaminaInfo.remaidCount / heroStaminaInfo.maxCount
                if pro > 0.6 then
                    -- item:setText("mTxtCont", nil, string.format("耐力：%s/%s", heroStaminaInfo.remaidCount, heroStaminaInfo.maxCount))
                    item:getChildGO("mImgProBar"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor("41E268FF")
                elseif pro <= 0.6 and pro > 0.2 then
                    item:getChildGO("mImgProBar"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor("F4CB38FF")
                else
                    item:getChildGO("mImgProBar"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor("FF3758FF")
                end

                item:getChildTrans("mImgProBar"):GetComponent(ty.Image).fillAmount = pro
                -- gs.TransQuick:ScaleX(item:getChildTrans("mImgProBar"), pro)
                gs.TransQuick:UIPos(item:getTrans(), pos.x, pos.y + 200)
                table.insert(self.mHeroStaminaList, item)
            end

        end
    end
end

function recoverHeroStamina(self)
    if self.mHeroStaminaList then
        for i, v in ipairs(self.mHeroStaminaList) do
            v:poolRecover()
        end
    end
    self.mHeroStaminaList = {}
end

function updateDupInfo(self)
    local allLvl = 0
    local formationTileCount, row, col = self:getManager():getFormationTileCount()
    for col_x = 1, col do
        for row_y = 1, row do
            local tilePos = self:getManager():getFormationTilePos(self.m_formationId, col_x, row_y)
            self.tileFormationHeroVo = self:getManager():getFormationHeroVoByPos(self.m_teamId, tilePos)
            if self.tileFormationHeroVo then
                local heroVo = hero.HeroManager:getHeroVo(self.tileFormationHeroVo.heroId)
                if heroVo then
                    allLvl = allLvl + heroVo.lvl
                end
            end
        end
    end
    local type = 1
    local data = self:getManager():getData()
    local dupVo = dup.DupCodeHopeManager:getDupData()[data.dupId]
    local rate = allLvl / dupVo.levelRequire
    local num_1 = sysParam.SysParamManager:getValue(SysParamType.CODE_HOPE_DANGER_NUM_1) / 10000 -- 8000
    local num_2 = sysParam.SysParamManager:getValue(SysParamType.CODE_HOPE_DANGER_NUM_2) / 10000 -- 5000

    if rate <= num_2 then
        type = 3
    elseif rate > num_2 and rate <= num_1 then
        type = 2
    else
        type = 1
    end

    self.mImgDupInfo:SetImg(UrlManager:getPackPath(string.format("dupCodeHope/dupCodeHope_%s.png", 31 + type)))
    if type == 1 then
        self.mTxtDupInfoTips.text = _TT(29122) -- "系统判断您当前的上阵队员<color='#26d5d3'>实力良好</color>"
    elseif type == 2 then
        self.mTxtDupInfoTips.text = _TT(29123) -- "系统判断您当前的上阵队员<color='#ffd481'>实力稍弱</color>"
    else
        self.mTxtDupInfoTips.text = _TT(29124) -- "系统判断您当前的上阵队员<color='#ed1941'>实力偏弱</color>"
    end
    -- self.mTxtDupInfoLimit.text = string.format("限制出战人数：%s人", dupVo.limitNum)
    self.mTxtDupInfoLimit.text = _TT(29125, dupVo.limitNum)

    local dupIsPass = dup.DupCodeHopeManager:getDupIsPass(self:getManager():getData().dupId)

    -- self.mTxtDupInfoStamina.text = string.format("关卡扣除耐力：%s", dupIsPass == false and dupVo.needNum or 0)
    self.mTxtDupInfoStamina.text = _TT(29126, dupIsPass == false and dupVo.needNum or 0)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
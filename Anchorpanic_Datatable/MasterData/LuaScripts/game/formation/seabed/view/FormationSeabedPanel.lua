
module('fomation.FormationSeabedPanel', Class.impl(formation.FormationPanel))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("formation/FormationSeabedPanel.prefab")

destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁

function configUI(self)
    super.configUI(self)
end

function active(self, args)
    super.active(self, args)
    GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_TOP_PANEL)
    self.isDefFormation = seabed.SeabedManager:getIsDefFormation()
    if self.isDefFormation then
        self.mBtnEnemyInfo:SetActive(true)
        self.mBtnControl:SetActive(true)
        self.mRecommandLv:SetActive(true)
    else
        self.mBtnEnemyInfo:SetActive(false)
        self.mBtnControl:SetActive(false)
        self.mRecommandLv:SetActive(false)
    end

    -- self:setTimeout(0.2, function()
    --     --self:__updateGuide()
    --     self:updateHeroStamina()
    -- end)

    --self:updateHeroStamina()
end

-- 打开培养界面
function __onClickDevelopHandler(self, args)
    if self.mIsSelectHero then
        return
    end

    GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_TOP_PANEL)

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

-- 更新阵型格子图显示
function __updateMapView(self)
    local formationHeroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
    local formationConfigVo = self:getManager():getFormationConfigVo(self.m_formationId)
    local formationConfigList = formationConfigVo:getFormationList()
 
    
    
    local isHasEmpty = #formationHeroList < #seabed.SeabedManager:getHeroList()
    if (isHasEmpty) then
        local selectTidList = self:getManager():getMySelectHeroTidList()
        if (not self.m_myAllHeroTidList) then
            self.m_myAllHeroTidList = hero.HeroManager:getAllHeroTidList()
        end
        if (#selectTidList >= #self.m_myAllHeroTidList) then
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
        self:updateHeroStamina()
    end

    self.m_sceneController:setModelList(formationConfigList, formationHeroList, self.m_formationId, allFinishCall)
    self:updatePosEff()
end

function updatePosEff(self)
    super.updatePosEff(self)
    --self:updateHeroStamina()
end

function deActive(self)
    super.deActive(self)
    self:recoverHeroStamina()
end

-- 阵型瓦片点击事件
function __onClickFormationTileHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FORMATION_MOVE, true) == false then
        return
    end

    if args == nil then
        return
    end
    --local dupVo = dup.DupCodeHopeManager:getDupVo(self:getManager():getData().dupId)
    local selectTidList = self:getManager():getMySelectHeroTidList(self.m_teamId)

    --local isLock, id = self:getManager():getFormationTileLock(self.m_formationId, args.col, args.row)


    if (self:isLoadFinish() and not self.mTweening) then
        local colIndex = args.col
        local rowIndex = args.row
        -- 获取配置里的可以上阵的格子次序位置
        local heroPos = self:getManager():getFormationTilePos(self.m_formationId, colIndex, rowIndex)
        local list = self:getManager():getFormationHeroVoByPos(self.m_teamId, heroPos)

        --if list ~= nil then
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
        -- else
        --     gs.Message.Show(_TT(1362))
        --end
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

function updateHeroStamina(self)
    self:recoverHeroStamina()

    local formationTileCount, row, col = self:getManager():getFormationTileCount()
    for col_x = 1, col do
        for row_y = 1, row do
            local tilePos = self:getManager():getFormationTilePos(self.m_formationId, col_x, row_y)
            self.tileFormationHeroVo = self:getManager():getFormationHeroVoByPos(self.m_teamId, tilePos)
            if self.tileFormationHeroVo then
                local rate = seabed.SeabedManager:getHpRate(self.tileFormationHeroVo.heroId)

                local worldPos = self.m_sceneController:getTileWorldPos(col_x, row_y)
                local pos = gs.CameraMgr:World2CameraUI01(gs.CameraMgr:GetDefSceneCamera(), gs.CameraMgr:GetUICamera(), worldPos, self:getChildTrans("mGroupHeroInfo"), nil)
                local item = SimpleInsItem:create(self:getChildGO("GroupHeroStaminaItem"), self:getChildTrans("mGroupHeroInfo"),"seabedHeroInfoItem")

                item:setText("mTxtCont", nil, rate.."%")

                local pro = rate / 100
                if pro >= 0.6 then
                    -- item:setText("mTxtCont", nil, string.format("耐力：%s/%s", heroStaminaInfo.remaidCount, heroStaminaInfo.maxCount))
                    item:getChildGO("mImgProBar"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor("31f860FF")
                elseif pro > 0.2 and pro < 0.6 then
                    item:getChildGO("mImgProBar"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor("d1bc39FF")
                else
                    item:getChildGO("mImgProBar"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor("e6526cFF")
                end

                item:getChildTrans("mImgProBar"):GetComponent(ty.Image).fillAmount = pro
                -- gs.TransQuick:ScaleX(item:getChildTrans("mImgProBar"), pro)
                gs.TransQuick:UIPos(item:getTrans(), pos.x, pos.y + 200)
                table.insert(self.mHeroStaminaList, item)
            end

        end
    end
end

function updateHeroOrMonster(self)
    self:recoverHeadItems()
    local heroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
    self.mBtnDevelop:SetActive(#heroList > 0)

    self.mCount = sysParam.SysParamManager:getValue(SysParamType.HERO_LV_UP_RED_ASTRICT)[1]
    self.mNeedLvl = sysParam.SysParamManager:getValue(SysParamType.HERO_LV_UP_RED_ASTRICT)[2]
    self.mCurrentCount = 0

    for k, v in pairs(heroList) do
        local heroVo = hero.HeroManager:getHeroVo(v.heroId)
        if heroVo then
            local rate = seabed.SeabedManager:getHpRate(heroVo.id)
            local heroConfigVo = hero.HeroManager:getHeroConfigVo(v:getHeroTid())
            local item = SimpleInsItem:create(self:getChildGO("mShowItem"), self.mHeroDevelopNode, "FormationPanelSeabedheroShowItem")
            self:setGuideTrans("funcTips_formation_item_" .. v:getHeroTid(), item:getTrans())
            item:setArgs(v)
            item:getChildGO("mImgHeroEleType"):SetActive(false)
            item:getChildGO("mTxtLv"):SetActive(true)
            item:getChildGO("mImgBossBg"):SetActive(false)
            item:getChildGO("mImgSelect"):SetActive(false)
            item:getChildGO("mGroupHero"):SetActive(true)
            item:getChildGO("mGroupStatr"):SetActive(heroVo.evolutionLvl > 0)
            item:getChildGO("mHerotype"):SetActive((heroConfigVo.eleType ~= nil))
            item:getChildGO("mTxtHeroName"):GetComponent(ty.Text).text = heroConfigVo.name
            item:getChildGO("mTxtLv"):GetComponent(ty.Text).text = HtmlUtil:colorAndSize("Lv", "FFFFFF", 14) .. heroVo.lvl
            item:getChildGO("mIconHead"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getFormationHeadUrl(heroVo:getHeroModel()), true)
            item:getChildGO("mHerotype"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getHeroEleTypeIconUrl2(heroConfigVo.eleType), true)
            item:getChildGO("mIconProfession"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getHeroJobSmallIconUrl(heroConfigVo.professionType), true)

            local imgProBar = item:getChildGO("mImgProBar"):GetComponent(ty.Image)
            imgProBar.fillAmount = rate / 100
            
            if rate >= 60 then
                imgProBar.color = gs.ColorUtil.GetColor("31f860FF")
            elseif rate > 20 and rate < 60 then
                imgProBar.color = gs.ColorUtil.GetColor("d1bc39FF")
            else
                imgProBar.color = gs.ColorUtil.GetColor("e6526cFF")
            end
            item:getChildGO("mTxtCont"):GetComponent(ty.Text).text = rate.."%"
            item:getChildGO("mHeroStaminaItem"):SetActive(true)

            item:addUIEvent(nil, function()
                self:__onClickDevelopHandler(v.heroId)
            end)
            local color = '2e95ffff'
            if heroVo.color == 3 then --  精英
                color = 'ff72f1ff' -- 紫色
            elseif heroVo.color == 4 then -- 首领
                color = 'ff9e35ff' -- 橙色
            end
            item:getChildGO("mImgColorBar"):GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(color)
            local curIntegers = heroVo.evolutionLvl
            for i = 1, curIntegers do
                local starItem = SimpleInsItem:create(item:getChildGO("mStar"), item:getChildTrans("mGroupStatr"), "FormationPanelmStar")
                starItem:getGo():GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0048.png"), true)
                table.insert(self.mStarItemList, starItem)
            end
            if self:getViewType() <= 1 then
                self:updateFightEleState(heroConfigVo.eleType)
            end
            table.insert(self.mItemList, item)
        end
    end

    self:updateTeamFlag()
end

function recoverHeroStamina(self)
    if self.mHeroStaminaList then
        for i, v in ipairs(self.mHeroStaminaList) do
            v:poolRecover()
        end
    end
    self.mHeroStaminaList = {}
end

function __playerClose(self)
    super.__playerClose(self)
    if self.isDefFormation then
        GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_ALL_PANEL)
    end
    
end

return _M
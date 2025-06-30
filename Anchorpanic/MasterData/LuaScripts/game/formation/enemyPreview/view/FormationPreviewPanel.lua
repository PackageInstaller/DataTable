--[[ 
-----------------------------------------------------
@filename       : MainMapStageAwardItem
@Description    : 主线阶段性奖励
@date           : 2022-11-23 17:27:35
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("formation.FormationPreviewPanel", Class.impl(formation.FormationPanel))

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.HeroTeam)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.m_formationName = UrlManager:getUIPrefabPath("formation/FormationScene3.prefab")
    self.mItemList = {}
    self.mMinHight = 86.62
    self.mMaxHight = 186.83
    self.mDetailWeaknessGrid = {}
    self.mSkillGridList = {}
    self.mWeaknessGridList = {}
    self.frameSnList = {}
end

function configUI(self)
    super.configUI(self)
    self.mSkillItem = self:getChildGO("mSkillItem")
    self.mWeakness = self:getChildTrans("mWeakness")
    self.mEnemyInfoTips = self:getChildGO("EnemyInfoTips")
    self.mIconSkillNode = self:getChildTrans("mIconSkillNode")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTitleBg = self:getChildGO("mTitleBg"):GetComponent(ty.Image)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtInfoDesc = self:getChildGO("mTxtInfoDesc"):GetComponent(ty.Text)
    self.mTxtSkillDesc = self:getChildGO("mTxtSkillDesc"):GetComponent(ty.Text)
    self.mTxtAttackStyle = self:getChildGO("mTxtAttackStyle"):GetComponent(ty.Text)
    self.mImgMonsterHead = self:getChildGO("mImgMonsterHead"):GetComponent(ty.AutoRefImage)
    self.mTweenInfoTips = self.mEnemyInfoTips:GetComponent(ty.UIDoTween)

    self:setGuideTrans("funcTips_guide_HeroDevelopNode", self:getChildTrans("mHeroDevelopNode"))
end

-- 设置文本标题
function setTxtTitle(self, title)
    super.setTxtTitle(self, title)
    self:setGuideTrans("funcTips_guide_formation_MonsterBtnClose", self.gBtnClose.transform)
end

function getManager(self)
    return self.m_manager
end

function setManager(self, cusManager)
    self.m_manager = cusManager
end

function active(self, args)
    formation.FormationPreviewManager:setSelectMonster(nil)
    self:setManager(args.manager)
    self.closeCallBack = args.closeCallBack
    Perset3dHandler:setupShowData(MainCityConst.ROLE_MODE_FORMATION, nil, nil, "")
    self.mDupVo = args.data.dupVo
    super.active(self, args)
    MoneyManager:setMoneyTidList()
    TextureCameraHandler:open()
    gs.RenderSettings.fog = false
    self.IS_CHECK_FOR_CLOSE = true
    gs.CameraMgr:GetDefSceneCamera().gameObject:SetActive(true)
    formation.FormationPreviewManager:addEventListener(formation.FormationPreviewManager.CHANGE_SELECT,
    self.selectAndOpenDetail, self)
    self.mBtnEnemyInfo:SetActive(false)
    local camera = gs.CameraMgr:GetDefSceneCamera()
    self.flipComponent = camera:GetComponent(ty.FlipCameraComponent)
    self.flipComponent:SetFlipHorizontal(true)
    self.mArrowLeft:SetActive(false)
    self.mArrowRight:SetActive(false)
    self.mEnemyInfoTips:SetActive(false)
    self.mGroupMove.gameObject:SetActive(false)
end

function deActive(self)
    super.deActive(self)
    self:recoverHeadItems()
    self:recoverDetailGrid()
    formation.FormationPreviewManager:setSelectMonster(nil)
    MoneyManager:setMoneyTidList()
    gs.RenderSettings.fog = true
    formation.FormationPreviewManager:removeEventListener(formation.FormationPreviewManager.CHANGE_SELECT,
    self.selectAndOpenDetail, self)
    local camera = gs.CameraMgr:GetDefSceneCamera()
    self.flipComponent = camera:GetComponent(ty.FlipCameraComponent)
    self.flipComponent:SetFlipHorizontal(false)
end

function getViewType(self)
    return 2
end

function initViewText(self)
    super.initViewText(self)
    self.mTxtRecommand.text = "推荐阵容"
    self:getChildGO("mTxtTitle"):GetComponent(ty.Text).text = "首领"
    self:getChildGO("mTxtBaseInfo"):GetComponent(ty.Text).text = "基本信息"
    self:getChildGO("mTxtSkill"):GetComponent(ty.Text).text = "技能"
    self:getChildGO("mTxtDes"):GetComponent(ty.Text).text = "简介"
    self:getChildGO("mTxtAttack"):GetComponent(ty.Text).text = "攻击方式："
    self:getChildGO("mTxtWeakness"):GetComponent(ty.Text).text = "弱点："
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mClearDetail, self.hideDetail)
end

function selectAndOpenDetail(self)
    self:updateSelect()
    self:showDetail()
end

-- 检测更新界面
function __checkUpdateView(self)
    self.m_sceneController = formation.FromtionPreviewController
    self.m_sceneController:setManager(self:getManager())
    local __finishCall = function()
        self:__updateView()
    end
    self.m_sceneController:enterMap("enemyMap", self:__getBgURL(), __finishCall)
end

function getDupVo(self)
    return self.mDupVo
end

function onRestoreArrowHandler(self, isExpansion)
end

-- 玩家点击关闭
function onClickClose(self)
    self:__closeOpenAction()
    if self.closeCallBack then
        self.closeCallBack()
    end
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    if self.mNavigation then
        self.mNavigation:onCloseAllFinish()
    end
    self:close()
end

function close(self)
    super.close(self)
end

function onRestoreHandler(self, isInit)
    self.mBtnDevelop:SetActive(false)
    self:updateFormationList()
end

function updatePosEff(self)
    self:clearEffPrefab()
    local dupVo = self:getDupVo()
    if dupVo ~= nil and dupVo.posEffectId and #dupVo.posEffectId > 0 then


        self.posEffectIds = dupVo.posEffectId
        self.heroEffId = dupVo.posEffectId[1]
        self.enemyEffId = dupVo.posEffectId[2]
        local camera = gs.CameraMgr:GetDefSceneCamera()
        -- self.flipComponent = camera:GetComponent(ty.FlipCameraComponent)
        -- self.flipComponent:SetFlipHorizontal(false)

        if not table.empty(self.posEffectIds) then
            self:updatePosEffPrefab()
        end
        self.mBtnPosEff:SetActive(true)
    else
        self.mBtnPosEff:SetActive(false)
    end
end

function updatePosEffPrefab(self)
    for i, id in ipairs(self.posEffectIds) do
        local posEffVo = self:getManager():getPosEffConfigData(id)
        if posEffVo.size == 2 and posEffVo.posList[1] ~= 0 then
            for i = 1, #posEffVo.posList do
                local parentTrans = self.m_sceneController:getDeactiveTile(posEffVo.col[i], posEffVo.row[i]).transform

                local effPrefab = AssetLoader.GetGO(UrlManager:get3DBuffPath(posEffVo.mEffectPrefabIcon[i]))
                effPrefab.transform:SetParent(parentTrans, false)

                local isEmpty = formation.FormationSceneController:isEmpty(posEffVo.col[i], posEffVo.row[i])

                local renderArray = gs.GoUtil.GetRendererComsInChildren(effPrefab)
                local len = renderArray.Length - 1
                for i = 0, len do
                    local materials = renderArray[i].materials
                    local materialLen = materials.Length - 1
                    for i = 0, materialLen do
                        materials[i]:SetColor("_TintColor", isEmpty and gs.COlOR_GREY or gs.COlOR_WHITE)
                    end
                end

                if isEmpty == false then
                    local effBuffPrefab = AssetLoader.GetGO(UrlManager:get3DBuffPath(posEffVo.mEffectPrefabBuff[i]))
                    effBuffPrefab.transform:SetParent(parentTrans, false)
                    table.insert(self.mHasHeroEffList, effBuffPrefab)
                end

                table.insert(self.mDefPosEffList, effPrefab)
            end
        end
    end
    -- end
end

function onClickPosEffInfoHandler(self)
    self:getManager():dispatchEvent(self:getManager().OPEN_FORMATION_POSEFF, {
        posEffIds = self.posEffectIds,
        manager = self:getManager()
    })
    self.mEleTipGroup:SetActive(false)
    self.mBtnCloseFormation:SetActive(false)
end

-- 更新界面
function updateHeroOrMonster(self)
    self:recoverHeadItems()
    local monsterLst = self.mDupVo.enemyList
    for k, v in pairs(monsterLst) do
        local monsterTidVo = monster.MonsterManager:getMonsterVo(v)
        local monsterConfigVo = monsterTidVo:getBaseConfig()
        if not monsterConfigVo then
            print("================怪物配置错误 tid：", v)
        end
        local item = SimpleInsItem:create(self:getChildGO("mMonsterItem"), self.mHeroDevelopNode, "MonsterPreviewItem")

        self:setGuideTrans("funcTips_guide_formation_MonsterPreviewItem_" .. k, item:getTrans())

        item:getChildGO("mTxtLv"):SetActive(true)
        item:getChildGO("mImgBossBg"):SetActive(true)
        item:getChildGO("mImgSelect"):SetActive(true)
        item:getChildGO("mGroupHero"):SetActive(false)
        item:getChildGO("mGroupStatr"):SetActive(false)
        -- item:getChildGO("mTxtHeroName"):SetActive(false)
        local imgMonster = item:getChildGO("mIconHead"):GetComponent(ty.AutoRefImage)
        local bgBoss = item:getChildGO("mImgBossBg"):GetComponent(ty.Image)
        local txtBoss = item:getChildGO("mTxtBoss"):GetComponent(ty.Text)
        local txtLvCount = item:getChildGO("mTxtLv"):GetComponent(ty.Text)
        local txtMonName = item:getChildGO("mTxtMonsterName"):GetComponent(ty.Text)
        local weeknessNode = item:getChildTrans("mShowWeakness")
        local colorBar = item:getChildGO("mImgColorBar"):GetComponent(ty.AutoRefImage)
        local select = item:getChildGO("mImgSelect")
        local imgEleType = item:getChildGO("mImgHeroEleType"):GetComponent(ty.AutoRefImage)
        local tween = item:getGo():GetComponent(ty.UIDoTween)

        local locationTxt = item:getChildGO("mTxtLocation"):GetComponent(ty.Text)
        LoopManager:addFrame(k, 1, self, function()
            tween:BeginTween()
        end)
        item:addUIEvent(nil, function()
            if (formation.FormationPreviewManager:getSelectMonster() == monsterTidVo.uniqueTid) then
                self:hideDetail()
            else
                formation.FormationPreviewManager:setSelectMonster(monsterTidVo.uniqueTid)
                self:updateSelect()
                self:showDetail()
            end
        end)
        select:SetActive(formation.FormationPreviewManager:getSelectMonster() == monsterTidVo.uniqueTid)
        imgMonster:SetImg(UrlManager:getFormationHeadUrl(monsterConfigVo:getShowModelld()), true)
        bgBoss.gameObject:SetActive(monsterConfigVo:getIsBoss() or monsterConfigVo:getIsElite())

        txtLvCount.text = HtmlUtil:colorAndSize("Lv", "FFFFFF", 14) .. monsterTidVo.lvl
        txtMonName.text = monsterConfigVo.name
        locationTxt.text = hero.getDefineName(monsterConfigVo.location)
        local url = ''
        -- 策划需求    怪物底色用color字段获取，怪物类型（首领、精英、小怪）用type字段获取   --主线查看 3-4 17:19
        bgBoss.color = monsterConfigVo:getIsElite() and gs.ColorUtil.GetColor("e259d4ff") or
        gs.ColorUtil.GetColor("d53529ff")
        txtBoss.text = monsterConfigVo:getIsElite() and "精英" or "首领"
        if monsterConfigVo.color == 3 then --  精英
            url = 'formation/formation_hero_03.png' -- 紫色
        elseif monsterConfigVo.color == 4 then -- 首领
            url = 'formation/formation_hero_02.png' -- 橙色
        else
            url = 'formation/formation_hero_05.png'
        end
        colorBar:SetImg(UrlManager:getPackPath(url), false)
        for i = 1, #monsterConfigVo.weak do
            local weakItem = SimpleInsItem:create(self.mImgEleBg, weeknessNode, "formationPreviewEleMonstergrid")
            weakItem:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getHeroEleTypeIconUrl(monsterConfigVo.weak[i]), true)
            table.insert(self.mWeaknessGridList, weakItem)
        end
        local eleType = monsterConfigVo.eleType
        if monsterConfigVo.eleType == 0 then
            url = "formation/combat_bz_zhiji.png"
        elseif monsterConfigVo.eleType == 1 then
            url = "formation/combat_bz_dian.png"
        elseif monsterConfigVo.eleType == 2 then
            url = "formation/combat_bz_huo.png"
        elseif monsterConfigVo.eleType == 3 then
            url = "formation/combat_bz_bing.png"
        elseif monsterConfigVo.eleType == 4 then
            url = "formation/combat_bz_yun.png"
        elseif monsterConfigVo.eleType == 5 then
            url = "formation/combat_bz_liang.png"
        end
        imgEleType:SetImg(UrlManager:getPackPath(url), true)
        imgEleType.gameObject:SetActive(true)
        table.insert(self.mItemList, {
            grid = item,
            id = v
        })
    end

    self:showDetail()
end

-- 更新阵型格子图显示
function __updateMapView(self)
    local formationListVo = formation.FormationManager:getMonFormationConfigVo(self.mDupVo.formationId).m_formationList
    local isHasEmpty = #formationListVo > #self.mDupVo.enemyList
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
    end
    self.m_sceneController:setModelList(formationListVo, self.mDupVo.enemyList, self.m_formationId, allFinishCall)
end

-- 更新界面
function __updateView(self, cusInit)
    if (self:isLoadFinish()) then
        local data = self:getManager():getData()
        if (data) then
            if (data.battleType == PreFightBattleType.ArenaChallenge) then
                self.mBtnEnemyInfo:SetActive(false)

            elseif data.battleType == PreFightBattleType.MainMapStage then
                local lock, formationId = self:getManager():isLockFormation()
                self.mImgLock:SetActive(lock == 1)
            end
        else
            self.mBtnEnemyInfo:SetActive(false)
        end
        self:updateFightBtn()
        self:updateHeroOrMonster()
        self.mBtnAssist:SetActive(false)
        self.isCanClickClose = true
        self.gBtnClose:SetActive(true)
        self.gBtnCloseAll:SetActive(false)

        cusInit = cusInit == nil and true or cusInit
        self:__updateFightPowerView(cusInit)
        self:__updateMapView()
        self:__updateGuide()

        self:updatePosEff()
        self.mBtnDevelop:SetActive(false)
        self.mScrollerSelect.gameObject:SetActive(false)
        self.mBtnControl:SetActive(false)
        self.mBtnElement:SetActive(false)
        self.mBtnFormation:SetActive(false)
    end
end

function __updateGuide(self)
    self:setGuideTrans("funcTips_guide_formation_MonsterName", self.mTxtName.transform)
    self:setGuideTrans("funcTips_guide_formation_MonsterAttackTips", self:getChildTrans("mGuideTips"))
end

function rsyncFormationList(self, isClearOther)

end

function showDetail(self)
    local selectId = formation.FormationPreviewManager:getSelectMonster()
    if (selectId == nil) then
        self.mEnemyInfoTips:SetActive(false)
        self.mClearDetail:SetActive(false)
        return
    end
    self:removeFrameList()
    self:recoverDetailGrid()
    local monsterVo = monster.MonsterManager:getMonsterVo(selectId):getBaseConfig()
    self.mImgMonsterHead:SetImg(UrlManager:getIconPath(monsterVo.boss_head), true)
    self.mTxtName.text = monsterVo.name
    if (monsterVo:getIsBoss() or monsterVo:getIsElite()) then
        self.mTitleBg.gameObject:SetActive(true)
        self.mTitleBg.color = monsterVo:getIsBoss() and gs.ColorUtil.GetColor("d53529ff") or
        gs.ColorUtil.GetColor("e259d4ff")
        self.mTxtTitle.text = monsterVo:getIsBoss() and "首领" or "精英"
    else
        self.mTitleBg.gameObject:SetActive(false)
    end

    self.mTxtAttackStyle.text = hero.getDefineName(monsterVo.location)
    -- weakness
    for i = 1, #monsterVo.weak do
        local item = SimpleInsItem:create(self.mImgEleBg, self.mWeakness, "elegridMonster")
        item:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage):SetImg(
        UrlManager:getHeroEleTypeIconUrl(monsterVo.weak[i]), true)
        -- self.mWeakness
        table.insert(self.mDetailWeaknessGrid, item)
    end

    local skillList = monsterVo.skillShowList or {}

    for k, v in pairs(skillList) do
        local skillVo = fight.SkillManager:getSkillRo(v)
        local skillItem = SimpleInsItem:create(self.mSkillItem, self.mIconSkillNode, "FormationPreviewPanelpreviewSkillItem")
        skillItem.skillId = v
        skillItem:getChildGO("mSkillIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(
        skillVo:getIcon()), false)
        skillItem:getChildGO("mTxtSkillName"):GetComponent(ty.Text).text = skillVo:getName()
        skillItem:getChildGO("mTxtType"):GetComponent(ty.Text).text = hero.getSkillDefineName(skillVo:getType())
        local richTxt = skillItem:getChildGO("mTxtSkillDesc"):GetComponent(ty.TMP_Text)
        local richTxtLink = self:getChildGO("mTxtSkillDesc"):GetComponent(ty.TextMeshProLink)
        richTxtLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
        richTxt.text = skillVo:getDesc()
        skillItem:getChildGO("Scroll View"):GetComponent(ty.ScrollRect).enabled = false
        local isCanOpen = false
        local isOpen = false
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mIconSkillNode)
        local skillDescHeight = skillItem:getChildTrans("mTxtSkillDesc").rect.size.y -
        skillItem:getChildTrans("mTxtSkillDesc").rect.size.y % 0.01
        local scrollheight = skillItem:getChildTrans("Scroll View").rect.size.y -
        skillItem:getChildTrans("Scroll View").rect.size.y % 0.01
        table.insert(self.frameSnList, LoopManager:addFrame(1, 3, self, function()
            gs.TransQuick:LPosY(self.mIconSkillNode.transform, 0)
            skillDescHeight = skillItem:getChildTrans("mTxtSkillDesc").rect.size.y -
            skillItem:getChildTrans("mTxtSkillDesc").rect.size.y % 0.01
            scrollheight = skillItem:getChildTrans("Scroll View").rect.size.y -
            skillItem:getChildTrans("Scroll View").rect.size.y % 0.01
            skillItem:getChildGO("mBtnShrink"):SetActive(skillDescHeight > scrollheight)
            skillItem:getChildGO("mBtnEnlarge"):SetActive(skillDescHeight > scrollheight)
            gs.TransQuick:SetRotation(skillItem:getChildTrans("mBtnShrink"), 0, 0, 0)
            isCanOpen = skillDescHeight > scrollheight
        end))
        gs.TransQuick:SizeDelta02(skillItem:getTrans(), self.mMinHight)
        skillItem:addUIEvent("mBtnEnlarge", function()
            if (isCanOpen and (not isOpen)) then
                isOpen = true
                gs.TransQuick:SizeDelta02(skillItem:getTrans(), self.mMaxHight)
                gs.TransQuick:SetRotation(skillItem:getChildTrans("mBtnShrink"), 0, 0, 180)
                LoopManager:addFrame(1, 3, self, function()
                    skillItem:getChildGO("Scroll View"):GetComponent(ty.ScrollRect).enabled = ((skillDescHeight >
                    skillItem:getChildTrans(
                    "Scroll View").rect
                    .size.y))
                end)
                return
            end
            if isOpen then
                if skillItem:getTrans().rect.size.y >= self.mMaxHight then
                    isOpen = false
                    gs.TransQuick:SizeDelta02(skillItem:getTrans(), self.mMinHight)
                    gs.TransQuick:SetRotation(skillItem:getChildTrans("mBtnShrink"), 0, 0, 0)
                    skillItem:getChildGO("Scroll View"):GetComponent(ty.ScrollRect).enabled = false
                end
                return
            end
        end)
        table.insert(self.mSkillGridList, skillItem)
    end

    self.mTxtInfoDesc.text = monsterVo.des
    self.mEnemyInfoTips:SetActive(true)
    self.mClearDetail:SetActive(true)
    if self.mTweenInfoTips then
        self.mTweenInfoTips:BeginTween()
    end
end

function removeFrameList(self)
    if self.frameSnList then
        for i, v in ipairs(self.frameSnList) do
            LoopManager:removeFrameByIndex(v)
        end
    end
    self.frameSnList = {}
end

function hideDetail(self)
    if (formation.FormationPreviewManager:getSelectMonster() ~= nil) then
        formation.FormationPreviewManager:setSelectMonster(nil)
        self:updateSelect()
        self.mEnemyInfoTips:SetActive(false)
        self.mClearDetail:SetActive(false)
        self:recoverDetailGrid()
    end
end

function updateSelect(self)
    for k, v in pairs(self.mItemList) do
        local select = v.grid:getChildGO("mImgSelect")
        select:SetActive(formation.FormationPreviewManager:getSelectMonster() == self.mDupVo.enemyList[k])
    end
end

-- function __onClickHeadHandler(self, data, duoVo, id)
--     TipsFactory:EnemyInfoTips({ dupVo = duoVo, selectId = id })
-- end

function recoverHeadItems(self)
    self:removeFrameList()
    for k, v in pairs(self.mItemList) do
        v.grid:poolRecover()
    end
    self.mItemList = {}
    if #self.mWeaknessGridList > 0 then
        for _, item in ipairs(self.mWeaknessGridList) do
            item:poolRecover()
            item = nil
        end
        self.mWeaknessGridList = {}
    end
end

function recoverDetailGrid(self)
    if #self.mDetailWeaknessGrid > 0 then
        for k, v in ipairs(self.mDetailWeaknessGrid) do
            self.mDetailWeaknessGrid[k]:poolRecover()
            self.mDetailWeaknessGrid[k] = nil
        end
        self.mDetailWeaknessGrid = {}
    end
    if #self.mSkillGridList > 0 then
        for k, v in ipairs(self.mSkillGridList) do
            self.mSkillGridList[k]:poolRecover()
            self.mSkillGridList[k] = nil
        end
        self.mSkillGridList = {}
    end
end

return _M
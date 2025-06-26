--[[
-----------------------------------------------------
@filename       : DupApostlesWarPanel
@Description    : 使徒之战
@date           : 2021-08-12 15:03:15
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostle_war.view.DupApostlesWarPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupApostleWar/DupApostlesWarPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShow3DBg = 1

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(52089))
    -- self:setBg("", false)
end

function initData(self)
    self.skillList = {}
    self.mTargetList = {}
    self.mDifficultyList = {}
    self.mAwardList = {}
    self.mEleTypeList = {}
    self.mChooseIndex = 1
    self.isOpenSelectDiff = false
end

-- 初始化
function configUI(self)
    self.mTxtNowDiff = self:getChildGO("mTxtNowDiff"):GetComponent(ty.Text)
    self.mTxtLevel = self:getChildGO("mTxtLevel"):GetComponent(ty.Text)
    self.mTxt = self:getChildGO("mTxt"):GetComponent(ty.Text)

    self.mTxtDifficulty = self:getChildGO("mTxtDifficulty"):GetComponent(ty.Text)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mBtnShop = self:getChildGO("mBtnShop")
    self.mBtnStage = self:getChildGO("mBtnStage")
    self.mNextAward = self:getChildTrans("mNextAward")
    self.mImgPro = self:getChildGO("mImgPro"):GetComponent(ty.Image)
    self.mTxtStageNum = self:getChildGO("mTxtStageNum"):GetComponent(ty.Text)

    self.mBossContent = self:getChildTrans("mBossContent")
    self.DupApostlesEnterItem = self:getChildGO("DupApostlesEnterItem")

    self.mDifficultySelect = self:getChildGO("mDifficultySelect")
    self.mTxtSelectDiff = self:getChildGO("mTxtSelectDiff"):GetComponent(ty.Text)
    self.mTxtSelectNum = self:getChildGO("mTxtSelectNum"):GetComponent(ty.Text)
    self.mImgOpen = self:getChildGO("mImgOpen")
    self.mImgClose = self:getChildGO("mImgClose")

    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtEnvironment = self:getChildGO("mTxtEnvironment"):GetComponent(ty.Text)
    self.mTxtTarget = self:getChildGO("mTxtTarget"):GetComponent(ty.Text)
    self.mTxtHero = self:getChildGO("mTxtHero"):GetComponent(ty.Text)
    self.mGroupSkill = self:getChildTrans("mGroupSkill")
    self.mGroupSkillItem = self:getChildGO("mGroupSkillItem")
    self.mGroupTarget = self:getChildTrans("mGroupTarget")
    self.mGroupTargetItem = self:getChildGO("mGroupTargetItem")
    self.mGroupHero = self:getChildTrans("mGroupHero") -- HeroHeadGrid
    self.mContent = self:getChildTrans("mContent")
    self.mDifficultyItem = self:getChildGO("mDifficultyItem")
    self.mBtnEnemyInfo = self:getChildGO("mBtnEnemyInfo")

    self.mTxtChallengeNum = self:getChildGO("mTxtChallengeNum"):GetComponent(ty.Text)
    self.mTxt = self:getChildGO("mTxt"):GetComponent(ty.Text)
    self.mBtnStage = self:getChildGO("mBtnStage")
    self.mTxtStageNum = self:getChildGO("mTxtStageNum"):GetComponent(ty.Text)
    self.mTxtAllStart = self:getChildGO("mTxtAllStart"):GetComponent(ty.Text)
    self.mBtnFight = self:getChildGO("mBtnFight")

    self.mBtnTrain = self:getChildGO("mBtnTrain")

    self.mTxtEmptySkill = self:getChildGO("mTxtEmptySkill")
    self.mTxtEmptyHero = self:getChildGO("mTxtEmptyHero")
    self.mModelPlayer = ModelScenePlayer.new()

    self.mReceive = self:getChildGO("Receive")
    self.mComplete = self:getChildGO("Complete")
    self.mAnimation = self.UITrans:GetComponent(ty.Animator)

    self.mNextAward = self:getChildTrans("mNextAward")
    self.mBtnCloseDiff = self:getChildGO("mBtnCloseDiff")

    self.mImgEleBg = self:getChildGO("mImgEleBg")
    self.mClick = self:getChildGO("mClick")

    self.mRichText = self.mTxtEmptySkill:GetComponent(ty.TMP_Text)
    self.mRichTextLink = self.mTxtEmptySkill:GetComponent(ty.TextMeshProLink)
    self.mRichTextLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)

    self:setGuideTrans("DupApostlesWarPanel_guide_2", self.mClick.transform)
    self:setGuideTrans("DupApostlesWarPanel_guide_3", self.mDifficultySelect.transform)
    self:setGuideTrans("DupApostlesWarPanel_guide_4", self:getChildTrans("mGuide_mask_4"))
    self:setGuideTrans("DupApostlesWarPanel_guide_5", self:getChildTrans("mGuide_mask_5"))
    self:setGuideTrans("DupApostlesWarPanel_guide_6", self:getChildTrans("mGuide_mask_6"))
    self:setGuideTrans("DupApostlesWarPanel_guide_7", self.mBtnFight.transform)

    self:setGuideTrans("funcTips_guide_dupApostlesWarPanel_1", self:getChildTrans("mGuideApostles1"))
    self:setGuideTrans("funcTips_guide_dupApostlesWarPanel_2", self:getChildTrans("mGuideApostles6"))
    self:setGuideTrans("funcTips_guide_dupApostlesWarPanel_3", self.mBtnStage.transform)
    self:setGuideTrans("funcTips_guide_dupApostlesWarPanel_4", self:getChildTrans("mGuideApostles2"))
    self:setGuideTrans("funcTips_guide_dupApostlesWarPanel_5", self:getChildTrans("mGuideApostles3"))
    self:setGuideTrans("funcTips_guide_dupApostlesWarPanel_6", self:getChildTrans("mGuideApostles4"))
    self:setGuideTrans("funcTips_guide_dupApostlesWarPanel_7", self:getChildTrans("mGuideApostles5"))
    self:setGuideTrans("funcTips_guide_dupApostlesWarPanel_8", self.mDifficultySelect.transform)
end

--激活
function active(self, args)
    super.active(self)
    MoneyManager:setMoneyTidList()

    GameDispatcher:addEventListener(EventName.UPDATE_DUP_APOSTLES_PANEL, self.onUpdateDataHandler, self)
    dup.DupApostlesWarManager:addEventListener(dup.DupApostlesWarManager.EVENT_DATA_UPDATE, self.onUpdateDataHandler, self)

    GameDispatcher:dispatchEvent(EventName.REQ_DUP_APOSTLES2_PANEL_INFO)

    self.isOpenSelectDiff = false
    -- self:onUpdateDataHandler()
    -- self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    dup.DupApostlesWarManager:removeEventListener(dup.DupApostlesWarManager.EVENT_DATA_UPDATE, self.onUpdateDataHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DUP_APOSTLES_PANEL, self.onUpdateDataHandler, self)
    self:recoverItem()
    self:recoverTargetItem()
    self:recoverModel(true)
    self:recoverAwardItem()
    self:recoverEnterItem()
    RedPointManager:remove(self.mBtnStage.transform)
    if self.timerId then
        LoopManager:removeTimerByIndex(self.timerId)
    end
    self.timerId = nil

    self.isInit = nil
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtEnvironment.text = _TT(3534)
    self.mTxtTarget.text = _TT(3535)
    self.mTxtHero.text = _TT(3536)
    self.mTxt.text = _TT(75009)

    self.mTxtEmptyHero:GetComponent(ty.Text).text = _TT(3538)
    -- self:setBtnLabel(self.mBtnStage, nil, "下一阶星级奖励")
    self:setBtnLabel(self.mBtnTrain, nil, "训练模式")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.onFight)
    self:addUIEvent(self.mBtnStage, self.onOpenReward)
    self:addUIEvent(self.mBtnTrain, self.onIntoTrain)
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
    self:addUIEvent(self.mBtnEnemyInfo, self.onEnemyInfo)
    self:addUIEvent(self.mDifficultySelect, self.onUpdateDiffView)
    self:addUIEvent(self.mBtnShop, self.onOpenShop)
    self:addUIEvent(self.mBtnCloseDiff, self.onClickCloseSelectDiff)
end

function onUpdateDataHandler(self)
    self.data = dup.DupApostlesWarManager:getPanelInfo()
    self.configVo = dup.DupApostlesWarManager:getClositerDataById(self.data.id)
    self.mBossData = self.data.bossList[dup.DupApostlesWarManager:getCurrentBossId()]

    -- self.isInit = false
    self:updateView()
end

function onOpenShop(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.ShopDupApostles})
end

function onEnemyInfo(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_PREVIEW, {dupVo = self.mDupConfigVo})
end

function onUpdateDiffView(self)
    self.isOpenSelectDiff = not self.isOpenSelectDiff
    self:updateSelectDiff()
end

function updateView(self)
    -- self.mTxtName.text = _TT(self.configVo.name[self.mBossData.id])
    self:updateBossList()
    self:updateSelectDiff()
    self.mTxtChallengeNum.text = self.configVo.challengeNum - self.data.challengeTimes
    local mDupData = self.mBossData.difficultyList[self.mChooseIndex]
    self.mDupConfigVo = dup.DupApostlesWarManager:getDupDataById(mDupData.id)
    local mCompletedList = mDupData.completedTarget

    local taskList = self.configVo.taskRewardList
    if (self.data.starNum < self.configVo.maxStar) then
        --策划要显示下一阶段的进度
        for i = 1, #taskList do
            if (taskList[i].star > self.data.starNum) then
                self.mTxtAllStart.text = taskList[i].star
                break
            end
        end
    else
        self.mTxtAllStart.text = self.configVo.maxStar
    end
    self.mTxtStageNum.text = self.data.starNum

    self:recoverAwardItem()
    local nextRewardVo = nil
    local hasGetList = self.data.receivedStarId
    local rewardVo = self.configVo.taskRewardList
    for k, v in pairs(rewardVo) do
        if (not table.indexof(hasGetList, v.id)) then
            nextRewardVo = v
            break
        end
    end
    if (nextRewardVo ~= nil) then
        for k, v in pairs(nextRewardVo.rewards) do
            local propsGrid = PropsGrid:createByData({tid = v[1], num = v[2], parent = self.mNextAward, scale = 1, showUseInTip = true})
            table.insert(self.mAwardList, propsGrid)
        end
    end
    self:updateDupInfo(mCompletedList)
    self:checkWeekEnd()
end

function updateBossList(self)
    self:recoverEnterItem()
    local bossList = self.data.bossList
    for i = 1, #self.data.bossList do
        local item = SimpleInsItem:create(self.DupApostlesEnterItem, self.mBossContent, "DupApostlesEnterItem")

        self:setGuideTrans("funcTips_apostles_item_" .. i, item:getTrans())

        local enterIcon = item:getChildGO("mEnterIcon"):GetComponent(ty.AutoRefImage)
        enterIcon:SetImg(UrlManager:getIconPath(self.configVo.bossImgList[bossList[i].id]))
        -- enterIcon:SetImg(UrlManager:getPackPath(bossList[i].bossImgList))
        local difficulty = item:getChildGO("mDifficultyPro"):GetComponent(ty.Image)
        local difficultyText = item:getChildGO("mTxtDifficultyNum"):GetComponent(ty.Text)
        local mTxtDiffAllCount = item:getChildGO("mTxtDiffAllCount"):GetComponent(ty.Text)
        local complete = item:getChildGO("mComplete")
        local txtName = item:getChildGO("mTxtName"):GetComponent(ty.Text)
        local select = item:getChildGO("mSelect")
        select:SetActive(bossList[i].id == dup.DupApostlesWarManager:getCurrentBossId())
        local completeNum = 0
        local allStarNum = 0
        for k = 1, #bossList[i].difficultyList do
            completeNum = completeNum + #bossList[i].difficultyList[k].completedTarget
            allStarNum = allStarNum + #dup.DupApostlesWarManager:getDupDataById(bossList[i].difficultyList[k].id).starList
        end
        txtName.text = _TT(self.configVo.name[bossList[i].id])
        difficultyText.text = completeNum
        mTxtDiffAllCount.text = allStarNum
        if (allStarNum == 0) then
            allStarNum = 1
        end
        difficulty.fillAmount = completeNum / allStarNum
        if completeNum >= allStarNum then
            complete:SetActive(true)
        else
            complete:SetActive(false)
        end

        local config = monster.MonsterManager:getMonsterVo(self.configVo.tidList[bossList[i].id]):getBaseConfig()
        for k, v in pairs(config.weak) do
            local eleItem = SimpleInsItem:create(self.mImgEleBg, item:getChildTrans("mWeakNode"), "WeakNode")
            local type = eleItem:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
            type:SetImg(UrlManager:getHeroEleTypeIconUrl(v), false)
            table.insert(self.mEleTypeList, eleItem)
        end

        item:addUIEvent(nil, function()
            dup.DupApostlesWarManager:setCurrentBossId(bossList[i].id)
            self.mBossData = bossList[i]
            self.isOpenSelectDiff = false
            self.isInit = false
            self:updateView()
            self.mAnimation:SetTrigger("show")
            -- self.selectData = bossList[i]
            -- GameDispatcher:dispatchEvent(EventName.OPEN_DUP_APOSTLES_WAR_PANEL, { bossData =  })
        end)
        table.insert(self.mEnterItemList, item)
    end
end

function updateSelectDiff(self)
    self:recoverDiffiItem()
    self.mImgClose:SetActive(not self.isOpenSelectDiff)
    self.mImgOpen:SetActive(self.isOpenSelectDiff)
    if (not self.isInit) then
        for i = #self.mBossData.difficultyList, 1, -1 do
            local dupData = self.mBossData.difficultyList[i]
            if (dupData.isUnlock ~= 0) then
                self.mChooseIndex = i
                break
            end
        end

        self.isInit = true
    end

    if (self.isOpenSelectDiff) then
        --难度列表
        for i = #self.mBossData.difficultyList, 1, -1 do
            local mDupData = self.mBossData.difficultyList[i]
            local mCompletedList = mDupData.completedTarget

            local item = SimpleInsItem:create(self.mDifficultyItem, self.mContent, "mDifficultyItem")
            local dupData = self.mBossData.difficultyList[i]
            local dupConfigVo = dup.DupApostlesWarManager:getDupDataById(dupData.id)
            local mBtnSelect = item:getChildGO("mBtnSelect")
            local startNum = item:getChildGO("mStarNum"):GetComponent(ty.Text)
            local mTxtNomal = item:getChildGO("mTxtNomal"):GetComponent(ty.Text)
            local lock = item:getChildGO("Lock")
            local complete = item:getChildGO("Complete")
            mTxtNomal.text = _TT(dupConfigVo.difficultyStep)
            if (dupData.isUnlock == 0) then
                lock:SetActive(true)
                startNum.gameObject:SetActive(false)
            else
                lock:SetActive(false)
                startNum.gameObject:SetActive(true)
            end

            local hasTarget = false
            for i = 1, #dupConfigVo.enemyList do
                hasTarget = false
                for j = 1, #mCompletedList do
                    if (dupConfigVo.enemyList[i] == mCompletedList[j]) then
                        hasTarget = true
                        break
                    end
                end
            end
            if (hasTarget) then
                complete:SetActive(true)
            else
                complete:SetActive(false)
            end

            local color = "ffffffff"
            if dupConfigVo.difficultyStep == 27159 then
                color = ColorUtil.BLUE_NUM
            elseif dupConfigVo.difficultyStep == 27160 then
                color = ColorUtil.PURPLE_NUM
            elseif dupConfigVo.difficultyStep == 27161 then
                color = ColorUtil.ORANGE_NUM
            elseif dupConfigVo.difficultyStep == 27167 then
                color = ColorUtil.ORANGE_NUM
            end

            if (self.mChooseIndex == i) then
                mBtnSelect:SetActive(true)
                startNum.text = #dupData.completedTarget .. "/" .. #dupConfigVo.starList
                startNum.color = gs.ColorUtil.GetColor(color)
                mTxtNomal.color = gs.ColorUtil.GetColor(color)
            else
                mBtnSelect:SetActive(false)
                startNum.text = #dupData.completedTarget .. "/" .. #dupConfigVo.starList
                startNum.color = gs.ColorUtil.GetColor(color)
                mTxtNomal.color = gs.ColorUtil.GetColor(color)
            end

            item:addUIEvent("mBtnNomal", function()
                if (dupData.isUnlock == 0) then
                    gs.Message.Show(_TT(3539))
                else
                    self.mChooseIndex = i
                    self:onClickCloseSelectDiff()
                end
            end)
            table.insert(self.mDifficultyList, item)
        end
    else
        local dupData = self.mBossData.difficultyList[self.mChooseIndex]
        local dupConfigVo = dup.DupApostlesWarManager:getDupDataById(dupData.id)
        self.mTxtSelectDiff.text = _TT(dupConfigVo.difficultyStep)
        self.mTxtSelectNum.text = #dupData.completedTarget .. "/" .. #dupConfigVo.starList

        local color = "ffffffff"
        if dupConfigVo.difficultyStep == 27159 then
            color = ColorUtil.BLUE_NUM
        elseif dupConfigVo.difficultyStep == 27160 then
            color = ColorUtil.PURPLE_NUM
        elseif dupConfigVo.difficultyStep == 27161 then
            color = ColorUtil.ORANGE_NUM
        elseif dupConfigVo.difficultyStep == 27167 then
            color = ColorUtil.ORANGE_NUM
        end
        self.mTxtSelectDiff.color = gs.ColorUtil.GetColor(color)
        self.mTxtSelectNum.color = gs.ColorUtil.GetColor(color)
    end
end

function updateDupInfo(self, completedList)
    self:updateModelView()
    self:updateTarget(self.mDupConfigVo.starList, completedList)
    self:updateSkill(self.mDupConfigVo.matrixList)
    self:updateRed()
    self:updateLockHero()
end

function onClickCloseSelectDiff(self)
    if (self.isOpenSelectDiff) then
        self.isOpenSelectDiff = false
        self:onUpdateDataHandler()

    end
end

function checkWeekEnd(self)
    if self.timerId then
        LoopManager:removeTimerByIndex(self.timerId)
        -- self.timerId = nil
    end
    local onTimer = function()
        if (dup.DupApostlesWarManager:getWeekEnd()) then
            self:closeAll()
        else
            local str, _ = dup.DupApostlesWarManager:getResetTimeStr()
            self.mTxtTime.text = str
        end
    end
    onTimer()
    self.timerId = LoopManager:addTimer(1, 0, self, onTimer)
end

-- 更新模型
function updateModelView(self)
    local id = self.mBossData.id
    local img = self.configVo.bossImgList[id]
    local model = self.configVo.bossModelList[id]
    if (model) then
        self.mModelPlayer:setModelData(model, true, false, 1, true, MainCityConst.APOSTLE_MONSTER_UI, UrlManager:getBgPath("dupApoWar/DE_bg_01.jpg"), nil, true, nil)
    else
        self:recoverModel(false)
    end
end

function recoverModel(self, isResetMaincity)
    self.mModelPlayer:reset(isResetMaincity)
end

-- 目标条件
function updateTarget(self, starList, completedList)
    self:recoverTargetItem()
    for i = 1, #starList do
        local item = SimpleInsItem:create(self.mGroupTargetItem, self.mGroupTarget, "mGroupTargetItem")
        local imgNoFin = item:getChildGO("mImgNotFin")
        local mImgFinish = item:getChildGO("mImgFinish")
        local txt = item:getChildGO("mTxtTarget"):GetComponent(ty.Text)
        txt.text = _TT(dup.DupApostlesWarManager:getStarDataById(starList[i]).des)

        local colorNum = "ffffffff"
        if not table.indexof(completedList, starList[i]) then
            imgNoFin:SetActive(true)
            mImgFinish:SetActive(false)
            colorNum = "c6d4e1ff"
        else
            imgNoFin:SetActive(false)
            mImgFinish:SetActive(true)

        end
        txt.color = gs.ColorUtil.GetColor(colorNum)
        table.insert(self.mTargetList, item)
    end
end

-- boss技能
function updateSkill(self, skillList)
    -- self:recoverItem()
    -- if (#skillList > 0) then
    --     self.mTxtEmptySkill:SetActive(false)
    --     for i, v in ipairs(skillList) do
    --         local skillVo = fight.SkillManager:getSkillRo(v)
    --         if skillVo:getType() ~= 0 then
    --             local item = SimpleInsItem:create(self.mGroupSkillItem, self.mGroupSkill, "GroupSkillItem")
    --             item:getChildGO("mImgSkill"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), false)

    --             local function openSpecialTip()
    --                 local skillVoList = {}
    --                 for i, v in ipairs(skillList) do
    --                     local skillVo = fight.SkillManager:getSkillRo(v)
    --                     table.insert(skillVoList, skillVo)
    --                 end
    --                 table.sort(skillVoList, function(a, b)
    --                     if a and b then
    --                         return a:getRefID() < b:getRefID()
    --                     end
    --                 end)
    --                 TipsFactory:SpecialEffectTips(skillVoList)
    --             end

    --             item:addUIEvent("mGroup", openSpecialTip)
    --             table.insert(self.skillList, item)
    --         end
    --     end
    -- else

    -- local skillId = sysParam.SysParamManager:getValue(SysParamType.DUO_APO_SKILLID)
    -- local skillRo = fight.SkillManager:getSkillRo(skillId)
    self.mRichText.text = _TT(self.mDupConfigVo.desc) --skillRo:getDesc()
    -- end
end

-- 锁定战员
function updateLockHero(self)
    self:recoverHeroItem()
    local lockList = self.mBossData.lockHeroList
    if #lockList == 0 then
        self.mTxtEmptyHero:SetActive(true)
    else
        self.mTxtEmptyHero:SetActive(false)
        for i = 1, #lockList do
            local heroConfigVo = hero.HeroManager:getHeroVo(lockList[i])
            local item = HeroHeadGrid:poolGet()
            item:setData(heroConfigVo)
            -- item:setScale(1.5)
            item:setParent(self.mGroupHero)
            table.insert(self.mHeroList, item)
        end
    end
end

function onFight(self)
    if (self.configVo.challengeNum - self.data.challengeTimes > 0) then
        local dupId = self.mBossData.difficultyList[self.mChooseIndex].id
        -- 计算被锁定的战员
        local lockList = {}
        for k, v in pairs(self.data.bossList) do
            if (v.id ~= self.mBossData.id) then
                local list = v.lockHeroList
                for i = 1, #list do
                    table.insert(lockList, list[i])
                end
            end
        end
        dup.DupApostlesWarManager.mIsTrain = false
        formation.checkFormationFight(PreFightBattleType.DupApostle2War, nil, dupId, formation.TYPE.DUP_APOSTLES, self.mBossData.id, {lockList})
    else
        gs.Message.Show(_TT(3540))
    end
end

--打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, {id = LinkCode.DupApostlesWarInfo})
end

function onIntoTrain(self)
    UIFactory:alertMessge(_TT(43105), true,
        function()
            dup.DupApostlesWarManager.mIsTrain = true
            local dupId = self.mBossData.difficultyList[self.mChooseIndex].id
            formation.checkFormationFight(PreFightBattleType.DupApostle2War, nil, dupId, formation.TYPE.DUP_APOSTLES, self.mBossData.id, {})
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, RemindConst.DUPAPO2TRAIN)
    end

    function onOpenReward(self)
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_APOSTLES_REWARD_PANEL)
    end

    -- 回收项
    function recoverItem(self)
        if self.skillList then
            for i, v in pairs(self.skillList) do
                v:poolRecover()
            end
        end
        self.skillList = {}
    end

    function recoverDiffiItem(self)
        if self.mDifficultyList then
            for i, v in pairs(self.mDifficultyList) do
                v:poolRecover()
            end
        end
        self.mDifficultyList = {}
    end

    function recoverAwardItem(self)
        if self.mAwardList then
            for i, v in pairs(self.mAwardList) do
                v:poolRecover()
            end
        end
        self.mAwardList = {}
    end

    -- 回收项

    function recoverEnterItem(self)
        for k, v in pairs(self.mEleTypeList) do
            v:poolRecover()
        end
        self.mEleTypeList = {}
        if self.mEnterItemList then
            for i, v in pairs(self.mEnterItemList) do
                LoopManager:clearTimeout(v.timerId)
                v.tweenId = nil
                v:poolRecover()
            end
        end
        self.mEnterItemList = {}
    end

    function recoverTargetItem(self)
        if self.mTargetList then
            for i, v in pairs(self.mTargetList) do
                v:poolRecover()
            end
        end
        self.mTargetList = {}
    end

    function recoverHeroItem(self)
        if self.mHeroList then
            for i, v in pairs(self.mHeroList) do
                v:poolRecover()
            end
        end
        self.mHeroList = {}
    end

    function updateRed(self)
        local isFlag = dup.DupApostlesWarManager:checkFlag()
        if isFlag then
            RedPointManager:add(self.mBtnStage.transform, nil, -124, 47)
            self.mReceive:SetActive(true)
        else
            RedPointManager:remove(self.mBtnStage.transform)
            self.mReceive:SetActive(false)
            if self.data.starNum >= self.configVo.maxStar then
                self.mComplete:SetActive(true)
            else
                self.mComplete:SetActive(false)
            end
        end
    end

    return _M

    --[[ 替换语言包自动生成，请勿修改！
语言包: _TT(3540):"当前挑战次数为0"
语言包: _TT(3539):"通关上一难度解锁"
语言包: _TT(3538):"-暂无锁定战员-"
语言包: _TT(3537):"-无异常环境-"
语言包: _TT(3531):"剩余挑战次数："
语言包: _TT(3536):"锁定战员"
语言包: _TT(3535):"关卡目标"
语言包: _TT(3534):"异常环境"
]]

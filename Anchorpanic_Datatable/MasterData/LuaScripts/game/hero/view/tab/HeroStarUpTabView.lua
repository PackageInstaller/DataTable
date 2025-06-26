module("hero.HeroStarUpTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("hero/tab/HeroStarUpTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mCheckLvHelper = -1
    self.mSkillGridList = {}
    self.mDelayStartView = nil
    self.mDelaySkillView = nil
    self.mDelayCostView = nil
    self.mDelayKV = nil
    self.mPostCheck = nil
    --当前选中的星级
    self.selectedIdx = 1
    --特效管理
    self.mEffectList = {}
    --点击管理 
    self.mClickStarDic = {}
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    self:playerClose()
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:playerClose()
end

function playerClose(self)
    self:recoveryAll()
end

function configUI(self)
    super.configUI(self)

    self.mGroupCost = self:getChildTrans("mGroupCost")
    self.mTransGuide_1 = self:getChildTrans("Guide_1")
    self.mBtnEvolution = self:getChildGO("mBtnEvolution")
    self.mBtnEvolution2 = self:getChildGO("mBtnEvolution2")
    self.mGroupCostMaterial = self:getChildGO("mGroupCostMaterial")
    self.mTxtSkillTips = self:getChildGO("mTxtSkillTips"):GetComponent(ty.Text)
    self.mImgNeedCost = self:getChildGO("mImgNeedCost"):GetComponent(ty.AutoRefImage)
    self.mTxtSkillNextTips = self:getChildGO("mTxtSkillNextTips"):GetComponent(ty.Text)
    self.mTxtSkillNextName = self:getChildGO("mTxtSkillNextName"):GetComponent(ty.TMP_Text)
    self.mTxtSkillNextNameLink = self:getChildGO("mTxtSkillNextName"):GetComponent(ty.TextMeshProLink)
    self.mTxtSkillNextNameLink:SetEventCall(notice.HrefUtil.commonTitleDesLinkData)
    self.mTxtSkillNextWarn = self:getChildGO("mTxtSkillNextWarn"):GetComponent(ty.Text)
    self.mTxtCostMateriall = self:getChildGO("mTxtCostMateriall"):GetComponent(ty.Text)
    self.mTextMaxStarTitle = self:getChildGO("mTextMaxStarTitle"):GetComponent(ty.Text)
    self.mTxtEvolution = self:getChildGO("mTxtEvolution"):GetComponent(ty.Text)
    self.mTxtEvolution2 = self:getChildGO("mTxtEvolution2"):GetComponent(ty.Text)
    self.mTxtActived = self:getChildGO("mTxtActived"):GetComponent(ty.Text)
    self.mTxtStarLv = self:getChildGO("mTxtStarLv"):GetComponent(ty.Text)
end

function updateGuide(self)
    self:setGuideTrans("weak_hero_straUp_1", self.mTransGuide_1)
    self:setGuideTrans("funcTips_starUp_1", self:getChildTrans("mGroupFuncTipsStarUp"))
    self:setGuideTrans("hero_starup_Btn", self.mBtnEvolution.transform)
end

function active(self, args)
    super.active(self, args)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateCostView, self)
    self:adjust3DModleByResolution()

    self:setData(args.heroId)
    self:updateGuide()
end

function deActive(self)
    super.deActive(self)
    -- self.isPlayLvAni = nil
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateCostView, self)
    self:recoveryAll()
    self:removeAllDelay()
    hero.HeroController:stopCurPlayCVData()

    if (self.scene) then
        self:unRegister3DClickEvent()
        UISceneBgUtil:reset()
        self.scene = nil
        self.m_senceChildGos, self.m_senceChildTrans = nil, nil
    end
end

function removeAllDelay(self)
    if (self.mDelayStartView) then
        LoopManager:removeFrameByIndex(self.mDelayStartView)
        self.mDelayStartView = nil
    end
    if (self.mDelayKV) then
        LoopManager:removeFrameByIndex(self.mDelayKV)
        self.mDelayKV = nil
    end
    if (self.mDelaySkillView) then
        LoopManager:removeFrameByIndex(self.mDelaySkillView)
        self.mDelaySkillView = nil
    end
    if (self.mDelayCostView) then
        LoopManager:removeFrameByIndex(self.mDelayCostView)
        self.mDelayCostView = nil
    end

    if self.mPostCheck then
        LoopManager:removeTimerByIndex(self.mPostCheck)
        self.mPostCheck = nil
    end
end

function initViewText(self)
    self.mTxtSkillTips.text = _TT(53509)--"特殊效果"
    self.mTxtCostMateriall.text = _TT(53510)--"消耗材料"
    self.mTxtEvolution.text = _TT(1042)--"升格"
    self.mTxtEvolution2.text = _TT(1042)--"升格"
    self.mTextMaxStarTitle.text = _TT(1055)--"已满级"
    self.mTxtActived.text = _TT(73)--"已激活"
    --"已激活"
end

function setData(self, cusHeroId)
    self.mClickStarDic = {}
    if self.m_curHeroId then
        self.isSameHero = self.m_curHeroId == cusHeroId
    end
    self.m_curHeroId = cusHeroId
    local heroVo = hero.HeroManager:getHeroVo(cusHeroId)

    if (heroVo:checkIsPreData()) then
        return
    else
        self.heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
        self.maxStarLvl = hero.HeroStarManager:getHeroMaxStarLvl(self.heroVo.tid)
        self.nextStarConfigVo = hero.HeroStarManager:getHeroStarConfigVo(self.heroVo.tid, self.heroVo.evolutionLvl + 1)
        if self.currentStarLvl then
            self.isLvUp = (self.heroVo.evolutionLvl - self.currentStarLvl > 0) and self.isSameHero

        end
        self.currentStarLvl = self.heroVo.evolutionLvl
        self.isMaxStar = self.maxStarLvl == self.currentStarLvl
        if self.nextStarConfigVo ~= nil then
            local costMoneyTid = self.nextStarConfigVo.cost[1]
            self.mImgNeedCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(costMoneyTid), true)
        end

        if self.isLvUp then
            self.isLvUp = false
            AudioManager:playSoundEffect("arts/audio/UI/basic/ui_upgrade02.prefab")
            self:addEffect(hero.StarUpEffect.Explode, self.m_senceChildTrans["mGroupItem_0" .. self.currentStarLvl])
            self:addEffect(hero.StarUpEffect.Actived, self.m_senceChildTrans["mGroupItem_0" .. self.currentStarLvl])
            self.mShowFXLvUp = LoopManager:setTimeout(1, nil, function()
                if self.mShowFXLvUp then
                    LoopManager:clearTimeout(self.mShowFXLvUp)
                end
                if self.mPostCheck then
                    self:recoverRayCast()
                    LoopManager:removeTimerByIndex(self.mPostCheck)
                    self.mPostCheck = nil
                end
                self:updateView()
            end)
        else
            self.m_childGos["mBtnOnShowFX"]:SetActive(false)
            hero.HeroManager:dispatchEvent(hero.HeroManager.BLOCK_GROUP_TOP_CLICK, true)
            self:updateView()
        end
    end
end

--根据分辨率调整模型位置 
function adjust3DModleByResolution(self)
    if not self.scene then
        self.scene = UISceneBgUtil:create3DBg("arts/sceneModule/ui_shengge/prefabs/ui_shengge_01.prefab")
        if self.scene then
            self.m_sceneAni = self.scene:GetComponent(ty.Animator)
            if not gs.GoUtil.IsCompNull(self.m_sceneAni) then
                self.m_sceneAni:SetTrigger("show")
            end
        end
        self.m_senceChildGos, self.m_senceChildTrans = GoUtil.GetChildHash(self.scene)
        self:register3DClickEvent()
        local mScreenRate = gs.Screen.height / gs.Screen.width
        if mScreenRate > 0.55 then
            gs.TransQuick:LPosZ(self.m_senceChildTrans["root"], 4.36)
        else
            gs.TransQuick:LPosZ(self.m_senceChildTrans["root"], 3.4)
        end
    end
end

--注册3d点击事件
function register3DClickEvent(self)
    if next(self.m_senceChildGos) then
        for i = 1, 6 do
            self.m_senceChildGos["mGroupItem_0" .. i]:GetComponent(ty.GoMouseEvent):SetCallFun(self, nil,
            function()
                if gs.UnityEngineUtil.GetRaycastUIResults(gs.Vector2(gs.UnityEngineUtil.GetMousePosX(),gs.UnityEngineUtil.GetMousePosY())).Count > 2 then 
                    return 
                end

                self:onStarClickedhandler(i)
            end, nil, nil)
        end
    end
end

--取消注册3d点击事件
function unRegister3DClickEvent(self)
    if next(self.m_senceChildGos) then
        for i = 1, 6 do
            self.m_senceChildGos["mGroupItem_0" .. i]:GetComponent(ty.GoMouseEvent):SetCallFun(self, nil, nil, nil, nil)
        end
    end
end

function updateView(self)
    self:recoveryAll()
    self:refreshText()
    self.mDelayStartView = LoopManager:addFrame(1, 1, self, self.updateStarView)
    self.mDelaySkillView = LoopManager:addFrame(2, 1, self, self.updateSkillView)
    self.mDelayCostView = LoopManager:addFrame(3, 1, self, self.updateCostView)

end

--更新星级显示
function updateStarView(self)
    -- self:recoverStarItemList()
    self:recoverAllEffect()
    for i = 1, self.maxStarLvl do
        if self.currentStarLvl >= i then
            self.m_senceChildGos["line_0" .. i]:SetActive(true)
            self:addEffect(hero.StarUpEffect.Actived, self.m_senceChildTrans["mGroupItem_0" .. i])
        else
            self.m_senceChildGos["line_0" .. i]:SetActive(false)
        end
    end
    if self.currentStarLvl > 0 and not self.isMaxStar then
        self:onStarClickedhandler(self.currentStarLvl + 1)
    end
    if self.isMaxStar then
        self:onStarClickedhandler(self.maxStarLvl)
    end
    if self.currentStarLvl < 1 then
        self:onStarClickedhandler(1)
    end

end

--点击星级回调
function onStarClickedhandler(self, idx)
    if self.mClickStarDic[idx] == nil then
        self.mClickStarDic[idx] = false
    end
    if self.mClickStarDic[idx] == false then
        for i = 1, 6 do
            if i == idx then
                self.mClickStarDic[i] = true
            else
                self.mClickStarDic[i] = false
            end
        end

        self.mTxtStarLv.text = _TT(1393, idx)
        self:removeEffect(hero.StarUpEffect.Selected)
        for i = 1, 6 do
            if idx == i then
                self:addEffect(hero.StarUpEffect.Selected, self.m_senceChildTrans["mGroupItem_0" .. i])
            end
        end
        if idx then
            self.selectedIdx = idx
            self:updateSkillView()
        end
    end
end

-- 更新选择显示的技能
function updateSkillView(self)
    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local starDic = hero.HeroStarManager:getHeroStarDic(heroVo.tid)
    local showIdx = 0
    if self.currentStarLvl > 0 then
        showIdx = (self.currentStarLvl > 0 and self.selectedIdx >= 1) and self.selectedIdx or self.currentStarLvl
    else
        showIdx = self.selectedIdx
    end
    --选中星级和当前星级的差
    local mDis = showIdx - self.currentStarLvl
    self.m_childGos["mBtnEvolution"]:SetActive(mDis == 1)
    self.m_childGos["mBtnEvolution2"]:SetActive(mDis > 1)
    self.m_childGos["mBtnActved"]:SetActive(mDis < 1)
    self:recoverSkillGrid()
    for _, v in pairs(starDic) do
        if showIdx == v.star then
            if v.passiveSkillId > 0 then
                self.mSkillId = v.passiveSkillId
                local skillVo = fight.SkillManager:getSkillRo(self.mSkillId)
                --skillName
                self.mTxtSkillNextTips.text = skillVo:getName()
                --desscribe
                self.mTxtSkillNextName.text = skillVo:getDesc()
                gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtSkillNextName.transform)
                if self.currentStarLvl < v.star then
                    self.mTxtSkillNextWarn.gameObject:SetActive(true)
                    self.mTxtSkillNextWarn.text = _TT(1173, v.star)
                elseif self.currentStarLvl == v.star then
                    self.mTxtSkillNextWarn.gameObject:SetActive(false)
                end
                local skillGrid = SkillGrid:create(self:getChildTrans("mSkillNode"), { skillId = self.mSkillId, heroVo = heroVo }, 1, false)
                skillGrid:setDetailVisible(false)
                local rect = skillGrid.m_childTrans["ImgSkill"]:GetComponent(ty.RectTransform)
                gs.TransQuick:Scale(rect, 0.75, 0.75, 0.75)
                table.insert(self.mSkillGridList, skillGrid)
            end
        end
    end

    if (self.mDelaySkillView) then
        LoopManager:removeFrameByIndex(self.mDelaySkillView)
        self.mDelaySkillView = nil
    end
end

-- 进化消耗显示
function updateCostView(self)
    self:recoverAllCostGrid()
    local heroVo = self.heroVo
    local nextStarConfigVo = hero.HeroStarManager:getHeroStarConfigVo(heroVo.tid, heroVo.evolutionLvl + 1)
    self.m_childGos["mMaxStarImg"]:SetActive(self.isMaxStar)
    if self.isMaxStar then
        -- self.m_senceChildGos["fx_ui_shengge_color_b"]:SetActive(false)
        -- self.m_senceChildGos["fx_ui_shengge_color_y"]:SetActive(true)
        self.mBtnEvolution:SetActive(false)
        self.mTxtSkillNextWarn.gameObject:SetActive(false)
        self.mGroupCostMaterial:SetActive(false)
    else
        -- if self.m_senceChildGos["fx_ui_shengge_color_y"].activeSelf == true then
        --     self.m_senceChildGos["fx_ui_shengge_color_y"]:SetActive(false)
        -- end
        -- if self.m_senceChildGos["fx_ui_shengge_color_b"].activeSelf == false then
        --     self.m_senceChildGos["fx_ui_shengge_color_b"]:SetActive(true)
        -- end
        self.mGroupCostMaterial:SetActive(true)
        local needCostProps = nextStarConfigVo.needCostProps
        local hasCount = bag.BagManager:getPropsCountByTid(needCostProps[1])
        local propsGrid = PropsGrid:createByData({ tid = needCostProps[1], num = needCostProps[2], parent = self.mGroupCost, scale = 1.3 })
        propsGrid:setIsShowCount(false)
        propsGrid:setShowNum(hasCount, needCostProps[2])
        table.insert(self.mPropsGridList, propsGrid)
        self.mBtnEvolution:SetActive(true)

    end
    if (self.mDelayCostView) then
        LoopManager:removeFrameByIndex(self.mDelayCostView)
        self.mDelayCostView = nil
    end
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnEvolution, self.onClickStarUpHandler)
    self:addUIEvent(self.mBtnEvolution2, self.onClickFunHandler)
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
end

function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.HeroStar })
end

function onClickFunHandler(self)
    gs.Message.Show(_TT(1380))
end

function onClickStarUpHandler(self)
    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local curStar = heroVo.evolutionLvl
    if (self.isMaxStar) then
        gs.Message.Show(_TT(1052))--"当前星级已满级"
    else
        local nextStarConfigVo = hero.HeroStarManager:getHeroStarConfigVo(heroVo.tid, heroVo.evolutionLvl + 1)
        local costMoneyTid = nextStarConfigVo.cost[1]
        local costMoneyCount = nextStarConfigVo.cost[2]
        local needCostProps = nextStarConfigVo.needCostProps
        local hasCount = bag.BagManager:getPropsCountByTid(needCostProps[1])
        if (hasCount >= needCostProps[2]) then
            local isEnough, tipStr = MoneyUtil.judgeNeedMoneyCountByTid(costMoneyTid, costMoneyCount, false, false)
            if (isEnough) then
                self.mCheckLvHelper = heroVo.evolutionLvl
                GameDispatcher:dispatchEvent(EventName.REQ_HERO_STAR_UP, { heroId = self.m_curHeroId })
                self.m_childGos["mBtnOnShowFX"]:SetActive(true)
                hero.HeroManager:dispatchEvent(hero.HeroManager.BLOCK_GROUP_TOP_CLICK, false)
                --避免重复点击 
                --4秒后校验，避免整体界失效
                self.mPostCheck = LoopManager:addTimer(4, 1, self, function()
                    self:recoverRayCast()
                end)
            else
                gs.Message.Show(_TT(1321))
            end
        else
            gs.Message.Show(_TT(4306))
        end
    end
end

function recoverRayCast(self)
    if self.m_childGos["mBtnOnShowFX"].activeSelf == true then
        self.m_childGos["mBtnOnShowFX"]:SetActive(false)
        hero.HeroManager:dispatchEvent(hero.HeroManager.BLOCK_GROUP_TOP_CLICK, true)
    end
end

function starRecover(self)
    if next(self.mStarSelected) then
        for _, star in pairs(self.mStarSelected) do
            gs.GameObject.Destroy(star)
            star = nil
        end
    end
end


function recoveryAll(self)
    self:recoverAllCostGrid()
    self:recoverSkillGrid()
end


function refreshText(self)
    self.selectedIdx = 1
    self.mTxtSkillNextTips.text = ""
    self.mTxtSkillNextName.text = ""
    self.mTxtSkillNextWarn.text = ""
end


function recoverColorUpAddAttrList(self)
    if (self.mStarUpAddAttrList) then
        for i = 1, #self.mStarUpAddAttrList do
            self.mStarUpAddAttrList[i]:poolRecover()
        end
    end
    self.mStarUpAddAttrList = {}
end

function recoverAllEffect(self)
    for _, effectName in pairs(hero.StarUpEffect) do
        self:removeEffect(effectName)
    end
end

function recoverAllCostGrid(self)
    if (self.mPropsGridList) then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
    end
    self.mPropsGridList = {}
end

function recoverSkillGrid(self)
    if (self.mSkillGridList) then
        for i = 1, #self.mSkillGridList do
            self.mSkillGridList[i]:poolRecover()
            self.mSkillGridList[i] = nil
        end
    end
    self.mSkillGridList = {}
end


--覆盖基类特效加载逻辑
function addEffect(self, effectName, parentTrans)
    local effectData = { effectSn = nil, effectName = nil, effectGo = nil }
    table.insert(self.mEffectList, effectData)
    local function _loadAysnCall(effectGo)
        if (effectGo) then
            local effectTrans = effectGo.transform
            effectData.effectGo = effectGo
            effectData.effectGo:SetActive(true)
            gs.TransQuick:SetParentOrg(effectTrans, parentTrans)
            gs.TransQuick:LPosXY(effectTrans, 0, 0)
        else
            if (effectName) then
                self:removeEffect(effectName)
            end

        end
    end
    effectData.effectName = effectName
    effectData.effectSn = gs.GOPoolMgr:GetAsyc(UrlManager:getUIEfxPath(string.format("%s.prefab", effectData.effectName)), _loadAysnCall)
end

-- 移除界面UI特效
function removeEffect(self, effectName)
    if next(self.mEffectList) then
        for i = #self.mEffectList, 1, -1 do
            local effectData = self.mEffectList[i]
            if effectData then
                if (effectName == nil or effectName == effectData.effectName) then
                    gs.GOPoolMgr:CancelAsyc(effectData.effectSn)
                    if (effectData.effectGo and not gs.GoUtil.IsGoNull(effectData.effectGo)) then
                        effectData.effectGo:SetActive(false)
                        gs.GOPoolMgr:Recover(effectData.effectGo, UrlManager:getUIEfxPath(string.format("%s.prefab", effectData.effectName)))
                    end
                    table.remove(self.mEffectList, i)
                end
            end
        end
        if (effectName == nil) then
            self.mEffectList = {}
            return true
        end

    end
    return false
end


return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1321):	"货币不足"
	语言包: _TT(1320):	"成长"
	语言包: _TT(1319):	"预览星级"
	语言包: _TT(1318):	"当前星级"
	语言包: _TT(1053):	"该战员无法进化"
]]
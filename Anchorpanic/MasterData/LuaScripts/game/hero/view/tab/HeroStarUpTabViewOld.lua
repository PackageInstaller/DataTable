module("hero.HeroStarUpTabViewOld", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("hero/tab/HeroStarUpTab.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mShowStar = nil
    self.m_curHeroId = nil
    self.mFullStarItemList = {}
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

    ------------------------------------------------------ 有进化权限区域 ------------------------------------------------------
    self.mGroupStar = self:getChildGO("GroupStar")
    ------------------------ 未满星区域 ------------------------
    self.mGroupUnFull = self:getChildGO("mGroupUnFull")
    -- 当前星级区域
    self.mTextCurStar = self:getChildGO("mTextCurStar"):GetComponent(ty.Text)
    self.mGroupCurStar = self:getChildTrans("mGroupCurStar")
    self.mImgCurStar = self:getChildGO("mImgCurStar")
    -- 查看星级区域
    self.mTextShowStar = self:getChildGO("mTextShowStar"):GetComponent(ty.Text)
    self.mGroupShowStar = self:getChildTrans("mGroupShowStar")
    self.mImgShowStar = self:getChildGO("mImgShowStar")

    self.mBtnLast = self:getChildGO("mBtnLast")
    self.mBtnNext = self:getChildGO("mBtnNext")
    -- 属性变化区域
    self.mGroupAddAttr = self:getChildGO("mGroupAddAttr")
    self.mColorUpAddAttrItem = self:getChildGO("mColorUpAddAttrItem")

    self.mSkillScroller = self:getChildGO("mSkillScroller"):GetComponent(ty.LyScroller)
    self.mSkillScroller:SetItemRender(hero.HeroStarUpItem)
    -- 技能区域
    -- self.mGroupSkill = self:getChildGO("mGroupSkill")
    -- self.mImgSkillBg = self:getChildGO("ImgSkillBg"):GetComponent(ty.AutoRefImage)
    -- self.mBtnSkillIcon = self:getChildGO("mSkillIcon")
    -- self.mSkillIcon = self.mBtnSkillIcon:GetComponent(ty.AutoRefImage)
    -- self.mImgSkillCost = self:getChildGO("ImgSkillCost")
    -- self.mTextSkillCost = self:getChildGO("TextSkillCost"):GetComponent(ty.Text)
    -- self.mImgSkillDefine = self:getChildGO("ImgSkillDefine"):GetComponent(ty.Image)
    -- self.mTextSkillDefine = self:getChildGO("TextSkillDefine"):GetComponent(ty.Text)
    -- self.mTextSkillName = self:getChildGO("TextSkillName"):GetComponent(ty.Text)
    -- self.mTxtNeedStar = self:getChildGO("TextNeedColor"):GetComponent(ty.Text)
    -- 进化消耗区域
    self.mGroupCost = self:getChildTrans("mGroupCost")
    self.mBtnEvolution = self:getChildGO("mBtnEvolution")
    self.mNeedCost = self:getChildGO("mNeedCost"):GetComponent(ty.Text)

    self.mTxtIsMax = self:getChildGO("mTxtIsMax")

    ------------------------ 满星区域 ------------------------
    -- self.mGroupFull = self:getChildGO("mGroupFull")
    self.mTextMaxStarTitle = self:getChildGO("mTextMaxStarTitle"):GetComponent(ty.Text)

    self.mMaxStarImg = self:getChildGO("mMaxStarImg")
    -- -- 满星级技能区域
    -- for star = 1, 6 do
    --     local transStarSkill = self:getChildTrans("StarSkill_" .. star)       
    --     table.insert(self.mFullStarItemList, {go = transStarSkill.gameObject, imgIcon = transStarSkill:Find("ImgSkill").gameObject:GetComponent(ty.AutoRefImage), goLock = transStarSkill:Find("ImgLock").gameObject, goLight = transStarSkill:Find("ImgLight").gameObject})
    -- end

    ------------------------------------------------------ 无进化权限区域 ------------------------------------------------------
    self.mGoEmptyTip = self:getChildGO("GroupEmpty")
    self.mTextEmpty = self:getChildGO("TextEmpty"):GetComponent(ty.Text)

    self.mTransGuide_1 = self:getChildTrans("Guide_1")
    self.mTransGuide_2 = self:getChildTrans("Guide_2")

    self:updateGuide()
end

function active(self, args)
    super.active(self, args)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_STARUP_PANEL, self.onStarUpUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.onUpdateHeroDetailDataHandler, self)
    hero.HeroFlagManager:addEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.onBubbleUpdateHandler, self)

    self:setShowStar(nil)
    self:setData(args.heroId)
end

function deActive(self)
    super.deActive(self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.onBagUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_STARUP_PANEL, self.onStarUpUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_DATA_UPDATE, self.onUpdateHeroDetailDataHandler, self)
    hero.HeroFlagManager:removeEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.onBubbleUpdateHandler, self)
    self:recoveryAll()
    if self.mSkillScroller then
        self.mSkillScroller:CleanAllItem()
    end

    RedPointManager:remove(self.mBtnEvolution.transform)
end

function initViewText(self)
    self.mTextCurStar.text = _TT(1318)
    self.mTextShowStar.text = _TT(1319)
    self.mTextMaxStarTitle.text = _TT(1162) --"进化满级"

    self.mTextEmpty.text = _TT(1053)
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLast, self.onClickLastHeroHandler)
    self:addUIEvent(self.mBtnNext, self.onClickNextHeroHandler)
    --self:addUIEvent(self.mBtnSkillIcon, self.onClickSkillTipHandler)
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
    self:addUIEvent(self.mBtnEvolution, self.onClickStarUpHandler)

    for index = 1, #self.mFullStarItemList do
        local function _onClickFullSkillTipHandler()
            self:onClickFullSkillTipHandler(index)
        end
        self:addUIEvent(self.mFullStarItemList[index].go, _onClickFullSkillTipHandler)
    end
end

-- 点击切换查看前一个英雄
function onClickLastHeroHandler(self)
    self:setShowStar(self:getLastShowStar(self:getShowStar()))
end

-- 点击切换查看后一个英雄
function onClickNextHeroHandler(self)
    self:setShowStar(self:getNextShowStar(self:getShowStar()))
end

function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.HeroStar })
end

function onClickStarUpHandler(self)
    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local curStar = heroVo.evolutionLvl
    local showStar = self:getShowStar()
    if (curStar + 1 == showStar) then
        local isCanStarUp = hero.HeroStarManager:isCanStarUp(heroVo.tid, heroVo.evolutionLvl + 1, heroVo.color)
        if (isCanStarUp) then
            local maxStarLvl = hero.HeroStarManager:getHeroMaxStarLvl(heroVo.tid)
            if (heroVo.evolutionLvl >= maxStarLvl) then
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
                        GameDispatcher:dispatchEvent(EventName.REQ_HERO_STAR_UP, { heroId = self.m_curHeroId })
                    else
                        gs.Message.Show(_TT(1321))
                    end
                else
                    gs.Message.Show(_TT(1322))
                end
            end
        else
            local nextStarConfigVo = hero.HeroStarManager:getHeroStarConfigVo(heroVo.tid, heroVo.evolutionLvl + 1)
            gs.Message.Show(string.format(_TT(1146), hero.getColorName(nextStarConfigVo.needOwnColor))) --提升至%s品质战员可进化升星
        end
    else
        gs.Message.Show("预览中")
    end

end

function onBagUpdateHandler(self, args)
    self:updateView()
end

function onStarUpUpdateHandler(self, args)
    hero.HeroStarManager.materialHeroIdList = {}
    local heroId = args.heroId
    if (self.m_curHeroId == heroId) then
        self:setShowStar(nil)
        self:updateView()
    end
end

function onUpdateHeroDetailDataHandler(self, args)
    local heroId = args.heroId
    if (self.m_curHeroId == heroId) then
        self:updateView()
    end
end

function onBubbleUpdateHandler(self, args)
    local heroId = args.heroId
    if (heroId == self.m_curHeroId) then
        if (args.flagType == hero.HeroFlagManager.FLAG_CAN_STAR_UP) then
            self:updateBubbleView(args.isFlag)
        end
    end
end

function updateBubbleView(self, isFlag)
    if (isFlag) then
        RedPointManager:add(self.mBtnEvolution.transform, nil, 161, 21)
    else
        RedPointManager:remove(self.mBtnEvolution.transform)
    end
end

function setData(self, cusHeroId)
    self.m_curHeroId = cusHeroId
    local heroVo = hero.HeroManager:getHeroVo(cusHeroId)
    if (heroVo:checkIsPreData()) then
        return
    else
        self:updateView()
        self:updateBubbleView(hero.HeroFlagManager:getFlag(self.m_curHeroId, hero.HeroFlagManager.FLAG_CAN_STAR_UP))
    end
end

function recoveryAll(self)
    self:recoverStarItemList()
    self:recoverColorUpAddAttrList()
    self:recoverAllCostGrid()
end

function updateView(self)
    self:recoveryAll()
    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local maxStarLvl = hero.HeroStarManager:getHeroMaxStarLvl(heroVo.tid)
    local nextStarConfigVo = hero.HeroStarManager:getHeroStarConfigVo(heroVo.tid, heroVo.evolutionLvl + 1)
    local isCanStarUp = hero.HeroStarManager:isCanStarUp(heroVo.tid, heroVo.evolutionLvl + 1, heroVo.color)
    if (isCanStarUp) then                             --可升星
        local starDic = hero.HeroStarManager:getHeroStarDic(heroVo.tid)
        if (nextStarConfigVo) then
            hero.HeroStarManager.needMaterialCount = nextStarConfigVo.needHeroNum
            hero.HeroStarManager.materialHeroIdList = {}
        else
            hero.HeroStarManager.needMaterialCount = -1
            hero.HeroStarManager.materialHeroIdList = {}
        end

        if (heroVo.evolutionLvl >= maxStarLvl) then --满星
            self.mGroupUnFull:SetActive(true)
            self.mMaxStarImg:SetActive(true)
            self.mBtnEvolution:SetActive(false)
            self.mGoEmptyTip:SetActive(false)
        else                                        --可升星
            self.mGroupUnFull:SetActive(true)
            self.mMaxStarImg:SetActive(false)
            self.mBtnEvolution:SetActive(true)
            self.mGoEmptyTip:SetActive(false)
        end
    else                                            --不可升星
        if (heroVo.evolutionLvl >= maxStarLvl) then --满星
            self.mGroupUnFull:SetActive(true)
            self.mBtnEvolution:SetActive(false)
            self.mGoEmptyTip:SetActive(false)
            self.mMaxStarImg:SetActive(true)
        else                                        --不可升星
            self.mGroupUnFull:SetActive(true)
            self.mBtnEvolution:SetActive(true)
            self.mMaxStarImg:SetActive(false)
            self.mGoEmptyTip:SetActive(false)
        end
    end
    self:updateStarView()
    self:updateSkillView()
end

-- 获取对应星级的前一星级
function getLastShowStar(self, starLvl)
    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local curStar = heroVo.evolutionLvl
    local minStarLvl = hero.HeroStarManager:getHeroMinStarLvl(heroVo.tid)
    if (starLvl > minStarLvl and starLvl ~= curStar + 1) then
        starLvl = starLvl - 1
    end
    return starLvl
end
-- 获取对应星级的后一星级
function getNextShowStar(self, starLvl)
    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local curStar = heroVo.evolutionLvl
    local maxStarLvl = hero.HeroStarManager:getHeroMaxStarLvl(heroVo.tid)
    if (starLvl < maxStarLvl and starLvl ~= curStar - 1) then
        starLvl = starLvl + 1
    end
    return starLvl
end

-- 设置选择显示的星级
function setShowStar(self, starLvl)
    self.mShowStar = starLvl
    if (self.mShowStar ~= nil) then
        self:updateStarView()
    end
end
-- 获取选择显示的星级
function getShowStar(self)
    if (not self.mShowStar) then
        local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
        self.mShowStar = heroVo.evolutionLvl + 1
    end
    return self.mShowStar
end

-- 更新星级显示
function updateStarView(self)
    self:recoverStarItemList()

    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local curStar = heroVo.evolutionLvl
    local showStar = self:getShowStar()

    local maxStar = 12
    -- 更新当前的星级
    local curIntegers, curDecimals = math.modf(curStar / 2)
    for i = 1, curIntegers do
        local item = SimpleInsItem:create(self.mImgCurStar, self.mGroupCurStar)
        local img = item:getGo():GetComponent(ty.AutoRefImage)
        img:SetImg(UrlManager:getPackPath("hero/hero_star_up_3.png"), false)
        table.insert(self.mStarItemList, item)
    end
    if (curDecimals > 0) then
        local item = SimpleInsItem:create(self.mImgCurStar, self.mGroupCurStar)
        local img = item:getGo():GetComponent(ty.AutoRefImage)
        img:SetImg(UrlManager:getPackPath("hero/hero_star_up_2.png"), false)
        table.insert(self.mStarItemList, item)
    end

    -- 更新选择显示的星级
    local showIntegers, showDecimals = math.modf(showStar / 2)

    if maxStar == curStar then
        --已经是最大等级了
        self.mTxtIsMax:SetActive(true)
        self.mGroupShowStar.gameObject:SetActive(false)
    else
        self.mTxtIsMax:SetActive(false)
        self.mGroupShowStar.gameObject:SetActive(true)
        for i = 1, showIntegers do
            local item = SimpleInsItem:create(self.mImgShowStar, self.mGroupShowStar)
            local img = item:getGo():GetComponent(ty.AutoRefImage)
            img:SetImg(UrlManager:getPackPath("hero/hero_star_up_3.png"), false)
            table.insert(self.mStarItemList, item)
        end
        if (showDecimals > 0) then
            local item = SimpleInsItem:create(self.mImgCurStar, self.mGroupShowStar)
            local img = item:getGo():GetComponent(ty.AutoRefImage)
            img:SetImg(UrlManager:getPackPath("hero/hero_star_up_2.png"), false)
            table.insert(self.mStarItemList, item)
        end
    end


    --self.mBtnLast:SetActive(showStar ~= self:getLastShowStar(showStar))
    --self.mBtnNext:SetActive(showStar ~= self:getNextShowStar(showStar))

    self:updateAddAttrView()
    self:updateSkillView()
    self:updateCostView()
end

-- 进化变化的属性
function updateAddAttrView(self)

    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local function _updateAddAttrList(preStarDic)
        if (preStarDic) then
            local attrDic = hero.HeroManager:getHeroVo(self.m_curHeroId).attrDic
            local showStar = self:getShowStar()
            local maxStar = 12
            if showStar >= maxStar then
                local preAttrDic = preStarDic[maxStar]
                if (preAttrDic) then
                    local addAttrList = {}
                    for key, value in pairs(preAttrDic) do
                        local addAttrVo = nil
                        if (attrDic[key]) then
                            addAttrVo = { key = key, value = value - attrDic[key], currentValue = value }
                        else
                            addAttrVo = { key = key, value = value, currentValue = value }
                        end
                        if (addAttrVo.value > 0) then
                            addAttrVo.value = "+" .. AttConst.getValueStr(addAttrVo.key, addAttrVo.value)
                            addAttrVo.key = AttConst.getName(key)
                            if (key == AttConst.ATTACK) then
                                table.insert(addAttrList, 1, addAttrVo)
                            elseif (key == AttConst.HP_MAX) then
                                table.insert(addAttrList, 2, addAttrVo)
                            elseif (key == AttConst.DEFENSE) then
                                table.insert(addAttrList, 3, addAttrVo)
                            elseif (key == AttConst.SPEED) then
                                table.insert(addAttrList, 4, addAttrVo)
                            else
                                table.insert(addAttrList, addAttrVo)
                            end
                        end
                    end
                    if (#addAttrList > 0) then
                        -- TipsFactory:AttrListTips(addAttrList)
                        self:recoverColorUpAddAttrList()
                        for i = 1, #addAttrList do
                            if (addAttrList[i]) then
                                local item = SimpleInsItem:create(self.mColorUpAddAttrItem, self.mGroupAddAttr.transform, self.__cname .. "_StarUpAddAttrItem")
                                item:getChildGO("TextKey"):GetComponent(ty.Text).text = addAttrList[i].key
                                item:getChildGO("TextValue"):GetComponent(ty.Text).text = ""
                                item:getChildGO("CurrentValue"):GetComponent(ty.Text).text = addAttrList[i].currentValue
                                table.insert(self.mStarUpAddAttrList, item)
                            end
                        end
                    end
                end
            else
                local preAttrDic = preStarDic[showStar]
                if (preAttrDic) then
                    local addAttrList = {}
                    for key, value in pairs(preAttrDic) do
                        local addAttrVo = nil
                        if (attrDic[key]) then
                            addAttrVo = { key = key, value = value - attrDic[key], currentValue = value }
                        else
                            addAttrVo = { key = key, value = value, currentValue = value }
                        end
                        if (addAttrVo.value > 0) then
                            addAttrVo.value = "+" .. AttConst.getValueStr(addAttrVo.key, addAttrVo.value)
                            addAttrVo.key = AttConst.getName(key)
                            if (key == AttConst.ATTACK) then
                                table.insert(addAttrList, 1, addAttrVo)
                            elseif (key == AttConst.HP_MAX) then
                                table.insert(addAttrList, 2, addAttrVo)
                            elseif (key == AttConst.DEFENSE) then
                                table.insert(addAttrList, 3, addAttrVo)
                            elseif (key == AttConst.SPEED) then
                                table.insert(addAttrList, 4, addAttrVo)
                            else
                                table.insert(addAttrList, addAttrVo)
                            end
                        end
                    end
                    if (#addAttrList > 0) then
                        -- TipsFactory:AttrListTips(addAttrList)
                        self:recoverColorUpAddAttrList()
                        for i = 1, #addAttrList do
                            if (addAttrList[i]) then
                                local item = SimpleInsItem:create(self.mColorUpAddAttrItem, self.mGroupAddAttr.transform, self.__cname .. "_StarUpAddAttrItem")
                                item:getChildGO("TextKey"):GetComponent(ty.Text).text = addAttrList[i].key
                                item:getChildGO("TextValue"):GetComponent(ty.Text).text = addAttrList[i].value
                                item:getChildGO("CurrentValue"):GetComponent(ty.Text).text = addAttrList[i].currentValue
                                table.insert(self.mStarUpAddAttrList, item)
                            end
                        end
                    end
                end
            end
        end
    end
    local function _onHerPreviewAttrUpdateHandler(self, data)
        if (data.heroId == self.m_curHeroId and data.previewType == hero.AllPreviewAttrType.STAR_UP) then
            GameDispatcher:removeEventListener(EventName.UPDATE_HERO_PREVIEW_ALL_ATTR, _onHerPreviewAttrUpdateHandler, self)
            local preAttrDic = hero.HeroManager:getHeroVo(self.m_curHeroId):getStarUpAllPreviewAttrDic()
            _updateAddAttrList(preAttrDic)
        end
    end

    local preAttrDic = hero.HeroManager:getHeroVo(self.m_curHeroId):getStarUpAllPreviewAttrDic()
    if (preAttrDic) then
        _updateAddAttrList(preAttrDic)
    else
        if (not GameDispatcher:hasEventListener(EventName.UPDATE_HERO_PREVIEW_ALL_ATTR, _onHerPreviewAttrUpdateHandler, self)) then
            GameDispatcher:addEventListener(EventName.UPDATE_HERO_PREVIEW_ALL_ATTR, _onHerPreviewAttrUpdateHandler, self)
        end
    end
end

-- 更新选择显示的技能
function updateSkillView(self)
    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local starDic = hero.HeroStarManager:getHeroStarDic(heroVo.tid)

    local skillList = {}
    for k, v in pairs(starDic) do
        table.insert(skillList, { star = heroVo.evolutionLvl, currentStar = v.star, skillId = v.passiveSkillId })
    end

    self.mSkillScroller.DataProvider = skillList

    -- local curStar = heroVo.evolutionLvl
    -- local showStar = self:getShowStar()
    -- local starConfigVo = hero.HeroStarManager:getHeroStarConfigVo(heroVo.tid, showStar)
    -- if(starConfigVo and starConfigVo.passiveSkillId > 0)then
    --     self.mGroupSkill:SetActive(true)
    --     local skillVo = fight.SkillManager:getSkillRo(starConfigVo.passiveSkillId)
    --     self.mSkillIcon:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
    --     if(skillVo:getType() == fight.FightDef.SKILL_TYPE_ACTIVE_SKILL)then         -- 主动技能
    --         self.mImgSkillBg:SetImg(UrlManager:getCommon4Path("common_1429.png"), true)
    --         self.mImgSkillCost:SetActive(true)
    --         self.mTextSkillCost.text = skillVo:getCost()
    --     elseif(skillVo:getType() == fight.FightDef.SKILL_TYPE_PASSIVE_SKILL)then    -- 被动技能
    --         self.mImgSkillBg:SetImg(UrlManager:getCommon4Path("common_1430.png"), true)
    --         self.mImgSkillCost:SetActive(false)
    --         self.mTextSkillCost.text = ""
    --     end
    --     if(#skillVo:getLocation() >= 2)then
    --         self.mImgSkillDefine.color = gs.ColorUtil.GetColor(skillVo:getLocation()[1])
    --         self.mTextSkillDefine.text = _TT(skillVo:getLocation()[2])
    --     else
    --         self.mImgSkillDefine.color = gs.ColorUtil.GetColor("FFFFFF00")
    --         self.mTextSkillDefine.text = ""
    --     end
    --     self.mTextSkillName.text = skillVo:getName()
    --     if(showStar <= curStar)then
    --         self.mTxtNeedStar.text = ""
    --     else
    --         self.mTxtNeedStar.text = string.format(_TT(53502), fight.FightDef.GetSkillTypeName(skillVo:getType())) --解锁%s
    --     end
    -- else
    --     self.mGroupSkill:SetActive(false)
    -- end
end

-- 进化消耗显示
function updateCostView(self)
    self:recoverAllCostGrid()
    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local nextStarConfigVo = hero.HeroStarManager:getHeroStarConfigVo(heroVo.tid, heroVo.evolutionLvl + 1)

    self.isMax = false
    if nextStarConfigVo == nil then
        self.isMax = true
    end

    if self.isMax then
        self.mMaxStarImg:SetActive(true)
        self.mBtnEvolution:SetActive(false)
    else
        self.mMaxStarImg:SetActive(false)
        self.mBtnEvolution:SetActive(true)
        local needCostProps = nextStarConfigVo.needCostProps
        local hasCount = bag.BagManager:getPropsCountByTid(needCostProps[1])
        local propsGrid = PropsGrid:create(self.mGroupCost, { needCostProps[1], needCostProps[2] }, 1)
        propsGrid:setCount(hasCount, needCostProps[2])
        table.insert(self.mPropsGridList, propsGrid)

        local curStar = heroVo.evolutionLvl
        local showStar = self:getShowStar()

        local needCost = nextStarConfigVo.cost

        if (curStar + 1 == showStar) then
            self.mNeedCost.text = needCost[2]
            self:setBtnLabel(self.mBtnEvolution, 1042, "进化")
        else
            self:setBtnLabel(self.mBtnEvolution, -1, "预览中")
        end
    end
end

-- 点击未满星状态时的技能tip
function onClickSkillTipHandler(self)
    self:showSkillTip(self:getShowStar())
end

-- 点击满星状态时的技能tip
function onClickFullSkillTipHandler(self, passiveSkillIndex)
    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local starLvl = hero.HeroStarManager:getStarByPassSkillIndex(heroVo.tid, passiveSkillIndex)
    self:showSkillTip(starLvl)
end

-- 根据星级显示技能tip
function showSkillTip(self, star)
    if (star) then
        local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
        local skillId = hero.HeroStarManager:getHeroStarConfigVo(heroVo.tid, star).passiveSkillId
        if (skillId > 0) then
            TipsFactory:skillTips(nil, skillId, heroVo)
        end
    end
end

-- 注册引导（只在英雄可进化时引导）
function regGuide(self)
    local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
    local isCanStarUp = hero.HeroStarManager:isCanStarUp(heroVo.tid, heroVo.evolutionLvl + 1, heroVo.color)
    if (isCanStarUp) then
        super.regGuide(self)
    end
end

function updateGuide(self)
    self:setGuideTrans("weak_hero_straUp_1", self.mTransGuide_1)
    self:setGuideTrans("funcTips_starUp_1", self:getChildTrans("mGroupFuncTipsStarUp"))
end

-----------------------------------------------回收相关-------------------------------------------------- 
function recoverColorUpAddAttrList(self)
    if (self.mStarUpAddAttrList) then
        for i = 1, #self.mStarUpAddAttrList do
            self.mStarUpAddAttrList[i]:poolRecover()
        end
    end
    self.mStarUpAddAttrList = {}
end

function recoverStarItemList(self)
    if (self.mStarItemList) then
        for i = 1, #self.mStarItemList do
            self.mStarItemList[i]:poolRecover()
        end
    end
    self.mStarItemList = {}
end

function recoverAllCostGrid(self)
    if (self.mPropsGridList) then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
    end
    self.mPropsGridList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1322):	"材料不足"
	语言包: _TT(1321):	"货币不足"
	语言包: _TT(1319):	"预览星级"
	语言包: _TT(1318):	"当前星级"
	语言包: _TT(1053):	"该战员无法进化"
]]
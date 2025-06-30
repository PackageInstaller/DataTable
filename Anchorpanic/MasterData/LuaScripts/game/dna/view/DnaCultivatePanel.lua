--[[
-----------------------------------------------------
   @CreateTime:2024/12/24 15:18:45
   @Author:zengweiwen
   @Copyright: (LY)2021 雷焰网络
   @Description:dna培养主界面
]]

module("game.dna.view.DnaCultivatePanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("dna/DnaCultivatePanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1   -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(149903))
    self:setSize(0, 0)
end

function initData(self)
    self.mAttrItemList = {}
    self.mCostPropItemList = {}
    self.mAllAttrItemTimeSn = {}
end

function configUI(self)
    self.mNodeSelectBtnBar = self:getChildGO("mNodeSelectBtnBar")
    self.mBtnSelectDna = self:getChildGO("mBtnSelectDna")
    self.mNodeSkill = self:getChildGO("mNodeSkill")
    self.mAriDnaSkillIcon = self:getChildGO("mAriDnaSkillIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtDnaSkillEffect = self:getChildGO("mTxtDnaSkillEffect"):GetComponent(ty.Text)
    self.mTxtDnaSkillNoActive = self:getChildGO("mTxtDnaSkillNoActive"):GetComponent(ty.Text)
    self.mTxtDnaSkillName = self:getChildGO("mTxtDnaSkillName"):GetComponent(ty.Text)
    self.mTxtDnaSkillLv = self:getChildGO("mTxtDnaSkillLv"):GetComponent(ty.Text)
    self.mTxtDnaSkillDesc = self:getChildGO("mTxtDnaSkillDesc"):GetComponent(ty.Text)
    self.mAriDnaIconGo = self:getChildGO("mAriDnaIcon")
    self.mAriDnaIcon = self.mAriDnaIconGo:GetComponent(ty.AutoRefImage)
    self.mBtnDnaClick = self:getChildGO("mBtnDnaClick")
    self.mBtnSkillAllLv = self:getChildGO("mBtnSkillAllLv")
    self.mNodeFrameAniPrefab = self:getChildTrans("mNodeFrameAniPrefab")
    self.mImgBubble = self:getChildGO("mImgBubble")
    self.mTxtBubble = self:getChildGO("mTxtBubble"):GetComponent(ty.Text)
    self.mBtnManual = self:getChildGO("mBtnManual")
    self.mBtnSwitchAttr = self:getChildGO("mBtnSwitchAttr")
    self.mTxtDnaLv = self:getChildGO("mTxtDnaLv"):GetComponent(ty.Text)
    self.mNodeAttr = self:getChildTrans("mNodeAttr")
    self.DnaCultivateAttrItem = self:getChildGO("DnaCultivateAttrItem")
    self.DnaCultivateAttrItem:SetActive(false)
    self.mNodeSkillLvup = self:getChildGO("mNodeSkillLvup")
    self.mTxtSkillLvupDesc = self:getChildGO("mTxtSkillLvupDesc"):GetComponent(ty.Text)
    self.mTxtSkillLvupNameLv = self:getChildGO("mTxtSkillLvupNameLv"):GetComponent(ty.Text)
    self.mNodeCost = self:getChildGO("mNodeCost")
    self.mGridCost = self:getChildTrans("mGridCost")
    self.mBtnLvlUp = self:getChildGO("mBtnLvlUp")
    self.mTxtCostNum = self:getChildGO("mTxtCostNum"):GetComponent(ty.Text)
    self.mAriCostIcon = self:getChildGO("mAriCostIcon"):GetComponent(ty.AutoRefImage)
    self.mBtnUnSelect = self:getChildGO("mBtnUnSelect")
    self.mBtnFullLevel = self:getChildGO("mBtnFullLevel")
    self.mTxtFullLevelDesc = self:getChildGO("mTxtFullLevelDesc"):GetComponent(ty.Text)
    self.mNoWearEggDesc = self:getChildGO("mNoWearEggDesc"):GetComponent(ty.Text)
    self.mBtnBackList = self:getChildGO("mBtnBackList")
    self.mAriHeroIcon = self:getChildGO("mAriHeroIcon"):GetComponent(ty.AutoRefImage)
    self.mImgQualityBar = self:getChildGO("mImgQualityBar"):GetComponent(ty.Image)
    self.mTxtRoleName = self:getChildGO("mTxtRoleName"):GetComponent(ty.Text)
    self.mEffect = self:getChildGO("mEffect")
    self.mEffect02 = self:getChildGO("mEffect02")
    self.ImgBg2 = self:getChildGO("ImgBg2")
    self.ImgBg3 = self:getChildGO("ImgBg3")
end

function initViewText(self)
    super.initViewText(self)
    self:setBtnLabel(self.mBtnUnSelect, 149906)
    self:setBtnLabel(self.mBtnFullLevel, 149918)
    self:getChildGO("mTxtHeart"):GetComponent(ty.Text).text = _TT(149904)
    self:getChildGO("mTxtSkillLvup"):GetComponent(ty.Text).text = _TT(149911)
    self:getChildGO("mTxtCost"):GetComponent(ty.Text).text = _TT(149915)
    self.mTxtDnaSkillEffect.text = _TT(149911)
    self.mTxtDnaSkillNoActive.text = _TT(149912)
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnSelectDna, self.onClickBtnSelectDnaHandler)
    self:addUIEvent(self.mBtnLvlUp, self.onClickBtnLvlUpHandler)
    self:addUIEvent(self.mBtnManual, self.onClickBtnManualHandler)
    self:addUIEvent(self.mBtnSwitchAttr, self.onClickBtnSwitchAttrHandler)
    self:addUIEvent(self.mBtnBackList, self.onClickBackListHandler)
    self:addUIEvent(self.mBtnDnaClick, self.onClicBtnDnaClickHandler)
    self:addUIEvent(self.mBtnSkillAllLv, self.onClicBtnSkillAllLvHandler)
end

function initArgs(self, args)
    self.teamId = args and args.teamId or nil
    self.lastClick = 0
    self.isCurHeroPreData = false
end

function active(self, args)
    super.active(self)
    self:initArgs(args)
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.onHeroDataUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_HEAD_CHANGE, self.onUpdateHeadHandler, self)
    GameDispatcher:addEventListener(EventName.DNA_INCUBATE_SUCCEED, self.onDnaIncubateSucceedHandler, self)
    GameDispatcher:addEventListener(EventName.DNA_LV_UP, self.onDnaLvUpHandler, self)
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.onUpdateModuleReadHandler, self)

    self.dnaBubbleCtrl = dna.DnaBubbleCtrl.new()
    self.dnaBubbleCtrl:active(self.mImgBubble, self.mTxtBubble)

    self.dnaFrameAniCtrl = dna.DnaFrameAniCtrl.new()
    self.dnaFrameAniCtrl:active()
    self.dnaFrameAniCtrl:initUiRef(true,
        self.mNodeFrameAniPrefab
    )

    self.dnaBubbleCtrl:addEventListener(
        self.dnaBubbleCtrl.DNA_BUBBLE_FINIISH_WAIT,
        self.dnaFrameAniCtrl.onDnaBubbleFiniishWaitHandler,
        self.dnaFrameAniCtrl
    )

    self:onUpdateHeadHandler()
end

function deActive(self)
    super.deActive(self)
    self:initArgs()
    self:destroyAllAttrItemTimeSn()
    self:stopLvlEfx()
    self:recoverAttrItem()
    self:recoverCostPropItem()
    GameDispatcher:removeEventListener(EventName.HERO_DATA_UPDATE, self.onHeroDataUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_HEAD_CHANGE, self.onUpdateHeadHandler, self)
    GameDispatcher:removeEventListener(EventName.DNA_INCUBATE_SUCCEED, self.onDnaIncubateSucceedHandler, self)
    GameDispatcher:removeEventListener(EventName.DNA_LV_UP, self.onDnaLvUpHandler, self)
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.onUpdateModuleReadHandler, self)

    self.dnaBubbleCtrl:deActive()
    self.dnaBubbleCtrl = nil
    self.dnaFrameAniCtrl:deActive()
    self.dnaFrameAniCtrl = nil
    RedPointManager:remove(self.mBtnManual.transform)
    RedPointManager:remove(self.mBtnSelectDna.transform)
end

function recoverAttrItem(self)
    for k, item in pairs(self.mAttrItemList) do
        item:poolRecover()
        self.mAttrItemList[k] = nil
    end
    self.mAttrItemList = {}
end

function recoverCostPropItem(self)
    for k, item in pairs(self.mCostPropItemList) do
        item:poolRecover()
        self.mCostPropItemList[k] = nil
    end
    self.mCostPropItemList = {}
end

function InitNodeActive(self, isResetAll)
    self.mNodeSelectBtnBar:SetActive(false)
    self.mTxtRoleName.gameObject:SetActive(false)
    self.mNodeSkill:SetActive(false)
    self.mAriDnaIconGo:SetActive(false)
    if isResetAll then
        self.dnaFrameAniCtrl:SetActive(false)
        self.dnaBubbleCtrl:stopPrintText()
        self:stopLvlEfx()
    end
    self.mNodeSkillLvup:SetActive(false)
    self.mNodeCost:SetActive(false)
    self.mBtnUnSelect:SetActive(false)
    self.mBtnFullLevel:SetActive(false)
    self.mTxtFullLevelDesc.gameObject:SetActive(false)
    self.mNoWearEggDesc.gameObject:SetActive(false)
    self:setEggBgActive(hero.eggType.none)
    self.mBtnSwitchAttr:SetActive(true)
end

function refreshView(self, isResetAll)
    self:InitNodeActive(isResetAll)
    self:recoverAttrItem()
    self:recoverCostPropItem()

    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local isNone = curHeroVo:checkDnaStatus(hero.eggType.none)
    local isEgg = curHeroVo:checkDnaStatus(hero.eggType.egg)
    local isRole = curHeroVo:checkDnaStatus(hero.eggType.role)

    --预览数据里面没有egg信息下发 所以要等待详细信息更新
    self.isCurHeroPreData = curHeroVo:checkIsPreData()
    if self.isCurHeroPreData or isNone then
        self:refreshNoneInfo(curHeroVo, isResetAll)
    elseif isEgg then
        self:refreshEggInfo(curHeroVo, isResetAll)
    elseif isRole then
        self:refreshRoleInfo(curHeroVo, isResetAll)
    else
        logError("战员dna蛋状态错误，检查代码")
    end

    self:refreshHeroHeadInfo(curHeroVo)
    self:refreshRed()
end

function refreshHeroHeadInfo(self, heroVo)
    self.mAriHeroIcon:SetImg(UrlManager:getHeroHeadUrlByModel(heroVo:getHeroModel()), false)
    self.mImgQualityBar.color = gs.ColorUtil.GetColor(ColorUtil:getPropColor(heroVo.color))
end

function refreshNoneInfo(self, heroVo)
    self.mBtnSwitchAttr:SetActive(false)
    self.mBtnUnSelect:SetActive(true)
    self.mNodeSelectBtnBar:SetActive(true)
    self:setBtnLabel(self.mBtnSelectDna, 149905)
    --刷新固定三围属性id 值为0 等级需要隐藏
    local defaultAttr = {
        [1] = { key = AttConst.HP_MAX, value = 0 },
        [2] = { key = AttConst.ATTACK, value = 0 },
        [3] = { key = AttConst.DEFENSE, value = 0 }
    }
    self:refreshAttrInfo(defaultAttr)

    self.mNoWearEggDesc.gameObject:SetActive(true)
    local heroEggDataCfgVo = dna.DnaManager:getSingleHeroEggDataConfigVo(heroVo.tid, true)
    local lanId = heroEggDataCfgVo == nil and 149930 or 149940
    self.mNoWearEggDesc.color = gs.ColorUtil.GetColor(heroEggDataCfgVo == nil and "FA3A2BFF" or "18ec68FF")
    self.mNoWearEggDesc.text = _TT(lanId)
end

local function __commonRefreshCostInfo(self, cost_tid_list, pay_id, pay_num)
    for i, costInfo in ipairs(cost_tid_list) do
        local propsGrid = PropsGrid:createByData(
            {
                tid = costInfo[1],
                parent = self.mGridCost,
                showUseInTip = false
            }
        )
        propsGrid:setCount(nil, costInfo[2])
        self.mCostPropItemList[i] = propsGrid
    end

    MoneyUtil.setCostIconAndNum(
        pay_id,
        pay_num,
        self.mAriCostIcon,
        self.mTxtCostNum
    )
end

function refreshEggInfo(self, heroVo, isResetAll)
    self.mNodeSkill:SetActive(true)
    self.mAriDnaIconGo:SetActive(true)

    local eggDataCfgVo = dna.DnaManager:getSingleEggDataCfgVoByHeroId(heroVo.id)
    local levelData = eggDataCfgVo:getLevelData(heroVo.egg_lv)

    --刷新选择按钮
    local isMaxQualityEgg = dna.DnaManager:checkIsMaxQualityEgg(eggDataCfgVo)
    self.mNodeSelectBtnBar:SetActive(not isMaxQualityEgg)
    self:setBtnLabel(self.mBtnSelectDna, 149913)

    --刷新图标
    self.mAriDnaIcon:SetImg(eggDataCfgVo:getDnaEggIconUrl())

    --刷新属性
    local fullLevelLimit = eggDataCfgVo:getFullLevelLimit()
    self:refreshAttrInfo(levelData.attr, levelData.lv, fullLevelLimit, isResetAll)

    --刷新技能
    local heroEggDataCfgVo = dna.DnaManager:getSingleHeroEggDataConfigVo(heroVo.tid, true)
    local de_blocking
    if heroEggDataCfgVo then --部分战员会没有战员形态
        de_blocking = heroEggDataCfgVo:getSkillHeroEggLvDataByLv()
    end
    self:refreshSkillInfo(de_blocking)
    self.mTxtDnaSkillNoActive.gameObject:SetActive(true)

    --刷新培养升级
    local isFullLevel = eggDataCfgVo:checkIsFullLevel(heroVo.egg_lv)
    --蛋形态满级时有战员形态配置的可以进行孵化
    local isFuhua = isFullLevel and heroEggDataCfgVo ~= nil and isMaxQualityEgg
    local isShowCost = not isFullLevel or isFuhua
    self.mNodeCost:SetActive(isShowCost)
    if isShowCost then
        if isFuhua then
            local cost_tid_list, pay_id, pay_num = dna.DnaManager:getEggBreakCostInfo()
            __commonRefreshCostInfo(
                self,
                cost_tid_list,
                pay_id,
                pay_num
            )
        else
            __commonRefreshCostInfo(
                self,
                levelData.cost_tid_list,
                levelData.pay_id,
                levelData.pay_num
            )
        end
        local lanId = isFuhua and 149926 or 149914
        self:setBtnLabel(self.mBtnLvlUp, lanId)
    end
    self.mBtnFullLevel:SetActive(not isShowCost)
    --满级描述
    if isFullLevel and not isMaxQualityEgg then --满级了但并不是最高品质的蛋
        self.mTxtFullLevelDesc.gameObject:SetActive(true)
        self.mTxtFullLevelDesc.text = _TT(149929)
    elseif isFullLevel and isMaxQualityEgg and not isFuhua then --满级了最高品质的蛋但没办法进行孵化
        self.mTxtFullLevelDesc.gameObject:SetActive(true)
        self.mTxtFullLevelDesc.text = _TT(149930)
    end

    --刷新升级技能预览
    if isFuhua then
        self.mNodeSkillLvup:SetActive(true)

        local heroSkillUpConfigVo = hero.HeroSkillUpManager:getSkillUpConfigVo(
            heroVo.tid,
            de_blocking[1],
            de_blocking[2]
        )
        local skillVo = fight.SkillManager:getSkillRo(de_blocking[1])
        local skillNameStr = skillVo:getName()
        local skillLvStr = "Lv." .. heroSkillUpConfigVo.skillLvl
        self.mTxtSkillLvupNameLv.text = skillNameStr .. skillLvStr

        self.mTxtSkillLvupDesc.text = _TT(149927)
    end
end

local function checkClickInterval(self)
    local clientTime = GameManager:getClientTime()
    if clientTime - self.lastClick > 3 then
        self.lastClick = clientTime
        return true
    end
    return false
end

function refreshRoleInfo(self, heroVo, isResetAll)
    self.mNodeSkill:SetActive(true)

    self:setEggBgActive(hero.eggType.role)

    local heroEggDataCfgVo = dna.DnaManager:getSingleHeroEggDataConfigVo(heroVo.tid)
    local levelData = heroEggDataCfgVo:getLevelData(heroVo.egg_lv)

    --刷新技能
    local de_blocking = heroEggDataCfgVo:getSkillHeroEggLvDataByLv(heroVo.egg_lv)
    self:refreshSkillInfo(de_blocking)
    self.mTxtDnaSkillNoActive.gameObject:SetActive(false)

    self.mTxtRoleName.gameObject:SetActive(true)
    self.mTxtRoleName.text = heroEggDataCfgVo:getName()
    if isResetAll then
        --刷新形象
        self.dnaFrameAniCtrl:SetActive(true)
        self.dnaFrameAniCtrl:refreshRole(heroEggDataCfgVo:getDnaRoleFrameAniUrl(), heroEggDataCfgVo.tid)
    end

    if isResetAll or checkClickInterval(self) then
        local bubbleData = heroEggDataCfgVo:getRandomBubbleDataByType(heroEggDataCfgVo.frameAniType.smile)
        self.dnaFrameAniCtrl:playAni(bubbleData.type)
        self.dnaBubbleCtrl:playBubbleText(bubbleData.txt)
    end

    --刷新属性
    local fullLevelLimit = heroEggDataCfgVo:getFullLevelLimit()
    self:refreshAttrInfo(levelData.attr, levelData.lv, fullLevelLimit, isResetAll)

    --刷新培养升级
    local isFullLevel = heroEggDataCfgVo:checkIsFullLevel(heroVo.egg_lv)
    --蛋形态满级时有战员形态配置的可以进行孵化
    local isShowCost = not isFullLevel
    self.mNodeCost:SetActive(isShowCost)
    if isShowCost then
        __commonRefreshCostInfo(
            self,
            levelData.cost_tid_list,
            levelData.pay_id,
            levelData.pay_num
        )
        self:setBtnLabel(self.mBtnLvlUp, 149914)

        --刷新升级技能预览
        local next_levelData = heroEggDataCfgVo:getLevelData(heroVo.egg_lv + 1)
        if next_levelData.de_blocking then
            local de_blocking = heroEggDataCfgVo:getSkillHeroEggLvDataByLv(heroVo.egg_lv + 1)
            self.mNodeSkillLvup:SetActive(true)

            local heroSkillUpConfigVo = hero.HeroSkillUpManager:getSkillUpConfigVo(
                heroVo.tid,
                de_blocking[1],
                de_blocking[2]
            )
            local skillVo = fight.SkillManager:getSkillRo(de_blocking[1])
            local skillNameStr = skillVo:getName()
            local skillLvStr = "Lv." .. heroSkillUpConfigVo.skillLvl
            self.mTxtSkillLvupNameLv.text = skillNameStr .. skillLvStr

            self.mTxtSkillLvupDesc.text = _TT(149928)
        end
    end
    self.mBtnFullLevel:SetActive(not isShowCost)
end

--刷新属性栏
function refreshAttrInfo(self, attrList, lv, fullLevelLimit, isResetAll)
    self:destroyAllAttrItemTimeSn()
    self.mTxtDnaLv.gameObject:SetActive(lv ~= nil and fullLevelLimit ~= nil)
    if lv ~= nil and fullLevelLimit ~= nil then
        local lvStr = "<size=15>Lv.</size>%s<size=22>/%s</size>"
        self.mTxtDnaLv.text = string.format(lvStr, lv, fullLevelLimit)
    end
    for i, attrData in ipairs(attrList) do
        local item = SimpleInsItem:create(self.DnaCultivateAttrItem, self.mNodeAttr, "DnaCultivateAttrItem")
        local attrId, attrValue = attrData.key, attrData.value
        item:getChildGO("mTxtAttrName"):GetComponent(ty.Text).text = AttConst.getName(attrId)
        item:getChildGO("mTxtAttrValue"):GetComponent(ty.Text).text = AttConst.getValueStr(attrId, attrValue)

        self.mAttrItemList[i] = item

        if not isResetAll then
            local animator = item:getGo():GetComponent(ty.Animator)
            item:setActive(false)
            local timeSn = LoopManager:setTimeout(i * 0.03, self, function()
                item:setActive(true)
                animator:Play("DnaCultivateAttrItem_Show")
            end)
            self.mAllAttrItemTimeSn[i] = timeSn
        end
    end
end

--刷新技能栏
function refreshSkillInfo(self, de_blocking)
    self.mNodeSkill:SetActive(de_blocking ~= nil)
    if not de_blocking then
        return
    end

    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local heroSkillUpConfigVo = hero.HeroSkillUpManager:getSkillUpConfigVo(
        curHeroVo.tid,
        de_blocking[1],
        de_blocking[2]
    )
    local skillVo = fight.SkillManager:getSkillRo(de_blocking[1])
    self.mAriDnaSkillIcon:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()))
    self.mTxtDnaSkillName.text = skillVo:getName()
    self.mTxtDnaSkillLv.text = "Lv." .. heroSkillUpConfigVo.skillLvl
    self.mTxtDnaSkillDesc.text = heroSkillUpConfigVo:getDesc()
end

function refreshRed(self)
    RedPointManager:remove(self.mBtnManual.transform)
    RedPointManager:remove(self.mBtnSelectDna.transform)
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local isFlag = dna.DnaManager:getReadModelRed(curHeroVo, true)
    if isFlag then
        RedPointManager:add(self.mBtnManual.transform, nil, 17, 18)
    end
    local isFlag = dna.DnaManager:checkIsCanReplaceEgg(curHeroVo)
    if isFlag then
        RedPointManager:add(self.mBtnSelectDna.transform, nil, 135, 30)
    end
end

function playLvlEfx(self)
    self:stopLvlEfx()
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local isRole = curHeroVo:checkDnaStatus(hero.eggType.role)
    local mEffect = isRole and self.mEffect02 or self.mEffect
    mEffect:SetActive(true)
    self.mLvlupTimeSn = LoopManager:setTimeout(2, self, self.stopLvlEfx)
end

function stopLvlEfx(self)
    self:destroyLvlupTimeSn()
    self.mEffect:SetActive(false)
    self.mEffect02:SetActive(false)
end

function destroyLvlupTimeSn(self)
    if self.mLvlupTimeSn then
        LoopManager:clearTimeout(self.mLvlupTimeSn)
        self.mLvlupTimeSn = nil
    end
end

function destroyAllAttrItemTimeSn(self)
    for k, v in pairs(self.mAllAttrItemTimeSn) do
        LoopManager:clearTimeout(v)
        self.mAllAttrItemTimeSn[k] = nil
    end
    self.mAllAttrItemTimeSn = {}
end

function setEggBgActive(self, eggType)
    self.ImgBg2:SetActive(eggType ~= hero.eggType.role)
    self.ImgBg3:SetActive(eggType == hero.eggType.role)
end

function onClickBtnSelectDnaHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_DNA_CULTIVATE_CHOICE_VIEW, {
        heroId = self.mCurHeroId
    }
    )
end

local function commonCheckItem(cost_tid_list, pay_id, pay_num)
    return dna.DnaManager:commonCheckItem(cost_tid_list, pay_id, pay_num, true)
end

function onClickBtnLvlUpHandler(self)
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local isEgg = curHeroVo:checkDnaStatus(hero.eggType.egg)
    local isRole = curHeroVo:checkDnaStatus(hero.eggType.role)
    local cost_tid_list, pay_id, pay_num
    if isEgg then
        local eggDataCfgVo = dna.DnaManager:getSingleEggDataCfgVoByHeroId(curHeroVo.id)
        local levelData = eggDataCfgVo:getLevelData(curHeroVo.egg_lv)
        local heroEggDataCfgVo = dna.DnaManager:getSingleHeroEggDataConfigVo(curHeroVo.tid, true)
        local isFullLevel = eggDataCfgVo:checkIsFullLevel(curHeroVo.egg_lv)
        local isMaxQualityEgg = dna.DnaManager:checkIsMaxQualityEgg(eggDataCfgVo)
        local isFuhua = isFullLevel and heroEggDataCfgVo ~= nil and isMaxQualityEgg
        if isFuhua then
            cost_tid_list, pay_id, pay_num = dna.DnaManager:getEggBreakCostInfo()
        else
            cost_tid_list, pay_id, pay_num = levelData.cost_tid_list, levelData.pay_id, levelData.pay_num
        end
        if commonCheckItem(cost_tid_list, pay_id, pay_num) then
            if isFuhua then
                UIFactory:alertMessge(_TT(149935), nil, function()
                    GameDispatcher:dispatchEvent(EventName.REQ_LVLUP_DNA_HATCH, {
                        hero_id = self.mCurHeroId
                    })
                end)
            else
                GameDispatcher:dispatchEvent(EventName.REQ_LVLUP_DNA_EGG, {
                    hero_id = self.mCurHeroId
                })
            end
        end
    elseif isRole then
        local heroEggDataCfgVo = dna.DnaManager:getSingleHeroEggDataConfigVo(curHeroVo.tid)
        local levelData = heroEggDataCfgVo:getLevelData(curHeroVo.egg_lv)
        cost_tid_list, pay_id, pay_num = levelData.cost_tid_list, levelData.pay_id, levelData.pay_num
        if commonCheckItem(cost_tid_list, pay_id, pay_num) then
            GameDispatcher:dispatchEvent(EventName.REQ_LVLUP_DNA_EGG, {
                hero_id = self.mCurHeroId
            })
        end
    else
        logError("dna状态错误")
        return
    end
end

function onClickBtnManualHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_DNA_MANUAL_VIEW)
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    if dna.DnaManager:getReadModelRed(curHeroVo, true) then
        dna.DnaManager:setReadModelRed(self.mCurHeroId)
    end
end

function onClickBtnSwitchAttrHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_DNA_SWITCH_ACTIVE_ATTR_VIEW, { heroId = self.mCurHeroId })
end

function onClickBackListHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_SHOW_SELECT_PANEL, {
        teamId = self.teamId,
        beforeSelectionCheckFunction = function(heroId)
            return dna.DnaManager:checkHeroDnaFuncOpen(heroId, true)
        end
    }
    )
end

local randomLanguage = {
    149919,
    149920,
    149921
}
local randomLimit = #randomLanguage
local lastRandomBubbleK
local function getEggBubbleTextRandom()
    local k
    local repeatCount = 0
    repeat
        k = math.random(1, randomLimit)
        repeatCount = repeatCount + 1
    until k ~= lastRandomBubbleK or repeatCount == 100
    lastRandomBubbleK = k or 1
    return _TT(randomLanguage[lastRandomBubbleK]) or ""
end

function onClickEggHandler(self)
    if checkClickInterval(self) then
        self.dnaBubbleCtrl:playBubbleText(getEggBubbleTextRandom())
    end
end

function onClickRoleHandler(self)
    if checkClickInterval(self) then
        local heroEggDataCfgVo = dna.DnaManager:getSingleHeroEggDataCfgVoByHeroId(self.mCurHeroId)
        local bubbleData = heroEggDataCfgVo:getRandomBubbleDataByType()
        self.dnaFrameAniCtrl:playAni(bubbleData.type)
        self.dnaBubbleCtrl:playBubbleText(bubbleData.txt)
    end
end

function onClicBtnDnaClickHandler(self)
    local curHeroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local isEgg = curHeroVo:checkDnaStatus(hero.eggType.egg)
    local isRole = curHeroVo:checkDnaStatus(hero.eggType.role)
    if isEgg then
        self:onClickEggHandler()
    elseif isRole then
        self:onClickRoleHandler()
    end
end

function onClicBtnSkillAllLvHandler(self)
    local heroVo = hero.HeroManager:getHeroVo(self.mCurHeroId)
    local heroEggDataCfgVo = dna.DnaManager:getSingleHeroEggDataConfigVo(heroVo.tid)
    local de_blocking = heroEggDataCfgVo:getSkillHeroEggLvDataByLv(heroVo.egg_lv)
    local isRole = heroVo:checkDnaStatus(hero.eggType.role)
    GameDispatcher:dispatchEvent(EventName.OPEN_DNA_SKILL_ALL_LV_TIPS_VIEW, {
        heroVo = heroVo,
        heroEggDataCfgVo = heroEggDataCfgVo,
        cur_de_blocking = de_blocking,
        isActiveSkill = heroEggDataCfgVo ~= nil and isRole
    }
    )
end

function onHeroDataUpdateHandler(self, msg)
    if msg.heroId ~= self.mCurHeroId then
        return
    end
    self:refreshView(self.isCurHeroPreData)
end

function onUpdateHeadHandler(self)
    self.mCurHeroId = hero.HeroManager:getPanelShowHeroId()
    self:refreshView(true)
end

function onDnaIncubateSucceedHandler(self)
    self:refreshView(true)
end

function onDnaLvUpHandler(self)
    self:playLvlEfx()
end

function onUpdateModuleReadHandler(self)
    self:refreshRed()
    --触达红点关联到所有解锁有孵化的战员 所以需要通知全部检查
    GameDispatcher:dispatchEvent(EventName.CHECK_ALL_HERO_RED)
end

return _M

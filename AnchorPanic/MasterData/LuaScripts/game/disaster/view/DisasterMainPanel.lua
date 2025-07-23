-- 灾厄主界面
module("disaster.DisasterMainPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("disaster/DisasterMainPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(104001))
    self:setSize(0, 0)
    self:setBg("disaster_main.jpg", false, "disaster")
    self:setUICode(LinkCode.Disaster)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mDifItems = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTxtRemTime = self:getChildGO("mTxtRemTime"):GetComponent(ty.Text)
    self.mTxtWar = self:getChildGO("mTxtWar"):GetComponent(ty.Text)

    self.mBtnFightAward = self:getChildGO("mBtnFightAward")
    self.mBtnRank = self:getChildGO("mBtnRank")
    self.mTxtCurFight = self:getChildGO("mTxtCurFight"):GetComponent(ty.Text)
    self.mTxtRem = self:getChildGO("mTxtRem"):GetComponent(ty.Text)
    self.mTxtAllFight = self:getChildGO("mTxtAllFight"):GetComponent(ty.Text)
    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mBtnCheckEnemy = self:getChildGO("mBtnCheckEnemy")
    self.mDifScroll = self:getChildGO("mDifScroll"):GetComponent(ty.ScrollRect)
    self.mDifItem = self:getChildGO("mDifItem")
    self.mInfInfo = self:getChildGO("mInfInfo")
    self.mBtnShop = self:getChildGO("mBtnShop")
    self.mTxtFight = self:getChildGO("mTxtFight"):GetComponent(ty.Text)

    self.mBtnFuncTips = self:getChildGO("mBtnFuncTips")

    self:setGuideTrans("functips_disaster_scroll", self:getChildTrans("mDifScroll"))
    self:setGuideTrans("functips_disaster_allFight", self:getChildTrans("mTxtAllFight"))
    self:setGuideTrans("functips_disaster_btns", self:getChildTrans("function_disaster_btns"))
    self:setGuideTrans("functips_disaster_checkBoss", self:getChildTrans("mBtnCheckEnemy"))
    self:setGuideTrans("functips_disaster_remTimes", self:getChildTrans("mTxtRem"))

end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})

    GameDispatcher:addEventListener(EventName.UPDATE_DISASTER_MAIN_PANEL, self.showPanel, self)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DISASTER_MAIN_PANEL, self.showPanel, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    self:clearDifItems()
    if self.mMonTimeloopSn then
        LoopManager:removeTimerByIndex(self.mMonTimeloopSn)
    end
    self.mMonTimeloopSn = nil
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.onBtnFightClick)
    self:addUIEvent(self.mBtnCheckEnemy, self.checkEnemyFormation)
    self:addUIEvent(self.mBtnFightAward, self.onBtnFightAwardClick)
    self:addUIEvent(self.mBtnRank, self.onBtnRankClick)

    self:addUIEvent(self.mBtnShop, self.onShopClick)
    self:addUIEvent(self.mBtnFuncTips, self.onClickFuncTipsHandler)
end

function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, {
        id = LinkCode.Disaster
    })
end

function onShopClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {
        linkId = LinkCode.ShopDisaster
    })
end

function onBtnRankClick(self)
    GameDispatcher:dispatchEvent(EventName.REQ_DISASTER_RANK_PANEL)
    -- GameDispatcher:dispatchEvent(EventName.OPEN_DISASTER_RANK_PANEL)
end

function onBtnFightAwardClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_DISASTER_FIGHT_AWARD_PANEL)
end

function checkEnemyFormation(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_DISASTER_BOSS_PANEL, {
        curDif = self.curDif,
        dupVo = self.mDupVo
    })
    -- GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_PREVIEW, {dupVo = self.mDupVo})
end

function onBtnFightClick(self)

    local maxDif = disaster.DisasterManager:getDisasterDupMaxDif()
    local remCount, allCount = disaster.DisasterManager:getRemCount()
    if self.curDif < maxDif then

        if disaster.DisasterManager:getCurChallengingDif() > 0 then
            local curDif = disaster.DisasterManager:getCurChallengingDif()
            local dupVo = disaster.DisasterManager:getDisasterDupDataByDif(curDif)

            formation.checkFormationFight(PreFightBattleType.Disaster, DupType.Disaster, dupVo.dupId,
                formation.TYPE.DISASTER, nil, nil, nil)
        else
            if remCount <= 0 then
                gs.Message.Show("挑战次数不足")
                return
            end

            UIFactory:alertMessge(_TT(104010), true, function()
                -- self:close()
                disaster.DisasterManager:setCurChallengingDif(self.curDif)
                GameDispatcher:dispatchEvent(EventName.REQ_CHALLENGE_DISASTER, {
                    dif = self.curDif
                })
            end, _TT(1), nil, true, function()
            end, _TT(2), _TT(5))
        end
    else
        if disaster.DisasterManager:getCurChallengingDif() > 0 then
            local curDif = disaster.DisasterManager:getCurChallengingDif()
            local dupVo = disaster.DisasterManager:getDisasterDupDataByDif(curDif)

            formation.checkFormationFight(PreFightBattleType.Disaster, DupType.Disaster, dupVo.dupId,
                formation.TYPE.DISASTER, nil, nil, nil)
        else
            -- if remCount <= 0 then
            --     gs.Message.Show("挑战次数不足")
            --     return
            -- end

            UIFactory:alertMessge(_TT(104014), true, function()
                -- self:close()
                disaster.DisasterManager:setCurChallengingDif(self.curDif)
                GameDispatcher:dispatchEvent(EventName.REQ_CHALLENGE_DISASTER, {
                    dif = self.curDif
                })
            end, _TT(1), nil, true, function()
            end, _TT(2), _TT(5), nil, RemindConst.DISASTER_FIGHT)
        end
    end
end

function getDifTxt(self, index)
    local s = ""
    if index == 1 then
        s = "Ⅰ"
    elseif index == 2 then
        s = "Ⅱ"
    elseif index == 3 then
        s = "Ⅲ"
    elseif index == 4 then
        s = "Ⅳ"
    elseif index == 5 then
        s = "Ⅴ"
    elseif index == 6 then
        s = "Ⅵ"
    elseif index == 7 then
        s = "Ⅶ"
    elseif index == 8 then
        s = "Ⅷ"
    elseif index == 9 then
        s = "Ⅸ"
    elseif index == 10 then
        s = "Ⅹ"
    end
    return s
end

function showPanel(self)
    --self.mBtnShop:SetActive(false)
    self.curDif = disaster.DisasterManager:getCurDif()

    self:clearDifItems()
    local maxDif = disaster.DisasterManager:getDisasterDupMaxDif()
    for i = 1, maxDif do
        local item = SimpleInsItem:create(self.mDifItem, self.mDifScroll.content, "mDisasterDufItem")
        item:getChildGO("mTxtDif"):GetComponent(ty.Text).text = self:getDifTxt(i)

        local isCur = i == self.curDif
        local isBoss = i == maxDif
        local isPass = i < self.curDif

        item:getChildGO("mTxtDif"):GetComponent(ty.Text).gameObject:SetActive(not isBoss)
        item:getChildGO("mTxtDif"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor(
            i > self.curDif and "82898cff" or "323232ff")
        local icon = ""
        if (isCur) then
            icon = isBoss and UrlManager:getPackPath("disaster/boss.png") or UrlManager:getPackPath("disaster/def.png")
        else
            icon = isBoss and UrlManager:getPackPath("disaster/bossLock.png") or
                       (isPass and UrlManager:getPackPath("disaster/def.png") or
                           UrlManager:getPackPath("disaster/defLock.png"))
        end
        item:getChildGO("mIcon"):GetComponent(ty.AutoRefImage):SetImg(icon)

        item:getChildGO("mIsPass"):SetActive(isPass)
        item:getChildGO("mLine"):GetComponent(ty.Image).color =
            isPass and gs.ColorUtil.GetColor("FFFFFFFF") or gs.ColorUtil.GetColor("FFFFFF80")
        table.insert(self.mDifItems, item)
    end
    self.mDupVo = disaster.DisasterManager:getDisasterDupDataByDif(self.curDif)

    gs.TransQuick:UIPosY(self.mDifScroll.content, gs.Mathf.Clamp(91 * (self.curDif - 3), 0, 488))

    self.mTxtRem.gameObject:SetActive(self.curDif < maxDif)
    local remCount, allCount = disaster.DisasterManager:getRemCount()
    self.mTxtRem.text = _TT(104002, remCount, allCount) -- "剩余挑战次数:" .. remCount .. "/" .. allCount
    self.mTxtAllFight.text = _TT(104003) .. disaster.DisasterManager:getAllFight()

    self.mInfInfo:SetActive(self.curDif == maxDif)
    -- self.mTxtCurFight.gameObject:SetActive(self.curDif == maxDif)
    self.mTxtCurFight.text = _TT(104004) .. disaster.DisasterManager:getInfDamage()

    self.mTxtFight.text = disaster.DisasterManager:getCurChallengingDif() > 0 and _TT(104022) or _TT(123)

    self.mTxtWar.text = disaster.DisasterManager:getDisasterWarTxt()
    self.endTime = disaster.DisasterManager:getDisasterOverTime()
    if self.mMonTimeloopSn then
        LoopManager:removeTimerByIndex(self.mMonTimeloopSn)
    end
    self.mMonTimeloopSn = self:addTimer(1, 0, self.onMonTimerLoop)
    self:onMonTimerLoop()

    self:updateRed()
end

function onMonTimerLoop(self)
    local serverTime = GameManager:getClientTime()
    local s = TimeUtil.getFormatTimeBySeconds_9(self.endTime - serverTime)
    self.mTxtRemTime.text = _TT(3530) .. s

    if (self.endTime - serverTime < 0) then
        gs.Message.Show("活动结束")
        self:close()
    end
end

function clearDifItems(self)
    for i = 1, #self.mDifItems do
        self.mDifItems[i]:poolRecover()
    end
    self.mDifItems = {}
end

function updateRed(self)
    if disaster.DisasterManager:getAwardRed() then
        RedPointManager:add(self.mBtnFightAward.transform, nil, 80, 18)
    else
        RedPointManager:remove(self.mBtnFightAward.transform)
    end

    if disaster.DisasterManager:getCanFight() then
        RedPointManager:add(self.mBtnFight.transform, nil, 124.6, 18)
    else
        RedPointManager:remove(self.mBtnFight.transform)
    end
end

return _M

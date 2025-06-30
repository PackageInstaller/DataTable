module("arena.ArenaPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("arenaHall/arena/ArenaPanel.prefab")
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
destroyTime = 0 -- 自动销毁时间-1默认

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(52002))
    self:setBg("")
    self:setUICode(LinkCode.PvpArena)
end

-- 初始化数据
function initData(self)
end

function configUI(self)
    super.configUI(self)
    self.mBtnLog = self:getChildGO("mBtnLog")
    self.mBtnShop = self:getChildGO("mBtnShop")
    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mBtnAward = self:getChildGO("mBtnAward")
    self.mBtnAttack = self:getChildGO("mBtnAttack")
    self.mBtnDefense = self:getChildGO("mBtnDefense")
    self.mClickerArea = self:getChildGO("mClickerArea")
    self.mBtnFuncTips = self:getChildGO("mBtnFuncTips")
    self.mBtnShowReward = self:getChildGO("mBtnShowReward")
    self.mGroupMatching = self:getChildGO("mGroupMatching")
    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
    self.mGroupItem = self:getChildGO("mGroupItem").transform
    self.mBtnCencelMatching = self:getChildGO('mBtnCencelMatching')
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
    self.mTxtItem = self:getChildGO("mTxtItem"):GetComponent(ty.Text)
    self.mTxtTileFree = self:getChildGO("mTxtTileFree"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO('mTxtName'):GetComponent(ty.Text)
    self.mTxtRank = self:getChildGO("mTxtRank"):GetComponent(ty.Text)
    self.mTxtScore = self:getChildGO("mTxtScore"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtSeasonDec = self:getChildGO('mTxtSeasonDec'):GetComponent(ty.Text)
    self.mIconItem = self:getChildGO("mIconItem"):GetComponent(ty.AutoRefImage)
    self.mBtnIcon = self:getChildGO("mBtnIcon"):GetComponent(ty.Button)
    self.mTxtTitleScore = self:getChildGO("mTxtTitleScore"):GetComponent(ty.Text)
    self.mImgCurRank = self:getChildGO('mImgCurRank'):GetComponent(ty.AutoRefImage)
    self.mImgProgressBar = self:getChildGO("mImgProgressBar"):GetComponent(ty.Image)
    self.mTxtMatchingTime = self:getChildGO("mTxtMatchingTime"):GetComponent(ty.Text)
    self.mBtnClickCurPank = self:getChildGO('mImgCurRank')
    self:setGuideTrans("funcTips_arena_1", self:getChildTrans("mFunctionTips_arena_1"))
    self:setGuideTrans("funcTips_arena_2", self:getChildTrans("mFunctionTips_arena_2"))
    self:setGuideTrans("funcTips_arena_3", self:getChildTrans("mFunctionTips_arena_3"))
    self:setGuideTrans("funcTips_arena_4", self:getChildTrans("mFunctionTips_arena_4"))
    self:setGuideTrans("funcTips_arena_5", self:getChildTrans("mFunctionTips_arena_5"))
    self:setGuideTrans("funcTips_arena_6", self:getChildTrans("mFunctionTips_arena_6"))
    self:setGuideTrans("funcTips_arena_7", self:getChildTrans("mFunctionTips_arena_7"))
    self:setGuideTrans("funcTips_arena_8", self.mBtnAward.transform)
    self:setGuideTrans("funcTips_arena_9", self:getChildTrans("mFunctionTips_arena_8"))

    self.mTxtWar = self:getChildGO("mTxtWar"):GetComponent(ty.Text)
    -- self.mBtnAward =self:getChildGO("mBtnAward")
end

function initViewText(self)
    self.mTxtTitleScore.text = _TT(159)
    self.mTxtTitle.text = _TT(48017) --"竞技场"
    self.mTxtSeasonDec.text = _TT(48019) --赛季倒计时
    self:setBtnLabel(self.mBtnShop, nil, "物资")
    self:setBtnLabel(self.mBtnLog, 62205, "战斗记录")
    -- self:setBtnLabel(self.mBtnAward, 62203, "排行榜单")
    self:setBtnLabel(self.mBtnFight, 48026, "寻找对手")
    self:setBtnLabel(self.mBtnAttack, 62206, "进攻队列")
    self:setBtnLabel(self.mBtnCencelMatching, 200, "取消匹配")
    self:setBtnLabel(self.mBtnDefense, 62204, "防守队列")
    self:setBtnLabel(self.mBtnShowReward, 62207, "奖励一览")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLog, self.onClickLogHandler)
    self:addUIEvent(self.mBtnShop, self.onClickShopHandler)
    self:addUIEvent(self.mBtnAward, self.onClickRankHandler)
    self:addUIEvent(self.mBtnAttack, self.onClickAttackHandler)
    self:addUIEvent(self.mBtnDefense, self.onClickDefenseHandler)
    self:addUIEvent(self.mBtnFight, self.onClickChallengeHandler)
    self:addUIEvent(self.mBtnFuncTips, self.onClickFuncTipsHandler)
    self:addUIEvent(self.mBtnShowReward, self.onClickShowRewardHandler)
    self:addUIEvent(self.mBtnCencelMatching, self.onClickCencelMatchingHandler)
    self:addUIEvent(self.mBtnIcon, self.onClickCoinHandler)
    self:addUIEvent(self.mBtnClickCurPank, self.onClickShowRewardHandler)
end

function active(self)
    super.active(self)
    if arena.ArenaManager:getActionAni() then
        arena.ArenaManager:setActionAni(false)
        self.mAnimator:Play("ArenaPanel_Show")
        self.mAnimator.enabled = false
        self.mAnimator:Update(0)
        self.dt = gs.DT.DOTween:Sequence():AppendInterval(0):AppendCallback(function()
            self.mAnimator.enabled = true
            self.dt:Kill()
        end):Play()
    end
    MoneyManager:setMoneyTidList({ MoneyTid.ARENA_CHALLENGE_TICKET_TID })
    hero.HeroManager:addEventListener(hero.HeroManager.PANEL_SHOW_HERO_CHANGE, self.onUpdatePanelShowHeroHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.onUpdateHeroDetailDataHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ARENA_INFO, self.updateView, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ARENA_HALL_INFO, self.onGetEndTime, self)
    GameDispatcher:addEventListener(EventName.OPEN_ARENA_CHALLENGE, self.onSendChallengeOKHandler, self)
    GameDispatcher:addEventListener(EventName.ACCOUNT_RELOGIN_SUC, self.onRelogin, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateView, self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.updateView, self)
    -- if arena.ArenaManager:getFightInfo() then
    --     GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_DAN_PANEL, arena.ArenaManager.myFightInfo)
    -- end
    self.mMatchingTime = 0
    self.mTime = 0
    if arena.ArenaManager:getSeasonEndTime() == nil then
        GameDispatcher:dispatchEvent(EventName.REQ_ARENA_ALL_INFO)
    else
        self:onGetEndTime()
    end
    self:reqInfo()
    self.mGroupMatching:SetActive(false)
    self:updateView(true)
    self.mTxtWar.text = arena.ArenaManager:getArenaWarTxt()
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    hero.HeroManager:removeEventListener(hero.HeroManager.PANEL_SHOW_HERO_CHANGE, self.onUpdatePanelShowHeroHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_DATA_UPDATE, self.onUpdateHeroDetailDataHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ARENA_INFO, self.updateView, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ARENA_HALL_INFO, self.onGetEndTime, self)
    GameDispatcher:removeEventListener(EventName.OPEN_ARENA_CHALLENGE, self.onSendChallengeOKHandler, self)
    GameDispatcher:removeEventListener(EventName.ACCOUNT_RELOGIN_SUC, self.onRelogin, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateView, self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.updateView, self)
    LoopManager:removeTimerByIndex(self.endTimeSign)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ARENA_FIGHT_INFO, nil)
    LoopManager:removeTimerByIndex(self.matchSign)
    self:onClickCencelMatchingHandler()
end

-- 重连成功界面未关闭，证明未进入战斗，重新请求进入
function onRelogin(self)
    GameDispatcher:dispatchEvent(EventName.REQ_ARENA_OK, { type = 2 })
end

function reqInfo(self)
    GameDispatcher:dispatchEvent(EventName.REQ_ARENA_HALL_INFO, {})
    GameDispatcher:dispatchEvent(EventName.REQ_ARENA_PANEL_INFO, {})
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    arena.ArenaManager:setActionAni(true)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    arena.ArenaManager:setActionAni(true)
end
--打开排行榜页面
function onClickRankHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_RANK_PANEL, {})
end
--打开防守页面
function onClickDefenseHandler(self)
    formation.openFormation(formation.TYPE.ARENA_DEFENSE, nil, nil, nil)
end
--打开战斗记录页面
function onClickLogHandler(self)
    --GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_LOG_PANEL, {})
    GameDispatcher:dispatchEvent(EventName.REQ_ARENA_LOG)
end
--打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.PvpArena })
end
--打开军械所页面
function onClickShopHandler(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_STOP_ARM, true) == false then
        return
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.ShopArm })
end
--打开进攻页面
function onClickAttackHandler(self)
    formation.openFormation(formation.TYPE.ARENA_ATTACK, nil, nil, nil)
end
--打开奖励一览页面
function onClickShowRewardHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_ARENA_AWARD_PANEL)
end

--弹挑战币弹窗
function onClickCoinHandler(self)
    local shopVo = shop.ShopManager:getShopItemByTid(ShopType.NOMAL, MoneyTid.ARENA_CHALLENGE_TICKET_TID)
    GameDispatcher:dispatchEvent(EventName.OPEN_SHOP_BUY_PANEL, shopVo)
end

function updateView(self, cusIsInit)
    local roleVo = role.RoleManager:getRoleVo()
    local rank = arena.ArenaManager.myDailyRank
    self.mTxtRank.text = rank > 100 and _TT(62220) or rank
    if arena.ArenaManager.mySeasonRank == 0 then
        self.mTxtRank.text = _TT(62220)
    end
    self.mIconItem:SetImg(MoneyUtil.getMoneyIconUrlByTid(MoneyTid.ARENA_CHALLENGE_TICKET_TID), true)

    local score = arena.ArenaManager.myScore
    if arena.ArenaManager.mysegment > 0 then
        local subValue = 0
        local nextNeedScore = nil
        if arena.ArenaManager.myScore >= arena.ArenaManager:getMaxSegmentNeedScore() then
            subValue = score / arena.ArenaManager:getMaxSegmentNeedScore()
            local lv = 0
            if arena.ArenaManager.mysegment < #arena.ArenaManager.mAwardList then
                lv = arena.ArenaManager.mysegment + 1
            else
                lv = arena.ArenaManager.mysegment
            end
            nextNeedScore = arena.ArenaManager.myScore >= arena.ArenaManager:getMaxSegmentNeedScore() and score or arena.ArenaManager:getSegmentVo(lv).needScore
            self.mTxtScore.text = score
        else
            local lv = 0
            if arena.ArenaManager.mysegment < #arena.ArenaManager.mAwardList then
                lv = arena.ArenaManager.mysegment + 1
            else
                lv = arena.ArenaManager.mysegment
            end
            subValue = (score - arena.ArenaManager:getSegmentVo(arena.ArenaManager.mysegment).needScore) / (arena.ArenaManager:getSegmentVo(lv).needScore - arena.ArenaManager:getSegmentVo(arena.ArenaManager.mysegment).needScore)
            nextNeedScore = arena.ArenaManager.myScore >= arena.ArenaManager:getMaxSegmentNeedScore() and score or arena.ArenaManager:getSegmentVo(lv).needScore
            self.mTxtScore.text = score .. "/" .. nextNeedScore
        end
        self.mTxtName.text = _TT(arena.ArenaManager:getSegmentVo(arena.ArenaManager.mysegment).rankName)
        self.mImgCurRank:SetImg(arena.ArenaManager:getSegmentVo(arena.ArenaManager.mysegment):getRankIcon(), true)
        self.mImgProgressBar.fillAmount = subValue
    end
    self.mTxtTileFree.text = HtmlUtil:color(_TT(151), "ffffffff")
    if (arena.ArenaManager.remainChallengeTimes > 0) then
        self.mIconItem.gameObject:SetActive(false)
        self.mTxtTileFree.gameObject:SetActive(true)
        self.mTxtItem.text = arena.ArenaManager.remainChallengeTimes .. "/3"
    else
        local itemNum = sysParam.SysParamManager:getValue(18, 1)
        local strItemNum = bag.BagManager:getPropsCountByTid(MoneyTid.ARENA_CHALLENGE_TICKET_TID) >= itemNum and HtmlUtil:color(bag.BagManager:getPropsCountByTid(MoneyTid.ARENA_CHALLENGE_TICKET_TID), "25e8ffff") or HtmlUtil:color(bag.BagManager:getPropsCountByTid(MoneyTid.ARENA_CHALLENGE_TICKET_TID), "ed1941FF")
        self.mTxtItem.text = strItemNum .. "/" .. itemNum
        self.mIconItem.gameObject:SetActive(true)
        self.mTxtTileFree.gameObject:SetActive(false)
    end
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mGroupItem)
end

--获取赛季结束时间
function onGetEndTime(self)
    self.mEndTime = arena.ArenaManager:getSeasonEndTime()
    self:updateTime()
    self.endTimeSign = LoopManager:addTimer(1, 0, self, self.updateTime)
end

--定时器
function updateTime(self)
    local clientTime = GameManager:getClientTime()
    local remainTime = self.mEndTime - clientTime
    if (remainTime < 0) then
    else
        self.mTxtTime.text = TimeUtil.getFormatTimeBySeconds_1(remainTime)
    end
end

--进入战斗等待页面
function onClickChallengeHandler(self, args)
    if bag.BagManager:getPropsCountByTid(MoneyTid.ARENA_CHALLENGE_TICKET_TID) < sysParam.SysParamManager:getValue(18, 1) then
        GameDispatcher:dispatchEvent(EventName.REQ_ARENA_OK, { type = 2 })
    else
        self.mBtnFuncTips:SetActive(false)
        self.base_childGos["mGroupTop"]:SetActive(false)
        self.mMatchingTime = math.floor(math.random(sysParam.SysParamManager:getValue(SysParamType.MATCHIMGTIME_MINTIME), sysParam.SysParamManager:getValue(SysParamType.MATCHIMGTIME_MAXTIME)))
        self.mGroupMatching:SetActive(true)
        self.matchSign = LoopManager:addTimer(1, 0, self, self.updateMatchingTimer)
        self:updateMatchingTimer()
    end
end

--进入战斗
function onSendChallengeOKHandler(self)
    if (arena.ArenaManager.remainChallengeTimes > 0) then
        self:onSendChallenge()
    else
        local costTid = sysParam.SysParamManager:getValue(SysParamType.ARENA_CHALLENGE_COST_TID)
        local costCount = sysParam.SysParamManager:getValue(SysParamType.ARENA_CHALLENGE_COST_COUNT)
        local judgeType = shop.ShopManager:getPropsJudgeType(costTid, costCount)
        if (judgeType == shop.PropsJudge.PROPS_ENOUGH) then
            self:onSendChallenge()
        elseif (judgeType ~= shop.PropsJudge.MONEY_ENOUGH and judgeType ~= shop.PropsJudge.MONEY_NOT_ENOUGH) then
            gs.Message.Show(_TT(156))
        end
    end
end

-- 发送挑战
function onSendChallenge(self)
    GameDispatcher:dispatchEvent(EventName.REQ_ARENA_ENEMY, {})
end

--删除战斗等待页面数据
function onClickCencelMatchingHandler(self)
    self.base_childGos["mGroupTop"]:SetActive(true)
    self.mGroupMatching:SetActive(false)
    LoopManager:removeTimerByIndex(self.matchSign)
    self.matchSign = nil
    self.mTime = 0
    self.mMatchingTime = 0
end

--刷新战斗等待页面倒计时（随机）
function updateMatchingTimer(self)
    self.mTime = self.mTime + 1
    local hStr = TimeUtil.getHMSByTime(self.mTime)
    self.mTxtMatchingTime.text = string.sub(hStr, 4, -1)
    if self.mTime == self.mMatchingTime then
        -- 断网了让它继续计时，但是不进来，走relogin
        GameDispatcher:dispatchEvent(EventName.REQ_ARENA_OK, { type = 2 })
    end
end

--段位不同显示图片
function UpdateShowDanImg(self, pathNum)
    self.mImgCurRank:SetImg(UrlManager:getPackPath("arean/arean_" .. pathNum .. ".png"))
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(62220):	"未上榜"
]]
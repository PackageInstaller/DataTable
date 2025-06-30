--[[ 
-----------------------------------------------------
@filename       : BuildBaseDroneSpView
@Description    : 正在派遣任务 点击弹窗
@date           : 2023-02-25 11:40:02
@Author         : Tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("buildBase.DispatchDockIncompleteView ", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("buildBase/DispatchDockIncompleteView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1117, 520)
    self:setTxtTitle("派遣战员")
end
-- 析构  
function dtor(self)
    super.dtor(self)
end

function initData(self)
    super.initData(self)
    self.mSlotTransDic = {}
    self.mSlotsDic = {}
    self.heroPosList = {}
    self.mBaseItems = {}
    self.mExtraItems = {}
    self.mStarsDic = {}
    self.mHeroHeadDic = {}
end

-- 初始化
function configUI(self)
    self.mTxtTile = self:getChildGO("mTxtTile"):GetComponent(ty.Text)
    self.mTxtDis = self:getChildGO("mTxtDis"):GetComponent(ty.Text)
    self.mTxtTimer = self:getChildGO("mTxtTimer"):GetComponent(ty.Text)
    self.mBtnSpeedUp = self:getChildGO("mBtnSpeedUp"):GetComponent(ty.Button)
    self.mBtnRecall = self:getChildGO("mBtnRecall"):GetComponent(ty.Button)
    self.mTxtRate = self:getChildGO("mTxtRate"):GetComponent(ty.Text)
    self.mBaseItemsTrans = self:getChildTrans("mBaseGroup")
    self.mBaseItem = self:getChildGO("mBaseItem")
    self.mExtraItemsTrans = self:getChildTrans("mExtraGroup")
    self.mExtraItem = self:getChildGO("mExtraItem")
    self.mBtnDispatchedMember = self:getChildGO("mBtnDispatchedMember")
    self.mDispatchedGroup = self:getChildTrans("mDispatchedGroup ")
end

-- 激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.RESPONSE_BUILDBASE_DISPATCH_SPEEDUP, self.onUpdateSpeedUpHanlder, self)
    self.taskId = args.taskId
    self.buildId = buildBase.DispatchDockManager:getBaseBuildId()
    self.exploreId = args.exploreId
    self.mEndTime = buildBase.DispatchDockManager:getAreaInfo(self.exploreId).endTIme
    self:updateData()
    self:init()
end

-- 销毁
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.RESPONSE_BUILDBASE_DISPATCH_SPEEDUP, self.onUpdateSpeedUpHanlder, self)
    self:clearItems()
    LoopManager:removeTimer(self, self.onUpdateChargeTimerInfo)
end


function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSpeedUp, self.onSpeedUpHandler)
    self:addUIEvent(self.mBtnRecall, self.onReCallHandler)

end

function closeAll(self)
    super.closeAll(self)

end

function init(self)
    self.mTxtTile.text = _TT(self.mTaskConfig.title)
    self.mTxtDis.text = _TT(self.mTaskConfig.des)
    self:updateTimer()
    self:updateBaseItem()
    self:updateExtraItems()
    self:updateStars()
    self:updateHero()

end

function onUpdateSpeedUpHanlder(self, exploreId)
    self.mEndTime = buildBase.DispatchDockManager:getAreaInfo(exploreId).endTIme
    if self.mEndTime - GameManager:getClientTime() > 0 then
        self:updateData()
        self:updateTimer()
    else
        self:close()
    end

end

function updateData(self)
    self.mTaskConfig = buildBase.DispatchDockManager:getTaskConfig(self.taskId)
    self.mHeroPosInfos = buildBase.DispatchDockManager:getAreaHeroInfo(self.exploreId)
end

function updateHero(self)
    if not self.mHeadTrans then
        self.mHeadTrans = {}
        self.mGroupGo = {}
        for i = 1, 3 do
            self.mHeadTrans[i] = self:getChildTrans("mBtnAddMember_0" .. i)
            self.mGroupGo[i] = self:getChildGO("mBtnAddMember_0" .. i)
            self.mGroupGo[i]:SetActive(false)
        end
    end
    for i = 1, 3 do
        self.mGroupGo[i]:SetActive(false)
    end
    if self.mHeroPosInfos then
        for _, heroTid in pairs(self.mHeroPosInfos) do
            local heroVo = hero.HeroManager:getHeroConfigVo(heroTid)
            local heroHead = HeroHeadGrid:poolGet()
            heroHead:setData(heroVo)
            heroHead:setEleType(false)
            heroHead:setShowColor(false)
            heroHead:setType(false)-- heroHead.m_childTrans["ImgColorBg"]:GetComponent(ty.AutoRefImage).gameObject:SetActive(false)
            heroHead:setScale(0.82)
            heroHead:setParent(self.mHeadTrans[_])
            self.mHeroHeadDic[_] = heroHead
            self.mGroupGo[_]:SetActive(true)
        end
    end

end


function updateTimer(self)
    -- self:onUpdateChargeTimerInfo()
    LoopManager:removeTimer(self, self.onUpdateChargeTimerInfo)
    self:onUpdateChargeTimerInfo()
    LoopManager:addTimer(1, 0, self, self.onUpdateChargeTimerInfo)
end
-- 倒计时

function onUpdateChargeTimerInfo(self)
    local reamainTime = self.mEndTime - GameManager:getClientTime()
    if (reamainTime < 0) then
    else
        self.mTxtTimer.text = TimeUtil.getHMSByTime(reamainTime)
    end
end

function updateBaseItem(self)
    self:clearBaseItems()
    local itemDic = buildBase.DispatchDockManager:getBaseItemCofigs(self.taskId)
    for _, vo in pairs(itemDic) do
        local propsGrid = PropsGrid:createByData({ tid = vo.tid, num = vo.num, parent = self.mBaseItemsTrans, scale = 0.53, showUseInTip = false })
        self.mBaseItems[_] = propsGrid
    end
end

function updateExtraItems(self)
    self:clearExtraItems()
    local rateHelper = 0
    local baseLen = #self.mHeroPosInfos
    local taskVo = buildBase.DispatchDockManager:getTaskConfig(self.taskId)
    rateHelper = baseLen * taskVo.baseIncome
    local len = buildBase.DispatchDockManager:checkExtraProps2(self.taskId, self.exploreId)
    rateHelper = rateHelper + (len * taskVo.extraIncome)
    rateHelper = rateHelper / 10000
    if rateHelper < 1 then
        self.mTxtRate.text = "（达成率：" .. HtmlUtil:color(tostring(rateHelper * 100) .. "%", "009106ff") .. " )"

    else
        self.mTxtRate.text = "（达成率：" .. HtmlUtil:color(tostring(100) .. "%", "0080f2ff") .. " )"
    end
    local itemDic = buildBase.DispatchDockManager:getExtraItemCofigs(self.taskId)
    local numHelper = 0
    for _, vo in pairs(itemDic) do
        if vo.num == 1 then
            numHelper = vo.num
        else
            numHelper = math.floor(vo.num * rateHelper)
        end
        local propsGrid = PropsGrid:createByData({ tid = vo.tid, num = numHelper, parent = self.mExtraItemsTrans, scale = 0.53, showUseInTip = false })
        self.mExtraItems[_] = propsGrid
    end
end

function updateStars(self)
    if not self.mStarsGroupTrans then
        self.mStarsGroupTrans = self:getChildTrans("mStarsGroupTrans")
    end
    if not self.mStarIcon then
        self.mStarIcon = self:getChildGO("mStarIcon")
    end
    self:clearStars()
    if self.mTaskConfig.star then
        for i = 1, self.mTaskConfig.star do
            local item = SimpleInsItem:create(self.mStarIcon, self.mStarsGroupTrans, "DispatchDockIncompleteViewstars")
            self.mStarsDic[i] = item
        end
    end
end

function onSpeedUpHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_DISPATCH_DRONE_SPEED_UP_VIEW, self.exploreId)
end

function onReCallHandler(self)
    UIFactory:alertMessge(_TT(76028), true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_BUILDBASE_DISPATCH_RECALL, { buildId = self.buildId, exploreId = self.exploreId })
        self:clearItems()
        LoopManager:removeTimer(self, self.onUpdateChargeTimerInfo)
        self:close()
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil
    )

end


function clearItems(self)
    self:clearBaseItems()
    self:clearExtraItems()
    self:clearStars()
end

function clearBaseItems(self)
    if next(self.mBaseItems) then
        for _, v in pairs(self.mBaseItems) do
            v:poolRecover()
        end
        self.mBaseItems = {}
    end
end

function clearExtraItems(self)

    if next(self.mExtraItems) then
        for _, v in pairs(self.mExtraItems) do
            v:poolRecover()
        end
        self.mExtraItems = {}
    end
end

function clearStars(self)
    if next(self.mStarsDic) then
        for _, v in pairs(self.mStarsDic) do
            v:poolRecover()
        end
    end
    self.mStarsDic = {}
end


return _M


--[[ 替换语言包自动生成，请勿修改！
]]
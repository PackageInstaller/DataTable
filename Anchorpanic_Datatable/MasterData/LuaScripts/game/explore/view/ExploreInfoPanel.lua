--[[ 
-----------------------------------------------------
@filename       : ExplorInfoPanel
@Description    : 探索详细界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("explore.ExploreInfoPanel", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("explore/ExploreInfoPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 1

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end

function initData(self)
    self.items = {}
    self.heroItems = {}
    self.awardItems = {}
    self.heroHeadList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTxtCheckTeam = self:getChildGO("mTxtCheckTeam"):GetComponent(ty.Text)
    self.mTxtExploreName = self:getChildGO("mTxtExploreName"):GetComponent(ty.Text)
    self.mTxtExploreTime = self:getChildGO("mTxtExploreTime"):GetComponent(ty.Text)
    self.mTxtHero = self:getChildGO("mTxtHero"):GetComponent(ty.Text)
    self.mTxtAward = self:getChildGO("mTxtAward"):GetComponent(ty.Text)
    self.mHeroContent = self:getChildTrans("mHeroContent")
    self.mAwardContent = self:getChildTrans("mAwardContent")
    self.mTxtSpeed = self:getChildGO("mTxtSpeed"):GetComponent(ty.Text)
    self.mBtnSpeed = self:getChildGO("mBtnSpeed")
    self.mBtnCancel = self:getChildGO("mBtnCancel")
    self.mHeroItem = self:getChildGO("mHeroItem")
    self.mTxtExping = self:getChildGO("mTxtExping"):GetComponent(ty.Text)
    self.mBtnRet = self:getChildGO("mBtnRet")
end

function show(self, args)
    self.cusId = args.id
    self.event = args.event
    --探索配置信息
    local dic = explore.exploreManager:getExploreData()
    self.vo = dic[self.cusId].eventDic[self.event.randEventId]
    self.mTxtExploreName.text = _TT(self.vo.eventName)
    self.heroVos = explore.exploreManager:getHerosById(self.cusId)
    for i = 1, #self.heroVos do
        local go = gs.GameObject.Instantiate(self.mHeroItem)
        local vo = self.heroVos[i]
        local mHeadGrid = HeroHeadGrid:poolGet()
        mHeadGrid:setData(vo)
        mHeadGrid:setParent(go.transform:Find("Head/HeadNode").transform)
        mHeadGrid:setLvl(vo.lvl)
        mHeadGrid:setType(true)
        mHeadGrid:setEleType(true)
        go.transform:SetParent(self.mHeroContent, false)
        table.insert(self.heroHeadList, mHeadGrid)
        table.insert(self.heroItems, go)
    end
    local rewards = AwardPackManager:getAwardListById(self.vo.showAeward)
    for i = 1, #rewards do
        local rewardVo = rewards[i]
        local propsGrid = PropsGrid:create(self.mAwardContent, {rewardVo.tid, rewardVo.num}, 0.8)
        table.insert(self.awardItems, propsGrid)
    end
    LoopManager:addTimer(0, 0, self, self.setTime)
end

function setTime(self)
    local endTime = self.event.endTime
    local clientTime = GameManager:getClientTime()
    local reamainTime = endTime -clientTime
    if (reamainTime <= 0) then
        self:upToOk()
        return
    end
    self.isOk = false
    local hours = math.floor((reamainTime % 86400) / 3600)
    local mins = math.floor((reamainTime % 3600) / 60)
    local secs = reamainTime % 60

    if hours < 10 then 
        hours = "0"..hours
    end
    if mins < 10 then
        mins = "0".. mins
    end
    if secs < 10 then
        secs = "0"..secs
    end

    self.mTxtExploreTime.text = hours .. ":" .. mins .. ":" .. secs
    local x = math.ceil(reamainTime / sysParam.SysParamManager:getValue(707))
    self.mTxtSpeed.text =
        math.floor(
        sysParam.SysParamManager:getValue(704) / 10000 * x * x - sysParam.SysParamManager:getValue(705) / 10000 * x +
            sysParam.SysParamManager:getValue(706) / 10000)
end

function upToOk(self)
    LoopManager:removeTimer(self, self.setTime)
    self.mBtnCancel:SetActive(false)
    self.mTxtSpeed.gameObject:SetActive(false)
    self.mTxtExping.gameObject:SetActive(false)
    self.mBtnSpeed:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("common5/common_0136.png"), false)
    self:setBtnLabel(self.mBtnSpeed, 412, "领取")
    self.mTxtExploreTime.text = _TT(40029)--"探索完成"
    self.isOk = true
end

--激活
function active(self)
    super.active(self)

    GameDispatcher:addEventListener(EventName.UPDATE_EXPLORE, self.updateExploreHandler, self)
end

function updateExploreHandler(self)
    self:onClickClose()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_EXPLORE, self.updateExploreHandler, self)
    LoopManager:removeTimer(self, self.setTime)
    self:clearHeadList()
    for i = 1, #self.heroItems do
        gs.GameObject.Destroy(self.heroItems[i])
    end
    self.heroItems = {}

    for i = 1, #self.awardItems do
        self.awardItems[i]:poolRecover()
    end
    self.awardItems = {}
end

function clearHeadList(self)
    for i = 1, #self.heroHeadList do
        self.heroHeadList[i]:poolRecover()
    end
    self.heroHeadList = {}
end

function initViewText(self)
    self.mTxtCheckTeam.text = _TT(40064)--"查看队伍"
    self:setBtnLabel(self.mBtnSpeed, 40069, "加速")
    self:setBtnLabel(self.mBtnCancel, 40068, "召回")
    self.mTxtHero.text = _TT(40033)--"派遣战员" = self:getChildGO("HeroTxt"):GetComponent(ty.Text)
    self.mTxtAward.text = _TT(40020) --= self:getChildGO("AwardTxt"):GetComponent(ty.Text)
    self.mTxtExping.text = _TT(40034)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCancel, self.onCancelBtnClick)
    self:addUIEvent(self.mBtnSpeed, self.onSpeedUpClick)
    self:addUIEvent(self.mBtnRet,self.onRetClick)
end

function onRetClick(self)
    self:onClickClose()
end

function onCancelBtnClick(self)
    UIFactory:alertMessge(_TT(40039), true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_CANCEL_ARENA_EXPLORE,{id = self.cusId})
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil,nil, _TT(40040))
end

function onSpeedUpClick(self)
    if self.isOk then
        GameDispatcher:dispatchEvent(EventName.REQ_GAIN_ARENA_EXPLORE_AWARD, {id = self.cusId})
    else    
        self:handleCon()
        UIFactory:alertMessge(_TT(40067, self.con), true, function()
            self:speedUp()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil, _TT(40019))
    end
end

function handleCon(self)
    self.events = explore.exploreManager:getExploreMsgData()
    self.endTime = self.events[self.cusId].endTime
    local clientTime = GameManager:getClientTime()
    local reamainTime = self.endTime - clientTime
    if (reamainTime <= 0) then
        self:onClickClose()
        return
    end
    local x = math.ceil(reamainTime / sysParam.SysParamManager:getValue(707))
    self.con =
        math.floor(
        sysParam.SysParamManager:getValue(704) / 10000 * x * x - sysParam.SysParamManager:getValue(705) / 10000 * x +
            sysParam.SysParamManager:getValue(706) / 10000
    )
end

function speedUp(self) 
    local rem = MoneyUtil.getMoneyCountByTid(MoneyTid.ITIANIUM_TID)
    if rem < self.con then
        gs.Message.Show(_TT(26313)) -- ("所需货币不足,无法增幅")
    else
        GameDispatcher:dispatchEvent(EventName.REQ_SPEEDUP_ARENA_EXPLORE, {id = self.cusId})
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

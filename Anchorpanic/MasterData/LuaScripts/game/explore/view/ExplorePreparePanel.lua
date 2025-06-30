--[[ 
-----------------------------------------------------
@filename       : ExplorPreparePanel
@Description    : 探索准备界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("explore.ExplorePreparePanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("explore/ExplorePreparePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    local w, h = ScreenUtil:getScreenSize(nil)
    self:setSize(w, h)
    self:setBg("common_bg_004.png", true)
    self:setTxtTitle(_TT(29562))
    self:setUICode(LinkCode.CovenantExplore)
end

-- 析构
function dtor(self)
end

function initData(self)
    -- 选择子元素列表
    self.selectItems = {}
    -- 奖励子元素列表
    self.awardItems = {}
    -- 头像子元素列表
    self.heroHeadList = {}
    -- 选择的角色列表
    self.selectHeroList = {}
    -- 要求描述列表
    self.contItems = {}

    self.conditionDelay = nil 
    self.selectDelay = nil 
    self.awardDelay = nil 
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTxtExploreName = self:getChildGO("mTxtExploreName"):GetComponent(ty.Text)
    self.mTxtExploreTime = self:getChildGO("mTxtExploreTime"):GetComponent(ty.Text)
    self.mTxtExploreInfo = self:getChildGO("mTxtExploreInfo"):GetComponent(ty.Text)
    self.mTxtCondition = self:getChildGO("mTxtCondition"):GetComponent(ty.Text)
    self.mSelectItem = self:getChildGO("mSelectItem")
    self.mContItem = self:getChildGO("mContItem")
    self.mContScrollView = self:getChildGO("mContScrollView"):GetComponent(ty.ScrollRect)
    -- 奖励Content
    self.mAwardContent = self:getChildTrans("mAwardContent")
    -- 选择按钮Content
    self.mSelectContent = self:getChildTrans("mSelectContent")
    self.mTxtAward = self:getChildGO("mTxtAward"):GetComponent(ty.Text)
    self.mTxtHero = self:getChildGO("mTxtHero"):GetComponent(ty.Text)
    -- 派遣按钮
    self.mBtnDispatch = self:getChildGO("mBtnDispatch")
    -- 一件派遣按钮
    self.mBtnOneKey = self:getChildGO("mBtnOneKey")
    self.mBtnRefresh = self:getChildGO("mBtnRefresh")
    self.mTxtRefreshNum = self:getChildGO("mTxtRefreshNum"):GetComponent(ty.Text)
    self:setGuideTrans("funcTips_explore_1", self:getChildTrans("mFunctionTips_explore_1"))
    self:setGuideTrans("funcTips_explore_2", self:getChildTrans("mTimeCount"))


    self:setGuideTrans("guide_explore_prepare" , self:getChildTrans("mBtnOneKey"))
    self:setGuideTrans("guide_explore_dispatch" , self:getChildTrans("mBtnDispatch"))
end

-- 激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_EXPLORE, self.updateExploreHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_EXPLORE_SELECT, self.updateExploreSelectHandler, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateCoinText, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID}, 2)
    self:show(args)
end

function initViewText(self)
    self.mTxtAward.text = _TT(40020) -- 巡防奖励预览
    self.mTxtHero.text = _TT(40021) -- 战员派遣要求
    self:setBtnLabel(self.mBtnDispatch, 40062, "开始探索")
    self:setBtnLabel(self.mBtnOneKey, 40063, "一键探索")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnDispatch, self.onDispatchClick)
    self:addUIEvent(self.mBtnOneKey, self.onOneKeyClick)
    self:addUIEvent(self.mBtnRefresh, self.onClickReflash)
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
end

function show(self, args)
    if (args ~= nil) then
        self.cusId = args.id
        self.event = args.event
    end
    if(not self.event or not self.cusId) then 
        return
    end
    -- 探索配置信息
    local dic = explore.exploreManager:getExploreData()
    local vo = dic[self.cusId].eventDic[self.event.randEventId]
    self.vo = vo
    self.mTxtExploreName.text = _TT(vo.eventName)
    self.mTxtExploreTime.text = math.floor((self.event.needTime / 3600)) .. _TT(153)
    self.mTxtExploreInfo.text = _TT(vo.eventExplain)

    self:updateCoinText()
    
    local function conditionDelay()
        self:clearContItem()
        for i = 1, #vo.explain do
            local item = gs.GameObject.Instantiate(self.mContItem, self.mContScrollView.content.transform, false)
            item.transform:Find("mImgConditionIcon/mTxtCondition"):GetComponent(ty.Text).text = _TT(vo.explain[i])
            table.insert(self.contItems, item)
        end
        self.conditionType = #vo.heroTypeNumList == 0 and explore.EventType.eleType or explore.EventType.heroType
        if self.conditionType == explore.EventType.heroType then
            self.needTypeNumList = vo.heroTypeNumList  --指定战员所需数量
            self.needTypeList = vo.heroTypeList  --指定战员职业 
        else
            self.needTypeNumList = vo.eleTypeNumList
            self.needTypeList = vo.eleTypeList
        end
        self:updateConditionIcon()

        self.heroNum = vo.heroNum
        self.heroDic = explore.exploreManager:getHeroDic()
        self.selectHeroList = explore.exploreManager:getHeroList()
        if (self.selectHeroList == nil) then
            self.selectHeroList = {}
            for i = 1, self.heroNum do
                table.insert(self.selectHeroList, -1)
            end
        end

        if(self.conditionDelay) then 
            LoopManager:removeFrameByIndex(self.conditionDelay)
            self.conditionDelay = nil
        end
    end
    self.conditionDelay = LoopManager:addFrame(1, 1, self, conditionDelay)

    local function selectDelay()
        self:clearHeroHeadList()
        self:clearSelectItems()
        for i = 1, #self.selectHeroList do
            local go = gs.GameObject.Instantiate(self.mSelectItem)
            go.transform:SetParent(self.mSelectContent, false)
            -- 没有选择战员
            if self.selectHeroList[i] == -1 then
                go.transform:Find("Select").gameObject:SetActive(true)
                go.transform:Find("Head").gameObject:SetActive(false)
            else
                go.transform:Find("Select").gameObject:SetActive(false)
                go.transform:Find("Head").gameObject:SetActive(true)
                local vo = self.heroDic[self.selectHeroList[i]]
                local mHeadGrid = HeroHeadSelectGrid:poolGet()
                mHeadGrid:setData(vo, false)
                mHeadGrid:setParent(go.transform:Find("Head/HeadNode").transform)
                mHeadGrid:setLvl(vo.lv1)
                mHeadGrid:setClickEnable(false)
                local eleObj = go.transform:Find("Head/EleImg").gameObject
                local eleImg = eleObj:GetComponent(ty.AutoRefImage)
                local proImg = go.transform:Find("Head/mImgIconBg/ProImg"):GetComponent(ty.AutoRefImage)

                eleObj:SetActive(true)
                eleImg:SetImg(UrlManager:getHeroEleTypeIconUrl(vo.eleType), false)
                -- if vo.eleType == 0 then
                
                table.insert(self.heroHeadList, mHeadGrid)
                proImg:SetImg(UrlManager:getHeroJobSmallIconUrl(vo.professionType), false)
            end
            table.insert(self.selectItems, go)
            if(self.selectDelay) then 
                LoopManager:removeFrameByIndex(self.selectDelay)
                self.selectDelay = nil
            end
        end
    end
    self.selectDelay = LoopManager:addFrame(3, 1, self, selectDelay)

    local function awardDelay()
        self:clearAwardItems()
        local rewards = AwardPackManager:getAwardListById(vo.showAeward)
        for i = 1, #rewards do
            local rewardVo = rewards[i]
            local propsGrid = PropsGrid:createByData({ tid = rewardVo.tid, num = rewardVo.num, parent = self.mAwardContent, scale = 0.7, showUseInTip = false })
            propsGrid:setCount(rewardVo.num)
            table.insert(self.awardItems, propsGrid)
        end
        self:updateEvent()
        if(self.awardDelay) then 
            LoopManager:removeFrameByIndex(self.awardDelay)
            self.awardDelay = nil
        end
    end
    self.awardDelay = LoopManager:addFrame(5, 1, self, awardDelay)
end

function updateCoinText(self)
    local needNum = sysParam.SysParamManager:getValue(SysParamType.COVENANT_REFLASH_PAY)
    self.mTxtRefreshNum.text = needNum
    local isEnough, tipStr = MoneyUtil.judgeNeedMoneyCountByTid(MoneyTid.GOLD_COIN_TID, needNum, false, false)
    if (isEnough) then
        self.mTxtRefreshNum.color = gs.ColorUtil.GetColor("000000ff")
    else
        self.mTxtRefreshNum.color = gs.ColorUtil.GetColor("FF0000ff")
    end
end

function updateExploreHandler(self)
    self:onClickClose()
end

function updateExploreSelectHandler(self, args)
    if(args == nil)then 
        args = self.args
    end

    
    self:show(self.args)
end

function updateConditionIcon(self)
    self.selectIdList = explore.exploreManager:getHeroList()
    if(self.selectIdList == nil) then 
        return
    end
    if self.conditionType == explore.EventType.heroType then
        for i = 1, #self.needTypeNumList do
            if(self.contItems[i]) then 
                local conditionIcon = self.contItems[i].transform:Find("mImgConditionIcon"):GetComponent(ty.AutoRefImage)
                local conNum = self.needTypeNumList[i]
                local curNum = 0
                for j = 1, #self.selectIdList do
                    if self.selectIdList[j] ~= -1 and self.heroDic[self.selectIdList[j]].professionType == self.needTypeList[i] then
                        curNum = curNum + 1
                    end
                end
                if conNum <= curNum then
                    conditionIcon:SetImg(UrlManager:getPackPath("common5/common_0145.png"), false)
                    conditionIcon.color = gs.ColorUtil.GetColor("12D411ff")
                else
                    conditionIcon:SetImg(UrlManager:getPackPath("common5/common_0146.png"), false)
                    conditionIcon.color = gs.ColorUtil.GetColor("ffffffff")
                end
            end
        end
    elseif self.conditionType == explore.EventType.eleType then
        for i = 1, #self.needTypeNumList do
            if(self.contItems[i]) then 
                local conditionIcon = self.contItems[i].transform:Find("mImgConditionIcon"):GetComponent(ty.AutoRefImage)
                local conNum = self.needTypeNumList[i]
                local curNum = 0
                for j = 1, #self.selectIdList do
                    if self.selectIdList[j] ~= -1 and self.heroDic[self.selectIdList[j]].eleType == self.needTypeList[i] then
                        curNum = curNum + 1
                    end
                end
                if conNum <= curNum then
                    conditionIcon:SetImg(UrlManager:getPackPath("common5/common_0145.png"), false)
                    conditionIcon.color = gs.ColorUtil.GetColor("12D411ff")
                else
                    conditionIcon:SetImg(UrlManager:getPackPath("common5/common_0146.png"), false)
                    conditionIcon.color = gs.ColorUtil.GetColor("ffffffff")
                end
            end
        end
    end
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    explore.exploreManager:setHeroList(nil)
    GameDispatcher:removeEventListener(EventName.UPDATE_EXPLORE, self.updateExploreHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_EXPLORE_SELECT, self.updateExploreSelectHandler, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateCoinText, self)
    self:clearContItem()
    self:clearHeroHeadList()
    self:clearSelectItems()
    self:clearAwardItems()
    self:clearAllDelay()
end

function clearAllDelay(self)
    if(self.awardDelay) then 
        LoopManager:removeFrameByIndex(self.awardDelay)
        self.awardDelay = nil
    end
    if(self.selectDelay) then 
        LoopManager:removeFrameByIndex(self.selectDelay)
        self.selectDelay = nil
    end
    if(self.conditionDelay) then 
        LoopManager:removeFrameByIndex(self.conditionDelay)
        self.conditionDelay = nil
    end
end

function clearSelectItems(self)
    for i = 1, #self.selectItems do
        gs.GameObject.Destroy(self.selectItems[i])
    end
    self.selectItems = {}
end

function clearHeroHeadList(self)
    for i = 1, #self.heroHeadList do
        self.heroHeadList[i]:poolRecover()
    end
    self.heroHeadList = {}
end

function clearContItem(self)
    for i = 1, #self.contItems do
        gs.GameObject.Destroy(self.contItems[i])
    end
    self.contItems = {}
end

function clearAwardItems(self)
    for i = 1, #self.awardItems do
        self.awardItems[i]:poolRecover()
    end
    self.awardItems = {}
end


function updateEvent(self)
    for i = 1, #self.selectItems do
        self:addUIEvent(self.selectItems[i].transform:Find("mBtn").gameObject, self.onSelectItemClick, nil, i)
    end
end

function verSuccess(self)
    if self.conditionType == explore.EventType.heroType then
        for i = 1, #self.needTypeNumList do
            local conNum = self.needTypeNumList[i]
            local curNum = 0
            for j = 1, #self.selectIdList do
                if self.selectIdList[j] ~= -1 and self.heroDic[self.selectIdList[j]].professionType == self.needTypeList[i] then
                    curNum = curNum + 1
                end
            end
            if conNum <= curNum then
            else
                return false
            end
        end
    elseif self.conditionType == explore.EventType.eleType then
        for i = 1, #self.needTypeNumList do
            local conNum = self.needTypeNumList[i]
            local curNum = 0
            for j = 1, #self.selectIdList do
                if self.selectIdList[j] ~= -1 and self.heroDic[self.selectIdList[j]].eleType == self.needTypeList[i] then
                    curNum = curNum + 1
                end
            end
            if conNum <= curNum then
            else
                return false
            end
        end
    end
    return true
end

--打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.CovenantExplore })
end

function onClickReflash(self)
    local needNum = sysParam.SysParamManager:getValue(SysParamType.COVENANT_REFLASH_PAY)
    local isEnough, tipStr = MoneyUtil.judgeNeedMoneyCountByTid(MoneyTid.GOLD_COIN_TID, needNum, false, false)
    if(isEnough) then 
        explore.exploreManager:setHeroList(nil)
        GameDispatcher:dispatchEvent(EventName.REQ_REFLASH_EXPLORE, { id = self.cusId })
    else
        gs.Message.Show(_TT(1321))
    end
end

function onDispatchClick(self)
    self.selectIdList = explore.exploreManager:getHeroList()
    if self.selectIdList == nil then
        gs.Message.Show(_TT(40037))
        return
    end
    if table.indexof01(self.selectIdList, -1) == 0 then
        if self:verSuccess() then
            GameDispatcher:dispatchEvent(EventName.REQ_START_ARENA_EXPLORE, { id = self.cusId, list = self.selectIdList })
        else
            gs.Message.Show(_TT(40036))
        end
    else
        gs.Message.Show(_TT(40037))
    end
end

-- 一键派遣
function onOneKeyClick(self)
    local heroList = explore.exploreManager:getHeroList()
    if (heroList == nil) then
        explore.exploreManager:setHeroList(self.selectHeroList)
    else
        local listCount = #heroList
        for i = 1, #heroList do
            if (heroList[i] == -1) then
                listCount = listCount - 1
            end
        end
        if (listCount >= self.heroNum) then
            gs.Message.Show(_TT(40032))
            return
        end
    end
    self.heroDic = explore.exploreManager:getHeroDic()
    local curNum = 0
    if(#self.needTypeList == 0) then 
        for k,v in pairs(self.heroDic) do
            if(curNum > self.vo.heroNum) then 
                break
            end
            if(explore.exploreManager:changeHeroList(v.id, false)) then 
                curNum = curNum + 1
            end
        end
    else
        for i = 1, #self.needTypeList do
            local conNum = self.needTypeNumList[i]
            local curNum = 0
            if self.conditionType == explore.EventType.heroType then
                for j = 1, #self.heroDic do
                    if (not explore.exploreManager:getExploreHeroById(self.heroDic[j].id) and not explore.exploreManager:getHeroSelect(self.heroDic[j].id)) then
                        if self.heroDic[j].professionType == self.needTypeList[i] then
                            if(explore.exploreManager:changeHeroList(self.heroDic[j].id, false)) then 
                                curNum = curNum + 1
                            end
                        end
                        if conNum <= curNum then
                            break
                        end
                    end
                end
            elseif self.conditionType == explore.EventType.eleType then
                for j = 1, #self.heroDic do
                    if (not explore.exploreManager:getExploreHeroById(self.heroDic[j].id) and not explore.exploreManager:getHeroSelect(self.heroDic[j].id)) then
                        if self.heroDic[j].eleType == self.needTypeList[i] then
                            if(explore.exploreManager:changeHeroList(self.heroDic[j].id, false)) then 
                                curNum = curNum + 1
                            end
                        end
                        if conNum <= curNum then
                            break
                        end
                    end
                end
            end
            if(conNum > curNum) then 
                gs.Message.Show("未能找到全部符合条件的战员")
            else
                if(curNum < self.vo.heroNum) then 
                    for k,v in pairs(self.heroDic) do
                        if(curNum > self.vo.heroNum) then 
                            break
                        end
                        if(not explore.exploreManager:getExploreHeroById(v.id) and not explore.exploreManager:getHeroSelect(v.id)) then 
                            if(explore.exploreManager:changeHeroList(v.id, false)) then 
                                curNum = curNum + 1
                            end
                        end
                    end
                    if(curNum < self.vo.heroNum) then 
                        gs.Message.Show("未能找到全部符合条件的战员")
                    end
                end
            end
        end
    end
    self:updateExploreSelectHandler()
end

function onSelectItemClick(self, id)
    explore.exploreManager:setHeroList(self.selectHeroList)
    GameDispatcher:dispatchEvent(EventName.OPEN_EXPLORE_SELECT_PANEL, { type = self.conditionType, needNumList = self.needTypeList })
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

-- 海底主界面
module("seabed.SeabedMainPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("seabed/SeabedMainPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(111017))
    self:setSize(0, 0)
    self:setBg("seabed_main.jpg", false, "seabed")
    self:setUICode(LinkCode.Seabed)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mBtnTask = self:getChildGO("mBtnTask")
    self.mBtnRank = self:getChildGO("mBtnRank")
    self.mBtnTalent = self:getChildGO("mBtnTalent")
    self.mBtnStory = self:getChildGO("mBtnStory")
    self.mBtnCollection = self:getChildGO("mBtnCollection")

    self.mBtnFight = self:getChildGO("mBtnFight")
    self.mBtnContinue = self:getChildGO("mBtnContinue")
    self.mTxtPro = self:getChildGO("mTxtPro"):GetComponent(ty.Text)
    self.mBtnAbandon = self:getChildGO("mBtnAbandon")
end


-- 激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_TOP_PANEL)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_SEABED_MAIN_PANEL, self.showPanel, self)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SEABED_MAIN_PANEL, self.showPanel, self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })

    --GameDispatcher:dispatchEvent(EventName.CLOSE_SEABED_TOP_PANEL)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.onBtnFightClickHandler)
    self:addUIEvent(self.mBtnContinue,self.onBtnFightClickHandler)
    self:addUIEvent(self.mBtnTask, self.onBtnTaskClickHandler)
    self:addUIEvent(self.mBtnAbandon, self.onBtnAbabdonClickHandler)
    self:addUIEvent(self.mBtnTalent, self.onBtnTalentClickHandler)


    self:addUIEvent(self.mBtnCollection,self.onBtnColletionClickHandler)
    self:addUIEvent(self.mBtnRank, self.onOpenRankClickHandler)

    self:addUIEvent(self.mBtnStory, self.onOpenStoryClickHandler)
end

function onOpenStoryClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_STORY_PANEL)
end

function onOpenRankClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_SEABED_RANK_DATA)
    --GameDispatcher:dispatchEvent(EventName.OPEN_RANK_MAIN_PANEL, { type = rank.RankConst.RANK_SEABED })
end

function onBtnColletionClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_COLLECTION_PANEL)
end

function showPanel(self)
    local hasData = seabed.SeabedManager:getSeabedHasSettleData()
    if hasData then
        GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_SETTPANEL)
    end

    local isStart = seabed.SeabedManager:getSeabedStart()
    if isStart then
        self.mBtnContinue:SetActive(true)
        self.mBtnFight:SetActive(false)
        --self.mBtnFight:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("seabed/seabed_continue.png"),false)
    else
        self.mBtnContinue:SetActive(false)
        self.mBtnFight:SetActive(true)
        --self.mBtnFight:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("seabed/seabed_fight.png"),false)
    end
    self.mTxtPro.text = _TT(111018).. seabed.SeabedManager:getCurMapName()
    --self.mTxtPro.gameObject:SetActive(isStart)
    self.mBtnAbandon:SetActive(isStart)


    self:updateRed()
end

function onBtnFightClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.CAN_SEABED_NEED_PANEL)
end

function onBtnTaskClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_TASK_PANEL)
end

function onBtnAbabdonClickHandler(self)
    UIFactory:alertMessge(_TT(111019), true, function()
        GameDispatcher:dispatchEvent(EventName.REQ_ABANDON_SEABED)
    end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
end

function onBtnTalentClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_TALENT_PANEL)
end

function updateRed(self)
    if seabed.SeabedManager:canGetTask() then
        RedPointManager:add(self.mBtnTask.transform, nil, 46, 26)
    else
        RedPointManager:remove(self.mBtnTask.transform)
    end
    
    if seabed.SeabedManager:canGetBuffOrColl() then
        RedPointManager:add(self.mBtnCollection.transform, nil, 46, 26)
    else
        RedPointManager:remove(self.mBtnCollection.transform)
    end

    if seabed.SeabedManager:canGetStory() then
        RedPointManager:add(self.mBtnStory.transform, nil, 46, 26)
    else
        RedPointManager:remove(self.mBtnStory.transform)
    end

    if seabed.SeabedManager:canGetTalent() then
        RedPointManager:add(self.mBtnTalent.transform, nil, 46, 26)
    else
        RedPointManager:remove(self.mBtnTalent.transform)
    end
end

return _M
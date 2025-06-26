--[[ 
-----------------------------------------------------
@filename       : ExplorPanel
@Description    : 探索界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("explore.ExplorePanel", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("explore/ExplorePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1800, 1200)
    self:setTxtTitle(_TT(29562))
    self:setBg("common_bg_012.jpg", false)
end

--析构
function dtor(self)
end

function initData(self)
    self.items = {}
    self.timeDic = {}
    self.itemDelay = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTxtResetInfo = self:getChildGO("mTxtResetInfo"):GetComponent(ty.Text)
    --未知如何通过child获取 TODO
    self.mMapItems = self:getChildGO("mMapItems")
    for i = 1, 5 do
        table.insert(self.items, self:getChildTrans("mMapItem"..i))
    end

    self:setGuideTrans("guide_explore_map1" , self:getChildTrans("mMapItem1"))
end

function initView(self)
    --声望等级
    local perstigeLevel = covenant.CovenantManager:getPerstigeStage()
    --探索配置信息
    self.dic = explore.exploreManager:getExploreData()
    --服务器下发事件配置
    local events = explore.exploreManager:getExploreMsgData()
    self:removeDelay()
    for i = 1, #self.items do
        --需要的声望等级
        -- 增加指挥官等级
        local function loadItem()
            local needPrestigeLevel = self.dic[i].needPrestige
            local needLevel = self.dic[i].level
            local openPrestige = needPrestigeLevel <= perstigeLevel
            local openLevel = needLevel <= role.RoleManager:getRoleVo():getPlayerLvl()
            local open = openPrestige and openLevel
            local obj = self.items[i]
            local state1 = obj:Find("mStateOpen").gameObject
            local state2 = obj:Find("mStateNotOpen").gameObject
            local mapStateImg = obj:Find("mImgMapState").gameObject:GetComponent(ty.AutoRefImage)

            state1:SetActive(open)
            state2:SetActive(not open)
            if open then -- 已开放的
                mapStateImg:SetImg(UrlManager:getPackPath("explore5/explore_2.png", true))
                local imgTitle = state1.transform:Find("mImgTitle").gameObject
                local itemNameTxt = imgTitle.transform:Find("mImgBg01/mTxtTitle"):GetComponent(ty.Text)
                itemNameTxt.text = _TT(40069 + i)
                local txtStateGo = state1.transform:Find("mTxtState").gameObject
                local imgFinish = txtStateGo.transform:Find("mImgFinish").gameObject
                local txtState = txtStateGo:GetComponent(ty.Text)
                local redPoint = state1.transform:Find("RedPoint").gameObject
                local timeTxt = state1.transform:Find("mTxtTime").gameObject
                local txtSearching = timeTxt.transform:Find("mTxtSearching"):GetComponent(ty.Text)
                redPoint:SetActive(true)
                imgTitle:SetActive(true)
                imgFinish:SetActive(false)
                timeTxt:SetActive(false)
                txtStateGo:SetActive(true)
                local sta = events[i].state
                if sta == 0 then -- 可探索
                    txtState.text = _TT(40035) --HtmlUtil:color( , "")
                elseif sta == 1 then -- 探索中
                    txtStateGo:SetActive(false)
                    txtSearching.text = _TT(40034) --HtmlUtil:color( , ColorUtil.PURE_WHITE_NUM)
                    redPoint:SetActive(false)
                    timeTxt:SetActive(true)
                    self.timeDic[i] = {
                        obj = timeTxt:GetComponent(ty.Text),
                        exploreData = self.dic[i].eventDic[events[i].randEventId],
                        eventData = events[i]
                    }
                elseif sta == 2 then -- 探索完成
                    txtState.text = _TT(40029)
                end
                -- 今日已经探索了
                if events[i].todayExploreTimes == 1 then
                    redPoint:SetActive(false)
                    imgTitle:SetActive(false)
                    imgFinish:SetActive(true)
                    txtState.text = _TT(40026)--"今日已完成"
                end
            else -- 未开放的
                mapStateImg:SetImg(UrlManager:getPackPath("explore5/explore_6.png", true))
                if(not openPrestige) then 
                    state2.transform:Find("mImgBg/mTxtInfo").gameObject:GetComponent(ty.Text).text = _TT(40024) ..needPrestigeLevel .. _TT(40025)
                elseif(not openLevel) then 
                    state2.transform:Find("mImgBg/mTxtInfo").gameObject:GetComponent(ty.Text).text = _TT(29570, needLevel)
                end
                state2.transform:Find("mImgBg/mExped").gameObject:SetActive(false)
            end

            LoopManager:removeTimer(self, self.updateTime)
            self:updateTime()
            if table.nums(self.timeDic) > 0 then
                LoopManager:addTimer(1, 0, self, self.updateTime)
            end
            if self.itemDelay[i] then 
                LoopManager:removeFrameByIndex(self.itemDelay[i])
                self.itemDelay[i] = nil
            end
        end
        self.itemDelay[i] = LoopManager:addFrame(i, 1, self, loadItem)
    end
    self:updateSize()
end

function updateTime(self)
    local clientTime = GameManager:getClientTime()
    local ok = false
    for id, para in pairs(self.timeDic) do
        local endTime = para.eventData.endTime
        local reamainTime = endTime - clientTime
        if (reamainTime <= 0) then
            ok = true
        end

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
        para.obj.text = hours .. ":" .. mins .. ":" .. secs
    end
    if ok then
        self:initView()
    end
end

function updateSize(self)
    gs.GoUtil.UpdateSize(self.mMapItems)
end

--激活
function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_EXPLORE, self.__updateExploreHandler, self)
    MoneyManager:setMoneyTidList({})
    self:initView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.UPDATE_EXPLORE, self.__updateExploreHandler, self)
    LoopManager:removeTimer(self, self.updateTime)
    self:removeDelay()
end

function removeDelay(self)
    for k,v in pairs(self.itemDelay) do
        if v then 
            LoopManager:removeFrameByIndex(v)
            v = nil
        end
    end
    self.itemDelay = {}
end

function __updateExploreHandler(self)
    self:initView()
end

function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtResetInfo.text = _TT(40061)--"每天    点重置地图任务"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    for i = 1, #self.items do
        local btn = self.items[i].gameObject
        self:addUIEvent(btn, self.__onItemBtnClick, nil, i)
    end
end

-- item被点击
function __onItemBtnClick(self, id)
    --重新获取 方便GM等工具
    --声望等级
    local level = covenant.CovenantManager:getPerstigeStage()
    --探索配置信息
    local dic = explore.exploreManager:getExploreData()

    local events = explore.exploreManager:getExploreMsgData()

    local needLevel = dic[id].needPrestige
    local open = needLevel <= level

    if events[id].todayExploreTimes >= 1 then
       return
    end
    if open == false then
        gs.Message.Show(_TT(40027))
         --"声望等级不足,无法探索")
        return
    else
        --服务器下发事件配置
        local state = events[id].state
        if state == 0 then --未开始
            GameDispatcher:dispatchEvent(EventName.OPEN_EXPLOREPREPARE_PANEL, {id = id, event = events[id]})
        elseif state == 1 then --进行中
            GameDispatcher:dispatchEvent(EventName.OPEN_EXPLOREINFO_PANEL, {id = id, event = events[id]})
        elseif state == 2 then --已完成未领取
            GameDispatcher:dispatchEvent(EventName.OPEN_EXPLOREINFO_PANEL, {id = id, event = events[id]})
        end
    end
end

function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:playerClose()
end

function onClickClose(self)
    super.onClickClose(self)
    self:playerClose()    
end

function playerClose(self)
    GameDispatcher:dispatchEvent(EventName.CUSTOM_CONVENANT_SCENE_CHANGE)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

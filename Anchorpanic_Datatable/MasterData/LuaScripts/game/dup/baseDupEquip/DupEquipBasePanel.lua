--[[ 
-----------------------------------------------------
@filename       : DupEquipBasePanel
@Description    : 芯片副本
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("dup.DupEquipBasePanel", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupEquip/DupEquipBasePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

function getAdaptaTrans(self)
    return self.base_childTrans["mGroupTop"]
end

--构造函数
function ctor(self)
    super.ctor(self)
    local w, h = ScreenUtil:getScreenSize()
    self:setSize(w, h)
    self:setBg("common_bg_4108.jpg", false)
    self:setUICode(LinkCode.DupEquip)
end


--析构
function dtor(self)
end

function initData(self)
    self.mDupItemList = {}

    self.isShowInfo = false
    self.posList = {}
    --策划说的最多10关
    for i = 1, 10 do
        table.insert(self.posList, {(i - 1) * 237 - self:getItemW()/2, -100})
    end
end

function getMgr(self)
    return dup.DupDailyUtil:getDupMgr(self:getDupType())
end

-- 继承公开副本类型
function getDupType(self)
    Debug:log_error("DupDailyBasePanel", "未继承公开副本类型")
    return nil
end
-- 副本item
function getDupItem(self)
    Debug:log_error("DupDailyBasePanel", "未继承公开DupItem")
    return nil
end

-- 初始化
function configUI(self)
    self.mScrollView = self:getChildTrans("mScrollView")
    self.mBtnReturn = self:getChildGO("mBtnReturn")
    self.mScollContent = self:getChildGO("Touch")
    self.mScollContentTrans = self:getChildTrans("Content")
    self.mGroupInfo = self:getChildTrans("mGroupInfo")
    self.mNameTxt = self:getChildGO("mName"):GetComponent(ty.Text)
    self.mDesTxt = self:getChildGO("DesTxt"):GetComponent(ty.Text)
    self.mInfoBtn = self:getChildGO("InfoBtn")
end

--激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    if args then
        self.showDupId = args.dupId
        self.showDupType = args.dupType
    end

    GameDispatcher:addEventListener(EventName.DUP_DAILY_MORE_INFO_PANEL, self.__onOpenDupMoreInfoHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_EQUIP_DUP_INFO, self.onOpenDupInfoHandler, self)
    GameDispatcher:addEventListener(EventName.CLOSE_EQUIP_DUP_INFO, self.onCloseDupInfoHandler, self)
    GameDispatcher:addEventListener(EventName.DUPDATE_DAILY_DUP_SELECTDATA,self.onDailySelectChange,self)

    self:updateDupInfo()
    self:updateView()
end

function updateDupInfo(self)
    local name = dup.DupDailyMainManager:getDailyDupName(self.showDupType)
    self.mNameTxt.text = _TT(name)
    local des = dup.DupDailyMainManager:getDailyDupDes(self.showDupType)
    self.mDesTxt.text = _TT(des)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    GameDispatcher:removeEventListener(EventName.DUP_DAILY_MORE_INFO_PANEL, self.__onOpenDupMoreInfoHandler, self)
    GameDispatcher:removeEventListener(EventName.OPEN_EQUIP_DUP_INFO, self.onOpenDupInfoHandler, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_EQUIP_DUP_INFO, self.onCloseDupInfoHandler, self)
    GameDispatcher:removeEventListener(EventName.DUPDATE_DAILY_DUP_SELECTDATA,self.onDailySelectChange,self)
    LoopManager:removeFrameByIndex(self.frameId)

    self:clearItemList()
    self:onCloseDupViewHandler()
    self.showDupId = nil
end

function onDailySelectChange(self,args)
    self.showDupId = args.dupId
end

function __onOpenDupMoreInfoHandler(self, args)
    if self.moreInfoView == nil then
        self.moreInfoView = dup.DupDailyMoreInfo.new()
        self.moreInfoView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMoreInfoHandler, self)
    end
    self.moreInfoView:open(args)
end

function onDestroyMoreInfoHandler(self)
    self.moreInfoView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMoreInfoHandler, self)
    self.moreInfoView = nil
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    --self:setBtnLabel(self.mBtnReturn, 124, "战斗基地")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mScollContent, self.onScollContentClick)
    --self:addUIEvent(self.mBtnReturn, self.onReturn)
    self:addUIEvent(self.mInfoBtn, self.onInfoClick)
end

function onInfoClick(self)
    GameDispatcher:dispatchEvent(EventName.DUP_DAILY_MORE_INFO_PANEL)
end

function onReturn(self)
    self:closeAll()
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.Adventure})
end

function onScollContentClick(self)
    self:onCloseDupInfoHandler(self.showDupId)
end

function onOpenDupInfoHandler(self, cusVo)
    self.isShowInfo = true
    if (cusVo.type == self:getMgr():getDupType()) then
        self:__onOpenDupInfoHandler(cusVo)

        for i, item in ipairs(self.mDupItemList) do
            item:setSelectState(false)
            if self.showDupId == item:getData().dupId then
                item:setSelectState(true)
            end
        end

        self:setActiveArgs({dupId = self.showDupId, dupType = cusVo.type})

        self:scollToItem()
    end
end
function onCloseDupInfoHandler(self, cusType)
    self.isShowInfo = false
    --if (cusType == self:getMgr():getDupType()) then
        self:onCloseDupViewHandler()
        --TweenFactory:move2LPosX(self.mScrollView, 0, 0.5)

        for i, item in ipairs(self.mDupItemList) do
            item:setSelectState(false)
        end

        self:scollToItem()
    --end
end

-- 副本信息
function __onOpenDupInfoHandler(self, cusVo)
    if (cusVo.type == self:getMgr():getDupType()) then
        if self.gInfoView == nil then
            self.gInfoView = dup.DupEquipInfoView.new()
        end
        self.gInfoView:show(self.mGroupInfo, cusVo)
    end
end
-- 关闭副本详情
function onCloseDupViewHandler(self)
    if self.gInfoView then
        self.gInfoView:destroy()
        self.gInfoView = nil
    end
end

function updateView(self)
    self:showDupList()
    -- self.mImgName:SetImg(
    --     UrlManager:getBgPath(string.format("dup/dup_daily_name_%s.png", self:getMgr():getDupType())),
    --     true
    -- )
end

function showDupList(self)
    self:clearItemList()

    local dupId = self:getMgr():getDupType()

    -- if
    --     (dupId == DupType.DUP_EQUIP_LOW or dupId == DupType.DUP_EQUIP_MID or dupId == DupType.DUP_EQUIP_HIGH 
    --         --or
    --         --dupId == DupType.DUP_EQUIP_4 or
    --         --dupId == DupType.DUP_EQUIP_5
    --         )
    --  then
    --     self.mBottom:SetActive(true)
    -- else
    --     self.mBottom:SetActive(false)
    -- end

    if self.tws then
        for i = 1, #self.tws do
            self.tws[i]:Kill()
            self.tws[i] = nil
        end
    end

    self.tws = {}      
    local dupList = self:getMgr():getDupList()
    local w = 0
    for i = 1, #dupList do
        local dupDailyDataVo = dupList[i]
        dupDailyDataVo.dupIndex = i
        local item = dup.DupEquipBaseItem:create(self.mScollContentTrans, dupDailyDataVo, 1, false)
        item:setPosition(gs.Vector3(self.posList[i][1] + self:getScreenW()/2, self.posList[i][2] + 100*i, 0))

        self.tws[i] = TweenFactory:move2LPosY(item.m_uiGo.transform,-100,0.1*i,gs.DT.Ease.OutQuad)


        table.insert(self.mDupItemList, item)
        w = math.abs(self.posList[i][1]) + self:getScreenW()/20*13 + self:getScreenW()/2

        -- if i == 1 then
        --     local type = self:getMgr():getDupType()
        --     local vo = self:getMgr():getDupEntryVo(DupType.DUP_EQUIP_LOW)
        --     if table.indexof(vo.subType, self:getMgr():getDupType()) ~= false then
        --         -- 芯片副本引导
        --         type = DupType.DUP_EQUIP_LOW
        --     end
        --     self:setGuideTrans("guide_DupDailyBaseItem_" .. type, item.mImgActiveBg)
        -- end
    end
    gs.TransQuick:SizeDelta01(self.mScollContentTrans, w)

    self:updateLine()
    self:scollToItem()

    local dupData = dup.DupMainManager:getDupInfoData(self:getMgr():getDupType())
    if self.showDupId and self:getMgr().enterCurId == dupData.curId then
        local dupVo = self:getMgr():getDupConfigVo(self.showDupId)
        self:onOpenDupInfoHandler(dupVo)
    end

    for i = 1, #self.mDupItemList do
        local item = self.mDupItemList[i]
        local dupId = self.showDupId 
        local dupId = self.showDupId or (dupData.curId == 0 and dupData.maxId or dupData.curId)
        if dupId == item:getData().dupId then
            item:setCurState(true)
            break
        end
    end
    -- self:setTimeout(0.3, self.scollToItem)
end

function getScreenW(self)
    local w, h = ScreenUtil:getScreenSize(nil)
    return w
end

function getItemW(self)
    return 86
end

function clearItemList(self)
    for i = 1, #self.mDupItemList do
        local item = self.mDupItemList[i]
        item:poolRecover()
    end
    self.mDupItemList = {}
end
-- 更新连接线条
function updateLine(self)
    -- for i = 1, #self.mDupItemList do
    --     local curItem = self.mDupItemList[i]
    --     local nextItem = self.mDupItemList[i + 1]
    --     if nextItem then
    --         curItem:setLinePos(nextItem:getCurAnchors(), nextItem:getDupState())
    --     else
    --         curItem:setLinePos(nil, nil)
    --     end
    -- end
end

function scollToItem(self)
    local dupData = dup.DupMainManager:getDupInfoData(self:getMgr():getDupType())
    for i = 1, #self.mDupItemList do
        local item = self.mDupItemList[i]
        local dupId = self.showDupId or (dupData.curId == 0 and dupData.maxId or dupData.curId)
        if dupId == item:getData().dupId then
            self:onScollToX(item, i)
            break
        end
    end
end


function onScollToX(self, item, index)
    local posX = 0
    if self.isShowInfo == true then
        posX = -(self.posList[index][1] - self:getScreenW()/2 + self:getScreenW()/20*13 + 86/2)
       
    else
        posX = -(self.posList[index][1] + 86/2)
    end

    TweenFactory:move2LPosX(self.mScollContentTrans, posX, 0.3)
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

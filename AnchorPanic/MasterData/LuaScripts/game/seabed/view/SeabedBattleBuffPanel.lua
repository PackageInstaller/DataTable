-- 海底主界面
module("seabed.SeabedBattleBuffPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("seabed/SeabedBattleBuffPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    -- self:setTxtTitle("战后BUFF选择")
    -- self:setSize(0, 0)
    --self:setBg("seabed_main.jpg", false, "seabed")
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mBuffList = {}

    self.mShowBuffList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mBuffScroll = self:getChildGO("mBuffScroll"):GetComponent(ty.ScrollRect)
    self.mBuffItem = self:getChildGO("mBuffItem")

    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)

    self.mBtnBuff = self:getChildGO("mBtnBuff")
    self.mTxtBuff = self:getChildGO("mTxtBuff"):GetComponent(ty.Text)
    self.mTxtBuffNum = self:getChildGO("mTxtBuffNum"):GetComponent(ty.Text)

    self.mBtnColl = self:getChildGO("mBtnColl")
    self.mTxtColl = self:getChildGO("mTxtColl"):GetComponent(ty.Text)
    self.mTxtCollNum = self:getChildGO("mTxtCollNum"):GetComponent(ty.Text)

    self.mShowBuffInfo = self:getChildGO("mShowBuffInfo")
    self.mBtnHideShowBuff = self:getChildGO("mBtnHideShowBuff")
    self.mTxtShowBuff = self:getChildGO("mTxtShowBuff"):GetComponent(ty.Text)
    self.mShowBuffScroll = self:getChildGO("mShowBuffScroll"):GetComponent(ty.ScrollRect)

    self.mShowCollectionInfo = self:getChildGO("mShowCollectionInfo")
    self.mBtnHideShowCollection = self:getChildGO("mBtnHideShowCollection")
    self.mTxtShowCollection = self:getChildGO("mTxtShowCollection"):GetComponent(ty.Text)
    self.mShowCollectionScroll = self:getChildGO("mShowCollectionScroll"):GetComponent(ty.ScrollRect)

    self.mBuffItem = self:getChildGO("mBuffItem")

    self.mBtnRes = self:getChildGO("mBtnRes")
    self.mTxtRem = self:getChildGO("mTxtRem"):GetComponent(ty.Text)
    self.mTxtResCount = self:getChildGO("mTxtResCount"):GetComponent(ty.Text)

    self.mBtnSure = self:getChildGO("mBtnSure")
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    self.battleType = args.type
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearBuffList()

    self:clearShowBuffList()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnColl, self.onBtnCollClickHandler)
    self:addUIEvent(self.mBtnHideShowCollection, self.onBtnHideShowCollectionClickHandler)

    self:addUIEvent(self.mBtnBuff, self.onBtnBuffClickHandler)
    self:addUIEvent(self.mBtnHideShowBuff, self.onBtnHideShowBuffClickHandler)

    self:addUIEvent(self.mBtnSure, self.onBtnSureClickHandler)
    self:addUIEvent(self.mBtnRes, self.onBtnResClickHandler)
end

function showPanel(self)
    self.selectId = 0
    self.mTxtBuffNum.text = #seabed.SeabedManager:getCurBuffList()
    self.mTxtCollNum.text = #seabed.SeabedManager:getCurCollectionList()


    local freeTimes = seabed.SeabedManager:getFreeResetTimes()
    local costCount = seabed.SeabedManager:getBattleCostCount()

    if freeTimes > 0 then
        self.mTxtRem.text = _TT(111054)..freeTimes
        self.mTxtResCount.gameObject:SetActive(false)
    else
        self.mTxtResCount.text = costCount
        self.mTxtResCount.gameObject:SetActive(true)
        self.mTxtRem.gameObject:SetActive(false)
    end

    local isCanRes = seabed.SeabedManager:getCanResest()
    self.mBtnRes:SetActive(self.battleType == seabed.SeabedBattleType.Buff and isCanRes)

    self:clearBuffList()
    local buffList
    if self.battleType == seabed.SeabedBattleType.Buff then
        self.mTxtTips.text = _TT(111055)
        buffList = seabed.SeabedManager:getSeabedBattlePostwar()
    elseif self.battleType == seabed.SeabedBattleType.Collage then
        self.mTxtTips.text = _TT(111056)
        buffList = seabed.SeabedManager:getSeabedBattlePostwar()
    elseif self.battleType == seabed.SeabedBattleType.SelectBuff then
        self.mTxtTips.text = "事件buff选择"
        buffList = seabed.SeabedManager:getEventSelectBuff()
    end
   
    for i = 1, #buffList, 1 do
        local item = SimpleInsItem:create(self.mBuffItem, self.mBuffScroll.content, "mSeabedBattleBuffItem")
        local vo
        if self.battleType == seabed.SeabedBattleType.Buff or self.battleType == seabed.SeabedBattleType.SelectBuff then
            vo = seabed.SeabedManager:getSeabedBuffDataById(buffList[i])
        else
            vo = seabed.SeabedManager:getSeabedCollectionDataById(buffList[i])
        end

        item.id = buffList[i]

        item:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage):SetImg("seabed/color_0"..vo.color..".png", false)
        item:getChildGO("mImgBuffIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(vo.icon), false)
        item:getChildGO("mTxtBuffName"):GetComponent(ty.Text).text = _TT(vo.name)
        item:getChildGO("mTxtBuffDes"):GetComponent(ty.Text).text = _TT(vo.des)

        item:getChildGO("mImgSelect"):SetActive(false)
       
        item:addUIEvent("mBtnClick", function()
            self:onClickItem(buffList[i])
        end)

        table.insert(self.mBuffList, item)
    end
end

function onClickItem(self,selectId)
    self.selectId = selectId 
    for i = 1, #self.mBuffList, 1 do
        self.mBuffList[i]:getChildGO("mImgSelect"):SetActive(self.mBuffList[i].id == selectId)
    end
end

function onBtnSureClickHandler(self)
    if self.selectId ~= 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_SEABED_POSTWAR_SELECT, {
            type = self.battleType,
            selectId = self.selectId
        })
        self:close()
    else
        gs.Message.Show(_TT(111057))
    end
end

function onBtnResClickHandler(self)
    local actionPoint,coin = seabed.SeabedManager:getSeabedResource()
    local freeTimes = seabed.SeabedManager:getFreeResetTimes()
    local costCount = seabed.SeabedManager:getBattleCostCount()

    if freeTimes > 0 or coin>=costCount then
        GameDispatcher:dispatchEvent(EventName.REQ_RESET_POSTAR_BUFF)
    else
        gs.Message.Show(_TT(111058))
    end
end

function clearBuffList(self)
    for i = 1, #self.mBuffList, 1 do
        self.mBuffList[i]:poolRecover()
    end
    self.mBuffList = {}
end

function onBtnHideEventInfoClickHandler(self)
    self.mEventInfo:SetActive(false)
    self:clearEventList()
end

function onBtnHideShowBuffClickHandler(self)
    self.mShowBuffInfo:SetActive(false)
    self:clearShowBuffList()
end

function onBtnBuffClickHandler(self)
    local buffList = seabed.SeabedManager:getCurBuffList()
    if #buffList == 0 then
        gs.Message.Show(_TT(111046))
        return
    end

    self.mTxtShowBuff.text = _TT(111047) .. #buffList
    self:clearShowBuffList()
    for i = 1, #buffList, 1 do
        local item = SimpleInsItem:create(self.mBuffItem, self.mShowBuffScroll.content, "mSeabedBuffItem")
        local vo = seabed.SeabedManager:getSeabedBuffDataById(buffList[i])
        item:getChildGO("mImgBuffIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(vo.icon), false)
        item:getChildGO("mTxtBuffName"):GetComponent(ty.Text).text = _TT(vo.name)
        item:getChildGO("mTxtBuffDes"):GetComponent(ty.Text).text = _TT(vo.des)
        item:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage):SetImg("seabed/color_0"..vo.color..".png", false)
        table.insert(self.mShowBuffList, item)
    end
    self.mShowBuffInfo:SetActive(true)
end

function onBtnCollClickHandler(self)
    local collectionList = seabed.SeabedManager:getCurCollectionList()
    if #collectionList == 0 then
        gs.Message.Show(_TT(111048))
        return
    end

    self.mTxtShowCollection.text = _TT(111049).. #collectionList
    self:clearShowBuffList()
    for i = 1, #collectionList, 1 do
        local item = SimpleInsItem:create(self.mBuffItem, self.mShowCollectionScroll.content, "mSeabedBuffItem")
        local vo = seabed.SeabedManager:getSeabedCollectionDataById(collectionList[i])
        item:getChildGO("mImgBuffIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(vo.icon), false)
        item:getChildGO("mTxtBuffName"):GetComponent(ty.Text).text = _TT(vo.name)
        item:getChildGO("mTxtBuffDes"):GetComponent(ty.Text).text = _TT(vo.des)
        item:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage):SetImg("seabed/color_0"..vo.color..".png", false)
        table.insert(self.mShowBuffList, item)
    end
    self.mShowCollectionInfo:SetActive(true)
end

function clearShowBuffList(self)
    for i = 1, #self.mShowBuffList, 1 do
        self.mShowBuffList[i]:poolRecover()
    end
    self.mShowBuffList = {}
end

function onBtnHideShowCollectionClickHandler(self)
    self.mShowCollectionInfo:SetActive(false)
end


return _M

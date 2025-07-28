-- 海底主界面
module("seabed.SeabedTalentPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("seabed/SeabedTalentPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(111022))
    self:setSize(0, 0)
    self:setBg("seabed_main.jpg", false, "seabed")
end

-- 初始化数据
function initData(self)
    super.initData(self)

    -- self.mTalentContentList = {}
    self.contentDic = {}
    self.mTalentDic = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTalentScroll = self:getChildGO("mTalentScroll"):GetComponent(ty.ScrollRect)
    self.mTalentContentItem = self:getChildGO("mTalentContentItem")

    self.mTalentItem = self:getChildGO("mTalentItem")
    self.mTxtAllTalent = self:getChildGO("mTxtAllTalent"):GetComponent(ty.Text)

    self.mTxtSelectTalentType = self:getChildGO("mTxtSelectTalentType"):GetComponent(ty.Text)
    self.mImgSelectTalentIcon = self:getChildGO("mImgSelectTalentIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtSelectTalentName = self:getChildGO("mTxtSelectTalentName"):GetComponent(ty.Text)
    self.mTxtSelectTalentDes = self:getChildGO("mTxtSelectTalentDes"):GetComponent(ty.Text)
    self.mBtnActive = self:getChildGO("mBtnActive")
    self.mBtnMax = self:getChildGO("mBtnMax")
    self.mTxtUnlock = self:getChildGO("mTxtUnlock"):GetComponent(ty.Text)
    self.mBtnAllTalent = self:getChildGO("mBtnAllTalent")

    self.mTxtHasTalent = self:getChildGO("mTxtHasTalent"):GetComponent(ty.Text)

    self.mTxtSelectCostCount = self:getChildGO("mTxtSelectCostCount"):GetComponent(ty.Text)
end

function initViewText(self)
    self.mTxtSelectTalentType.text = _TT(111023)
    self:getChildGO("mTxtActive"):GetComponent(ty.Text).text = _TT(111026)
    self:getChildGO("mTxtMax"):GetComponent(ty.Text).text = _TT(111027)
    self:getChildGO("mTxtUnlock"):GetComponent(ty.Text).text = _TT(111028)
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_SEABED_TALENT_PANEL, self.showPanel, self)
    
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })

    GameDispatcher:removeEventListener(EventName.UPDATE_SEABED_TALENT_PANEL, self.showPanel, self)

    self:clearTalentDic()
    self:clearContentDic()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnActive, self.onBtnActiveClickHandler)
    --self:addUIEvent(self.mBtnAllTalent, self.onBtnTalentAllClickHandler)
end

function onBtnTalentAllClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_TALENT_ALL_PANEL)
end

function onBtnActiveClickHandler(self)
    local vo = seabed.SeabedManager:getSeabedTalentDataById(self.selectId)
    if seabed.SeabedManager:getSeabedTalentPoint() >= vo.needTalent then
        GameDispatcher:dispatchEvent(EventName.REQ_SEABED_TALENT_UNLOCK,{id = self.selectId})
    else
        gs.Message.Show(_TT(111024))
    end
   
end

function showPanel(self)

    self.mTxtHasTalent.text = seabed.SeabedManager:getSeabedTalentPoint()
    local dic = seabed.SeabedManager:getSeabedTalentData()
    self.mTxtAllTalent.text = _TT(111025) .. seabed.SeabedManager:getSeabedTalentUnlockNum() .. "/" ..
                                  table.nums(dic)

    local maxRow = 0 -- 8
    local maxCol = 0 -- 3
    for k, vo in pairs(dic) do
        if vo.row > maxRow then
            maxRow = vo.row
        end

        if vo.col > maxCol then
            maxCol = vo.col
        end
    end
    self:clearTalentDic()
    self:clearContentDic()
    for i = 1, maxRow do
        for j = 1, maxCol do
            local item = SimpleInsItem:create(self.mTalentContentItem, self.mTalentScroll.content, "mSeabedContentItem")
            item.name = i .. "-" .. j
            self.contentDic[i .. "-" .. j] = item
        end
    end

    for id, vo in pairs(dic) do
        local content = self.contentDic[vo.row .. "-" .. vo.col]
        local item = SimpleInsItem:create(self.mTalentItem, content:getChildTrans("mTalentTrans"), "mSeabedTalentItem")
        gs.TransQuick:UIPos(item:getGo():GetComponent(ty.RectTransform), 0, 0)

        item:getChildGO("mImgSelect"):SetActive(false)
        item:getChildGO("mImgTalentIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(vo.icon),false)

        item:addUIEvent("mImgClick", function()
            self:onClickTalent(id)
        end)
        self.mTalentDic[vo.row .. "-" .. vo.col] = {
            item = item,
            vo = vo
        }
    end

    for key, data in pairs(self.mTalentDic) do
        self:updateLine(data.item, data.vo)
    end

    if self.selectId == nil then
        self.selectId = 1
    end
    self:onClickTalent(self.selectId)
end

function onClickTalent(self,id)
    local vo = seabed.SeabedManager:getSeabedTalentDataById(id)
    self.selectId = id

    for key, data in pairs(self.mTalentDic) do
        data.item:getChildGO("mImgSelect"):SetActive(data.vo.id == id)
    end

    --self.mTxtSelectTalentType.text = "天赋"
    self.mImgSelectTalentIcon:SetImg(UrlManager:getIconPath(vo.icon),false) 
    self.mTxtSelectTalentName = _TT(vo.title)
    self.mTxtSelectTalentDes = _TT(vo.des)

    local isPreUnLock = true
    for i = 1, #vo.preId do
        isPreUnLock = isPreUnLock and seabed.SeabedManager:getSeabedTalentMsgDataById(vo.preId[i])
    end

 
    local isUnLock = seabed.SeabedManager:getSeabedTalentMsgDataById(vo.id)
    self.mBtnActive:SetActive(isPreUnLock and not isUnLock) 
    self.mBtnMax:SetActive(isPreUnLock and isUnLock)
    self.mTxtUnlock.gameObject:SetActive(not isPreUnLock) 
    self.mTxtSelectCostCount.text = vo.needTalent

    if vo.needTalent > seabed.SeabedManager:getSeabedTalentPoint() then
        self.mTxtSelectCostCount.color = gs.ColorUtil.GetColor("fa3a2bff")
    else
        self.mTxtSelectCostCount.color = gs.ColorUtil.GetColor("ffffffff")
    end
end

function updateLine(self, item, vo)
    local line1 = item:getChildGO("mLine1")
    local line2 = item:getChildGO("mLine2")
    local line3 = item:getChildGO("mLine3")

    line1:SetActive(self:isChildLine(vo, self.mTalentDic[vo.row + 1 .. "-" .. vo.col - 1]))
    line2:SetActive(self:isChildLine(vo, self.mTalentDic[vo.row + 1 .. "-" .. vo.col]))
    line3:SetActive(self:isChildLine(vo, self.mTalentDic[vo.row + 1 .. "-" .. vo.col + 1]))

    local isUnLock = seabed.SeabedManager:getSeabedTalentMsgDataById(vo.id)
    item:getChildGO("mImgLock"):SetActive(not isUnLock)
    local lineLock1 = item:getChildGO("mLineLock1")
    local lineLock2 = item:getChildGO("mLineLock2")
    local lineLock3 = item:getChildGO("mLineLock3")
    lineLock1:SetActive(self:isChildLine(vo, self.mTalentDic[vo.row + 1 .. "-" .. vo.col - 1]))
    lineLock2:SetActive(self:isChildLine(vo, self.mTalentDic[vo.row + 1 .. "-" .. vo.col]))
    lineLock3:SetActive(self:isChildLine(vo, self.mTalentDic[vo.row + 1 .. "-" .. vo.col + 1]))
end

function isChildLine(self, vo, data)
    if data == nil then
        return false
    end
    return table.indexof01(vo.nextId, data.vo.id) > 0
end

function clearContentDic(self)
    for k, item in pairs(self.contentDic) do
        item:poolRecover()
    end
    self.contentDic = {}
end

function clearTalentDic(self)
    for k, data in pairs(self.mTalentDic) do
        data.item:poolRecover()
    end
    self.mTalentDic = {}
end

return _M

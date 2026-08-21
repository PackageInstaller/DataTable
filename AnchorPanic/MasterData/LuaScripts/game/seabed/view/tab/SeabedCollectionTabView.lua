module("seabed.SeabedCollectionTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("seabed/tab/SeabedCollectionTabView.prefab")

function getOpenType()
    return seabed.SeabedBattleType.Collage
end

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.selectType = 1
end

function configUI(self)
    super.configUI(self)

    self.mBuffItem = self:getChildGO("mBuffItem")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mBuffScroll = self:getChildGO("mBuffScroll"):GetComponent(ty.LyScroller)
    self.mBuffScroll:SetItemRender(seabed.SeabedCollectionItem)

    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgBuff = self:getChildGO("mImgBuff"):GetComponent(ty.AutoRefImage)
    self.mTxtBuffName = self:getChildGO("mTxtBuffName"):GetComponent(ty.Text)
    self.mTxtBuffDes = self:getChildGO("mTxtBuffDes"):GetComponent(ty.Text)
    self.mSelectBuffLocked = self:getChildGO("mSelectBuffLocked")
    self.mEmpty = self:getChildGO("mEmpty")
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self.tab1 = self:getChildGO("Tab_1")
    self.tab2 = self:getChildGO("Tab_2")
    self.tab3 = self:getChildGO("Tab_3")
    self.mGroupList = {self.tab1, self.tab2, self.tab3}

    self.mBtnAward = self:getChildGO("mBtnAward")

    self.mGroup = self:getChildGO("mGroup")
end

function active(self, args)
    super.active(self, args)
    self.selectType = 1
    GameDispatcher:addEventListener(EventName.ON_CLICK_SEABED_COLLECTION_ITEM, self.onClickItem, self)
    GameDispatcher:addEventListener(EventName.UPDATE_SEABED_COLLECTION_PANEL,self.updateRed,self)
    self:onBtnTabClickHandler(self.selectType)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SEABED_COLLECTION_PANEL,self.updateRed,self)
    GameDispatcher:removeEventListener(EventName.ON_CLICK_SEABED_COLLECTION_ITEM, self.onClickItem, self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.tab1, self.onBtnTabClickHandler, nil, 1)
    self:addUIEvent(self.tab2, self.onBtnTabClickHandler, nil, 2)
    self:addUIEvent(self.tab3, self.onBtnTabClickHandler, nil, 3)

    self:addUIEvent(self.mBtnAward, self.onBtnAwardClickHandler)
end

function onBtnAwardClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_SEABED_COLLECTION_AWARD_PANEL,{type = self:getOpenType()})
end

function onBtnTabClickHandler(self, type)
    self.selectType = type
    for i = 1, #self.mGroupList, 1 do
        self.mGroupList[i].transform:Find("ImgSelected").gameObject:SetActive(type == i)
    end

    self:showPanel()

    if type == 1 then
        self.mTxtTitle.text = "全部" 
        self.mTxtEmptyTip.text = "暂无收集物品"
    elseif type == 2 then
        self.mTxtTitle.text = "已收集" 
        self.mTxtEmptyTip.text = "暂无已收集物品"
    elseif type == 3 then
        self.mTxtTitle.text = "未收集" 
        self.mTxtEmptyTip.text = "暂无未收集物品"
    end
end

-- function getNum(self)
--     local has = 0
--     for i = 1, #self.list, 1 do
--         if self.list[i].has == true then
--             has = has + 1 
--         end
--     end
--     return has
-- end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end

function onClickItem(self, data)
    for i = 1, #self.list, 1 do
        self.list[i].isSelect = data.id == self.list[i].id
    end

    self.mBuffScroll:ReplaceAllDataProvider(self.list)
    self:showSelectItem(data)
end

function showSelectItem(self, data)
    self.mImgBg:SetImg(UrlManager:getIconPath("seabed/color_0" .. data.color .. ".png"), false)
    self.mImgBuff:SetImg(UrlManager:getIconPath(data.icon), false)
   
    self.mSelectBuffLocked:SetActive(not data.has)
    if data.has then
        self.mTxtBuffName.text = _TT(data.name)
        self.mTxtBuffDes.text = _TT(data.des)
        --self.mImgBuff.color = gs.ColorUtil.GetColor("FFFFFFFF")
    else
        self.mTxtBuffName.text = _TT(111064)
        self.mTxtBuffDes.text = _TT(111065)
        --self.mImgBuff.color = gs.ColorUtil.GetColor("4D4D4DFF")
    end
end

function showPanel(self)
    local taskType = self:getOpenType()
    --self.mBtnAward:SetActive(seabed.SeabedBattleType.Collage == taskType)
    local dic
    if seabed.SeabedBattleType.Collage == taskType then
        dic = seabed.SeabedManager:getSeabedCollectionData()
    elseif seabed.SeabedBattleType.Buff == taskType then
        dic = seabed.SeabedManager:getSeabedBuffData()
    end

    self.list = {}
    for id, vo in pairs(dic) do
        if seabed.SeabedBattleType.Collage == taskType then
            vo.has = seabed.SeabedManager:getHisCollectionIsHas(id)
        elseif seabed.SeabedBattleType.Buff == taskType then
            vo.has = seabed.SeabedManager:getHisBuffIsHas(id)
        end
        vo.isSelect = false
        vo.taskType = taskType

        if self.selectType == 1 then
            table.insert(self.list, vo)
        elseif self.selectType == 2 then
            if vo.has == true then
                table.insert(self.list, vo)
            end
        elseif self.selectType == 3 then
            if vo.has == false then
                table.insert(self.list, vo)
            end
        end
    end

    table.sort(self.list, function(a, b)
        return a.id < b.id
    end)

    self.mBuffScroll.DataProvider = self.list
    if self.list and #self.list > 0 then
        self.mEmpty:SetActive(false)
        self:onClickItem(self.list[1])
        self.mGroup:SetActive(true)
    else
        self.mEmpty:SetActive(true)
        self.mGroup:SetActive(false)
    end

    self:updateRed()
end

function updateRed(self)
    if seabed.SeabedManager:canGetGain(self:getOpenType()) then
        RedPointManager:add(self.mBtnAward.transform, nil, 27, 45)
    else
        RedPointManager:remove(self.mBtnAward.transform)
    end
end

return _M

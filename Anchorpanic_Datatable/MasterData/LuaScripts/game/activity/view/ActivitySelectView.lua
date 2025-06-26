module("game.activity.view.ActivitySelectView", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("activity/ActivitySelectView.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowMoneyBar = 1

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(136501))
    self:setSize(1120, 520)
end

function initData(self)
    self.posDic = {}
    self.mSelectItemList = {}
    self.mSelectPropsItemList = {}
    self.mPropsGridList = {}
end

function configUI(self)
    super.configUI(self)

    self.mSelectScroll = self:getChildGO("mSelectScroll"):GetComponent(ty.ScrollRect)
    self.mSelectItem = self:getChildGO("mSelectItem")
    self.mSelectPropsItem = self:getChildGO("mSelectPropsItem")

    self.mTxtSave = self:getChildGO("mTxtSave"):GetComponent(ty.Text)
    self.mTxtPrice = self:getChildGO("mTxtPrice"):GetComponent(ty.Text)

    self.mBtnSave = self:getChildGO("mBtnSave")
    self.mBtnPrice = self:getChildGO("mBtnPrice")
end

function active(self, args)
    super.active(self, args)
    self.selectId = args.id

    local msgData = activity.ActitvityExtraManager:getSelectGiftMsgData(self.selectId)
    if msgData then
        for i = 1, #msgData.grid_select_list do
            self.posDic[msgData.grid_select_list[i].grid_id] = msgData.grid_select_list[i].select_id
        end
    end

    self:showPanel()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtSave.text = _TT(173)
end

function deActive(self)
    super.deActive(self)

    self:clearPropsGridItemList()
    self:clearSelectPropsItemList()
    self:clearSelectItemList()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSave, self.onBtnSaveClick)
    self:addUIEvent(self.mBtnPrice, self.onBtnPriceClick)
end

function onBtnSaveClick(self)
    local vo = activity.ActitvityExtraManager:getSelectBuyDataById(self.selectId)
    local list = {}
    for k, v in pairs(self.posDic) do
        if v ~= 0 then
            table.insert(list, {
                grid_id = k,
                select_id = v
            })
        end
    end
    activity.ActitvityExtraManager:setIsRMBBuy(self.selectId, false)
    GameDispatcher:dispatchEvent(EventName.REQ_ACTIVITY_SELECT_BUY_SAVE, {
        giftId = self.selectId,
        gridSelectList = list
    })

    self:close()
end

function onBtnPriceClick(self)
    local vo = activity.ActitvityExtraManager:getSelectBuyDataById(self.selectId)

    local list = {}
    for k, v in pairs(self.posDic) do
        if v ~= 0 then
            table.insert(list, {
                grid_id = k,
                select_id = v
            })
        end
    end

    if #list == #vo.selectList then
        activity.ActitvityExtraManager:setIsRMBBuy(self.selectId, true)
        GameDispatcher:dispatchEvent(EventName.REQ_ACTIVITY_SELECT_BUY_SAVE, {
            giftId = self.selectId,
            gridSelectList = list
        })
    else
        gs.Message.Show(_TT(149002))
    end

end

function showPanel(self)
    local vo = activity.ActitvityExtraManager:getSelectBuyDataById(self.selectId)
    self:setTxtTitle(_TT(vo.name))
    self.mTxtPrice.text = "¥" .. vo.price .._TT(9)
    self:clearPropsGridItemList()
    self:clearSelectPropsItemList()
    self:clearSelectItemList()

    -- 默认固定位置
    local item = SimpleInsItem:create(self.mSelectItem, self.mSelectScroll.content, "mSelectViewItem1")
    item:getChildGO("mTxtNorml"):SetActive(true)
    item:getChildGO("mSelectInfo"):SetActive(false)

    item:getChildGO("mTxtNorml"):GetComponent(ty.Text).text = _TT(149001)
    
    local selectItem = SimpleInsItem:create(self.mSelectPropsItem, item:getChildTrans("mSelectPropsContent"),
        "mSelectPropsItem1")
    selectItem:getChildGO("mImgNor"):SetActive(true)
    selectItem:getChildGO("mIsSelect"):SetActive(false)
    gs.TransQuick:UIPos(selectItem.m_go:GetComponent(ty.RectTransform), 0, 0)
    local propsGrid = PropsGrid:createByData({
        tid = vo.normalItemTid,
        num = vo.normalItemNum,
        parent = selectItem:getChildTrans("mPropsContent"),
        scale = 0.56,
        showUseInTip = false
    })

    selectItem:addUIEvent("mBtnClick",function ()
        local propsVo = props.PropsManager:getPropsConfigVo(vo.normalItemTid)
        TipsFactory:propsTips({propsVo = propsVo, isShowUseBtn = self.mIsShowUseInTip})
    end)

    table.insert(self.mPropsGridList, propsGrid)
    table.insert(self.mSelectPropsItemList, selectItem)
    table.insert(self.mSelectItemList, item)

    -- 非固定位置
    for i = 1, #vo.selectList do
        local index = 0
        local childItem = SimpleInsItem:create(self.mSelectItem, self.mSelectScroll.content, "mSelectItem2")
        childItem:getChildGO("mTxtNorml"):SetActive(false)
        childItem:getChildGO("mSelectInfo"):SetActive(true)

        -- 左侧部分
        local selectChildItem = SimpleInsItem:create(self.mSelectPropsItem,
            childItem:getChildTrans("mSelectPropsContent"), "mSelectPropsItem2")
        selectChildItem:getChildGO("mImgNor"):SetActive(false)
        selectChildItem:getChildGO("mIsSelect"):SetActive(false)
        gs.TransQuick:UIPos(selectChildItem.m_go:GetComponent(ty.RectTransform), 0, 0)
        if self.posDic and self.posDic[i] and self.posDic[i] > 0 then
            index = self.posDic[i]
            local selectPropsData = vo.selectList[i].data.childList[index]
            local selectProps = PropsGrid:createByData({
                tid = selectPropsData.tid,
                num = selectPropsData.num,
                parent = selectChildItem:getChildTrans("mPropsContent"),
                scale = 0.56,
                showUseInTip = false
            })

            selectChildItem:addUIEvent("mBtnClick",function ()
                local propsVo = props.PropsManager:getPropsConfigVo(vo.selectList[i].data.childList[index].tid)
                TipsFactory:propsTips({propsVo = propsVo, isShowUseBtn = self.mIsShowUseInTip})
            end)
    
            table.insert(self.mPropsGridList, selectProps)
        end

       

        -- 右侧可选部分
        for j = 1, #vo.selectList[i].data.childList do
            local content = childItem:getChildGO("mCanSelectScroll"):GetComponent(ty.ScrollRect).content
            local canSelectItem = SimpleInsItem:create(self.mSelectPropsItem, content, "canSelectViewItem")
            canSelectItem:getChildGO("mImgNor"):SetActive(false)
            canSelectItem:getChildGO("mIsSelect"):SetActive(index == j)
            local canSelectPropsGrid = PropsGrid:createByData({
                tid = vo.selectList[i].data.childList[j].tid,
                num = vo.selectList[i].data.childList[j].num,
                parent = canSelectItem:getChildTrans("mPropsContent"),
                scale = 0.56,
                showUseInTip = false
            })

            canSelectItem:addUIEvent("mBtnClick", function()
                local data = {
                    id = j,
                    tid = vo.selectList[i].data.childList[j].tid,
                    num = vo.selectList[i].data.childList[j].num
                }
                self:updateSelectProps(i, data)
            end)
            table.insert(self.mPropsGridList, canSelectPropsGrid)
            table.insert(self.mSelectPropsItemList, canSelectItem)
        end

        table.insert(self.mSelectPropsItemList, selectChildItem)
        table.insert(self.mSelectItemList, childItem)
    end
end

function updateSelectProps(self, id, data)
    self.posDic[id] = data.id
    self:showPanel()
end

function clearSelectItemList(self)
    for i = 1, #self.mSelectItemList do
        self.mSelectItemList[i]:poolRecover()
    end
    self.mSelectItemList = {}
end

function clearSelectPropsItemList(self)
    for i = 1, #self.mSelectPropsItemList do
        self.mSelectPropsItemList[i]:poolRecover()
    end
    self.mSelectPropsItemList = {}
end

function clearPropsGridItemList(self)
    for i = 1, #self.mPropsGridList do
        self.mPropsGridList[i]:poolRecover()
    end
    self.mPropsGridList = {}
end

return _M

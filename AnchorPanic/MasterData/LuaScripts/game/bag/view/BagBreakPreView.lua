--[[ 
-----------------------------------------------------
@filename       : BagBreakPreView
@Description    : 道具分解预览
@date           : 2021-11-01 17:18:58
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.bag.view.BagBreakPreView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("bag/BagBreakPreView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mItemList = {}
end

-- 初始化
function configUI(self)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mImgTitle = self:getChildGO("mImgTitle"):GetComponent(ty.AutoRefImage)
    self.mTxtBreakInfo = self:getChildGO("mTxtBreakInfo"):GetComponent(ty.Text)
    self.mTipsTxt = self:getChildGO("mTipsTxt"):GetComponent(ty.Text)
    self.mTxtColorTitle = self:getChildGO("mTxtColorTitle"):GetComponent(ty.Text)

    self.mBtnReturen = self:getChildGO("mBtnReturen")
    self.mBtnCloseAll = self:getChildGO("mBtnCloseAll")
    self.mBtnBreak = self:getChildGO("mBtnBreak")
    self.mBtnPreview = self:getChildGO("mBtnPreview")
    self.mImgTips = self:getChildGO("mImgTips")

    self.mGruopPreview = self:getChildGO("mGruopPreview")
    self.mPreviewScrollerGo = self:getChildGO("LyScroller")
    self.mPreviewScroller = self.mPreviewScrollerGo:GetComponent(ty.LyScroller)
    self.mPreviewScroller:SetItemRender(bag.BagEquipPreviewScrollerItem)
    self.mItemScroller = self:getChildTrans("mItemScroller")
    self.mScrollContent = self:getChildTrans("Content")

    self.mTxtNumG = self:getChildGO("mTxtNumG"):GetComponent(ty.Text)
    self.mTxtNumB = self:getChildGO("mTxtNumB"):GetComponent(ty.Text)
    self.mTxtNumP = self:getChildGO("mTxtNumP"):GetComponent(ty.Text)
    self.mTxtNumO = self:getChildGO("mTxtNumO"):GetComponent(ty.Text)

end

--激活
function active(self, args)
    super.active(self, args)
    self.tabType = args.tabType
    self.suitId = args.suitId

    self.mTxtTitle.text = bag.getPageName(self.tabType)
    self.mImgTitle:SetImg(bag.getIconURL(self.tabType), true)

    bag.BagManager:addEventListener(bag.BagManager.EVENT_BREAK_SHOW_UPDATE, self.onBreakShowUpdate, self)
    GameDispatcher:addEventListener(EventName.BAG_BREAK_UPDATE_VIEW, self.onSelectUpdate, self)

    self:updateBreakPreviewView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    bag.BagManager:removeEventListener(bag.BagManager.EVENT_BREAK_SHOW_UPDATE, self.onBreakShowUpdate, self)
    GameDispatcher:removeEventListener(EventName.BAG_BREAK_UPDATE_VIEW, self.onSelectUpdate, self)
    self:resetData()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.mBtnBreak, 4050, "确认分解")
    self:setBtnLabel(self.mBtnReturen,4030, "返回")
    self.mTxtBreakInfo.text = _TT(4051) --"分解可获得"
    self.mTipsTxt.text = _TT(4052) --"—可获得的道具—"
    self.mTxtColorTitle.text = _TT(4053) --"选择品质"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBreak, self.onBreak)
    self:addUIEvent(self.mBtnPreview, self.onClickClose)
    self:addUIEvent(self.mBtnReturen, self.onClickClose)
    self:addUIEvent(self.mBtnCloseAll, self.closeAll)
end

function onBreakShowUpdate(self, args)
    self:showBreakView(args)
end

function onSelectUpdate(self)
    self:updateBreakPreviewView(false)
end

-- 取类型道具列表
function getTypsList(self, cusType)
    local suitIdList = self.suitId and {self.suitId} or nil
    local propsList = bag.BagManager:getBagPagePropsList(self.tabType, suitIdList)
    local list = {}
    for i, vo in ipairs(propsList) do
        if cusType == 1 and vo.color == ColorType.GREEN and vo.isLock == 0 then
            table.insert(list, vo.id)
        end
        if cusType == 2 and vo.color == ColorType.BLUE and vo.isLock == 0 then
            table.insert(list, vo.id)
        end
        if cusType == 3 and vo.color == ColorType.VIOLET and vo.isLock == 0 then
            table.insert(list, vo.id)
        end
    end
    return list
end

function onBreak(self)
    local idList = bag.BagManager:getBreakList()
    if not idList or #idList <= 0 then
        gs.Message.Show(_TT(4022)) --'列表为空不可分解'
        return
    end

    for i, v in ipairs(idList) do
        local propsVo = bag.BagManager:getPropsVoById(idList[i])
        if propsVo.color >= ColorType.ORANGE then
            UIFactory:alertMessge(_TT(4023), true, function() --'分解的道具中包含橙色品质的道具，是否继续分解？'
                self:sendBreak()
            end, _TT(1), nil, true) --确定
            return
        end
    end
    self:sendBreak()
end

function sendBreak(self)
    GameDispatcher:dispatchEvent(EventName.REQ_BREAK_PROPS)
    self:resetData()
    bag.BagManager:clearSellBreakData()
    GameDispatcher:dispatchEvent(EventName.BAG_BREAK_PRE_VIEW_CLOSE)
    self:close()
end

-- 更新分解预览界面
function updateBreakPreviewView(self)
    local type = nil
    local idList = bag.BagManager:getBreakList()
    local scrollList = {}
    for i = 1, #idList do
        local equipVo = bag.BagManager:getPropsVoById(idList[i])
        type = equipVo.__cname
        if bag.BagManager.propsOpState ~= 2 or equipVo.isLock ~= 1 then
            local scrollerVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
            scrollerVo:setDataVo(equipVo)
            scrollerVo:setSelect(false)
            table.insert(scrollList, scrollerVo)
        end
    end

    self.mPreviewScroller:CleanAllItem()
    self.mPreviewScroller:SetItemGameObject(self:getChildGO("LyScrollerItem2"))
    -- if type == props.EquipVo.__cname then
    --     self.mPreviewScroller:SetItemGameObject(self:getChildGO("LyScrollerItem"))
    -- else
    --     self.mPreviewScroller:SetItemGameObject(self:getChildGO("LyScrollerItem2"))
    -- end
    self.mPreviewScroller.DataProvider = scrollList

    local len = #scrollList
    self:setBtnLabel(self.mBtnPreview, 4026, string.format("已选:%s", len), len) --"已选：" .. HtmlUtil:colorAndSize(len, "81cdffff", 22)

    self:showBreakView()
    self:updateSelectNum()
end

function updateSelectNum(self)
    local numG, numB, numP, numO = 0, 0, 0, 0
    local idList = bag.BagManager:getBreakList()
    for i = 1, #idList do
        local equipVo = bag.BagManager:getPropsVoById(idList[i])
        if equipVo.color == ColorType.GREEN then
            numG = numG + 1
        end
        if equipVo.color == ColorType.BLUE then
            numB = numB + 1
        end
        if equipVo.color == ColorType.VIOLET then
            numP = numP + 1
        end
        if equipVo.color == ColorType.ORANGE then
            numO = numO + 1
        end
    end
    self.mTxtNumG.text = "x" .. numG
    self.mTxtNumB.text = "x" .. numB
    self.mTxtNumP.text = "x" .. numP
    self.mTxtNumO.text = "x" .. numO
end

-- 分解预览更新
function showBreakView(self, args)
    self:clearBreakList()
    local idList = bag.BagManager:getBreakList()
    if not idList then
        return
    end
    local list = {}
    for i, v in ipairs(idList) do
        local propsVo = bag.BagManager:getPropsVoById(idList[i])
        local data = bag.BagManager:getBreakBaseData(propsVo.tid, 2)
        for i, v in ipairs(data.propsList) do
            if not list[v.tid] then
                list[v.tid] = v.count
            else
                list[v.tid] = list[v.tid] + v.count
            end
        end
    end
    for tid, count in pairs(list) do
        local propsVo = props.PropsManager:getPropsVo({ tid = tid, num = count })
        local grid = PropsGrid:create(self.mScrollContent, propsVo, 0.6)
        grid:setIsShowCount(false)
        grid:setIsShowCount2(true)

        table.insert(self.mItemList, grid)
    end

    self:onScollOver()

    if #list > 0 then
        self.mImgTips:SetActive(false)
    else
        self.mImgTips:SetActive(true)
    end
end

function clearBreakList(self)
    for i = #self.mItemList, 1, -1 do
        local item = self.mItemList[i]
        item:poolRecover()
        table.remove(self.mItemList, i)
    end
end

-- 取消全选状态
function cancelToggeState(self, args)
    if not args or args.state == 1 then
        return
    end
    local propsVo = bag.BagManager:getPropsVoById(args.id)
    if self.mToggleG.isOn and propsVo.color == ColorType.GREEN then
        self.mToggleG.onValueChanged:RemoveAllListeners()
        self.mToggleG.isOn = false
        self:addToggleGEvent()
    end
    if self.mToggleB.isOn and propsVo.color == ColorType.BLUE then
        self.mToggleB.onValueChanged:RemoveAllListeners()
        self.mToggleB.isOn = false
        self:addToggleBEvent()
    end
    if self.mToggleP.isOn and propsVo.color == ColorType.VIOLET then
        self.mToggleP.onValueChanged:RemoveAllListeners()
        self.mToggleP.isOn = false
        self:addTogglePEvent()
    end
end


-- 滚动到最新
function onScollOver(self)
    local scollOver = function()
        if self.mScrollContent.sizeDelta.y >= self.mItemScroller.rect.size.y then
            local pos = self.mScrollContent.anchoredPosition
            local _y = self.mScrollContent.sizeDelta.y - self.mItemScroller.rect.size.y + 10
            TweenFactory:move2LPosY(self.mScrollContent, _y, 0.3)
        end
    end
    self:clearTimeout(self.tid)
    self.tid = self:setTimeout(0.1, scollOver)
end

function resetData(self)
    self:clearBreakList()
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

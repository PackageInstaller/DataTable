--[[-----------------------------------------------------
@filename       : SandPlayFishingTeachingView
@Description    : 钓鱼教学提示面板
@date           : 2024-01-04 11:54:50
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.sandPlay.view.SandPlayFishingTeachingView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("sandPlay/SandPlayFishingTeachingView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 540)
    self:setTxtTitle(_TT(28011))
end
--析构
function dtor(self)
end

function initData(self)
    self.mItemList = {}
    self.mSelectItemList = {}
end

-- 初始化
function configUI(self)
    self.mBtnClose = self:getChildGO("mBtnClose")

    self.mBtnLeft = self:getChildGO("mBtnLeft")
    self.mBtnRight = self:getChildGO("mBtnRight")

    self.mScrollView = self:getChildTrans("mScrollView")
    self.mScrollContent = self:getChildTrans("Content")
    self.mGroupLocal = self:getChildTrans("mGroupLocal")
    self.scrollRect = self.mScrollView:GetComponent(ty.ScrollRect)
    self.mEventTrigger = self.mScrollView:GetComponent(ty.LongPressOrClickEventTrigger)

    self.mTxtContent = self:getChildGO("mTxtContent"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)
    self.resList = args.resList
    -- self.title = args.title
    self.des = args.des

    self:updateView()
    local function _onBeginDrag()
        self:__onBeginDragHandler()
    end
    self.mEventTrigger.onBeginDrag:AddListener(_onBeginDrag)
    local function _onEndDrag()
        self:__onEndDragHandler()
    end
    self.mEventTrigger.onEndDrag:AddListener(_onEndDrag)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self.mEventTrigger.onBeginDrag:RemoveAllListeners()
    self.mEventTrigger.onEndDrag:RemoveAllListeners()
    LoopManager:removeFrameByIndex(self.frameId)
    LoopManager:removeFrame(self, self.onUpdate)
    if self.mSelectItem then
        self.mSelectItem:getChildGO("mImgSelect"):SetActive(false)
        self.mSelectItem:getChildGO("mImgNomal"):SetActive(true)
        self.mSelectItem = nil
    end
    self:recoverItem()
end

--[[    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
    self:addUIEvent(self.mBtnLeft, self.onClickLeft)
    self:addUIEvent(self.mBtnRight, self.onClickRight)
end

-- 创建内容
function updateView(self)
    self:recoverItem()
    -- local lastItem = nil

    for i, resName in ipairs(self.resList) do
        local item = SimpleInsItem:create(self:getChildGO("GroupShowItem"), self.mScrollContent, "TeachingTipsViewShowItem")
        table.insert(self.mItemList, item)
        item:getChildGO("mImgInfo"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getBgPath(string.format("sandPlay/%s.jpg", resName)), true)
        item:getChildGO("mImgArrow"):SetActive(false)
        -- if lastItem then
        --     lastItem:getChildGO("mImgArrow"):SetActive(true)
        -- end
        -- lastItem = item

        local item = SimpleInsItem:create(self:getChildGO("GroupSelectItem"), self.mGroupLocal, "TeachingTipsViewSelectItem")
        table.insert(self.mSelectItemList, item)
        if i == 1 then
            self.mSelectItem = item
            item:getChildGO("mImgSelect"):SetActive(true)
            item:getChildGO("mImgNomal"):SetActive(false)
        end
    end

    self:setPosList()
    self:setPageIndex(1)
end

-- 回收项
function recoverItem(self)
    for i, v in pairs(self.mItemList) do
        v:poolRecover()
    end
    for i, v in pairs(self.mSelectItemList) do
        v:poolRecover()
    end
    self.mItemList = {}
    self.mSelectItemList = {}
end

function setPosList(self)
    self.posList = {}
    self.frameId = LoopManager:addFrame(3, 1, self, function()
        --剩余显示的长度  总长度减去 ScrollView的 长
        local horizontalLrngth = self.mScrollContent.rect.width - self.mScrollView.rect.width

        for i = 1, self.mScrollContent.childCount do
            -- 然后开始保存每一个子物体得开始位置  因为要翻页
            local posx = (self.mScrollView.rect.width) * (i - 1) / horizontalLrngth
            table.insert(self.posList, posx)
        end
    end)
end

-- 开始拖动
function __onBeginDragHandler(self)
    self.isDrag = true
    self.mTimes = 0
    self.startHorizontal = self.scrollRect.horizontalNormalizedPosition
    LoopManager:addFrame(1, 0, self, self.onUpdate)
    self:removeTimerByIndex(self.mTimeId)
    self.mTimeId = nil
end
-- 拖动结束
function __onEndDragHandler(self)
    local posX = self.scrollRect.horizontalNormalizedPosition--记录放手的 位置

    posX = posX + ((posX - self.startHorizontal) * 0.66)

    posX = posX < 1 and posX or 1
    posX = posX > 0 and posX or 0

    local index = 1

    local offset = math.abs(self.posList[index] - posX)

    for i = 1, #self.posList do
        local temp = math.abs(self.posList[i] - posX)
        if temp < offset then
            index = i
            offset = temp
        end
    end

    self:setPageIndex(index)
    self.tergetHorizontal = self.posList[index]
    self.isDrag = false
    self.startTime = 0
    self.stopMOVE = false
end

function onClickLeft(self)
    self:pageTo(self.currentPageIndex - 1)
end
function onClickRight(self)
    self:pageTo(self.currentPageIndex + 1)
end

-- 跳转到某一页
function pageTo(self, index, noTween)
    if index > 0 and index <= #self.posList then
        if noTween then
            self.scrollRect.horizontalNormalizedPosition = self.posList[index]
        else
            self.tergetHorizontal = self.posList[index]
            self.startTime = 0
            self.isDrag = false
            self.stopMOVE = false
            LoopManager:addFrame(1, 0, self, self.onUpdate)
        end
        self:setPageIndex(index)
    end
end
-- 设置当前页
function setPageIndex(self, index)
    if (self.currentPageIndex ~= index) then
        self.currentPageIndex = index
    end

    if self.mSelectItem then
        self.mSelectItem:getChildGO("mImgSelect"):SetActive(false)
        self.mSelectItem:getChildGO("mImgNomal"):SetActive(true)
    end
    local selectItem = self.mSelectItemList[index]
    if selectItem then
        selectItem:getChildGO("mImgSelect"):SetActive(true)
        selectItem:getChildGO("mImgNomal"):SetActive(false)
        self.mSelectItem = selectItem
    end

    self.mTxtContent.text = _TT(self.des[index])

    if self.currentPageIndex <= 1 then
        self.mBtnLeft:SetActive(false)
        self.mBtnRight:SetActive(true)
    end
    if self.currentPageIndex >= #self.mItemList then
        self.mBtnLeft:SetActive(true)
        self.mBtnRight:SetActive(false)
    end
end
-- 差值缓动
function onUpdate(self)
    if not self.isDrag and not self.stopMOVE then
        self.startTime = self.startTime + LoopManager:getDeltaTime()
        local t = self.startTime * 3
        self.scrollRect.horizontalNormalizedPosition = gs.Mathf.Lerp(self.scrollRect.horizontalNormalizedPosition, self.tergetHorizontal, t)
        if t >= 1 then
            self.stopMOVE = true
            LoopManager:removeFrame(self, self.onUpdate)
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
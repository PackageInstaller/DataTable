module("tips.RecommandTip", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/RecommandTips.prefab")

panelType = -1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 1 -- 是否
isAddMask = 1
--构造函数
function ctor(self)
    super.ctor(self)
end

--析构函数
function dtor(self)
    super.dtor(self)
end

-- 初始化数据
function initData(self)
    self.mNowIndex = 1
    self.mBarList = {}
    self.mMouseStart = 0
end

--初始化UI
function configUI(self)
    super.configUI(self)
    self.mLeft = self:getChildGO("mLeft")
    self.mRight = self:getChildGO("mRight")
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mReCommandBg = self:getChildGO("mReCommandBg"):GetComponent(ty.AutoRefImage)
    self.mTxtRecommand = self:getChildGO("mTxtRecommand"):GetComponent(ty.Text)
    self.mBarContent = self:getChildTrans("mBarContent")
    self.mBar = self:getChildGO("mBar")
    self.mDrag = self:getChildGO("Group"):GetComponent(ty.LongPressOrClickEventTrigger)

    self:setGuideTrans("funcTips_RecommandTip_BtnRight", self:getChildTrans("mRight"))
    self:setGuideTrans("funcTips_RecommandTip_BtnLeft", self:getChildTrans("mLeft"))
    self:setGuideTrans("funcTips_RecommandTip_tips", self:getChildTrans("Group"))
end

function initViewText(self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mLeft, self.onClickLeft)
    self:addUIEvent(self.mRight, self.onClickRight)
end

function onClickLeft(self)
    self.mNowIndex = self.mNowIndex - 1
    self:updateView()
end

function onClickRight(self)
    self.mNowIndex = self.mNowIndex + 1
    self:updateView()
end

function active(self, args)
    super.active(self, args)
    self.mData = args.data
    self.mCloseCall = args.closeCall

    self.mNowIndex = 1
    self:updateView()
    function beginDrag()
        self.mMouseStart = gs.Input.mousePosition.x
    end

    self.mDrag.onBeginDrag:AddListener(beginDrag)
    function endDrag()
        if gs.Input.mousePosition.x > self.mMouseStart then 
            if self.mNowIndex ~= 1 then 
                self:onClickLeft()
            end
        else
            if self.mNowIndex ~= self.mData:getCount() then 
                self:onClickRight()
            end
        end
    end
    self.mDrag.onEndDrag:AddListener(endDrag)
end

function deActive(self)
    super.deActive(self)
    self.mDrag.onBeginDrag:RemoveAllListeners()
    self.mDrag.onEndDrag:RemoveAllListeners()
    self:recoverItems()
end

function close(self)
    if self.mCloseCall then 
        self.mCloseCall()
    end

    super.close(self)
end

function updateView(self, type)
    self.mLeft:SetActive(self.mNowIndex ~= 1)
    self.mRight:SetActive(self.mNowIndex ~= self.mData:getCount())

    self.mTxtDes.text = self.mData:getDes(self.mNowIndex)
    self.mReCommandBg:SetImg(UrlManager:getBgPath(self.mData:getType(self.mNowIndex)))
    self.mTxtRecommand.text = self.mData:getTitle(self.mNowIndex)
    self:recoverItems()

    local isShowBar = self.mData:getCount() > 1
    self.mBarContent.gameObject:SetActive(isShowBar)
    if isShowBar then 
        for i = 1, self.mData:getCount() do
            local barItem = SimpleInsItem:create(self.mBar, self.mBarContent, "RecommandTipBar")
            local image = barItem:getGo():GetComponent(ty.Image)
            if self.mNowIndex == i then
                image.color = gs.ColorUtil.GetColor("ffffffff")
            else
                image.color = gs.ColorUtil.GetColor("00000080")
            end
            table.insert(self.mBarList, barItem)
        end
    end
end


function recoverItems(self)
    if #self.mBarList > 0 then
        for _, item in ipairs(self.mBarList) do
            item:poolRecover()
            item = nil
        end
        self.mBarList = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
    语言包: _TT(36):   "效果"
]]
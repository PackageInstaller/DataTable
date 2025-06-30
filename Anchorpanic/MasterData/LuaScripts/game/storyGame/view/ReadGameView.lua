--[[ 
-----------------------------------------------------
@filename       : ReadGameView
@Description    : 阅读文件小游戏
@date           : 2021-02-06 10:17:51
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.view.view.ReadGameView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("storyGame/ReadGameView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mIndex = 1
    self.mMaxLen = 2
end

-- 初始化
function configUI(self)
    self.mGroupTrigger = self:getChildGO("mGroup"):GetComponent(ty.LongPressOrClickEventTrigger)
    self.mImgInfo = self:getChildGO("mImgInfo"):GetComponent(ty.AutoRefImage)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mBtnLeft = self:getChildGO("mBtnLeft")
    self.mBtnRight = self:getChildGO("mBtnRight")
    self.mBtnClose = self:getChildGO("mBtnClose")
end

--激活
function active(self)
    super.active(self)
    local function _onBeginDownHandler()
        self:onBeginDown()
    end
    self.mGroupTrigger.onPointerDown:AddListener(_onBeginDownHandler)

    local function _onEndUpHandler()
        self:onEndUp()
    end
    self.mGroupTrigger.onPointerUp:AddListener(_onEndUpHandler)


    self.mIndex = 1
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self.mGroupTrigger.onPointerDown:RemoveAllListeners()
    self.mGroupTrigger.onPointerUp:RemoveAllListeners()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtTips.text = "左右滑动翻页"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)
    self:addUIEvent(self.mBtnLeft, self.onLeft)
    self:addUIEvent(self.mBtnRight, self.onRight)
end

function onBeginDown(self)
    self.mMousePos = gs.Input.mousePosition
    self:updateView()
end

function onEndUp(self)
    local endPos = gs.Input.mousePosition

    if self.mMousePos.x < endPos.x and (endPos.x - self.mMousePos.x > 150) then
        self.mIndex = math.max(1, self.mIndex - 1)
    elseif self.mMousePos.x > endPos.x and (self.mMousePos.x - endPos.x > 150) then
        self.mIndex = math.max(self.mMaxLen, self.mIndex + 1)
    end
    self:updateView()
end

function onLeft(self)
    self.mIndex = math.min(1, self.mIndex - 1)
    self:updateView()
end
function onRight(self)
    self.mIndex = math.max(1, self.mIndex + 1)
    self:updateView()
end

function updateView(self)
    self.mBtnLeft:SetActive(true)
    self.mBtnRight:SetActive(true)
    self.mBtnClose:SetActive(false)
    if self.mIndex == 1 then
        self.mTxtTips.gameObject:SetActive(true)
        self.mBtnLeft:SetActive(false)
    else
        self.mTxtTips.gameObject:SetActive(false)
    end

    if self.mIndex >= self.mMaxLen then
        self.mBtnRight:SetActive(false)
        self.mBtnClose:SetActive(true)
    end
    self.mImgInfo:SetImg(UrlManager:getBgPath(string.format("storycharbg/%s.png", (6100 + self.mIndex))))

end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

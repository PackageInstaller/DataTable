--[[ 
-----------------------------------------------------
@filename       : MiniProduceView
@Description    : 迷你工厂-生产列表页面
@date           : 2022-02-28 17:27:27
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("miniFac.MiniProduceView", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("factory/MiniProduceView.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAdapta = 0--是否开启适配刘海 0 否 1 是
--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(43706))
    self:setSize(1278, 520)
end

function initData(self)
end

--析构
function dtor(self)
end

--初始化
function configUI(self)
    super.configUI(self)
    self.mLyScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(miniFac.MiniFactoryProduceItem)
    self.mImgNo = self:getChildGO("mImgNo")
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self:updateView()
end

--激活
function active(self, args)
    super.active(self, args)
    self.mTxtEmptyTip.text = _TT(60515)
    GameDispatcher:addEventListener(EventName.UPDATE_FACTORY_INFO, self.updateView, self)
    GameDispatcher:dispatchEvent(EventName.REQ_FACTORY_INFO)
end

--反激活(销毁工作)
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FACTORY_INFO, self.updateView, self)
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
end

function initViewTxt(self)

end

function addAllUIEvent(self)
end

function updateView(self)
    local list = miniFac.MiniFactoryManager:getProduceList()
    self.mImgNo:SetActive(#list <= 0)
    if self.mLyScroller.Count <= 0 then
        self.mLyScroller.DataProvider = list
    else
        self.mLyScroller:ReplaceAllDataProvider(list)
    end
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]
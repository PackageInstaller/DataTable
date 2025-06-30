--[[ 
-----------------------------------------------------
@filename       : CyclePassPanel
@Description    : 事影循回总结算界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("cycle.CyclePassPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CyclePassPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("cycle_bg_002.jpg", false, "cycle")
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mScoreList = {}
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTitle.text = _TT(27558)
    self.mTxtColl.text = _TT(27559)
    self.mTxtHero.text = _TT(27560)
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)

    self.mTxtColl = self:getChildGO("mTxtColl"):GetComponent(ty.Text)
    self.mTxtCollCount = self:getChildGO("mTxtCollCount"):GetComponent(ty.Text)

    self.mBuffLyScroller = self:getChildGO("mBuffLyScroller"):GetComponent(ty.LyScroller)
    self.mBuffLyScroller:SetItemRender(cycle.CyclePassCollItem)

    self.mTxtHero = self:getChildGO("mTxtHero"):GetComponent(ty.Text)
    self.mTxtHeroCount = self:getChildGO("mTxtHeroCount"):GetComponent(ty.Text)
    self.mHeroLyScroller = self:getChildGO("mHeroLyScroller"):GetComponent(ty.LyScroller)
    self.mHeroLyScroller:SetItemRender(cycle.CyclePassHeroItem)

    self.mBtnClose = self:getChildGO("mBtnClose")
end

-- 激活
function active(self, args)
    super.active(self)
    GameDispatcher:dispatchEvent(EventName.HIDE_CYCLE_TOP_PANEL)
    self.base_childGos["mGroupTop"]:SetActive(false)

    self:showView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickHandler)
end

function onClickHandler(self)
    self:close()

    GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_SETT_PANEL)
end

function showView(self)
    local serverTime = GameManager:getClientTime()

    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_MAP_PANEL)
    
    self.mTxtDes.text = _TT(77614, os.date("%Y-%m-%d %H:%M:%S",serverTime)) 

    local collList = cycle.CycleManager:getLayerCollageList()
    self.mTxtCollCount.text = #collList

    self.mBuffLyScroller.DataProvider = collList

    local heroList = cycle.CycleManager:getHeroList()
    self.mTxtHeroCount.text = #heroList
    self.mHeroLyScroller.DataProvider = heroList
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27560):	"招募战员"
	语言包: _TT(27559):	"收藏品"
	语言包: _TT(27558):	"结语"
]]

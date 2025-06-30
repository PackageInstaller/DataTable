--[[ 
-----------------------------------------------------
@filename       : MainExploreGoodsPanel
@Description    : 主线探索物资面板
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreGoodsPanel", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("mainExplore/MainExploreGoodsPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 1

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
end

--析构
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mBtnClose = self:getChildGO("BtnClose")
    self.mScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(mainExplore.MainExploreGoodsItem)
    
    self.mGoEmptyTip = self:getChildGO("mImgNo")
    self.mTextEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
end

function active(self, args)
    super.active(self, args)
    self.mMapId = args.mapId
    self:updateView()
end

function deActive(self)
    super.deActive(self)
end

function initViewText(self)
    self.mTextEmptyTip.text = _TT(63028)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)
end

function updateView(self)
    local list = mainExplore.MainExploreManager:getGoodsList(self.mMapId)
    if self.mScroller.Count <= 0 then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end

    self.mGoEmptyTip:SetActive(#list <= 0)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(63028):	"- 当前暂无资源 -"
]]

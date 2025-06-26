module("maze.MazeGoodsPanel", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("maze/MazeGoodsPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0

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
    self.mScroller = self:getChildGO("mScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(maze.MazeGoodsItem)

    self.mTextEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self.mImgNo = self:getChildGO("mImgNo")
end

function active(self, args)
    super.active(self, args)
    self.mMazeId = args.mazeId
    self:updateView()
end

function deActive(self)
    super.deActive(self)
end

function initViewText(self)
    self.mTextEmptyTip.text = _TT(46803) --"- 当前暂无物资 -"
end

function addAllUIEvent(self)
end

function updateView(self)
    local list = maze.MazeManager:getGoodsList(self.mMazeId)
    if self.mScroller.Count <= 0 then
        self.mScroller.DataProvider = list
    else
        self.mScroller:ReplaceAllDataProvider(list)
    end
    self.mImgNo:SetActive(#list <= 0)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

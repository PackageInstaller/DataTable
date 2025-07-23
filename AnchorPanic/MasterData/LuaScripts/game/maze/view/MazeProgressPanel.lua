module("maze.MazeProgressPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("maze/MazeProgressPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mShowItemList = {}
end

function configUI(self)
    self.mTextRemain = self:getChildGO("TextRemain"):GetComponent(ty.Text)
    self.mTextTitle = self:getChildGO("TextTitle"):GetComponent(ty.Text)
    self.mGroupShow = self:getChildTrans("GroupShow")
end

function active(self, args)
    super.active(self, args)

    self.mMazeId = args.mazeId
    self:__updateView()
end

function deActive(self)
    super.deActive(self)
    self:__removeItem()
end

function initViewText(self)
    self.mTextTitle.text = "查看奖励"
end

function addAllUIEvent(self)
end

function __updateView(self)
    local mazeVo = maze.MazeManager:getMazeVo(self.mMazeId)
    
    local item = SimpleInsItem:create(self:getChildGO("ShowItem"), self.mGroupShow, "MazeProgressPanelShowItem")
    -- item:getChildGO("ImgIcon"):GetComponent(ty.AutoRefImage):SetImg("", true)
    item:getChildGO("TextShowContent"):GetComponent(ty.Text).text = "剩余华丽宝箱数量："
    item:getChildGO("TextRemainCount"):GetComponent(ty.Text).text = mazeVo.remainGorgeousBoxNum
    table.insert(self.mShowItemList, item)
    
    item = SimpleInsItem:create(self:getChildGO("ShowItem"), self.mGroupShow, "MazeProgressPanelShowItem")
    -- item:getChildGO("ImgIcon"):GetComponent(ty.AutoRefImage):SetImg("", true)
    item:getChildGO("TextShowContent"):GetComponent(ty.Text).text = "剩余普通宝箱数量："
    item:getChildGO("TextRemainCount"):GetComponent(ty.Text).text = mazeVo.remainNormalBoxNum
    table.insert(self.mShowItemList, item)
    
    item = SimpleInsItem:create(self:getChildGO("ShowItem"), self.mGroupShow, "MazeProgressPanelShowItem")
    -- item:getChildGO("ImgIcon"):GetComponent(ty.AutoRefImage):SetImg("", true)
    item:getChildGO("TextShowContent"):GetComponent(ty.Text).text = "剩余通关宝箱数量："
    item:getChildGO("TextRemainCount"):GetComponent(ty.Text).text = mazeVo:getReaminPassBoxNum()
    table.insert(self.mShowItemList, item)
end

function __removeItem(self)
    if (self.mShowItemList) then
        for i = #self.mShowItemList, 1, -1 do
            local item = self.mShowItemList[i]
            item:poolRecover()
        end
    end
    self.mShowItemList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

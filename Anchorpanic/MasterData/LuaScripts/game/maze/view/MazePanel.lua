--[[ 
    迷宫
]]
module("maze.MazePanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("maze/MazePanel.prefab")

destroyTime = -1 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(52088))
    self:setBg("maze_bg_1.jpg", false, "maze")
end

-- 关闭所有UI
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:__playerClose()
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    self:__playerClose()
end

function __playerClose(self)
end

function open(self, args)
    super.open(self, args)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mImgDecorate = self:getChildTrans("ImgDecorate")
    self.mBtnRank = self:getChildGO("BtnRank")
    self.m_scroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
	self.m_scroller:SetItemRender(maze.MazeItem)
end

function initViewText(self)
    self:setBtnLabel(self.mBtnRank, 46821, "排行榜")
end

function addAllUIEvent(self)
    self:addOnClick(self.mBtnRank, self.__onClickRankHandler)
end

-- 激活
function active(self, args)
    MoneyManager:setMoneyTidList()
    GameDispatcher:addEventListener(EventName.UPDATE_MAZE_PANEL_DATA, self.__onUpdateMazeDataHandler, self)
    self:__updateView()
end

-- 非激活
function deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.UPDATE_MAZE_PANEL_DATA, self.__onUpdateMazeDataHandler, self)
    if(self.mFrameSn)then
        LoopManager:removeFrameByIndex(self.mFrameSn)
        self.mFrameSn = nil
    end
    if self.m_scroller then
        self.m_scroller:CleanAllItem()
    end
end

function __onClickRankHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_RANK_MAIN_PANEL,{type = rank.RankConst.RANK_MAZE})
    -- GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_RANK_PANEL, {mazeId = maze.MazeSceneManager:getMazeId()})
end

function __onUpdateMazeDataHandler(self)
    self:__updateView(true)
end

function __updateView(self, cusIsInit)
    if(self.mFrameSn)then
        LoopManager:removeFrameByIndex(self.mFrameSn)
    end
    self.mFrameSn = LoopManager:addFrame(3, 1, self, function()
        local configList = maze.MazeSceneManager:getMazeConfigList()
        for i = 1, #configList do 
            configList[i].tweenId = i
        end
        -- if (cusIsInit == nil or cusIsInit == true) then
            self.m_scroller.DataProvider = configList
        -- else
        --     self.m_scroller:ReplaceAllDataProvider(configList)
        -- end
    end)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

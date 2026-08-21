--[[ 
-----------------------------------------------------
@filename       : MazeAbnormalShowPanel
@Description    : 默示之境异常环境
@date           : 2021-07-07 11:18:19
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('maze.MazeAbnormalShowPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("maze/MazeAbnormalShowPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0 --是否开启适配刘海

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
    self.mScroller:SetItemRender(maze.MazeAbnormalShowItem)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)

    self.mMazeId = args.mazeId
	local mazeConfigVo = maze.MazeSceneManager:getMazeConfigVo(self.mMazeId)
    self.abnormalList = mazeConfigVo.abnormalList

    self:updateView()
    -- self:addTimer(1, 0, self.onTimer)
    -- self:onTimer()
    self.mTxtTime.text = ""
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function updateView(self)
    if self.mScroller.Count <= 0 then
        self.mScroller.DataProvider = self.abnormalList
    else
        self.mScroller:ReplaceAllDataProvider(self.abnormalList)
    end
end

function onTimer(self)
    -- local wday = tonumber(os.date("%w")) == 0 and 7 or tonumber(os.date("%w"))
    -- wday = (wday == 1 and tonumber(os.date("%H")) < 5) and 8 or wday
    -- local endTime = ((8 - wday) * 24 * 3600) - os.date("%H") * 3600 - os.date("%M") * 60 - os.date("%S") + 5 * 3600
    -- self.mTxtTime.text = _TT(42107, TimeUtil.getFormatTimeBySeconds_1(endTime))

    local currentTime = GameManager:getClientTime()
    local reamainTime = GameManager:getWeekResetTime() - currentTime
    self.mTxtTime.text = _TT(42107,TimeUtil.getFormatTimeBySeconds_1(reamainTime))
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

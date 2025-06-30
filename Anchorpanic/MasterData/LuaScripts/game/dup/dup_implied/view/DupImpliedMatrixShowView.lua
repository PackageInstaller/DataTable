--[[ 
-----------------------------------------------------
@filename       : DupImpliedMatrixShowView
@Description    : 默示之境拥有的矩阵展示
@date           : 2021-07-07 11:10:34
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_implied.view.DupImpliedMatrixShowView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupImplied/DupImpliedMatrixShowView.prefab")

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
    self.mScrollerContent = self:getChildTrans("mScrollerContent")
    self.LyScrollerItem = self:getChildGO("LyScrollerItem")

    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)

    self.stageId = args.stageId

    self.matrixList = dup.DupImpliedManager:getOwnMatrixList(self.stageId)
    self:updateView()

    self:addTimer(1, 0, self.onTimer)
    self:onTimer()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverItem()
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
    -- self:addUIEvent(self.aa,self.onClick)
end


function updateView(self)
    if not self.mItemList  then 
        self.mItemList = {}
    end

    self:recoverItem()

    for i=1,#self.matrixList do
        local item = dup.DupImpliedMatrixItem:poolGet()
        local data = dup.DupImpliedManager:getMatrixBaseData(self.matrixList[i])
        item:setData(self.mScrollerContent,data)
        table.insert(self.mItemList, item)
    end
end

function recoverItem(self)
    for i = 1, #self.mItemList do
        local item = self.mItemList[i]
        item:poolRecover()
    end
    self.mItemList = {}
end

function onTimer(self)
    -- local wday = tonumber(os.date("%w")) == 0 and 7 or tonumber(os.date("%w"))
    -- wday = (wday == 1 and tonumber(os.date("%H")) < 5) and 8 or wday
    -- local endTime = ((8 - wday) * 24 * 3600) - os.date("%H") * 3600 - os.date("%M") * 60 - os.date("%S") + 5 * 3600
    -- -- self.mTxtTime.text = "重置剩余时间：" .. TimeUtil.getFormatTimeBySeconds_1(endTime)
    -- self.mTxtTime.text = _TT(42102, TimeUtil.getFormatTimeBySeconds_1(endTime))

    
    local currentTime = GameManager:getClientTime()
    local reamainTime = GameManager:getWeekResetTime() - currentTime
    self.mTxtTime.text = _TT(42102,TimeUtil.getFormatTimeBySeconds_1(reamainTime)) .. _TT(42101)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

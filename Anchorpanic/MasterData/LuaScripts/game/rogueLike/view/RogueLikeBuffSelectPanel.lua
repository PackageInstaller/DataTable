--[[ 
-----------------------------------------------------
@filename       : RogueLikeBuffSelectPanel
@Description    : 肉鸽结算选buff
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("rogueLike.RogueLikeBuffSelectPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeBuffSelectPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mBuffItemList = {}
    self.mSelectItem = nil
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnForgo = self:getChildGO("mBtnForgo")
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mGroup = self:getChildTrans("mGroup")
    self.mBtnGet = self:getChildGO("mBtnGet")
end

-- 激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_ROGUELIKE_BUFF_SELECT, self.onUpdateBuff, self)
    GameDispatcher:addEventListener(EventName.SET_ROGUELIKE_BUFF_ARGS, self.onSetArgs, self)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ROGUELIKE_BUFF_SELECT, self.onUpdateBuff, self)
    GameDispatcher:removeEventListener(EventName.SET_ROGUELIKE_BUFF_ARGS, self.onSetArgs, self)
    self:recoverList()
end

function initViewText(self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnForgo, self.onForgoClick)
    self:addUIEvent(self.mBtnGet, self.onBtnGetClick)
end

function onUpdateBuff(self, cellData)
    self.cellId = cellData.cell_id
    self.eventId = cellData.event_id
    self.args = cellData.args
    self:updateView()
end

function onSetArgs(self, args)
    self.cellId = args.cellId
    self.eventId = args.eventId
    self.args = args.args
    self:updateView()
end

function onForgoClick(self)
    GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SELECT_MAP_BUFF, {cellId = self.cellId, buffId = 0})
end

function onBtnGetClick(self)
    if self.showItem and self.showItem.mBuffId > 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SELECT_MAP_BUFF, {cellId = self.cellId, buffId = self.showItem.mBuffId})
    else
        -- gs.Message.Show("请至少选择一个buff")
        gs.Message.Show(_TT(46829))
    end
end

function updateView(self)
    self:updateGoodsList()
end

-- 更新物资
function updateGoodsList(self)
    self:recoverList()

    for id, data in pairs(self.args) do
        local item = rogueLike.RogueLikeBuffItemResuse:poolGet()
        item:addEventListener(item.EVENT_CHANGE, self.onItemChange, self)
        item:setData(self.mGroup, self.cellId, data.key,nil,nil,data.value)
        table.insert(self.mBuffItemList, item)
    end
end

-- 回收项
function recoverList(self)
    if self.mBuffItemList then
        for i, v in pairs(self.mBuffItemList) do
            v:removeEventListener(v.EVENT_CHANGE, self.onItemChange, self)
            v:poolRecover()
        end
    end
    self.mBuffItemList = {}
end

function onItemChange(self, args)
    if self.showItem then
        -- 回收之前打开的
        self.showItem:setSelect(false)
        self.showItem = nil
    end
    self.showItem = args.item
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

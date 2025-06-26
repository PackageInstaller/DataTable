--[[ 
-----------------------------------------------------
@filename       : RogueLikeEventSelectPanel
@Description    : 事件选择界面
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] 
module("rogueLike.RogueLikeEventSelectPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeEventSelectPanel.prefab")

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
    self.mEventItemList = {}
    self.mSelectItem = nil
end

-- 初始化
function configUI(self)
    super.configUI(self)

    --gs.ColorUtil.GetColor(color)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mScrollView = self:getChildGO("mScrollView"):GetComponent(ty.ScrollRect)
    self.mBtnGet = self:getChildGO("mBtnGet")
end

-- 激活
function active(self, args)
    super.active(self, args)

    self.cellId = args.id
    self.eventId = args.eventId
    self.args = args.args

    self:updateView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverList()
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGet,self.onBtnGet)
end

function onBtnGet(self)
    if self.mSelectItem and self.mSelectItem.eventId > 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SELECT_EVENT, {cellId = self.cellId, eventId = self.mSelectItem.eventId})
    else
        gs.Message.Show("请至少选择一个事件")
    end
end

function initViewText(self)
end

function updateView(self)
    self:updateGoodsList()

    self.eventVo = rogueLike.RogueLikeManager:getRogueLikeEventData(self.eventId)
    self.mTxtName.text = _TT(self.eventVo.eventTitle)
    self.mTxtDes.text = _TT(self.eventVo.eventDes)
end

-- 更新物资
function updateGoodsList(self)
    self:recoverList()

    for id, data in pairs(self.args) do
        local item = rogueLike.RogueLikeEventSelectItem:poolGet()
        item:addEventListener(item.EVENT_CHANGE, self.onItemChange, self)
        item:setData(self.mScrollView.content, self.cellId, data)
        table.insert(self.mEventItemList, item)
    end
end

-- 回收项
function recoverList(self)
    if self.mEventItemList then
        for i, v in pairs(self.mEventItemList) do
            v:removeEventListener(v.EVENT_CHANGE, self.onItemChange, self)
            v:poolRecover()
        end
    end
    self.mEventItemList = {}
end

function onItemChange(self, args)
    if self.mSelectItem then
        -- 回收之前打开的
        self.mSelectItem:setSelect(false)
        self.mSelectItem = nil
    end
    self.mSelectItem = args.item
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

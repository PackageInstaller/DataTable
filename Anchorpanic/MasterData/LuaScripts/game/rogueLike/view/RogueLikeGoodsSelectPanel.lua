--[[ 
-----------------------------------------------------
@filename       : RogueLikeGoodsSelectPanel
@Description    : 肉鸽结算选buff
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] 
module("rogueLike.RogueLikeGoodsSelectPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeGoodsSelectPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
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

    self:initViewText()
    self:addAllUIEvent()
end

-- 激活
function active(self, args)
    super.active(self, args)

    -- rogueLike.RogueLikeManager:setLastArgs(self.args)
    local id, buff = rogueLike.RogueLikeManager:getMapIdAndBuff()
    self.cellId = id
    self.buffList = buff

    if #self.buffList == 0 then
        self:onClickClose()
        return
    end

    self:updateView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverList()
end

function initViewText(self)
    self:setBtnLabel(self.mBtnForgo, -1, "放弃选择")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnForgo, self.onForgo)
    self:addUIEvent(self.mBtnGet,self.onBtnGet)
end

function onForgo(self)
    GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SELECT_BUFF, {buffId = 0})
end

function onBtnGet(self)
    if self.showItem and self.showItem.mBuffId > 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SELECT_BUFF, {buffId = self.showItem.mBuffId})
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
    for i = 1, #self.buffList do
        local item = rogueLike.RogueLikeBuffItemResuse:poolGet()
        item:addEventListener(item.EVENT_CHANGE, self.onItemChange, self)
        item:setData(self.mGroup, self.cellId, self.buffList[i].buff_id,nil,nil,self.buffList[i].improve_efficiency)
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

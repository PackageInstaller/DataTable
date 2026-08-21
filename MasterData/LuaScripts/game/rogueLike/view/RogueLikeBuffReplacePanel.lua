--[[ 
-----------------------------------------------------
@filename       : RogueLikeBuffReplacePanel
@Description    : 肉鸽buff替换界面
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] 
module("rogueLike.RogueLikeBuffReplacePanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeBuffReplacePanel.prefab")

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
    self.mSelectItem = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mScrollView = self:getChildGO("mScrollView"):GetComponent(ty.ScrollRect)
    self.mBtnLevelUp = self:getChildGO("mBtnLevelUp")
    self.mTxtLevelUpCoin = self:getChildGO("mTxtLevelUpCoin"):GetComponent(ty.Text)
    self.mSellBtn = self:getChildGO("mBtnSell")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtSell = self:getChildGO("mTxtSell"):GetComponent(ty.Text)
end

-- 激活
function active(self, args)
    super.active(self, args)

    GameDispatcher:addEventListener(EventName.UPDATE_ROGUELIKE_REPLACE_PANEL, self.onUpdateRelpacePanel, self)
    self:updateView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ROGUELIKE_REPLACE_PANEL, self.onUpdateRelpacePanel, self)
    self:recoverList()
end

function onUpdateRelpacePanel(self)
    self:updateView()
end

function initViewText(self)
    self.mTxtTitle.text = "出售buff"
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLevelUp, self.onLevelUpClick)
    self:addUIEvent(self.mSellBtn, self.onSellBtnClick)
end

-- 升级BUFF上限
function onLevelUpClick(self)
    local levelMax = rogueLike.RogueLikeManager:getIsExpandMax()
    local levelUpCoin = rogueLike.RogueLikeManager:getExpandBuffCoin()

    if levelMax == 0 then
        if MoneyUtil.judgeNeedMoneyCountByTid(MoneyTid.FUNCTION_TID, levelUpCoin) then
            GameDispatcher:dispatchEvent(EventName.REQ_LEVEL_UP_BUFF_LIMIT)
        end
    else
        gs.Message.Show("已经满级了")
    end
end

-- 出售BUFF
function onSellBtnClick(self)
    local sellList = {}

    if #self.buffList - self.maxLength - table.nums(self.mSelectItem) == 0 then
        for id, data in pairs(self.mSelectItem) do
            table.insert(sellList, data)
        end
        GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SHOP_SELL, {cellId = 0, list = sellList})
    else
        gs.Message.Show("请选择正确数量的BUFF出售")
    end

end

function updateView(self)
    self:recoverList()
    self.maxLength = rogueLike.RogueLikeManager:getBuffLimit()

    self.buffList = rogueLike.RogueLikeManager:getBuffList()
    for i = 1, #self.buffList do
        local item = rogueLike.RogueLikeBuffReplaceItem:poolGet()
        item:addEventListener(item.EVENT_CHANGE, self.onItemChange, self)
        item:setData(self.mScrollView.content, i, self.buffList[i])
        table.insert(self.mBuffItemList, item)
    end
    self.mTxtSell.text = "需要出售" .. (#self.buffList - self.maxLength) .. "个buff"

    -- 可能由于升级变成不需要出售buff了
    if (#self.buffList - self.maxLength == 0) then
        self:onClickClose()
        return
    end

    local levelMax = rogueLike.RogueLikeManager:getIsExpandMax()
    if levelMax == 0 then
        local levelUpCoin = rogueLike.RogueLikeManager:getExpandBuffCoin()
        self.mTxtLevelUpCoin.text = levelUpCoin
    else
        self.mTxtLevelUpCoin.text = "已经满级"
    end
end

function recoverList(self)
    for i = 1, #self.mBuffItemList do
        self.mBuffItemList[i]:removeEventListener(self.mBuffItemList[i].EVENT_CHANGE, self.onItemChange, self)
        self.mBuffItemList[i]:poolRecover()
    end
    self.mBuffItemList = {}
end

function onItemChange(self, args)
    if args.isSelect == true then
        self.mSelectItem[args.index] = args.showId
    else
        self.mSelectItem[args.index] = nil
    end
    -- self.mTxtSell.text = "需要出售"..#self.buffList - self.maxLength.."个buff"
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

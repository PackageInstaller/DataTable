--[[ 
-----------------------------------------------------
@filename       : MainExploreGoodsSelectPanel
@Description    : 副本结算选buff
@date           : 2021-08-11 11:10:57
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('mainExplore.MainExploreGoodsSelectPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("mainExplore/MainExploreGoodsSelectPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
end

--析构  
function dtor(self)
end

function initData(self)
    self.mBuffItemList = {}
    self.mSelectItem = nil
end

-- 初始化
function configUI(self)
    self.mBtnForgo = self:getChildGO("mBtnForgo")
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mGroup = self:getChildTrans("mGroup")
    self.mBtnGet = self:getChildGO("mBtnGet")
end

--激活
function active(self, args)
    super.active(self, args)

    self.mBuffList = args.buffIdList
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverList()
end

function initViewText(self)
    self:setBtnLabel(self.mBtnForgo, -1, "放弃选择")
    self:setBtnLabel(self.mBtnGet, 63026, "确 认 选 择")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnForgo, self.onForgo)
    self:addUIEvent(self.mBtnGet, self.onClickConfirmHandler)
end

function onForgo(self)
    GameDispatcher:dispatchEvent(EventName.REQ_MAIN_EXPLORE_SELECT_BUFF, { buffId = 0 })
    self:onClickClose()
end

function onClickConfirmHandler(self)
    if self.mSelectItem and self.mSelectItem.buffId > 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_MAIN_EXPLORE_SELECT_BUFF, { buffId = self.mSelectItem.buffId })
        return self:close()
    else
        gs.Message.Show("请至少选择一个")
    end
end

function updateView(self)
    self:updateGoodsList()
end

-- 更新物资
function updateGoodsList(self)
    self:recoverList()
    for i = 1, #self.mBuffList do
        local item = mainExplore.MainExploreGoodsSelectItem:poolGet()
        item:addEventListener(item.EVENT_CHANGE, self.onItemChange, self)
        item:setData(self.mGroup, mainExplore.MainExploreSceneManager:getGoodsConfigVo(self.mBuffList[i]))
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
    local nowItem = args.item
    if(self.mSelectItem ~= nowItem)then
        if(self.mSelectItem)then
            self.mSelectItem:setSelect(false)
        end
        nowItem:setSelect(true)
        self.mSelectItem = nowItem
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

--[[ 
-----------------------------------------------------
@filename       : MainExploreGoodsInfoPanel
@Description    : 探索·buff信息面板
@date           : 2021年5月11日 15:59:35
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('mainExplore.MainExploreGoodsInfoPanel', Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("mainExplore/MainExploreGoodsInfoPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
end

-- 初始化数据
function initData(self)
    self.mBuffItemList = {}
    self.mSelectItem = nil
end

--初始化UI
function configUI(self)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mGroup = self:getChildTrans("mGroup")
    self.mBtnGet = self:getChildGO("mBtnGet")
end

--激活
function active(self, args)
    super.active(self, args)

    self.mMapId = args.mapId
    self.mEventVo = args.eventVo
    self.mCallFun = args.callFun
    self:__updateView()
end

--非激活
function deActive(self)
    super.deActive(self)
    self:recoverList()
end

function initViewText(self)
    self.mTxtDes.text = _TT(63027)
    self:setBtnLabel(self.mBtnGet, 63026, "确 认 选 择")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGet, self.onClickConfirmHandler)
end

-- 关闭所有UI
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:playerClose()
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    self:playerClose()
end

function playerClose(self)
    if(self.mCallFun)then
        self.mCallFun(false, nil)
    end
end

function onClickConfirmHandler(self)
    if self.mSelectItem and self.mSelectItem.buffId > 0 then
        if(self.mCallFun)then
            self.mCallFun(true, {self.mSelectItem.buffId})
        end
        return self:close()
    else
        gs.Message.Show("请至少选择一个")
    end
end

function __updateView(self)
    self:updateGoodsList()
end

-- 更新物资
function updateGoodsList(self)
    self:recoverList()
    local buffIdList = self.mEventVo:getEffecctList()
    for i = 1, #buffIdList do
        local item = mainExplore.MainExploreGoodsInfoItem:poolGet()
        item:addEventListener(item.EVENT_CHANGE, self.onItemChange, self)
        item:setData(self.mGroup, buffIdList[i])
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
	语言包: _TT(63027):	"- 选择一个物资 -"
]]

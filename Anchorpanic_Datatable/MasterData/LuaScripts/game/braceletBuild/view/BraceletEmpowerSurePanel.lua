-- @FileName:   BraceletEmpowerSurePanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-09-19 15:44:51
-- @Copyright:   (LY) 2023 雷焰网络

module('braceletBuild.BraceletEmpowerSurePanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('braceletBuild/BraceletEmpowerSurePanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isShowMoneyBar = 1 -- 是否显示货币栏 1开启（仅2弹窗有效）

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(831, 330)
end

-- 初始化数据
function initData(self)

end

function initViewText(self)
    self.mTextTips.text = _TT(93106)
end

-- 初始化
function configUI(self)
    self.mTextDesc = self:getChildGO("mTextDesc"):GetComponent(ty.Text)
    self.mTextTips = self:getChildGO("mTextTips"):GetComponent(ty.Text)
    self.propsContent = self:getChildTrans("propsContent")
    self.mBtn_Sure = self:getChildGO("mBtn_Sure")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtn_Sure, self.onClick)
end

-- 激活
function active(self, args)
    super.active(self, args)

    MoneyManager:setMoneyTidList({MoneyTid.GOLD_COIN_TID, MoneyTid.ITEM_2061})

    self.data = args
    if self.data.type == 1 then --锁定词条
        self:setTxtTitle(_TT(5))
        self.mTextDesc.text = _TT(93105)

    elseif self.data.type == 2 then--重置词条数值
        self:setTxtTitle(_TT(93104))
        self.mTextDesc.text = _TT(93111)

    elseif self.data.type == 3 then--改变词条
        self:setTxtTitle(_TT(5))
        self.mTextDesc.text = _TT(93114)
    end

    self:clearPropsItem()
    self:createPropsItem()
end

function onClick(self)
    local propCount = nil
    for _, item in pairs(self.data.itemList) do
        if props.PropsManager:getTypePropsVoByTid(item.tid).type ~= PropsType.Money then
            propCount = bag.BagManager:getPropsCountByTid(item.tid)
        else
            propCount = MoneyUtil.getMoneyCountByTid(item.tid)
        end

        if propCount < item.num then
            gs.Message.Show(_TT(156))
            return
        end
    end

    if self.data.type == 1 then --锁定词条
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_BRA_LOCK_ATTR, {equipId = self.data.equipId, pos = self.data.pos, is_lock = true})
    elseif self.data.type == 2 then--重置词条数值
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_BRA_EMPOWER, {equipId = self.data.equipId, type = 2})
    elseif self.data.type == 3 then--改变词条
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_BRA_EMPOWER, {equipId = self.data.equipId, type = 1})
    end
end

function createPropsItem(self)
    local propCount = nil
    self.mPropsGridList = {}
    local awardList = self.data.itemList
    for i = 1, #awardList do
        local propsGrid = PropsGrid:createByData({tid = awardList[i].tid, num = awardList[i].num, parent = self.propsContent})
        table.insert(self.mPropsGridList, propsGrid)

        if props.PropsManager:getTypePropsVoByTid(awardList[i].tid).type ~= PropsType.Money then
            propCount = bag.BagManager:getPropsCountByTid(awardList[i].tid)
        else
            propCount = MoneyUtil.getMoneyCountByTid(awardList[i].tid)
        end
        local colorStr = propCount >= awardList[i].num and "FFFFFFFF" or "ed1941FF"
        propsGrid:setCountTextColor(colorStr)
        propsGrid:setIsShowCount(true)
        propsGrid:showCount()
    end
end

function clearPropsItem(self)
    if self.mPropsGridList ~= nil then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
        self.mPropsGridList = {}
    end
end

-- 非激活
function deActive(self)
    super.deActive(self)
    self:clearPropsItem()
end

return _M

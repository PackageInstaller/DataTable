-- @FileName:   EquipEmpowerLockSurePanel.lua
-- @Description:   模组锁定确认界面
-- @Copyright:   (LY) 2023 雷焰网络
module('equipBuild.EquipEmpowerLockSurePanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('equipBuild/EquipEmpowerSurePanel.prefab')

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
    self.datas = args
    MoneyManager:setMoneyTidList({MoneyTid.GOLD_COIN_TID, MoneyTid.EQUIP_LOCK_TID, MoneyTid.EQUIP_EMPOWER_TID})

    self:clearPropsItem()
    self:createPropsItem()
end

function onClick(self)
    local hasCount = true
    for i = 1, #self.costList, 1 do
        local result, tips = MoneyUtil.judgeNeedMoneyCountByTid(self.costList[i].tid, self.costList[i].num, true, true)
        if tips == "" and result == true then

        else
            hasCount = false
            gs.Message.Show(tips)
            return
        end
    end

    if hasCount == false then
        return
    end

    if self.datas.type == 1 then -- 锁定词条
        GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_EMPOWER_LOCK, {
            equipId = self.datas.equipId,
            pos = self.datas.pos,
            isLock = self.datas.isLock
        })
    else
        GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_EMPOWER_PREPARE, {
            equipId = self.datas.equipId
        })
    end
    self:close()
    -- if self.data.type == 1 then --锁定词条
    --     GameDispatcher:dispatchEvent(EventName.REQ_HERO_BRA_LOCK_ATTR, {equipId = self.data.equipId, pos = self.data.pos, is_lock = true})
    -- elseif self.data.type == 2 then--重置词条数值
    --     GameDispatcher:dispatchEvent(EventName.REQ_HERO_BRA_EMPOWER, {equipId = self.data.equipId, type = 2})
    -- elseif self.data.type == 3 then--改变词条
    --     GameDispatcher:dispatchEvent(EventName.REQ_HERO_BRA_EMPOWER, {equipId = self.data.equipId, type = 1})
    -- end
end

function createPropsItem(self)
    -- local sub = GameView.UINode["SUB_POP"]
    -- sub.gameObject:GetComponent(ty.Canvas).additionalShaderChannels = 3 --bit.bor(1,2)
    self:setTxtTitle(_TT(5))
    self.selectEquipVo = equipBuild.EquipStrengthenManager:getOpenEquipVo()
    local costList = {}
    self.infoId = 0
    if self.datas.type == 1 then
        local attackList = self.selectEquipVo:getTuPoAttachAttr()
        local lockCount = 1
        for i = 1, #attackList, 1 do
            if attackList[i].isLock then
                lockCount = lockCount + 1
            end
        end
        self.infoId = lockCount
    elseif self.datas.type == 2 then
        local attackList = self.selectEquipVo:getTuPoAttachAttr()
        local lockCount = 0
        for i = 1, #attackList, 1 do
            if attackList[i].isLock then
                lockCount = lockCount + 1
            end
        end
        self.infoId = lockCount + 3
    end
    if self.datas.type == 1 then
           self.mTextDesc.text = _TT(71479)
    elseif self.datas.type == 2 then
        self.mTextDesc.text = _TT(71480)
    end
    self.costList = equipBuild.EquipEmpowerManager:getEmpowerCostInfo(self.infoId):getCost()
    local propCount = nil
    self.mPropsGridList = {}
    local awardList = self.costList
    for i = 1, #awardList do
        local propsGrid = PropsGrid:createByData({
            tid = awardList[i].tid,
            num = awardList[i].num,
            parent = self.propsContent
        })
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

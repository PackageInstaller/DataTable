-- @FileName:   roundPrizeTwoRulePanel.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-12-20 17:42:57
-- @Copyright:   (LY) 2024 锚点降临

module("game.roundPrizeTwo.RoundPrizeRuleTwoPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("roundPrizeTwo/RoundPrizeRuleTwoPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 519)
    self:setTxtTitle(_TT(121201))
end

function initData(self)

end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mItemGrid = self:getChildTrans("mItemGrid")
    self.mItem = self:getChildGO("mItem")
end

function initViewText(self)
    self.mTxtTitle.text = _TT(121208)
end

-- 激活
function active(self, args)
    super.active(self, args)
    local configVo = roundPrizeTwo.RoundPrizeTwoManager:getProbabilityConfigVo()
    if configVo then
        self.mTxtTips.text = _TT(configVo.rule)

        local probabilityList = {}
        for index, desc in pairs(configVo.probabilityList) do
            table.insert(probabilityList, desc)
        end

        table.sort(probabilityList, function (a, b)
            if a.probability ~= b.probability then
                return a.probability < b.probability
            else
                return a.tid < b.tid
            end
        end)

        self:clearItem()
        for i = 1, #probabilityList do
            local item = SimpleInsItem:create(self.mItem, self.mItemGrid, "RoundPrizeRuleTwoPanel_item")
            table.insert(self.m_itemList, item)

            local PropGrid = PropsGrid:createByData({tid = probabilityList[i].tid, num = probabilityList[i].count, parent = item:getTrans(), scale = 0.8, showUseInTip = true})
            table.insert(self.m_propsList, PropGrid)

            item:getChildGO("mTextProbability"):GetComponent(ty.Text).text = string.format("%s%%", probabilityList[i].probability * 100)
        end
    end
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:clearItem()
end

function clearItem(self)
    if self.m_itemList then
        for k, v in pairs(self.m_itemList) do
            v:poolRecover()
        end
    end

    self.m_itemList = {}

    if self.m_propsList then
        for k, v in pairs(self.m_propsList) do
            v:poolRecover()
        end
    end

    self.m_propsList = {}
end

return _M

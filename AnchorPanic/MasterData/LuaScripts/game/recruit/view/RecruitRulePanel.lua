--[[
     英雄招募规则界面
]]
module('recruit.RecruitRulePanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('recruit/RecruitRulePanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 519)
    self:setTxtTitle(_TT(28032))
end

-- 初始化数据
function initData(self)
    self.m_itemList = {}
    self.m_recruitId = nil
end

-- 初始化
function configUI(self)
    self.mTxtTips = self:getChildGO('mTxtTips'):GetComponent(ty.Text)
    self.mContent = self:getChildTrans('Content')
    self.mContentRect = self:getChildGO('Content'):GetComponent(ty.RectTransform)
end

-- 激活
function active(self, args)
    super.active(self, args)

    recruit.RecruitManager:SetOpenRulePanel(true)

    self.m_recruitId = args.recruitId

    local ruleConfigVo = recruit.RecruitManager:getRecruitRuleConfigVo(self.m_recruitId)
    self.ruleList = ruleConfigVo:getRuleData()
    self.m_createIndex = 0
    self.mTxtTips.text = _TT(ruleConfigVo.rule)

    self:recyAllItem()
    self:createItem()
end

-- 非激活
function deActive(self)
    super.deActive(self)

    self:recyAllItem()
end

function initViewText(self)
    -- if self.m_recruitId  == recruit.RecruitType.RECRUIT_BRACELETS then
    --     self.mTxtTips.text = _TT(28029) --"*SSR战员招募的基础概率为0.500%，综合概率（含保底）为2.100%，最多60次招募必定能通过保底获取SSR战员。"
    -- else
    --     self.mTxtTips.text = _TT(28028) --"*SSR战员招募的基础概率为0.500%，综合概率（含保底）为2.100%，最多60次招募必定能通过保底获取SSR战员。"
    -- end
end

function addAllUIEvent(self)
end

function recyAllItem(self)
    if self.m_itemList then
        for i, v in pairs(self.m_itemList) do
            v:poolRecover()
        end
    end
    self.m_itemList = {}
    gs.TransQuick:UIPos(self.mContentRect, 0, 0)
end

function createItem(self)
    self.m_createIndex = self.m_createIndex + 1
    if self.m_createIndex > #self.ruleList then return end

    local recruitType = recruit.RecruitManager:getRecruitTypeById(self.m_recruitId)

    local item = recruit.RecruitRuleItem:poolGet()
    item:setData(self.mContent, self.ruleList, self.m_createIndex, recruitType, function ()
        self:createItem()
    end)
    table.insert(self.m_itemList, item)
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)

    recruit.RecruitManager:SetOpenRulePanel(false)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]

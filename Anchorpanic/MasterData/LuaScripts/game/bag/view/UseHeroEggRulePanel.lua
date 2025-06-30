-- @FileName:   UseHeroEggRulePanel.lua
-- @Description:   概率页面
-- @Copyright:   (LY) 2024 锚点降临

module("game.bag.view.UseHeroEggRulePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("bag/UseHeroEggRulePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 519)
    self:setTxtTitle(_TT(149924))
end

function initData(self)

end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    --self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    --self.mItemGrid = self:getChildTrans("mItemGrid")

    self.mItemScroll = self:getChildGO("mItemScroll"):GetComponent(ty.ScrollRect)
    self.mItem = self:getChildGO("mItem")
end

function initViewText(self)
    --self.mTxtTitle.text = _TT(121208)
end

-- 激活
function active(self, args)
    super.active(self, args)

    self:clearItem()
    local configVo = props.PropsManager:getItemRuleDataByTid(args.tid)
    local listRule = {}
    for _, v in pairs(configVo.ruleDic) do
        table.insert(listRule, v)
    end
    table.sort(listRule, function (a, b)
        return a.color > b.color
    end)
    for i, v in ipairs(listRule) do
        local item = bag.HeroEggRuleItem:poolGet()

        item:setData(self.mItemScroll.content, v.itemList, v.pr,v.color)

        self.mRecruititemList[i] = item
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

    if self.mRecruititemList then
        for k, v in pairs(self.mRecruititemList) do
            v:poolRecover()
        end

    end
    self.mRecruititemList={}
end


return _M

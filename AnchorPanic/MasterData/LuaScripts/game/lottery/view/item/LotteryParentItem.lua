module("lottery.LotteryParentItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    --self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mItemContent = self:getChildTrans("mItemContent")
    self.mItem = self:getChildGO("mItem")
end

function setData(self, data)
    super.setData(self, data)
    self.data = data
    self:showPanel()
end

function onDelete(self)
    super.onDelete(self)
    self:clearItem()
end

function showPanel(self)

    self:clearItem()
    -- if self.data.rule == 0 then
    --     self.mTxtTips.text = _TT(self.data.rule)
    -- else
    --     self.mTxtTips.text = ""
    -- end
    self.mTxtTitle.text = _TT(138110, self.data.id)

    local configVo = lottery.LotteryManager:getLotteryDataByRound(self.data.id)
    local probabilityList = {}
    for index, desc in pairs(configVo.des) do
        desc.index = index
        table.insert(probabilityList, desc)
    end


    table.sort(probabilityList, function(a, b)
        -- if a.pr ~= b.pr then
        --     return a.pr < b.pr
        -- else
            return a.index < b.index
        --end
    end)
    for i = 1, #probabilityList do
        local probItem = SimpleInsItem:create(self.mItem, self.mItemContent, "LotteryRulePanel_item")
        table.insert(self.m_itemList, probItem)

        local PropGrid = PropsGrid:createByData({
            tid = probabilityList[i].item_id,
            num = probabilityList[i].num,
            parent = probItem:getChildTrans("mPropsContent"),
            scale = 0.8,
            showUseInTip = true
        })
        table.insert(self.m_propsList, PropGrid)
        probItem:getChildGO("mTxtMain"):SetActive(i == 1)
        probItem:getChildGO("mMainFx"):SetActive(i == 1)
        probItem:getChildGO("mTxtMain"):GetComponent(ty.Text).text = _TT(138112)

        probItem:getChildGO("mTextProbability"):GetComponent(ty.Text).text = string.format("%s%%",
            probabilityList[i].pr / 10)
    end
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

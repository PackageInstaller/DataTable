module("doundless.DoundlessPromoteItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mContent = self:getChildTrans("mContent")
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mPropsGridList = {}
end

function setData(self, param)
    super.setData(self, param)
    self:recoverAllGrid()

    local list = {}
    list = AwardPackManager:getAwardListById(param.award)

    if #list > 0 then
        for i, vo in ipairs(list) do
            local propsGrid = PropsGrid:createByData({
                tid = vo.tid,
                num = vo.num,
                parent = self.mContent,
                scale = 1.4,
                showUseInTip = true
            })
            table.insert(self.mPropsGridList, propsGrid)
        end
    end
    self.mTxtTips.text = param.name
end

function recoverAllGrid(self)
    if #self.mPropsGridList > 0 then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
        self.mPropsGridList = {}
    end
end

function deActive(self)
    super.deActive(self)
    self:recoverAllGrid()
end

function onDelete(self)
    super.onDelete(self)
end

return _M

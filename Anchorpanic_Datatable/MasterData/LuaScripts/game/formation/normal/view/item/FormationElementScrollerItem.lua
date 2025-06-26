module("formation.FormationElementScrollerItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
end

function setData(self, data)
    super.setData(self, data)

    self.mElementItem = self:getChildGO("mElementItem")
    self.mTxtStandardNum = self:getChildGO("mTxtStandardNum"):GetComponent(ty.Text)
    self.mConNotStandard = self:getChildGO("mConNotStandard")

    self.mGroupElement = self:getChildTrans("mGroupElement")
    self.mTxtElementDesc = self:getChildGO("mTxtElementDesc"):GetComponent(ty.Text)

    self.items = {}

    for i = 1, data.needNum do
        local item = SimpleInsItem:create(self.mElementItem, self.mGroupElement, "FormationElementScrollerItemmElementItem")
        local autoImg = item:getChildGO("mImgElementIcon"):GetComponent(ty.AutoRefImage)
        autoImg:SetImg(UrlManager:getHeroEleTypeIconUrl(data.type), false)
        autoImg:SetGray(true)
        table.insert(self.items, item)
    end

    local hasNum = data.hasNum
    self:updateEleTypeState(hasNum)
    if hasNum > 0 and data.needNum <= hasNum then
        self.mTxtElementDesc.color = gs.ColorUtil.GetColor("FFFFFFff")
    else
        self.mTxtElementDesc.color = gs.ColorUtil.GetColor("82898cff")
    end
    local skillVo = fight.SkillManager:getSkillRo(data.skillId)
    self.mTxtElementDesc.text = skillVo:getDesc()
end

function updateEleTypeState(self, hasNum)
    if hasNum > 0 then
        for i = 1, #self.items do
            if i <= hasNum then
                self.items[i]:getChildGO("mImgElementIcon"):GetComponent(ty.AutoRefImage):SetGray(false)
            end
        end
    end
end


function deActive(self)
    super.deActive(self)
    for i = 1, #self.items do
        self.items[i]:poolRecover()
    end
    self.items = {}
end

function onDelete(self)
    super.onDelete(self)


end

return _M